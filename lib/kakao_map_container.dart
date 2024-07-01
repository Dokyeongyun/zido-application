import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';
import 'package:zido/place.dart';

class KakaoMapContainer extends StatelessWidget {
  const KakaoMapContainer({
    super.key,
    this.height = 280,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    late Marker? tappedLocationMarker;
    late KakaoMapController mapController;

    Future<Coord2Address> coord2Address(LatLng latLng) async {
      Coord2AddressRequest request = Coord2AddressRequest(
        x: latLng.latitude,
        y: latLng.longitude,
      );

      return mapController
          .coord2Address(request)
          .then((value) => value.list.first)
          .timeout(const Duration(seconds: 1));
    }

    Future<KeywordSearchResponse> keywordSearch(
      String keyword,
      LatLng latLng,
      int radius,
    ) async {
      KeywordSearchRequest request = KeywordSearchRequest(
        keyword: keyword,
        x: latLng.longitude,
        y: latLng.latitude,
        radius: radius,
        page: 1,
        size: 5,
        sort: SortBy.distance,
      );
      return mapController.keywordSearch(request);
    }

    void showSearchFailedToast() {
      Fluttertoast.showToast(msg: "주소 검색에 실패했습니다. 잠시 후 다시 시도해주세요.");
    }

    Future<void> searchLocation(LatLng latLng) async {
      try {
        Coord2Address searchedAddress = await coord2Address(latLng);
        RoadAddress? roadAddress = searchedAddress.roadAddress;
        Address? address = searchedAddress.address;

        String? keywordSearchAddress =
            roadAddress?.addressName ?? address?.addressName;
        if (keywordSearchAddress != null) {
          KeywordSearchResponse response = await keywordSearch(
            keywordSearchAddress,
            latLng,
            10,
          );

          List<KeywordAddress> keywordAddresses = response.list;
          List<Place> places = keywordAddresses.where((element) {
            String? categoryGroupName = element.categoryGroupName;
            if (categoryGroupName != null &&
                categoryGroupName.contains('음식점')) {
              return true;
            } else {
              return false;
            }
          }).map(
            (e) {
              return Place(
                  category: e.categoryGroupName ?? '',
                  name: e.placeName ?? '',
                  phone: e.phone ?? '',
                  address: e.roadAddressName ?? e.addressName ?? '',
                  url: e.placeUrl ?? '');
            },
          ).toList();

          Provider.of<PlaceProvider>(
            context,
            listen: false,
          ).setPlaces(places);

          if (places.isNotEmpty) {
            KeywordAddress keywordAddress = keywordAddresses.first;
            double latitude = keywordAddress.y != null
                ? double.parse(keywordAddress.y!)
                : 0.0;

            double longitude = keywordAddress.x != null
                ? double.parse(keywordAddress.x!)
                : 0.0;

            if (latitude != 0.0 && longitude != 0.0) {
              tappedLocationMarker = Marker(
                markerId: 'tappedLocationMarker',
                latLng: LatLng(latitude, longitude),
                width: 10,
                height: 10,
              );
            }
          }
        } else {
          showSearchFailedToast();
        }
      } catch (error) {
        showSearchFailedToast();
      }
    }

    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 1.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 0),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: KakaoMap(
          onMapCreated: ((controller) async {
            mapController = controller;
          }),
          onMapTap: ((latLng) async {
            tappedLocationMarker = null;
            mapController.addMarker(markers: []);
            await searchLocation(latLng);
            if (tappedLocationMarker != null) {
              mapController.addMarker(markers: [tappedLocationMarker!]);
            }
          }),
          center: LatLng(37.48256861253413, 127.04079608010362),
        ),
      ),
    );
  }
}

class PlaceProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => _places;

  Future<void> setPlaces(List<Place> places) async {
    _places = places;
    notifyListeners();
  }
}

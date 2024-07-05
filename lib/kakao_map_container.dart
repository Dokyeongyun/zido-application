import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';
import 'package:zido/place.dart';

class KakaoMapContainer extends StatefulWidget {
  const KakaoMapContainer({
    super.key,
    this.height = 280,
  });

  final double height;

  @override
  State<KakaoMapContainer> createState() => _KakaoMapContainerState();
}

class _KakaoMapContainerState extends State<KakaoMapContainer> {
  LocationPermission? geoPermission;
  Marker? tappedLocationMarker;
  LatLng? currentLatLng;
  late KakaoMapController mapController;

  requestGeoPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      setState(() {
        geoPermission = permission;
      });

      if (geoPermission != LocationPermission.denied) {
        await setCurrentLatLng();
      }
    } else {
      setState(() {
        geoPermission = permission;
      });
    }
  }

  setCurrentLatLng() async {
    if (geoPermission == null) {
      requestGeoPermission();
    }
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLatLng = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    requestGeoPermission();
  }

  @override
  Widget build(BuildContext context) {
    if (geoPermission == null ||
        geoPermission == LocationPermission.denied ||
        geoPermission == LocationPermission.deniedForever) {
      return Wrapper(
        widget: widget,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                requestGeoPermission();
              },
              child: const Text('위치정보 접근 권한을 허용해주세요.'),
            )
          ],
        ),
      );
    }

    if (currentLatLng == null) {
      setCurrentLatLng();
      return Wrapper(
        widget: widget,
        child: const CircularProgressIndicator(),
      );
    }

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

    return Wrapper(
      widget: widget,
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
        center: currentLatLng,
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({
    super.key,
    required this.widget,
    required this.child,
  });

  final KakaoMapContainer widget;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
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
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class PlaceProvider with ChangeNotifier {
  List<Place> _places = [];
  bool _isInitialized = false;

  List<Place> get places => _places;

  Future<void> setPlaces(List<Place> places) async {
    _places = places;
    _isInitialized = true;
    notifyListeners();
  }

  bool isInitialized() {
    return _isInitialized;
  }

  bool isPlaceEmpty() {
    return _isInitialized && _places.isEmpty;
  }

  bool isPlaceNotEmpty() {
    return _isInitialized && _places.isNotEmpty;
  }
}

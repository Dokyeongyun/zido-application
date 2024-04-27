import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class KakaoMapContainer extends StatelessWidget {
  const KakaoMapContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Container(
        height: 280,
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
            onMapCreated: ((controller) async {}),
            center: LatLng(37.3608681, 126.9306506),
          ),
        ),
      ),
    );
  }
}

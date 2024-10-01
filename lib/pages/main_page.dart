import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

import '../global/global.dart';

///MainPage
///담당자 : ---

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    super.initState();
    initMarkers();
  }

  late KakaoMapController mapController;

  Set<Marker> markers = {};
  Set<CustomOverlay> customOverlays = {};

  void initMarkers(){
    markers.add(Marker(
        markerId: '${markers.length + 1}',
        latLng: LatLng(37.5267767278681, 126.99958141888409)));
    setState(() { });
  }

  void addMarkers(LatLng latlng){

    Marker newMarker = Marker(
      markerId: '${markers.length + 1}',
      latLng: latlng,
      width: 50,
      height: 50,
      offsetY: 25,
      offsetX: 11,
      markerImageSrc: 'https://cdn-icons-png.flaticon.com/512/6157/6157513.png'
    );
    markers.add(newMarker);

    CustomOverlay newCustomOverlay = CustomOverlay(
      customOverlayId: '${customOverlays.length + 1}',
      latLng: latlng,
      yAnchor: 1.9,
      // content: '<p style="background-color: black; color:white; padding: 8px; border-radius: 8px;">장사가능</p>'
      content: '<div style="position: relative; background-color: black; color: white; padding: 8px; border-radius: 8px; text-align: center;">장사가능 <div style="content: ''; position: absolute; bottom: -15px; left: 50%; margin-left: -10px; border-width: 10px; border-style: solid; border-color: black transparent transparent transparent;"></div></div>'
    );

    CustomOverlay newCustomOverlay2 = CustomOverlay(
        customOverlayId: '${customOverlays.length + 1}ojj',
        latLng: latlng,
        yAnchor: 2.9,
        xAnchor: -1,
        // content: '<p style="background-color: black; color:white; padding: 8px; border-radius: 8px;">장사가능</p>'
        content: '<div style="position: relative; background-color: black; color: white; padding: 8px; border-radius: 8px; text-align: center;">날시 <div style="content: ''; position: absolute; bottom: -15px; left: 50%; margin-left: -10px; border-width: 10px; border-style: solid; border-color: black transparent transparent transparent;"></div></div>'
    );
    customOverlays.add(newCustomOverlay);
    customOverlays.add(newCustomOverlay2);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KakaoMap(
        onMapCreated: ((controller) async {
          mapController = controller;
          setState(() { });
        }),
        onMapTap: (value){

          LatLng newPoint = LatLng(value.latitude, value.longitude);
          logger.e(newPoint.toJson());
          addMarkers(newPoint);
        },
        onMarkerTap: (a,b,c){
          logger.e(a);
          logger.e(b);
          logger.e(c);
        },

        center: LatLng(37.526542467487104, 126.99962667206407),
        markers: markers.toList(),

        customOverlays: customOverlays.toList(),
      ),
    );
  }
}



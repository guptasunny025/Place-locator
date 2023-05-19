import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:syncfusion_flutter_maps/maps.dart';

class HoemScreen extends StatefulWidget {
  const HoemScreen({Key? key}) : super(key: key);

  @override
  State<HoemScreen> createState() => _HoemScreenState();
}

class _HoemScreenState extends State<HoemScreen> {
  String Address = 'Fetching...';
  late Position position;
  late MapZoomPanBehavior _zoomPanBehavior;

  var isloading = true;
  var buttonloading = false;
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      setState(() {
        isloading = false;
      });
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        setState(() {
          isloading = false;
        });
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      setState(() {
        isloading = false;
      });
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
  }

  getlocation() async {
    setState(() {
      isloading = true;
      Address = 'fetching...';
    });
    position = await _getGeoLocationPosition();
    await GetAddressFromLatLong(position);
  }

  Future<void> GetAddressFromLatLong(position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    // var location = await currentLocation.getLocation();
    _zoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: MapLatLng(position.latitude, position.longitude),
      zoomLevel: 4,
    );
    setState(() {
      Address = '${place.locality}, ${place.postalCode}, ${place.country}';
      isloading = false;
      buttonloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocation();
    // GetAddressFromLatLong(position);
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Container(
                width: double.infinity,
                height: devicesize.height / 4 / 3,
                padding: EdgeInsets.only(left: devicesize.width / 4 / 4 / 2),
                alignment: Alignment.centerLeft,
                child: Row(children: [
                  Expanded(
                      child: Row(children: [
                    Image.asset(
                      'assets/locate.png',
                      width: devicesize.width / 4 / 4 / 2,
                      height: devicesize.height / 4 / 4 / 3,
                    ),
                    SizedBox(
                      width: devicesize.width / 4 / 4 / 2,
                    ),
                    Expanded(
                        child: Text(
                      '${Address}',
                      overflow: TextOverflow.ellipsis,
                    ))
                  ])),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/locate.png',
                        width: devicesize.width / 4 / 4 * .9,
                        height: devicesize.height / 4 / 4 / 3,
                      ),
                      SizedBox(
                        width: devicesize.width / 4 / 4 / 3,
                      ),
                      Transform.scale(
                          scale: 1.3,
                          child: Image.asset(
                            'assets/msg.png',
                            width: devicesize.width / 4 / 3,
                            height: devicesize.height / 4 / 4 / 2,
                          )),
                      SizedBox(
                        width: devicesize.width / 4 / 4 / 3,
                      ),
                      CircleAvatar(
                          radius: devicesize.width / 4 / 4 * .7,
                          backgroundImage: AssetImage(
                            'assets/profile.png',
                          )),
                      SizedBox(
                        width: devicesize.width / 4 / 4 / 3,
                      ),
                    ],
                  ))
                ]),
              ),
              SizedBox(
                height: devicesize.height / 4 / 4 / 3,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: devicesize.width / 4 / 4,
                    right: devicesize.width / 4 / 4),
                width: double.infinity,
                height: devicesize.height / 4 * .6,
                color: Color(0xFFE4F1F1),
              ),
              SizedBox(
                height: devicesize.height / 4 / 4 / 3,
              ),
              Divider(),
              // SizedBox(height: devicesize.height/4/2,),
              Container(
                height: devicesize.height / 4 / 2,
                // color: Colors.amber,
                width: devicesize.width,
                padding: EdgeInsets.only(
                    left: devicesize.width / 4 / 4 * .9,
                    right: devicesize.width / 4 / 4 * .9),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Container(
                          width: devicesize.width / 4 / 2,
                          height: devicesize.height / 4 / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/profile.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: devicesize.width / 4 / 4 / 2,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alina Johnsan',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Sr ux designer',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600),
                            ),
                            Text(
                              '10th args',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600),
                            ),
                          ],
                        )
                      ],
                    )),
                    SizedBox(
                      width: devicesize.width / 4 / 4 / 2,
                    ),
                    Image.asset(
                      'assets/menu.png',
                      width: devicesize.width / 4 / 3,
                      height: devicesize.height / 4 / 4 / 2,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      width: double.infinity,
                      child: isloading == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : SfMaps(
                              layers: [
                                MapTileLayer(
                                  zoomPanBehavior: _zoomPanBehavior,
                                  initialFocalLatLng: MapLatLng(
                                      position.latitude, position.longitude),
                                  initialZoomLevel: 10,
                                  initialMarkersCount: 1,
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  markerBuilder:
                                      (BuildContext context, int index) {
                                    return MapMarker(
                                      latitude: position.latitude,
                                      longitude: position.longitude,
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.yellow.shade900,
                                      ),
                                      size: Size(20, 20),
                                    );
                                  },
                                ),
                              ],
                            ))),
              SizedBox(
                height: devicesize.height / 4,
              )
            ],
          )),
          // isloading == true
          //     ? Container()
          //     : buttonloading == true
          //         ? ElevatedButton(
          //             onPressed: () async {
          //               // await getlocation();
          //             },
          //             child: Center(
          //                 child: CircularProgressIndicator(
          //               color: Colors.white,
          //             )))
          //         : ElevatedButton(
          //             onPressed: () async {
          //               setState(() {
          //                 buttonloading = true;
          //               });
          //               await getlocation();
          //             },
          //             child: Text('Get Location'))
        ],
      )),
    );
  }
}

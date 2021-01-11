import 'package:delivery/provider/locationProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class LocationShop extends StatefulWidget {
  @override
  _LocationShopState createState() => _LocationShopState();
}

class _LocationShopState extends State<LocationShop> {
  LatLng _initialPosition = LatLng(45.521563, -122.677433);
  GoogleMapController _controller;
  Location _location = Location();
  LocationData _locationData;
  BitmapDescriptor icon;

  Future<Null> _getCurrentLocation() async {
    _locationData = await _location.getLocation();
    context
        .read<LocationProvider>()
        .addCurrentLocation(_locationData.latitude, _locationData.longitude);

    print("show loaction");
    print(_locationData.longitude);

    print(_locationData.latitude);
    setState(() {
      _initialPosition =
          LatLng(_locationData.latitude, _locationData.longitude);
    });
    locationUpdate(_locationData);
  }

  void _onMapCreate(GoogleMapController _cntrl) {
    _controller = _cntrl;
    _getCurrentLocation();
    _location.onLocationChanged.listen((_location) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(_location.latitude, _location.longitude),
              zoom: 15),
        ),
      );
    });
  }

  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.0),
        "assests/imgs/userfrofile.png");
    setState(() {
      this.icon = icon;
    });
  }

  Set<Marker> _createMarker() {
    var marker = Set<Marker>();
    marker.add(
      Marker(
          markerId: MarkerId("MarkerCurrent"),
          position: _initialPosition,
          icon: icon,
          infoWindow: InfoWindow(
            title: "My location",
            snippet: "$_initialPosition",
          ),
          draggable: true,
          onDragEnd: null),
    );
    return marker;
  }

  locationUpdate(currentLocation) {
    if (currentLocation != null)
      setState(() {
        _locationData = currentLocation;
        _initialPosition =
            LatLng(currentLocation.latidude, currentLocation.longitude);
        _createMarker();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: _initialPosition, zoom: 16),
          mapType: MapType.normal,
          onMapCreated: _onMapCreate,
          markers: _createMarker(),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
      ],
    );
  }
}

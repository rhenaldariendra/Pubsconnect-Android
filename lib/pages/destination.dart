// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:thesis_pubsconnect/api/destination_api.dart';
import 'package:thesis_pubsconnect/component/loading.dart';
import 'package:thesis_pubsconnect/component/location_list.dart';
import 'package:thesis_pubsconnect/pages/journey.dart';
import 'package:thesis_pubsconnect/model/autocomplete_prediction.dart';

class Destination extends StatefulWidget {
  const Destination({super.key});

  @override
  State<Destination> createState() => _DestinationState();
}

class _DestinationState extends State<Destination> {
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  List<AutocompletePrediction> predList = [];
  bool _isLoading = false;
  bool _current = true;
  bool _isSearched = false;
  String _startId = '';
  String _endId = '';

  Map<String, bool> currenLocationUsed = {
    'start': false,
    'end': false,
  };

  void _onChangedVall(value) async {
    predList = [];
    AutoCompleteResponse data = await DestinationAPI.getSearchAutocomplete(value);
    setState(() {
      predList = data.predictions!;
      _current ? currenLocationUsed['start'] = false : currenLocationUsed['end'] = false;
    });
  }

  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> snapshot;
    dynamic startLat, startLon, endLat, endLon;
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (_startController.text != '' && _endController.text != '') {
      if (currenLocationUsed['start'] == true) {
        startLat = position.latitude;
        startLon = position.longitude;
      } else {
        startLat = _startId;
        startLon = 0;
      }

      if (currenLocationUsed['end'] == true) {
        endLat = position.latitude;
        endLon = position.longitude;
      } else {
        endLat = _endId;
        endLon = 0;
      }

      snapshot = await DestinationAPI.getTransportSuggestion(startLat, startLon, endLat, endLon);
    } else {
      snapshot = {};
    }
    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Journey(
          dataTransport: snapshot,
          endName: _endController.text,
          startName: _startController.text,
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isSearched) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 30.w, 20.w, 16.w),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => setState(() {
                    _isSearched = !_isSearched;
                  }),
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                SizedBox(
                  width: 8.w,
                ),
                _current
                    ? const Text('Set Your Starting Point')
                    : Text(
                        'Set Your Destination Point',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: Colors.black,
                        ),
                      ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: _current
                ? TextField(
                    textInputAction: TextInputAction.go,
                    onChanged: (value) {
                      _onChangedVall(value);
                    },
                    controller: _startController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Your Location',
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                      fillColor: const Color.fromRGBO(248, 248, 248, 1),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(14.w, 8.w, 10.w, 8.w),
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                : TextField(
                    textInputAction: TextInputAction.go,
                    onChanged: (value) {
                      _onChangedVall(value);
                    },
                    controller: _endController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Your Destination',
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                      fillColor: const Color.fromRGBO(248, 248, 248, 1),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(14.w, 8.w, 10.w, 8.w),
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
            child: ElevatedButton(
              onPressed: () {
                _current ? currenLocationUsed['start'] = true : currenLocationUsed['end'] = true;
                setState(() {
                  _current ? _startController.text = 'Current Location' : _endController.text = 'Current Location';
                  _isSearched = !_isSearched;
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.fromLTRB(0, 10.w, 0, 10.w),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.w)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on_outlined),
                  SizedBox(
                    width: 8.w,
                  ),
                  const Text('Use Your Current Location'),
                ],
              ),
            ),
          ),
          const Divider(
            height: 2,
            thickness: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: predList.length,
              itemBuilder: (context, index) => LocationListTile(
                press: () {
                  _current ? _startId = predList[index].placeId! : _endId = predList[index].placeId!;
                  setState(() {
                    _isSearched = !_isSearched;
                    if (_current == true) {
                      _startController.text = (predList[index].structuredFormatting?.mainText == '' ? '' : predList[index].structuredFormatting?.mainText)!;
                    } else {
                      _endController.text = (predList[index].structuredFormatting?.mainText == '' ? '' : predList[index].structuredFormatting?.mainText)!;
                    }
                    predList = [];
                  });
                },
                location: predList[index].description!,
              ),
            ),
          ),
        ],
      );
    } else {
      if (_isLoading) {
        return const Loading(height: double.infinity);
      } else {
        return Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/maps.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 30.w,
              left: 10.w,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            Positioned(
              bottom: 0.w,
              left: 0,
              right: 0,
              height: 225.w,
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(18.w), topRight: Radius.circular(18.w))),
                    padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 28.w, bottom: 30.w),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 75.w,
                              child: Image.asset('assets/images/dot.png'),
                            ),
                            SizedBox(
                              width: 18.w,
                            ),
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 260.w,
                                  child: ElevatedButton(
                                    onPressed: () => setState(() {
                                      _isSearched = !_isSearched;
                                      _current = true;
                                    }),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.w)),
                                      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
                                      foregroundColor: Colors.black,
                                      padding: EdgeInsets.fromLTRB(16.w, 0, 0, 0),
                                      elevation: 0,
                                      textStyle: Theme.of(context).textTheme.labelMedium,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(_startController.text == '' ? 'Your Location' : _startController.text),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 14.w,
                                ),
                                SizedBox(
                                  width: 260.w,
                                  child: ElevatedButton(
                                    onPressed: () => setState(() {
                                      _isSearched = !_isSearched;
                                      _current = false;
                                    }),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.w)),
                                      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
                                      foregroundColor: Colors.black,
                                      padding: EdgeInsets.fromLTRB(16.w, 0, 0, 0),
                                      elevation: 0,
                                      textStyle: Theme.of(context).textTheme.labelMedium,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(_endController.text == '' ? 'Your Destination' : _endController.text),
                                    ),
                                  ),
                                ),

                                // SizedBox(
                                //   width: 260.w,
                                //   child: end,
                                // ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.w,
                        ),
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.w)),
                          ),
                          child: const Text('Find Now'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),
    );
  }
}

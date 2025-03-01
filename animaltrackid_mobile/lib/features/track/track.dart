import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../reusables/custom_appbar.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/icons.dart';
import '../reusables/custom_button.dart';
import '../reusables/text_group.dart';
import '../reusables/appnav.dart';
import '../reusables/bottomsheet.dart';
import '../reusables/loadingscreen.dart';
import 'results.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  XFile? _selectedImage;
  Position? _currentPosition;
  bool _isLoading = false;

  void _pickImage() {
    PhotoPickerBottomSheet.show(context, (XFile? image) {
      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      }
    });
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location services are disabled.")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permissions are denied.")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Location permissions are permanently denied.")),
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to get location: $e")),
      );
    }
  }

  Future<void> _classifyFootprint() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an image first.")),
      );
      return;
    }

    await _getCurrentLocation();
    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to get location.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      var uri = Uri.parse("http://0.0.0.0:8000/predict");

      print(
          "Sending: Latitude=${_currentPosition!.latitude}, Longitude=${_currentPosition!.longitude}");
      print("Sending Image: ${_selectedImage!.path}");

      var request = http.MultipartRequest('POST', uri)
        ..fields['latitude'] = _currentPosition!.latitude.toString()
        ..fields['longitude'] = _currentPosition!.longitude.toString()
        ..files.add(
            await http.MultipartFile.fromPath('file', _selectedImage!.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var data = jsonDecode(responseBody);
        print("API Response: $data");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ClassificationResultScreen(
              imagePath: _selectedImage!.path,
              classificationData: data,
            ),
          ),
        );
      } else {
        print(
            "Error ${response.statusCode}: ${await response.stream.bytesToString()}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print("Network Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to connect to server: $e")),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: InfoAppBar(
            onInfoPressed: () {},
          ),
          body: Container(
            margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextGroupLeft(
                  headerText: 'Footprints found?',
                  supportingText:
                      'Take a photo of the footprint or upload a photo to get a classification report. Click on the icon at the top right to learn more',
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: AppColors.strokeColor, width: 1),
                      ),
                      child: _selectedImage == null
                          ? _buildUploadUI()
                          : _buildImagePreview(),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  buttonColor: AppColors.primaryColor,
                  outlineColor: null,
                  text: 'Classify Footprint',
                  textColor: AppColors.whiteColor,
                  textSize: FontConstants.body,
                  textWeight: FontConstants.mediumWeight,
                  onPressed: _classifyFootprint,
                ),
              ],
            ),
          ),
          bottomNavigationBar: AppNavBar(
            currentRoute: ModalRoute.of(context)?.settings.name ?? '/track',
            onTabSelected: (route) {
              if (route != ModalRoute.of(context)?.settings.name) {
                Navigator.pushReplacementNamed(context, route);
              }
            },
          ),
        ),

        // Fullscreen Loading Overlay
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: AppColors.loadingOverlay, // Semi-transparent background
              child: const Center(
                child: LoadingScreen(
                    size: 60.0), // Use your reusable loading animation
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildUploadUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppIcons.upload,
          width: 40,
          height: 40,
          colorFilter: const ColorFilter.mode(
            AppColors.secondaryColor,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Upload photo",
          style: const TextStyle(
            fontFamily: FontConstants.fontFamily,
            fontSize: FontConstants.small,
            fontWeight: FontConstants.regular,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(_selectedImage!.path),
            width: 240,
            height: 240,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: _clearImage,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppIcons.close,
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                      AppColors.textColor, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

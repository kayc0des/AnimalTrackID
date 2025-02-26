import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../reusables/custom_appbar.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/icons.dart';
import '../reusables/custom_button.dart';
import '../reusables/text_group.dart';
import '../reusables/appnav.dart';
import '../reusables/bottomsheet.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  XFile? _selectedImage; // Stores selected/taken photo
  Position? _currentPosition; // Stores the user's current location

  // Opens bottom sheet & handles image selection
  void _pickImage() {
    PhotoPickerBottomSheet.show(context, (XFile? image) {
      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      }
    });
  }

  // Clears the selected image
  void _clearImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  // Fetches the user's current location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location services are disabled.")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location permissions are denied.")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permissions are permanently denied.")),
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

  // Sends the image and location to the FastAPI backend
  Future<void> _classifyFootprint() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an image first.")),
      );
      return;
    }

    await _getCurrentLocation(); // Fetch location before sending the request

    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to get location.")),
      );
      return;
    }

    // Send the image and location to the backend
    print("Selected Image Path: ${_selectedImage!.path}");
    print("Latitude: ${_currentPosition!.latitude}");
    print("Longitude: ${_currentPosition!.longitude}");

    // TODO: Call your FastAPI backend here
    // Use the _selectedImage and _currentPosition to send the request
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InfoAppBar(
        onInfoPressed: () {},
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading and description
            TextGroupLeft(
              headerText: 'Footprints found?',
              supportingText:
                  'Take a photo of the footprint or upload a photo to get a classification report. Click on the icon at the top right to learn more',
            ),
            const SizedBox(height: 24),

            // Upload Photo Container
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.strokeColor, width: 1),
                  ),
                  child: _selectedImage == null
                      ? _buildUploadUI() // Show upload UI
                      : _buildImagePreview(), // Show image preview
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Classify Button
            CustomButton(
              buttonColor: AppColors.primaryColor,
              outlineColor: null,
              text: 'Classify Footprint',
              textColor: AppColors.whiteColor,
              textSize: FontConstants.body,
              textWeight: FontConstants.mediumWeight,
              onPressed:
                  _classifyFootprint, // Updated to use _classifyFootprint
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
    );
  }

  // Upload UI (Shown when no image is selected)
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

  // Image Preview UI (Shown when an image is selected)
  Widget _buildImagePreview() {
    return Stack(
      children: [
        // Selected Image (Fills Container)
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(_selectedImage!.path),
            width: 240,
            height: 240,
            fit: BoxFit.cover, // Makes image fill the container
          ),
        ),

        // Close Icon (Top Right)
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
                color: Colors.white, // Background for better visibility
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

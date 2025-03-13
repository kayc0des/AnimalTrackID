import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../reusables/custom_button.dart';
import '../reusables/custom_input.dart';
import '../reusables/custom_appbar.dart';
import '../reusables/text_group.dart';
import '../reusables/bottomsheet.dart';
import '../reusables/loadingscreen.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/text.dart';
import '../../utils/constants/icons.dart';
import '../../utils/helpers/getid.dart';
import 'success.dart';

class SubmitFormScreen extends StatefulWidget {
  const SubmitFormScreen({super.key});

  @override
  _SubmitFormScreenState createState() => _SubmitFormScreenState();
}

class _SubmitFormScreenState extends State<SubmitFormScreen> {
  final TextEditingController _animalNameController = TextEditingController();
  XFile? _selectedImage;
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

  Future<void> _submitData() async {
    if (_selectedImage == null || _animalNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please enter a name and select an image.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      String? userId = await getUserId();
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not logged in.")),
        );
        setState(() => _isLoading = false);
        return;
      }

      // Construct the URL with query parameters
      var uri =
          Uri.parse("http://0.0.0.0:8000/upload/").replace(queryParameters: {
        'userID': userId,
        'name': _animalNameController.text.trim(),
      });

      var request = http.MultipartRequest('POST', uri)
        ..files.add(
            await http.MultipartFile.fromPath('file', _selectedImage!.path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var data = jsonDecode(responseBody);
        print("Upload Successful: $data");

        // Show the SuccessScreen for 4 seconds
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SuccessScreen()),
        );

        // Wait for 4 seconds and then navigate back
        await Future.delayed(const Duration(seconds: 4));

        // Navigate back to the previous screen
        Navigator.pushReplacementNamed(context, '/submit');
      } else {
        print("Error ${response.statusCode}: $responseBody");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Upload failed: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print("Network Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload: $e")),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: ReturnAppBar(
            onBackPressed: () {
              Navigator.pushReplacementNamed(context, '/submit');
            },
          ),
          body: Container(
            margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextGroupLeft(
                  headerText: 'Hooray! More Data 🎊',
                  supportingText: AppTexts.authTextTwo,
                ),
                const SizedBox(height: 24),

                // Animal Name Input
                CustomInputField(
                  controller: _animalNameController,
                  labelText: 'Animal Name',
                  labelFontSize: FontConstants.body,
                  labelFontWeight: FontConstants.mediumWeight,
                  placeholderText: 'Enter Animal Name',
                  placeholderFontSize: FontConstants.body,
                  placeholderFontWeight: FontConstants.regular,
                ),
                const SizedBox(height: 16),

                // Upload Photo Label
                const Text(
                  "Upload a photo",
                  style: TextStyle(
                    fontFamily: FontConstants.fontFamily,
                    fontSize: FontConstants.body,
                    fontWeight: FontConstants.mediumWeight,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 8),

                // Upload Footprint Field
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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

                const SizedBox(height: 24),

                // Submit Button
                CustomButton(
                  buttonColor: AppColors.primaryColor,
                  outlineColor: null,
                  text: 'Submit',
                  textColor: AppColors.whiteColor,
                  textSize: FontConstants.body,
                  textWeight: FontConstants.mediumWeight,
                  onPressed: _submitData,
                ),
              ],
            ),
          ),
        ),

        // Fullscreen Loading Screen
        if (_isLoading) const LoadingScreen(),
      ],
    );
  }

  // 📌 Upload UI (when no image is selected)
  Widget _buildUploadUI() {
    return Center(
      child: Column(
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
          const SizedBox(height: 4),
          Text(
            "Tap to upload",
            style: const TextStyle(
              fontSize: FontConstants.small,
              fontWeight: FontConstants.regular,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }

  // 📌 Image Preview UI (when an image is selected)
  Widget _buildImagePreview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(_selectedImage!.path),
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _shortenFileName(_selectedImage!.name),
              style: const TextStyle(
                fontSize: FontConstants.body,
                fontWeight: FontConstants.regular,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: _clearImage,
          child: SvgPicture.asset(
            AppIcons.close,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.textColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }

  // 📌 Shortens file name for UI
  String _shortenFileName(String fileName) {
    return fileName.length > 10 ? "${fileName.substring(0, 10)}..." : fileName;
  }
}

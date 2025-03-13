// lib/features/results.dart
import 'dart:io';
import 'package:flutter/material.dart';
import '../reusables/custom_appbar.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/colors.dart';
import '../reusables/custom_button.dart';
import '../reusables/text_group.dart';

class ClassificationResultScreen extends StatelessWidget {
  final String imagePath;
  final Map<String, dynamic> classificationData;

  const ClassificationResultScreen({
    super.key,
    required this.imagePath,
    required this.classificationData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ReturnAppBar(
        onBackPressed: () {
          Navigator.pushReplacementNamed(context, '/track');
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(
              24, 8, 24, 80), // Add bottom margin for the navbar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              TextGroupLeft(
                headerText: 'Classification Report',
                supportingText:
                    'Your track has been recorded, find below a classification report.',
              ),
              const SizedBox(height: 12),

              // Image Container
              Center(
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.strokeColor, width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(imagePath),
                      width: 240,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Tracked Animal ID Label
              Text(
                "Tracked Animal ID",
                style: const TextStyle(
                  fontFamily: FontConstants.fontFamily,
                  fontSize: FontConstants.medium,
                  fontWeight: FontConstants.mediumWeight,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 8),

              // Classification Data Section
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _buildReportRow(
                        "Specie Found", classificationData["species_name"]),
                    _buildDivider(),
                    _buildReportRow(
                        "Latitude", classificationData["latitude"].toString()),
                    _buildDivider(),
                    _buildReportRow("Longitude",
                        classificationData["longitude"].toString()),
                    _buildDivider(),
                    _buildReportRow(
                        "Date & Time", classificationData["datetime"]),
                    _buildDivider(),
                    _buildReportRow("Temperature",
                        "${classificationData["temperature"]}°C"),
                    _buildDivider(),
                    _buildReportRow(
                        "Humidity", "${classificationData["humidity"]}%"),
                    _buildDivider(),
                    _buildReportRow(
                        "Pressure", "${classificationData["pressure"]} hPa"),
                    _buildDivider(),
                    _buildReportRow(
                        "Wind Speed", "${classificationData["windspeed"]} m/s"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Add the "Learn More" button as a bottom navigation bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(
            24, 16, 24, 32), // Added more bottom padding
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.cardColor.withValues(),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: CustomButton(
          buttonColor: AppColors.primaryColor,
          outlineColor: null,
          text: 'Learn More',
          textColor: AppColors.whiteColor,
          textSize: FontConstants.body,
          textWeight: FontConstants.mediumWeight,
          onPressed: () {
            // Add your button action here
          },
        ),
      ),
    );
  }

  // 📌 Builds Report Rows (Left: Label, Right: Value)
  Widget _buildReportRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.body,
              fontWeight: FontConstants.regular,
              color: AppColors.textColor,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.body,
              fontWeight: FontConstants.regular,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }

  // 📌 Divider Line
  Widget _buildDivider() {
    return Container(
      height: 1,
      color: AppColors.strokeColor,
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}

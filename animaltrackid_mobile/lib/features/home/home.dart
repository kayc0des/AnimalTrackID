import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../reusables/custom_appbar.dart';
import '../reusables/text_group.dart';
import '../reusables/appnav.dart';
import '../reusables/loadingscreen.dart';
import '../../utils/constants/images.dart';
import '../../utils/constants/icons.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/helpers/getid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _tracks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTrackHistory();
  }

  Future<void> _fetchTrackHistory() async {
    try {
      String? userId = await getUserId();
      if (userId == null) {
        setState(() => _isLoading = false);
        return;
      }

      var response =
          await http.get(Uri.parse('http://0.0.0.0:8000/tracks/$userId'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          _tracks = List<Map<String, dynamic>>.from(data['tracks']);
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      print("Error fetching track history: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        onBackPressed: () {
          Navigator.pushReplacementNamed(context, '/track');
        },
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBoxLeft(headerText: 'Explore'),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                AppImages.homeCard,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            TextBoxLeft(headerText: 'Track History'),
            const SizedBox(height: 12),
            _isLoading
                ? const LoadingScreen()
                : _tracks.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "No tracks found.",
                            style: TextStyle(
                              fontSize: FontConstants.body,
                              fontWeight: FontConstants.regular,
                              color: AppColors.textColor,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        constraints: const BoxConstraints(
                          maxHeight: 320, // Limits card height (~7 items)
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              _tracks.length > 7 ? 7 : _tracks.length,
                              (index) {
                                var track = _tracks[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Left side: Badge icon + Species name
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppIcons.badge,
                                                width: 32,
                                                height: 32,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                track['species'],
                                                style: const TextStyle(
                                                  fontSize: FontConstants.body,
                                                  fontWeight:
                                                      FontConstants.regular,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Right side: Latitude | Longitude
                                          Text(
                                            "${track['latitude']} | ${track['longitude']}",
                                            style: const TextStyle(
                                              fontSize: FontConstants.body,
                                              fontWeight: FontConstants.regular,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (index != _tracks.length - 1)
                                      _buildDivider(),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
      bottomNavigationBar: AppNavBar(
        currentRoute: ModalRoute.of(context)?.settings.name ?? '/home',
        onTabSelected: (route) {
          if (route != ModalRoute.of(context)?.settings.name) {
            Navigator.pushReplacementNamed(context, route);
          }
        },
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

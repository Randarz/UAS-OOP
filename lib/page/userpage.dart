import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_profile_page.dart'; // Import the EditProfilePage
import 'rating_page.dart'; // Import the RatingPage

class UserPage extends StatefulWidget {
  final String username;
  final String profileImageUrl;
  final int completedOrders;
  final double rating;
  final String operationalHours;

  UserPage({
    required this.username,
    required this.profileImageUrl,
    required this.completedOrders,
    required this.rating,
    required this.operationalHours,
  });

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late String _username;
  late String _profileImageUrl;
  late String _operationalHours;

  @override
  void initState() {
    super.initState();
    _username = widget.username;
    _profileImageUrl = widget.profileImageUrl;
    _operationalHours = widget.operationalHours;
  }

  void _navigateToEditProfile(BuildContext context) async {
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          currentUsername: _username,
          currentProfileImageUrl: _profileImageUrl,
          currentOperationalHours: _operationalHours,
        ),
      ),
    );

    if (updatedProfile != null) {
      setState(() {
        _username = updatedProfile['username'];
        _profileImageUrl = updatedProfile['profileImageUrl'];
        _operationalHours = updatedProfile['operationalHours'];
      });
    }
  }

  void _navigateToRatingsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RatingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF242424),
      appBar: AppBar(
        backgroundColor: Color(0xFF242424),
        elevation: 0,
        title: Text(
          'User Page',
          style: GoogleFonts.rubik(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'Edit') {
                _navigateToEditProfile(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Edit'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 150, // Adjust the height as needed
                color: Color(0xFF242424),
              ),
              Container(
                height: 100, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: Color(0xFF242424),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50), // Adjust the height to move profile picture upwards
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(_profileImageUrl),
              ),
              SizedBox(height: 16),
              Text(
                _username,
                style: GoogleFonts.rubik(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '${widget.completedOrders}',
                        style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Completed Orders',
                        style: GoogleFonts.rubik(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _navigateToRatingsPage(context),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 18),
                            SizedBox(width: 4),
                            Text(
                              widget.rating.toString(),
                              style: GoogleFonts.rubik(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Rating',
                          style: GoogleFonts.rubik(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        _operationalHours,
                        style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Operational Hours',
                        style: GoogleFonts.rubik(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

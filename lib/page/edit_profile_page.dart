import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import dart:io for File class

class EditProfilePage extends StatefulWidget {
  final String currentUsername;
  final String currentProfileImageUrl;
  final String currentOperationalHours;

  EditProfilePage({
    required this.currentUsername,
    required this.currentProfileImageUrl,
    required this.currentOperationalHours,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _startHourController;
  late TextEditingController _endHourController;
  late String _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.currentUsername);
    _startHourController = TextEditingController();
    _endHourController = TextEditingController();
    _profileImageUrl = widget.currentProfileImageUrl;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _startHourController.dispose();
    _endHourController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    Navigator.pop(context, {
      'username': _usernameController.text,
      'profileImageUrl': _profileImageUrl,
      'operationalHours': '${_startHourController.text} - ${_endHourController.text}',
    });
  }

  Future<void> _chooseNewProfileImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImageUrl = image.path;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _startHourController.text = picked.format(context);
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _endHourController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF242424),
      appBar: AppBar(
        backgroundColor: Color(0xFF242424),
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.rubik(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _chooseNewProfileImage,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: FileImage(File(_profileImageUrl)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              style: GoogleFonts.rubik(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: GoogleFonts.rubik(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70, width: 1.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _startHourController,
                    readOnly: true,
                    onTap: () => _selectStartTime(context),
                    style: GoogleFonts.rubik(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Start Hour',
                      labelStyle: GoogleFonts.rubik(color: Colors.white70),
                      border: InputBorder.none, // Remove the underline
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, size: 20, color: Colors.white70),
                  onPressed: () => _selectStartTime(context),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _endHourController,
                    readOnly: true,
                    onTap: () => _selectEndTime(context),
                    style: GoogleFonts.rubik(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'End Hour',
                      labelStyle: GoogleFonts.rubik(color: Colors.white70),
                      border: InputBorder.none, // Remove the underline
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, size: 20, color: Colors.white70),
                  onPressed: () => _selectEndTime(context),
                ),
              ],
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

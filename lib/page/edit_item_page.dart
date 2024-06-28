import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditItemPage extends StatefulWidget {
  final String itemId;
  final String itemName;
  final String imageUrl;
  final double itemPrice;
  final int itemQuantity;
  final bool hasVariants;
  final List<Map<String, dynamic>> variants;

  EditItemPage({
    required this.itemId,
    required this.itemName,
    required this.imageUrl,
    required this.itemPrice,
    required this.itemQuantity,
    required this.hasVariants,
    required this.variants,
  });

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  bool _hasVariants = false;
  File? _imageFile;
  final picker = ImagePicker();
  List<Map<String, dynamic>> _variants = [];
  List<Map<String, dynamic>> _newVariants = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.itemName);
    _priceController = TextEditingController(text: widget.itemPrice.toString());
    _quantityController = TextEditingController(text: widget.itemQuantity.toString());
    _hasVariants = widget.hasVariants && widget.variants.isNotEmpty;
    _variants = List.from(widget.variants);
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<String?> _uploadImage(File imageFile) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://yourapiurl/upload-image'), // Replace with your image upload endpoint
    );
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      final data = jsonDecode(responseData.body);
      return data['imageUrl']; // Adjust this based on your API response
    } else {
      return null;
    }
  }

  Future<void> _saveItem() async {
    String? imageUrl = widget.imageUrl;
    if (_imageFile != null) {
      imageUrl = await _uploadImage(_imageFile!);
    }

    if (imageUrl == null) {
      throw Exception('Failed to upload image');
    }

    final url = Uri.parse('https://p6d0q4jz-8080.asse.devtunnels.ms/item/${widget.itemId}');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'itemName': _nameController.text,
        'imageUrl': imageUrl,
        'price': double.parse(_priceController.text),
        'totalQuantity': int.parse(_quantityController.text),
        'variant': _hasVariants ? _variants : null,
      }),
    );

    if (response.statusCode == 200) {
      if (_newVariants.isNotEmpty) {
        await _saveNewVariants();
      } else {
        Navigator.pop(context, true);
      }
    } else {
      throw Exception('Failed to update item');
    }
  }

  Future<void> _saveNewVariants() async {
    for (var variant in _newVariants) {
      final url = Uri.parse('https://p6d0q4jz-8080.asse.devtunnels.ms/item/${widget.itemId}/add-variant');
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'variantName': variant['variantName'],
          'quantity': variant['quantity'],
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add variant');
      }
    }
    Navigator.pop(context, true);
  }

  void _addVariantField() {
    setState(() {
      _newVariants.add({'variantName': '', 'quantity': 0});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242424),
      appBar: AppBar(
        backgroundColor: const Color(0xFF242424),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Item',
          style: GoogleFonts.rubik(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              style: GoogleFonts.rubik(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Item Name',
                labelStyle: GoogleFonts.rubik(color: Colors.white70),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.greenAccent,
                    child: _imageFile != null
                        ? Image.file(_imageFile!, fit: BoxFit.cover)
                        : const Center(
                            child: Icon(
                              Icons.upload,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                _imageFile != null
                    ? Image.file(_imageFile!, fit: BoxFit.cover)
                    : widget.imageUrl.isNotEmpty
                        ? Image.network(
                            widget.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey,
                            child: const Center(
                              child: Text(
                                'No Image',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              style: GoogleFonts.rubik(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Item Price',
                labelStyle: GoogleFonts.rubik(color: Colors.white70),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Any Variants?',
                  style: GoogleFonts.rubik(color: Colors.white),
                ),
                Switch(
                  value: _hasVariants,
                  onChanged: (value) {
                    setState(() {
                      _hasVariants = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_hasVariants)
              Column(
                children: _variants.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> variant = entry.value;
                  return Column(
                    children: [
                      TextField(
                        controller: TextEditingController(text: variant['variantName']),
                        onChanged: (value) {
                          variant['variantName'] = value;
                        },
                        style: GoogleFonts.rubik(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Variant ${index + 1} Name',
                          labelStyle: GoogleFonts.rubik(color: Colors.white70),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      TextField(
                        controller: TextEditingController(text: variant['quantity'].toString()),
                        onChanged: (value) {
                          variant['quantity'] = int.tryParse(value) ?? 0;
                        },
                        style: GoogleFonts.rubik(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Variant ${index + 1} Quantity',
                          labelStyle: GoogleFonts.rubik(color: Colors.white70),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            const SizedBox(height: 16),
            if (_hasVariants)
              Column(
                children: _newVariants.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> variant = entry.value;
                  return Column(
                    children: [
                      TextField(
                        controller: TextEditingController(text: variant['variantName']),
                        onChanged: (value) {
                          variant['variantName'] = value;
                        },
                        style: GoogleFonts.rubik(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'New Variant ${index + 1} Name',
                          labelStyle: GoogleFonts.rubik(color: Colors.white70),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      TextField(
                        controller: TextEditingController(text: variant['quantity'].toString()),
                        onChanged: (value) {
                          variant['quantity'] = int.tryParse(value) ?? 0;
                        },
                        style: GoogleFonts.rubik(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'New Variant ${index + 1} Quantity',
                          labelStyle: GoogleFonts.rubik(color: Colors.white70),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            if (_hasVariants)
              Center(
                child: ElevatedButton(
                  onPressed: _addVariantField,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
            if (_hasVariants)
              Center(
                child: ElevatedButton(
                  onPressed: _saveNewVariants,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Add Variants"),
                ),
              ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _saveItem,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  'Confirm',
                  style: GoogleFonts.rubik(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

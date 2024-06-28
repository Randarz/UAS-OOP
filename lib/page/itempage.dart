import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'edit_item_page.dart';

// Modified splitText function
String splitText(String text, int maxLength) {
  var words = text.split(' ');
  var result = [];
  var currentLine = '';

  for (var word in words) {
    if ((currentLine + word).length <= maxLength) {
      currentLine += word + ' ';
    } else {
      result.add(currentLine.trim());
      currentLine = word + ' ';
    }
  }
  result.add(currentLine.trim());

  return result.join('\n');
}

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    final response = await http.get(Uri.parse('https://p6d0q4jz-8080.asse.devtunnels.ms/item/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        items = data['data'];
      });
    } else {
      throw Exception('Failed to load items');
    }
  }

  void _onMenuSelection(String value, dynamic item) {
    if (value == 'Edit') {
      // Handle edit action
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditItemPage(
            itemId: item['id'],
            itemName: item['itemName'] ?? '',
            imageUrl: item['imageUrl'] ?? '',
            itemPrice: item['price'].toDouble() ?? 0.0,
            itemQuantity: item['totalQuantity'] ?? 0,
            hasVariants: item['variant'] != null && item['variant'].isNotEmpty,
            variants: item['variant'] != null
                ? List<Map<String, dynamic>>.from(item['variant'])
                : [],
          ),
        ),
      ).then((_) => fetchItems());
    } else if (value == 'Remove') {
      // Handle remove action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(36, 36, 36, 1),
      appBar: AppBar(
        title: const Text('Items', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(36, 36, 36, 1),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final itemName = item['itemName'] ?? '';
            final imageUrl = item['imageUrl'] ?? '';
            final price = item['price']?.toString() ?? '';
            final totalQuantity = item['totalQuantity'] ?? 0;
            final variantList = item['variant'] != null
                ? item['variant'].map((v) => '[${v['variantName']}]').join(', ')
                : 'No variants available';

            return Card(
              color: const Color.fromARGB(255, 250, 161, 109),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 150,
                                  width: 150,
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Text('No image', style: TextStyle(color: Colors.black)),
                                  ),
                                ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                splitText(itemName, 18), // Using the modified splitText function
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Price: Rp$price',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Variants: $variantList',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Quantity: $totalQuantity',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: PopupMenuButton<String>(
                      onSelected: (value) => _onMenuSelection(value, item),
                      itemBuilder: (BuildContext context) {
                        return {'Edit', 'Remove'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

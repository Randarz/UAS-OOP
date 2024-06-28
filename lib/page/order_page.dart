import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 36, 36),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 36, 36),
        title: Text(
          'Orders List',
          style: GoogleFonts.rubik(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Filter action
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          OrderItemCard(
            username: 'RandarzGitGut',
            itemName: 'VortexSeries Xera84',
            variant: 'type2',
            address: 'Cibinong, Bogor',
            expedition: 'JNE',
            phoneNumber: '081234567890',
            qty: 1,
            initialStatus: 'Proceed',
          ),
          OrderItemCard(
            username: 'ArdikaasBerakTakCebok',
            itemName: 'VortexSeries Oni R1',
            variant: 'type3',
            address: 'Cilegon, Banten',
            expedition: 'J&T',
            phoneNumber: '081234567890',
            qty: 1,
            initialStatus: 'Proceed',
          ),
          OrderItemCard(
            username: 'ProVynnie',
            itemName: 'Logitech G Pro X Superlight',
            variant: 'type3',
            address: 'Tangerang Selatan, Banten',
            expedition: 'JNE',
            phoneNumber: '081234567890',
            qty: 2,
            initialStatus: 'Proceed',
          ),
          OrderItemCard(
            username: 'KamalNotGud',
            itemName: 'Vynnie.co Deskmat NEKO daylight',
            variant: 'type3',
            address: 'Cilegon, Banten',
            expedition: 'J&T',
            phoneNumber: '081234567890',
            qty: 1,
            initialStatus: 'Completed',
          ),
        ],
      ),
    );
  }
}

class OrderItemCard extends StatefulWidget {
  final String username;
  final String itemName;
  final String variant;
  final String address;
  final String expedition;
  final String phoneNumber;
  final int qty;
  final String initialStatus;

  OrderItemCard({
    required this.username,
    required this.itemName,
    required this.variant,
    required this.address,
    required this.expedition,
    required this.phoneNumber,
    required this.qty,
    required this.initialStatus,
  });

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  late String currentStatus;
  late Color containerColor;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.initialStatus;
    containerColor = _getColorForStatus(currentStatus);
  }

  void _updateStatus() {
    setState(() {
      switch (currentStatus) {
        case 'Proceed':
          currentStatus = 'In Process';
          break;
        case 'In Process':
          currentStatus = 'Ready to Ship';
          break;
        case 'Ready to Ship':
          currentStatus = 'On Shipping';
          break;
        case 'On Shipping':
          currentStatus = 'Completed';
          break;
        case 'Completed':
          // Do nothing
          return;
      }
      containerColor = _getColorForStatus(currentStatus);
    });
  }

  Color _getColorForStatus(String status) {
    switch (status) {
      case 'Proceed':
        return Color.fromARGB(255, 247, 173, 133);
      case 'In Process':
        return Color.fromARGB(255, 255, 246, 163);
      case 'Ready to Ship':
        return Color.fromARGB(255, 216, 232, 238);
      case 'On Shipping':
        return Color.fromARGB(255, 250, 232, 251);
      case 'Completed':
        return Color.fromARGB(255, 238, 255, 190);
      default:
        return Colors.white;
    }
  }

  double fontSizeConverter(double x) {
    return x * 5 / 4;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: containerColor,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color.fromARGB(255, 36, 36, 36),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('lib/img/vynnie.jpg'),
                      radius: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.username,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: fontSizeConverter(12),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.itemName,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: fontSizeConverter(12),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'Qty: ${widget.qty}',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: fontSizeConverter(12),
                    ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'Variant: ${widget.variant}',
              style: TextStyle(
                color: Color.fromARGB(255, 97, 97, 97),
                fontSize: fontSizeConverter(10),
                ),
            ),
            Text(
              widget.address,
              style: TextStyle(
                color: Color.fromARGB(255, 36, 36, 36),
                fontSize: fontSizeConverter(10),
                ),
            ),
            Text(
              widget.phoneNumber,
              style: TextStyle(
                color: Color.fromARGB(255, 36, 36, 36),
                fontSize: fontSizeConverter(10),
                ),
            ),
            Text(
              widget.expedition,
              style: TextStyle(
                color: Color.fromARGB(255, 36, 36, 36),
                fontSize: fontSizeConverter(10),
                ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status: $currentStatus',
                  style: TextStyle(
                    color: Color.fromARGB(255, 36, 36, 36),
                    fontSize: fontSizeConverter(10),
                    ),
                ),
                ElevatedButton(
                  onPressed: currentStatus == 'Completed' ? null : _updateStatus,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 36, 36, 36),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Moved borderRadius to shape property
                    ),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: fontSizeConverter(10),
                    ),
                  ),
                  child: Text(currentStatus), // Moved child to the end
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

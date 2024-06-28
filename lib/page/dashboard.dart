import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'rating_page.dart';

class DashboardPage extends StatelessWidget {
  final String username;
  final String profileImageUrl;
  final Function(int) onItemTapped; // Callback function to change the page

  DashboardPage({
    required this.username,
    required this.profileImageUrl,
    required this.onItemTapped, // Add the callback function
  });

  @override
  Widget build(BuildContext context) {
    double totalSales = 15.632523; // Update with actual total sales value
    double totalOrders = 4394; // Update with actual total orders value
    double salesPercentageChange = 9.49; // Update with actual sales percentage change
    double ordersPercentageChange = -9.49; // Update with actual orders percentage change

    return Scaffold(
      backgroundColor: Color(0xFF242424),
      appBar: AppBar(
        backgroundColor: Color(0xFF242424),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('lib/img/smrek.jpg'),
          ),
        ),
        title: Text(
          'Hi, Josua Tanpa H',
          style: GoogleFonts.rubik(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: IconButton(
              icon: Icon(Icons.notifications_outlined, color: Colors.white),
              onPressed: () {
                // Handle notification tap
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First chart
              Container(
                height: 250,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Stack(
                  children: [
                    LineChart(
                      LineChartData(
                        minY: 0, 
                        maxY: 10,
                        minX: -0.5,
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 0.8),
                              FlSpot(1, 1.1),
                              FlSpot(2, 1.4),
                              FlSpot(3, 4),
                              FlSpot(4, 5),
                              FlSpot(5, 6),
                              FlSpot(6, 6.7),
                              FlSpot(7, 6.9),
                              FlSpot(8, 8),
                            ],
                            isCurved: false,
                            color: Colors.green,
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.green.withOpacity(0.3),
                                  Colors.green.withOpacity(0.0),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ],
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false), // Set show to false to remove grid lines
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Sales',
                            style: GoogleFonts.rubik(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Rp$totalSales',
                            style: GoogleFonts.rubik(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Text(
                        '+$salesPercentageChange%',
                        style: GoogleFonts.rubik(
                          color: Colors.green,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Second chart
              Container(
                height: 250,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Stack(
                  children: [
                    LineChart(
                      LineChartData(
                        minY: 0, 
                        maxY: 10,
                        minX: -0.5,
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 8),
                              FlSpot(1, 6.9),
                              FlSpot(2, 6.7),
                              FlSpot(3, 6),
                              FlSpot(4, 5),
                              FlSpot(5, 4),
                              FlSpot(6, 1.4),
                              FlSpot(7, 1.1),
                              FlSpot(8, 0.8),
                            ],
                            isCurved: false,
                            color: Colors.red,
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.red.withOpacity(0.3),
                                  Colors.red.withOpacity(0.0),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ],
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false), // Set show to false to remove grid lines
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Orders',
                            style: GoogleFonts.rubik(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '$totalOrders',
                            style: GoogleFonts.rubik(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Text(
                        '$ordersPercentageChange%',
                        style: GoogleFonts.rubik(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              RecentOrders(onItemTapped: onItemTapped), // Pass the callback function
              SizedBox(height: 20),
              RecentRatingsReviews(onItemTapped: onItemTapped), // Pass the callback function
            ],
          ),
        ),
      ),
    );
  }
}

class RecentOrders extends StatelessWidget {
  final Function(int) onItemTapped; // Callback function to change the page

  RecentOrders({required this.onItemTapped}); // Add the callback function

  @override
  Widget build(BuildContext context) {
    // Dummy data for recent orders
    final orders = [
      {
        'user': 'RandarzGitGut',
        'item': 'Item Name',
        'variant': 'type3',
        'qty': 1,
        'profileImageUrl': 'lib/img/jamur.jpg'
      },
      {
        'user': 'KamallsBad',
        'item': 'Item Name',
        'variant': 'type3',
        'qty': 2,
        'profileImageUrl': 'lib/img/kamal.jpg',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFAE9FB),
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ...orders.map((order) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Color(0xFFFAE9FB),
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(order['profileImageUrl'] as String),
                          onBackgroundImageError: (exception, stackTrace) {
                            print('Image load error: $exception');
                          },
                        ),
                        SizedBox(width: 10),
                        Text(
                          order['user'] as String,
                          style: GoogleFonts.rubik(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order['item'] as String,
                          style: GoogleFonts.rubik(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Qty: ${(order['qty'] as int).toString()}',
                          style: GoogleFonts.rubik(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Variant: ${order['variant']}',
                      style: GoogleFonts.rubik(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF6A1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextButton(
              onPressed: () {
                onItemTapped(1); // Change to the OrderPage by updating the index
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'View More',
                    style: GoogleFonts.rubik(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                    size :17,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecentRatingsReviews extends StatelessWidget {
  final Function(int) onItemTapped; // Callback function to change the page

  RecentRatingsReviews({required this.onItemTapped}); // Add the callback function

  @override
  Widget build(BuildContext context) {
    // Dummy data for recent ratings & reviews
    final reviews = [
      {
        'user': 'Ardikaas2003SM',
        'rating': 3.5,
        'review': 'Lorem ipsum dolor sit amet consectetur. Quis tellus nullam etiam convallis ac ornare vitae. Egestas odio vitae hac morbi. Habitasse mollis tortor tinc.',
        'variant': 'type1',
        'profileImageUrl': 'lib/img/dika.jpg'
      },
      {
        'user': 'VynnieSoPro',
        'rating': 5.0,
        'review': 'Lorem ipsum dolor sit amet consectetur. Quis tellus nullam etiam convallis ac ornare vitae. Egestas odio vitae hac morbi. Habitasse mollis tortor tinc.',
        'variant': 'type2',
        'profileImageUrl': 'lib/img/vynnie.jpg', // Reference to local image
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFEEFEBF),
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ...reviews.map((review) {
            double rating = review['rating'] as double;
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Color(0xFFEEFEBF),
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(review['profileImageUrl'] as String), // Use AssetImage for local images
                              onBackgroundImageError: (exception, stackTrace) {
                                print('Image load error: $exception');
                              },
                            ),
                            SizedBox(width: 10),
                            Text(
                              review['user'] as String,
                              style: GoogleFonts.rubik(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        RatingBarIndicator(
                          rating: rating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.black, // Set the star color to black
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      review['review'] as String,
                      style: GoogleFonts.rubik(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Variant: ${review['variant']}',
                      style: GoogleFonts.rubik(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFD7FAFE), // Change the color to match the provided image
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextButton(
              onPressed: () {
                // Navigate to the RatingPage when the button is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RatingPage()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'View More',
                    style: GoogleFonts.rubik(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                    size: 17,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

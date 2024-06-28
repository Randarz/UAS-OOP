import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Review {
  final String image;
  final String name;
  final String product;
  final String variants;
  final String quantity;
  final String comment;
  final double rating;

  Review({
    required this.image,
    required this.name,
    required this.product,
    required this.variants,
    required this.quantity,
    required this.comment,
    required this.rating,
  });
}

class RatingPage extends StatelessWidget {
  final List<Review> reviewList = [
    Review(
      image: 'https://github.com/SyrenSoul/Image/blob/main/Cucumber.jpeg?raw=true',
      name: 'ArdikaasCum',
      product: 'Jacket',
      variants: '[White]',
      quantity: '1',
      comment: 'Great product!',
      rating: 4.5,
    ),
    Review(
      image: 'https://github.com/SyrenSoul/Image/blob/main/Toad.jpeg?raw=true',
      name: 'RandarzGitGut',
      product: 'Shoes',
      variants: '[White]',
      quantity: '1',
      comment: 'Kinda',
      rating: 4.0,
    ),
    Review(
      image: 'https://github.com/SyrenSoul/Image/blob/main/Vynnie.jpeg?raw=true',
      name: 'ProVynnie',
      product: 'Sandal',
      variants: '[White]',
      quantity: '1',
      comment: 'Very useful!',
      rating: 4.5,
    ),
    Review(
      image: 'https://github.com/SyrenSoul/Image/blob/main/Doma.jpeg?raw=true',
      name: 'SyrenSoul',
      product: 'Shirt',
      variants: '[White]',
      quantity: '2',
      comment: 'Yahahahayyukkksss',
      rating: 5.0,
    ),
    Review(
      image: 'https://github.com/SyrenSoul/Image/blob/main/Opah.jpg?raw=true',
      name: 'KamalNotGud',
      product: 'Cardigan',
      variants: '[White]',
      quantity: '1',
      comment: 'Meh',
      rating: 3.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(36, 36, 36, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 36, 36, 1),
        centerTitle: true,
        title: Text(
          'Reviews', 
          style: GoogleFonts.rubik(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ), 
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            color: Colors.white,
            onPressed: () {
              // Handle filter action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: reviewList.length,
              itemBuilder: (context, index) {
                return ReviewUI(
                  review: reviewList[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewUI extends StatelessWidget {
  final Review review;

  const ReviewUI({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(48, 48, 48, 1),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(review.image),
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: GoogleFonts.rubik(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                RatingBarIndicator(
                  rating: review.rating,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
            
            const SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.product,
                        style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Variants: ${review.variants}',
                        style: GoogleFonts.rubik(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Quantity: ${review.quantity}',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Text(
              review.comment.length > 100 ? '${review.comment.substring(0, 100)}...' : review.comment,
              style: GoogleFonts.rubik(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

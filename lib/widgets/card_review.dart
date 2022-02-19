import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/response_detail.dart';

class CardReview extends StatelessWidget {
  CustomerReview customerReview;

  CardReview({required this.customerReview});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Icon(Icons.account_circle,size: 30,color: Colors.white,),
              ),
              SizedBox(width: 10,),
              Text(
                customerReview.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: 20,),
              Text(
                customerReview.date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.2)
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          Container(
            margin: EdgeInsets.only(left:40),
            child: Text(
              customerReview.review,
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}

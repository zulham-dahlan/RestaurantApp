import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/response_detail.dart';

class FoodsMenu extends StatelessWidget {
  List<Category> foodCategory;
  String categoryMenu;

  FoodsMenu({required this.foodCategory, required this.categoryMenu});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          categoryMenu,
          textAlign: TextAlign.center,
          style: TextStyle(color: darkColor, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: foodCategory.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(width: 2, color: mainColor))),
                    child: Text(foodCategory[index].name),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              );
            }),
      ],
    );
  }
}

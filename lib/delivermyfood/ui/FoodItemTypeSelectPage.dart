import 'package:DeliverMyFood/delivermyfood/Callbacks.dart';
import 'package:DeliverMyFood/delivermyfood/models/FoodItemType.dart';
import 'package:DeliverMyFood/weatherapp/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FoodItemTypeSelectPage {

  // Default Radio Button Item
  var fList = foodItemListType;

   Widget showTypeDialog(OnItemSelect onItemSelect,int position,BuildContext context){
     return Column(
       children: <Widget>[
         Expanded(
             child: Container(
               child: Column(
                 children:
                 fList.map((data) => RadioListTile(
                   title: Text("${data.name}"),
                   groupValue: Utils.selectedFoodType,
                   value: data.index,
                   onChanged: (val) {
                     onItemSelect.foodType(data, position);

                     //Navigator.pop(context);
                   },
                 )).toList(),
               ),
             )),

       ],
     );
   }

}
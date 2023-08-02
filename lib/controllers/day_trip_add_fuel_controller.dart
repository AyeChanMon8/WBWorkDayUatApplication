// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DayTripAddFuelController extends GetxController{
  TextEditingController dateTextController;
  TextEditingController shopNameTextController;
  TextEditingController literTextController;
  TextEditingController priceTextController;
  TextEditingController totalAmountTextController;
  @override
  void onInit() {
    super.onInit();
    dateTextController = TextEditingController();
    shopNameTextController = TextEditingController();
    literTextController = TextEditingController();
    priceTextController = TextEditingController();
    totalAmountTextController =TextEditingController();
  }

}
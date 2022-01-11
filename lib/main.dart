import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:terremotos/bindings.dart';
import 'package:terremotos/home.dart';

void main(){
  runApp(GetMaterialApp(
    title: 'Terremotos',
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: ()=> const HomePage(), binding: HomeBinding())
    ],
  ));
}

import 'package:ecommerce_user_app/pages/view_product_page.dart';
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import 'login_page.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/';
  const LauncherPage({super.key});

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0),(){
      if(AuthService.currentUser != null){
        Navigator.pushReplacementNamed(context, ViewProductPage.routeName);
      }else{
        Navigator.pushReplacementNamed(context, LoginPage.routeName);

      }
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(child: CircularProgressIndicator()),
    );
  }
}

import 'package:ecommerce_user_app/pages/cart_page.dart';
import 'package:ecommerce_user_app/pages/checkout_page.dart';
import 'package:ecommerce_user_app/providers/cart_provider.dart';
import 'package:ecommerce_user_app/providers/order_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'pages/launcher_page.dart';
import 'pages/login_page.dart';
import 'pages/view_product_page.dart';
import 'providers/product_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName : (context) => const LauncherPage(),
        LoginPage.routeName : (context) => const LoginPage(),
        ViewProductPage.routeName : (context) => const ViewProductPage(),
        CartPage.routeName : (context) => const CartPage(),
        CheckoutPage.routeName : (context) => const CheckoutPage(),
      },
    );
  }
}


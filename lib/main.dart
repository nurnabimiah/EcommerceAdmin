import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/pages/dashboard_page.dart';
import 'package:firebase_demo/pages/launcher_page.dart';
import 'package:firebase_demo/pages/login_page.dart';
import 'package:firebase_demo/pages/new_product_page.dart';
import 'package:firebase_demo/pages/product_details_page.dart';
import 'package:firebase_demo/pages/product_list_page.dart';
import 'package:firebase_demo/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()

         ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LauncherPage(),
        routes: {
          LauncherPage.routeName : (context) => LauncherPage(),
          LoginPage.routeName : (context) => LoginPage(),
          NewProductPage.routeName : (context) => NewProductPage(),
          ProductDetailsPage.routeName : (context) => ProductDetailsPage(),
          ProductListPage.routeName : (context) => ProductListPage(),
          DashboardPage.routeName : (context) => DashboardPage(),
        },
      ),
    );
  }
}




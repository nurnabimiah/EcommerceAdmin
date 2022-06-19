
import 'package:firebase_demo/pages/product_list_page.dart';
import 'package:firebase_demo/providers/product_provider.dart';
import 'package:flutter/material.dart';

import '../auth/firebase_auth.dart';
import '../custom_widget/dashboard_button.dart';
import 'login_page.dart';
import 'new_product_page.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late ProductProvider _productProvider;

  @override
  void didChangeDependencies() {


    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              /* code for logout*/
              FirebaseAuthService.Logout().then((value) => Navigator.pushReplacementNamed(context, LoginPage.routeName));

            },
          )
        ],
      ),

      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: [
          DashboardButton(
            label: 'Add Product',
            onPressed: () => Navigator.pushNamed(context, NewProductPage.routeName),
          ),
          DashboardButton(
            label: 'View Product',
            onPressed: () => Navigator.pushNamed(context, ProductListPage.routeName),
          ),
          DashboardButton(
            label: 'View Product',
            onPressed: () => Navigator.pushNamed(context, ProductListPage.routeName),
          ),
          DashboardButton(
            label: 'View Product',
            onPressed: () => Navigator.pushNamed(context, ProductListPage.routeName),
          ),
          DashboardButton(
            label: 'View Product',
            onPressed: () => Navigator.pushNamed(context, ProductListPage.routeName),
          ),
          DashboardButton(
            label: 'View Product',
            onPressed: () => Navigator.pushNamed(context, ProductListPage.routeName),
          ),
          DashboardButton(
            label: 'View Product',
            onPressed: () => Navigator.pushNamed(context, ProductListPage.routeName),
          ),
        ],
      ),

    );
  }
}

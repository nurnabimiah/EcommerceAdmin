
import 'package:firebase_demo/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class ProductListPage extends StatefulWidget {
  static const String routeName = '/productList';

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductProvider _productProvider;
// solution
  get takaSymbol => '৳';

  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: _productProvider.productList.isEmpty ? Center(
        child: Text('No items found'),
      ) : ListView.builder(
        itemCount: _productProvider.productList.length,
        itemBuilder: (context, index) {
          final product = _productProvider.productList[index];
          return Card(
            elevation: 5,
            child: ListTile(

                onTap:() => Navigator.pushNamed(context, ProductDetailsPage.routeName,arguments: [product.id,product.name]),
                title: Text(product.name!),
                leading: fadedImageWidget(product.imageDownloadUrl!),
                trailing: Chip(
                  label: Text('$takaSymbol ${product.price}'),
                )
            ),
          );
        },
      ),




    );
  }

  /* ai faded in Image ta tokhoni call kora hoy suppose doren amar image network thekhe download hobe,akhon
  download hothe to time lagbe, jotho khon download hobe na tothokhon porjonto ekta place holder image show korbe
  r jokhon download hoye jabe tokhon imager url ta show korbe

   */
  Widget fadedImageWidget(String url) {
    return FadeInImage.assetNetwork(
        fadeInDuration: const Duration(seconds: 3),
        fadeInCurve: Curves.bounceInOut,
        fit: BoxFit.cover,
        placeholder: 'images/imageplaceholder.png',
        image: url
    );
  }


}


import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/models/product_model.dart';
import 'package:firebase_demo/models/purchase_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class NewProductPage extends StatefulWidget {
  static const String routeName = '/newProduct';

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final _formkey = GlobalKey<FormState>();
  String? _category;
  DateTime? _dateTime;
  ProductModel _productModel = ProductModel();
  PurchaseModel _purchaseModel = PurchaseModel(purchaseDate: Timestamp.fromDate(DateTime.now()));
  ImageSource _imageSource = ImageSource.camera;
  String? _imagePath;
  bool isSaving = false;
  late ProductProvider _productProvider;

  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);
    super.didChangeDependencies();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){

            }
          )
        ],
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            TextFormField(
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'This field must not be empty';
                }
                return null;
              },
              onSaved: (value) {
                _productModel.name = value;
              },
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),

            TextFormField(
              //maxLines: 10,
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'This field must not be empty';
                }
                return null;
              },
              onSaved: (value) {
                _productModel.description = value;
              },
              decoration: InputDecoration(
                labelText: 'Product Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'This field must not be empty';
                }
                return null;
              },
              onSaved: (value) {
                _purchaseModel.purchasePrice= num.parse(value!);
              },
              decoration: InputDecoration(
                labelText: ' Purchases Price',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),



            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'This field must not be empty';
                }
                return null;
              },
              onSaved: (value) {
                _productModel.price = num.parse(value!);
              },
              decoration: InputDecoration(
                labelText: ' Sale Price',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),


            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'This field must not be empty';
                }
                return null;
              },
              onSaved: (value) {
                _purchaseModel.qty = num.parse(value!);
              },
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),

            DropdownButtonFormField<String>(          /* dropdown nameo widget ase, catagory database theke asbe*/
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),

              hint: Text('Select Category'),
              value: _category,  /* category jeita select hobe  priduct model er modde dokbe*/
              onChanged: (value) {
                setState(() {
                  _category = value;
                });

              },
              onSaved: (value){
                _productModel.category = value;

              },
              items: _productProvider.categoryList.map((cat) => DropdownMenuItem(
                child: Text(cat),
                value: cat,
              )).toList(),
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'Please select a category';
                }
                return null;
              },
            ),




          ],


        ),

      ),



    );
  }
}


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../custom_widget/custom_progress_dialouge.dart';
import '../models/product_model.dart';
import '../models/purchase_model.dart';
import '../providers/product_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_function.dart';

class NewProductPage extends StatefulWidget {
  static const String routeName = '/new_product';

  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  late ProductProvider _productProvider;
  final _formKey = GlobalKey<FormState>();
  String? _category;
  DateTime? _dateTime;
  ProductModel _productModel = ProductModel();

  PurchaseModel _purchaseModel = PurchaseModel(purchaseDate: Timestamp.fromDate(DateTime.now()));

  ImageSource _imageSource = ImageSource.camera;
  String? _imagePath;
  bool isSaving = false;

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
            onPressed: _saveProduct,
          )
        ],
      ),
      body: Stack(
        children: [
          if(isSaving) Center(child: CustomProgressDialog(title: 'Please wait',),),
          Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(12.0),
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
                SizedBox(height: 10,),
                Card(
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                          onPressed: _showDatePicker,
                          icon: Icon(Icons.date_range),
                          label: Text('Select Date')
                      ),
                      Text(_dateTime == null ? 'No date chosen' : getFormattedDate(_dateTime!, 'MMM dd, yyyy')),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2)
                        ),
                        child: _imagePath == null ? Image.asset('images/imageplaceholder.png')
                            : Image.file(File(_imagePath!), width: 100, height: 100, fit: BoxFit.cover,),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text('Camera'),
                            onPressed: () {
                              _imageSource = ImageSource.camera;
                              _pickImage();
                            },
                          ),
                          SizedBox(width: 10,),
                          ElevatedButton(
                            child: Text('Gallery'),
                            onPressed: () {
                              _imageSource = ImageSource.gallery;
                              _pickImage();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveProduct() async {
    final isConnected = await isConnectedToInternet(); // internet er sathe connect na thakele image upload hobe na
    // is connected to internet aita holo helper function er ekta method
    if(isConnected) {
      if(_formKey.currentState!.validate()) {
        _formKey.currentState!.save();  //ai save method ta call korbe proti ta save method k
        if (_dateTime == null) {
          showMessage(context, 'Please a select a date');
          return;
        }
        if (_imagePath == null) {
          showMessage(context, 'Please a select an image');
          return;
        }
        setState(() {
          isSaving = true;  // aitan k rakha hyse kono ekta progress bar goranor jonnno
        });

        _uploadImageAndSaveProduct();

      }
    }else {
      showMessage(context, 'No internet connection detected.');
    }

  }

  void _showDatePicker() async {
    final dt = await showDatePicker(   // showDatePicker flutter er method
      /*show date picker ta return kore ekta  date picker er object*/
        context: context,
        initialDate: DateTime.now(), // date time open krle kon date ta select hoye thakbe
        firstDate: DateTime(DateTime.now().year - 1), // ami pisate pisate kon date porjonto jete parbo
        lastDate: DateTime.now()); // ai mohorte j date ta dewa ase
    if(dt != null) {
      setState(() {             /* jodi null na hoy tahole kono ekta user date ta select korse
                              other wise date ta null thekhe jabe , tahole ai date ta k opore _date
                               time er modde assign kore dibo*/
        _dateTime = dt;
        _purchaseModel.purchaseDate = Timestamp.fromDate(_dateTime!);

      });

    }
  }

  void _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: _imageSource, imageQuality: 60);
    if(pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });

    }
  }
  /* ai image ta firebase er storage a tolbo, ai image golo asole a cloud a thakbe
    tahole storage a kivabe upload kora hobe, picture ta tolar por amra image ta file hisabe  dart file a convert korte
    hobe. amar main concept holo sodo pic ta upload kora na upload korar por image ta to amake download korte hobe
    , ai download url ta amar dorkar, sei url ta peye gele ami product model er imageDownloadUrl hisabe rakhte parbo
      product model a image er nam tao niye rakhsi,athe ki sobida hobe image ta delete korte parbo,
      image er url ta peye gele amra aita k admin app  eo show korabo abar user app eo show korabo*/

  void _uploadImageAndSaveProduct() async {
    final imageName = '${_productModel.name}_${DateTime.now().microsecondsSinceEpoch}'; // aita hobe product er nam
    _productModel.imageName = imageName;
    final photoRef = FirebaseStorage.instance.ref().child('$photoDirectory/$imageName');
    final uploadTask = photoRef.putFile(File(_imagePath!));
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    _productModel.imageDownloadUrl = downloadUrl;
    _productProvider.insertNewProduct(_productModel, _purchaseModel)
        .then((value) {
      setState((){
        isSaving = false;

      });
      Navigator.pop(context);

    }).catchError((error){
      showMessage(context, 'Could not save');
    });

  }
}

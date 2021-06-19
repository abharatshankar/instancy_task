import 'package:flutter/material.dart';
import 'package:instancy_task/screens/home/custom_widgets/custom_drop_down.dart';
import 'package:instancy_task/screens/home/models/product_list_model.dart';
import 'package:instancy_task/screens/home/models/saved_product_model.dart';

class DetailedScreen extends StatefulWidget {
  final SavedProduct productDetails;
  final int index;
  final ProductList product;

  const DetailedScreen({Key key, this.productDetails, this.index, this.product})
      : super(key: key);
  @override
  _DetailedScreenState createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  List<SavedProduct> choosedProductData = [];
  String savedColor = "No Color";
  String savedSize = 'No Size';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              print((widget.productDetails.noOfUnits + 1) *
                  widget.productDetails.totalPrice);
              Navigator.of(context).pop(SavedProduct(
                  choosedColor: savedColor,
                  choosedSize: savedSize,
                  uniqueId: widget.productDetails.uniqueId,
                  noOfUnits: (widget.productDetails.noOfUnits + 1),
                  productName: widget.productDetails.productName,
                  totalPrice: widget.productDetails.noOfUnits == 0
                      ? widget.productDetails.totalPrice
                      : widget.productDetails.noOfUnits *
                          widget.productDetails.totalPrice,
                  unitPrice: widget.productDetails.unitPrice));
            },
            label: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Add Product'),
              ),
            )),
        appBar: AppBar(),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Title:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      widget?.productDetails?.productName ?? "N/A",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text("Change color:"),
                      CustomDropDown(
                          value: widget?.productDetails?.choosedColor ??
                              "No Color",
                          itemsList: productVariants(
                              widget?.product?.productVariants ?? [], 'color'),
                          onChanged: (value) {
                            print(value);
                            savedColor = value;
                            widget?.productDetails?.choosedColor = value;
                            setState(() {});
                          }),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text("Change Size:"),
                      CustomDropDown(
                          value:
                              widget?.productDetails?.choosedSize ?? "No Size",
                          itemsList: productVariants(
                              widget?.product?.productVariants ?? [], 'size'),
                          onChanged: (value) {
                            savedSize = value;
                            print(value);
                            widget?.productDetails?.choosedSize = value;
                            setState(() {});
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> productVariants(List<ProductVariant> variants, String type) {
    List<String> colorsList = [];
    List<String> sizesList = [];
    colorsList.clear();
    sizesList.clear();
    colorsList.add("No Color");
    sizesList.add("No Size");
    for (var item in variants) {
      item.variantType == 'color'
          ? colorsList.add(item.variantValue)
          : sizesList.add(item.variantValue);
    }
    return type == 'color' ? colorsList : sizesList;
  }
}

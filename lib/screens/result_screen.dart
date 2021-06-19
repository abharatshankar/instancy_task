import 'package:flutter/material.dart';
import 'package:instancy_task/screens/home/models/saved_product_model.dart';
import 'package:instancy_task/utils/util_methods.dart';

class ResultScreen extends StatefulWidget {
  final List<SavedProduct> selectedProductsList;

  const ResultScreen({Key key, this.selectedProductsList}) : super(key: key);
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Results'),
        ),
        body: ListView.builder(
            itemCount: widget?.selectedProductsList?.length ?? 0,
            itemBuilder: (context, index) {
              SavedProduct product = widget?.selectedProductsList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: applyShadow(containerRadius: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product?.productName ?? "N/A",
                              style: titleTextStyle(),
                            ),
                            Row(
                              children: [
                                Text(
                                  (product?.totalPrice.toString() ?? "") +
                                      " x " +
                                      (product?.noOfUnits.toString()),
                                  style: spTextStyle(),
                                ),
                                Text(
                                  " = " +
                                      ((product?.totalPrice ?? 0) *
                                              (product?.noOfUnits ?? 0))
                                          .toString(),
                                  style: spTextStyle(),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    'Color Variant : ${product?.choosedColor ?? ""}'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    'Size Variant : ${product?.choosedSize ?? ""}'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

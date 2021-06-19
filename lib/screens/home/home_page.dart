import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:instancy_task/screens/home/custom_widgets/custom_drop_down.dart';
import 'package:instancy_task/screens/home/detail_screen.dart';
import 'package:instancy_task/screens/home/models/product_list_model.dart';
import 'package:instancy_task/screens/home/models/saved_product_model.dart';
import 'package:instancy_task/screens/home/repository/products_list_repo.dart';
import 'package:instancy_task/screens/result_screen.dart';
import 'package:instancy_task/utils/util_methods.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductListModel productsData;
  List<String> colorsList = [];
  List<String> sizesList = [];
  List<SavedProduct> choosedProductData = [];
  List<SavedProduct> selectedProductsList = [];
  String totalAmountStr;
  TextEditingController spEditController;

  @override
  void initState() {
    super.initState();
    spEditController = TextEditingController();
    getData();
  }

  @override
  void dispose() {
    spEditController.dispose();
    super.dispose();
  }

  getData() async {
    productsData = await getProductList();
    for (ProductList item in productsData?.productList ?? []) {
      choosedProductData.add(SavedProduct(
          choosedColor: 'No Color',
          choosedSize: 'No Size',
          noOfUnits: 0,
          productName: item.name,
          totalPrice: item.sp,
          unitPrice: item.unitprice,
          uniqueId: item.id));
    }
    print(choosedProductData);
    setState(() {});
  }

  String totalAmount() {
    int total = 0;

    for (var item in selectedProductsList) {
      total = total + (item.totalPrice * item.noOfUnits);
    }
    return total.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Products Page'),
          leading: Icon(Icons.menu),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No of Items : ${selectedProductsList?.length ?? 0}"),
                  Text('Total : ${totalAmount()} '),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: (selectedProductsList?.length ?? 0) > 0
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ResultScreen(
                            selectedProductsList: selectedProductsList ?? [],
                          )));
                },
                label: Container(
                  child: Row(
                    children: [
                      Text('Proceed'),
                    ],
                  ),
                ),
              )
            : Container(),
        body: ListView.builder(
            itemCount: productsData?.productList?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print(choosedProductData[index]);
                  print(productsData?.productList[index]);
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (_) => DetailedScreen(
                                index: index,
                                productDetails: choosedProductData[index],
                                product: productsData?.productList[index],
                              )))
                      .then((value) {
                    if (value != null) {
                      SavedProduct product = value;
                      if (product.noOfUnits == 1) {
                        selectedProductsList.add(product);
                      } else {
                        if (selectedProductsList.length > 0) {
                          for (var i = 0;
                              i < selectedProductsList.length;
                              i++) {
                            if (selectedProductsList[i].uniqueId ==
                                product.uniqueId) {
                              selectedProductsList[i] = product;
                            }
                          }
                        } else {
                          selectedProductsList.add(product);
                        }
                      }

                      choosedProductData[index] = product;
                      setState(() {});
                    }

                    // productsData?.productList[index].
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    width: MediaQuery.of(context).size.width,
                    decoration: applyShadow(containerRadius: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productsData?.productList[index]?.name ?? "N/A",
                                style: titleTextStyle(),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (_) {
                                            return _editSpValue(
                                                index: index,
                                                product: productsData
                                                    ?.productList[index]);
                                          }).then((value) => setState(() {}));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            productsData?.productList[index]?.sp
                                                    .toString() ??
                                                "",
                                            style: spTextStyle(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 7),
                                            child: Icon(Icons.edit, size: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  productsData?.productList[index]?.discount
                                              ?.discountValue
                                              .toString() !=
                                          "0"
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                  productsData
                                                          ?.productList[index]
                                                          ?.unitprice ??
                                                      "",
                                                  style: unitPriceStyle(
                                                      productsData
                                                          ?.productList[index]
                                                          ?.discount
                                                          ?.discountValue
                                                          .toString())),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                    calculateDiscount(
                                                        discountPrice: productsData
                                                                ?.productList[
                                                                    index]
                                                                ?.discount
                                                                ?.discountValue
                                                                .toString() ??
                                                            "0",
                                                        totalPrice: productsData
                                                                ?.productList[
                                                                    index]
                                                                ?.unitprice ??
                                                            ""),
                                                    style: discountStyle()),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              (productsData?.productList[index]?.productVariants
                                              ?.length ??
                                          0) >
                                      0
                                  ? GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (_) {
                                              return _getBottomSheetWidget(
                                                  index: index,
                                                  product: productsData
                                                      ?.productList[index]);
                                            }).then((value) => setState(() {}));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    "Color : ${choosedProductData[index].choosedColor}\nSize : ${choosedProductData[index].choosedSize}"),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1)),
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: IconButton(
                                    padding: new EdgeInsets.all(0.0),
                                    icon: Icon(
                                      Icons.remove,
                                    ),
                                    onPressed: () {
                                      if (choosedProductData[index].noOfUnits ==
                                          0) {
                                        selectedProductsList.clear();
                                        BotToast.showText(
                                            text: "No Products to remove");
                                      } else {
                                        int quantity = choosedProductData[index]
                                                .noOfUnits -
                                            1;
                                        if (selectedProductsList.contains(
                                            choosedProductData[index])) {
                                          choosedProductData[index].noOfUnits =
                                              quantity;
                                          if (quantity == 0) {
                                            selectedProductsList.removeAt(
                                                selectedProductsList.indexOf(
                                                    choosedProductData[index]));
                                          } else {
                                            selectedProductsList[
                                                    selectedProductsList
                                                        .indexOf(
                                                            choosedProductData[
                                                                index])] =
                                                choosedProductData[index];
                                          }
                                        } else {
                                          choosedProductData[index].noOfUnits =
                                              quantity;
                                        }
                                      }
                                      print(selectedProductsList);
                                      print(
                                          " decremented  value ${choosedProductData[index].noOfUnits}");
                                      setState(() {});
                                    }),
                                width: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  choosedProductData[index]
                                      .noOfUnits
                                      .toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                child: IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      if (selectedProductsList.contains(
                                          choosedProductData[index])) {
                                        choosedProductData[index].noOfUnits =
                                            choosedProductData[index]
                                                    .noOfUnits +
                                                1;
                                        selectedProductsList[
                                                selectedProductsList.indexOf(
                                                    choosedProductData[
                                                        index])] =
                                            choosedProductData[index];
                                      } else {
                                        choosedProductData[index].noOfUnits =
                                            choosedProductData[index]
                                                    .noOfUnits +
                                                1;
                                        selectedProductsList
                                            .add(choosedProductData[index]);
                                      }

                                      print(selectedProductsList);

                                      print(
                                          " incremented  value ${choosedProductData[index].noOfUnits}");
                                      setState(() {});
                                    }),
                                width: 30,
                              ),
                              SizedBox(
                                width: 15,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _getBottomSheetWidget({int index, ProductList product}) {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.50,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                "Choose color :",
                style: titleTextStyle(),
              ),
              CustomDropDown(
                  value: (colorsList?.length ?? 0) > 0
                      ? choosedProductData[index]?.choosedColor ?? null
                      : "No Color",
                  itemsList:
                      productVariants(product?.productVariants ?? [], 'color'),
                  onChanged: (value) {
                    print(value);
                    choosedProductData[index].choosedColor = value;
                    setState(() {});
                  }),
              SizedBox(
                height: 10,
              ),
              Text("Choose size :"),
              CustomDropDown(
                  value: (sizesList?.length ?? 0) > 0
                      ? choosedProductData[index]?.choosedSize ?? null
                      : "No Size",
                  itemsList:
                      productVariants(product?.productVariants ?? [], 'size'),
                  onChanged: (value) {
                    print(value);
                    choosedProductData[index].choosedSize = value;
                    setState(() {});
                  }),
            ],
          ),
        ),
      );
    });
  }

  Widget _editSpValue({int index, ProductList product}) {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.30,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  controller: spEditController,
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  decoration: InputDecoration(hintText: 'Change Special Price'),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    productsData?.productList[index].sp =
                        int.parse(spEditController.text);

                    for (var i = 0;
                        i < productsData?.productList?.length;
                        i++) {
                      for (var k = 0; k < selectedProductsList.length; k++) {
                        if (productsData?.productList[i].id ==
                            selectedProductsList[k].uniqueId) {
                          selectedProductsList[k].totalPrice =
                              productsData?.productList[i].sp;
                        }
                      }
                    }

                    Navigator.of(context).pop();
                  },
                  child: Text('Update'))
            ],
          ));
    });
  }

  List<String> productVariants(List<ProductVariant> variants, String type) {
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

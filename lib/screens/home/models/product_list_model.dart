// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) =>
    ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) =>
    json.encode(data.toJson());

class ProductListModel {
  ProductListModel({
    this.error,
    this.productList,
  });

  bool error;
  List<ProductList> productList;

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        error: json["error"],
        productList: (json["error"] != null || json['error'] != true)
            ? List<ProductList>.from(
                json["product_list"].map((x) => ProductList.fromJson(x)))
            : ProductListModel(),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "product_list": List<dynamic>.from(productList.map((x) => x.toJson())),
      };
}

class ProductList {
  ProductList({
    this.tenantId,
    this.name,
    this.customCode,
    this.unitprice,
    this.msp,
    this.id,
    this.isActive,
    this.productOption1,
    this.meta,
    this.discount,
    this.gst,
    this.sp,
    this.productVariants,
    this.productAccessories,
  });

  int tenantId;
  String name;
  String customCode;
  String unitprice;
  String msp;
  int id;
  bool isActive;
  List<int> productOption1;
  Meta meta;
  Discount discount;
  String gst;
  int sp;
  List<ProductVariant> productVariants;
  List<ProductAccessory> productAccessories;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        tenantId: json["tenant_id"],
        name: json["name"],
        customCode: json["custom_code"],
        unitprice: json["unitprice"],
        msp: json["msp"],
        id: json["id"],
        isActive: json["is_active"],
        productOption1: json["product_option1"] == null
            ? null
            : List<int>.from(json["product_option1"].map((x) => x)),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        discount: Discount.fromJson(json["discount"]),
        gst: json["gst"],
        sp: json["sp"],
        productVariants: List<ProductVariant>.from(
            json["product_variants"].map((x) => ProductVariant.fromJson(x))),
        productAccessories: List<ProductAccessory>.from(
            json["product_accessories"]
                .map((x) => ProductAccessory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tenant_id": tenantId,
        "name": name,
        "custom_code": customCode,
        "unitprice": unitprice,
        "msp": msp,
        "id": id,
        "is_active": isActive,
        "product_option1": productOption1 == null
            ? null
            : List<dynamic>.from(productOption1.map((x) => x)),
        "meta": meta == null ? null : meta.toJson(),
        "discount": discount.toJson(),
        "gst": gst,
        "sp": sp,
        "product_variants":
            List<dynamic>.from(productVariants.map((x) => x.toJson())),
        "product_accessories":
            List<dynamic>.from(productAccessories.map((x) => x.toJson())),
      };
}

class Discount {
  Discount({
    this.isDiscountPercent,
    this.discountValue,
  });

  bool isDiscountPercent;
  dynamic discountValue;

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        isDiscountPercent: json["is_discount_percent"],
        discountValue: json["discount_value"],
      );

  Map<String, dynamic> toJson() => {
        "is_discount_percent": isDiscountPercent,
        "discount_value": discountValue,
      };
}

class Meta {
  Meta({
    this.description,
    this.specifications,
    this.features,
    this.imageId,
    this.variant,
  });

  String description;
  String specifications;
  String features;
  String imageId;
  String variant;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        description: json["description"],
        specifications: json["specifications"],
        features: json["features"],
        imageId: json["imageId"] == null ? null : json["imageId"],
        variant: json["variant"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "specifications": specifications,
        "features": features,
        "imageId": imageId == null ? null : imageId,
        "variant": variant,
      };
}

class ProductAccessory {
  ProductAccessory({
    this.accessoriesId,
    this.productId,
    this.name,
    this.sellingPrice,
    this.gst,
    this.createdAt,
  });

  int accessoriesId;
  int productId;
  String name;
  int sellingPrice;
  int gst;
  DateTime createdAt;

  factory ProductAccessory.fromJson(Map<String, dynamic> json) =>
      ProductAccessory(
        accessoriesId: json["accessories_id"],
        productId: json["product_id"],
        name: json["name"],
        sellingPrice: json["selling_price"],
        gst: json["gst"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "accessories_id": accessoriesId,
        "product_id": productId,
        "name": name,
        "selling_price": sellingPrice,
        "gst": gst,
        "created_at": createdAt.toIso8601String(),
      };
}

class ProductVariant {
  ProductVariant({
    this.productId,
    this.variantType,
    this.variantValue,
    this.tenantId,
    this.createdAt,
  });

  int productId;
  String variantType;
  String variantValue;
  int tenantId;
  DateTime createdAt;

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
        productId: json["product_id"],
        variantType: json["variant_type"],
        variantValue: json["variant_value"],
        tenantId: json["tenant_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "variant_type": variantType,
        "variant_value": variantValue,
        "tenant_id": tenantId,
        "created_at": createdAt.toIso8601String(),
      };
}

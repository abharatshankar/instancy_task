class SavedProduct {
  final String productName;
  final String unitPrice;
  int noOfUnits;
  String choosedColor = 'No Color';
  String choosedSize = 'No Size';
  int totalPrice;
  final int uniqueId;

  SavedProduct(
      {this.productName,
      this.unitPrice,
      this.noOfUnits,
      this.choosedColor,
      this.choosedSize,
      this.totalPrice,
      this.uniqueId});
}

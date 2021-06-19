import 'package:bot_toast/bot_toast.dart';
import 'package:instancy_task/screens/home/models/product_list_model.dart';
import 'package:instancy_task/utils/app_constants.dart';
import 'package:instancy_task/utils/util_methods.dart';
import 'package:http/http.dart' as http;

Future<ProductListModel> getProductList() async {
  try {
    // ToastService().showLoadingIndicator();
    var url = Uri.parse(AppConstants.PRODUCTS_LIST_URL);

    final response = await http.get(url);
    final productListModel = productListModelFromJson(response.body);
    // BotToast.closeAllLoading();
    return productListModel;
  } catch (error, stackTrace) {
    print('Exception: $error \n $stackTrace');
    // BotToast.closeAllLoading();
    return ProductListModel(error: true);
  }
}

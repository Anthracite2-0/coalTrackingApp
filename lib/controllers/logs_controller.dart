import 'package:coal_tracking_app/controllers/db_controller.dart';
import 'package:coal_tracking_app/models/logs_model.dart';
import 'package:get/get.dart';

class LogsController extends GetxController {
  final LocationDatabase _locationDB = LocationDatabase();
  RxList<String> allOrderIds = <String>[].obs;
  RxList<String> displayedOrderIds = <String>[].obs;
  RxList<LocationLogs> locations = <LocationLogs>[].obs;
  RxString selectedOrderId = ''.obs;
  int currentPage = 0;
  final int itemsPerPage = 6;

  @override
  void onInit() {
    super.onInit();
    fetchOrderIds();
  }

  Future<void> fetchOrderIds() async {
    List<String> orderIds = await _locationDB.getAllOrderIdsSortedByTimestamp();
    allOrderIds.value = orderIds;
    _displayPage(currentPage);
  }

  void _displayPage(int page) async {
    int startIndex = page * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    if (startIndex < allOrderIds.length) {
      displayedOrderIds.assignAll(allOrderIds.sublist(startIndex,
          endIndex > allOrderIds.length ? allOrderIds.length : endIndex));
      if (displayedOrderIds.isNotEmpty) {
        List<LocationLogs> logs =
            await _locationDB.getLocationsForOrder(displayedOrderIds.first);
        locations.assignAll(logs);
        selectedOrderId.value = displayedOrderIds.first;
      }
    }
    currentPage = page;
  }

  void onPageSelected(int page) {
    _displayPage(page);
  }

  Future<void> onOrderIdSelected(String orderId) async {
    List<LocationLogs> logs = await _locationDB.getLocationsForOrder(orderId);
    locations.assignAll(logs);
    selectedOrderId.value = orderId;
  }
}

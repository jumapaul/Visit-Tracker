import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:visit_tracker/app/data/model/activity_response.dart';
import 'package:visit_tracker/app/data/providers/api_providers.dart';
import 'package:visit_tracker/app/utils/resources/data_state.dart';

class ActivitiesController extends GetxController {
  TextEditingController searchActivityController = TextEditingController();
  final String customerId = Get.arguments['customerId'];
  ApiProviders apiProviders = ApiProviders();
  Rx<DataState<ActivityResponse>> activities = Rx(Initial());
  var cancelStatus = false.obs;
  var completeStatus = false.obs;

  Future<void> getCustomerActivities() async {
    activities.value = await apiProviders.getCustomerActivities(customerId);
  }

  Future<void> getSearchedActivities(String? activityName)async{
    activities.value = await apiProviders.searchActivity(activityName);
  }

  Future<void> cancelActivity(String customerId, String activityId) async {
    cancelStatus.value = true;
    var response = await apiProviders.updateActivity(activityId, "Cancelled");

    if (response?.data != null) {
      await getCustomerActivities();
      cancelStatus.value = false;
    } else {
      cancelStatus.value = false;
    }
  }

  Future<void> completeActivity(String customerId, String activityId) async {
    completeStatus.value = true;

    var response = await apiProviders.updateActivity(activityId, "Completed");

    if (response?.data != null) {
      await getCustomerActivities();
      completeStatus.value = false;
    } else {
      completeStatus.value = false;
    }
  }

  @override
  void onInit() {
    getCustomerActivities();
    super.onInit();
  }
}

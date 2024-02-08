import 'package:get/get.dart';

import '../../../../api/api.dart';

class FAQController extends GetxController {
  var gettingStartedArticles = ''.obs;
  var bookingChargesArticles = ''.obs;
  var deliveryAndReturnArticles = ''.obs;
  var depositsArticles = ''.obs;
  var evArticles = ''.obs;
  var insuranceArticles = ''.obs;
  var selfPickupANdReturnArticles = ''.obs;
  var vehicleAndEquipmentArticles = ''.obs;
  var verificationArticles = ''.obs;

  Rx<bool> loaded = false.obs;

  Future<void> fetchData() async {
    getGettingStartedArticles();
    getBookingChargesArticles();
    getDeliveryAndReturnArticles();
    getDepositsArticles();
    getElectricVehiclesArticles();
    getInsuranceArticles();
    getSelfPickupArticles();
    getVehiclesEquipmentsArticles();
    getVerificationArticles();

    print('before');
    Future.delayed(Duration(seconds: 2), () {
      loaded.value = true;
      print('after');
    });
    // state.loaded.value = true;
  }

  Future<List<Map<String, dynamic>>> getGettingStartedArticles() async {
    try {
      var querySnapshot = await APis.db.collection('gettingStarted').get();

      gettingStartedArticles.value = querySnapshot.docs.length.toString();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getBookingChargesArticles() async {
    try {
      var querySnapshot = await APis.db.collection('bookingChanges').get();

      bookingChargesArticles.value = querySnapshot.docs.length.toString();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getDeliveryAndReturnArticles() async {
    try {
      var querySnapshot = await APis.db.collection('deliveryReturn').get();

      deliveryAndReturnArticles.value = querySnapshot.docs.length.toString();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getDepositsArticles() async {
    try {
      var querySnapshot = await APis.db.collection('deposits').get();

      depositsArticles.value = querySnapshot.docs.length.toString();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getElectricVehiclesArticles() async {
    try {
      var querySnapshot = await APis.db.collection('electricVehicles').get();

      evArticles.value = querySnapshot.docs.length.toString();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getInsuranceArticles() async {
    try {
      var querySnapshot = await APis.db.collection('insurance').get();

      insuranceArticles.value = querySnapshot.docs.length.toString();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getVehiclesEquipmentsArticles() async {
    try {
      var querySnapshot = await APis.db.collection('vehiclesEquipments').get();

      vehicleAndEquipmentArticles.value = querySnapshot.docs.length.toString();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getVerificationArticles() async {
    try {
      var querySnapshot = await APis.db.collection('verification').get();

      verificationArticles.value = querySnapshot.docs.length.toString();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getSelfPickupArticles() async {
    try {
      var querySnapshot = await APis.db.collection('selfPickup').get();

      selfPickupANdReturnArticles.value = querySnapshot.docs.length.toString();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }
}

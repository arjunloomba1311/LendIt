import 'dart:math';
class Product {

  int? randomNumber;

  //generate a random locker number and location for the product if available
  int? generateRandomNumber(int? num) {
    Random random = new Random();
    randomNumber = random.nextInt(num!);
    return randomNumber;
  }

  int? getLockerNumber() {
    return locker_number;
  }

  String? getlocation() {
    return location;
  }

  String? getUserLentId() {
    return userLent;
  }

  String? getproductName() {
    return Name;
  }

  String? getDescription() {
    return description;
  }

  int? getPriceDay() {
    return priceDay;
  }

  final List<String> locations = ['location1', 'location2','location3'];
  final String? userLent;
  final String? Name;
  final String? description;
  final int? priceDay;
  int? locker_number;
  String? location;

  String? userBorrowed = '-1';

  Product(this.userLent,
      this.Name,
      this.description,
      this.priceDay,
      ) {

    locker_number = generateRandomNumber(21);
    int? rand = generateRandomNumber(3);
    location = locations[rand!];
  }
}
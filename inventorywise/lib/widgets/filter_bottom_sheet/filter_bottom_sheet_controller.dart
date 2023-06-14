import 'package:get/get.dart';

import 'package:InventoryWise/widgets/filter_bottom_sheet/filter_bottom_sheet.dart';

class FilterBottomSheetResponse {
  FilterBottomSheetResponse(
      {required this.hasData, this.storeType, this.categoryNames});

  final String? categoryNames;
  final StoreType? storeType;
  late final bool hasData;
}

class FilterBottomSheetController extends GetxController {
  Rx<StoreType> selectedStore = StoreType.none.obs;
  RxList<SelectedCategory> selectedCategories = [
    SelectedCategory(val: false, categoryName: 'Select All'),
    // SelectedCategory(val: false, categoryName: 'Activewear'),
    // SelectedCategory(val: false, categoryName: 'Fragrances'),
    // SelectedCategory(val: false, categoryName: 'Jewelry & Accessories'),
    // SelectedCategory(val: false, categoryName: 'Shoes'),
    // SelectedCategory(val: false, categoryName: 'Cosmetics'),
    // SelectedCategory(val: false, categoryName: 'Fitness'),
    // SelectedCategory(val: false, categoryName: 'Hair'),
  ].obs;
  @override
  void onInit() {

    super.onInit();
  }



  void onResetPressed() {
    selectedStore(StoreType.none);
    handleCategoryChanged(false, 0);
  }

  void handleCategoryChanged(bool val, int i) {
    switch (i) {
      case 0:
        for (int i = 0; i < selectedCategories.length; i++) {
          selectedCategories[i] = SelectedCategory(
              categoryName: selectedCategories[i].categoryName, val: val);
        }
        break;
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        selectedCategories[i] = SelectedCategory(
            categoryName: selectedCategories[i].categoryName, val: val);
        if (selectedCategories[0].val) {
          selectedCategories[0] = SelectedCategory(
              categoryName: selectedCategories[0].categoryName, val: false);
        } else {
          List<SelectedCategory> _selectedCategories =
              selectedCategories.toList();
          _selectedCategories.removeAt(0);
          bool allSelected =
              _selectedCategories.every((element) => (element.val));
          if (allSelected) {
            selectedCategories[0] = SelectedCategory(
                categoryName: selectedCategories[0].categoryName, val: val);
          }
        }
        break;
      default:
        for (int i = 0; i < selectedCategories.length; i++) {
          selectedCategories[i] = SelectedCategory(
              categoryName: selectedCategories[i].categoryName, val: false);
        }
    }
  }

  void onApplyFiltersPressed() {
    String categoryNames = _populateCategoryNames();
    // _applyFilters();
    Get.back<FilterBottomSheetResponse>(
        result: FilterBottomSheetResponse(
            hasData: true,
            storeType: selectedStore.value,
            categoryNames: categoryNames));
  }

  void onClosePressed() {
    // onResetPressed();
    Get.back<FilterBottomSheetResponse>(
        result: FilterBottomSheetResponse(hasData: false));
  }

  String _populateCategoryNames() {
    String categoryNames = '';
    List<SelectedCategory> trueCategories = selectedCategories.value
        .where((e) => (e.val && e.categoryName != 'Select All'))
        .toList();

    for (int i = 0; i < trueCategories.length; i++) {
      categoryNames += trueCategories[i].categoryName;
      if (i != trueCategories.length - 1) {
        categoryNames += ', ';
      }
    }
    return categoryNames;
  }

  void _applyFilters() {
    List<SelectedCategory> trueCategories = selectedCategories.value
        .where((e) => (e.val && e.categoryName != 'Select All'))
        .toList();
    //perform list filtering
  }
}

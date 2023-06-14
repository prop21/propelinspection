import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:InventoryWise/utils/app_theme.dart';
import 'package:InventoryWise/widgets/filter_bottom_sheet/filter_bottom_sheet_controller.dart';

enum StoreType { online, inStore, none }

class SelectedCategory {
  String categoryName;
  bool val;

  SelectedCategory({required this.categoryName, required this.val});
}

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key, this.listOfSubCategories})
      : super(key: key);
  final List<String?>? listOfSubCategories;

  @override
  Widget build(BuildContext context) {
    FilterBottomSheetController controller =
        Get.put(FilterBottomSheetController());
    return Obx(() {
      return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.white),
        height: MediaQuery.of(context).size.height * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'filters'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    child: Text('reset'.tr,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600)),
                    onPressed: () => controller.onResetPressed(),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Scrollbar(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.black,
                    ),
                    child: ListView(
                      // mainAxisSize: MainAxisSize.min,
                      // shrinkWrap: true,
                      children: [
                        Text(
                          'store_type'.tr,
                          style: TextStyle(color: AppTheme.greyColor),
                        ),
                        RadioListTile<StoreType>(
                            activeColor: AppTheme.primaryColor,
                            title: Text('online'.tr),
                            value: StoreType.online,
                            groupValue: controller.selectedStore.value,
                            onChanged: (val) => controller.selectedStore(val)),
                        RadioListTile<StoreType>(
                            activeColor: AppTheme.primaryColor,
                            title: Text('in_store'.tr),
                            value: StoreType.inStore,
                            groupValue: controller.selectedStore.value,
                            onChanged: (val) => controller.selectedStore(val)),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'categories_capital'.tr,
                          style: TextStyle(color: AppTheme.greyColor),
                        ),
                        CheckboxListTile(
                          activeColor: AppTheme.primaryColor,
                          title: Text('Select All'.tr),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: controller.selectedCategories[0].val,
                          onChanged: (val) =>
                              controller.handleCategoryChanged(val!, 0),
                        ),
                        ListView.builder(
                          itemCount: listOfSubCategories?.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => CheckboxListTile(
                            activeColor: AppTheme.primaryColor,
                            title: Text(listOfSubCategories![index]!.tr),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: controller.selectedCategories[index + 1].val,
                            onChanged: (val) => controller
                                .handleCategoryChanged(val!, index + 1),
                          ),
                        )
                        // CheckboxListTile(
                        //   activeColor: AppTheme.primaryColor,
                        //   title: Text('activewear'.tr),
                        //   controlAffinity: ListTileControlAffinity.leading,
                        //   value: controller.selectedCategories[1].val,
                        //   onChanged: (val) =>
                        //       controller.handleCategoryChanged(val!, 1),
                        // ),
                        // CheckboxListTile(
                        //   activeColor: AppTheme.primaryColor,
                        //   title: Text('fragrances'.tr),
                        //   controlAffinity: ListTileControlAffinity.leading,
                        //   value: controller.selectedCategories[2].val,
                        //   onChanged: (val) =>
                        //       controller.handleCategoryChanged(val!, 2),
                        // ),
                        // CheckboxListTile(
                        //   activeColor: AppTheme.primaryColor,
                        //   title: Text('jewelry_and_accessories'.tr),
                        //   controlAffinity: ListTileControlAffinity.leading,
                        //   value: controller.selectedCategories[3].val,
                        //   onChanged: (val) =>
                        //       controller.handleCategoryChanged(val!, 3),
                        // ),
                        // CheckboxListTile(
                        //   activeColor: AppTheme.primaryColor,
                        //   title: Text('shoes'.tr),
                        //   controlAffinity: ListTileControlAffinity.leading,
                        //   value: controller.selectedCategories[4].val,
                        //   onChanged: (val) =>
                        //       controller.handleCategoryChanged(val!, 4),
                        // ),
                        // CheckboxListTile(
                        //   activeColor: AppTheme.primaryColor,
                        //   title: Text('cosmetics'.tr),
                        //   controlAffinity: ListTileControlAffinity.leading,
                        //   value: controller.selectedCategories[5].val,
                        //   onChanged: (val) =>
                        //       controller.handleCategoryChanged(val!, 5),
                        // ),
                        // CheckboxListTile(
                        //   activeColor: AppTheme.primaryColor,
                        //   title: Text('fitness'.tr),
                        //   controlAffinity: ListTileControlAffinity.leading,
                        //   value: controller.selectedCategories[6].val,
                        //   onChanged: (val) =>
                        //       controller.handleCategoryChanged(val!, 6),
                        // ),
                        // CheckboxListTile(
                        //   activeColor: AppTheme.primaryColor,
                        //   title: Text('hair'.tr),
                        //   controlAffinity: ListTileControlAffinity.leading,
                        //   value: controller.selectedCategories[7].val,
                        //   onChanged: (val) =>
                        //       controller.handleCategoryChanged(val!, 7),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              // const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, bottom: 20, right: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: controller.onClosePressed,
                        child: Text(
                          'close'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () => controller.onApplyFiltersPressed(),
                        child: Text(
                          'apply_filters'.tr,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

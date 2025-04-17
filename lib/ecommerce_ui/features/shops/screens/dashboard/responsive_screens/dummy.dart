// import 'package:data_table_2/data_table_2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:minimal_flutter_app/commons/widgets/data_table/paginated_data_table.dart';
// import 'package:minimal_flutter_app/utils/constants/sizes.dart';

// class DashboardDesktopScreen extends StatelessWidget {
//   const DashboardDesktopScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(DashboardController());
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(30),
//         child: Center(
//             child: Column(children: [
//           TextFormField(
//             decoration: const InputDecoration(
//                 hintText: 'Search', prefixIcon: Icon(Iconsax.search_normal)),
//           ),
//           const SizedBox(
//             height: AppSizes.spaceBtwSections,
//           ),
//           Obx(() {
//             //
//             const Visibility(
//               visible: false,
//               child: Text('Filtered'),
//             );
//             return AppPaginatedDataTable(
//                 // columnSpacing: 12,
//                 // minWidth: 786,
//                 // dividerThickness: 0,
//                 // horizontalMargin: 12,
//                 // dataRowHeight: 56,
//                 // rowsPerPage: 10,
//                 // headingTextStyle: Theme.of(context).textTheme.titleMedium,
//                 // headingRowColor: WidgetStateProperty.resolveWith(
//                 //   (states) => AppColors.primaryBackground,
//                 // ),
//                 // headingRowDecoration: const BoxDecoration(
//                 //     borderRadius: BorderRadius.only(
//                 //         topLeft: Radius.circular(AppSizes.borderRadiusMd),
//                 //         topRight:
//                 //             Radius.circular(AppSizes.borderRadiusMd))),
//                 // // check box column
//                 // showCheckboxColumn: true,
//                 // // Pagination
//                 // showFirstLastButtons: true,
//                 // onPageChanged: (value) {},
//                 // renderEmptyRowsInTheEnd: false,
//                 // onRowsPerPageChanged: (noOfRows) {},

//                 // Sorting
//                 sortAscending: controller.sortAscending.value,
//                 // sortArrowAlwaysVisible: true,
//                 sortColumnIndex: controller.sortColumnIndex.value,
//                 // sortArrowBuilder: (bool ascending, bool sorted) {
//                 //   if (sorted) {
//                 //     return Icon(
//                 //       ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
//                 //       size: AppSizes.iconSm,
//                 //     );
//                 //   } else {
//                 //     return const Icon(
//                 //       Iconsax.arrow_3,
//                 //       size: AppSizes.iconSm,
//                 //     );
//                 //   }
//                 // },
//                 columns: [
//                   const DataColumn2(label: Text('Column 1')),
//                   DataColumn2(
//                     label: const Text('Column 2'),
//                     onSort: (columnIndex, ascending) =>
//                         {controller.sortById(columnIndex, ascending)},
//                   ),
//                   const DataColumn2(label: Text('Column 3')),
//                   DataColumn2(
//                       label: const Text('Column 4'),
//                       onSort: (columnIndex, ascending) =>
//                           {controller.sortById(columnIndex, ascending)}),
//                 ],
//                 source: MyData());
//           }),
//         ])),
//       ),
//     );
//   }
// }

// class MyData extends DataTableSource {
//   final DashboardController controller = Get.put(DashboardController());
//   @override
//   DataRow? getRow(int index) {
//     final data = controller.dataList[index];
//     return DataRow2(
//         onTap: () {},
//         selected: controller.selectedRows[index],
//         onSelectChanged: (value) =>
//             controller.selectedRows[index] = value ?? false,
//         cells: [
//           DataCell(Text(data['Column 1'] ?? "")),
//           DataCell(Text(data['Column 2'] ?? "")),
//           DataCell(Text(data['Column 3'] ?? "")),
//           DataCell(Text(data['Column 4'] ?? "")),
//         ]);
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => controller.dataList.length;

//   @override
//   // TODO: implement selectedRowCount
//   int get selectedRowCount => 0;
// }

// class DashboardController extends GetxController {
//   var dataList = <Map<String, String>>[].obs;
//   RxList<bool> selectedRows = <bool>[].obs;

//   RxInt sortColumnIndex = 1.obs;
//   RxBool sortAscending = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchDummyData();
//   }

//   void sortById(int sortColumnIndex, bool ascending) {
//     sortAscending.value = ascending;
//   }

//   void fetchDummyData() {
//     selectedRows.assignAll(List.generate(36, (index) => false));
//     dataList.addAll(List.generate(
//         36,
//         (index) => {
//               'Column 1': 'Data ${index + 1} -1',
//               'Column 2': 'Data ${index + 1} -2',
//               'Column 3': 'Data ${index + 1} -3',
//               'Column 4': 'Data ${index + 1} -4',
//             }));
//   }
// }

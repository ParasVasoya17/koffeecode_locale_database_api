import '../utils/all_imports.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  String? title;
  final String hintText;
  final List<String> items;
  final Function(String?)? onChanged;

  CustomDropdown({
    Key? key,
    required this.value,
    this.title = "",
    required this.hintText,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title ?? "",
          fontSize: 16.sp,
          fontFamily: FontFamily.regular,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
        5.verticalSpace,
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: Colors.grey, width: 1), // Full border
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            hint: Text(hintText),
            icon: const Icon(Icons.arrow_drop_down),
            underline: const SizedBox(),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            focusColor: AppColors.white,
            onChanged: onChanged,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

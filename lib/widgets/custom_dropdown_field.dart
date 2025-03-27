import 'package:flutter/material.dart';
import 'package:meri_sadak/providerData/permission_provider.dart';
import '../../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class CustomDropdownField extends StatefulWidget {
  final TextEditingController? textController;
  final String? hintText;
  final List<String>? items;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final TextStyle? dropdownTextStyle;
  final IconData? suffixIcon;
  final double? dropdownHeight;
  final Color? dropdownBgColor;
  final InputBorder? textFieldBorder;
  final EdgeInsetsGeometry? contentPadding;
  final bool isRequired;
  final Color textColor;
  final Color boxBgColor;
  final Function(String)? onChanged;
  final PermissionProvider? permissionProvider;

  const CustomDropdownField({
    super.key,
    required this.textController,
    this.hintText,
    required this.items,
    this.hintStyle,
    this.style,
    this.dropdownTextStyle,
    this.suffixIcon,
    this.dropdownHeight,
    this.dropdownBgColor,
    this.textFieldBorder,
    this.contentPadding,
    required this.isRequired,
    this.onChanged,
    this.textColor = AppColors.black,
    this.boxBgColor = AppColors.black,
    this.permissionProvider,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownField();
}

class _CustomDropdownField extends State<CustomDropdownField> {
  bool _isTapped = false; // Used to show or hide the dropdown
  List<String> _filteredList = [];
  List<String> _subFilteredList = [];
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _filteredList = widget.items!;
    _subFilteredList = _filteredList;

    // Add listener to focus node to control keyboard behavior
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _isTapped = false; // Hide dropdown when focus is lost
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isRequired == true
            ? Text(
              "*",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            )
            : SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.di_12),
          child: Container(
            padding: const EdgeInsets.only(
              left: AppDimensions.di_5,
              right: AppDimensions.di_5,
            ),
            height: 50,
            decoration: BoxDecoration(
              color: widget.boxBgColor,
              borderRadius: BorderRadius.circular(AppDimensions.di_5),
              border: Border.all(
                color: AppColors.textFieldBorderColor, // First border color
                width: AppDimensions.di_1,
              ),
            ),
            child: TextFormField(
              controller: widget.textController,
              focusNode: _focusNode,
              onChanged: (val) {
                setState(() {
                  _filteredList =
                      _subFilteredList
                          .where(
                            (element) => element.toLowerCase().contains(
                              val.toLowerCase(),
                            ),
                          )
                          .toList();
                  // Show dropdown when text is entered
                  _isTapped = val.isNotEmpty;
                });
              },
              validator: (val) => val!.isEmpty ? 'Field can\'t be empty' : null,
              style:
                  widget.style ??
                  TextStyle(
                    color: widget.textColor,
                    fontSize: AppDimensions.di_16,
                  ),
              onTap: () {
                setState(() {
                  _isTapped = true; // Show dropdown when tapped
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(color: widget.textColor.withAlpha(95)),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      _isTapped = !_isTapped; // Toggle dropdown visibility
                    });
                  },
                  child: Icon(
                    _isTapped
                        ? Icons.keyboard_arrow_up_outlined
                        : Icons.keyboard_arrow_down_outlined,
                    size: AppDimensions.di_25,
                  ),
                ),
                suffixIconConstraints: BoxConstraints.loose(
                  MediaQuery.of(context).size,
                ),
                // Show the clear icon only when the text field is not empty
                suffix:
                    widget.textController!.text.isNotEmpty
                        ? InkWell(
                          onTap: () {
                            widget.permissionProvider?.isLocationFetched =
                                false;
                            widget.textController!.clear();
                            setState(() {
                              widget.onChanged?.call('');
                              _filteredList = widget.items!;
                            });
                          },
                          child: const Icon(Icons.clear, color: Colors.grey),
                        )
                        : null,
              ),
            ),
          ),
        ),
        // Dropdown Items
        _isTapped && _filteredList.isNotEmpty
            ? Container(
              height: widget.dropdownHeight ?? AppDimensions.di_150,
              color: widget.dropdownBgColor ?? Colors.grey.shade200,
              padding: const EdgeInsets.only(
                left: AppDimensions.di_12,
                right: AppDimensions.di_8,
              ),
              child: ListView.builder(
                itemCount: _filteredList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _isTapped =
                            false; // Close dropdown when item is selected
                        widget.textController!.text =
                            _filteredList[index]; // Set the selected item
                        widget.onChanged?.call(widget.textController!.text);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppDimensions.di_8,
                      ),
                      child: Text(
                        _filteredList[index],
                        style:
                            widget.dropdownTextStyle ??
                            TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: AppDimensions.di_16,
                            ),
                      ),
                    ),
                  );
                },
              ),
            )
            : SizedBox.shrink(),
      ],
    );
  }
}

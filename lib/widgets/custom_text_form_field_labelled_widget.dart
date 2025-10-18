import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class CustomTextFormFieldLabelledWidget extends StatelessWidget {
  const CustomTextFormFieldLabelledWidget({
    super.key,
    required this.label,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.showLabel = true,
    this.prefixIcon,
    this.suffixIcon,
    this.enableDateInput = false,
    this.enableRangeInput = false,
    this.rangeMinValue = 0,
    this.rangeMaxValue = 100,
    this.rangeDivisions,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool showLabel;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enableDateInput;

  // Range input parameters
  final bool enableRangeInput;
  final double rangeMinValue;
  final double rangeMaxValue;
  final int? rangeDivisions;

  String? _validateNumberInput(String? value) {
    if (textInputType == TextInputType.number &&
        value != null &&
        value.isNotEmpty) {
      final isNumber = double.tryParse(value) != null;
      if (!isNumber) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.text = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        });
        return 'Hanya angka yang diperbolehkan';
      }
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  Future<void> _selectRange(BuildContext context) async {
    double start = rangeMinValue;
    double end = rangeMaxValue;

    // Try parse existing controller value to set initial range
    final current = controller.text.trim();
    if (current.contains('-')) {
      final parts = current.split('-');
      if (parts.length == 2) {
        final p0 = double.tryParse(parts[0]);
        final p1 = double.tryParse(parts[1]);
        if (p0 != null && p1 != null) {
          start = p0.clamp(rangeMinValue, rangeMaxValue);
          end = p1.clamp(rangeMinValue, rangeMaxValue);
        }
      }
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets +
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: LayoutBuilder(builder: (context, constraints) {
              final rangeSpan = (rangeMaxValue - rangeMinValue);
              double fracStart =
                  rangeSpan > 0 ? (start - rangeMinValue) / rangeSpan : 0.0;
              double fracEnd =
                  rangeSpan > 0 ? (end - rangeMinValue) / rangeSpan : 1.0;
              final alignXStart = (-1.0 + 2.0 * fracStart).clamp(-1.0, 1.0);
              final alignXEnd = (-1.0 + 2.0 * fracEnd).clamp(-1.0, 1.0);

              Widget buildTooltipText(String text) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    text,
                    style:
                        primaryTextStyle.copyWith(color: white, fontSize: 12),
                  ),
                );
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: secondaryTextStyle.copyWith(fontWeight: bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 28),
                          child: RangeSlider(
                            min: rangeMinValue,
                            max: rangeMaxValue,
                            divisions: rangeDivisions,
                            labels: RangeLabels(
                              start.toInt().toString(),
                              end.toInt().toString(),
                            ),
                            values: RangeValues(start, end),
                            onChanged: (values) {
                              setState(() {
                                start = values.start;
                                end = values.end;
                                if (rangeDivisions == null) {
                                  start = start.roundToDouble();
                                  end = end.roundToDouble();
                                }
                              });
                            },
                            activeColor: primaryColor,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: SizedBox(
                            height: 28,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment(alignXStart, 0),
                                  child: buildTooltipText(
                                      start.toInt().toString()),
                                ),
                                Align(
                                  alignment: Alignment(alignXEnd, 0),
                                  child:
                                      buildTooltipText(end.toInt().toString()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Reset button: clears controller and resets sliders, then closes sheet
                      TextButton(
                        onPressed: () {
                          setState(() {
                            start = rangeMinValue;
                            end = rangeMaxValue;
                            controller.text = '';
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('Reset'),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          final minVal = start.toInt();
                          final maxVal = end.toInt();
                          controller.text = '$minVal-$maxVal';
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ],
              );
            }),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: showLabel,
            child: Text(
              label,
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
              ),
            ),
          ),
          Visibility(
            visible: showLabel,
            child: const SizedBox(
              height: 10,
            ),
          ),
          TextFormField(
            cursorColor: primaryColor,
            controller: controller,
            keyboardType: enableDateInput
                ? TextInputType.none
                : (enableRangeInput ? TextInputType.none : textInputType),
            validator: _validateNumberInput,
            readOnly: enableDateInput || enableRangeInput,
            onTap: enableDateInput
                ? () => _selectDate(context)
                : (enableRangeInput ? () => _selectRange(context) : null),
            style: secondaryTextStyle.copyWith(
              fontSize: 14,
            ),
            inputFormatters: (textInputType == TextInputType.number &&
                    !enableDateInput &&
                    !enableRangeInput)
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ]
                : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: white,
              hintText: label,
              hintStyle: primaryTextStyle.copyWith(
                color: Colors.grey[400],
                fontStyle: FontStyle.normal,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: black),
              ),
              prefixIcon: prefixIcon is SizedBox &&
                      (prefixIcon as SizedBox).width == 0.0 &&
                      (prefixIcon as SizedBox).height == 0.0
                  ? null
                  : prefixIcon,
              suffixIcon: suffixIcon is SizedBox &&
                      (suffixIcon as SizedBox).width == 0.0 &&
                      (suffixIcon as SizedBox).height == 0.0
                  ? null
                  : suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}

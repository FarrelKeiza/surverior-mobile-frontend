import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class CustomSearchableDropdownWidget<T> extends HookWidget {
  const CustomSearchableDropdownWidget({
    super.key,
    required this.label,
    this.showLabel = true,
    this.prefixIcon,
    this.suffixIcon,
    this.value,
    this.paddingBottom = 20,
    required this.items,
    required this.onChanged,
    required this.displayText,
    required this.searchFilter,
    this.emptyMessage = 'No items found',
    this.maxDropdownHeight = 200,
  });

  final String label;
  final bool showLabel;
  final Widget? prefixIcon, suffixIcon;
  final List<T> items;
  final T? value;
  final Function(T?)? onChanged;
  final double paddingBottom;
  final String Function(T item) displayText;
  final bool Function(T item, String query) searchFilter;
  final String emptyMessage;
  final double maxDropdownHeight;

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final focusNode = useFocusNode();
    final isDropdownVisible = useState<bool>(false);
    final filteredItems = useState<List<T>>(items);
    final overlayEntry = useRef<OverlayEntry?>(null);

    // Update text field when value changes externally
    useEffect(() {
      if (value != null) {
        textController.text = displayText(value!);
      } else {
        textController.text = '';
      }
      return null;
    }, [value]);

    // Filter items based on text input
    useEffect(() {
      void onTextChanged() {
        final query = textController.text.toLowerCase();
        if (query.isEmpty) {
          filteredItems.value = items;
        } else {
          filteredItems.value =
              items.where((item) => searchFilter(item, query)).toList();
        }
      }

      textController.addListener(onTextChanged);
      return () => textController.removeListener(onTextChanged);
    }, [textController]);

    // --- Move selectItem declaration above useEffect so it can be referenced ---
    void selectItem(T? item) {
      if (item != null) {
        textController.text = displayText(item);
        onChanged?.call(item);
      } else {
        textController.text = '';
        onChanged?.call(null);
      }
      focusNode.unfocus();
    }

    // Handle focus changes and overlay
    useEffect(() {
      void _showDropdown(
        BuildContext context,
        ObjectRef<OverlayEntry?> overlayEntryRef,
        ValueNotifier<List<T>> filteredItemsNotifier,
        TextEditingController controller,
        FocusNode focus,
      ) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox == null) return;

        final position = renderBox.localToGlobal(Offset.zero);
        final size = renderBox.size;

        overlayEntryRef.value = OverlayEntry(
          builder: (context) => Positioned(
            left: position.dx,
            top: position.dy + size.height,
            width: size.width,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                constraints: BoxConstraints(maxHeight: maxDropdownHeight),
                decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ValueListenableBuilder<List<T>>(
                  valueListenable: filteredItemsNotifier,
                  builder: (context, items, child) {
                    if (items.isEmpty) {
                      return Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          emptyMessage,
                          style: primaryTextStyle.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      );
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Clear option
                        ListTile(
                          dense: true,
                          leading: const Icon(Icons.clear,
                              color: Colors.red, size: 20),
                          title: Text(
                            'Clear selection',
                            style: secondaryTextStyle.copyWith(fontSize: 14),
                          ),
                          onTap: () => selectItem(null),
                        ),
                        if (items.isNotEmpty) const Divider(height: 1),
                        // Items list
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              final isSelected = item == value;
                              return ListTile(
                                dense: true,
                                title: Text(
                                  displayText(item),
                                  style: secondaryTextStyle.copyWith(
                                    fontWeight:
                                        isSelected ? bold : FontWeight.normal,
                                    color: isSelected ? primaryColor : null,
                                    fontSize: 14,
                                  ),
                                ),
                                trailing: isSelected
                                    ? Icon(
                                        Icons.check,
                                        color: primaryColor,
                                        size: 20,
                                      )
                                    : null,
                                onTap: () => selectItem(item),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );

        Overlay.of(context).insert(overlayEntryRef.value!);
      }

      void _hideDropdown(ObjectRef<OverlayEntry?> overlayEntryRef) {
        overlayEntryRef.value?.remove();
        overlayEntryRef.value = null;
      }

      void onFocusChanged() {
        if (focusNode.hasFocus) {
          _showDropdown(
              context, overlayEntry, filteredItems, textController, focusNode);
          isDropdownVisible.value = true;
        } else {
          _hideDropdown(overlayEntry);
          isDropdownVisible.value = false;
        }
      }

      focusNode.addListener(onFocusChanged);
      return () {
        focusNode.removeListener(onFocusChanged);
        _hideDropdown(overlayEntry);
      };
    }, [focusNode, filteredItems, textController, maxDropdownHeight, value]);

    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
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
            child: const SizedBox(height: 10),
          ),
          TextField(
            controller: textController,
            focusNode: focusNode,
            style: secondaryTextStyle.copyWith(fontSize: 14),
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
                borderSide: BorderSide(color: primaryColor),
              ),
              prefixIcon: prefixIcon != null &&
                      !(prefixIcon is SizedBox &&
                          (prefixIcon as SizedBox).width == 0.0 &&
                          (prefixIcon as SizedBox).height == 0.0)
                  ? prefixIcon
                  : null,
              suffixIcon: suffixIcon != null &&
                      !(suffixIcon is SizedBox &&
                          (suffixIcon as SizedBox).width == 0.0 &&
                          (suffixIcon as SizedBox).height == 0.0)
                  ? suffixIcon
                  : Icon(
                      isDropdownVisible.value
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: black,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

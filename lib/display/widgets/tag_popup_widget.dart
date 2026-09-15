// Popup tag
import 'package:flutter/material.dart';
import 'package:product_search_demo/helper/tags_reference.dart';

// Class for tag popup
class TagPopupWidget extends StatefulWidget {
  final List<String> selectedTags;
  final Function(List<String>) onSave;

  // Constructor
  const TagPopupWidget({
    super.key,
    required this.selectedTags,
    required this.onSave,
  });

  @override
  State<TagPopupWidget> createState() => _TagPopupWidgetState();
}

class _TagPopupWidgetState extends State<TagPopupWidget> {
  // Track tags selected as temp
  late List<String> tempSelected;

  @override
  void initState() {
    super.initState();
    // Make a copy so changes aren't applied until Save
    tempSelected = List.from(widget.selectedTags);
  }

  // Call all the tags
  List<TagsReference> allTags() {
    return TagsReference.values;
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Select Tags',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // Display selected tag count
          const SizedBox(height: 4),
          Text(
            'Selected ${tempSelected.length}',
            style: const TextStyle(fontSize: 13, color: Colors.red),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: Column(
          children: [
            // Quick action
            Row(
              children: [
                // Add all tag
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      tempSelected
                        ..clear()
                        ..addAll(TagsReference.values.map((tag) => tag.displayTags));
                    });
                  },
                  icon: const Icon(Icons.select_all, size: 18),
                  label: const Text('Select All'),
                ),
                // Clear all tag
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      tempSelected.clear();
                    });
                  },
                  icon: const Icon(Icons.clear, size: 18),
                  label: const Text('Clear All'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Grid showing all tag
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.start,
                  children: allTags().map((tag){
                    final tagName = tag.displayTags;
                    final isSelected = tempSelected.contains(tagName);
                    // How tags are display
                    return ChoiceChip(
                      label: Text(tagName),
                      selected: isSelected,
                      onSelected: (selected){
                        setState(() {
                          // Check and update tags once selected or deselected
                          if(selected){
                            tempSelected.add(tagName);
                          } else {
                            tempSelected.remove(tagName);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      // On save button
      actions: [
        TextButton(
          onPressed: (){
            widget.onSave(tempSelected);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        )
      ],
    );
  }
}


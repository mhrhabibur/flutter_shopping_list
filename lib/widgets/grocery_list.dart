import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/model/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) {
          return NewItem();
        },
      ),
    );

    if (newItem == null) {
      return;
    }
    setState(() {
      groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text('No items added yet.'));

    if (groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: groceryItems.length,

        itemBuilder:
            (context, index) => Dismissible(
              key: ValueKey(groceryItems[index].id),

              onDismissed: (direction) {
                _removeItem(groceryItems[index]);
              },
              child: ListTile(
                title: Text(groceryItems[index].name),
                leading: Container(
                  width: 24,
                  height: 24,
                  color: groceryItems[index].category.color,
                ),
                trailing: Text(groceryItems[index].quantity.toString()),
              ),
            ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Grocery'),
        actions: [IconButton(onPressed: _addItem, icon: Icon(Icons.add))],
      ),
      body: content,
    );
  }
}

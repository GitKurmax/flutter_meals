import 'package:flutter/material.dart';
import 'package:meals/widgets/drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  void Function(Map<String, bool> filterData) saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactoseFree = false;

  @override
  initState() {
    setState(() {
      if (widget.currentFilters['gluten'] != null) {
        _glutenFree = widget.currentFilters['gluten']!;
      }
      if (_vegan = widget.currentFilters['vegan'] != null) {
        _vegan = widget.currentFilters['vegan']!;
      }
      if (_vegetarian = widget.currentFilters['vegetarian'] != null) {
        _vegetarian = widget.currentFilters['vegetarian'] !;
      }
      if (_lactoseFree = widget.currentFilters['lactose'] != null) {
        _lactoseFree = widget.currentFilters['lactose']!;
      }
    });
    super.initState();
  }

  Widget _buildWidgetTile(String title, String description, bool currentValue,
      void Function(bool) updateValue) {
    return SwitchListTile(
        title: Text(title),
        activeColor: Theme.of(context).colorScheme.secondary,
        value: currentValue,
        subtitle: Text(description),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: [
            IconButton(
                onPressed: () => widget.saveFilters({
                      'gluten': _glutenFree,
                      'lactose': _lactoseFree,
                      'vegan': _vegan,
                      'vegetarian': _vegetarian,
                    }),
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildWidgetTile('Gluten-free',
                    'Only include gluten-free meals.', _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                _buildWidgetTile('Vegan', 'Only include vegan meals.', _vegan,
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                _buildWidgetTile(
                    'Vegetarian', 'Only include vegetarian meals.', _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                _buildWidgetTile(
                    'Lactose-free',
                    'Only include lactose-free meals.',
                    _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                })
              ],
            ))
          ],
        ));
  }
}

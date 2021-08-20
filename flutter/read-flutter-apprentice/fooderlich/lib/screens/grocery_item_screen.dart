import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fooderlich/components/grocery_tile.dart';
import 'package:fooderlich/models/models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating;

  const GroceryItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _GroceryItemScreenState createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final _headerStyle = GoogleFonts.lato(fontSize: 20);

  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime? _dueDate = DateTime.now();
  TimeOfDay? _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final item = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _name,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate!.year,
                  _dueDate!.month,
                  _dueDate!.day,
                  _timeOfDay!.hour,
                  _timeOfDay!.minute,
                ),
              );

              if (widget.isUpdating) {
                widget.onUpdate(item);
              } else {
                widget.onCreate(item);
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
        elevation: 0.0,
        title: Text(
          'Grocery Item',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            buildDateField(context),
            buildTimeField(context),
            buildColorPicker(context),
            buildQuantityField(context),
            const SizedBox(height: 16),
            GroceryTile(
              item: GroceryItem(
                name: _name,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(_dueDate!.year, _dueDate!.month, _dueDate!.day,
                    _timeOfDay!.hour, _timeOfDay!.minute),
              ),
              onComplete: (item) {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.originalItem != null) {
      _nameController.text = widget.originalItem!.name;
      _name = widget.originalItem!.name;
      _currentSliderValue = widget.originalItem!.quantity;
      _importance = widget.originalItem!.importance;
      _currentColor = widget.originalItem!.color;
      final date = widget.originalItem!.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });

    super.initState();
  }

  buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Item Name', style: _headerStyle),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'E.g Apples, Bananas, 1 bag of salt',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        ),
      ],
    );
  }

  buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Importance', style: _headerStyle),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
              selectedColor: _currentColor,
              label: const Text(
                'low',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.low,
              onSelected: (_) => setState(() => _importance = Importance.low),
            ),
            ChoiceChip(
              selectedColor: _currentColor,
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.medium,
              onSelected: (_) =>
                  setState(() => _importance = Importance.medium),
            ),
            ChoiceChip(
              selectedColor: _currentColor,
              label: const Text(
                'high',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.high,
              onSelected: (_) => setState(() => _importance = Importance.high),
            ),
          ],
        )
      ],
    );
  }

  buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Date', style: _headerStyle),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final now = DateTime.now();
                final selected = await showDatePicker(
                  context: context,
                  initialDate: now,
                  firstDate: now,
                  lastDate: DateTime(now.year + 5),
                );

                setState(() {
                  _dueDate = selected;
                });
              },
            ),
          ],
        ),
        if (_dueDate != null)
          Text('${DateFormat('yyyy-MM-dd').format(_dueDate!)}'),
      ],
    );
  }

  buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Time of Day', style: _headerStyle),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final now = TimeOfDay.now();
                final selected = await showTimePicker(
                  context: context,
                  initialTime: now,
                );

                setState(() {
                  _timeOfDay = selected;
                });
              },
            ),
          ],
        ),
        if (_timeOfDay != null) Text('${_timeOfDay!.format(context)}'),
      ],
    );
  }

  buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(height: 40.0, width: 10.0, color: _currentColor),
            const SizedBox(width: 8.0),
            Text('Color', style: _headerStyle),
          ],
        ),
        TextButton(
          child: const Text('Select'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: BlockPicker(
                    pickerColor: Colors.white,
                    onColorChanged: (c) {
                      setState(() {
                        _currentColor = c;
                      });
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Save'),
                    )
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  buildQuantityField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Quantity', style: _headerStyle),
            const SizedBox(width: 16),
            Text(_currentSliderValue.toInt().toString(), style: _headerStyle),
          ],
        ),
        Slider(
          min: 0,
          max: 100,
          inactiveColor: _currentColor.withOpacity(0.5),
          activeColor: _currentColor,
          divisions: 100,
          onChanged: (v) {
            setState(() {
              _currentSliderValue = v.toInt();
            });
          },
          value: _currentSliderValue.toDouble(),
        ),
      ],
    );
  }
}

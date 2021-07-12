import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fooderlich/components/grocery_tile.dart';
import 'package:fooderlich/models/models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class GroceryItemScreen extends StatefulWidget {
  GroceryItemScreen({
    Key? key,
    this.index,
    this.onCreate,
    this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  final int? index;
  final Function(GroceryItem)? onCreate;
  final Function(GroceryItem, int)? onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating;

  static MaterialPage page(
      {GroceryItem? item,
      int? index,
      Function(GroceryItem)? onCreate,
      Function(GroceryItem, int)? onUpdate}) {
    return MaterialPage(
      name: FooderlichPages.groceryItemDetails,
      key: ValueKey(FooderlichPages.groceryItemDetails),
      child: GroceryItemScreen(
        originalItem: item,
        index: index,
        onCreate: onCreate,
        onUpdate: onUpdate,
      ),
    );
  }

  @override
  _GroceryItemScreenState createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  void initState() {
    if (widget.originalItem != null) {
      _nameController.text = widget.originalItem!.name;
      _name = widget.originalItem!.name;
      _currentSliderValue = widget.originalItem!.quantity;
      _importance = widget.originalItem!.importance;
      _currentColor = widget.originalItem!.color;
      final DateTime date = widget.originalItem!.date;
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

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              );

              if (widget.isUpdating) {
                widget.onUpdate!(groceryItem, widget.index!);
              } else {
                widget.onCreate!(groceryItem);
              }
            },
          ),
        ],
        elevation: 3.0,
        title: Text(
          'GroceryItem',
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
            buildQuantityField(),
            const SizedBox(height: 16),
            GroceryTile(
              item: GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _name,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              ),
              onComplete: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'E.g. Apples, Banana, 1 Bag of salt',
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

  Widget buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.low,
              label: const Text('low', style: TextStyle(color: Colors.white)),
              onSelected: (selected) {
                setState(() => _importance = Importance.low);
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.medium,
              label:
                  const Text('medium', style: TextStyle(color: Colors.white)),
              onSelected: (selected) {
                setState(() => _importance = Importance.medium);
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.high,
              label: const Text('high', style: TextStyle(color: Colors.white)),
              onSelected: (selected) {
                setState(() => _importance = Importance.high);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: currentDate,
                    lastDate: DateTime(currentDate.year + 5));
                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
            ),
          ],
        ),
        Text('${DateFormat('yyyy-MM-dd').format(_dueDate)}'),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of Day',
              style: GoogleFonts.lato(fontSize: 28),
            ),
            TextButton(
              child: const Text('select'),
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                setState(() {
                  if (timeOfDay != null) {
                    _timeOfDay = timeOfDay;
                  }
                });
              },
            ),
          ],
        ),
        if (_timeOfDay != null) Text('${_timeOfDay.format(context)}'),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50.0,
              width: 10.0,
              color: _currentColor,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Color',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
          ],
        ),
        TextButton(
          child: const Text('Select'),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: BlockPicker(
                        pickerColor: Colors.white,
                        onColorChanged: (color) {
                          setState(() => _currentColor = color);
                        }),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Save'),
                      )
                    ],
                  );
                });
          },
        ),
      ],
    );
  }

  Widget buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            const SizedBox(width: 16),
            Text(
              '$_currentSliderValue',
              style: GoogleFonts.lato(fontSize: 18.0),
            ),
          ],
        ),
        Slider(
          activeColor: _currentColor,
          inactiveColor: _currentColor.withOpacity(0.5),
          value: _currentSliderValue.toDouble(),
          min: 0,
          max: 100,
          label: _currentSliderValue.toString(),
          divisions: 100,
          onChanged: (double value) {
            setState(() => _currentSliderValue = value.toInt());
          },
        )
      ],
    );
  }
}

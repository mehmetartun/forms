# Forms in Flutter

This project is a tutorial on Flutter Forms together with best practices 
for editing objects, creating custom `FormField` widgets and expooring 
some of the things to pay attention to when dealing with forms.

# Contents
1. [Tag 1.0.0](https://github.com/mehmetartun/forms/tree/1.0.0) Start - empty Flutter project
2. [Tag 2.0.0](https://github.com/mehmetartun/forms/tree/2.0.0) Implement simple **TextFormField**
3. [Tag 3.0.0](https://github.com/mehmetartun/forms/tree/3.0.0) Implement a **DropdownButtonFormField**
4. [Tag 4.0.0](https://github.com/mehmetartun/forms/tree/4.0.0) Using `enum` classes
5. [Tag 5.0.0](https://github.com/mehmetartun/forms/tree/5.0.0) Creating a custom form field


## Tag 5.0.0

The `FormField` widget can be extended to be used with custom data types such as images, files, etc. 
In this example we implement a form field to pick a date using the `DatePicker` widget of the `material.dart` library.

### Extension on the FormField<T>

The first part of the task is to create an extension to the `FormField<T>` class which implements methods like `onSaved()` and `validator()` along with `initialValue` parameter. This is achieved by creating a class called `DateFormField` with one addition of a the `dateFormat` property that specifies how the `DateTime` object is displayed.
```dart
class DateFormField extends FormField<DateTime> {
  final DateFormat? dateFormat;

  DateFormField(
      {super.key, super.autovalidateMode, super.enabled,
      super.initialValue, super.onSaved, super.validator,
      super.restorationId, super.forceErrorText, this.dateFormat})
      : super(
          builder: (state) {
            return DateFormFieldWidget(
              state: state,
              dateFormat: dateFormat ?? DateFormat.yMd(),
            );
          },
        );
}
```
The `builder` property of the `FormField` is specified here which is another stateful widget that takes the `state` of the `FormField` as input along with the `dateFormat`. The purpose of the stateful widget is to expose a `TextField` and initiate the `showDatePicker()` method in `material.dart` library. The reason we use a stateful widget here is to access the `dispose()` method in order to dispose of the `TextEditingController()` that we had to create for accessing the value of the `TextField`. The implementation can be seen below:
```dart
class DateFormFieldWidget extends StatefulWidget {
  const DateFormFieldWidget({
    super.key, required this.state, required this.dateFormat,
  });
  final FormFieldState<DateTime> state;
  final DateFormat dateFormat;
  @override
  State<DateFormFieldWidget> createState() => _DateFormFieldWidgetState();
}

class _DateFormFieldWidgetState extends State<DateFormFieldWidget> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    controller.text = widget.state.value == null ? "" : widget.dateFormat.format(widget.state.value!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    controller.text = widget.state.value == null ? "" : widget.dateFormat.format(widget.state.value!);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Date", errorText: widget.state.errorText,
      ),
      onTap: () async {
        DateTime? val = await showDatePicker(
          initialDate: widget.state.value,
          context: widget.state.context,
          firstDate: DateTime.utc(2024), lastDate: DateTime.utc(2026),
        );
        widget.state.didChange(val);
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
```
The most important call here is `widget.state.didChange(val)` which accesses the state of the `FormField` and stores the newly received value and triggers a rebuild of the tree. In this step the value of the `TextField` is set by accessing the `controller`.




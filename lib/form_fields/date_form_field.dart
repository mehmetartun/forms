import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormField extends FormField<DateTime> {
  final DateFormat? dateFormat;

  DateFormField(
      {super.key,
      super.autovalidateMode,
      super.enabled,
      super.initialValue,
      super.onSaved,
      super.validator,
      super.restorationId,
      super.forceErrorText,
      this.dateFormat})
      : super(
          builder: (state) {
            return DateFormFieldWidget(
              state: state,
              dateFormat: dateFormat ?? DateFormat.yMd(),
            );
          },
        );
}

class DateFormFieldWidget extends StatefulWidget {
  const DateFormFieldWidget({
    super.key,
    required this.state,
    required this.dateFormat,
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
    controller.text = widget.state.value == null
        ? ""
        : widget.dateFormat.format(widget.state.value!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = widget.state.value == null
        ? ""
        : widget.dateFormat.format(widget.state.value!);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Date",
        errorText: widget.state.errorText,
      ),
      onTap: () async {
        DateTime? val = await showDatePicker(
          initialDate: widget.state.value,
          context: widget.state.context,
          firstDate: DateTime.utc(2024),
          lastDate: DateTime.utc(2026),
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

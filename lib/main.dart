import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forms Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Forms Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const toppings = ["Pepperoni", "Ham", "Vegeterian", "Four Seasons"];

enum Gender {
  male(description: "Male"),
  female(description: "Female"),
  transGender(description: "Transgender"),
  nonBinary(description: "Non-binary"),
  preferNoToSay(description: "Prefer not to say");

  final String description;
  const Gender({required this.description});
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> formValues = {};
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    formValues["name"] = "John Doe";
    formValues["topping"] = "Pepperoni";
    formValues["gender"] = Gender.preferNoToSay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            initialValue: formValues["name"],
                            decoration: const InputDecoration(
                              labelText: "Name",
                            ),
                            onSaved: (value) {
                              formValues["name"] = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field cannot be empty";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                              decoration:
                                  const InputDecoration(labelText: "Topping"),
                              value: formValues['topping'],
                              validator: (value) {
                                if (value == null) {
                                  return "Please select a value";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                formValues['topping'] = value;
                              },
                              isExpanded: true,
                              selectedItemBuilder: (context) {
                                return toppings.map((topping) {
                                  return Text(topping);
                                }).toList();
                              },
                              items: toppings.map((topping) {
                                return DropdownMenuItem<String>(
                                    value: topping,
                                    child: Text(
                                      topping,
                                      style: formValues['topping'] == topping
                                          ? TextStyle(color: Colors.blue)
                                          : null,
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  formValues['topping'] = value;
                                });
                              }),
                          DropdownButtonFormField<Gender>(
                              decoration:
                                  const InputDecoration(labelText: "Gender"),
                              value: formValues['gender'],
                              validator: (value) {
                                if (value == null) {
                                  return "Please select a value";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                formValues['gender'] = value;
                              },
                              // isExpanded: true,
                              selectedItemBuilder: (context) {
                                return Gender.values.map((gender) {
                                  return Text(gender.description);
                                }).toList();
                              },
                              items: Gender.values.map((gender) {
                                return DropdownMenuItem<Gender>(
                                    value: gender,
                                    child: Text(
                                      gender.description,
                                      style: formValues['gender'] == gender
                                          ? TextStyle(color: Colors.blue)
                                          : null,
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  formValues['gender'] = value;
                                });
                              }),
                          const SizedBox(height: 20),
                          FilledButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("name: ${formValues['name']} "
                                      "topping: ${formValues['topping']} "
                                      "gender: ${(formValues['gender'] as Gender).description} "),
                                ));
                              }
                            },
                            child: const Text("Submit"),
                          )
                        ])))));
  }
}

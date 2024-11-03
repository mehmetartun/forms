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

enum Gender {
  male,
  female,
  nonBinary,
  transgender,
  preferNoToSay,
}

extension Description on Gender {
  String get description {
    String _return = "";
    for (int i = 0; i < name.length; i++) {
      if (i == 0) {
        _return += name[i].toUpperCase();
      } else {
        if (name[i].toUpperCase() == name[i]) {
          _return += " ${name[i].toLowerCase()}";
        } else {
          _return += name[i];
        }
      }
    }
    return _return;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// enum Topping {
//   pepperoni("Pepperoni"),
//   fourSeasons("Four Seasons"),
//   vegeterian("Vegeterian"),
//   ham("Ham");

//   const Topping(this.description);
//   final String description;
// }

const toppings = ["Pepperoni", "Ham", "Vegeterian", "Four Seasons"];

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
                              focusColor: Colors.blue,
                              decoration:
                                  const InputDecoration(labelText: "Topping"),
                              value: "Pepperoni",
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
                          // const SizedBox(height: 20),
                          // DropdownButtonFormField<Gender>(
                          //     menuMaxHeight: 100,
                          //     decoration:
                          //         const InputDecoration(labelText: "Gender"),
                          //     value: formValues['gender'],
                          //     validator: (value) {
                          //       if (value == null) {
                          //         return "Please select a value";
                          //       }
                          //       return null;
                          //     },
                          //     onSaved: (value) {
                          //       formValues['gender'] = value;
                          //     },
                          //     isExpanded: true,
                          //     items: Gender.values.map((gender) {
                          //       return DropdownMenuItem<Gender>(
                          //         value: gender,
                          //         child: Text(gender.description),
                          //       );
                          //     }).toList(),
                          //     onChanged: (value) {}
                          //     // onChanged: onChanged,
                          //     ),
                          const SizedBox(height: 20),
                          FilledButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("name: ${formValues['name']} "
                                      // "gender: ${(formValues['gender'] as Gender).description}"
                                      "topping: ${formValues['topping']}"),
                                ));
                              }
                            },
                            child: const Text("Submit"),
                          )
                        ])))));
  }
}

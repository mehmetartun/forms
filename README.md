# Forms in Flutter

This project is a tutorial on Flutter Forms together with best practices 
for editing objects, creating custom `FormField` widgets and expooring 
some of the things to pay attention to when dealing with forms.

# Contents
1. [Tag 1.0.0](https://github.com/mehmetartun/forms/tree/1.0.0) Start - empty Flutter project
2. [Tag 2.0.0](https://github.com/mehmetartun/forms/tree/2.0.0) Implement simple **TextFormField**
3. [Tag 3.0.0](https://github.com/mehmetartun/forms/tree/3.0.0) Implement a **DropdownButtonFormField**
4. [Tag 4.0.0](https://github.com/mehmetartun/forms/tree/4.0.0) Using `enum` classes


## Tag 4.0.0

It is much better practice to use `enum` classes in conjunction with the `DropdownButtonFormField`.

### Gender field in the form

In this example we create a new `enum` called `Gender`
```dart
enum Gender {
  male(description: "Male"),
  female(description: "Female"),
  transGender(description: "Transgender"),
  nonBinary(description: "Non-binary"),
  preferNoToSay(description: "Prefer not to say");

  final String description;
  const Gender({required this.description});
}
```
where aside from the `enum` values, we also store the `description` which is how we would display this `enum` in our dropdown.

The implementation of the `DropdownButtonFormField` then becomes:
```dart
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
```





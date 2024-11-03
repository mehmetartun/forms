# Forms in Flutter

This project is a tutorial on Flutter Forms together with best practices 
for editing objects, creating custom `FormField` widgets and expooring 
some of the things to pay attention to when dealing with forms.

# Contents
1. [Tag 1.0.0](https://github.com/mehmetartun/forms/tree/1.0.0) Start - empty Flutter project
2. [Tag 2.0.0](https://github.com/mehmetartun/forms/tree/2.0.0) Implement simple **TextFormField**
3. [Tag 3.0.0](https://github.com/mehmetartun/forms/tree/2.0.0) Implement a **DropdownButtonFormField**

## Tag 3.0.0

Here we will implement a `DropdownButtonFormField`. For this purpose we will create an `enum` and choose the values of the `enum`.

![Simple Implementation](/assets/illustrations/Forms5.png)

![Formatting](/assets/illustrations/Forms6.png)

### Simple Implementation

We start by defining a list of values
```dart
const toppings = ["Pepperoni", "Ham", "Vegeterian", "Four Seasons"];
```

And then we insert the `FormField` widget just like the `TextFormField`.
```dart
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
        items: toppings.map((topping) {
        return DropdownMenuItem<String>(
            value: topping,
            child: Text(
                topping
            ));
        }).toList()
        ),
```

The shortcoming of this method is that we are unable to see the selected item when clicking on the menu. To fix this we do the following:
1. Add the `onChanged()` method such that we update the `formValues` Map everytime the dropdown changes and then we know what was selected last such that we can indicate this when we are building the menu.
2. The `items` property is built differently for the currently selected item where we supply additional `TextStyle` parameter
3. Because we do not want to change the builder for the **selected item**, we also define a `selectedItemBuilder` which is a list of `Widget`s.

Hence our `DropdownButtonFormField` becomes:
```dart
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
```



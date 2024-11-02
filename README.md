# Forms in Flutter

This project is a tutorial on Flutter Forms together with best practices 
for editing objects, creating custom `FormField` widgets and expooring 
some of the things to pay attention to when dealing with forms.

## Tag 1.0.0
We start with a blank project created using
```zsh
flutter create . --org com.artun
```
and we remove the counter and floating action button to have an empty page in the start.

## Tag 2.0.0
In this part we add a simple form with a `TextFormField`. The following slides give an overview of the structure of the form and below we see the implementation

![Overview of a Form](/assets/illustrations/Forms in Flutter-2.png)

![Initialization](/assets/illustrations/Forms in Flutter-3.png)

![Basic Operation](/assets/illustrations/Forms in Flutter-4.png)

### The Map containing the values of all form fields
To populate the formfield we first initialize a `Map` named `formValues` to contain the initial values of the form. 

This `Map` can come from the `toMap()` function of a data object, like for example a `User()` class with multiple properties such as `displayName`, `firstName`, `lastName`, `dob`, etc. More on this later.
```dart
  Map<String, dynamic> formValues = {};
  ...
  @override
  void initState() {
    formValues["name"] = "John Doe";
    super.initState();
  }
```

### The TextFormField
In the `TextFormField` we use these initialized values as:
```dart
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
```
Here we note that `onSaved()` method simply updates the `name` property of the `formValues` object. `validator()` on the other hand returns a `String` when the value is empty or null, and returns `null` otherwise, equivalent to saying the validation has passed.

### Submitting the form
For submitting the form we implement a `FilledButton` where validation and if successful, the subsequent submission occurs here.
```dart
    FilledButton(
    onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState?.save();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
            content: Text("name: ${formValues['name']}"),
        ));
        }
    },
    child: Text("Submit"),
    )
```
Once saved, we can then access the `formValues` map to display the **updated** value which is done in the `showSnackBar` step. 





import 'package:flutter/material.dart';
import 'package:forms/custom_text_field.dart';
import 'package:string_validator/string_validator.dart' as validator;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  var user = UserModel();
  var passwordCache = '';
  var passwordCacheConfirm = '';
  var obscureTextPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forms'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextField(
                label: 'Name',
                icon: Icons.person,
                hint: 'Type Your Name',
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Field cannot be empty';
                  }
                  if (text.length < 5) {
                    return 'Field name needs more 5 characters. (Has ${text.length})';
                  }
                },
                onSaved: (text) => user = user.copyWith(name: text),
              ),
              SizedBox(height: 15),
              CustomTextField(
                label: 'Email',
                icon: Icons.mail_sharp,
                hint: 'Type Your Email',
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'This field cannot empty';
                  }
                  if (!validator.isEmail(text)) {
                    return 'Value must be email type';
                  }
                },
                onSaved: (text) => user = user.copyWith(email: text),
              ),
              SizedBox(height: 15),
              CustomTextField(
                label: 'Password',
                icon: Icons.lock_outline_rounded,
                hint: 'Type Your Password',
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'This field cannot empty';
                  }
                  if (passwordCacheConfirm != passwordCache) {
                    return 'Password don\'t match';
                  }
                },
                onSaved: (text) => user = user.copyWith(password: text),
                onChanged: (text) => passwordCache = text,
                obscureText: obscureTextPassword,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureTextPassword = !obscureTextPassword;
                    });
                  },
                  icon: Icon(obscureTextPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
              SizedBox(height: 15),
              CustomTextField(
                label: 'Confirm Password',
                icon: Icons.lock_outline_rounded,
                hint: 'Confirm Your Password',
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'This field cannot empty';
                  }
                  if (passwordCacheConfirm != passwordCache) {
                    return 'Password don\'t match';
                  }
                },
                obscureText: obscureTextPassword,
                onSaved: (text) => user = user.copyWith(password: text),
                onChanged: (text) => passwordCacheConfirm = text,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureTextPassword = !obscureTextPassword;
                    });
                  },
                  icon: Icon(obscureTextPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
              SizedBox(height: 15),
              /*Builder(builder: (context) {    
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Form.of(context)?.validate();
                    },
                    icon: Icon(Icons.save),
                    label: Text("Save"),
                  ),
                );
              }),*/
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState?.save();
                      print('''FLUTTERANDO FORM
                      Name: ${user.name}
                      Email: ${user.email}
                      Password: ${user.password}
                      ''');
                    }
                  },
                  icon: Icon(Icons.save),
                  label: Text("Save"),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                  ),
                  onPressed: () {
                    formKey.currentState?.reset();
                  },
                  icon: Icon(Icons.save),
                  label: Text("Reset"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
class UserModel {
  final String name;
  final String email;
  final String password;

  UserModel({
    this.name = '',
    this.email = '',
    this.password = '',
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

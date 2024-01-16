import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _userController =
      TextEditingController(text: 'test');
  final TextEditingController _passwordController =
      TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(
          top: 70,
          left: 35,
          right: 35,
        ),
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.login_outlined),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "用户登录",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          _form(),
          _button(),
        ],
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: BrnTextInputFormItem(
                controller: _userController,
                isRequire: true,
                error: "用户名不能为空",
                title: "用户名",
              )),
          Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: BrnTextInputFormItem(
                controller: _passwordController,
                obscureText: true,
                isRequire: true,
                error: "密码不能为空",
                title: "密码",
              )),
        ],
      ),
    );
  }

  Widget _button() {
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
          onPressed: () async {
            if ((_formKey.currentState as FormState).validate()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                'navigator',
                (route) => false,
              );
            }
          },
          child: const Text("登录"),
        ),
      ),
    );
  }
}

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdi_hybrid/state/user_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _nickController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  late UserProvider _userProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = Provider.of<UserProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 200, 30, 0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _nickController,
              decoration: const InputDecoration(
                labelText: "用户昵称",
                hintText: "您的昵称",
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (v) {
                return v!.trim().length > 5 ? null : "昵称不能为空";
              },
            ),
            TextFormField(
              autofocus: true,
              controller: _unameController,
              decoration: const InputDecoration(
                labelText: "用户名",
                hintText: "您的用户名",
                icon: Icon(Icons.person),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
              validator: (v) {
                return v!.trim().isNotEmpty ? null : "用户名不能为空";
              },
            ),
            TextFormField(
              controller: _pwdController,
              decoration: const InputDecoration(
                labelText: "密码",
                hintText: "您的登录密码",
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (v) {
                return v!.trim().length > 5 ? null : "密码不能少于6位";
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: BrnSmallMainButton(
                      title: "注册并登录",
                      onTap: () {
                        if ((_formKey.currentState as FormState).validate()) {
                          _userProvider
                              .register(_unameController.text,
                                  _pwdController.text, _nickController.text)
                              .then((value) => {
                                    if (value)
                                      {
                                        BrnToast.show("注册成功，已为您登录", context,
                                            duration: BrnDuration.short)
                                      }
                                    else
                                      {
                                        BrnToast.show("注册失败,请检查信息", context,
                                            duration: BrnDuration.short)
                                      }
                                  });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: GestureDetector(
              onTap: () {},
              child: const Text(
                '注册账户',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdi_hybrid/state/user_provider.dart';
import 'package:sdi_hybrid/widgets/page/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
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
              autofocus: true,
              controller: _unameController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(),
                labelText: "用户名",
                hintText: "您的用户名",
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) {
                return v!.trim().isNotEmpty ? null : "用户名不能为空";
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _pwdController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(),
                labelText: "密码",
                hintText: "您的登录密码",
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (v) {
                return v!.trim().length > 5 ? null : "密码不能少于6位";
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: BrnSmallMainButton(
                      title: "登录",
                      onTap: () {
                        if ((_formKey.currentState as FormState).validate()) {
                          _userProvider
                              .login(_unameController.text, _pwdController.text)
                              .then((value) => {
                                    if (value && context.mounted)
                                      {
                                        BrnToast.show("登陆成功", context,
                                            duration: BrnDuration.short)
                                      }
                                    else
                                      {
                                        if (context.mounted)
                                          BrnToast.show("登陆失败,请检查信息", context,
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const Material(child: RegisterPage())));
              },
              child: const Text(
                '注册账户',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 151, 87),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

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
    return Scaffold(
      appBar: BrnAppBar(
        leading: const Icon(
          Icons.app_registration,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 0, 151, 87),
        themeData: BrnAppBarConfig.dark(),
        elevation: 4,
        title: '注册',
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 150, 32, 0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nickController,
                autofocus: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(),
                  labelText: "用户昵称",
                  hintText: "您的昵称",
                  prefixIcon: Icon(Icons.text_fields_outlined),
                ),
                validator: (v) {
                  return v!.trim().length > 1 ? null : "昵称长度需至少为2";
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
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
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 8),
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
                                              duration: BrnDuration.short),
                                          Navigator.pop(context)
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
            ],
          ),
        ),
      ),
    );
  }
}

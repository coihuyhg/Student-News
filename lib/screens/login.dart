import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/routers/router_name.dart';
import 'package:flutter_app/views_model/login_model.dart';
import 'package:flutter_app/widget/text_button_login.dart';
import 'package:flutter_app/widget/text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (context) => LoginModel(context),
      child: Consumer<LoginModel>(
        builder: (context, model, _) => Container(
          color: Colors.white,
          child: Center(
            child: model.loading
                ? CircularProgressIndicator()
                : Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Scaffold(
                        body: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    //Logo(),
                                    Image.asset("assets/logo_icon.png"),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      30, 10, 30, 10),
                                              child: TextFormFieldLogin(
                                                  labelText: "T??i kho???n",
                                                  prefixIcon:
                                                      Icon(Icons.person),
                                                  onChanged: (value) {
                                                    model
                                                        .onUserIdChanged(value);
                                                  },
                                                  validator:
                                                      Validatorless.multiple([
                                                    Validatorless.number(
                                                        "T??i kho???n kh??ng h???p l??? !"),
                                                    Validatorless.required(
                                                        "T??i kho???n kh??ng h???p l??? !")
                                                  ]))),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      30, 10, 30, 10),
                                              child: TextFormFieldLogin(
                                                labelText: "M???t kh???u",
                                                prefixIcon: Icon(Icons.lock),
                                                onChanged: (value) {
                                                  model
                                                      .onPasswordChanged(value);
                                                },
                                                validator:
                                                    Validatorless.multiple([
                                                  Validatorless.min(6,
                                                      "M???t kh???u kh??ng h???p l??? !"),
                                                  Validatorless.required(
                                                      "M???t kh???u kh??ng ???????c tr???ng !")
                                                ]),
                                              )),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 30),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pushReplacementNamed(RouterName.forgetPassword);
                                                  },
                                                  child:
                                                      Text("Qu??n m???t kh???u ?"),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: TextButtonLogin(
                                              onPressed: () async {
                                                bool isValid = _formKey
                                                    .currentState
                                                    .validate();
                                                if (isValid == true) {
                                                  await model.onLogin();
                                                }
                                              },
                                              title: ("????ng nh???p"),
                                            )),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10,
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

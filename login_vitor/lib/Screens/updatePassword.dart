import 'package:flutter/material.dart';
import 'package:interface_zenith/Services/auth.dart';
import 'package:interface_zenith/Effects/Loader.dart';
import '../Effects/FadeAnimation.dart';

class UpdatePassword extends StatefulWidget {

  final Function toggleUpdatePassword;
  UpdatePassword({this.toggleUpdatePassword});



  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword>{

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();


  String email = '';
  String error = '';

  bool loading = false;

  dynamic result;

  @override
  Widget build(BuildContext context) {
    return loading ? Loader() : MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(30, 28, 27, 1),
        body: Container(
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset("images/Z.png"),
                ),
                FadeAnimation(1.5, -50.0,
                  Container(
                    margin: EdgeInsetsDirectional.fromSTEB(15, 60, 15, 20),
                    height: 508,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(70),
                      ),
                    ),
                    child: ListView(children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      FadeAnimation(2.5, -25.0,
                        Container(
                          margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: TextFormField(
                            validator: (val) =>
                            val.isEmpty ? 'Insira um email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "E-mail cadastrado",
                              labelStyle: TextStyle(
                                color: Color.fromRGBO(30, 28, 27, 1),
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(2.5, -20.0,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin:EdgeInsetsDirectional.fromSTEB(5, 2, 5, 5),
                              height: 60,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                              child: SizedBox.expand(
                                child: FlatButton(
                                  child: Text(
                                    "Voltar",
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  onPressed: widget.toggleUpdatePassword,
                                ),
                              ),
                            ),

                            Container(
                              margin:EdgeInsetsDirectional.fromSTEB(5, 2, 5, 2),
                              height: 60,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                              child: SizedBox.expand(
                                child: FlatButton(
                                  child: Text(
                                    "Submit",
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() => loading = true);
                                      result = await _auth.resetPassword(email);
                                      setState(() => loading = false);

                                      if (result != null) {
                                        setState(() => error = "email inválido");
                                      } else {
                                        setState(() => error = "email enviado com sucesso");
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(

                        child: Text(
                          error,
                          style: TextStyle(color: result == null ? Colors.green : Colors.red, fontSize: 14.0),
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

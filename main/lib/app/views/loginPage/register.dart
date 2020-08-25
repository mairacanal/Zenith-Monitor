import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zenith_monitor/app/bloc/login_bloc/login_bloc.dart';
import 'package:zenith_monitor/app/models/user.dart';
import 'Effects/FadeAnimation.dart';
import 'Effects/Loader.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String senha = '';
  String imageURL = '';
  String error = '';

  bool valida = true;
  bool loading = false;

  File imageFile;

  Future<void> _pickImage(ImageSource source) async {
    // ignore: deprecated_member_use
    File selected = await ImagePicker.pickImage(source: source);
    print("picker");
    if (selected != null) {
      print("cropper");
      File cropped = await ImageCropper.cropImage(
        sourcePath: selected.path,
        cropStyle: CropStyle.circle,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxHeight: 700,
        maxWidth: 700,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Color.fromRGBO(30, 28, 27, 1),
          toolbarWidgetColor: Colors.white,
          hideBottomControls: true,
        ),
      );
      setState(() {
        imageFile = cropped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loader()
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Color.fromRGBO(30, 28, 27, 1),
              body: ListView(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      FadeAnimation(
                        1.5,
                        -50.0,
                        Container(
                          margin:
                              EdgeInsetsDirectional.fromSTEB(15, 180, 15, 50),
                          height: 600,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(70),
                            ),
                          ),
                          child: Form(
                            key: _formKey,
                            child: ListView(children: <Widget>[
                              SizedBox(
                                height: 40,
                              ),
                              FadeAnimation(
                                2.5,
                                -25.0,
                                Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      20, 60, 20, 10),
                                  child: TextFormField(
                                    validator: (val) =>
                                        val.isEmpty ? 'Insira seu nome' : null,
                                    onChanged: (val) {
                                      setState(() => name = val);
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: "Nome",
                                      labelStyle: TextStyle(
                                        color: Color.fromRGBO(30, 28, 27, 1),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                2.5,
                                -35.0,
                                Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 20, 0),
                                  child: TextFormField(
                                    validator: (val) =>
                                        val.isEmpty ? 'Insira um email' : null,
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: "E-mail",
                                      labelStyle: TextStyle(
                                        color: Color.fromRGBO(30, 28, 27, 1),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                2.5,
                                -45.0,
                                Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      20, 10, 20, 0),
                                  child: TextFormField(
                                    validator: (val) => val.length < 6
                                        ? 'Senha deve conter no mínimo 6 digitos'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => senha = val);
                                    },
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      labelText: "Senha",
                                      labelStyle: TextStyle(
                                        color: Color.fromRGBO(30, 28, 27, 1),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  error,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.0),
                                ),
                              ),
                              SizedBox(
                                height: valida ? 150 : 85,
                              ),
                              FadeAnimation(
                                2.5,
                                -20.0,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          5, 2, 5, 5),
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
                                          onPressed: () {
                                            BlocProvider.of<LoginBloc>(context)
                                                .add(ChangeForm(
                                                    LoginForm.signin));
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          5, 2, 5, 2),
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
                                            setState(() => valida = _formKey
                                                .currentState
                                                .validate());

                                            if (valida) {
                                              setState(() => loading = true);

                                              if (imageFile != null) {
                                                // assim o usuário não é obrigado a escolher uma imagem
                                                // imageURL = await _store
                                                //     .uploadFile(imageFile);
                                              }
                                              BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .add(LoginRegister(
                                                RegisterPacket(name, email,
                                                    senha, imageURL),
                                              ));
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      FadeAnimation(
                        3,
                        -50.0,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 200.0),
                              child: MaterialButton(
                                onPressed: () {
                                  _pickImage(ImageSource.camera);
                                },
                                height: 50,
                                color: Colors.black,
                                textColor: Colors.grey,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 60.0),
                              child: CircleAvatar(
                                radius: 100,
                                backgroundColor: Colors.black,
                                child: ClipOval(
                                  child: SizedBox(
                                    height: 180.0,
                                    width: 180.0,
                                    child: (imageFile != null)
                                        ? Image.file(
                                            imageFile,
                                            fit: BoxFit.fill,
                                          )
                                        : Icon(
                                            Icons.person,
                                            color: Colors.grey,
                                            size: 100,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 200.0),
                              child: MaterialButton(
                                onPressed: () {
                                  _pickImage(ImageSource.gallery);
                                },
                                height: 50,
                                color: Colors.black,
                                textColor: Colors.grey,
                                child: Icon(
                                  Icons.photo_library,
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}

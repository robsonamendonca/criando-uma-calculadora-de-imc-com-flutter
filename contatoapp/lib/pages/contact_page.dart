// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison
import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:contatoapp/model/contatos_back4app_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  final ContatoModel contact;

  const ContactPage({super.key, required this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _diaNascController = TextEditingController();
  final _mesNascController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;
  late ContatoModel _editedContact;
  File? _image;
  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _editedContact.foto = _image?.path;
        debugPrint('foto ok');
      });
      // Após capturar a imagem, chame a função para recortar
      File? croppedFile = await _cropImage(File(pickedFile.path));

      if (croppedFile != null) {
        debugPrint('croppedFile ok');
        setState(() {
          _image = File(croppedFile.path);
          _editedContact.foto = _image?.path;
        });
      } else {
        debugPrint('não foi possivel croppedFile');
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    CroppedFile? croppedFile = (await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      maxWidth: 1024,
      maxHeight: 1024,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: "APP_TOOLBAR_TITLE_CROP".tr(),
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: "APP_TOOLBAR_TITLE_CROP".tr(),
        ),
      ],
    ));
    return (croppedFile == null) ? null : File(croppedFile.path);
  }

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = ContatoModel([]);
      _nameController.text = "";
      _telefoneController.text = "";
      _diaNascController.text = "";
      _mesNascController.text = "";
    } else {
      _editedContact = ContatoModel.fromMap(widget.contact.toMap());
      _nameController.text = _editedContact.nome.toString();
      _telefoneController.text = _editedContact.telefone.toString();
      _diaNascController.text = _editedContact.diaNascimento.toString();
      _mesNascController.text = _editedContact.mesNascimento.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _telefoneController.dispose();
    _diaNascController.dispose();
    _mesNascController.dispose();
    super.dispose();
  }

  cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      await GallerySaver.saveImage(croppedFile.path);
      _editedContact.foto = XFile(croppedFile.path).path;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(_editedContact.nome!.isEmpty
              ? "API_TITULO_FORM_CONTATO".tr()
              : _editedContact.nome.toString()),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_nameController.text != null) {
              bool ok = _validarCampos(context);
              debugPrint('ok: $ok');
              if (ok == false) return;
              Navigator.pop(context, _editedContact);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.save),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _editedContact.foto != null
                              ? FileImage(File(_editedContact.foto!))
                              : const AssetImage("assets/person.png")
                                  as ImageProvider,
                          fit: BoxFit.cover)),
                ),
                onTap: () async {
                  await _takePhoto();
                },
              ),
              TextField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: InputDecoration(labelText: "APP_TXT_NOME".tr()),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editedContact.nome = text;
                  });
                },
              ),
              TextField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: "APP_TXT_TELEFONE".tr()),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.telefone = text;
                },
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
              ),
              TextField(
                controller: _diaNascController,
                decoration: InputDecoration(
                    labelText: "${"APP_TXT_DIA_NASCIMENTO".tr()} (1-31)"),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.diaNascimento = int.parse(text);
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              TextField(
                controller: _mesNascController,
                decoration: InputDecoration(
                    labelText: "${"APP_TXT_MES_NASCIMENTO".tr()} (1-12)"),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.mesNascimento = int.parse(text);
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("APP_ALERT_TITULO_PENDENTE".tr()),
              content: Text("APP_ALERT_MENSAGEM_PENDENTE".tr()),
              actions: <Widget>[
                TextButton(
                  child: Text("APP_ALERT_BOTAO_CANCELAR".tr()),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text("APP_ALERT_BOTAO_SIM".tr()),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  bool _validarCampos(BuildContext context) {
    if (_editedContact.foto == null || _editedContact.foto!.isEmpty) {
      _showAlertDialog(context, "APP_MSG_VALID_FOTO".tr());
      return false;
    }
    if (_nameController.text == null || _nameController.text.isEmpty) {
      _showAlertDialog(context, "APP_MSG_VALIDA_VAZIO_NOME".tr());
      return false;
    } else {
      if (_nameController.text.length < 3) {
        _showAlertDialog(context, "APP_MSG_VALID_NOME".tr());
        return false;
      }
    }
    if (int.parse(_diaNascController.text) > 0 &&
        int.parse(_diaNascController.text) > 31) {
      _showAlertDialog(context, "APP_MSG_VALID_DIA_NASC".tr());
      return false;
    }
    if (int.parse(_mesNascController.text) > 0 &&
        int.parse(_mesNascController.text) > 12) {
      _showAlertDialog(context, "APP_MSG_VALID_MES_NASC".tr());
      return false;
    }

    return true;
  }

  void _showAlertDialog(BuildContext context, String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("APP_TXT_ATENCAO".tr()),
          content: Text(mensagem),
          actions: [
            TextButton(
              child: Text("APP_BOTAO_OK".tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

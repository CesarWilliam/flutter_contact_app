import 'package:contacts/models/contact.model.dart';
import 'package:flutter/material.dart';
import 'package:contacts/repositories/contact.repository.dart';

class EditorContactView extends StatefulWidget {
  final ContactModel model;

  EditorContactView({this.model});

  @override
  _EditorContactViewState createState() => _EditorContactViewState();
}

class _EditorContactViewState extends State<EditorContactView> {
  final _scaffoldkey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  final _repository = ContactRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: widget.model.id == 0 ? Text("Novo Contato") : Text("Editar Contato"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.model?.name,
                onSaved: (val) {
                  widget.model.name = val;
                },
              ),
              TextFormField(
                initialValue: widget.model?.phone,
                onSaved: (val) {
                  widget.model.phone = val;
                },
              ),
              TextFormField(
                initialValue: widget.model?.email,
                onSaved: (val) {
                  widget.model.email = val;
                },
              ),
              SizedBox(
                height: 20
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: FlatButton.icon(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {}, 
                  icon: Icon(
                    Icons.save,
                    color: Theme.of(context).accentColor,
                  ),
                  label: Text(
                    "Salvar",
                    style: TextStyle(
                      color: Theme.of(context).accentColor
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
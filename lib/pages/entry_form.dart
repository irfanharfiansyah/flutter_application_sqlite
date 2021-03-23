import 'package:flutter/material.dart';
import 'package:flutter_application_sqlite/models/item.dart';

class EntryForm extends StatefulWidget {
  @override
  final Item item;

  EntryForm(this.item);

  _EntryFormState createState() => _EntryFormState(this.item);
}

class _EntryFormState extends State<EntryForm> {
  Item item;

  _EntryFormState(this.item);
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // kondisi,
    if (item != null) {
      nameController.text = item.name;
      priceController.text = item.price.toString();
    }
    // rubah
    return Scaffold(
      appBar: AppBar(
        title: item == null ? Text("Tambah") : Text("Ubah"),
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10, right: 10),
        child: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Nama Barang",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onChanged: (value){
                // 
              },
            ),
          )
        ]),
      ),
    );
  }
}

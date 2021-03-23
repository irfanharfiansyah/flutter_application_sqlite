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
          // input text untuk nama barang
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
              onChanged: (value) {
                //
              },
            ),
          ),
          // input text untuk harga
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Harga",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onChanged: (value) {},
            ),
          ),
          // Tombol button
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(children: <Widget>[
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text(
                    "Save",
                    textScaleFactor: 1.5,
                  ),
                  onPressed: () {
                    if (item == null) {
                      // menambahkan data
                      item = Item(
                        nameController.text,
                        int.parse(priceController.text),
                      );
                    } else {
                      // merubah data
                      item.name = nameController.text;
                      item.price = int.parse(priceController.text);
                    }
                    // kembali ke halaman/layar sebelumnya dengan membawa objek item
                    Navigator.pop(context, item);
                  },
                ),
              ),
              Container(width: 5),
              // tombol untuk batal
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text("Batal", textScaleFactor: 1.5),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}

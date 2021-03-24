import 'package:flutter/material.dart';
import 'package:flutter_application_sqlite/models/item.dart';
import 'package:flutter_application_sqlite/theme.dart';

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
  TextEditingController qtyController = TextEditingController();
  TextEditingController kodeController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // kondisi,
    if (item != null) {
      nameController.text = item.name;
      priceController.text = item.price;
      qtyController.text = item.qty.toString();
      kodeController.text = item.kode.toString();
      photoController.text = item.photo;
    }
    // rubah
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        title: item == null ? Text("Tambah Data") : Text("Ubah Data"),
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
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: TextField(
              controller: photoController,
              decoration: InputDecoration(
                labelText: "Link Photo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onChanged: (value) {},
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 15),
                width: 178,
                child: TextField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Stok",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 19),
                width: 178,
                child: TextField(
                  controller: kodeController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: InputDecoration(
                    labelText: "Kode barang",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          // Tombol button
          Padding(
            padding: EdgeInsets.only(top: 90, bottom: 20),
            child: Row(children: <Widget>[
              Expanded(
                child: RaisedButton(
                  color: Colors.teal,
                  textColor: Colors.white,
                  child: Text(
                    "Simpan",
                    style: title.copyWith(
                        fontSize: 19, fontWeight: FontWeight.w800),
                  ),
                  onPressed: () {
                    if (item == null) {
                      // menambahkan data
                      item = Item(
                        nameController.text,
                        priceController.text,
                        int.parse(qtyController.text),
                        int.parse(kodeController.text),
                        photoController.text,
                      );
                    } else {
                      // merubah data
                      item.name = nameController.text;
                      item.price = priceController.text;
                      item.qty = int.parse(qtyController.text);
                      item.kode = int.parse(kodeController.text);
                      item.photo = photoController.text;
                    }
                    // kembali ke halaman/layar sebelumnya dengan membawa objek item
                    Navigator.pop(context, item);
                  },
                ),
              ),
              Container(width: 25),
              // tombol untuk batal
              Expanded(
                child: RaisedButton(
                  color: Colors.black12,
                  textColor: Theme.of(context).primaryColorLight,
                  splashColor: Colors.white,
                  child: Text(
                    "Batal",
                    style: title.copyWith(
                        fontSize: 19, fontWeight: FontWeight.w800),
                  ),
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_sqlite/theme.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter_application_sqlite/database/db_helper.dart';
import 'entry_form.dart';
import 'package:flutter_application_sqlite/models/item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Item> itemList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        backgroundColor: green1,
        centerTitle: true,
        title: Text(
          "Daftar Item",
          textAlign: TextAlign.center,
        ),
        actions: [Icon(Icons.more_vert)],
      ),
      body: createListView(),
      floatingActionButton: Visibility(
        child: FloatingActionButton.extended(
          backgroundColor: Colors.teal[100],
          foregroundColor: Colors.black,
          onPressed: () async {
            // Respond to button press
            var item = await navigateToEntryForm(context, null);
            if (item != null) {
              // TODO 2 panggil fungsi untuk insert ke DB
              int result = await dbHelper.insert(item);
              if (result > 0) {
                updateListView();
              }
            }
          },
          icon: Icon(Icons.add),
          label: Text(
            'Tambah data',
            style: title.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  Future<Item> navigateToEntryForm(BuildContext context, Item item) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EntryForm(item);
        },
      ),
    );
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(top: 5),
          child: Card(
            color: Colors.white70,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://pbs.twimg.com/profile_images/1278387488516530177/nF9su3de_400x400.png"),
                  ),
                  title: Text(
                    '${this.itemList[index].name.toString()}',
                    style: title.copyWith(
                        fontSize: 15, fontWeight: FontWeight.w900),
                  ),
                  subtitle: Text(
                    'Qty: ${this.itemList[index].qty.toString()}',
                    style: body.copyWith(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  child: Image.network(
                      "https://resource.logitechg.com/content/dam/gaming/en/products/g413/g413-gallery-1.png"),
                ),
                // Menampilkan Harga dari input
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Rp.${this.itemList[index].price.toString()}',
                    style: body.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Menambhakan button untuk Edit dan hapus
                Container(
                  color: green1,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                        textColor: Colors.white,
                        color: Colors.indigo[600],
                        onPressed: () async {
                          // TODO 4 panggil fungsi untuk Edit data
                          var item = await navigateToEntryForm(
                              context, this.itemList[index]);
                          if (item != null) {
                            editListView(item);
                          }
                          // Perform some action
                        },
                        child: Text(
                          'EDIT',
                          style: but.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                      FlatButton(
                        textColor: Colors.white,
                        color: Colors.brown[200],
                        onPressed: () async {
                          // TODO 3 panggil fungsi untuk Delete dari Db berdasarkan item
                          deleteListView(itemList[index]);
                        },
                        child: Text(
                          'HAPUS',
                          style: but.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 140),
                        child: Text(
                          'code : ${this.itemList[index].kode.toString()}',
                          style: title.copyWith(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then(
      (database) {
        // TODO 1 select data dari DB
        Future<List<Item>> itemListFuture = dbHelper.getItemList();
        itemListFuture.then(
          (itemList) {
            setState(
              () {
                this.itemList = itemList;
                this.count = itemList.length;
              },
            );
          },
        );
      },
    );
  }

// Fungsi untuk menghapus List item
  void deleteListView(Item object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  // Fungsi untuk mengedit List item
  void editListView(Item object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }
}

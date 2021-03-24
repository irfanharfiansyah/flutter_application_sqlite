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
        backgroundColor: Colors.black54,
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
          backgroundColor: Colors.orange,
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
          margin: EdgeInsets.only(top: 9, left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
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
                  width: 150,
                  child:
                      Image.network('${this.itemList[index].photo.toString()}'),
                ),
                // Menampilkan Harga dari input
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(
                    'Rp.${this.itemList[index].price.toString()}',
                    style: but.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w900,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Menambhakan button untuk Edit dan hapus
                Container(
                  color: Colors.black87,
                  padding: EdgeInsets.only(left: 5),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        textColor: Colors.white,
                        color: Colors.orange,
                        splashColor: Colors.grey,
                        onPressed: () async {
                          // TODO 4 panggil fungsi untuk Edit data
                          var item = await navigateToEntryForm(
                              context, this.itemList[index]);
                          if (item != null) {
                            editListView(item);
                          }
                          // Perform some action
                        },
                        child: Container(
                          child: Icon(
                            Icons.edit,
                            size: 19,
                          ),
                        ),
                      ),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        textColor: Colors.white,
                        splashColor: Colors.red,
                        color: Colors.brown[200],
                        onPressed: () async {
                          // TODO 3 panggil fungsi untuk Delete dari Db berdasarkan item
                          deleteListView(itemList[index]);
                        },
                        child: Icon(
                          Icons.delete_forever_rounded,
                          size: 19,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 118),
                        child: Text(
                          'code : ${this.itemList[index].kode.toString()}',
                          style: title.copyWith(
                            color: Colors.white.withOpacity(0.3),
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

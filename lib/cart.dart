import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final Box = GetStorage();

  List<Widget> getList() {
    return Box.read('CartList');
  }

  List<Widget>? ItemList = [];
  bool isempty = true;

  Future<bool> checkTheList(List<Widget>? list) async{
    Widget firstElement = list![0];
    if (firstElement == 0) {
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    ItemList = getList();

    double maxwidth = MediaQuery
        .of(context)
        .size
        .width;
    checkTheList(ItemList);
    return Scaffold(
      appBar: AppBar(centerTitle: false, title: Text("Order Summary")),
      body: Container(
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(07)),
          padding: EdgeInsets.all(07),
          margin: EdgeInsets.all(17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: maxwidth,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(07),
                    color: Color(0xff3D8361)),
                child: Text("data", style: TextStyle(fontSize: 25)),
              ),
               Container(
                 child: Expanded(
                  child: ListView.builder(
                      itemCount: ItemList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(title: ItemList?[index],);
                      }),
              ),
               )
            ],
          )),
    );
  }
}


Widget CartItems(){
  return Container(child: Column(children: [Text("")]),);
}
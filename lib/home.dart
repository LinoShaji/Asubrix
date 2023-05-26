import 'package:asubrix/authentication.dart';
import 'package:asubrix/cart.dart';
import 'package:asubrix/services/remote_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'models/restraunts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Restraunts>? restraunts;
  var isLoaded = false;
  final Box = GetStorage();
  List<Widget> ListCart = [];

  void SaveOrderList(List<Widget> Item) {
    Box.write('CartList', Item);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    print("debug 2 succes");
    restraunts = await RemoteServices().getPosts();
    print("debug 3 succes");
    if (restraunts != null) {
      setState(() {
        isLoaded = true;
        print("restraunts not equal to null");
      });
    } else
      print("restraunts are null");
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;
    int? tablemenuListCount =
        restraunts?[0].tableMenuList[0].categoryDishes[0].dishName.length;
    int count = 6;
    return DefaultTabController(
      length: count,
      child: Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(Cart());
                  },
                  icon: Icon(Icons.shopping_cart))
            ],
            bottom: TabBar(isScrollable: true, tabs: [
              for (int i = 0; i <= count - 1; i++)
                Tab(
                    child: Text(
                      "${restraunts?[0].tableMenuList[i].menuCategory}",
                      style: const TextStyle(fontSize: 17),
                    )),
            ])),
        drawer: Drawer(
          child: SafeArea(
            child: Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                height: 100,
                width: 100,
                decoration: BoxDecoration(color: Colors.green.shade100),
                child: ListView(children: [
                  Container(
                    alignment: Alignment.center,
                    height: 100,
                    decoration: const BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Text("${user?.displayName}",
                        style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton.icon(onPressed: () {auth.signOut();Get.off(authenticationScreen());},
                    icon: Icon(Icons.logout),
                    label: Text("Logout"),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),)
                ]),
              ),
            ),
          ),
        ),
        body: TabBarView(children: [
          ListView.builder(
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                print(tablemenuListCount);
                return ItemContainer(
                  dishName: restraunts?[0]
                      .tableMenuList[0]
                      .categoryDishes[index]
                      .dishName,
                  price: restraunts?[0]
                      .tableMenuList[0]
                      .categoryDishes[index]
                      .dishPrice,
                  calories: restraunts?[0]
                      .tableMenuList[0]
                      .categoryDishes[index]
                      .dishCalories,
                  URL: restraunts?[0]
                      .tableMenuList[0]
                      .categoryDishes[index]
                      .dishImage,
                  dishDesc: restraunts?[0]
                      .tableMenuList[0]
                      .categoryDishes[index]
                      .dishDescription,
                  pressedDelete: () {
                    print(index);
                  },
                  pressedAdd: () {
                    setState(() {
                      ListCart.add(Container(
                          child: Column(
                            children: [
                              Text(
                                  "${restraunts?[0].tableMenuList[0]
                                      .categoryDishes[index].dishName}"),
                              Text(
                                  "${restraunts?[0].tableMenuList[0]
                                      .categoryDishes[index].dishPrice}")
                            ],
                          )));
                    });
                    SaveOrderList(ListCart);
                  },
                );
              }),
          ListView.builder(
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                print(tablemenuListCount);
                return ItemContainer(
                  dishName: restraunts?[0]
                      .tableMenuList[1]
                      .categoryDishes[index]
                      .dishName,
                  price: restraunts?[0]
                      .tableMenuList[1]
                      .categoryDishes[index]
                      .dishPrice,
                  calories: restraunts?[0]
                      .tableMenuList[1]
                      .categoryDishes[index]
                      .dishCalories,
                  URL: restraunts?[0]
                      .tableMenuList[1]
                      .categoryDishes[index]
                      .dishImage,
                  dishDesc: restraunts?[0]
                      .tableMenuList[1]
                      .categoryDishes[index]
                      .dishDescription,
                  pressedDelete: () {
                    print("pressed");
                  },
                  pressedAdd: () {
                    setState(() {
                      ListCart.add(Container(
                          child: Column(
                            children: [
                              Text(
                                  "${restraunts?[0].tableMenuList[1]
                                      .categoryDishes[index].dishName}"),
                              Text(
                                  "${restraunts?[0].tableMenuList[1]
                                      .categoryDishes[index].dishPrice}")
                            ],
                          )));
                    });
                    SaveOrderList(ListCart);
                  },
                );
              }),
          ListView.builder(
              itemCount: restraunts?[0].tableMenuList[2].categoryDishes.length,
              itemBuilder: (BuildContext context, int index) {
                print(tablemenuListCount);
                return ItemContainer(
                  dishName: restraunts?[0].tableMenuList[2].categoryDishes[index].dishName,
                  price: restraunts?[0]
                      .tableMenuList[2]
                      .categoryDishes[index]
                      .dishPrice,
                  calories: restraunts?[0]
                      .tableMenuList[2]
                      .categoryDishes[index]
                      .dishCalories,
                  URL: restraunts?[0]
                      .tableMenuList[2]
                      .categoryDishes[index]
                      .dishImage,
                  dishDesc: restraunts?[0]
                      .tableMenuList[2]
                      .categoryDishes[index]
                      .dishDescription,
                  pressedDelete: () {
                    print("pressed");
                  },
                  pressedAdd: () {
                    setState(() {
                      ListCart.add(Container(
                          child: Column(
                            children: [
                              Text(
                                  "${restraunts?[0].tableMenuList[2]
                                      .categoryDishes[index].dishName}"),
                              Text(
                                  "${restraunts?[0].tableMenuList[2]
                                      .categoryDishes[index].dishPrice}")
                            ],
                          )));
                    });
                    SaveOrderList(ListCart);
                  },
                );
              }),
          ListView.builder(
              itemCount: restraunts?[0].tableMenuList[3].categoryDishes.length,
              itemBuilder: (BuildContext context, int index) {
                print(tablemenuListCount);
                return ItemContainer(
                  dishName: restraunts?[0].tableMenuList[3].categoryDishes[index].dishName,
                  price: restraunts?[0]
                      .tableMenuList[3]
                      .categoryDishes[index]
                      .dishPrice,
                  calories: restraunts?[0]
                      .tableMenuList[3]
                      .categoryDishes[index]
                      .dishCalories,
                  URL: restraunts?[0]
                      .tableMenuList[3]
                      .categoryDishes[index]
                      .dishImage,
                  dishDesc: restraunts?[0]
                      .tableMenuList[3]
                      .categoryDishes[index]
                      .dishDescription,
                  pressedDelete: () {
                    print("pressed");
                  },
                  pressedAdd: () {
                    setState(() {
                      ListCart.add(Container(
                          child: Column(
                            children: [
                              Text(
                                  "${restraunts?[0].tableMenuList[3]
                                      .categoryDishes[index].dishName}"),
                              Text(
                                  "${restraunts?[0].tableMenuList[3]
                                      .categoryDishes[index].dishPrice}")
                            ],
                          )));
                    });
                    SaveOrderList(ListCart);
                  },
                );
              }),
          ListView.builder(
              itemCount: restraunts?[0].tableMenuList[4].categoryDishes.length,
              itemBuilder: (BuildContext context, int index) {
                print(tablemenuListCount);
                return ItemContainer(
                  dishName: restraunts?[0].tableMenuList[4].categoryDishes[index].dishName,
                  price: restraunts?[0]
                      .tableMenuList[4]
                      .categoryDishes[index]
                      .dishPrice,
                  calories: restraunts?[0]
                      .tableMenuList[4]
                      .categoryDishes[index]
                      .dishCalories,
                  URL: restraunts?[0]
                      .tableMenuList[4]
                      .categoryDishes[index]
                      .dishImage,
                  dishDesc: restraunts?[0]
                      .tableMenuList[4]
                      .categoryDishes[index]
                      .dishDescription,
                  pressedDelete: () {
                    print("pressed");
                  },
                  pressedAdd: () {
                    setState(() {
                      ListCart.add(Container(
                          child: Column(
                            children: [
                              Text(
                                  "${restraunts?[0].tableMenuList[4]
                                      .categoryDishes[index].dishName}"),
                              Text(
                                  "${restraunts?[0].tableMenuList[4]
                                      .categoryDishes[index].dishPrice}")
                            ],
                          )));
                    });
                    SaveOrderList(ListCart);
                  },
                );
              }),
          ListView.builder(
              itemCount: restraunts?[0].tableMenuList[5].categoryDishes.length,
              itemBuilder: (BuildContext context, int index) {
                print(tablemenuListCount);
                return ItemContainer(
                  dishName: restraunts?[0].tableMenuList[5].categoryDishes[index].dishName,
                  price: restraunts?[0]
                      .tableMenuList[5]
                      .categoryDishes[index]
                      .dishPrice,
                  calories: restraunts?[0]
                      .tableMenuList[5]
                      .categoryDishes[index]
                      .dishCalories,
                  URL: restraunts?[0]
                      .tableMenuList[5]
                      .categoryDishes[index]
                      .dishImage,
                  dishDesc: restraunts?[0]
                      .tableMenuList[5]
                      .categoryDishes[index]
                      .dishDescription,
                  pressedDelete: () {
                  },
                  pressedAdd: () {
                    setState(() {
                      ListCart.add(Container(
                          child: Column(
                            children: [
                              Text(
                                  "${restraunts?[0].tableMenuList[5]
                                      .categoryDishes[index].dishName}"),
                              Text(
                                  "${restraunts?[0].tableMenuList[5]
                                      .categoryDishes[index].dishPrice}")
                            ],
                          )));
                    });
                    SaveOrderList(ListCart);
                  },
                );
              })
        ]),
      ),
    );
  }
}

class ItemContainer extends StatefulWidget {
  String? dishName;
  double? price;
  double? calories;
  String? URL;
  String? dishDesc;
  VoidCallback pressedDelete;
  VoidCallback pressedAdd;

  ItemContainer({required this.calories,
    required this.pressedDelete,
    required this.price,
    required this.dishName,
    required this.URL,
    required this.dishDesc,
    required this.pressedAdd,
    Key? key})
      : super(key: key);

  @override
  State<ItemContainer> createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 05,
        right: 05,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.black),
          color: Colors.white24),
      padding: EdgeInsets.only(left: 20, top: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "${widget.dishName}",
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("INR ${widget.price}",
                style: TextStyle(fontWeight: FontWeight.w500)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.calories} calories",
                    style: TextStyle(fontWeight: FontWeight.w500)),
                Container(
                  width: 70,
                  height: 70,
                  child: Image(image: NetworkImage("https://www.pexels.com/photo/green-tree-268533/")),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: Text("${widget.dishDesc}",
                    maxLines: 5, overflow: TextOverflow.clip, softWrap: true)),
            Container(
              width: 50,
              height: 30,
            )
          ],
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(20)),
          width: 110,
          child: Row(children: [
            IconButton(
                onPressed: widget.pressedDelete, icon: Icon(Icons.delete)),
            Text("0"),
            IconButton(onPressed: widget.pressedAdd, icon: Icon(Icons.add))
          ]),
        )
      ]),
    );
  }
}

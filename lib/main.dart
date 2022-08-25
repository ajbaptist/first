import 'dart:developer';
import 'dart:ffi';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TutorialCoachMark Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SwiperController controller = SwiperController();

  @override
  Widget build(BuildContext context) {
    RxList<DataClass> data = [
      DataClass(data: "data 20", orginal: true, page: 5),
      DataClass(data: "data 21", orginal: true, page: 5),
      DataClass(data: "data 22", orginal: true, page: 5),
      DataClass(data: "data 23", orginal: true, page: 5),
      DataClass(data: "data 24", orginal: true, page: 5),
    ].obs;
    // RxList growableList =
    //     RxList.generate(25, (int index) => index * index, growable: true);

    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (() {
          print(data.length);
          var mylist = <DataClass>[].obs;
          if (data[0].page == 1) {
            Get.to(Demo(list: mylist));
          } else {
            var value = (data[0].page - 1) * 5;
            for (var i = 0; i < value; i++) {
              mylist.add(DataClass(data: "data", orginal: false, page: value));
            }

            data.forEach((element) {
              mylist.add(element);
            });

            Get.to(Demo(
              list: mylist,
              isDuplicate: true,
            ));
          }
        })),
        body: Center(
          child: TextButton(onPressed: (() {}), child: Text("Click")),
        ));
  }
}

class Demo extends StatefulWidget {
  RxList<DataClass> list;
  bool isDuplicate;
  Demo({Key? key, required this.list, this.isDuplicate = false})
      : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  late RxList orginal;

  @override
  void initState() {
    orginal = widget.list; // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addData({required int list}) {
      var count = list;
      if ((list % 5) == 0) {
        print("workng");
        List<DataClass> data = [
          DataClass(data: "data 15", orginal: true, page: 5),
          DataClass(data: "data 16", orginal: true, page: 5),
          DataClass(data: "data 17", orginal: true, page: 5),
          DataClass(data: "data 18", orginal: true, page: 5),
          DataClass(data: "data 19", orginal: true, page: 5),
        ];

        data.reversed.forEach((element) {
          var temp = (count - 1);
          count = temp;

          orginal[count] = element;

          print("working $temp");
        });
      }
    }

    return Scaffold(
      body: Swiper(
        index: 24,
        loop: false,
        itemCount: orginal.length,
        scrollDirection: Axis.vertical,
        onIndexChanged: (value) {
          if (widget.isDuplicate) {
            addData(list: value);
          }
        },
        itemBuilder: ((context, index) {
          log("check--->${orginal.length}");

          return SizedBox(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(orginal[index].data),
                Text(orginal[index].orginal.toString()),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class DataClass {
  final bool orginal;
  final String data;
  final int page;

  DataClass({required this.data, required this.orginal, required this.page});
}

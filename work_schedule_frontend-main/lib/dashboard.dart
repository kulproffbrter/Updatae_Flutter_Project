import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:work_schedule/Work.dart';
import 'package:work_schedule/http.dart';
import 'package:work_schedule/UpdateWork.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  List<Map<String, dynamic>> workList = [{}];
  Future<List<Map<String, dynamic>>> getAllWork() async {
    try {
      var response = await http.get(Uri.parse(getAllwork),
          headers: {"Content-Type": "application/json"});
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse != null) {
        if (jsonResponse is List) {
          workList = List<Map<String, dynamic>>.from(jsonResponse);
        } else if (jsonResponse is Map) {
          workList.add(Map<String, dynamic>.from(jsonResponse));
        } else {
          throw ("Invalid response format");
        }

        // ตัวแปร workList ตอนนี้มีรายการงานทั้งหมดจาก API

        return workList;
      } else {
        throw ("No data received");
      }
    } catch (error) {
      throw error;
    }
  }

  /* @override
void initState() {
  super.initState();
  getAllWork();
}

Future<void> getAllWork() async {
  try {
    var response = await http.get(Uri.parse(getAllwork),
        headers: {"Content-Type": "application/json"});
    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse != null) {
      if (jsonResponse is List) {
        setState(() {
          workList = List<Map<String, dynamic>>.from(jsonResponse);
        });
      } else if (jsonResponse is Map) {
        setState(() {
          workList.add(Map<String, dynamic>.from(jsonResponse));
        });
      } else {
        throw ("Invalid response format");
      }
    } else {
      throw ("No data received");
    }
  } catch (error) {
    throw error;
  }
}

 @override
   void didChangeDependencies() {
   super.didChangeDependencies();
    getAllWork();
   }
    setState(() {
  workList.removeAt(index);
}); */

  Future<void> deleteWork(int index) async {
    try {
      var response = await http.delete(
        Uri.parse(
            '$getAllwork/$index'), // เพิ่ม index ใน URL เพื่อระบุรายการที่ต้องการลบ
        headers: {
          "Content-Type": "application/json",
        },
      );
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DashboardPage()));
      } else {
        throw ("ลบผิดพลาด");
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ตารางงานของฉัน',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UpdateMyHomePage(title: 'ตารางงานของฉัน'),
    );
  }
}

class UpdateMyHomePage extends StatefulWidget {
  const UpdateMyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _UpdateMyHomePageState createState() => _UpdateMyHomePageState();
}

class _UpdateMyHomePageState extends State<UpdateMyHomePage> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFCA79),
        title: PreferredSize(
          preferredSize: Size.fromHeight(80.0), // กำหนดความสูงของ AppBar
          child: Container(
            alignment: Alignment.center,
            child: Text(widget.title),
          ),
        ),
        actions: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 30.0), // เพิ่มระยะห่างด้านขวา 30px
              child: IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  //getAllWork();
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 243, 223, 192),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0), // เพิ่มระยะห่างด้านบน 20px
          child: Container(
            width: 400,
            height: 230,
            child: Card(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'header',
                          //'$headers',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('วันเริ่มต้น')
                            //Text('วันเริ่มต้น: $startDate $startTime')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('วันครบกำหนด')
                            //Text('วันครบกำหนด: $endDate $endTime')
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            DropdownButton<String>(
                              value: selectedValue,
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'กำลังทำ',
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text('กำลังทำ'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'แก้ไข',
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.yellow,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text('แก้ไข'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'เสร็จสิ้น',
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text('เสร็จสิ้น'),
                                    ],
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value!;
                                });
                              },
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => UpdateWorkPage(),
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.black,
                                    elevation: 5,
                                  ),
                                  child: Text('แก้ไข'),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    //deleteWork(index);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WorkPage()),
          );
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

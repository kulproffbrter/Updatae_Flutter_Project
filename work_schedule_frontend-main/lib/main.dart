import 'package:work_schedule/login.dart';
import 'package:work_schedule/Empty.dart';
import 'package:flutter/material.dart';

//Empty คือ หน้าหลักของตารางงานที่ยังไม่มีข้อมูลแสดง
//Work คือ หน้าใส่ข้อมูลหลังจากกด add ที่หน้า Empty
//Dashboard คือ หน้าตารางงานที่มีข้อมูลแสดงเป็นการ์ด
//UpdateWork คือ หน้าอัพเดตเปลี่ยนแปลงข้อมูลภายในการ์ด
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'NBU Schedule',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const EmptyPage(),
      home: const LoginPage(),
    );
  }
}

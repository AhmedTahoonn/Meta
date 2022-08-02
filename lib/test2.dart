import 'package:flutter/material.dart';

class test2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: 
        [
          Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/mysocialapp-e8928.appspot.com/o/ChatImages%2Fimage_picker4253657698144777979.png?alt=media&token=c73ff167-1ced-42a0-8e4f-2f07df392146'))
        ],
      ),
    );
  }
}

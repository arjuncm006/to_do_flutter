import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
    final _textController = TextEditingController();
    String userPost=" hbjhg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Padding(
        padding:  EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,

          children:  [
            Expanded(
                child: Container(
                  color: Colors.blueAccent,
                  child: Text(userPost
                  ),
                )),
            TextField(
              controller: _textController,   // this is assigning the controller
              decoration: InputDecoration(
                hintText: "whats on ur mind" ,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    _textController.clear();
                  },
                  icon: const Icon(Icons.clear),
                )
              ),
            ),
            MaterialButton(
                onPressed: ( ) {
                  //when the button is pressed controller will store the input text into the variable
                  setState(() {
                    userPost= _textController.text;
                  });
                },
                color: Colors.cyan,
                child: const  Text('Post', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      )
    );
  }
}

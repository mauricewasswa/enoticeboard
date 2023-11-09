import 'package:enoticeboard/customWidgets/btn_widget.dart';
import 'package:enoticeboard/nav_pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Container(
                  margin: EdgeInsets.only(top: 30,left: 50,right: 50,bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),

                  ),
                  child: Image.asset('assets/logo.png',
                    height: 200,
                    width: 200,)
              ),
              Text("Welcome!",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        'Forgot Password?',
                        style : TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        )
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25,),

              BtnWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
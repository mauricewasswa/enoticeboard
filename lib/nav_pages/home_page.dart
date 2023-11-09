import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../side_menu/Nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);


  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Color(0xff222222),
        child: Icon(Icons.add,color: Colors.white,),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text("eNoticeboard",
            style: TextStyle(
              color: Colors.white,
              // Set the text color of the title
            ))
        ,
        centerTitle: true,
        actions: <Widget>[
           Builder(
             builder: (context) {
               return IconButton(
                   onPressed: (){
                     Scaffold.of(context).openDrawer();
                   },
                   icon: Icon(Icons.notifications),
                 color: Colors.white,
               );
             }
           )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 30.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 30,
                    child: Image.asset('assets/search.png'),

                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Notices...",
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add a scrollable list of news feed items below the search
          Expanded(
            child: ListView.builder(
              itemCount: 30, // Replace with the number of items you have
              itemBuilder: (context, index) {
                // Replace this with the content for each news feed item
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Add space between the title and subtitle
                        children: [
                          Text("MUST $index"),
                          Spacer(), // Adds space between title and subtitle
                          Text("12th-08-2023 09:38Am $index"),
                        ],
                      ),
                    ),
                    Container(
                      height: 400,
                        margin: EdgeInsets.all(20),
                      decoration : BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.grey,

                      ),
                        child: Image.asset('assets/images.png'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

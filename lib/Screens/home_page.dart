import 'package:api_test/Model/image_flip.dart';
import 'package:api_test/Services/api_manager.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<ImageFlip> _flipModel;


  @override
  void initState() {
    _flipModel=Api_Manager().get_data();
    print("-----------------------------------------------");
    print(_flipModel);
    print("-----------------------------------------------");
    super.initState();
  }



  int select;
  @override
  Widget build(BuildContext context) {
    var widht1 = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Testing"),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<ImageFlip>(
            future: _flipModel,
            builder: (context,snapshot){
              if(snapshot.hasData){
              return ListView.builder(
                 itemCount: snapshot.data.data.memes.length,
                    itemBuilder: (context,index){
                   var flips = snapshot.data.data.memes[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              select = index;
                            });
                          },
                          child: Container(
                            height: 110,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color:select==index ? Colors.cyan : Colors.white,
                              borderRadius: BorderRadius.circular(9),
                              boxShadow:  [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  offset: Offset(0, 0),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  Container(
                                    height: select==index ? 80:70,
                                    width: select==index ? 80:70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(flips.url),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                           Container(
                                             width: 45,
                                             //color: Colors.green,
                                             child: Text("Name:",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold
                                          ),
                                          ),
                                           ),
                                          Container(
                                              width: widht1*0.57,
                                              //color: Colors.yellow,
                                              child: Text(flips.name)),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          //NetworkImage(flips.url),
                                          Container(
                                            width: 45,
                                            child: const Text("ID:",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          Text(flips.id),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                );
              }
              else {
                 return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            ),
      ),
    );
  }
}

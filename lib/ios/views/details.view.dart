import 'package:contacts/ios/views/address.view.dart';
import 'package:contacts/ios/views/editor-contact.view.dart';
import 'package:contacts/ios/styles.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:flutter/cupertino.dart';

class DetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget> [
          CupertinoSliverNavigationBar(
            largeTitle: Text("Contato"),
            trailing: CupertinoButton(
              child: Icon(
                CupertinoIcons.pen,
              ),
              onPressed: (){
                Navigator.push(
                  context, 
                  CupertinoPageRoute(
                    builder: (context) => EditorContactView(
                      model: ContactModel(
                        id: 1,
                        name: "Will",
                        email: "will.roc@hotmail.com",
                        phone: "00 0000-0000"
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                  width: double.infinity
                ),
                Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(200)
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: NetworkImage("https://avatars3.githubusercontent.com/u/38091277?s=400&u=840448783fb078d4e087df79c3e4f8902c45756b&v=4")
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Will",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "00 0000-0000",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  "will.roc@hotmail.com",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(
                  height: 20
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CupertinoButton(
                      child: Icon(
                        CupertinoIcons.phone
                      ), 
                      onPressed: () {}
                    ),
                    CupertinoButton(
                      child: Icon(
                        CupertinoIcons.mail
                      ), 
                      onPressed: () {}
                    ),
                    CupertinoButton(
                      child: Icon(
                        CupertinoIcons.photo_camera
                      ), 
                      onPressed: () {}
                    ),
                  ],
                ),
                SizedBox(
                  height: 20
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                            ),
                            Text(
                              "Endereço",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                              ),
                            ),
                            Text(
                              "Rua X",
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),
                            Text(
                              "Rua Y/SP",
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),
                          ],
                        ),
                      ),
                      CupertinoButton(
                        child: Icon(
                          CupertinoIcons.location
                        ), 
                        onPressed: () {
                          Navigator.push(
                            context, 
                            CupertinoPageRoute(
                              builder: (context) => AddressView(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//@dart=2.9
import 'package:flutter/material.dart';
class ReplyMessage extends StatelessWidget {
  
  const ReplyMessage({ Key key,this.messages }) : super(key: key);
final String messages;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(constraints: BoxConstraints(
maxWidth
: MediaQuery.of(context).size.width-45


      ),
      child: Card(elevation: 1,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//color: Color(0xffdcf8c6),
child: Stack(children: [
Padding(padding: const EdgeInsets.only(
left: 10
,right: 60,top: 5,bottom: 20,


),
child: Text("Hiiiiiiiiiiiiiiiiiii",style: TextStyle(fontSize: 15,color: Colors.grey[600]),),)
,Positioned(bottom: 4,right: 10,child:Text('10:20',style: TextStyle(fontSize: 15,color: Colors.grey[600])
),
)


],),

      ),
      ),
    );
  }
}
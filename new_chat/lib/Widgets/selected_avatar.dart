import 'package:flutter/material.dart';
class SelectedAvatar extends StatelessWidget {
  const SelectedAvatar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 2),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
 Stack(
  
      children: [
   CircleAvatar(
          child: Icon(Icons.person,color: Colors.white
  
          ,),
  
        
  
        )
  ,        //contact.select?
            Positioned(bottom: 4,
  
            right: 5,
  
              child:   CircleAvatar(
  
          
  
          backgroundColor: Colors.teal,
  
          radius: 11,
  
  child:Icon(Icons.clear,color: Colors.white,size :17)
  
  
  
        )
        
  
            ),
            
  
   
  
      ],
  
  ),


        ],
      ),
    );
  }
}
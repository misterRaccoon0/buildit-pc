import 'package:flutter/material.dart';

class SharedListView extends StatelessWidget {
  final int itemCount;

  const SharedListView({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemCount * 90,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: itemCount, 
        itemBuilder: (context, index) {
          return Card(
            color: const Color.fromARGB(255, 2, 1, 75),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text('Shared Build ${index + 1}',
              style: TextStyle(
                color: Colors.cyan
              ),),
              subtitle: Text('Description of build ${index + 1}',
              style: TextStyle(
                color: Colors.white
              ),),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://via.placeholder.com/50'), // Placeholder
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {

              },
            ),
          );
        },
      ),
    );
  }
}

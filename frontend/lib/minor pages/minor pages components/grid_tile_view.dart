import 'package:flutter/material.dart';

class GridTileView extends StatefulWidget {
  final ImageProvider componentPic;
  final String componentTitle;
  final String componentName;
  final Map<String, String> componentSpecs;

  GridTileView({
    required this.componentPic,
    required this.componentTitle,
    required this.componentName,
    required this.componentSpecs,
  });

  @override
  State<GridTileView> createState() => _GridTileViewState();
}

class _GridTileViewState extends State<GridTileView> with SingleTickerProviderStateMixin {
  bool isSpecsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            child: isSpecsVisible
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: widget.componentSpecs.entries.map((spec) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text(
                                '${spec.key}:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(
                                spec.value,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  )
                : Column(
                    key: ValueKey('image_and_title'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: widget.componentPic,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.componentTitle,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        widget.componentName,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
          ),

          IconButton(
            icon: Icon(
              isSpecsVisible
                  ? Icons.clear
                  : Icons.add,
            ),
            constraints: BoxConstraints(),
            onPressed: () {
              setState(() {
                isSpecsVisible = !isSpecsVisible;
              }
              );
            },
          ),
        ],
      ),
    );
  }
}

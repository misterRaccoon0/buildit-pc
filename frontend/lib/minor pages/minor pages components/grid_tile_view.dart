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
    return GestureDetector(
      onTap: () {
        setState(() {
          isSpecsVisible = !isSpecsVisible;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 8,
              offset: Offset(0, 4),
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.componentSpecs.entries.map((spec) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${spec.key}:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  spec.value,
                                  style: TextStyle(
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.w600,
                                  ),
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
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.componentTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.blue[800],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.componentName,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
            ),
            
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue[900],
              ),
              child: IconButton(
                icon: Icon(
                  isSpecsVisible ? Icons.remove : Icons.add,
                  color: Colors.white,
                ),
                constraints: BoxConstraints(),
                onPressed: () {
                  setState(() {
                    isSpecsVisible = !isSpecsVisible;
                  });
                },
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

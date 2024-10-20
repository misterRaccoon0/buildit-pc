import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 208, 223, 243),
            const Color.fromARGB(255, 141, 199, 238),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25), 
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12, 
            offset: Offset(0, -5),  
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Colors.transparent,
          selectedItemColor: const Color.fromARGB(255, 0, 70, 131), 
          unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          selectedFontSize: 14, 
          unselectedFontSize: 12,  
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.home_filled, 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.build, 1),
              label: 'Builds',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.create, 2),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.account_circle, 3),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData iconData, int index) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: isSelected ? 50 : 40,  
        width: isSelected ? 50 : 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,  
                    spreadRadius: 2,  
                    offset: Offset(0, 2),  
                  ),
                ]
              : [],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              iconData,
              size: isSelected ? 30 : 24,  
              color: isSelected ? const Color.fromARGB(255, 0, 28, 187) : const Color.fromARGB(255, 0, 70, 131),
            ),
            if (isSelected)
              Positioned(
                bottom: -6,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: 3,  
                  width: 18,  
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 70, 131),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

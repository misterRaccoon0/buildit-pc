import 'package:flutter/material.dart';
import 'package:frontend/components/component_category.dart';
import 'package:frontend/components/component_selector.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({ Key? key }) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

/*   List <Component> c_p_u_s = [];
  List <Component> g_p_u_s = [];
  List <Component> motherboards = [];
  List <Component> r_a_m_s = [];
  List <Component> storages = [];
  List <Component> p_s_u_s = []; 
 */

// TEST LIST 

  final List<Component> cpus = [
    Component(name: 'Select CPU', specs: '', price: 0, tdp: 0, imageUrl: 'https://via.placeholder.com/50'),
    Component(name: 'Intel i7adasdads', specs: '8 cores, 16 threads', price: 15000, tdp: 105 ,imageUrl: 'https://via.placeholder.com/50'),
    Component(name: 'AMD Ryzen 5 5600X', specs: '6 cores, 12 threads', price: 6000, tdp: 90 ,imageUrl: 'https://via.placeholder.com/50'),
  ];

  final List<Component> gpus = [
    Component(name: 'Select GPU', specs: '', price: 0, tdp: 0, imageUrl: 'https://via.placeholder.com/50'),
    Component(name: '3080', specs: '10GB GDDR6X', price: 35000, tdp: 175, imageUrl: 'https://via.placeholder.com/50'),
    Component(name: 'RX 6800', specs: '16GB GDDR6', price: 30000, tdp: 180, imageUrl: 'https://via.placeholder.com/50'),
  ];

  final List<Component> motherboards = [
    Component(name: 'Select Motherboard', specs: '', price: 0, tdp: 0, imageUrl: 'https://via.placeholder.com/50'),
    Component(name: 'ASUS B550', specs: 'AM4, ATX', price: 15000, tdp: 60, imageUrl: 'https://via.placeholder.com/50'),
    Component(name: 'MSI B550 Gaming', specs: 'AM4, ATX', price: 15000, tdp: 60, imageUrl: 'https://via.placeholder.com/50'),
  ];

    final List<Component> rams = [
    Component(name: 'Select RAM', specs: '', price: 0, tdp: 0, imageUrl: 'https://via.placeholder.com/50'),
    Component(name: 'Corsair Vengeance 16GB', specs: 'DDR4', price: 5000,  tdp: 30, imageUrl: 'https://via.placeholder.com/50'),
    Component(name: 'G.Skill Ripjaws 16GB', specs: 'DDR4', price: 4800,  tdp: 30, imageUrl: 'https://via.placeholder.com/50'),
  ];

  final List<Component> storages = [
    Component(name: 'Select Storage', specs: '', price: 0, tdp: 0, imageUrl: 'https://via.placeholder.com/50'),
    Component(name: 'Samsung 970 EVO 1TB', specs: 'SSD', price: 12000,  tdp: 5, imageUrl: 'https://via.placeholder.com/50'),
    Component(name: 'Seagate Barracuda 2TB', specs: 'HDD', price: 4000,  tdp: 5, imageUrl: 'https://via.placeholder.com/50'),
  ];

  final List<Component> powerSupplies = [
    Component(name: 'Select Power Supply', specs: '', price: 0, tdp: 0, imageUrl: 'https://via.placeholder.com/50'),
    Component(name: 'Corsair 750W', specs: '80+ Gold', price: 6000, tdp: 0,imageUrl: 'https://via.placeholder.com/50'),
    Component(name: 'EVGA 600W', specs: '80+ Bronze', price: 4000, tdp: 0,imageUrl: 'https://via.placeholder.com/50'),
  ];

// END OF TEST LIST

  String selectedCPU = '';
  String selectedGPU = '';
  String selectedMotherboard = '';
  String selectedRAM = '';
  String selectedStorage = '';
  String selectedPowerSupply = '';

int getTotalPrice() {
  int totalPrice = 0;

  if (selectedCPU != 'Select CPU') {
    totalPrice += cpus.firstWhere((c) => c.name == selectedCPU, orElse: () => Component(name: '', specs: '', price: 0, tdp: 0, imageUrl: '')).price;
  }

  if (selectedGPU != 'Select GPU') {
    totalPrice += gpus.firstWhere((g) => g.name == selectedGPU, orElse: () => Component(name: '', specs: '', price: 0, tdp: 0, imageUrl: '')).price;
  }

  if (selectedMotherboard != 'Select Motherboard') {
    totalPrice += motherboards.firstWhere((m) => m.name == selectedMotherboard, orElse: () => Component(name: '', specs: '', price: 0, tdp: 0, imageUrl: '')).price;
  }

  if (selectedRAM != 'Select RAM') {
    totalPrice += rams.firstWhere((r) => r.name == selectedRAM, orElse: () => Component(name: '', specs: '', price: 0, tdp: 0, imageUrl: '')).price;
  }

  if (selectedStorage != 'Select Storage') {
    totalPrice += storages.firstWhere((s) => s.name == selectedStorage, orElse: () => Component(name: '', specs: '', price: 0, tdp: 0, imageUrl: '')).price;
  }

  if (selectedPowerSupply != 'Select Power Supply') {
    totalPrice += powerSupplies.firstWhere((p) => p.name == selectedPowerSupply, orElse: () => Component(name: '', specs: '', price: 0, tdp: 0, imageUrl: '')).price;
  }

  return totalPrice;
}

int getTDP() {
  int totalTDP = 0;

  if (selectedCPU != 'Select CPU') {
    totalTDP += cpus.firstWhere((c) => c.name == selectedCPU, orElse: () => Component(name: '', specs: '', price: 0, tdp: 0, imageUrl: '')).tdp;
  }

  if (selectedGPU != 'Select GPU') {
    totalTDP += gpus.firstWhere((g) => g.name == selectedGPU, orElse: () => Component(name: '', specs: '', price: 0, tdp: 0, imageUrl: '')).tdp;
  }

  if (selectedMotherboard != 'Select Motherboard') {
    totalTDP += motherboards.firstWhere((m) => m.name == selectedMotherboard, orElse: () => Component(name: '', specs: '', price: 0, tdp: 0, imageUrl: '')).tdp;
  }

  if (selectedRAM != 'Select RAM') {
    totalTDP += rams.firstWhere((r) => r.name == selectedRAM, orElse: () => Component(name: '', specs: '', price: 0, tdp: 0, imageUrl: '')).tdp;
  }

  if (selectedStorage != 'Select Storage') {
    totalTDP += storages.firstWhere((s) => s.name == selectedStorage, orElse: () => Component(name: '', specs: '', price: 0, tdp: 0, imageUrl: '')).tdp;
  }

  if (selectedPowerSupply != 'Select Power Supply') {
    totalTDP += powerSupplies.firstWhere((p) => p.name == selectedPowerSupply, orElse: () => Component(name: '', specs: '', price: 0, tdp: 0, imageUrl: '')).tdp;
  }

  return totalTDP;
}


// TEST LOGIC

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'C R E A T E   B U I L D',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[300],
        elevation: 0,
        actions: [

        IconButton(
          icon: Icon(Icons.refresh, color: Colors.black), 
          onPressed: () {

          },
          tooltip: 'Reset',
        ),

        IconButton(
          icon: Icon(Icons.save, color: Colors.black), 
          onPressed: () {
            
          },
          tooltip: 'Save',
        ),

        IconButton(
          icon: Icon(Icons.publish, color: Colors.black), 
          onPressed: () {
            
          },
          tooltip: 'Publish',
        ),
        const SizedBox(width: 10),
        ],
      ),
      

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ComponentCategory(
                title: 'CPU',
                components: cpus,
                initialValue: cpus[0].name,
                onChanged: (value) => setState(() => selectedCPU = value!),
              ),
              ComponentCategory(
                title: 'GPU',
                components: gpus,
                initialValue: gpus[0].name,
                onChanged: (value) => setState(() => selectedGPU = value!),
              ),
              ComponentCategory(
                title: 'MOTHERBOARD',
                components: motherboards,
                initialValue: motherboards[0].name,
                onChanged: (value) => setState(() => selectedMotherboard = value!),
              ),
              ComponentCategory(
                title: 'RAM SLOT 1',
                components: rams,
                initialValue: rams[0].name,
                onChanged: (value) => setState(() => selectedRAM = value!),
              ),
              ComponentCategory(
                title: 'RAM SLOT 2',
                components: rams,
                initialValue: rams[0].name,
                onChanged: (value) => setState(() => selectedRAM = value!),
              ),              
              ComponentCategory(
                title: 'STORAGE',
                components: storages,
                initialValue: storages[0].name,
                onChanged: (value) => setState(() => selectedStorage = value!),
              ),
              ComponentCategory(
                title: 'POWER SUPPLY',
                components: powerSupplies,
                initialValue: powerSupplies[0].name,
                onChanged: (value) => setState(() => selectedPowerSupply = value!),
              ),

              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'E S T I M A T E D   B U I L D   P R I C E  :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 87, 87, 87),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '₱ ${getTotalPrice().toStringAsFixed(2)}', 
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'R E C O M M E N D E D   P S U : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 87, 87, 87),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${getTDP().toStringAsFixed(2)}', 
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
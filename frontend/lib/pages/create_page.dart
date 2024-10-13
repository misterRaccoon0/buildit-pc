import 'package:flutter/material.dart';
import 'package:frontend/components/component_category.dart';
import 'package:frontend/services/component_service.dart';
import 'package:frontend/components/component_selector.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String selectedCPU = '';
  String selectedGPU = '';
  String selectedMotherboard = '';
  String selectedRam = '';
  String selectedStorage = '';
  String selectedPSU = '';
  
  late Future<List<Component>> futureCPU;
  late Future<List<Component>> futureGPU;
  late Future<List<Component>> futureMOBO;
  late Future<List<Component>> futureRAM;
  late Future<List<Component>> futureSTORAGE;
  late Future<List<Component>> futurePSU;



  

  @override
  void initState() {
    super.initState();
    futureCPU = ComponentService().fetchCPU(); 
    futureGPU = ComponentService().fetchGPU(); 
    futureMOBO = ComponentService().fetchMOBO(); 
    futureRAM = ComponentService().fetchRAM();
    futureSTORAGE = ComponentService().fetchSTORAGE();
    futurePSU = ComponentService().fetchPSU(); 
  }




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



      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
                FutureBuilder<List<Component>>(
                  future: futureCPU,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<Component> cpus = snapshot.data ?? [];
                      return ComponentCategory(
                        title: 'CPU',
                        components: cpus,
                        initialValue: cpus[0].name,
                        onChanged: (value) => setState(() => selectedCPU = value!),
                      );
                    } else {
                      return const Text('No CPUs available');
                    }
                  },
                ),
        
                FutureBuilder<List<Component>>(
                  future: futureGPU,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<Component> gpus = snapshot.data ?? [];
                      return ComponentCategory(
                        title: 'GPU',
                        components: gpus,
                        initialValue: gpus[0].name,
                        onChanged: (value) => setState(() => selectedGPU = value!),
                      );
                    } else {
                      return const Text('No GPUs available');
                    }
                  },
                ),
        
                FutureBuilder<List<Component>>(
                  future: futureMOBO,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<Component> motherboards = snapshot.data ?? [];
                      return ComponentCategory(
                        title: 'MOTHERBOARD',
                        components: motherboards,
                        initialValue: motherboards[0].name,
                        onChanged: (value) => setState(() => selectedMotherboard = value!),
                      );
                    } else {
                      return const Text('No Motherboard available');
                    }
                  },
                ),
        
                FutureBuilder<List<Component>>(
                  future: futureRAM,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<Component> rams = snapshot.data ?? [];
                      return ComponentCategory(
                        title: 'RAM SLOT 1',
                        components: rams,
                        initialValue: rams[0].name,
                        onChanged: (value) => setState(() => selectedRam = value!),
                      );
                    } else {
                      return const Text('No RAM available');
                    }
                  },
                ),
        
                FutureBuilder<List<Component>>(
                  future: futureRAM,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<Component> rams = snapshot.data ?? [];
                      return ComponentCategory(
                        title: 'RAM SLOT 2',
                        components: rams,
                        initialValue: rams[0].name,
                        onChanged: (value) => setState(() => selectedRam = value!),
                      );
                    } else {
                      return const Text('No RAM available');
                    }
                  },
                ),
        
                FutureBuilder<List<Component>>(
                  future: futureSTORAGE,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<Component> storages = snapshot.data ?? [];
                      return ComponentCategory(
                        title: 'STORAGE',
                        components: storages,
                        initialValue: storages[0].name,
                        onChanged: (value) => setState(() => selectedStorage = value!),
                      );
                    } else {
                      return const Text('No Storage available');
                    }
                  },
                ), 
        
                FutureBuilder<List<Component>>(
                  future: futurePSU,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<Component> psus = snapshot.data ?? [];

                      return ComponentCategory(
                        title: 'POWER SUPPLY',
                        components: psus,
                        initialValue: psus[0].name,
                        onChanged: (value) => setState(() => selectedPSU = value!),
                      );
                    } else {
                      return const Text('No PSU available');
                    }
                  },
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
                  
                SizedBox(height: 40,),

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

      
              ],
            
            ),
          ),
        ),
        
      ),
    );
  }
}

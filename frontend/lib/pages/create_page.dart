import 'package:flutter/material.dart';
import 'package:frontend/components/component_category.dart';
import 'package:frontend/services/build_service.dart';
import 'package:frontend/services/component_service.dart';
import 'package:frontend/components/component_selector.dart';
import 'package:frontend/services/userBuild.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String? selectedCPU = '';
  String? selectedGPU = '';
  String? selectedMotherboard = '';
  String? selectedRam = '';
  String? selectedStorage = '';
  String? selectedPSU = '';

  final GlobalKey<ComponentSelectorState> _cpuKey = GlobalKey<ComponentSelectorState>();
  final GlobalKey<ComponentSelectorState> _gpuKey = GlobalKey<ComponentSelectorState>();
  final GlobalKey<ComponentSelectorState> _moboKey = GlobalKey<ComponentSelectorState>();
  final GlobalKey<ComponentSelectorState> _ramKey = GlobalKey<ComponentSelectorState>();
  final GlobalKey<ComponentSelectorState> _storageKey = GlobalKey<ComponentSelectorState>();
  final GlobalKey<ComponentSelectorState> _psuKey = GlobalKey<ComponentSelectorState>();

  late Future<List<Component>> futureCPU;
  late Future<List<Component>> futureGPU;
  late Future<List<Component>> futureMOBO;
  late Future<List<Component>> futureRAM;
  late Future<List<Component>> futureSTORAGE;
  late Future<List<Component>> futurePSU;

  Map<String, Component> selectedComponents = {};
  int totalTDP = 0;
  int totalPrice = 0;
  int benchmarkScore = 0;

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

  void calculateTotalTDP() {
    setState(() {
      totalTDP = selectedComponents.values.fold(0, (sum, component) => sum + component.tdp + 25) + 100;
    });
  }

  void calculatePrice() {
    setState(() {
      totalPrice = selectedComponents.values.fold(0, (sum, component) => sum + component.price);
    });
  }

  void calculateBenchmark() {
    setState(() {
      benchmarkScore = selectedComponents.values.fold(0, (sum, component) => sum + component.benchmark);
    });
  }

  void updateComponent(String category, Component component) {
    setState(() {
      selectedComponents[category] = component;
      calculateTotalTDP();
      calculatePrice();
      calculateBenchmark();
      print('Component selected for $category: ${component.id}, ${component.name}');
    });
  }

  void resetComponent() { // HINDI GUMAGANA NANG MAAYOS!!!
    
    setState(() {
    
      _cpuKey.currentState?.resetComponentView();
      _gpuKey.currentState?.resetComponentView();
      _moboKey.currentState?.resetComponentView();
      _ramKey.currentState?.resetComponentView();
      _storageKey.currentState?.resetComponentView();
      _psuKey.currentState?.resetComponentView();

      selectedComponents.clear();
      selectedCPU = '';
      selectedGPU = '';
      selectedMotherboard = '';
      selectedRam = '';
      selectedStorage = '';
      selectedPSU = '';

      totalPrice = 0;
      totalTDP = 0;
      benchmarkScore = 0;
    });
  }

  Future<void> saveBuild() async {
    String? buildName;
    String? buildDescription;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Save Build'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Build Name'),
                onChanged: (value) {
                  buildName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description (Optional)'),
                onChanged: (value) {
                  buildDescription = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                if (buildName != null && buildName!.isNotEmpty) {
                  
                  _submitBuild(buildName!, buildDescription);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitBuild(String name, String? description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? user_id = prefs.getInt('user_id');
    
    UserBuild newBuild = UserBuild(
      id: 0, 
      name: name,
      description: description ?? '',
      cpu: selectedComponents['cpu']!.id, 
      gpu: selectedComponents['gpu']!.id,
      motherboard: selectedComponents['motherboard']!.id,
      ram: selectedComponents['ram']!.id,
      storage: selectedComponents['storage']!.id,
      psu: selectedComponents['psu']!.id,
      totalTdp: totalTDP,
      totalPrice: totalPrice.toDouble(),
      benchmarkScore: benchmarkScore,
      user_id: user_id ?? 0,
    );
    
    print(newBuild.toJson());

    try {
      BuildService buildService = BuildService();
      await buildService.createUserBuild(newBuild);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Build saved successfully!')),
      );
      resetComponent(); 
    } 
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save build: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'C R E A T E   B U I L D',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: resetComponent,
            tooltip: 'Reset',
          ),


          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: saveBuild,
            tooltip: 'Save',
          ),
          IconButton(
            icon: Icon(Icons.publish, color: Colors.white),
            onPressed: () {},
            tooltip: 'Publish',
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<Component>>(
                future: futureCPU,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: const LinearProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<Component> cpus = snapshot.data ?? [];
                    return ComponentCategory(
                      key:_cpuKey, 
                      title: 'CPU',
                      components: cpus,
                      onChanged: (value) {
                        setState(() {
                          selectedCPU = value!;
                          Component selectedComponent = cpus.firstWhere((cpu) => cpu.name == selectedCPU);
                          updateComponent('cpu', selectedComponent);  
                        });
                      },
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
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: const LinearProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<Component> gpus = snapshot.data ?? [];
                    return ComponentCategory(
                      key:_gpuKey,
                      title: 'GPU',
                      components: gpus,
                      onChanged: (value) {
                        setState(() {
                          selectedGPU = value!;
                          Component selectedComponent = gpus.firstWhere((gpu) => gpu.name == selectedGPU);
                          updateComponent('gpu', selectedComponent);
                        });
                      },
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
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: const LinearProgressIndicator()),
                    );
                    } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<Component> motherboards = snapshot.data ?? [];
                    return ComponentCategory(
                      key:_moboKey,
                      title: 'MOTHERBOARD',
                      components: motherboards,
                      onChanged: (value) {
                        setState(() {
                          selectedMotherboard = value!;
                          Component selectedComponent = motherboards.firstWhere((mobo) => mobo.name == selectedMotherboard);
                          updateComponent('motherboard', selectedComponent);
                        });
                      },
                    );
                  } else {
                    return const Text('No Motherboards available');
                  }
                },
              ),


              FutureBuilder<List<Component>>(
                future: futureRAM,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: const LinearProgressIndicator()),
                    );                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<Component> rams = snapshot.data ?? [];
                    return ComponentCategory(
                      key:_ramKey,
                      title: 'RAM',
                      components: rams,
                      onChanged: (value) {
                        setState(() {
                          selectedRam = value!;
                          Component selectedComponent = rams.firstWhere((ram) => ram.name == selectedRam);
                          updateComponent('ram', selectedComponent);
                        });
                      },
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
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: const LinearProgressIndicator()),
                    );                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<Component> storages = snapshot.data ?? [];
                    return ComponentCategory(
                      key:_storageKey,
                      title: 'STORAGE',
                      components: storages,
                      onChanged: (value) {
                        setState(() {
                          selectedStorage = value!;
                          Component selectedComponent = storages.firstWhere((storage) => storage.name == selectedStorage);
                          updateComponent('storage', selectedComponent);
                        });
                      },
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
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: const LinearProgressIndicator()),
                    );
                    } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<Component> psus = snapshot.data ?? [];
                    return ComponentCategory(
                      key:_psuKey,
                      title: 'POWER SUPPLY',
                      components: psus,
                      onChanged: (value) {
                        setState(() {
                          selectedPSU = value!;
                          Component selectedComponent = psus.firstWhere((psu) => psu.name == selectedPSU);
                          updateComponent('psu', selectedComponent);
                        });
                      },
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
                  'E S T I M A T E D   B U I L D   P R I C E :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '₱${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyan),
                ),
              ),


              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'R E C O M M E N D E D   P S U :',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${totalTDP.toString()} W',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.cyan),
                ),
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'B U I L D   S C O R E :',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${benchmarkScore.toString()}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyan ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
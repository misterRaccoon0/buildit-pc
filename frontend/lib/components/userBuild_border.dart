import 'package:flutter/material.dart';
import 'package:frontend/minor%20pages/ComparePage.dart';
import 'package:frontend/minor%20pages/userBuild_detailedView.dart';

class UserBuildBorder extends StatefulWidget {
  final int buildID;
  final String buildName;
  final String? buildDescription;
  final String? buildPic;
  final String cpu;
  final String gpu;
  final String motherboard;
  final String ram;
  final String storage;
  final String psu;
  final int? benchmarkScore;
  final String dateCreated;

  final int? cpuId;
  final int? gpuId;
  final int? motherboardId;
  final int? ramId;
  final int? storageId;
  final int? psuId;

  final Function(int) onDelete;
  final Future<void> Function(int, String?, String?) onEdit;

  const UserBuildBorder({
    super.key,
    required this.buildID,
    required this.buildName,
    this.buildDescription,
    required this.buildPic,
    required this.cpu,
    required this.gpu,
    required this.motherboard,
    required this.ram,
    required this.storage,
    required this.psu,
    this.benchmarkScore,
    required this.dateCreated,
    this.cpuId,
    this.gpuId,
    this.motherboardId,
    this.ramId,
    this.storageId,
    this.psuId,
    required this.onDelete,
    required this.onEdit
  });

  @override
  _UserBuildBorderState createState() => _UserBuildBorderState();
}

class _UserBuildBorderState extends State<UserBuildBorder> {
  bool isExpanded = false;

  void _showEditDialog(BuildContext context, int buildID, String? currentName, String? currentDescription) {
    final TextEditingController nameController = TextEditingController(text: currentName);
    final TextEditingController descriptionController = TextEditingController(text: currentDescription);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Build'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
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
                
                widget.onEdit(buildID, nameController.text, descriptionController.text); 
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 89, 255).withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ExpansionTile(
          leading: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('http://10.0.2.2:8000/${widget.buildPic ?? 'No Image Available'}'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  widget.buildName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 52, 51, 128),
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            'Created: ${widget.dateCreated}',
            style: TextStyle(color: Colors.grey[700]),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  _showModalActions(context); 
                },
              ),
            ],
          ),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          backgroundColor: isExpanded ? Colors.blue[100] : Colors.white,
          onExpansionChanged: (bool expanded) {
            setState(() {
              isExpanded = expanded;
            });
          },
          children: [
            ListTile(
              leading: const Icon(Icons.memory, color: Color.fromARGB(255, 53, 58, 121)),
              title: Text(
                "CPU: ${widget.cpu}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'lib/assets/icons/gpu.png',
                width: 24,
                height: 24,
                color: const Color.fromARGB(255, 53, 58, 121),
              ),
              title: Text(
                "GPU: ${widget.gpu}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'lib/assets/icons/motherboard.png',
                width: 24,
                height: 24,
                color: const Color.fromARGB(255, 53, 58, 121),
              ),
              title: Text(
                "Motherboard: ${widget.motherboard}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'lib/assets/icons/ram.png',
                width: 24,
                height: 24,
                color: const Color.fromARGB(255, 53, 58, 121),
              ),
              title: Text(
                "RAM: ${widget.ram}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.storage, color: Color.fromARGB(255, 53, 58, 121)),
              title: Text(
                "Storage: ${widget.storage}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.power, color: Color.fromARGB(255, 53, 58, 121)),
              title: Text(
                "PSU: ${widget.psu}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserBuildDetailedView(
                          buildID: widget.buildID,
                          buildName: widget.buildName,
                          buildPic: NetworkImage('http://10.0.2.2:8000/${widget.buildPic ?? 'default_image.png'}'),
                          cpu: widget.cpu,
                          gpu: widget.gpu,
                          motherboard: widget.motherboard,
                          ram: widget.ram,
                          storage: widget.storage,
                          psu: widget.psu,
                          buildDescription: widget.buildDescription,
                          benchmarkScore: widget.benchmarkScore ?? 0,
                          dateCreated: widget.dateCreated,
                          cpuId: widget.cpuId,
                          gpuId: widget.gpuId,
                          motherboardId: widget.motherboardId,
                          ramId: widget.ramId,
                          storageId: widget.storageId,
                          psuId: widget.psuId,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                  ),
                  child: Text(
                    'Detailed View',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[

            // EDIT

            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                _showEditDialog(context, widget.buildID, widget.buildName, widget.buildDescription);
              },
            ),

            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context); 
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Build'),
                      content: const Text('Are you sure you want to delete this build?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.onDelete(widget.buildID); 
                            Navigator.of(context).pop(); 
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            // COMPARE

            ListTile(
              leading: const Icon(Icons.compare_arrows),
              title: const Text('Compare'),
              onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComparePage(
                    buildID: widget.buildID,
                    buildName: widget.buildName,
                    buildPic: NetworkImage('http://10.0.2.2:8000/${widget.buildPic ?? 'default_image.png'}'),
                    cpu: widget.cpu,
                    gpu: widget.gpu,
                    motherboard: widget.motherboard,
                    ram: widget.ram,
                    storage: widget.storage,
                    psu: widget.psu,
                    buildDescription: widget.buildDescription,
                    benchmarkScore: widget.benchmarkScore ?? 0,
                    dateCreated: widget.dateCreated,
                    cpuId: widget.cpuId,
                    gpuId: widget.gpuId,
                    motherboardId: widget.motherboardId,
                    ramId: widget.ramId,
                    storageId: widget.storageId,
                    psuId: widget.psuId,

                  )));     
            },
            ),
          ],
        );
      },
    );
  }
}



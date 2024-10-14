import 'package:frontend/components/component_selector.dart';
import 'component_service.dart';

class CompatibilityChecker {
  static String? checkCompatibility(Map<String, Component> components) {
    // Check if the CPU and Motherboard have the same socket
    if (components['cpu'] != null && components['motherboard'] != null) {
      if (!isCpuMotherboardCompatible(components['cpu']!, components['motherboard']!)) {
        return 'Incompatible CPU and Motherboard: Different sockets';
      }
    }

    // Check if the Motherboard and RAM are compatible
    if (components['motherboard'] != null && components['ram'] != null) {
      if (!isMotherboardRamCompatible(components['motherboard']!, components['ram']!)) {
        return 'Incompatible Motherboard and RAM: Different RAM types';
      }
    }

    // Check if PSU has enough power for the selected components
    int totalTDP = components.values.fold(0, (sum, component) => sum + component.tdp);
    if (components['psu'] != null && !isPsuSufficient(components['psu']!, totalTDP)) {
      return 'Power supply is insufficient for the selected components';
    }

    return null; // If everything is compatible
  }

  // Check compatibility between CPU and Motherboard based on socket type
  static bool isCpuMotherboardCompatible(Component cpu, Component motherboard) {
    return cpu.socket == motherboard.socket;
  }

  // Check compatibility between Motherboard and RAM based on RAM type
  static bool isMotherboardRamCompatible(Component motherboard, Component ram) {
    return motherboard.ramsupport == ram.gen;
  }

  // Check if the selected power supply can handle the total power consumption (TDP)
  static bool isPsuSufficient(Component psu, int totalTDP) {
    return psu.tdp >= totalTDP;
  }
}

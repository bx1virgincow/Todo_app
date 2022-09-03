class Items {
  int id;
  String machineName;
  String machineModel;
  String machineDetails;
  // String machineImage;
  Items({
    required this.id,
    required this.machineName,
    required this.machineModel,
    required this.machineDetails,
    // required this.machineImage,
  });

  factory Items.fromString(int id, String machineName, String machineModel,
      String machineDetails, String machineImage) {
    return Items(
      id: id,
      machineName: machineName,
      machineModel: machineModel,
      machineDetails: machineDetails,
      // machineImage: machineImage
    );
  }

  factory Items.fromMap(Map<String, dynamic> mapItems) {
    return Items(
      id: mapItems['id'],
      machineName: mapItems['machineName'],
      machineModel: mapItems['machineModel'],
      machineDetails: mapItems['machineDetails'],
      // machineImage: mapItems['machineImage'] as String
    );
  }

  Map<String, dynamic> getItems() {
    return {
      'id': id,
      'machineName': machineName,
      'machineModel': machineModel,
      'machineDetails': machineDetails,
      // 'machineImage': machineImage
    };
  }

  factory Items.fromJson(Map<String, dynamic> jsonItems) => Items(
        id: jsonItems["id"],
        machineName: jsonItems["machineName"],
        machineModel: jsonItems["MachineModel"],
        machineDetails: jsonItems["machineDetails"],
        // machineImage: jsonItems["machineImage"],
      );
}

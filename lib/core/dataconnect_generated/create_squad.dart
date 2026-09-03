part of 'default.dart';

class CreateSquadVariablesBuilder {
  String name;
  String stack;

  final FirebaseDataConnect _dataConnect;
  CreateSquadVariablesBuilder(this._dataConnect, {required  this.name,required  this.stack,});
  Deserializer<CreateSquadData> dataDeserializer = (dynamic json)  => CreateSquadData.fromJson(jsonDecode(json));
  Serializer<CreateSquadVariables> varsSerializer = (CreateSquadVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSquadData, CreateSquadVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSquadData, CreateSquadVariables> ref() {
    CreateSquadVariables vars= CreateSquadVariables(name: name,stack: stack,);
    return _dataConnect.mutation("CreateSquad", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSquadSquadInsert {
  final String id;
  CreateSquadSquadInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSquadSquadInsert otherTyped = other as CreateSquadSquadInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSquadSquadInsert({
    required this.id,
  });
}

@immutable
class CreateSquadData {
  final CreateSquadSquadInsert squad_insert;
  CreateSquadData.fromJson(dynamic json):
  
  squad_insert = CreateSquadSquadInsert.fromJson(json['squad_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSquadData otherTyped = other as CreateSquadData;
    return squad_insert == otherTyped.squad_insert;
    
  }
  @override
  int get hashCode => squad_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['squad_insert'] = squad_insert.toJson();
    return json;
  }

  CreateSquadData({
    required this.squad_insert,
  });
}

@immutable
class CreateSquadVariables {
  final String name;
  final String stack;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSquadVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  stack = nativeFromJson<String>(json['stack']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSquadVariables otherTyped = other as CreateSquadVariables;
    return name == otherTyped.name && 
    stack == otherTyped.stack;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, stack.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['stack'] = nativeToJson<String>(stack);
    return json;
  }

  CreateSquadVariables({
    required this.name,
    required this.stack,
  });
}


part of 'default.dart';

class UpdateUserNameVariablesBuilder {
  String name;

  final FirebaseDataConnect _dataConnect;
  UpdateUserNameVariablesBuilder(this._dataConnect, {required  this.name,});
  Deserializer<UpdateUserNameData> dataDeserializer = (dynamic json)  => UpdateUserNameData.fromJson(jsonDecode(json));
  Serializer<UpdateUserNameVariables> varsSerializer = (UpdateUserNameVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateUserNameData, UpdateUserNameVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateUserNameData, UpdateUserNameVariables> ref() {
    UpdateUserNameVariables vars= UpdateUserNameVariables(name: name,);
    return _dataConnect.mutation("UpdateUserName", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateUserNameUserUpdate {
  final String id;
  UpdateUserNameUserUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserNameUserUpdate otherTyped = other as UpdateUserNameUserUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateUserNameUserUpdate({
    required this.id,
  });
}

@immutable
class UpdateUserNameData {
  final UpdateUserNameUserUpdate? user_update;
  UpdateUserNameData.fromJson(dynamic json):
  
  user_update = json['user_update'] == null ? null : UpdateUserNameUserUpdate.fromJson(json['user_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserNameData otherTyped = other as UpdateUserNameData;
    return user_update == otherTyped.user_update;
    
  }
  @override
  int get hashCode => user_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user_update != null) {
      json['user_update'] = user_update!.toJson();
    }
    return json;
  }

  UpdateUserNameData({
    this.user_update,
  });
}

@immutable
class UpdateUserNameVariables {
  final String name;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateUserNameVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserNameVariables otherTyped = other as UpdateUserNameVariables;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  UpdateUserNameVariables({
    required this.name,
  });
}


part of 'default.dart';

class UpdateUserTotalXpVariablesBuilder {
  int totalXp;

  final FirebaseDataConnect _dataConnect;
  UpdateUserTotalXpVariablesBuilder(this._dataConnect, {required  this.totalXp,});
  Deserializer<UpdateUserTotalXpData> dataDeserializer = (dynamic json)  => UpdateUserTotalXpData.fromJson(jsonDecode(json));
  Serializer<UpdateUserTotalXpVariables> varsSerializer = (UpdateUserTotalXpVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateUserTotalXpData, UpdateUserTotalXpVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateUserTotalXpData, UpdateUserTotalXpVariables> ref() {
    UpdateUserTotalXpVariables vars= UpdateUserTotalXpVariables(totalXp: totalXp,);
    return _dataConnect.mutation("UpdateUserTotalXp", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateUserTotalXpUserUpdate {
  final String id;
  UpdateUserTotalXpUserUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserTotalXpUserUpdate otherTyped = other as UpdateUserTotalXpUserUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateUserTotalXpUserUpdate({
    required this.id,
  });
}

@immutable
class UpdateUserTotalXpData {
  final UpdateUserTotalXpUserUpdate? user_update;
  UpdateUserTotalXpData.fromJson(dynamic json):
  
  user_update = json['user_update'] == null ? null : UpdateUserTotalXpUserUpdate.fromJson(json['user_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserTotalXpData otherTyped = other as UpdateUserTotalXpData;
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

  UpdateUserTotalXpData({
    this.user_update,
  });
}

@immutable
class UpdateUserTotalXpVariables {
  final int totalXp;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateUserTotalXpVariables.fromJson(Map<String, dynamic> json):
  
  totalXp = nativeFromJson<int>(json['totalXp']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserTotalXpVariables otherTyped = other as UpdateUserTotalXpVariables;
    return totalXp == otherTyped.totalXp;
    
  }
  @override
  int get hashCode => totalXp.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['totalXp'] = nativeToJson<int>(totalXp);
    return json;
  }

  UpdateUserTotalXpVariables({
    required this.totalXp,
  });
}


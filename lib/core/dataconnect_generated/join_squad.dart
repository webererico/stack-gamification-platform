part of 'default.dart';

class JoinSquadVariablesBuilder {
  String squadId;
  int newMemberCount;

  final FirebaseDataConnect _dataConnect;
  JoinSquadVariablesBuilder(this._dataConnect, {required  this.squadId,required  this.newMemberCount,});
  Deserializer<JoinSquadData> dataDeserializer = (dynamic json)  => JoinSquadData.fromJson(jsonDecode(json));
  Serializer<JoinSquadVariables> varsSerializer = (JoinSquadVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<JoinSquadData, JoinSquadVariables>> execute() {
    return ref().execute();
  }

  MutationRef<JoinSquadData, JoinSquadVariables> ref() {
    JoinSquadVariables vars= JoinSquadVariables(squadId: squadId,newMemberCount: newMemberCount,);
    return _dataConnect.mutation("JoinSquad", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class JoinSquadUserUpdate {
  final String id;
  JoinSquadUserUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final JoinSquadUserUpdate otherTyped = other as JoinSquadUserUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  JoinSquadUserUpdate({
    required this.id,
  });
}

@immutable
class JoinSquadSquadUpdate {
  final String id;
  JoinSquadSquadUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final JoinSquadSquadUpdate otherTyped = other as JoinSquadSquadUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  JoinSquadSquadUpdate({
    required this.id,
  });
}

@immutable
class JoinSquadData {
  final JoinSquadUserUpdate? user_update;
  final JoinSquadSquadUpdate? squad_update;
  JoinSquadData.fromJson(dynamic json):
  
  user_update = json['user_update'] == null ? null : JoinSquadUserUpdate.fromJson(json['user_update']),
  squad_update = json['squad_update'] == null ? null : JoinSquadSquadUpdate.fromJson(json['squad_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final JoinSquadData otherTyped = other as JoinSquadData;
    return user_update == otherTyped.user_update && 
    squad_update == otherTyped.squad_update;
    
  }
  @override
  int get hashCode => Object.hashAll([user_update.hashCode, squad_update.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user_update != null) {
      json['user_update'] = user_update!.toJson();
    }
    if (squad_update != null) {
      json['squad_update'] = squad_update!.toJson();
    }
    return json;
  }

  JoinSquadData({
    this.user_update,
    this.squad_update,
  });
}

@immutable
class JoinSquadVariables {
  final String squadId;
  final int newMemberCount;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  JoinSquadVariables.fromJson(Map<String, dynamic> json):
  
  squadId = nativeFromJson<String>(json['squadId']),
  newMemberCount = nativeFromJson<int>(json['newMemberCount']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final JoinSquadVariables otherTyped = other as JoinSquadVariables;
    return squadId == otherTyped.squadId && 
    newMemberCount == otherTyped.newMemberCount;
    
  }
  @override
  int get hashCode => Object.hashAll([squadId.hashCode, newMemberCount.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['squadId'] = nativeToJson<String>(squadId);
    json['newMemberCount'] = nativeToJson<int>(newMemberCount);
    return json;
  }

  JoinSquadVariables({
    required this.squadId,
    required this.newMemberCount,
  });
}


part of 'default.dart';

class ListSquadMembersVariablesBuilder {
  String squadId;

  final FirebaseDataConnect _dataConnect;
  ListSquadMembersVariablesBuilder(this._dataConnect, {required  this.squadId,});
  Deserializer<ListSquadMembersData> dataDeserializer = (dynamic json)  => ListSquadMembersData.fromJson(jsonDecode(json));
  Serializer<ListSquadMembersVariables> varsSerializer = (ListSquadMembersVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListSquadMembersData, ListSquadMembersVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListSquadMembersData, ListSquadMembersVariables> ref() {
    ListSquadMembersVariables vars= ListSquadMembersVariables(squadId: squadId,);
    return _dataConnect.query("ListSquadMembers", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListSquadMembersUsers {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final int totalXp;
  ListSquadMembersUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  email = nativeFromJson<String>(json['email']),
  photoUrl = json['photoUrl'] == null ? null : nativeFromJson<String>(json['photoUrl']),
  totalXp = nativeFromJson<int>(json['totalXp']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSquadMembersUsers otherTyped = other as ListSquadMembersUsers;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    email == otherTyped.email && 
    photoUrl == otherTyped.photoUrl && 
    totalXp == otherTyped.totalXp;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, email.hashCode, photoUrl.hashCode, totalXp.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['email'] = nativeToJson<String>(email);
    if (photoUrl != null) {
      json['photoUrl'] = nativeToJson<String?>(photoUrl);
    }
    json['totalXp'] = nativeToJson<int>(totalXp);
    return json;
  }

  ListSquadMembersUsers({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.totalXp,
  });
}

@immutable
class ListSquadMembersData {
  final List<ListSquadMembersUsers> users;
  ListSquadMembersData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => ListSquadMembersUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSquadMembersData otherTyped = other as ListSquadMembersData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  ListSquadMembersData({
    required this.users,
  });
}

@immutable
class ListSquadMembersVariables {
  final String squadId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListSquadMembersVariables.fromJson(Map<String, dynamic> json):
  
  squadId = nativeFromJson<String>(json['squadId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSquadMembersVariables otherTyped = other as ListSquadMembersVariables;
    return squadId == otherTyped.squadId;
    
  }
  @override
  int get hashCode => squadId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['squadId'] = nativeToJson<String>(squadId);
    return json;
  }

  ListSquadMembersVariables({
    required this.squadId,
  });
}


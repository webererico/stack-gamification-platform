part of 'default.dart';

class GetUserVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetUserVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetUserData> dataDeserializer = (dynamic json)  => GetUserData.fromJson(jsonDecode(json));
  Serializer<GetUserVariables> varsSerializer = (GetUserVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserData, GetUserVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetUserData, GetUserVariables> ref() {
    GetUserVariables vars= GetUserVariables(id: id,);
    return _dataConnect.query("GetUser", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetUserUser {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final int totalXp;
  final Timestamp createdAt;
  final GetUserUserSquad? squad;
  GetUserUser.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  email = nativeFromJson<String>(json['email']),
  photoUrl = json['photoUrl'] == null ? null : nativeFromJson<String>(json['photoUrl']),
  totalXp = nativeFromJson<int>(json['totalXp']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  squad = json['squad'] == null ? null : GetUserUserSquad.fromJson(json['squad']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserUser otherTyped = other as GetUserUser;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    email == otherTyped.email && 
    photoUrl == otherTyped.photoUrl && 
    totalXp == otherTyped.totalXp && 
    createdAt == otherTyped.createdAt && 
    squad == otherTyped.squad;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, email.hashCode, photoUrl.hashCode, totalXp.hashCode, createdAt.hashCode, squad.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['email'] = nativeToJson<String>(email);
    if (photoUrl != null) {
      json['photoUrl'] = nativeToJson<String?>(photoUrl);
    }
    json['totalXp'] = nativeToJson<int>(totalXp);
    json['createdAt'] = createdAt.toJson();
    if (squad != null) {
      json['squad'] = squad!.toJson();
    }
    return json;
  }

  GetUserUser({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.totalXp,
    required this.createdAt,
    this.squad,
  });
}

@immutable
class GetUserUserSquad {
  final String id;
  final String name;
  final String stack;
  final int memberCount;
  GetUserUserSquad.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  stack = nativeFromJson<String>(json['stack']),
  memberCount = nativeFromJson<int>(json['memberCount']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserUserSquad otherTyped = other as GetUserUserSquad;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    stack == otherTyped.stack && 
    memberCount == otherTyped.memberCount;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, stack.hashCode, memberCount.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['stack'] = nativeToJson<String>(stack);
    json['memberCount'] = nativeToJson<int>(memberCount);
    return json;
  }

  GetUserUserSquad({
    required this.id,
    required this.name,
    required this.stack,
    required this.memberCount,
  });
}

@immutable
class GetUserData {
  final GetUserUser? user;
  GetUserData.fromJson(dynamic json):
  
  user = json['user'] == null ? null : GetUserUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserData otherTyped = other as GetUserData;
    return user == otherTyped.user;
    
  }
  @override
  int get hashCode => user.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user != null) {
      json['user'] = user!.toJson();
    }
    return json;
  }

  GetUserData({
    this.user,
  });
}

@immutable
class GetUserVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserVariables otherTyped = other as GetUserVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetUserVariables({
    required this.id,
  });
}


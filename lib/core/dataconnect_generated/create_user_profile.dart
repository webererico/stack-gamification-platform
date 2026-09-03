part of 'default.dart';

class CreateUserProfileVariablesBuilder {
  String name;
  String email;

  final FirebaseDataConnect _dataConnect;
  CreateUserProfileVariablesBuilder(this._dataConnect, {required  this.name,required  this.email,});
  Deserializer<CreateUserProfileData> dataDeserializer = (dynamic json)  => CreateUserProfileData.fromJson(jsonDecode(json));
  Serializer<CreateUserProfileVariables> varsSerializer = (CreateUserProfileVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateUserProfileData, CreateUserProfileVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateUserProfileData, CreateUserProfileVariables> ref() {
    CreateUserProfileVariables vars= CreateUserProfileVariables(name: name,email: email,);
    return _dataConnect.mutation("CreateUserProfile", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateUserProfileUserInsert {
  final String id;
  CreateUserProfileUserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserProfileUserInsert otherTyped = other as CreateUserProfileUserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateUserProfileUserInsert({
    required this.id,
  });
}

@immutable
class CreateUserProfileData {
  final CreateUserProfileUserInsert user_insert;
  CreateUserProfileData.fromJson(dynamic json):
  
  user_insert = CreateUserProfileUserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserProfileData otherTyped = other as CreateUserProfileData;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  CreateUserProfileData({
    required this.user_insert,
  });
}

@immutable
class CreateUserProfileVariables {
  final String name;
  final String email;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateUserProfileVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserProfileVariables otherTyped = other as CreateUserProfileVariables;
    return name == otherTyped.name && 
    email == otherTyped.email;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, email.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  CreateUserProfileVariables({
    required this.name,
    required this.email,
  });
}


part of 'default.dart';

class UpsertGoogleProfileVariablesBuilder {
  String name;
  String email;
  Optional<String> _photoUrl = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpsertGoogleProfileVariablesBuilder photoUrl(String? t) {
   _photoUrl.value = t;
   return this;
  }

  UpsertGoogleProfileVariablesBuilder(this._dataConnect, {required  this.name,required  this.email,});
  Deserializer<UpsertGoogleProfileData> dataDeserializer = (dynamic json)  => UpsertGoogleProfileData.fromJson(jsonDecode(json));
  Serializer<UpsertGoogleProfileVariables> varsSerializer = (UpsertGoogleProfileVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpsertGoogleProfileData, UpsertGoogleProfileVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpsertGoogleProfileData, UpsertGoogleProfileVariables> ref() {
    UpsertGoogleProfileVariables vars= UpsertGoogleProfileVariables(name: name,email: email,photoUrl: _photoUrl,);
    return _dataConnect.mutation("UpsertGoogleProfile", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpsertGoogleProfileUserUpsert {
  final String id;
  UpsertGoogleProfileUserUpsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpsertGoogleProfileUserUpsert otherTyped = other as UpsertGoogleProfileUserUpsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpsertGoogleProfileUserUpsert({
    required this.id,
  });
}

@immutable
class UpsertGoogleProfileData {
  final UpsertGoogleProfileUserUpsert user_upsert;
  UpsertGoogleProfileData.fromJson(dynamic json):
  
  user_upsert = UpsertGoogleProfileUserUpsert.fromJson(json['user_upsert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpsertGoogleProfileData otherTyped = other as UpsertGoogleProfileData;
    return user_upsert == otherTyped.user_upsert;
    
  }
  @override
  int get hashCode => user_upsert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_upsert'] = user_upsert.toJson();
    return json;
  }

  UpsertGoogleProfileData({
    required this.user_upsert,
  });
}

@immutable
class UpsertGoogleProfileVariables {
  final String name;
  final String email;
  late final Optional<String>photoUrl;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpsertGoogleProfileVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  email = nativeFromJson<String>(json['email']) {
  
  
  
  
    photoUrl = Optional.optional(nativeFromJson, nativeToJson);
    photoUrl.value = json['photoUrl'] == null ? null : nativeFromJson<String>(json['photoUrl']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpsertGoogleProfileVariables otherTyped = other as UpsertGoogleProfileVariables;
    return name == otherTyped.name && 
    email == otherTyped.email && 
    photoUrl == otherTyped.photoUrl;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, email.hashCode, photoUrl.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['email'] = nativeToJson<String>(email);
    if(photoUrl.state == OptionalState.set) {
      json['photoUrl'] = photoUrl.toJson();
    }
    return json;
  }

  UpsertGoogleProfileVariables({
    required this.name,
    required this.email,
    required this.photoUrl,
  });
}


part of 'default.dart';

class UpdateUserContactVariablesBuilder {
  String email;
  Optional<String> _photoUrl = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateUserContactVariablesBuilder photoUrl(String? t) {
   _photoUrl.value = t;
   return this;
  }

  UpdateUserContactVariablesBuilder(this._dataConnect, {required  this.email,});
  Deserializer<UpdateUserContactData> dataDeserializer = (dynamic json)  => UpdateUserContactData.fromJson(jsonDecode(json));
  Serializer<UpdateUserContactVariables> varsSerializer = (UpdateUserContactVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateUserContactData, UpdateUserContactVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateUserContactData, UpdateUserContactVariables> ref() {
    UpdateUserContactVariables vars= UpdateUserContactVariables(email: email,photoUrl: _photoUrl,);
    return _dataConnect.mutation("UpdateUserContact", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateUserContactUserUpdate {
  final String id;
  UpdateUserContactUserUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserContactUserUpdate otherTyped = other as UpdateUserContactUserUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateUserContactUserUpdate({
    required this.id,
  });
}

@immutable
class UpdateUserContactData {
  final UpdateUserContactUserUpdate? user_update;
  UpdateUserContactData.fromJson(dynamic json):
  
  user_update = json['user_update'] == null ? null : UpdateUserContactUserUpdate.fromJson(json['user_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserContactData otherTyped = other as UpdateUserContactData;
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

  UpdateUserContactData({
    this.user_update,
  });
}

@immutable
class UpdateUserContactVariables {
  final String email;
  late final Optional<String>photoUrl;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateUserContactVariables.fromJson(Map<String, dynamic> json):
  
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

    final UpdateUserContactVariables otherTyped = other as UpdateUserContactVariables;
    return email == otherTyped.email && 
    photoUrl == otherTyped.photoUrl;
    
  }
  @override
  int get hashCode => Object.hashAll([email.hashCode, photoUrl.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['email'] = nativeToJson<String>(email);
    if(photoUrl.state == OptionalState.set) {
      json['photoUrl'] = photoUrl.toJson();
    }
    return json;
  }

  UpdateUserContactVariables({
    required this.email,
    required this.photoUrl,
  });
}


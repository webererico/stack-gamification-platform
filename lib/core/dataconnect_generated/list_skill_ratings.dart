part of 'default.dart';

class ListSkillRatingsVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  ListSkillRatingsVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<ListSkillRatingsData> dataDeserializer = (dynamic json)  => ListSkillRatingsData.fromJson(jsonDecode(json));
  Serializer<ListSkillRatingsVariables> varsSerializer = (ListSkillRatingsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListSkillRatingsData, ListSkillRatingsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListSkillRatingsData, ListSkillRatingsVariables> ref() {
    ListSkillRatingsVariables vars= ListSkillRatingsVariables(userId: userId,);
    return _dataConnect.query("ListSkillRatings", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListSkillRatingsSkillRatings {
  final String skillId;
  final String name;
  final int rating;
  final String answersJson;
  final int projectsCount;
  final Timestamp updatedAt;
  ListSkillRatingsSkillRatings.fromJson(dynamic json):
  
  skillId = nativeFromJson<String>(json['skillId']),
  name = nativeFromJson<String>(json['name']),
  rating = nativeFromJson<int>(json['rating']),
  answersJson = nativeFromJson<String>(json['answersJson']),
  projectsCount = nativeFromJson<int>(json['projectsCount']),
  updatedAt = Timestamp.fromJson(json['updatedAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSkillRatingsSkillRatings otherTyped = other as ListSkillRatingsSkillRatings;
    return skillId == otherTyped.skillId && 
    name == otherTyped.name && 
    rating == otherTyped.rating && 
    answersJson == otherTyped.answersJson && 
    projectsCount == otherTyped.projectsCount && 
    updatedAt == otherTyped.updatedAt;
    
  }
  @override
  int get hashCode => Object.hashAll([skillId.hashCode, name.hashCode, rating.hashCode, answersJson.hashCode, projectsCount.hashCode, updatedAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['skillId'] = nativeToJson<String>(skillId);
    json['name'] = nativeToJson<String>(name);
    json['rating'] = nativeToJson<int>(rating);
    json['answersJson'] = nativeToJson<String>(answersJson);
    json['projectsCount'] = nativeToJson<int>(projectsCount);
    json['updatedAt'] = updatedAt.toJson();
    return json;
  }

  ListSkillRatingsSkillRatings({
    required this.skillId,
    required this.name,
    required this.rating,
    required this.answersJson,
    required this.projectsCount,
    required this.updatedAt,
  });
}

@immutable
class ListSkillRatingsData {
  final List<ListSkillRatingsSkillRatings> skillRatings;
  ListSkillRatingsData.fromJson(dynamic json):
  
  skillRatings = (json['skillRatings'] as List<dynamic>)
        .map((e) => ListSkillRatingsSkillRatings.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSkillRatingsData otherTyped = other as ListSkillRatingsData;
    return skillRatings == otherTyped.skillRatings;
    
  }
  @override
  int get hashCode => skillRatings.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['skillRatings'] = skillRatings.map((e) => e.toJson()).toList();
    return json;
  }

  ListSkillRatingsData({
    required this.skillRatings,
  });
}

@immutable
class ListSkillRatingsVariables {
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListSkillRatingsVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSkillRatingsVariables otherTyped = other as ListSkillRatingsVariables;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  ListSkillRatingsVariables({
    required this.userId,
  });
}


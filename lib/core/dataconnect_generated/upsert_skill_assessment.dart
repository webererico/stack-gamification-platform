part of 'default.dart';

class UpsertSkillAssessmentVariablesBuilder {
  String skillId;
  String name;
  int rating;
  String answersJson;
  int projectsCount;

  final FirebaseDataConnect _dataConnect;
  UpsertSkillAssessmentVariablesBuilder(this._dataConnect, {required  this.skillId,required  this.name,required  this.rating,required  this.answersJson,required  this.projectsCount,});
  Deserializer<UpsertSkillAssessmentData> dataDeserializer = (dynamic json)  => UpsertSkillAssessmentData.fromJson(jsonDecode(json));
  Serializer<UpsertSkillAssessmentVariables> varsSerializer = (UpsertSkillAssessmentVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpsertSkillAssessmentData, UpsertSkillAssessmentVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpsertSkillAssessmentData, UpsertSkillAssessmentVariables> ref() {
    UpsertSkillAssessmentVariables vars= UpsertSkillAssessmentVariables(skillId: skillId,name: name,rating: rating,answersJson: answersJson,projectsCount: projectsCount,);
    return _dataConnect.mutation("UpsertSkillAssessment", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpsertSkillAssessmentSkillRatingUpsert {
  final String userId;
  final String skillId;
  UpsertSkillAssessmentSkillRatingUpsert.fromJson(dynamic json):
  
  userId = nativeFromJson<String>(json['userId']),
  skillId = nativeFromJson<String>(json['skillId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpsertSkillAssessmentSkillRatingUpsert otherTyped = other as UpsertSkillAssessmentSkillRatingUpsert;
    return userId == otherTyped.userId && 
    skillId == otherTyped.skillId;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, skillId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['skillId'] = nativeToJson<String>(skillId);
    return json;
  }

  UpsertSkillAssessmentSkillRatingUpsert({
    required this.userId,
    required this.skillId,
  });
}

@immutable
class UpsertSkillAssessmentData {
  final UpsertSkillAssessmentSkillRatingUpsert skillRating_upsert;
  UpsertSkillAssessmentData.fromJson(dynamic json):
  
  skillRating_upsert = UpsertSkillAssessmentSkillRatingUpsert.fromJson(json['skillRating_upsert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpsertSkillAssessmentData otherTyped = other as UpsertSkillAssessmentData;
    return skillRating_upsert == otherTyped.skillRating_upsert;
    
  }
  @override
  int get hashCode => skillRating_upsert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['skillRating_upsert'] = skillRating_upsert.toJson();
    return json;
  }

  UpsertSkillAssessmentData({
    required this.skillRating_upsert,
  });
}

@immutable
class UpsertSkillAssessmentVariables {
  final String skillId;
  final String name;
  final int rating;
  final String answersJson;
  final int projectsCount;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpsertSkillAssessmentVariables.fromJson(Map<String, dynamic> json):
  
  skillId = nativeFromJson<String>(json['skillId']),
  name = nativeFromJson<String>(json['name']),
  rating = nativeFromJson<int>(json['rating']),
  answersJson = nativeFromJson<String>(json['answersJson']),
  projectsCount = nativeFromJson<int>(json['projectsCount']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpsertSkillAssessmentVariables otherTyped = other as UpsertSkillAssessmentVariables;
    return skillId == otherTyped.skillId && 
    name == otherTyped.name && 
    rating == otherTyped.rating && 
    answersJson == otherTyped.answersJson && 
    projectsCount == otherTyped.projectsCount;
    
  }
  @override
  int get hashCode => Object.hashAll([skillId.hashCode, name.hashCode, rating.hashCode, answersJson.hashCode, projectsCount.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['skillId'] = nativeToJson<String>(skillId);
    json['name'] = nativeToJson<String>(name);
    json['rating'] = nativeToJson<int>(rating);
    json['answersJson'] = nativeToJson<String>(answersJson);
    json['projectsCount'] = nativeToJson<int>(projectsCount);
    return json;
  }

  UpsertSkillAssessmentVariables({
    required this.skillId,
    required this.name,
    required this.rating,
    required this.answersJson,
    required this.projectsCount,
  });
}


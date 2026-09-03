part of 'default.dart';

class ListSquadsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListSquadsVariablesBuilder(this._dataConnect, );
  Deserializer<ListSquadsData> dataDeserializer = (dynamic json)  => ListSquadsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListSquadsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListSquadsData, void> ref() {
    
    return _dataConnect.query("ListSquads", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListSquadsSquads {
  final String id;
  final String name;
  final String stack;
  final int memberCount;
  ListSquadsSquads.fromJson(dynamic json):
  
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

    final ListSquadsSquads otherTyped = other as ListSquadsSquads;
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

  ListSquadsSquads({
    required this.id,
    required this.name,
    required this.stack,
    required this.memberCount,
  });
}

@immutable
class ListSquadsData {
  final List<ListSquadsSquads> squads;
  ListSquadsData.fromJson(dynamic json):
  
  squads = (json['squads'] as List<dynamic>)
        .map((e) => ListSquadsSquads.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSquadsData otherTyped = other as ListSquadsData;
    return squads == otherTyped.squads;
    
  }
  @override
  int get hashCode => squads.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['squads'] = squads.map((e) => e.toJson()).toList();
    return json;
  }

  ListSquadsData({
    required this.squads,
  });
}


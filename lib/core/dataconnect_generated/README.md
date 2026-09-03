# stack_up_connector SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
DefaultConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### GetUser
#### Required Arguments
```dart
String id = ...;
DefaultConnector.instance.getUser(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserData, GetUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getUser(
  id: id,
);
GetUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = DefaultConnector.instance.getUser(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListSquadMembers
#### Required Arguments
```dart
String squadId = ...;
DefaultConnector.instance.listSquadMembers(
  squadId: squadId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListSquadMembersData, ListSquadMembersVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listSquadMembers(
  squadId: squadId,
);
ListSquadMembersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String squadId = ...;

final ref = DefaultConnector.instance.listSquadMembers(
  squadId: squadId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListSquads
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listSquads().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListSquadsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listSquads();
ListSquadsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listSquads().ref();
ref.execute();

ref.subscribe(...);
```


### ListSkillRatings
#### Required Arguments
```dart
String userId = ...;
DefaultConnector.instance.listSkillRatings(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListSkillRatingsData, ListSkillRatingsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listSkillRatings(
  userId: userId,
);
ListSkillRatingsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = DefaultConnector.instance.listSkillRatings(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### CreateUserProfile
#### Required Arguments
```dart
String name = ...;
String email = ...;
DefaultConnector.instance.createUserProfile(
  name: name,
  email: email,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateUserProfileData, CreateUserProfileVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createUserProfile(
  name: name,
  email: email,
);
CreateUserProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
String email = ...;

final ref = DefaultConnector.instance.createUserProfile(
  name: name,
  email: email,
).ref();
ref.execute();
```


### UpsertGoogleProfile
#### Required Arguments
```dart
String name = ...;
String email = ...;
DefaultConnector.instance.upsertGoogleProfile(
  name: name,
  email: email,
).execute();
```

#### Optional Arguments
We return a builder for each query. For UpsertGoogleProfile, we created `UpsertGoogleProfileBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpsertGoogleProfileVariablesBuilder {
  ...
   UpsertGoogleProfileVariablesBuilder photoUrl(String? t) {
   _photoUrl.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.upsertGoogleProfile(
  name: name,
  email: email,
)
.photoUrl(photoUrl)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<UpsertGoogleProfileData, UpsertGoogleProfileVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.upsertGoogleProfile(
  name: name,
  email: email,
);
UpsertGoogleProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
String email = ...;

final ref = DefaultConnector.instance.upsertGoogleProfile(
  name: name,
  email: email,
).ref();
ref.execute();
```


### UpdateUserContact
#### Required Arguments
```dart
String email = ...;
DefaultConnector.instance.updateUserContact(
  email: email,
).execute();
```

#### Optional Arguments
We return a builder for each query. For UpdateUserContact, we created `UpdateUserContactBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateUserContactVariablesBuilder {
  ...
   UpdateUserContactVariablesBuilder photoUrl(String? t) {
   _photoUrl.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.updateUserContact(
  email: email,
)
.photoUrl(photoUrl)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<UpdateUserContactData, UpdateUserContactVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateUserContact(
  email: email,
);
UpdateUserContactData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String email = ...;

final ref = DefaultConnector.instance.updateUserContact(
  email: email,
).ref();
ref.execute();
```


### UpdateUserName
#### Required Arguments
```dart
String name = ...;
DefaultConnector.instance.updateUserName(
  name: name,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateUserNameData, UpdateUserNameVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateUserName(
  name: name,
);
UpdateUserNameData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;

final ref = DefaultConnector.instance.updateUserName(
  name: name,
).ref();
ref.execute();
```


### UpdateUserTotalXp
#### Required Arguments
```dart
int totalXp = ...;
DefaultConnector.instance.updateUserTotalXp(
  totalXp: totalXp,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateUserTotalXpData, UpdateUserTotalXpVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateUserTotalXp(
  totalXp: totalXp,
);
UpdateUserTotalXpData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
int totalXp = ...;

final ref = DefaultConnector.instance.updateUserTotalXp(
  totalXp: totalXp,
).ref();
ref.execute();
```


### CreateSquad
#### Required Arguments
```dart
String name = ...;
String stack = ...;
DefaultConnector.instance.createSquad(
  name: name,
  stack: stack,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateSquadData, CreateSquadVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSquad(
  name: name,
  stack: stack,
);
CreateSquadData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
String stack = ...;

final ref = DefaultConnector.instance.createSquad(
  name: name,
  stack: stack,
).ref();
ref.execute();
```


### JoinSquad
#### Required Arguments
```dart
String squadId = ...;
int newMemberCount = ...;
DefaultConnector.instance.joinSquad(
  squadId: squadId,
  newMemberCount: newMemberCount,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<JoinSquadData, JoinSquadVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.joinSquad(
  squadId: squadId,
  newMemberCount: newMemberCount,
);
JoinSquadData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String squadId = ...;
int newMemberCount = ...;

final ref = DefaultConnector.instance.joinSquad(
  squadId: squadId,
  newMemberCount: newMemberCount,
).ref();
ref.execute();
```


### UpsertSkillAssessment
#### Required Arguments
```dart
String skillId = ...;
String name = ...;
int rating = ...;
String answersJson = ...;
int projectsCount = ...;
DefaultConnector.instance.upsertSkillAssessment(
  skillId: skillId,
  name: name,
  rating: rating,
  answersJson: answersJson,
  projectsCount: projectsCount,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpsertSkillAssessmentData, UpsertSkillAssessmentVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.upsertSkillAssessment(
  skillId: skillId,
  name: name,
  rating: rating,
  answersJson: answersJson,
  projectsCount: projectsCount,
);
UpsertSkillAssessmentData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String skillId = ...;
String name = ...;
int rating = ...;
String answersJson = ...;
int projectsCount = ...;

final ref = DefaultConnector.instance.upsertSkillAssessment(
  skillId: skillId,
  name: name,
  rating: rating,
  answersJson: answersJson,
  projectsCount: projectsCount,
).ref();
ref.execute();
```


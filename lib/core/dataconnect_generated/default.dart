library stack_up_connector;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'create_user_profile.dart';

part 'upsert_google_profile.dart';

part 'update_user_contact.dart';

part 'update_user_name.dart';

part 'update_user_total_xp.dart';

part 'create_squad.dart';

part 'join_squad.dart';

part 'upsert_skill_assessment.dart';

part 'get_user.dart';

part 'list_squad_members.dart';

part 'list_squads.dart';

part 'list_skill_ratings.dart';







class DefaultConnector {
  
  
  CreateUserProfileVariablesBuilder createUserProfile ({required String name, required String email, }) {
    return CreateUserProfileVariablesBuilder(dataConnect, name: name,email: email,);
  }
  
  
  UpsertGoogleProfileVariablesBuilder upsertGoogleProfile ({required String name, required String email, }) {
    return UpsertGoogleProfileVariablesBuilder(dataConnect, name: name,email: email,);
  }
  
  
  UpdateUserContactVariablesBuilder updateUserContact ({required String email, }) {
    return UpdateUserContactVariablesBuilder(dataConnect, email: email,);
  }
  
  
  UpdateUserNameVariablesBuilder updateUserName ({required String name, }) {
    return UpdateUserNameVariablesBuilder(dataConnect, name: name,);
  }
  
  
  UpdateUserTotalXpVariablesBuilder updateUserTotalXp ({required int totalXp, }) {
    return UpdateUserTotalXpVariablesBuilder(dataConnect, totalXp: totalXp,);
  }
  
  
  CreateSquadVariablesBuilder createSquad ({required String name, required String stack, }) {
    return CreateSquadVariablesBuilder(dataConnect, name: name,stack: stack,);
  }
  
  
  JoinSquadVariablesBuilder joinSquad ({required String squadId, required int newMemberCount, }) {
    return JoinSquadVariablesBuilder(dataConnect, squadId: squadId,newMemberCount: newMemberCount,);
  }
  
  
  UpsertSkillAssessmentVariablesBuilder upsertSkillAssessment ({required String skillId, required String name, required int rating, required String answersJson, required int projectsCount, }) {
    return UpsertSkillAssessmentVariablesBuilder(dataConnect, skillId: skillId,name: name,rating: rating,answersJson: answersJson,projectsCount: projectsCount,);
  }
  
  
  GetUserVariablesBuilder getUser ({required String id, }) {
    return GetUserVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListSquadMembersVariablesBuilder listSquadMembers ({required String squadId, }) {
    return ListSquadMembersVariablesBuilder(dataConnect, squadId: squadId,);
  }
  
  
  ListSquadsVariablesBuilder listSquads () {
    return ListSquadsVariablesBuilder(dataConnect, );
  }
  
  
  ListSkillRatingsVariablesBuilder listSkillRatings ({required String userId, }) {
    return ListSkillRatingsVariablesBuilder(dataConnect, userId: userId,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-east4',
    'default',
    'stack-up',
  );

  DefaultConnector({required this.dataConnect});
  static DefaultConnector get instance {
    
    return DefaultConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}

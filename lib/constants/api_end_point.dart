class ApiEndPoints {

  static const feedback = '/feedback';
  static const login = '/userpost';
  static const updateUser = '/updateuser';
  static const userRegister = '/registeruser';
  static const forgotChangePass = '/forgotchangepass';
  static const getUserForgot = '/getuserforgot?mobileno=';
  static const checkUser = '/checkuser?mobileno=';
  static const regFeedback = '$feedback/regfeedback';
  static const feedbackStatus = '$feedback/feedbackstatus';
  static const feedbackStatusByCitizenId = '$feedback/feedbackStatusbyCitizenId?citizenId=';
  static const getHomePageRoadCounts = '$feedback/getHomePageRoadCounts?stateCode=';
  static const getVillageList = '$feedback/getVillageList?stateCode=';
  static const getHabitationList = '$feedback/getHabitationList?stateCode=';
  static const getRoadList = '$feedback/getRoadList?stateCode=';
  static const getNearbyRoads = '$feedback/getNearbyRoads?stateCode=';
  static const getRoadListCategoryWise = '$feedback/getRoadListCategoryWise?levelRoadID=';
  static const getReplyForFeedback = '$feedback/getReplyForFeedback?feedbackID=';
  static const cpgramFeedbackStatus = '$feedback/cpgramfeedbackstatus';
  static const registerReminderClarificationReply = '$feedback/registerReminderClarificationReply';
  static const getReplyFileOfFeedback = '$feedback/getReplyFileOfFeedback?feedbackID=';

  static const getRoadListByBlock = '$feedback/getRoadListByBlock?blockCode=';

}
abstract class ApiErrorHandler {
  static String handelErrorMessage(int errorStatusCode){
    switch(errorStatusCode){
      case 401: return "Unauthorized";
      case 403: return "Refresh Failed";
      case 501: return "An Error Occurred, Please try again";
      default: return 'UnExpected error';
    }
  }
}
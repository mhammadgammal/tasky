abstract class ApiErrorHandler {
  static String handelErrorMessage(int errorStatusCode){
    switch(errorStatusCode){
      case 401: return "Unauthorized";
      case 403: return "Refresh Failed";
      case 501: return "An Error Occurred, Please try again";
      case 413:
        return 'Photo is too big, must be less than 1 MB';
      default: return 'UnExpected error';
    }
  }
}

class ExceptionCode {
  static const formatException = 100;
  static const httpException = 101;
  static const socketException = 102;
  static const error = 103;
  static const notFound = 404; 
  static const serverError = 500; 

}

class ExceptionMessage {
  static const formatException = "Invalid Format";
  static const httpException = "No internet";
  static const socketException = "No Internet connection";
  static const error = 'An error occurred';
  static const notFound = 'Resource not found'; 
  static const serverError = 'Internal server error'; 
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppFailure {
  String message;
  AppFailure([this.message = "Sorry, An unexpected error occured"]);

  @override
  String toString() => 'AppFailure(message: $message)';
}

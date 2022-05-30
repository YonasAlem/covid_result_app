// Register view exceptions
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// Login view Exceptions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// Genral Exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

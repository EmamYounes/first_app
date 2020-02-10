class ApiUtilities {
  static final String API_KEY = 'AIzaSyDfUx5R2STtVDMafWy8rwi3FO4ORJjardQ';
  static final String SIGN_UP_URL =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${API_KEY}';
  static final String LOGIN_URL =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${API_KEY}';
}

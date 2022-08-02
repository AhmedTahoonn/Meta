/// abstract class
abstract class LoginStates
{

}
///////////////////////////////////////////////////////////////////////////////
/// Initial state
class LoginInitialState extends LoginStates
{

}/////////////////////////////////////////////////////////////////////////
/// login states
class LoginLoadingState extends LoginStates
{

}
class LoginSuccessState extends LoginStates
{
  final String uId;

  LoginSuccessState(this.uId);
}
class LoginErrorState extends LoginStates
{
  final String error;

  LoginErrorState(this.error);
}
///////////////////////////////////////////////////////////////////////////////
/// reset password states
class RestPasswordSuccessState extends LoginStates
{

}
class RestPasswordErrorState extends LoginStates
{

}
///////////////////////////////////////////////////////////////////////////////



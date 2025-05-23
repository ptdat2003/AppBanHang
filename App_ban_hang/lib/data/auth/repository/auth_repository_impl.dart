import 'package:dartz/dartz.dart';
import '../../../domain/auth/repository/auth.dart';
import '../../../service_locator.dart';
import '../models/user.dart';
import '../models/user_creation_req.dart';
import '../models/user_signin_req.dart';
import '../source/auth_firebase_service.dart';


class AuthRepositoryImpl extends AuthRepository {


  @override
  Future<Either> signup(UserCreationReq user) async {
    return await sl<AuthFirebaseService>().signup(user);
  }

  @override
  Future<Either> getAges() async {
    return await sl<AuthFirebaseService>().getAges();
  }

  @override
  Future<Either> signin(UserSigninReq user) async {
    return await sl<AuthFirebaseService>().signin(user);
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) async {
    return await sl<AuthFirebaseService>().sendPasswordResetEmail(email);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthFirebaseService>().isLoggedIn();
  }

  @override
  Future < Either > getUser() async {
    var user = await sl < AuthFirebaseService > ().getUser();
    return user.fold(
            (error) {
          return Left(error);
        },
            (data) {
          return Right(
              UserModel.fromMap(data).toEntity()
          );
        }
    );
  }
  
  @override
  Future<Either> signout() async {
    return await sl<AuthFirebaseService>().signout();
  }

  @override
  Future<Either> checkEmailExists(String email) async {
    return await sl<AuthFirebaseService>().checkEmailExists(email);
  }
}
import 'package:get_it/get_it.dart';
import 'data/auth/repository/auth_repository_impl.dart';
import 'data/auth/source/auth_firebase_service.dart';
import 'data/category/repository/category.dart';
import 'data/order/repository/order.dart';
import 'data/product/repository/product.dart';
import 'domain/auth/repository/auth.dart';
import 'domain/auth/usecases/get_ages.dart';
import 'domain/auth/usecases/get_user.dart';
import 'domain/auth/usecases/is_logged_in.dart';
import 'domain/auth/usecases/send_password_reset_email.dart';
import 'domain/auth/usecases/siginup.dart';
import 'domain/auth/usecases/signin.dart';
import 'domain/auth/usecases/signout.dart';
import 'domain/category/repository/category.dart';
import 'domain/category/usecases/get_categories.dart';
import 'domain/order/repository/order.dart';
import 'domain/order/usecases/add_to_cart.dart';
import 'domain/order/usecases/get_cart_products.dart';
import 'domain/order/usecases/get_orders.dart';
import 'domain/order/usecases/order_registration.dart';
import 'domain/order/usecases/remove_cart_product.dart';
import 'domain/product/repository/product.dart';
import 'domain/product/usecases/add_or_remove_favorite_product.dart';
import 'domain/product/usecases/get_all_products.dart';
import 'domain/product/usecases/get_favorties_products.dart';
import 'domain/product/usecases/get_new_in.dart';
import 'domain/product/usecases/get_products_by_category_id.dart';
import 'domain/product/usecases/get_products_by_title.dart';
import 'domain/product/usecases/get_top_selling.dart';
import 'domain/product/usecases/is_favorite.dart';
import 'domain/auth/usecases/check_email_exists.dart';


final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  // Services
  sl.registerSingleton<AuthFirebaseService>(
      AuthFirebaseServiceImpl()
  );

  // Repositories
  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );

  sl.registerSingleton<CategoryRepository>(
      CategoryRepositoryImpl()
  );
  sl.registerSingleton<ProductRepository>(
      ProductRepositoryImpl()
  );
  sl.registerSingleton<OrderRepository>(
      OrderRepositoryImpl()
  );

  // Usecases
  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );

  sl.registerSingleton<GetAgesUseCase>(
      GetAgesUseCase()
  );

  sl.registerSingleton<SigninUseCase>(
      SigninUseCase()
  );
  
  sl.registerSingleton<SignoutUseCase>(
      SignoutUseCase()
  );

  sl.registerSingleton<SendPasswordResetEmailUseCase>(
      SendPasswordResetEmailUseCase()
  );

  sl.registerSingleton<IsLoggedInUseCase>(
      IsLoggedInUseCase()
  );

  sl.registerSingleton<GetUserUseCase>(
      GetUserUseCase()
  );

  sl.registerSingleton<GetCategoriesUseCase>(
      GetCategoriesUseCase()
  );
  sl.registerSingleton<GetTopSellingUseCase>(
      GetTopSellingUseCase()
  );
  sl.registerSingleton<GetNewInUseCase>(
      GetNewInUseCase()
  );
  sl.registerSingleton<GetProductsByCategoryIdUseCase>(
      GetProductsByCategoryIdUseCase()
  );
  sl.registerSingleton<GetProductsByTitleUseCase>(
      GetProductsByTitleUseCase()
  );
  sl.registerSingleton<AddToCartUseCase>(
      AddToCartUseCase()
  );
  sl.registerSingleton<GetCartProductsUseCase>(
      GetCartProductsUseCase()
  );
  sl.registerSingleton<RemoveCartProductUseCase>(
      RemoveCartProductUseCase()
  );
  sl.registerSingleton<OrderRegistrationUseCase>(
      OrderRegistrationUseCase()
  );
  sl.registerSingleton<AddOrRemoveFavoriteProductUseCase>(
      AddOrRemoveFavoriteProductUseCase()
  );
  sl.registerSingleton<IsFavoriteUseCase>(
      IsFavoriteUseCase()
  );
  sl.registerSingleton<GetFavortiesProductsUseCase>(
      GetFavortiesProductsUseCase()
  );
  sl.registerSingleton<GetOrdersUseCase>(
      GetOrdersUseCase()
  );
  sl.registerSingleton<GetAllProductsUseCase>(
      GetAllProductsUseCase(sl())
  );
  sl.registerSingleton<CheckEmailExistsUseCase>(
      CheckEmailExistsUseCase()
  );
 }

import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../domain/product/entities/product.dart';
import '../../../domain/product/repository/product.dart';
import '../models/product.dart';
import '../models/color.dart';
import '../source/product_firebase_service.dart';

class ProductRepositoryImpl extends ProductRepository {
  final List<ProductModel> _allProducts = [
    // T-Shirt (categoryId: '1')
    ProductModel(
      categoryId: '1',
      colors: [
        ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
        ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 5, 1)),
      discountedPrice: 199000,
      gender: 0,
      images: ['assets/images/categories/categories-tshirt/tshirt1.webp'],
      price: 299000,
      sizes: ['S', 'M', 'L', 'XL'],
      productId: '101',
      salesNumber: 35,
      title: 'Áo phông trơn BeYourSelfe',
    ),
    ProductModel(
      categoryId: '1',
      colors: [
        ProductColorModel(title: 'Cam', rgb: [231, 70, 37]),
        ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
        ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 5, 1)),
      discountedPrice: 189000,
      gender: 0,
      images: ['assets/images/categories/categories-tshirt/tshirt2.webp'],
      price: 289000,
      sizes: ['S', 'M', 'L', 'XL'],
      productId: '102',
      salesNumber: 32,
      title: 'Áo phông Adimanav',
    ),
    ProductModel(
      categoryId: '1',
      colors: [
        ProductColorModel(title: 'Xám', rgb: [63, 70,83]),
        ProductColorModel(title: 'Xanh lá', rgb: [0, 255, 0]),
        ProductColorModel(title: 'Vàng', rgb: [255, 255, 0]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 5, 10)),
      discountedPrice: 249000,
      gender: 0,
      images: ['assets/images/categories/categories-tshirt/tshirt3.webp'],
      price: 320000,
      sizes: ['S', 'M', 'L'],
      productId: '103',
      salesNumber: 28,
      title: 'Áo phông xám basic',
    ),
    ProductModel(
      categoryId: '1',
      colors: [
        ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
        ProductColorModel(title: 'Xanh lá', rgb: [0, 255, 0]),
        ProductColorModel(title: 'Vàng', rgb: [255, 255, 0]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 5, 10)),
      discountedPrice: 249000,
      gender: 0,
      images: ['assets/images/categories/categories-tshirt/tshirt4.jpg'],
      price: 320000,
      sizes: ['S', 'M', 'L'],
      productId: '104',
      salesNumber: 26,
      title: 'Áo phông FREEPIK',
    ),
    
    // Polo Shirt (categoryId: '2')
    ProductModel(
      categoryId: '2',
      colors: [
        ProductColorModel(title: 'Xanh dương', rgb: [35, 91, 180]),
        ProductColorModel(title: 'Đỏ', rgb: [255, 0, 0]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 4, 15)),
      discountedPrice: 299000,
      gender: 0,
      images: ['assets/images/categories/categories-poloshirt/poloshirt1.jpg'],
      price: 399000,
      sizes: ['M', 'L', 'XL'],
      productId: '105',
      salesNumber: 24,
      title: 'Áo polo thể thao',
    ),
    ProductModel(
      categoryId: '2',
      colors: [
        ProductColorModel(title: 'Xanh dương đậm', rgb: [47, 55,82]),
        ProductColorModel(title: 'Đỏ', rgb: [255, 0, 0]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 4, 15)),
      discountedPrice: 289000,
      gender: 0,
      images: ['assets/images/categories/categories-poloshirt/poloshirt2.jpg'],
      price: 389000,
      sizes: ['M', 'L', 'XL'],
      productId: '106',
      salesNumber: 22,
      title: 'Áo polo lịch lãm',
    ),
    ProductModel(
      categoryId: '2',
      colors: [
        ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
        ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
        ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 4, 20)),
      discountedPrice: 329000,
      gender: 0,
      images: ['assets/images/categories/categories-poloshirt/poloshirt3.webp'],
      price: 429000,
      sizes: ['M', 'L', 'XL', 'XXL'],
      productId: '107',
      salesNumber: 20,
      title: 'Áo polo Paris',
    ),
    ProductModel(
      categoryId: '2',
      colors: [
        ProductColorModel(title: 'Nâu caffee', rgb: [94,39, 3]),
        ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
        ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 4, 20)),
      discountedPrice: 319000,
      gender: 0,
      images: ['assets/images/categories/categories-poloshirt/poloshirt4.webp'],
      price: 419000,
      sizes: ['M', 'L', 'XL', 'XXL'],
      productId: '108',
      salesNumber: 18,
      title: 'Áo polo quý ông',
    ),
    
    // Croptop (categoryId: '3')
    ProductModel(
      categoryId: '3',
      colors: [
        ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
        ProductColorModel(title: 'Hồng', rgb: [255, 192, 203]),
        ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 6, 5)),
      discountedPrice: 249000,
      gender: 1,
      images: ['assets/images/categories/categories-croptop/croptop1.webp'],
      price: 349000,
      sizes: ['S', 'M', 'L'],
      productId: '109',
      salesNumber: 42,
      title: 'Áo croptop nữ quyến rũ',
    ),
    ProductModel(
      categoryId: '3',
      colors: [
        ProductColorModel(title: 'Xanh dương nhạt', rgb: [134, 145, 164]),
        ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 6, 5)),
      discountedPrice: 239000,
      gender: 1,
      images: ['assets/images/categories/categories-croptop/croptop2.jpeg'],
      price: 339000,
      sizes: ['S', 'M', 'L'],
      productId: '110',
      salesNumber: 38,
      title: 'Áo croptop nữ công sở',
    ),
    ProductModel(
      categoryId: '3',
      colors: [
        ProductColorModel(title: 'Hồng cá tính', rgb: [178, 52, 99]),
        ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
        ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 6, 12)),
      discountedPrice: 279000,
      gender: 1,
      images: ['assets/images/categories/categories-croptop/croptop3.webp'],
      price: 379000,
      sizes: ['S', 'M', 'L'],
      productId: '111',
      salesNumber: 36,
      title: 'Áo croptop Loren Styte',
    ),
    ProductModel(
      categoryId: '3',
      colors: [
        ProductColorModel(title: 'Xanh lá', rgb: [42, 168, 121]),
        ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
        ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 6, 12)),
      discountedPrice: 269000,
      gender: 1,
      images: ['assets/images/categories/categories-croptop/croptop4.webp'],
      price: 369000,
      sizes: ['S', 'M', 'L'],
      productId: '112',
      salesNumber: 34,
      title: 'Áo croptop Basic',
    ),
    
    // Hoodie (categoryId: '4')
    ProductModel(
      categoryId: '4',
      colors: [
        ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
        ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 7, 25)),
      discountedPrice: 499000,
      gender: 0,
      images: ['assets/images/categories/categories-hoodie/hoodie1.jpg'],
      price: 699000,
      sizes: ['M', 'L', 'XL'],
      productId: '113',
      salesNumber: 17,
      title: 'Áo hoodie genZ',
    ),
    ProductModel(
      categoryId: '4',
      colors: [
        ProductColorModel(title: 'Nâu', rgb: [109, 74, 67]),
        ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
        ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 7, 25)),
      discountedPrice: 489000,
      gender: 0,
      images: ['assets/images/categories/categories-hoodie/hoodie2.jpeg'],
      price: 689000,
      sizes: ['M', 'L', 'XL'],
      productId: '114',
      salesNumber: 15,
      title: 'Áo hoodie Atino 6981',
    ),
    ProductModel(
      categoryId: '4',
      colors: [
        ProductColorModel(title: 'Xám Xanh', rgb: [36,37, 38]),
        ProductColorModel(title: 'Xanh dương', rgb: [0, 0, 128]),
        ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 7, 18)),
      discountedPrice: 549000,
      gender: 0,
      images: ['assets/images/categories/categories-hoodie/hoodie3.webp'],
      price: 749000,
      sizes: ['L', 'XL', 'XXL'],
      productId: '115',
      salesNumber: 13,
      title: 'Áo hoodie Basic',
    ),
    ProductModel(
      categoryId: '4',
      colors: [
        ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
        ProductColorModel(title: 'Xanh dương', rgb: [0, 0, 128]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 7, 18)),
      discountedPrice: 539000,
      gender: 0,
      images: ['assets/images/categories/categories-hoodie/hoodie4.webp'],
      price: 739000,
      sizes: ['L', 'XL', 'XXL'],
      productId: '116',
      salesNumber: 12,
      title: 'Áo hoodie DO MORE',
    ),
    
    // Sweater (categoryId: '5')
    ProductModel(
      categoryId: '5',
      colors: [
        ProductColorModel(title: 'Xanh lá', rgb: [4, 80, 61]),
        ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
        ProductColorModel(title: 'Xanh navy', rgb: [0, 0, 128]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 3, 10)),
      discountedPrice: 450000,
      gender: 0,
      images: ['assets/images/categories/categories-sweater/sweater1.webp'],
      price: 599000,
      sizes: ['M', 'L', 'XL', 'XXL'],
      productId: '117',
      salesNumber: 27,
      title: 'Áo sweater DAVIESISM',
    ),
    ProductModel(
      categoryId: '5',
      colors: [
        ProductColorModel(title: 'Xanh dương', rgb: [29, 32, 70]),
        ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
        ProductColorModel(title: 'Xanh navy', rgb: [0, 0, 128]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 3, 10)),
      discountedPrice: 440000,
      gender: 0,
      images: ['assets/images/categories/categories-sweater/sweater2.webp'],
      price: 589000,
      sizes: ['M', 'L', 'XL', 'XXL'],
      productId: '118',
      salesNumber: 25,
      title: 'Áo sweater MADE NOT BORN',
    ),
    ProductModel(
      categoryId: '5',
      colors: [
        ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
        ProductColorModel(title: 'Đỏ', rgb: [255, 0, 0]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 3, 15)),
      discountedPrice: 480000,
      gender: 0,
      images: ['assets/images/categories/categories-sweater/sweater3.webp'],
      price: 620000,
      sizes: ['S', 'M', 'L', 'XL'],
      productId: '119',
      salesNumber: 22,
      title: 'Áo sweater BYS',
    ),
    ProductModel(
      categoryId: '5',
      colors: [
        ProductColorModel(title: 'Xám lông chuột', rgb: [60, 62, 64]),
        ProductColorModel(title: 'Đỏ', rgb: [255, 0, 0]),
        ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 3, 15)),
      discountedPrice: 470000,
      gender: 0,
      images: ['assets/images/categories/categories-sweater/sweater4.webp'],
      price: 610000,
      sizes: ['S', 'M', 'L', 'XL'],
      productId: '120',
      salesNumber: 20,
      title: 'Áo sweater VERGENCY',
    ),
    
    // Blouse (categoryId: '6')
    ProductModel(
      categoryId: '6',
      colors: [
        ProductColorModel(title: 'Vàng dịu', rgb: [175, 155, 37]),
        ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
        ProductColorModel(title: 'Hồng nhạt', rgb: [255, 200, 210]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 5, 20)),
      discountedPrice: 399000,
      gender: 1,
      images: ['assets/images/categories/categories-blouse/blouse1.webp'],
      price: 499000,
      sizes: ['S', 'M', 'L'],
      productId: '121',
      salesNumber: 35,
      title: 'Áo blouse nữ công sở',
    ),
    ProductModel(
      categoryId: '6',
      colors: [
        ProductColorModel(title: 'Xanh nhạt', rgb: [102, 129, 158]),
        ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
        ProductColorModel(title: 'Hồng nhạt', rgb: [255, 200, 210]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 5, 20)),
      discountedPrice: 389000,
      gender: 1,
      images: ['assets/images/categories/categories-blouse/blouse2.jpg'],
      price: 489000,
      sizes: ['S', 'M', 'L'],
      productId: '122',
      salesNumber: 32,
      title: 'Áo blouse uốn lượn',
    ),
    ProductModel(
      categoryId: '6',
      colors: [
        ProductColorModel(title: 'Xanh nhạt', rgb: [102, 129, 158]),
        ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
        ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 5, 25)),
      discountedPrice: 420000,
      gender: 1,
      images: ['assets/images/categories/categories-blouse/blouse3.jpg'],
      price: 520000,
      sizes: ['S', 'M', 'L', 'XL'],
      productId: '123',
      salesNumber: 30,
      title: 'Áo blouse form rộng công sở',
    ),
    ProductModel(
      categoryId: '6',
      colors: [
        ProductColorModel(title: 'Hồng đỏ', rgb: [223, 68, 109]),
        ProductColorModel(title: 'Xanh biển', rgb: [0, 100, 200]),
        ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 5, 25)),
      discountedPrice: 410000,
      gender: 1,
      images: ['assets/images/categories/categories-blouse/blouse4.webp'],
      price: 510000,
      sizes: ['S', 'M', 'L', 'XL'],
      productId: '124',
      salesNumber: 28,
      title: 'Áo blouse quý tộc',
    ),
    
    // Turtleneck (categoryId: '7')
    ProductModel(
      categoryId: '7',
      colors: [
        ProductColorModel(title: 'Xám nhạt', rgb: [113, 115, 119]),
        ProductColorModel(title: 'Be', rgb: [245, 245, 220]),
        ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 7, 29)),
      discountedPrice: 399000,
      gender: 0,
      images: ['assets/images/categories/categories-turtleneck/turtleneck1.webp'],
      price: 599000,
      sizes: ['S', 'M', 'L'],
      productId: '125',
      salesNumber: 10,
      title: 'Áo cổ lọ xám basic',
    ),
    ProductModel(
      categoryId: '7',
      colors: [
        ProductColorModel(title: 'Xám nhạt', rgb: [113, 115, 119]),
        ProductColorModel(title: 'Be', rgb: [245, 245, 220]),
        ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 7, 29)),
      discountedPrice: 389000,
      gender: 0,
      images: ['assets/images/categories/categories-turtleneck/turtleneck2.webp'],
      price: 589000,
      sizes: ['S', 'M', 'L'],
      productId: '126',
      salesNumber: 8,
      title: 'Áo cổ lọ da lộn',
    ),
    ProductModel(
      categoryId: '7',
      colors: [
        ProductColorModel(title: 'Be', rgb: [205, 199, 188]),
        ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
        ProductColorModel(title: 'Nâu', rgb: [139, 69, 19]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 7, 15)),
      discountedPrice: 430000,
      gender: 0,
      images: ['assets/images/categories/categories-turtleneck/turtleneck3.webp'],
      price: 650000,
      sizes: ['M', 'L', 'XL'],
      productId: '127',
      salesNumber: 7,
      title: 'Áo cổ lọ len mềm',
    ),
    ProductModel(
      categoryId: '7',
      colors: [
        ProductColorModel(title: 'Xanh than', rgb: [17, 28, 42]),
        ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
        ProductColorModel(title: 'Nâu', rgb: [139, 69, 19]),
      ],
      createdDate: Timestamp.fromDate(DateTime(2024, 7, 15)),
      discountedPrice: 420000,
      gender: 0,
      images: ['assets/images/categories/categories-turtleneck/turtleneck4.webp'],
      price: 640000,
      sizes: ['M', 'L', 'XL'],
      productId: '128',
      salesNumber: 5,
      title: 'Áo cổ lọ nỉ cao cấp',
    ),
  ];

  // Danh sách sản phẩm yêu thích
  final List<String> _favoriteProductIds = [];

  @override
  Future<Either> getTopSelling() async {
    try {
      // Dữ liệu local
      var products = [
        ProductModel(
          categoryId: '1',
          colors: [
            ProductColorModel(title: 'Cam', rgb: [213, 73, 24]),
            ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
            ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),

          ],
          createdDate: Timestamp.fromDate(DateTime(2024, 5, 1)),
          discountedPrice: 199000,
          gender: 0,
          images: ['assets/images/products/T-shirt.jpg'],
          price: 299000,
          sizes: ['S', 'M', 'L', 'XL'],
          productId: '101',
          salesNumber: 35,
          title: 'Áo phông nữ MUDE',
        ),
        ProductModel(
          categoryId: '2',
          colors: [
            ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
            ProductColorModel(title: 'Xanh dương', rgb: [0, 0, 255]),
            ProductColorModel(title: 'Đỏ', rgb: [255, 0, 0]),
          ],
          createdDate: Timestamp.fromDate(DateTime(2024, 4, 15)),
          discountedPrice: 299000,
          gender: 0,
          images: ['assets/images/products/hoodie.png'],
          price: 399000,
          sizes: ['M', 'L', 'XL'],
          productId: '102',
          salesNumber: 28,
          title: 'Áo hoodie cao cấp',
        ),
        ProductModel(
          categoryId: '5',
          colors: [
            ProductColorModel(title: 'Xanh navy', rgb: [0, 0, 128]),
            ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
          ],
          createdDate: Timestamp.fromDate(DateTime(2024, 3, 10)),
          discountedPrice: 450000,
          gender: 0,
          images: ['assets/images/products/sweater.webp'],
          price: 599000,
          sizes: ['M', 'L', 'XL', 'XXL'],
          productId: '103',
          salesNumber: 25,
          title: 'Áo sweater cổ tròn',
        ),
      ];

      return Right(products.map((e) => e.toEntity()).toList());
    } catch (e) {
      return const Left('Lỗi khi lấy sản phẩm bán chạy từ local');
    }
  }

  @override
  Future<Either> getNewIn() async {
    try {
      // Dữ liệu local
      var products = [
        ProductModel(
          categoryId: '4',
          colors: [
            ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
            ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
          ],
          createdDate: Timestamp.fromDate(DateTime(2024, 7, 25)),
          discountedPrice: 499000,
          gender: 0,
          images: ['assets/images/products/hoodie2.png'],
          price: 699000,
          sizes: ['M', 'L', 'XL'],
          productId: '104',
          salesNumber: 10,
          title: 'Áo hoodie oversize',
        ),
        ProductModel(
          categoryId: '7',
          colors: [
            ProductColorModel(title: 'Be', rgb: [245, 245, 220]),
            ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
          ],
          createdDate: Timestamp.fromDate(DateTime(2024, 7, 29)),
          discountedPrice: 399000,
          gender: 0,
          images: ['assets/images/products/turtleneck.webp'],
          price: 599000,
          sizes: ['S', 'M', 'L'],
          productId: '200',
          salesNumber: 5,
          title: 'Áo cổ lọ cao cấp',
        ),
      ];

      return Right(products.map((e) => e.toEntity()).toList());
    } catch (e) {
      return const Left('Lỗi khi lấy sản phẩm mới từ local');
    }
  }

  @override
  Future<Either> getProductsByCategoryId(String categoryId) async {
    try {
      // Danh sách sản phẩm tùy thuộc vào categoryId
      List<ProductModel> products = [];
      
      if (categoryId == '1') {
        // T-Shirt category
        products = [
          ProductModel(
            categoryId: '1',
            colors: [
              ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
              ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 5, 1)),
            discountedPrice: 199000,
            gender: 0,
            images: ['assets/images/categories/categories-tshirt/tshirt1.webp'],
            price: 299000,
            sizes: ['S', 'M', 'L', 'XL'],
            productId: '101',
            salesNumber: 35,
            title: 'Áo phông trơn BeYourSelfe',
          ),
          ProductModel(
            categoryId: '1',
            colors: [
              ProductColorModel(title: 'Cam', rgb: [231, 70, 37]),
              ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
              ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 5, 1)),
            discountedPrice: 189000,
            gender: 0,
            images: ['assets/images/categories/categories-tshirt/tshirt2.webp'],
            price: 289000,
            sizes: ['S', 'M', 'L', 'XL'],
            productId: '102',
            salesNumber: 32,
            title: 'Áo phông Adimanav',
          ),
          ProductModel(
            categoryId: '1',
            colors: [
              ProductColorModel(title: 'Xám', rgb: [63, 70,83]),
              ProductColorModel(title: 'Xanh lá', rgb: [0, 255, 0]),
              ProductColorModel(title: 'Vàng', rgb: [255, 255, 0]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 5, 10)),
            discountedPrice: 249000,
            gender: 0,
            images: ['assets/images/categories/categories-tshirt/tshirt3.webp'],
            price: 320000,
            sizes: ['S', 'M', 'L'],
            productId: '103',
            salesNumber: 28,
            title: 'Áo phông xám basic',
          ),
          ProductModel(
            categoryId: '1',
            colors: [
              ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
              ProductColorModel(title: 'Xanh lá', rgb: [0, 255, 0]),
              ProductColorModel(title: 'Vàng', rgb: [255, 255, 0]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 5, 10)),
            discountedPrice: 249000,
            gender: 0,
            images: ['assets/images/categories/categories-tshirt/tshirt4.jpg'],
            price: 320000,
            sizes: ['S', 'M', 'L'],
            productId: '104',
            salesNumber: 26,
            title: 'Áo phông FREEPIK',
          ),

        ];
      } else if (categoryId == '2') {
        // Polo Shirt category
        products = [
          ProductModel(
            categoryId: '2',
            colors: [
              ProductColorModel(title: 'Xanh dương', rgb: [35, 91, 180]),
              ProductColorModel(title: 'Đỏ', rgb: [255, 0, 0]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 4, 15)),
            discountedPrice: 299000,
            gender: 0,
            images: ['assets/images/categories/categories-poloshirt/poloshirt1.jpg'],
            price: 399000,
            sizes: ['M', 'L', 'XL'],
            productId: '105',
            salesNumber: 24,
            title: 'Áo polo thể thao',
          ),
          ProductModel(
            categoryId: '2',
            colors: [
              ProductColorModel(title: 'Xanh dương đậm', rgb: [47, 55,82]),
              ProductColorModel(title: 'Đỏ', rgb: [255, 0, 0]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 4, 15)),
            discountedPrice: 289000,
            gender: 0,
            images: ['assets/images/categories/categories-poloshirt/poloshirt2.jpg'],
            price: 389000,
            sizes: ['M', 'L', 'XL'],
            productId: '106',
            salesNumber: 22,
            title: 'Áo polo lịch lãm',
          ),
          ProductModel(
            categoryId: '2',
            colors: [
              ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
              ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
              ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 4, 20)),
            discountedPrice: 329000,
            gender: 0,
            images: ['assets/images/categories/categories-poloshirt/poloshirt3.webp'],
            price: 429000,
            sizes: ['M', 'L', 'XL', 'XXL'],
            productId: '107',
            salesNumber: 20,
            title: 'Áo polo Paris',
          ),
          ProductModel(
            categoryId: '2',
            colors: [
              ProductColorModel(title: 'Nâu caffee', rgb: [94,39, 3]),
              ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
              ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 4, 20)),
            discountedPrice: 319000,
            gender: 0,
            images: ['assets/images/categories/categories-poloshirt/poloshirt4.webp'],
            price: 419000,
            sizes: ['M', 'L', 'XL', 'XXL'],
            productId: '108',
            salesNumber: 18,
            title: 'Áo polo quý ông',
          ),

        ];
      } else if (categoryId == '3') {
        // Croptop category
        products = [
          ProductModel(
            categoryId: '3',
            colors: [
              ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
              ProductColorModel(title: 'Hồng', rgb: [255, 192, 203]),
              ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 6, 5)),
            discountedPrice: 249000,
            gender: 1,
            images: ['assets/images/categories/categories-croptop/croptop1.webp'],
            price: 349000,
            sizes: ['S', 'M', 'L'],
            productId: '109',
            salesNumber: 42,
            title: 'Áo croptop nữ quyến rũ',
          ),
          ProductModel(
            categoryId: '3',
            colors: [
              ProductColorModel(title: 'Xanh dương nhạt', rgb: [134, 145, 164]),
              ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 6, 5)),
            discountedPrice: 239000,
            gender: 1,
            images: ['assets/images/categories/categories-croptop/croptop2.jpeg'],
            price: 339000,
            sizes: ['S', 'M', 'L'],
            productId: '110',
            salesNumber: 38,
            title: 'Áo croptop nữ công sở',
          ),
          ProductModel(
            categoryId: '3',
            colors: [
              ProductColorModel(title: 'Hồng cá tính', rgb: [178, 52, 99]),
              ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
              ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 6, 12)),
            discountedPrice: 279000,
            gender: 1,
            images: ['assets/images/categories/categories-croptop/croptop3.webp'],
            price: 379000,
            sizes: ['S', 'M', 'L'],
            productId: '111',
            salesNumber: 36,
            title: 'Áo croptop Loren Styte',
          ),
          ProductModel(
            categoryId: '3',
            colors: [
              ProductColorModel(title: 'Xanh lá', rgb: [42, 168, 121]),
              ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
              ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 6, 12)),
            discountedPrice: 269000,
            gender: 1,
            images: ['assets/images/categories/categories-croptop/croptop4.webp'],
            price: 369000,
            sizes: ['S', 'M', 'L'],
            productId: '112',
            salesNumber: 34,
            title: 'Áo croptop Basic',
          ),

        ];
      } else if (categoryId == '4') {
        // Hoodie category
        products = [
          ProductModel(
            categoryId: '4',
            colors: [
              ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
              ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 7, 25)),
            discountedPrice: 499000,
            gender: 0,
            images: ['assets/images/categories/categories-hoodie/hoodie1.jpg'],
            price: 699000,
            sizes: ['M', 'L', 'XL'],
            productId: '113',
            salesNumber: 17,
            title: 'Áo hoodie genZ',
          ),
          ProductModel(
            categoryId: '4',
            colors: [
              ProductColorModel(title: 'Nâu', rgb: [109, 74, 67]),
              ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
              ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 7, 25)),
            discountedPrice: 489000,
            gender: 0,
            images: ['assets/images/categories/categories-hoodie/hoodie2.jpeg'],
            price: 689000,
            sizes: ['M', 'L', 'XL'],
            productId: '114',
            salesNumber: 15,
            title: 'Áo hoodie Atino 6981',
          ),
          ProductModel(
            categoryId: '4',
            colors: [
              ProductColorModel(title: 'Xám Xanh', rgb: [36,37, 38]),
              ProductColorModel(title: 'Xanh dương', rgb: [0, 0, 128]),
              ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 7, 18)),
            discountedPrice: 549000,
            gender: 0,
            images: ['assets/images/categories/categories-hoodie/hoodie3.webp'],
            price: 749000,
            sizes: ['L', 'XL', 'XXL'],
            productId: '115',
            salesNumber: 13,
            title: 'Áo hoodie Basic',
          ),
          ProductModel(
            categoryId: '4',
            colors: [
              ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
              ProductColorModel(title: 'Xanh dương', rgb: [0, 0, 128]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 7, 18)),
            discountedPrice: 539000,
            gender: 0,
            images: ['assets/images/categories/categories-hoodie/hoodie4.webp'],
            price: 739000,
            sizes: ['L', 'XL', 'XXL'],
            productId: '116',
            salesNumber: 12,
            title: 'Áo hoodie DO MORE',
          ),
        ];
      } else if (categoryId == '5') {
        // Sweater category
        products = [
          ProductModel(
            categoryId: '5',
            colors: [
              ProductColorModel(title: 'Xanh lá', rgb: [4, 80, 61]),
              ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
              ProductColorModel(title: 'Xanh navy', rgb: [0, 0, 128]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 3, 10)),
            discountedPrice: 450000,
            gender: 0,
            images: ['assets/images/categories/categories-sweater/sweater1.webp'],
            price: 599000,
            sizes: ['M', 'L', 'XL', 'XXL'],
            productId: '117',
            salesNumber: 27,
            title: 'Áo sweater DAVIESISM',
          ),
          ProductModel(
            categoryId: '5',
            colors: [
              ProductColorModel(title: 'Xanh dương', rgb: [29, 32, 70]),
              ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
              ProductColorModel(title: 'Xanh navy', rgb: [0, 0, 128]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 3, 10)),
            discountedPrice: 440000,
            gender: 0,
            images: ['assets/images/categories/categories-sweater/sweater2.webp'],
            price: 589000,
            sizes: ['M', 'L', 'XL', 'XXL'],
            productId: '118',
            salesNumber: 25,
            title: 'Áo sweater MADE NOT BORN',
          ),
          ProductModel(
            categoryId: '5',
            colors: [
              ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
              ProductColorModel(title: 'Đỏ', rgb: [255, 0, 0]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 3, 15)),
            discountedPrice: 480000,
            gender: 0,
            images: ['assets/images/categories/categories-sweater/sweater3.webp'],
            price: 620000,
            sizes: ['S', 'M', 'L', 'XL'],
            productId: '119',
            salesNumber: 22,
            title: 'Áo sweater BYS',
          ),
          ProductModel(
            categoryId: '5',
            colors: [
              ProductColorModel(title: 'Xám lông chuột', rgb: [60, 62, 64]),
              ProductColorModel(title: 'Đỏ', rgb: [255, 0, 0]),
              ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 3, 15)),
            discountedPrice: 470000,
            gender: 0,
            images: ['assets/images/categories/categories-sweater/sweater4.webp'],
            price: 610000,
            sizes: ['S', 'M', 'L', 'XL'],
            productId: '120',
            salesNumber: 20,
            title: 'Áo sweater VERGENCY',
          ),
        ];
      } else if (categoryId == '6') {
        // Blouse category
        products = [
          ProductModel(
            categoryId: '6',
            colors: [
              ProductColorModel(title: 'Vàng dịu', rgb: [175, 155, 37]),
              ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
              ProductColorModel(title: 'Hồng nhạt', rgb: [255, 200, 210]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 5, 20)),
            discountedPrice: 399000,
            gender: 1,
            images: ['assets/images/categories/categories-blouse/blouse1.webp'],
            price: 499000,
            sizes: ['S', 'M', 'L'],
            productId: '121',
            salesNumber: 35,
            title: 'Áo blouse nữ công sở',
          ),
          ProductModel(
            categoryId: '6',
            colors: [
              ProductColorModel(title: 'Xanh nhạt', rgb: [102, 129, 158]),
              ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
              ProductColorModel(title: 'Hồng nhạt', rgb: [255, 200, 210]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 5, 20)),
            discountedPrice: 389000,
            gender: 1,
            images: ['assets/images/categories/categories-blouse/blouse2.jpg'],
            price: 489000,
            sizes: ['S', 'M', 'L'],
            productId: '122',
            salesNumber: 32,
            title: 'Áo blouse uốn lượn',
          ),
          ProductModel(
            categoryId: '6',
            colors: [
              ProductColorModel(title: 'Xanh nhạt', rgb: [102, 129, 158]),
              ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
              ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 5, 25)),
            discountedPrice: 420000,
            gender: 1,
            images: ['assets/images/categories/categories-blouse/blouse3.jpg'],
            price: 520000,
            sizes: ['S', 'M', 'L', 'XL'],
            productId: '123',
            salesNumber: 30,
            title: 'Áo blouse form rộng công sở',
          ),
          ProductModel(
            categoryId: '6',
            colors: [
              ProductColorModel(title: 'Hồng đỏ', rgb: [223, 68, 109]),
              ProductColorModel(title: 'Xanh biển', rgb: [0, 100, 200]),
              ProductColorModel(title: 'Trắng', rgb: [255, 255, 255]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 5, 25)),
            discountedPrice: 410000,
            gender: 1,
            images: ['assets/images/categories/categories-blouse/blouse4.webp'],
            price: 510000,
            sizes: ['S', 'M', 'L', 'XL'],
            productId: '124',
            salesNumber: 28,
            title: 'Áo blouse quý tộc',
          ),
        ];
      } else if (categoryId == '7') {
        // Turtleneck category
        products = [
          ProductModel(
            categoryId: '7',
            colors: [
              ProductColorModel(title: 'Xám nhạt', rgb: [113, 115, 119]),
              ProductColorModel(title: 'Be', rgb: [245, 245, 220]),
              ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 7, 29)),
            discountedPrice: 399000,
            gender: 0,
            images: ['assets/images/categories/categories-turtleneck/turtleneck1.webp'],
            price: 599000,
            sizes: ['S', 'M', 'L'],
            productId: '125',
            salesNumber: 10,
            title: 'Áo cổ lọ xám basic',
          ),
          ProductModel(
            categoryId: '7',
            colors: [
              ProductColorModel(title: 'Xám nhạt', rgb: [113, 115, 119]),
              ProductColorModel(title: 'Be', rgb: [245, 245, 220]),
              ProductColorModel(title: 'Đen', rgb: [0, 0, 0]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 7, 29)),
            discountedPrice: 389000,
            gender: 0,
            images: ['assets/images/categories/categories-turtleneck/turtleneck2.webp'],
            price: 589000,
            sizes: ['S', 'M', 'L'],
            productId: '126',
            salesNumber: 8,
            title: 'Áo cổ lọ da lộn',
          ),
          ProductModel(
            categoryId: '7',
            colors: [
              ProductColorModel(title: 'Be', rgb: [205, 199, 188]),
              ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
              ProductColorModel(title: 'Nâu', rgb: [139, 69, 19]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 7, 15)),
            discountedPrice: 430000,
            gender: 0,
            images: ['assets/images/categories/categories-turtleneck/turtleneck3.webp'],
            price: 650000,
            sizes: ['M', 'L', 'XL'],
            productId: '127',
            salesNumber: 7,
            title: 'Áo cổ lọ len mềm',
          ),
          ProductModel(
            categoryId: '7',
            colors: [
              ProductColorModel(title: 'Xanh than', rgb: [17, 28, 42]),
              ProductColorModel(title: 'Xám', rgb: [128, 128, 128]),
              ProductColorModel(title: 'Nâu', rgb: [139, 69, 19]),
            ],
            createdDate: Timestamp.fromDate(DateTime(2024, 7, 15)),
            discountedPrice: 420000,
            gender: 0,
            images: ['assets/images/categories/categories-turtleneck/turtleneck4.webp'],
            price: 640000,
            sizes: ['M', 'L', 'XL'],
            productId: '128',
            salesNumber: 5,
            title: 'Áo cổ lọ nỉ cao cấp',
          ),
        ];
      }
      
      return Right(products.map((e) => e.toEntity()).toList());
    } catch (e) {
      return const Left('Lỗi khi lấy sản phẩm theo danh mục từ local');
    }
  }

  @override
  Future<Either> getProductsByTitle(String title) async {
    try {
      // Tìm kiếm trong toàn bộ danh sách sản phẩm _allProducts
      var filteredProducts = _allProducts.where(
        (product) => product.title.toLowerCase().contains(title.toLowerCase())
      ).toList();
      
      return Right(filteredProducts.map((e) => e.toEntity()).toList());
    } catch (e) {
      return const Left('Lỗi khi tìm kiếm sản phẩm từ local');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity product) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return const Left('Bạn cần đăng nhập để thực hiện thao tác này');
      }
      
      var products = await FirebaseFirestore.instance.collection(
          "Users"
      ).doc(user.uid).collection('Favorites').where(
          'productId', isEqualTo: product.productId
      ).get();

      if (products.docs.isNotEmpty) {
        // Nếu đã là yêu thích thì bỏ yêu thích
        await products.docs.first.reference.delete();
        return const Right(false);
      } else {
        // Nếu chưa yêu thích thì thêm vào yêu thích
        await FirebaseFirestore.instance.collection(
            "Users"
        ).doc(user.uid).collection('Favorites').add(
            product.fromEntity().toMap()
        );
        return const Right(true);
      }
    } catch (e) {
      return const Left('Lỗi khi thêm/xóa sản phẩm yêu thích');
    }
  }

  @override
  Future<bool> isFavorite(String productId) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return false;
      }
      
      var products = await FirebaseFirestore.instance.collection(
          "Users"
      ).doc(user.uid).collection('Favorites').where(
          'productId', isEqualTo: productId
      ).get();

      return products.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getFavoritesProducts() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return const Left('Bạn cần đăng nhập để xem sản phẩm yêu thích');
      }
      
      var returnedData = await FirebaseFirestore.instance.collection(
          "Users"
      ).doc(user.uid).collection('Favorites').get();
      
      List<ProductModel> favoriteProducts = [];
      
      for (var doc in returnedData.docs) {
        try {
          Map<String, dynamic> data = doc.data();
          
          // Tạo ProductModel trực tiếp từ dữ liệu trong Firestore
          // Thay vì tìm kiếm trong _allProducts
          List<ProductColorModel> colors = [];
          if (data['colors'] is List) {
            colors = List<Map<String, dynamic>>.from(data['colors'])
                .map((colorMap) => ProductColorModel.fromMap(colorMap))
                .toList();
          }
          
          List<String> images = [];
          if (data['images'] is List) {
            images = List<String>.from(data['images']);
          }
          
          List<String> sizes = [];
          if (data['sizes'] is List) {
            sizes = List<String>.from(data['sizes']);
          }
          
          ProductModel product = ProductModel(
            categoryId: data['categoryId'] ?? '',
            colors: colors,
            createdDate: data['createdDate'] is Timestamp 
                ? data['createdDate'] 
                : Timestamp.now(),
            discountedPrice: data['discountedPrice'] ?? 0,
            gender: data['gender'] ?? 0,
            images: images,
            price: data['price'] ?? 0,
            sizes: sizes,
            productId: data['productId'] ?? '',
            salesNumber: data['salesNumber'] ?? 0,
            title: data['title'] ?? 'Sản phẩm không xác định',
          );
          
          favoriteProducts.add(product);
        } catch (e) {
          print('Lỗi khi xử lý sản phẩm yêu thích: $e');
        }
      }
      
      return Right(favoriteProducts.map((e) => e.toEntity()).toList());
    } catch (e) {
      print('Lỗi khi lấy danh sách sản phẩm yêu thích: $e');
      return const Left('Vui lòng thử lại');
    }
  }

  @override
  Future<Either> getAllProducts() async {
    try {
      return Right(_allProducts.map((e) => e.toEntity()).toList());
    } catch (e) {
      return const Left('Lỗi khi lấy tất cả sản phẩm từ local');
    }
  }
}
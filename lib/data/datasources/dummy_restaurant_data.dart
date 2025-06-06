import '../../domain/entities/restaurant.dart';
import '../../domain/entities/branch.dart';
import '../../domain/entities/food_item.dart';
import '../../domain/entities/food_category.dart';

class DummyRestaurantData {
  static List<Restaurant> getRestaurants() {
    return [
      Restaurant(
        id: 'lotteria',
        name: 'Lotteria',
        address: 'Thức ăn nhanh',
        imageUrl: '',
        rating: 4.4,
        reviewCount: 171,
        deliveryTime: 30,
        deliveryFee: 25000,
        originalDeliveryFee: 40000,
        categories: ['Thức ăn nhanh', 'Cơm', 'Món Quốc Tế'],
        isOpen: true,
        hasPromo: true,
        promoText: 'Giảm 16.000đ',
        branches: [
          Branch(
            id: 'lotteria_longkhanh',
            name: 'Long Khánh Hùng Vương',
            address: 'Long Khánh Hùng Vương',
            isOpen: true,
          ),
          Branch(
            id: 'lotteria_xuanhoa',
            name: 'Hùng Vương - Xuân Hòa',
            address: 'Hùng Vương - Xuân Hòa',
            isOpen: false,
            closingTime: 'Đặt đơn giao vào 10:30',
          ),
        ],
      ),
      Restaurant(
        id: 'highlands',
        name: 'Highlands Coffee',
        address: 'Cà Phê - Trà - Sinh Tố - Nước Ép',
        imageUrl: '',
        rating: 4.3,
        reviewCount: 60,
        deliveryTime: 25,
        deliveryFee: 32000,
        originalDeliveryFee: 47000,
        categories: ['Cà Phê - Trà - Sinh Tố - Nước Ép'],
        isOpen: true,
        hasPromo: true,
        promoText: 'Giảm 16.000đ',
        branches: [
          Branch(
            id: 'highlands_nguyenthiminhkhai',
            name: 'Nguyễn Thị Minh Khai - Long Khánh',
            address: 'Nguyễn Thị Minh Khai - Long Khánh',
            isOpen: true,
          ),
          Branch(
            id: 'highlands_hungvuong',
            name: 'Hùng Vương - Long Khánh',
            address: 'Hùng Vương - Long Khánh',
            isOpen: true,
          ),
        ],
      ),
      Restaurant(
        id: 'bunbo_hue',
        name: 'Bún Bò Huế Gánh Xưa',
        address: 'Mì',
        imageUrl: '',
        rating: 3.7,
        reviewCount: 10,
        deliveryTime: 25,
        deliveryFee: 24000,
        originalDeliveryFee: 39000,
        categories: ['Mì'],
        isOpen: true,
        hasPromo: true,
        promoText: 'Giảm 16.000đ',
        branches: [
          Branch(
            id: 'bunbo_single',
            name: 'Bún Bò Huế Gánh Xưa',
            address: 'Bún Bò Huế Gánh Xưa',
            isOpen: true,
          ),
        ],
      ),
      Restaurant(
        id: 'chan_ga_dinh',
        name: 'Chân gà ĐỈNH (CN Long Khánh)',
        address: 'Đồ ăn nhe',
        imageUrl: '',
        rating: 4.6,
        reviewCount: 55,
        deliveryTime: 30,
        deliveryFee: 24000,
        originalDeliveryFee: 39000,
        categories: ['Đồ ăn nhe'],
        isOpen: true,
        hasPromo: true,
        promoText: 'Giảm 16.000đ',
        branches: [
          Branch(
            id: 'chan_ga_single',
            name: 'Chân gà ĐỈNH (CN Long Khánh)',
            address: 'Chân gà ĐỈNH (CN Long Khánh)',
            isOpen: true,
          ),
        ],
      ),
      Restaurant(
        id: 'zen_tea',
        name: 'ZEN Tea - Long Khánh',
        address: 'Cà Phê - Trà - Sinh Tố',
        imageUrl: '',
        rating: 4.5,
        reviewCount: 41,
        deliveryTime: 30,
        deliveryFee: 40000,
        originalDeliveryFee: 55000,
        categories: ['Cà Phê - Trà - Sinh Tố'],
        isOpen: true,
        hasPromo: true,
        promoText: 'Giảm 16.000đ',
        branches: [
          Branch(
            id: 'zen_tea_single',
            name: 'ZEN Tea - Long Khánh',
            address: 'ZEN Tea - Long Khánh',
            isOpen: true,
          ),
        ],
      ),
    ];
  }

  static List<FoodCategory> getCategories() {
    return [
      const FoodCategory(id: 'com', name: 'Cơm', iconUrl: ''),
      const FoodCategory(id: 'cafe', name: 'Cà Phê - Trà - Sinh Tố - Nước Ép', iconUrl: ''),
      const FoodCategory(id: 'tra_sua', name: 'Trà sữa', iconUrl: ''),
      const FoodCategory(id: 'do_an_nhe', name: 'Đồ ăn nhe', iconUrl: ''),
      const FoodCategory(id: 'mon_quoc_te', name: 'Món Quốc Tế', iconUrl: ''),
      const FoodCategory(id: 'thuc_an_nhanh', name: 'Thức ăn nhanh', iconUrl: ''),
      const FoodCategory(id: 'lau_nuong', name: 'Lẩu & Nướng - Quay', iconUrl: ''),
      const FoodCategory(id: 'banh_mi', name: 'Bánh Mì - Xôi', iconUrl: ''),
      const FoodCategory(id: 'trang_mieng', name: 'Tráng miệng', iconUrl: ''),
      const FoodCategory(id: 'do_an_healthy', name: 'Đồ ăn Healthy', iconUrl: ''),
      const FoodCategory(id: 'mon_khac', name: 'Món Khác', iconUrl: ''),
    ];
  }

  static List<FoodItem> getFoodItems(String restaurantId) {
    switch (restaurantId) {
      case 'bunbo_hue':
        return [
          const FoodItem(
            id: 'bunbo_dacbiet',
            name: 'Bún Bò Huế - Đặc Biệt',
            description: '',
            imageUrl: '',
            price: 68000,
            originalPrice: 68000,
            isAvailable: true,
            isBestSeller: true,
            category: 'Bán chạy',
          ),
          const FoodItem(
            id: 'bunbo_2topping',
            name: 'Bún Bò Huế - 2 Topping',
            description: 'Bún bò Huế với thịt bò mềm, thơm ngon nước dùng đậm đà.',
            imageUrl: '',
            price: 54000,
            originalPrice: 54000,
            isAvailable: true,
            isBestSeller: true,
            category: 'Bán chạy',
          ),
          const FoodItem(
            id: 'bunbo_1topping',
            name: 'Bún Bò Huế - 1 Topping',
            description: 'Bún gạo mềm, thịt bò tươi, nước dùng đậm đà thơm ngon',
            imageUrl: '',
            price: 54000,
            originalPrice: 54000,
            isAvailable: true,
            isBestSeller: false,
            category: 'MENU',
          ),
        ];
      default:
        return [];
    }
  }
}
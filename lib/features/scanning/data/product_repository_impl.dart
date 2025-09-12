import '../../scanning/domain/product_repository.dart';
import '../../../core/constants.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  bool isValidProduct(String code) {
    // Extract the number at the end of the string
    final regExp = RegExp(r'(\d+)$'); // matches last number
    final match = regExp.firstMatch(code);

    if (match == null) return false;

    final id = int.tryParse(match.group(1)!);
    return id != null && AppConstants.validProductIds.contains(id);
  }
}

class AppEnvironment {

  static String BASE_URL = 'http://easyrouteplan.com/api/index.php?';
  static String LOGIN_URL = 'method=login';
  static String ORDERS_URL = 'method=driverdelivery';
  static String UPDATE_DELIVERY_URL = 'method=updatedelivery';
  static String DELIVERY_ITEM_URL = 'method=deliveryitems';
  static String UPLOAD_SIGNATURE_URL = 'method=uploadsignature';
  static String RE_ORDER_URL = 'method=updatedeliveryinfo';
  static String UPDATE_DELIVERY_ITEM_URL = 'method=updatedeliveryitem';
  static String IMAGE_URL = 'http://easyrouteplan.com/api/index.php?';

  static final String _env =
      String.fromEnvironment('ENV', defaultValue: ApiEnvironmentEnum.Prod.value);

  static String env() {
    return _env;
  }
  static String apiUrl() {
    switch (_env) {
      case 'prod':
        return BASE_URL;
      case 'staging':
        return BASE_URL;
      case 'debug':
        return BASE_URL;
      default:
        return '';
    }
  }

}

enum ApiEnvironmentEnum {
  Prod('prod'),
  Staging('staging'),
  Debug('debug');

  const ApiEnvironmentEnum(this.value);

  final String value;
}

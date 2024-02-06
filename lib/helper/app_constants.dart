class AppConstants {
  static final String google_api_key = '';

  static final String stripe_publish_key = '';

  static final String stripe_secret_key = '';

  static final String kPlacesApiKey = 'AIzaSyDw220zwlHJ1LnBdx0udN_NM2i4nucLLwA';
  static final String placesBaseUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  //Address Constants
  static String fromAddress = 'Tap to Search';
  static String toAddress = 'Return Place';

  //Time Constants
  static   String epochFromDate = "";
  static   String fromMonth = "";
  static   String fromMonthName = "";
  static   String fromDate = "";
  static   String fromDateName = "";
  static   String fromYear = "";
  static   String fromTime = "11:00 AM";
  static String fromTimeinMiliSeconds = "";
  static   String epochToDate="";
  static   String toMonth = "";
  static   String toMonthName = "";
  static   String toDate = "";
  static   String toDateName = "";
  static   String toYear = "";
  static   String toTime = "11:00 AM";
  static String toTimeinMiliSeconds = "";

  //Calculation Constants
  static double rentDays = 0.0;
  static double totalPrice =0.0;
  // Vehicle Type
  static String vehicleType = "";
  // checkOut values
  static bool isPickup = false;
  static bool isDeliver =false;

  static bool standardProtection=false;
  static bool liabilityProtection=false;
  static bool i_have_own=false;
  static bool customCoverage=false;
  static double totalCustomCoverage=0.0;

  static bool unlimitedMiles = false;
  static bool under25Years = false;

  //Card Details Constants
  static String cardNumber="";
  static String cardCvv="";
  static String cardExp="";
  static String cardZip="";

  //PromoCode details
  static bool isPromoApplied = false;
  static double promoDiscountAmount = 0.0;

  //Customer Details
  static String custFirstName="";
  static String custLastName="";
  static String custEmail="";
  static String custPhoneNo="";

}
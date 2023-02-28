import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static logScreenView({String? screenName}) {
    _analytics.setCurrentScreen(screenName: screenName!);
  }

  static logEvent({String? eventName}) {
    _analytics.logEvent(name: eventName!);
  }

  static logAddPaymentInfo({
    String? currency,
    String? value,
    String? paymentType,
    List<String>? items,
  }) {
    _analytics.logAddPaymentInfo(currency: currency, paymentType: paymentType);
  }

  static logAddToCart(
      {String? currency, double? value, List<AnalyticsEventItem>? items}) {
    _analytics.logAddToCart(
      value: value!,
      currency: currency,
      items: items!,
    );
  }

  static logAppOpen() {
    _analytics.logAppOpen();
  }

  static logAdImpression() {
    _analytics.logAdImpression(
        adPlatform: "", adFormat: "", adUnitName: "", adSource: "");
  }

  static logSetProperty({String? id}) {
    _analytics.setUserId(id: id);
  }

  static setUserProperty() {
    _analytics.setUserProperty(name: "name", value: "value");
  }

  static logRemoveFromCart(
      {String? currency, double? value, List<AnalyticsEventItem>? items}) {
    _analytics.logRemoveFromCart(currency: currency, value: value, items: items);
  }

  static logSignUp() {
    _analytics.logSignUp(
      signUpMethod: 'test sign up method',
    );
  }

  static logAddToWishList(
      {String? currency, double? value, List<AnalyticsEventItem>? items}) {
    _analytics.logAddToWishlist(
      value: value!,
      currency: currency,
      items: items!,
    );
  }

  static logBeginCheckout(
      {String? currency, double? value, List<AnalyticsEventItem>? items}) {
    _analytics.logBeginCheckout(
      value: value!,
      currency: currency,
      items: items!,
    );
  }

  static logCompaignDetails() {
    _analytics.logCampaignDetails(
      source: 'source',
      medium: 'medium',
      campaign: 'campaign',
      term: 'term',
      content: 'content',
      aclid: 'aclid',
      cp1: 'cp1',
    );
  }

  static logPurchasePremium() {
    _analytics.logLevelUp(
      level: 1,
      character: "premium",
    );
  }

  static logPurchase(
      {String? currency, double? payment, String? transactionId}) {
    _analytics.logPurchase(
        currency: currency, value: payment, transactionId: transactionId);
  }

  static logShare() {
    _analytics.logShare(
      contentType: 'test content type',
      itemId: 'test item id',
      method: 'facebook',
    );
  }

  static logEarnVirtualCurrency(
      {String? virtualCurrencyName, double? currencyValue}) {
    _analytics.logEarnVirtualCurrency(
      virtualCurrencyName: 'bitcoin',
      value: 345.66,
    );
  }

  static logGenerateLead({String? virtualCurrencyName, double? currencyValue}) {
    _analytics.logGenerateLead(
      currency: 'USD',
      value: 123.45,
    );
  }

  static logJoinGroup(String? groupName) {
    _analytics.logJoinGroup(
      groupId: groupName!,
    );
  }

  static logSearch() {
    _analytics.logSearch(
      searchTerm: 'hotel',
      numberOfNights: 2,
      numberOfRooms: 1,
      numberOfPassengers: 3,
      origin: 'test origin',
      destination: 'test destination',
      startDate: '2015-09-14',
      endDate: '2015-09-16',
      travelClass: 'test travel class',
    );
  }

  static logSelectContent() {
    _analytics.logSelectContent(
      contentType: 'test content type',
      itemId: 'test item id',
    );
  }

  static logSelectPromotion() {
    _analytics.logSelectPromotion(
      creativeName: 'promotion name',
      creativeSlot: 'promotion slot',
      items: [],
      locationId: 'United States',
    );
  }

  static logSelectItem() {
    _analytics.logSelectItem(
      items: [],
      itemListName: 't-shirt',
      itemListId: '1234',
    );
  }

  static logViewCart() {
    _analytics.logViewCart(
      currency: 'USD',
      value: 123,
      items: [],
    );
  }

  static logSpendVirtualCurrency() {
    _analytics.logSpendVirtualCurrency(
      itemName: 'test item name',
      virtualCurrencyName: 'bitcoin',
      value: 34,
    );
  }

  static logViewPromotion() {
    _analytics.logViewPromotion(
      creativeName: 'promotion name',
      creativeSlot: 'promotion slot',
      items: [],
      locationId: 'United States',
      promotionId: '1234',
      promotionName: 'big sale',
    );
  }

  static logRefund() {
    _analytics.logRefund(
      currency: 'USD',
      value: 123,
      items: [],
    );
  }

  static logTutorialBegin() {
    _analytics.logTutorialBegin();
  }

  static logTutorialComplete() {
    _analytics.logTutorialComplete();
  }

  static logUnlockAchievement() {
    _analytics.logUnlockAchievement(id: 'all Firebase API covered');
  }

  static logViewItem() {
    _analytics.logViewItem(
      currency: 'usd',
      value: 1000,
      items: [],
    );
  }

  static logViewItemList() {
    _analytics.logViewItemList(
      itemListId: 't-shirt-4321',
      itemListName: 'green t-shirt',
      items: [],
    );
  }

  static logViewSearchResults() {
    _analytics.logViewSearchResults(
      searchTerm: 'test search term',
    );
  }
}

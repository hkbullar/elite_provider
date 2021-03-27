class Constants{
  static const String FIRST_NAME = "first_name";
  static const String LAST_NAME = "last_name";
  static const String EMAIL = "email";
  static const String PHONE = "phone";
  static const String PASSWORD = "password";
  static const String USER_TYPE = "user_type";
  static const String PASSWORD_CONFIRMATION = "password_confirmation";
  static const String ID = "id";
  static const String LANGUAGE_CODE = "language";
  static const String TOKEN = "token";
  static const String ISONLINE = "isonline";
  static const String TOKEN_TYPE = "token_type";
  static const String USER_PREF = "userpref";
  static const String FIREBASE_TOKEN = "firebase_token";
  static const String ISREGISTERED = "isRegistered";
  static const String ISAPPROVED = "isApproved";

  //SP KEYS
  static const String USER_ROLE="role";
  static const String USER_ROLE_DRIVER="driver";
  static const String USER_ROLE_GUARD="guard";

  //UPLOAD DOCUMENTS KEYS
  static const String DOCUMENT_USER_TYPE_GUARDIAN="gurad";
  static const String DOCUMENT_USER_TYPE_DRIVER="driver";
  static const String DOCUMENT_USER_TYPE="type";
  static const String DOCUMENT_IMAGE_TYPE="image_type";
  static const String DOCUMENT_IMAGE="picture";
  static const String DOCUMENT_RC_PIC="rc_image";
  static const String DOCUMENT_PROFILE_PIC="profile_picture";
  static const String DOCUMENT_ID_PIC="profile_id";

  //REQUEST ACCEPT REJECT KEYS
  static const String REQUEST_AR_BOOKING_ID="booking_id";
  static const String REQUEST_AR_DRIVER_ID="driver_id";
  static const String REQUEST_AR_GUARDIAN_ID="guard_id";

  static const String SEARCH_USER = "search";
  //CREATE COMMENT KEYS
  static const String COMMENT_USER_ID = "user_id";
  static const String COMMENT_FEED_ID = "feeds_id";
  static const String COMMENT_CONTENT = "comment";
  //LIKE/DISLIKE KEYS
  static const String LIKE_USER_ID = "user_id";
  static const String LIKE_FEED_ID = "feeds_id";
  static const String LIKE_UNLIKE = "likes";
  static const String DISLIKE_UNDISLIKE = "dislikes";

  //FOLLOW/UNFOLLOW KEYS
  static const String FOLLOW_USER_ID = "contact_id";
  static const String FOLLOW_UNFOLLOW_EVENT = "event";

  //LEAVE COMMUNITY AND DELETE COMMUNITY API KEYS
  static const String LEAVE_COMMUNITY_API_COM_ID = "community_id";


  static const String CLAIM_BUSINESS_ID = "business_id";
  //CREATE POST KEYS
  static const String POST_USER_ID = "user_id";
  static const String POST_BUSINESS_ID = "businesses_id";
  static const String POST_COMMUNITY_ID = "community_id";
  static const String POST_MESSAGE = "message";
  static const String POST_FEED_TYPE = "type_of_feed";

  static const String SAVE_BUSINESS_ID = "businesses_id";
  //SUGGETSION KEYS
  static const String SUGGEST_USER_ID = "user_id";
  static const String SUGGEST_MESSAGE = "message";
  static const String SUGGEST_SUBJECT = "subject";

  //CREATE BUSINESS OBJECT KEYS
  static const String USER_ID= "user_id";

  static const String DummY_TOken= "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDMxMTMzYmM4NTBkMzgzMDFlODZiY2U0OTVjZTQ0NTRkM2U3MDNhY2IwNWUzZWJiZmRiMGVmM2YxZTA4NjE5YWNkOGY4ZWIyNzI4MjdjYTkiLCJpYXQiOjE2MDI3NjY4MTAsIm5iZiI6MTYwMjc2NjgxMCwiZXhwIjoxNjM0MzAyODEwLCJzdWIiOiI3Iiwic2NvcGVzIjpbXX0.bv6pXNob6ESvN0--V_qioU9aaVtwSonP7O2yuO1cev3_vts7thqFVBDBj493T8TEP6T6pDfJhECxF9YDKsPtNclT66pveBctMFubRIlaS2ieKAq27DiPeXCSXJ9JDGZvuK0y5_qUgCbcb9GoU7mT3Z6uS3zmAtgviBVVWet4I6INrEhS7xIhUHz47tdnxajms04ieCyEeU4zMgx87Xcak7RGR1itoMvu1iix32blbLl55qnWZCFZelZlbzZrDlEZ3r9oFUVc8l7RN8c1xFI6yU8DSyq-Zf8oUc3eq5EAsDfKUFxRbDVfwMdg60mfoCO0Qe0UuN3nLvpYNKJ0nPCnvtBIFKT08vvX4RS_VBIjoyC8EfsiMJ4Dx8ie8aV8L62EF5ExxqZzcv8HaYtxUndDaMVlQh1FAYUqUNnba_vhDBWu0MLkV2PEYlEeFl_ob5XsBpp3Ab2i7pZTe68wJDiOACLrPKOXb_OHSr0ojmePbJo2SSLI0mQUJkWyTzzVXNRxSkqOosqYE8X6432OWeiX6KF1WXhyHTDs817VQI3GLteQYpjuACcsDRFC2TLFmscG1o8sZP6Gp8UDEcvQgTepY3cY4xbbRTK8H53iDeAV14FM58cUBxmx9AqIxa7x5DCS2rX-vUfm7z_mp215eGHcDqFn2_F8jHOiRSkyz3G3Chw";

  //CREATE BUSINESS KEYS
  static const String NAME ="name";
  static const String CATEGORY_ID="cat_id";
  static const String SUBCATEGORY_ID="subcat_id";
  static const String ADDRESS="address";
  static const String LATITUDE ="latitude";
  static const String LONGITUDE ="logitude";
  static const String OPENING_HOURS="opening_hours";
  static const String CLOSING_HOURS="closing_hours";
  static const String OPENING_DAYS="opening_day";
  static const String CLOSING_DAYS="closing_day";
  static const String PRICE_TAG="price_category";
  static const String SERVICE_DESCRIPTION="services_description";
  static const String DIRECT_MESSAGE="dm";
  static const String PHONE_CALL="phone_call";
  static const String HOME_DELIVERY ="home_delivery";
  static const String FACEBOOK_LINK ="fb_link";
  static const String INSTAGRAM_LINK="ig_link";
  static const String TWITTER_LINK ="twitter_link";
  static const String IMAGES ="images[]";

  //BUSINESS FILTER PRICE TAGS
  static const String FILTER_PRICE_TAG="price_category";
  static const String FILTER_HOME_DELIVERY="delivery";
  static const String FILTER_SUBCATEGORY="subcategory";
  static const String FILTER_CATEGORY="category";
  static const String FILTER_CONTACTS="user_id";

  //FIREBASE CHAT OBJECT KEYS
  static const String SENDER ="sender";
  static const String RECIEVER ="reciever";
  static const String MESSAGE ="message";
  static const String TYPE ="type";
  static const String SENDER_NAME ="name";
  static const String TIMESTAMP ="timestamp";

  //FIREBASE USER AND CHAT TABLE NAME
  static const String USER_TABLE ="users";
  static const String COMMUNITY_TABLE ="communities";
  static const String CHAT_TABLE ="chat_inbox";

  //FIREBASE USER OBJECT KEYS
  static const String USER_ID_F ="id";
  static const String USER_NAME ="name";
  static const String USER_EMAIL ="email";
  static const String USER_PHONE ="mobile";
  static const String USER_IMAGE ="image";
  static const String USER_CHATTING_WITH ="chattingwith";
  static const String USER_LAST_MESSAGE ="lastmessage";
  static const String USER_LAST_MESSAGE_TIME ="messagetime";
  static const String USER_STATUS ="status";
  static const String USER_CHATS ="user_chats";
  static const String USER_COMMUNITIES ="my_communities";
  static const String USER_STATUS_ONLINE ="Online";
  static const String USER_STATUS_OFFLINE ="Offline";

  //FIREBASE COMMUNITY OBJECT KEYS
  static const String COM_ID_F ="com_id";
  static const String COM_NAME ="com_name";
  static const String COM_IMAGE ="com_image";
  static const String COM_USERS ="com_users";
  static const String COM_INVITED_USERS ="com_invites";
  static const String COM_ADMIN ="com_admin";

  static const String COM_LAST_MESSAGE ="com_lastmessage";
  static const String COM_LAST_MESSAGE_TIME ="com_lastmessage_time";
  static const String COM_CREATED_DATE ="com_created_date";
  static const String COM_SENDER_NAME ="com_sender_name";

  static const String RECENT_SEARCH_LIST = "searchlist";

  static const String LOCAL_IMAGE="assets/images/";

  static const String USER_TYPE_DRIVER="driver";
  static const String USER_TYPE_GUARDIAN="guard";
  static const String USER_TYPE_OFFICER="assets/images/";

  //BASE URL FOR IMAGES
  static const String IMAGE_BASE_URL="https://geeniuz.co/storage/app/";

  static const String IMAGE_BASE_URL_2="https://geeniuz.co/public/";

  //GOOGLE PLACE API KEY
  static const String API_KEY ="AIzaSyCXNju8F2rp5rhRp1W4igjTVDY8SpsdJQg";
}

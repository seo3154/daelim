class Config {
  static const String _baseFunctionUrl =
      'https://daelim-server.fleecy.dev/functions/v1';
  static const String _storagePublicUrl =
      'https://daelim-server.fleecy.dev/storage/v1/object/public';

  static const icon = (
    google: '$_storagePublicUrl/icons/google.png',
    apple: '$_storagePublicUrl/icons/apple.png',
    github: '$_storagePublicUrl/icons/github.png',
  );

  static const image = (
    defaultProfile: '$_storagePublicUrl/icons/user.png', //
  );

  static const api = (
    getToken: '$_baseFunctionUrl/auth/get-token',
    getUserData: '$_baseFunctionUrl/auth/my-data',
    setProfileImage: '$_baseFunctionUrl/auth/set-profile-image',
    changePassword: '$_baseFunctionUrl/auth/reset-password',
    getUserList: '$_baseFunctionUrl/users',
    createRoom: '$_baseFunctionUrl/chat/room/create',
  );

  static const storage = ();
}

// class Config {
//   static const String _baseFunctionUrl =
//       'https://daelim-server.fleecy.dev/functions/v1';
//   static const String _storagePublicUrl =
//       'https://daelim-server.fleecy.dev/functions/v1/object/public';

//   static const icon = (
//     google: '$_storagePublicUrl/icons/google.png',
//     apple: '$_storagePublicUrl/icons/apple.png',
//     github: '$_storagePublicUrl/icons/github.png',
//   );

//   static const api = (
//     getToken: '$_baseFunctionUrl/auth/get-token',
//     getUserData: '$_baseFunctionUrl/auth/my-data',
//     setProfileImage: '$_baseFunctionUrl/auth/set-profile-image',
//   );

//   static const storage = (
//     getPublicUrl: 'https://daelim-server.fleecy.dev/functions/v1/object/public',
//   );

//   static const image =
//       (defaultProfileUrl: '$_storagePublicUrl/icons/user.png',);
// }

// // NOTE: API 호출 URL
// const String _baseUrl = 'https://daelim-server.fleecy.dev/functions/v1';
// const String getTokenUrl = '$_baseUrl/auth/get-token';
// const String getUserDataUrl = '$_baseUrl/auth/my-data';
// const String setProfileImageUrl = '$_baseUrl/auth/set-profile-image';

// const String _storageUrl =
//     'https://daelim-server.fleecy.dev/functions/v1/object/public';

// // NOTE: 아이콘 URL
// const String icGoogle = '$_storageUrl/icons/google.png';
// const String icApple = '$_storageUrl/icons/apple.png';
// const String icGithub = '$_storageUrl/icons/github.png';

// // NOTE: 이미지 URL
// const String defaultProfileImageUrl = '$_storageUrl/icons/user.png';

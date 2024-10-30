// NOTE: API 호출 URL
const String baseUrl = 'https://daelim-server.fleecy.dev/functions/v1';
const String getTokenUrl = '$baseUrl/auth/get-token';
const String getUserDataUrl = '$baseUrl/auth/my-data';
const String setProfileImageUrl = '$baseUrl/auth/set-profile-image';

const String _storageUrl =
    'https://daelim-server.fleecy.dev/functions/v1/object/public';

// NOTE: 아이콘 URL
const String icGoogle = '$_storageUrl/icons/google.png';
const String icApple = '$_storageUrl/icons/apple.png';
const String icGithub = '$_storageUrl/icons/github.png';

// NOTE: 이미지 URL
const String defaultProfileImageUrl = '$_storageUrl/icons/user.png';

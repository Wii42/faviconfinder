import 'package:favicon/favicon.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main(List<String> arguments) async {
  await faviconFinder(arguments);
  print('');
}

Future<void> faviconFinder(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('No arguments provided');
    return;
  }
  if (arguments.length > 1) {
    print('Too many arguments provided, only first one is considered');
  }
  String url = arguments[0];
  await fetchFavicons(url);
}

Future<void> fetchFavicons(String url) async {
  url = url.trim();
  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    url = 'https://$url';
  }
  Uri? parsedUrl;
  try {
    parsedUrl = Uri.tryParse(url);
  } catch (e) {
    print('Error parsing URL: ${e.toString().split('\n').first}');
  }
  if (parsedUrl == null ||
      parsedUrl.isAbsolute == false ||
      !url.contains('.')) {
    print('$url is not a valid URL');
    return;
  }
  print('fetching favicons...');
  List<Favicon> favicons;
  try {
    favicons = await FaviconFinder.getAll(url);
  } catch (e) {
    if (e.toString().startsWith(
        'ClientException with SocketException: Failed host lookup:')) {
      bool hasConnection = await InternetConnectionChecker().hasConnection;
      if (!hasConnection) {
        print('Error: No internet connection');
        return;
      }
    }
    print('Error fetching favicons: ${e.toString().split('\n').first}');
    return;
  }
  if (favicons.isEmpty) {
    print('No favicons found for $url');
    return;
  }
  print('Found ${favicons.length} favicons for $url:');
  for (Favicon favicon in favicons) {
    print("[${favicon.width}x${favicon.height}] ${favicon.url}");
  }
}

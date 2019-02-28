//
// ImpactImages gets numImages of URLS from unsplash.  I have
// set up 3 predefined categories (unsplash collection ids) to
// draw random URLs from.  Each URL drawn is unique.  The URLs
// are images that are then displayed as background images.
//
import 'dart:math';
// TODO: On many clicks, image does not update.  However, the URL
// has updated.  Is there a way to determine if an error occured
// when loading an image to the screen?
class ImpactImages {
  static int numImages = 10;
  // The unsplash collection id for the impact category:
  // forest (3302326)
  // oil (3947516)
  // money (2364459)
  static const int TREES = 3302326;
  static const int OIL = 3947516;
  static const int MONEY = 2364459;
  // Get URLs from unsplash that are relevant to our
  // impact categories.
  static List<String> _impactURLs = List<String>();
  static List<String> get impactURLs {
    numImages = numImages < 0 ? 10 : numImages > 30 ? 10 : numImages;
    // Check to see if the impact URLs already exist and the list contains
    // The expected number of URLs.
    if (_impactURLs.length == numImages) {
      return _impactURLs;
    } else if (_impactURLs.length > 0) {
      _impactURLs.clear();
    }
    // Set up the number of images that are in each category.
    Map mapNumImagesPerType = {TREES: 264, OIL: 18, MONEY: 22};
    // Get the URL strings.
    int i = 0;
    while (i < numImages) {
      // Randomely select one of the three categories
      int _impactCategory = mapNumImagesPerType.keys
          .elementAt(new Random().nextInt(mapNumImagesPerType.length));
      // Pick a random image and build the URL.
      int numImages = mapNumImagesPerType[_impactCategory];
      Random rnd = Random();
      int randomImage = 1 + rnd.nextInt(numImages);
      String unsplashURL = "https://source.unsplash.com/collection/" +
          _impactCategory.toString() +
          "/540x960?/sig=" +
          randomImage.toString();
      // Make sure the URL we built is unique.
      if (i == 0) {
        _impactURLs.add(unsplashURL);
        i++;
      } else {
        bool urlsContain = false;
        for (final url in _impactURLs) {
          if (url.contains(unsplashURL)) {
            urlsContain = true;
            break;
          }
        }
        if (!urlsContain) {
          _impactURLs.add(unsplashURL);
          i++;
        }
      }
    }
    return _impactURLs;
  }
}

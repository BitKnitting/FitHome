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
//
// The image the user sees as the background of the Dashboard.
// It should invoke a positive emotion about saving electricity and
// be a reminder of an aspect of the environment - trees, oil, money.
// The images come from unsplash categories for trees, oil, money.
//
class ImpactImages {
  static final ImpactImages _singleton = ImpactImages._internal();
  //   The unsplash collection id for the impact category:
  // forest (3302326)
  // oil (3947516)
  // money (2364459)
  static const int TREES = 3302326;
  static const int OIL = 3947516;
  static const int MONEY = 2364459;

  static int width;
  static int height;
  static List<String> _impactURLs = List<String>();
  List<String> get impactURLs {
    return _impactURLs;
  }

  factory ImpactImages(double w, double h) {
    width = w.toInt() + 200; // w/o 200, image looks stretched...
    height = h.toInt();
    return _singleton;
  }

  ImpactImages._internal() {
    int numImages = 20;
    numImages = numImages < 0 ? 10 : numImages > 30 ? 10 : numImages;
    // Set up the number of images that are in each category.
    Map mapNumImagesPerType = {TREES: 264, OIL: 18, MONEY: 22};
    // Get the URL strings.
    int i = 0;
    while (i < numImages) {
      //Randomly select one of the three categories
      int _impactCategory = mapNumImagesPerType.keys
          .elementAt(new Random().nextInt(mapNumImagesPerType.length));
      // Pick a random image and build the URL.
      int numImages = mapNumImagesPerType[_impactCategory];
      Random rnd = Random();
      int randomImage = 1 + rnd.nextInt(numImages);
      String unsplashURL = "https://source.unsplash.com/collection/" +
          _impactCategory.toString() +
          "/" +
          width.toString() +
          "x" +
          height.toString() +
          "?/sig=" +
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
      } // else
    } // while
  } //_internal
} // class ImpactImages

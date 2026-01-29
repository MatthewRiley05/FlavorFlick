# FlavorFlick

> ⚠️ **Project Status: On Indefinite Hiatus**
> 
> OpenRice updated their website structure in early 2026, moving bookmark pages behind authenticated sessions (`/me/saved/`) with no public URL available for your own bookmarks. This broke the core functionality of the app. The project is shelved until a workaround becomes available.

## What is FlavorFlick?

FlavorFlick is a Flutter app that helps you decide where to eat by turning your OpenRice bookmarks into a Tinder-style swiping experience. Can't decide between your 84 saved restaurants? Just swipe!

### Features

- 🍜 **Swipe to Decide** - Swipe right on restaurants you're feeling, left on ones you're not
- 📍 **Distance Sorting** - Restaurants are sorted by distance from your current location
- 🗺️ **Google Routes Integration** - Real walking/driving distances, not just straight-line
- 📱 **Clean Card UI** - See restaurant photos, cuisine tags, price range, and ratings at a glance
- 📚 **History Tracking** - Keep track of restaurants you've swiped on
- 🌙 **Dark Mode** - Because of course

### How It Worked

1. Paste your OpenRice bookmarks page URL into the app
2. The app scrapes your bookmarked restaurants
3. Swipe through them to narrow down your choices
4. Open the winner directly in OpenRice

## Tech Stack

- Flutter/Dart
- OpenRice HTML parsing (broken 💀)
- Google Routes API for distance calculations
- Geolocator for current position
- flutter_card_swiper for the swipe UI

## Building

```bash
flutter pub get
flutter run
```

Requires a `.env` file with `ROUTES_API_KEY` for Google Routes API.

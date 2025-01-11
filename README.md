
# Showz App

Showz is a mobile application that allows users to explore trending and popular TV shows. The app fetches the data from a remote API and displays it in a visually appealing manner with smooth interactions.

## Features

### 1. **Trending and Popular Shows**
   - Displays two categories of shows: **Trending Now** and **Popular Shows**.
   - Shows are fetched from a remote API and categorized accordingly.

### 2. **Image Carousel**
   - Displays a horizontal carousel of trending shows using the `CarouselSlider` package.
   - The carousel automatically rotates through images and allows users to tap on an image to navigate to a show detail screen.

### 3. **SliverAppBar with Search**
   - A floating `SliverAppBar` that hides when scrolling down and reappears when scrolling back up.
   - Includes a search icon in the app bar to open a search screen where users can search for specific shows.

### 4. **Responsive UI**
   - The app layout adjusts dynamically based on the screen size, ensuring a consistent experience across devices.
   - Images and grid layouts are responsive and adapt well to different screen dimensions.

### 5. **Error Handling**
   - Built-in error handling for invalid image URLs or network issues.
   - Displays a fallback icon if an image fails to load.

### 6. **Navigation**
   - Users can tap on any show’s image or card to navigate to a detailed page.
   - The detail page contains more information about the selected show, including links and descriptions.

### 7. **Auto-play Carousel**
   - The carousel of trending shows automatically plays and cycles through images every 5 seconds.
   - Provides an automatic, smooth user experience.

### 8. **Grid View for Popular Shows**
   - Displays popular shows in a grid layout with three columns.
   - Each grid item contains a clickable card that users can tap to get more details about the show.

### 9. **Custom Styling**
   - Custom dark theme with vibrant colors and modern typography.
   - Images and cards have rounded corners for a polished look.

### 10. **Smooth Scrolling Experience**
   - Both the carousel and grid list offer smooth scrolling interactions.
   - Scrolling behavior adapts dynamically as users interact with the content.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/showz-app.git
   ```
   
2. Navigate to the project directory:
   ```bash
   cd showz-app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

- `carousel_slider`: A carousel slider for displaying trending shows.
- `http`: To make HTTP requests to fetch show data from the remote API.
- `flutter`: Flutter SDK for building the app.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

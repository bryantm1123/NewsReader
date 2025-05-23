## News Reader
A simple news reader app, currently showing top headlines from the US. The app sources articles from [https://newsapi.org/](https://newsapi.org/).

## Get Started
### Prerequisites
- Xcode 16.2+
- Swift 5.4.2+
- iOS 16.6+

The app was **tested on iOS 18.1** and there are **no third-party dependencies**.

### Run Locally
Clone the project  
```git clone https://github.com/bryantm1123/NewsReader.git```

Navigate to the project directory  
```cd path/to/project/newsreader```

Open `NewsReader.pbxproj`.

Register for an API key at [https://newsapi.org/](https://newsapi.org/). The app expects the api key as an environment variable named `API_KEY`.

## Architecture 
From a user perspective, the app consists of a scrolling article feed, which displays a preview of the article content. Tapping an article preview loads the full article in a web view.

The app currently utilizes UIKit to provide the user interface. The article feed uses a collection view attached to a view controller to display article previews and a view model manages calling a service to load the headlines and preparing the data for visual display. A binding between the view model and view controller updates the UI when new data loads.

 

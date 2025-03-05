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

Register for an API key at [https://newsapi.org/](https://newsapi.org/). Once you have a key, paste it between the double quotes `""` in line 11 of [TopHeadlinesAPI.swift](https://github.com/bryantm1123/NewsReader/blob/main/NewsReader/TopHeadlinesService/TopHeadlinesAPI.swift#L11).

## Architecture 
From a user perspective, the app consists of a scrolling article feed, which displays a preview of the article content. Tapping an article preview loads the full article—up to API character limits.

The app currently utilizes UIKit to provide the user interface. The article feed uses a collection view attached to a view controller to display article previews and a view model manages calling a service to load the headlines and preparing the data for visual display. A binding between the view model and view controller updates the UI when new data loads.  

The article reader is a simple view controller that accepts the article data and displays it in a layout similar to the article preview.

## Roadmap
### Webview for full article
Explore loading the full article in a web view to provide a better user experience. The API limits the article text, making the full article unreadable. However it does provide a url to the article source. The app could load this url into a web view to provide access to the full article content.

### Filters
The API supports multiple query parameters and search filters, to include topics, sources, and categories. The app could provide more options for the user to narrow the scope of the news article feed based on interests.

### Swift UI
The app could replace UIKit with SwiftUI to improve the user interface. 

 

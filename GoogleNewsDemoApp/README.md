Hello! 

Thank you for taking the time to review my GoogleNews Demo App!

The project was built using Xcode 16.2 and Swift 5.4.2, with a minimum build target of iOS 16.6.
It was tested on iOS 18.2.

There are no third-party dependencies and the API-key is hard-coded.

**Architecture**: 
The app consists of a home screen which is a view controller holding a collection view.
This screen offers continuous scroll and pagination to load articles from the News API.
Upon tapping an article, the app pushes to a detail screen where you can see the article
content in further detail.

The approach for the News List view controller is MVVM. The view model is a small one, and 
used for fetching the article data from the remote API and preparing it to display onscreen. 
The Article view controller uses a simple MVC approach, and receives its article data
from the News List view controller. 

The project also contains a git repository, so you can view the commit history.

 

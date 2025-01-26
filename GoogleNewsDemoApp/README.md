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

**Known issues**:
- There are some spacing issues in the News List layout. With further tweaking and polishing,
    especially regarding the imageView height, cell layout constraints, and the collection view item size, 
    I think these issues could be remedied.
- Lack of tests:
    - The NewsService has no test coverage. A mocking solution for URLSession could be created
        and injected via the initializer, for the purpose of mocking Data and Response scenarios. 
        Additionally the URL composition could be outsourced to a factory or builder method or object
        and tested.
    - While the view model does have a test, the coverage on the date parser is light. In the current
        test, I'm checking that a value is returned from the parsing. A difficulty here is that the
        parser method compares the date from the API with a current Date timestamp. This makes testing a value
        comparison impossible because our test could run at any time. Rather this method needs refactoring to
        be testable. One possiblity is to inject a Date timestamp into the parsing method
        for the comparison. This would allow us to inject a Date timestamp from our tests that is
        controlled. However, This would need to be tested for flakiness to ensure that it's reliable.
        
Overall, I enjoyed the challenge. As I've been working mostly in backend for the past year, it was a great
refresher on many skills. While I would have liked to build the detail screen at least in SwiftUI, I opted
for UIKit for expediency. Thanks again, and happy reviewing!

All the best,
Matt 
 

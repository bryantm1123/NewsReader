import Foundation

struct ErrorMessaging {
    static let error = "Error"
    static let tryAgain = "Try again"
    static let cancel = "Cancel"
    static let ok = "OK"
    
    struct RetryableDialog {
        static let message = "Unfortunately we encountered an error. Please try again."
        
    }
    
    struct WebViewLoadFailed {
        static let message = "Unfortunately we could not access the requested content."
    }
}

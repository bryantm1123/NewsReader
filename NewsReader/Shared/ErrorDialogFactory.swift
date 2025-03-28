import UIKit

struct ErrorDialogFactory {
    static func makeRetryableErrorDialog(with action: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: ErrorMessaging.error,
                                      message: ErrorMessaging.RetryableDialog.message,
                                      preferredStyle: .alert
        )
        
        let retryAction = UIAlertAction(title: ErrorMessaging.tryAgain, style: .default) { _ in
            action()
        }
        let cancelAction = UIAlertAction(title: ErrorMessaging.cancel, style: .cancel)
        
        alert.addAction(retryAction)
        alert.addAction(cancelAction)
        return alert
    }
    
    static func makeWebViewLoadFailed(with action: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: ErrorMessaging.error,
                                      message: ErrorMessaging.WebViewLoadFailed.message,
                                      preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: ErrorMessaging.ok, style: .default) { _ in
            action()
        }
        alert.addAction(okAction)
        return alert
    }
}

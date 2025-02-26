import UIKit

struct ErrorDialogFactory {
    static func retryableErrorDialog(with action: @escaping () -> Void) -> UIAlertController {
        let retryAction = UIAlertAction(title: ErrorMessaging.RetryableDialog.tryAgain, style: .default) { _ in
            action()
        }
        let cancelAction = UIAlertAction(title: ErrorMessaging.RetryableDialog.cancel, style: .cancel)
        
        let alert = UIAlertController(title: ErrorMessaging.RetryableDialog.title,
                                      message: ErrorMessaging.RetryableDialog.message,
                                      preferredStyle: .alert)
        alert.addAction(retryAction)
        alert.addAction(cancelAction)
        return alert
    }
}

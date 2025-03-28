import UIKit

extension UIViewController {
    func presentRetryableErrorDialog(with action: @escaping () -> Void) {
        present(ErrorDialogFactory.makeRetryableErrorDialog(with: action), animated: true)
    }
    
    func presentWebViewLoadFailedErrorDialog(with action: @escaping () -> Void) {
        present(ErrorDialogFactory.makeWebViewLoadFailed(with: action), animated: true)
    }
}

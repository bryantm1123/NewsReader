import UIKit

extension UIViewController {
    func presentRetryableErrorDialog(with action: @escaping () -> Void) {
        present(ErrorDialogFactory.retryableErrorDialog(with: action), animated: true)
    }
}

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    private let urlString: String?
    private let webView = WKWebView()
    
    init(urlString: String?) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        guard let urlString,
              let url = URL(string: urlString) else {
                presentWebViewLoadFailedErrorDialog { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
                return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

import UIKit

final class ArticleViewController: UIViewController {
    private var article: ArticleModel
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var textLabel = UILabel()
    private let imageViewHeight: CGFloat = 250
    private let padding: CGFloat = 10
    private let titleFontSize: CGFloat = 18
    private let textFontSize: CGFloat = 14
    private let placeHolderImage = UIImage(systemName: "questionmark.circle")
    
    init(article: ArticleModel) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupImageView()
        setupTitleLabel()
        setupTextLabel()
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
    }
    
    private func setupImageView() {
        imageView.image = placeHolderImage
        Task {
            try? await imageView.loadImage(from: article.imageURL)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = article.title
        titleLabel.font = UIFont.systemFont(ofSize: titleFontSize, weight: .semibold)
        titleLabel.numberOfLines = 3
    }
    
    private func setupTextLabel() {
        textLabel = UILabel()
        textLabel.text = article.content
        textLabel.font = UIFont.systemFont(ofSize: textFontSize, weight: .regular)
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            titleLabel,
            textLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = padding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}

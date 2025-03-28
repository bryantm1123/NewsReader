import UIKit

class ArticleCell: UICollectionViewCell {
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var timeLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var authorLabel = UILabel()
    private let placeHolderImage = UIImage(systemName: "arrow.trianglehead.2.clockwise.rotate.90.icloud.fill")
    
    public static let identifier = "NewsCell"
    
    private let imageViewHeight: CGFloat = 100
    private let padding: CGFloat = 10
    private let smallPadding: CGFloat = 3
    private let titleFontSize: CGFloat = 12
    private let labelFontSize: CGFloat = 10
    
    private var imageLoadTask: Task<Void, Never>?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupImage()
        setupTitleLabel()
        setupTimeLabel()
        setupDescriptionLabel()
        setupAuthorLabel()
        setupContentStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImage() {
        imageView.image = placeHolderImage
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            imageView.bottomAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        imageView.contentMode = .scaleToFill
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: titleFontSize, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    private func setupTimeLabel() {
        timeLabel.font = UIFont.systemFont(ofSize: labelFontSize, weight: .medium)
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: labelFontSize, weight: .medium)
        descriptionLabel.numberOfLines = 3
    }
    
    private func setupAuthorLabel() {
        authorLabel.font = UIFont.systemFont(ofSize: labelFontSize, weight: .medium)
    }
    
    private func setupContentStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            descriptionLabel,
            authorTimeLabelStack
        ])
        stackView.axis = .vertical
        stackView.spacing = smallPadding
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])
    }
    
    private lazy var authorTimeLabelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            authorLabel,
            UIView(),
            timeLabel
        ])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    
    func setupContent(from dataSource: Article) {
        titleLabel.text = dataSource.title
        timeLabel.text  = dataSource.time
        descriptionLabel.text = dataSource.description
        authorLabel.text = dataSource.source
        
        if let imageURLString = dataSource.imageURL,
           let imageURL = URL(string: imageURLString) {
            imageLoadTask?.cancel()
            imageLoadTask = Task {
                try? await imageView.loadImage(from: imageURL)
            }
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoadTask?.cancel()
        imageView.image = placeHolderImage
    }
}

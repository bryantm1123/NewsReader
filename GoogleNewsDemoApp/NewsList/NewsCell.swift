import UIKit

class NewsCell: UICollectionViewCell {
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var timeLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var authorLabel: UILabel!
    public static let identifier = "NewsCell"
    
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
        imageView = UIImageView(image: UIImage(systemName: "arrow.trianglehead.clockwise")!)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        imageView.contentMode = .scaleAspectFit
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    private func setupTimeLabel() {
        timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        descriptionLabel.numberOfLines = 3
    }
    
    private func setupAuthorLabel() {
        authorLabel = UILabel()
        authorLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
    }
    
    private func setupContentStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            titleTimeLabelStack,
            descriptionLabel,
            authorLabel
        ])
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private lazy var titleTimeLabelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            UIView(),
            timeLabel
        ])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    
    func configure(from dataSource: NewsCellModel) {
        imageView.image = dataSource.image
        titleLabel.text = dataSource.title
        //timeLabel.text  = dataSource.time // TODO: Read from model
        timeLabel.text = "3 hrs ago"
        descriptionLabel.text = dataSource.description
        authorLabel.text = dataSource.author
    }
}

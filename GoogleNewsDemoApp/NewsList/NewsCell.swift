import UIKit

class NewsCell: UICollectionViewCell {
    private var titleLabel = UILabel()
    public static let identifier = "NewsCell"
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func configure(from dataSource: String) {
        titleLabel.text = dataSource // TODO: replace with model
    }
}

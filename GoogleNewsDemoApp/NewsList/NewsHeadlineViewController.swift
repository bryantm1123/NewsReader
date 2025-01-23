import UIKit

final class NewsHeadlineViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
        Task {
            do {
                try await fetchData()
            } catch {
                print(error) // TODO: Handle error
            }
        }
    }
    
    private func configureCollectionView() {
        let padding: CGFloat = 10
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identifier)
        addCollectionViewContraints()
    }
    
    private func addCollectionViewContraints() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchData() async throws {
        // TODO: connect to API and fetch real data
        try await Task.sleep(for: .seconds(2))
        data.append(contentsOf: Array(repeating: "Item", count: 20))
        await MainActor.run {
            self.collectionView.reloadData()
        }
    }
}

extension NewsHeadlineViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        cell.configure(from: data[indexPath.row])
        return cell
    }
}

extension NewsHeadlineViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item at index \(indexPath.row) tapped")
        // TODO: transition to full story view
    }
}


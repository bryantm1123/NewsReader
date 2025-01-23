import UIKit

final class NewsHeadlineViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
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
        layout = UICollectionViewFlowLayout()
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
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func fetchData() async throws {
        // TODO: connect to API and fetch real data
        try await Task.sleep(for: .seconds(2))
        data.append(contentsOf: Array(repeating: "Item", count: 50))
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {
            fatalError("Unable to dequeue cell with identifier: \(NewsCell.identifier)")
        }
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

extension NewsHeadlineViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let orientation = UIDevice.current.orientation
        
        // TODO: adjust sizing, DRY up every 7th
        if orientation.isLandscape {
            // If item is first of every 7, 1 item per row
            if indexPath.row == 0 || indexPath.row.isMultiple(of: 7) {
                let itemWidth = (view.bounds.width - 30)
                return CGSize(width: itemWidth, height: itemWidth)
            } else {
                // Landscape: 3 items per row
                let itemWidth = (view.bounds.width - 40) / 3
                return CGSize(width: itemWidth, height: itemWidth)
            }
        }
        // If item is first of every 7, 1 item per row
        if indexPath.row == 0 || indexPath.row.isMultiple(of: 7) {
            let itemWidth = (view.bounds.width - 30)
            return CGSize(width: itemWidth, height: itemWidth)
        }
        // Portrait: 2 items per row
        let itemWidth = (view.bounds.width - 30) / 2
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}


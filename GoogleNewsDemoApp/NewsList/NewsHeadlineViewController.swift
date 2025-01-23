import UIKit

final class NewsHeadlineViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    private var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(observeOrientationChanged),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
        
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
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        updateLayoutForOrientation()
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
    
    @objc private func observeOrientationChanged() {
        updateLayoutForOrientation()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func updateLayoutForOrientation() {
        let orientation = UIDevice.current.orientation
        
        if orientation.isPortrait {
            // TODO: If item is every 7th, 1 item per row
            // Portrait: 2 items per row
            let itemWidth = (view.bounds.width - 30) / 2 // TODO: adjust sizing as needed
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        } else if orientation.isLandscape {
            // Landscape: 3 items per row
            let itemWidth = (view.bounds.width - 40) / 3
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
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


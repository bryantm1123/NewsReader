import UIKit

final class NewsViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    private var data: [NewsCellModel] = []
    private let widthOffset: CGFloat = 30
    
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
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
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
        data.append(contentsOf: Array(repeating: NewsCellModel(image: UIImage(systemName: "arrow.trianglehead.clockwise")!,
                                                               title: "Trump To Take Virtual Centre Stage In Davos",
                                                               description: "Donald Trump will star in an eagerly-anticipated online appearance at the World Economic Forum in Davos on Thursday, addressing global elites whose annual gabfest has been consumed by the US president's days-old second term.",
                                                               author: "Ibtimes.com.au",
                                                               time: "2025-01-23T13:53:35Z"), count: 50))
        await MainActor.run {
            self.collectionView.reloadData()
        }
    }
}

extension NewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {
            fatalError("Unable to dequeue cell with identifier: \(NewsCell.identifier)")
        }
        cell.configure(from: data[indexPath.row])
        // TODO: Remove me
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
}

extension NewsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item at index \(indexPath.row) tapped")
        // TODO: transition to full story view
    }
}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Took some inspiration from here: https://stackoverflow.com/a/37152739
        let orientation = UIDevice.current.orientation
        let itemWidth = collectionView.bounds.width - widthOffset
        
        // If item is first of every 7, 1 item per row
        if indexPath.row == 0 || indexPath.row.isMultiple(of: 7) {
            if orientation.isLandscape {
                return sizeForFirstRowLandscape(itemWidth)
            }
            return sizeForFirstRowPortrait(itemWidth)
        }
        
        // Landscape: 3 items per row
        if orientation.isLandscape {
            return sizeForLandscape(itemWidth)
        }
        
        // Portrait: 2 items per row
        return sizeForPortrait(itemWidth)
    }
    
    private func sizeForFirstRowLandscape(_ itemWidth: CGFloat) -> CGSize {
        CGSize(width: itemWidth, height: itemWidth / 3)
    }
    
    private func sizeForFirstRowPortrait(_ itemWidth: CGFloat) -> CGSize {
        CGSize(width: itemWidth, height: 0.75 * itemWidth)
    }
    
    private func sizeForPortrait(_ itemWidth: CGFloat) -> CGSize {
        let itemWidth = itemWidth / 2
        return CGSize(width: itemWidth, height: 1.25 * itemWidth)
    }
    
    private func sizeForLandscape(_ itemWidth: CGFloat) -> CGSize {
        let itemWidth = itemWidth / 4
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}


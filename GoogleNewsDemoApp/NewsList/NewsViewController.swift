import UIKit

final class NewsViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    private var data: [NewsCellModel] = []
    private let widthOffset: CGFloat = 30
    private var viewModel: NewsViewModel
    private var isLoading = false
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadDataIntoCollectionView()
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
    
    private func loadDataIntoCollectionView() {
        guard !isLoading else { return }
        isLoading = true
        Task {
            do {
                let headlines = try await viewModel.fetchTopHeadlines()
                await MainActor.run {
                    data.append(contentsOf: headlines)
                    self.collectionView.reloadData()
                    isLoading = false
                }
            } catch {
                print(error) // TODO: Handle error
            }
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !data.isEmpty else { return }
        let lastElement = data.count - 1
        if !isLoading && indexPath.row == lastElement {
            loadDataIntoCollectionView()
        }
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


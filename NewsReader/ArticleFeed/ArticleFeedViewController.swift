import UIKit
import Combine

final class ArticleFeedViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    private let widthOffset: CGFloat = 30
    private var viewModel: ArticleFeedViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: ArticleFeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViewModelBinding()
        loadData()
    }
    
    private func setupCollectionView() {
        let padding: CGFloat = 10
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.identifier)
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
    
    private func setupViewModelBinding() {
        viewModel.$articles.sink { _ in} receiveValue: { [weak self] _ in
            self?.viewModel.isLoading = false
            self?.collectionView.reloadData()
        }.store(in: &cancellables)
    }
    
    private func loadData() {
        guard !viewModel.isLoading else { return }
        Task {
            do {
                try await viewModel.fetchTopHeadlines()
            } catch {
                await MainActor.run {
                    presentRetryableErrorDialog { [weak self] in
                        self?.loadData()
                    }
                }
            }
        }
    }
}

extension ArticleFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.identifier, for: indexPath) as? ArticleCell else {
            fatalError("Unable to dequeue cell with identifier: \(ArticleCell.identifier)")
        }
        cell.setupContent(from: viewModel.articles[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !viewModel.articles.isEmpty else { return }
        let lastElement = viewModel.articles.count - 1
        if !viewModel.isLoading && indexPath.row == lastElement {
            loadData()
        }
    }
}

extension ArticleFeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = viewModel.articles[indexPath.row]
        let articleViewController = ArticleReaderViewController(article: article)
        navigationController?.pushViewController(articleViewController, animated: true)
    }
}

extension ArticleFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
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
        CGSize(width: itemWidth - widthOffset, height: itemWidth / 3)
    }
    
    private func sizeForFirstRowPortrait(_ itemWidth: CGFloat) -> CGSize {
        CGSize(width: itemWidth - widthOffset, height: 0.75 * itemWidth)
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


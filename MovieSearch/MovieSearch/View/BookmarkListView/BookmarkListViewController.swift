import UIKit
import RxSwift
import RxCocoa

class BookmarkListViewController: UIViewController {
    private enum Section {
        case list
    }
    
    private var bookmarkCollectionView = UICollectionView(frame: .zero, collectionViewLayout: MovieCollectionViewLayout.list())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Movie>?
    private let viewModel = BookmarkListViewModel()
    private let viewWillAppearObservable: PublishSubject<Void> = .init()
    private let didTabBookmarkButton: PublishSubject<String> = .init()
    private let disposeBag: DisposeBag = .init()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBookmarkCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearObservable.onNext(())
    }
    
    private func bind() {
        bindCollectionView()
        
        let input = BookmarkListViewModel.Input(
            viewWillAppearObservable: viewWillAppearObservable,
            didTabBookmarkButton: didTabBookmarkButton
        )
        
        let output = viewModel.transform(input)
        output
            .loadBookmarkedMovies
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .subscribe(onNext: { (owner, movies) in
                owner.populate(movie: movies)
            })
            .disposed(by: disposeBag)
        
        output
            .updateBookmrakedMovies
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .subscribe(onNext: { (owner, movies) in
                owner.populate(movie: movies)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindCollectionView() {
        bookmarkCollectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe(onNext: { (owner, indexPath) in
                let movie = owner.viewModel.bookmarkedMovie[indexPath.row]
                let destination = MovieDetailViewController()
                owner.navigationController?.pushViewController(destination, animated: true)
                destination.setupDetailView(with: movie)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Design.Text.bookmarkListViewTitle
    }
}

extension BookmarkListViewController {
    private func setupBookmarkCollectionView() {
        setupCollectionViewConstraints()
        registerCollectionViewCell()
        setupCollectionViewDataSource()
    }
    
    private func setupCollectionViewConstraints() {
        view.addSubview(bookmarkCollectionView)
        bookmarkCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func registerCollectionViewCell() {
        bookmarkCollectionView.register(MovieCell.self)
    }
    
    private func setupCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: bookmarkCollectionView) { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(MovieCell.self, for: indexPath) else {
                return UICollectionViewCell()
            }
            cell.containerView.changeBookmarkState = { [weak self] in
                self?.didTabBookmarkButton.onNext(item.title)
            }
            cell.setupCell(with: item)
            
            return cell
        }
        bookmarkCollectionView.dataSource = dataSource
    }
    
    private func populate(movie: [Movie]?) {
        guard let movie = movie else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.list])
        snapshot.appendItems(movie, toSection: .list)
        snapshot.reloadItems(movie)
        dataSource?.apply(snapshot)
    }
}

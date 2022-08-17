import UIKit
import RxSwift
import RxCocoa

class MovieSearchViewController: UIViewController {
    private enum Section {
        case list
    }
    
    private let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        searchController.searchBar.barTintColor = Design.Color.defaultBackground
        searchController.searchBar.searchTextField.layer.borderColor = Design.Color.border
        searchController.searchBar.searchTextField.layer.borderWidth = 1
        
        return searchController
    }()
    
    private var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: MovieCollectionViewLayout.list())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Movie>?
    private let viewModel = MovieSearchViewModel()
    private let searchMovieObservable: PublishSubject<String> = .init()
    private let didTabBookmarkButton: PublishSubject<String> = .init()
    private let viewDidLoadObservable: PublishSubject<Void> = .init()
    private let viewWillAppearObservable: PublishSubject<Void> = .init()
    private let viewWillDisappearObservable: PublishSubject<Void> = .init()
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
        viewDidLoadObservable.onNext(())
        setupNavigationBar()
        setupHomeCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearObservable.onNext(())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearObservable.onNext(())
    }
    
    private func bind() {
        bindSearchBar()
        bindCollectionView()
        
        let input = MovieSearchViewModel.Input(
            searchMovieObservable: searchMovieObservable,
            didTabBookmarkButton: didTabBookmarkButton,
            viewDidLoadObservable: viewDidLoadObservable,
            viewWillAppearObservable: viewWillAppearObservable,
            viewWillDisappearObservable: viewWillDisappearObservable
        )
        let output = viewModel.transform(input)
        output
            .movieItemsObservable
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .subscribe(onNext: { (owner, movies) in
                owner.populate(movie: movies)
            })
            .disposed(by: disposeBag)
        
        output
            .reloadMovieItemsObservable
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .subscribe(onNext: { (owner, movies) in
                owner.populate(movie: movies)
            })
            .disposed(by: disposeBag)
        
        output
            .updateMovieItemsObservable
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .subscribe(onNext: { (owner, movies) in
                owner.populate(movie: movies)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindSearchBar() {
        searchController.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .withUnretained(self)
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { (_, searchWord) in
                self.searchMovieObservable.onNext(searchWord)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindCollectionView() {
        movieCollectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe(onNext: { (owner, indexPath) in
                let movie = owner.viewModel.searchResults[indexPath.row]
                let destination = MovieDetailViewController()
                owner.navigationController?.pushViewController(destination, animated: true)
                destination.setupDetailView(with: movie)
            })
            .disposed(by: disposeBag)
        
        movieCollectionView.rx.didScroll
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                owner.navigationItem.searchController?.searchBar.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Design.Text.movieSearchViewTitle
        navigationItem.searchController = searchController
    }
}

extension MovieSearchViewController {
    private func setupHomeCollectionView() {
        setupCollectionViewConstraints()
        registerCollectionViewCell()
        setupCollectionViewDataSource()
    }
    
    private func setupCollectionViewConstraints() {
        view.addSubview(movieCollectionView)
        movieCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func registerCollectionViewCell() {
        movieCollectionView.register(MovieCell.self)
    }
    
    private func setupCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: movieCollectionView) { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(MovieCell.self, for: indexPath) else {
                return UICollectionViewCell()
            }
            cell.containerView.changeBookmarkState = {
                self.didTabBookmarkButton.onNext(item.title)
            }
            cell.setupCell(with: item)
            
            return cell
        }
        movieCollectionView.dataSource = dataSource
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

//
//  BoxOfficeViewController.swift
//  MovieSearch
//
//  Created by Seul Mac on 2022/08/17.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class BoxOfficeViewController: UIViewController, View {
    
    private enum Section {
        case list
    }
    
    private var boxOfficeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: MovieCollectionViewLayout.list())
    private var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeMovie>?
    var disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBoxOfficeCollectionView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "일간 박스오피스"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func bind(reactor: BoxOfficeViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: BoxOfficeViewReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.load }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: BoxOfficeViewReactor) {
        reactor.state
            .map { $0.currentBoxOffice }
            .subscribe (onNext: { [weak self] movies in
                self?.populate(movie: movies)
            })
            .disposed(by: disposeBag)
    }
}

extension BoxOfficeViewController {
    private func setupBoxOfficeCollectionView() {
        setupCollectionViewConstraints()
        registerCollectionViewCell()
        setupCollectionViewDataSource()
        boxOfficeCollectionView.backgroundColor = .secondarySystemBackground
    }
    
    private func setupCollectionViewConstraints() {
        view.addSubview(boxOfficeCollectionView)
        boxOfficeCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func registerCollectionViewCell() {
        boxOfficeCollectionView.register(BoxOfficeCell.self)
    }
    
    private func setupCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeMovie>(collectionView: boxOfficeCollectionView) { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(BoxOfficeCell.self, for: indexPath) else {
                return UICollectionViewCell()
            }
            cell.setupCell(with: item)
            
            return cell
        }
        boxOfficeCollectionView.dataSource = dataSource
    }
    
    private func populate(movie: [BoxOfficeMovie]?) {
        guard let movie = movie else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeMovie>()
        snapshot.appendSections([.list])
        snapshot.appendItems(movie, toSection: .list)
        snapshot.reloadItems(movie)
        dataSource?.apply(snapshot)
    }
}

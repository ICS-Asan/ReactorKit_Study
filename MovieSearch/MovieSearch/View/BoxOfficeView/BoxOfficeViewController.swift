//
//  BoxOfficeViewController.swift
//  MovieSearch
//
//  Created by Seul Mac on 2022/08/17.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    private enum Section {
        case list
    }
    
    private var boxOfficeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: MovieCollectionViewLayout.list())
    private var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeMovie>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBoxOfficeCollectionView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "일간 박스오피스"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension BoxOfficeViewController {
    private func setupBoxOfficeCollectionView() {
        setupCollectionViewConstraints()
        registerCollectionViewCell()
        setupCollectionViewDataSource()
    }
    
    private func setupCollectionViewConstraints() {
        view.addSubview(boxOfficeCollectionView)
        boxOfficeCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func registerCollectionViewCell() {
        boxOfficeCollectionView.register(MovieCell.self)
    }
    
    private func setupCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeMovie>(collectionView: boxOfficeCollectionView) { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(MovieCell.self, for: indexPath) else {
                return UICollectionViewCell()
            }

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

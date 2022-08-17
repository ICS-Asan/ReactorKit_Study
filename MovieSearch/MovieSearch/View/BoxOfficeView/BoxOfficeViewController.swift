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
    private let testData: [BoxOfficeMovie] = [
    BoxOfficeMovie(rank: "1",
                   changedRankValue: "0",
                   isNew: false, title: "헌트",
                   openDate: "2022-08-10",
                   dailyAudience: "504131",
                   totalAudience: "1511592"
                  ),
    BoxOfficeMovie(rank: "2",
                   changedRankValue: "1",
                   isNew: true, title: "한산: 용의 출현",
                   openDate: "2022-07-27",
                   dailyAudience: "324007",
                   totalAudience: "1511592"
                  ),
    BoxOfficeMovie(rank: "5",
                   changedRankValue: "-1",
                   isNew: true, title: "비상선언",
                   openDate: "2022-08-03",
                   dailyAudience: "82873",
                   totalAudience: "1884005"
                  ),
    BoxOfficeMovie(rank: "10",
                   changedRankValue: "3",
                   isNew: false,
                   title: "탑건: 매버릭",
                   openDate: "2022-06-22",
                   dailyAudience: "53850",
                   totalAudience: "7667872")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBoxOfficeCollectionView()
        populate(movie: testData)
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

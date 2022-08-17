//
//  BoxOfficeCell.swift
//  MovieSearch
//
//  Created by Seul Mac on 2022/08/17.
//

import UIKit

final class BoxOfficeCell: UICollectionViewCell {
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let rankBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = Design.Color.main
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3).bold
        label.textColor = .systemBackground
        label.textAlignment = .center
        
        return label
    }()
    
    let rankChangeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        
        return stackView
    }()
    
    let rankChangeSignImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        
        return imageView
    }()
    
    let rankChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textAlignment = .center
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3).bold
        
        return label
    }()

    private let openDateLable: UILabel = {
        let label = UILabel()
        label.font = Design.Font.movieInformation
        
        return label
    }()
    
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Font.movieInformation
        
        return label
    }()
    
    private let movieInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private let newBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    private let newLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body).bold
        label.textColor = .systemYellow
        label.text = "NEW"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setupCell(with movie: BoxOfficeMovie) {
        rankLabel.text = movie.rank
        setupRankChangeLabel(with: movie.changedRankValue)
        setupTitleLable(with: movie.title)
        setupOpenDateLable(with: movie.openDate)
        setupAudienceLable(with: movie)
        hideNewBadge(with: movie.isNew)
    }
    
    private func setupRankChangeLabel(with changedRankValue: String) {
        if changedRankValue == "0" {
            rankChangeSignImageView.image = UIImage(systemName: "minus")
            rankChangeSignImageView.tintColor = .label
            rankChangeLabel.isHidden = true
        } else if changedRankValue.hasPrefix("-") {
            var value = changedRankValue
            value.removeFirst()
            rankChangeSignImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            rankChangeSignImageView.tintColor = .systemBlue
            rankChangeLabel.textColor = .systemBlue
            rankChangeLabel.text = value
        } else {
            rankChangeSignImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            rankChangeSignImageView.tintColor = .systemRed
            rankChangeLabel.textColor = .systemRed
            rankChangeLabel.text = changedRankValue
        }
    }
    
    private func setupTitleLable(with title: String) {
        titleLabel.text = title
    }
    
    private func setupOpenDateLable(with date: String) {
        openDateLable.text = date + " " + "개봉"
    }
    
    private func setupAudienceLable(with movie: BoxOfficeMovie) {
        audienceLabel.text = "\(movie.dailyAudience)명(전체: \(movie.totalAudience)명)"
    }
    
    private func hideNewBadge(with isNew: Bool) {
        if isNew == false {
            newBadgeView.isHidden = true
            newLabel.isHidden = true
        }
    }
    
    private func commonInit() {
        setupContentViewLayout()
    }
    
    private func setupContentViewLayout() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(containerView)
        setupContainerViewLayout()
    }
    
    private func setupContainerViewLayout() {
        containerView.addSubview(rankBadgeView)
        containerView.addSubview(rankChangeStackView)
        containerView.addSubview(movieInformationStackView)
        containerView.addSubview(newBadgeView)
        containerView.addSubview(newLabel)
        setupRankBadgeViewLayout()
        setupRankChangeStackViewLayout()
        setupMovieInformationStackViewLayout()
        setupNewBadgeViewLayout()
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    private func setupRankBadgeViewLayout() {
        rankBadgeView.addSubview(rankLabel)
        rankBadgeView.snp.makeConstraints { make in
            make.height.equalTo(containerView).multipliedBy(0.43)
            make.width.equalTo(rankBadgeView.snp.height)
            make.centerY.equalTo(containerView)
            make.leading.equalTo(containerView).inset(10)
        }
        rankLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    private func setupRankChangeStackViewLayout() {
        rankChangeStackView.addArrangedSubview(rankChangeSignImageView)
        rankChangeStackView.addArrangedSubview(rankChangeLabel)
        rankChangeSignImageView.snp.makeConstraints { make in
            make.height.equalTo(rankChangeLabel)
        }
        rankChangeStackView.snp.makeConstraints { make in
            make.top.equalTo(rankBadgeView.snp.bottom).offset(5)
            make.centerX.equalTo(rankBadgeView)
        }
    }
    
    private func setupMovieInformationStackViewLayout() {
        setupMovieInformationStackView()
        movieInformationStackView.snp.makeConstraints { make in
            make.leading.equalTo(rankBadgeView.snp.trailing).offset(10)
            make.top.bottom.trailing.equalTo(containerView).inset(10)
        }
    }
    
    private func setupMovieInformationStackView() {
        movieInformationStackView.addArrangedSubview(titleLabel)
        movieInformationStackView.addArrangedSubview(openDateLable)
        movieInformationStackView.addArrangedSubview(audienceLabel)
    }
    
    private func setupNewBadgeViewLayout() {
        newLabel.snp.makeConstraints { make in
//            make.edges.equalTo(newBadgeView)
            make.top.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
        }
        
        newBadgeView.snp.makeConstraints { make in
            make.width.height.equalTo(newLabel).offset(5)
            make.centerX.centerY.equalTo(newLabel)
        }
    }
}

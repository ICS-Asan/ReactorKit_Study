import UIKit
import SnapKit
import SDWebImage

final class MovieInformationView: UIView {
    var changeBookmarkState: (() -> Void)?
    
    private var isBookmarked: Bool {
        return bookmarkButton.tintColor == Design.Color.bookmarkedButton
    }

    private let posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Font.movieInformationTitle
        
        return label
    }()

    private let directorLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Font.movieInformation
        
        return label
    }()
    
    private let actorLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Font.movieInformation
        
        return label
    }()
    
    private let userRatingLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Font.movieInformation
        
        return label
    }()
    
    private let textInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let bookmarkButton: UIButton = {
       let button = UIButton()
        button.setImage(Design.Image.bookmarkButton, for: .normal)
        button.tintColor = Design.Color.normalButton
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setupView(with movie: Movie) {
        setupPosterImageView(url: movie.image)
        setupTitleLabel(with: movie.title)
        setupDirectorLabel(with: movie.director)
        setupActorLabel(with: movie.actor)
        setupUserRatingLable(with: movie.userRating)
        setupBookmarkButtonColor(with: movie.isBookmarked)
    }
    
    func setupBookmarkButtonColor(with isBookmarked: Bool) {
        if isBookmarked {
            bookmarkButton.tintColor = Design.Color.bookmarkedButton
        } else {
            bookmarkButton.tintColor = Design.Color.normalButton
        }
    }
    
    private func setupPosterImageView(url: String) {
        if url.isEmpty {
            posterImageView.sd_setImage(with: URL(string: Design.Text.defaultPosterURL))
        } else {
            posterImageView.sd_setImage(with: URL(string: url))
        }
    }
    
    private func setupTitleLabel(with title: String) {
        titleLabel.text = title
    }
    
    private func setupDirectorLabel(with director:String) {
        directorLabel.text = Design.Text.directorTitle + director
    }
    
    private func setupActorLabel(with actor: String) {
        actorLabel.text = Design.Text.actorTitle + actor
    }
    
    private func setupUserRatingLable(with userRating: String) {
        userRatingLabel.text = Design.Text.userRatingTitle + userRating
    }
    
    private func commonInit() {
        setupPosterImageViewLayout()
        setupTextInformationStackViewLayout()
        setupBookmarkButtonLayout()
        setupBookmarkButtonAction()
    }
    
    private func setupPosterImageViewLayout() {
        addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.7)
        }
    }
    
    private func setupTextInformationStackViewLayout() {
        setupTextInformationStackView()
        addSubview(textInformationStackView)
        textInformationStackView.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).inset(-10)
            make.top.bottom.equalTo(posterImageView)
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupTextInformationStackView() {
        textInformationStackView.addArrangedSubview(titleLabel)
        textInformationStackView.addArrangedSubview(directorLabel)
        textInformationStackView.addArrangedSubview(actorLabel)
        textInformationStackView.addArrangedSubview(userRatingLabel)
    }
    
    private func setupBookmarkButtonLayout() {
        addSubview(bookmarkButton)
        bookmarkButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
        }
    }
    
    private func setupBookmarkButtonAction() {
        bookmarkButton.addTarget(self, action: #selector(didTabBookmarkButton), for: .touchDown)
    }
    
    @objc private func didTabBookmarkButton() {
        changeBookmarkState?()
    }
}

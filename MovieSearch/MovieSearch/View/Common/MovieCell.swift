import UIKit

final class MovieCell: UICollectionViewCell {
    let containerView = MovieInformationView()
    var changeFavoriteState: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setupCell(with movie: Movie) {
        containerView.setupView(with: movie)
    }
    
    private func commonInit() {
        setupContainerViewLayout()
        drawUnderLine()
    }
    
    private func setupContainerViewLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    private func drawUnderLine() {
        let underLine = CALayer()
        underLine.frame = CGRect(
            x: 10,
            y: contentView.frame.height,
            width: contentView.frame.width - 20,
            height: 1
        )
        underLine.backgroundColor = Design.Color.cellDivider
        layer.addSublayer(underLine)
    }
}

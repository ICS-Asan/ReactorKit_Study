import UIKit

enum MovieCollectionViewLayout {
    static func list() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemsize = NSCollectionLayoutSize(widthDimension: Design.Size.itemWidth,
                                                  heightDimension: Design.Size.itemHeight)
            let item = NSCollectionLayoutItem(layoutSize: itemsize)
            let groupSize = NSCollectionLayoutSize(widthDimension: itemsize.widthDimension,
                                                   heightDimension: itemsize.heightDimension)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        return layout
    }
}

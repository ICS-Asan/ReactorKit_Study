import UIKit

class MovieTabBarController: UITabBarController {
    let searchNavigationController = UINavigationController(rootViewController: MovieSearchViewController())
    let bookmarkNavigationController = UINavigationController(rootViewController: BookmarkListViewController())
    
    init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupTabBarViews()
        setupTabBarItem()
        setupNavigationBarColor()
    }
    
    private func setupTabBarViews() {
        setViewControllers([searchNavigationController, bookmarkNavigationController], animated: true)
    }
    
    private func setupTabBarItem() {
        searchNavigationController.tabBarItem = UITabBarItem(
            title: Design.Text.searchViewTabBarTitle,
            image: Design.Image.search,
            selectedImage: Design.Image.search
        )
        bookmarkNavigationController.tabBarItem = UITabBarItem(
            title: Design.Text.bookmarkListViewTabBarTitle,
            image: Design.Image.normalBookmark,
            selectedImage: Design.Image.selectedbookmark
        )
        tabBar.tintColor = Design.Color.main
        tabBar.unselectedItemTintColor = .systemGray
    }
    
    private func setupNavigationBarColor() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

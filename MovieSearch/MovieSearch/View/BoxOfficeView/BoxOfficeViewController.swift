//
//  BoxOfficeViewController.swift
//  MovieSearch
//
//  Created by Seul Mac on 2022/08/17.
//

import UIKit

class BoxOfficeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "일간 박스오피스"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

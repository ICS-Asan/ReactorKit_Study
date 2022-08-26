//
//  UIViewController+Rx.swift
//  MovieSearch
//
//  Created by Seul Mac on 2022/08/26.
//

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        let viewDidLoadEvent = self.methodInvoked(#selector(base.viewDidLoad)).map { _ in }
        return ControlEvent(events: viewDidLoadEvent)
    }
    
    var viewWillAppear: ControlEvent<Void> {
        let viewWillAppearEvent = self.methodInvoked(#selector(base.viewWillAppear)).map { _ in }
        return ControlEvent(events: viewWillAppearEvent)
    }
}

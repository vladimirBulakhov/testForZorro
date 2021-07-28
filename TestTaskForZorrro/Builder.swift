//
//  Builder.swift
//  TestTaskForZorrro
//
//  Created by Vladimir Bulakhov on 27.07.2021.
//

import Foundation

class ViewControllerBuilder {
    
    static func createBeerListViewController() -> BeerListViewController {
        let viewController = BeerListViewController()
        viewController.viewModel = BeerListViewModel()
        return viewController
    }
    
    static func createDetailBeerViewController(beer:Beer) -> DetailBeerViewController {
        let viewController = DetailBeerViewController()
        viewController.viewModel = DetailBeerViewModel(beer: beer)
        return viewController
    }
    
}

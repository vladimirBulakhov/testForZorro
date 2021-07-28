//
//  DetailBeerViewModel.swift
//  TestTaskForZorrro
//
//  Created by Vladimir Bulakhov on 28.07.2021.
//

import Foundation

protocol DetailBeerViewModelDelegate {
    var beer: Beer { get }
}

class DetailBeerViewModel: DetailBeerViewModelDelegate {
    var beer: Beer
    init(beer: Beer) {
        self.beer = beer
    }
}

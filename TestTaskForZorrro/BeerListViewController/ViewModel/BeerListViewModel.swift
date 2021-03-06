//
//  BeerListViewModel.swift
//  TestTaskForZorrro
//
//  Created by Vladimir Bulakhov on 27.07.2021.
//

import Foundation
import RxSwift

protocol BeerListViewModelDelegate {
    var beerArray: BehaviorSubject<[Beer]> { get }
    var errorSubject: PublishSubject<String> { get }
    func getBeerList()
    func updateListIfNeeded(index: Int)
    func refreshList() -> Single<[Beer]>
}

class BeerListViewModel: BeerListViewModelDelegate {
    var beerArray =  BehaviorSubject<[Beer]>(value: [])
    var errorSubject = PublishSubject<String>()
    private var page = 1
    private var lastPageIsReached = false
    private var disposeBag = DisposeBag()
    
    func getBeerList() {
        NetworkManager.getBeerList(forPage: page).subscribe { (beers) in
            if beers != [] {
                if var newBeerArray = try? self.beerArray.value() {
                    newBeerArray.append(contentsOf: beers)
                    self.beerArray.onNext(newBeerArray)
                } else {
                    var newBeerArray = [Beer]()
                    newBeerArray.append(contentsOf: beers)
                    self.beerArray.onNext(newBeerArray)
                }
            } else  {
                self.lastPageIsReached = true
            }
        } onFailure: { (error) in
            self.errorSubject.onNext(error.localizedDescription)
        }.disposed(by: disposeBag)
        self.page += 1
    }
    
    func updateListIfNeeded(index: Int) {
        do {
            let beerArray = try self.beerArray.value()
            if index == beerArray.count - 1 && !lastPageIsReached {
                getBeerList()
            }
        } catch {
            print(error)
        }
    }
    
    func refreshList() -> Single<[Beer]> {
        page = 1
        lastPageIsReached = false
        return NetworkManager.getBeerList(forPage: self.page).do { (beers) in
            self.beerArray.onNext(beers)
        } onError: { (error) in
            self.errorSubject.onNext(error.localizedDescription)
        }
    }
}

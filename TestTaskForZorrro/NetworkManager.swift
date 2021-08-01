//
//  NetworkManager.swift
//  TestTaskForZorrro
//
//  Created by Vladimir Bulakhov on 27.07.2021.
//

import Foundation
import Alamofire
import RxSwift

class NetworkManager {
    static func getBeerList(forPage page:Int) -> Single<[Beer]> {
        return Single<[Beer]>.create { (single) -> Disposable in
            if let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)&per_page=20") {
                AF.request(url).validate().responseData { (responseData) in
                    switch responseData.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let beerArray = try decoder.decode([Beer].self, from: data)
                            single(.success(beerArray))
                        } catch {
                            print(error)
                            single(.failure(error))
                        }
                    case.failure(let error):
                        single(.failure(error))
                    }
                }
            } else {
                single(.failure(NSError(domain: "URL is not correct", code: 777, userInfo: nil)))
            }
            return Disposables.create {}
        }
    }
}

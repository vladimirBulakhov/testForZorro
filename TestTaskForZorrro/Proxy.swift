//
//  Proxy.swift
//  TestTaskForZorrro
//
//  Created by Vladimir Bulakhov on 28.07.2021.
//

import Foundation

final class Cache: NSCache<NSString, NSData> {

    static let sharedInstance = Cache()

    private override init() {}
 }

class Proxy {
    static func getImageDataForUrl(urlString: String) -> Data? {
        if let data = Cache.sharedInstance.object(forKey: urlString as NSString) {
            return data as Data
        } else {
            guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else { return nil }
            Cache.sharedInstance.setObject(data as NSData, forKey: urlString as NSString)
            return data
        }
    }
}

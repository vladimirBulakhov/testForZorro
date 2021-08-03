//
//  DownloadingImageView.swift
//  TestTaskForZorrro
//
//  Created by Vladimir Bulakhov on 03.08.2021.
//

import UIKit

class DownloadingImageView: UIImageView {
    
    var urlString:String?
    
    func downloadAndSetImage(for urlString: String?) {
        self.urlString = urlString
        DispatchQueue.global(qos: .utility).async {
            if let urlStr = urlString, let data = Proxy.getImageDataForUrl(urlString: urlStr) {
                if self.urlString == urlString {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.image = UIImage.defaultBeerImage
                }
            }
        }
    }
    
}


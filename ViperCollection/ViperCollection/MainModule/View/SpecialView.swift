//
//  SpecialView.swift
//  ViperCollection
//
//  Created by 17515726 on 19/06/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//
import UIKit
import Alamofire
import AlamofireImage
import Foundation

class SBOLImage: UIImageView {
    
    var completedView: UIImage?
    let imageCahce = AutoPurgingImageCache()

    
    var placeholder: UIImage? {
        didSet {
            self.image = placeholder
        }
    }
    var url: String? {
        didSet {
            if let url = url{
                downloadImage(url: url)
            }
        }
    }
    
    private func downloadImage(url: String){
        
        if let imageFromCache = imageCahce.image(withIdentifier: url){
            self.image = imageFromCache
            return
        }
        
       let concurency = DispatchQueue.global(qos: .userInteractive)
        concurency.async {
            Alamofire.request(url).responseImage{ response in
                print(response.request)
                let imageToCache = UIImage(data: response.data!)
                self.imageCahce.add(imageToCache!, withIdentifier: url)
                self.image = imageToCache
            }
        }
    }
}

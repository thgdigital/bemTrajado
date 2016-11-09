//
//  ImageHelper.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 11/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import Kingfisher

//public typealias ImageLoadCompletionBlock = (_ image: UIImage?) -> Void
//
//class ImageHelper: NSObject {
//    
//    class func loadImageWithUrl(_ url: URL, completion: @escaping ImageLoadCompletionBlock) {
//        
//        let downloader = KingfisherManager.sharedManager.downloader
//        let myCache = ImageCache(name: url.absoluteString)
//        
//        let optionInfo: KingfisherOptionsInfo = [
//            .ForceRefresh,
//            .TargetCache(myCache)
//        ]
//        
//        downloader.downloadImageWithURL(url, options: optionInfo, progressBlock: nil) { (image, error, imageURL, originalData) -> () in
//            completion(image: image)
//        }
//    }
//}
//
//extension UIImageView {
//    func loadImageWithUrl(_ url: String, placeholder: UIImage?) {
//        if let _placeholder = placeholder {
//            self.image = _placeholder
//        }
//        
//        ImageHelper.loadImageWithUrl(URL(string: url)!) { (image) -> Void in
//            self.image = image
//        }
//    }
//    
//    func loadResourceImageWithUrl(_ url: String, placeholder: UIImage?) {
//        if let _placeholder = placeholder {
//            self.image = _placeholder
//        }
//        
//        let _url = URL(string: url)
//        let resource =  Resource(_url!, cacheKey: url)
//        
//        let optionInfo: KingfisherOptionsInfo = [
//            .transition(ImageTransition.fade(0.5))
//        ]
//    
//        self.kf_setImageWithResource(resource, placeholderImage: UIImage(named: "placeholder"), optionsInfo: optionInfo, progressBlock: nil, completionHandler: nil)
//    }
//}

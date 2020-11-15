 

import Foundation
import UIKit



struct APIEndPoints {
      static let photosBaseApi = "https://picsum.photos/"
      static let photoCollectionApi = photosBaseApi + "list"
    static func returnPhotoLink(forImageSize size: CGSize, andId id: Int) -> String
    {
    return "\(photosBaseApi)\(Int(size.width))/\(Int(size.height))?image=\(id)"
    }
}


let imageCache = NSCache<NSString, UIImage>()

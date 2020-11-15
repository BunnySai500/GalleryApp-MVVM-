 

import Foundation
import UIKit

class CustomCacheImageView: UIImageView {
    var urlString: String?
    
    func loadImageforID(imageId id: Int)
    {
    let apiImageString = APIEndPoints.returnPhotoLink(forImageSize: self.frame.size, andId: id)
        
        self.urlString = apiImageString
    guard let imageLink = URL(string: apiImageString) else {return}
    image = nil
        if let str = self.urlString, let cachedImage = imageCache.object(forKey: NSString(string: str))
        {
        self.image = cachedImage
        //print("returned after fetching fromcache")
        return
        }
    APIService.getDataFromEndpoint(urlString: imageLink) { (error, data) in
        if let err = error{
        print(err)
        return}
        if let imagedate = data, let galleryimage = UIImage(data: imagedate){
        DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else{return}
        if strongSelf.urlString == apiImageString
        {strongSelf.image = galleryimage}}
        imageCache.setObject(galleryimage, forKey: NSString(string: apiImageString))
        //print("returned after fetching feshely")
        }}
    }
    
    
    
}





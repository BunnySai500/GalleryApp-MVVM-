 

import Foundation
import UIKit

protocol ConfigurableCell {
    func configureCell(with item: GalleryObjectModel)
}

class GalleryCell: UICollectionViewCell, ConfigurableCell {
    @IBOutlet weak var photoImageView: CustomCacheImageView!
   
    @IBOutlet weak var authorNameLBL: UILabel!
    var galleryItem: GalleryObjectModel?
    static let reuseId = "galleryCellReuseId"
    func configureCell(with item: GalleryObjectModel) {
        self.galleryItem = item
        guard let gitem = galleryItem else{return}
        if let id = gitem.id{
        photoImageView.loadImageforID(imageId: id)
        }
        if let author = gitem.author
        {
        authorNameLBL.numberOfLines = 2
        authorNameLBL.text = author
        
        }
    }
    
    
}

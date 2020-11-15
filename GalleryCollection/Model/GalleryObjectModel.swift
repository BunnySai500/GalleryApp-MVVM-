 
import Foundation

struct GalleryObjectModel: Decodable {
    var id: Int?
    var author: String?
    var visitingAdress: String?
    
    enum CodingKeys: String, CodingKey {
        case id, author
        case visitingAdress = "post_url"
    }
}


import Foundation
import UIKit



class GalleryCollectionViewModel: NSObject {
    
    private weak var collection: UICollectionView?
    var galleryItems: [GalleryObjectModel]?
    var selectedItem: GalleryObjectModel?
    var collectionTitle: String?
    init(_ collection: UICollectionView, _ title: String) {
        super.init()
        self.collection = collection
        self.collectionTitle = title
    registerCells()
    loadGalleryItems()
    }
    func loadGalleryItems()
    {
        guard let url = URL(string: APIEndPoints.photoCollectionApi) else {return}
        APIService.getDataFromEndpoint(urlString: url) { (error, APIdata) in
        if let err = error {print(err)}
        if let galleryData = APIdata{
        JsonParser.getJsonDataObjectsfromResponse(withData: galleryData, type: GalleryObjectModel.self) { jsonerr, objects in
        if let jerr = jsonerr {print(jerr)}
        if let galleryobjects = objects{
        self.galleryItems = galleryobjects
         //print("items are here", self.galleryItems)
            DispatchQueue.main.async { [weak self] in
                guard let strongself = self else {return}
        strongself.collection?.reloadData()
            }
            }}}}
    }
    private func registerCells()
    {
        collection?.register(UINib(nibName: "GalleryCell", bundle: nil), forCellWithReuseIdentifier: GalleryCell.reuseId)
    }
}


extension GalleryCollectionViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = galleryItems else {
            return 0
        }
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let items = galleryItems else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.reuseId, for: indexPath)
        if let c_cell = cell as? ConfigurableCell
        {
        c_cell.configureCell(with: items[indexPath.item])
        return c_cell as? UICollectionViewCell ?? cell
        }
        
    return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let coll = collection else{return CGSize.zero}
       if UIScreen.main.bounds.height > UIScreen.main.bounds.width
       {
       return CGSize(width: (coll.bounds.size.width)/2, height: (coll.bounds.size.height)/2.5)
       }
       else {
       return CGSize(width: (coll.bounds.size.width)/3, height: (coll.bounds.size.height)/2)
       }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

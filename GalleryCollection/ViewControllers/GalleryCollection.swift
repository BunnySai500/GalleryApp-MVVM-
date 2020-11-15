 

import UIKit

class GalleryCollection: UICollectionViewController {
    var vieModel: GalleryCollectionViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .black
        vieModel = GalleryCollectionViewModel(self.collectionView, "Picsum Gallery")
        self.collectionView.delegate = vieModel
        self.collectionView.dataSource = vieModel
        self.title = vieModel?.collectionTitle
        collectionView.reloadData()
         NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        }
  @objc func rotated() {
       collectionView.reloadData()
   }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

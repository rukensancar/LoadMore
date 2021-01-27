//
//  KesfetCollectionViewCell.swift
//  LoadMore
//
//  Created by Ruken Sancar on 21.01.2021.
//

import UIKit
import Kingfisher

class KesfetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fotografCollectionView: UICollectionView!
    @IBOutlet weak var label: UILabel!
    
    var fotoList = [FotografModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fotografCollectionView.delegate = self
        fotografCollectionView.dataSource = self
        self.fotografCollectionView.reloadData()
    }
}

extension KesfetCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.fotoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FotografCollectionViewCell = fotografCollectionView.dequeueReusableCell(withReuseIdentifier: "fotografCell", for: indexPath) as! FotografCollectionViewCell
        
        let url = URL(string: fotoList[indexPath.row].fotografUrl)
        cell.image.kf.setImage(with: url!)
    
        return cell
    }
}

//
//  ViewController.swift
//  LoadMore
//
//  Created by Ruken Sancar on 21.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var itemsArray: [KesfetModel] = []
    
    var loadingView: LoadingReusableView?
    
    var isLoading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    func loadData() {
        isLoading = false
        collectionView.collectionViewLayout.invalidateLayout()
        
        for i in 0...2 {
            
            itemsArray.append(getString(i: i))
        }
        self.collectionView.reloadData()
    }
    
    func getString(i: Int) -> KesfetModel {
        
        var kesfetModel = KesfetModel()
        kesfetModel.aciklama = "indexPath.row \(i)"
        
        var fotograModel = FotografModel()
        fotograModel.fotografUrl.append("https://firebasestorage.googleapis.com/v0/b/dimidi-b4e22.appspot.com/o/ModelTip%2Ffood-delivery.png?alt=media&token=e219f827-e271-499f-981f-4be3ce762a5d")
        for _ in 0...i + 1  {
            kesfetModel.fotoList.append(fotograModel)
        }
        
        return kesfetModel
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : KesfetCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "kesfetCollectionViewCell", for: indexPath) as! KesfetCollectionViewCell
        

        cell.fotoList = itemsArray[indexPath.row].fotoList
        
        cell.label.text = itemsArray[indexPath.row].aciklama
 
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        self.view.layoutIfNeeded()
        let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        self.collectionViewHeight.constant = height
        /*
         if indexPath.row == itemsArray.count - 1 && !self.isLoading {
         loadMoreData()
         }*/
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            let start = itemsArray.count
            let end = start + 16
            DispatchQueue.global().async {
                // fake background loading task
                sleep(2)
                for i in start...end {
                    self.itemsArray.append(self.getString(i:i))
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loadingresuableviewid", for: indexPath) as! LoadingReusableView
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !isLoading {
                loadMoreData()
            }
        }
    }
}

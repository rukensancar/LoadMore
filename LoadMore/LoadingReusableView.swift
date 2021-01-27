//
//  LoadingReusableView.swift
//  LoadMore
//
//  Created by Ruken Sancar on 21.01.2021.
//

import UIKit

class LoadingReusableView: UICollectionReusableView {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.color = UIColor.red
    }
}


//
//  EffectsViewController.swift
//  BeautyFilter
//
//  Created by Erick Borges on 22/06/21.
//

import UIKit

class EffectsViewController: UIViewController {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var viewOverrided: UIView!
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImage.image = image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
    }
    
}

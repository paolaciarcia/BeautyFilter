//
//  EffectsViewController.swift
//  BeautyFilter
//
//  Created by Erick Borges on 22/06/21.
//

import UIKit
import CoreImage

class EffectsViewController: UIViewController {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var viewOverrided: UIView!
    
    var image: UIImage?
    
    lazy var filterManager: FilterManager = {
        guard let image = image else { fatalError() }
            let filterManager = FilterManager(image: image)
            
            return filterManager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImage.image = image
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        selectedImage.image = filterManager.applyFilter(type: FilterType(rawValue: 5)!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
    }
    
}

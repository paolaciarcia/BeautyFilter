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
    
    let filterImageNames = [
        "comic",
        "sepia",
        "halftone",
        "crystallize",
        "vignette",
        "noir"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImage.image = image
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
    }
}
//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension EffectsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterManager.filterNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EffectCollectionViewCell
        cell?.imageViewEffect.image = UIImage(named: filterImageNames[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let filter = FilterType(rawValue: indexPath.row) {
            let filteredImage = self.filterManager.applyFilter(type: filter)
            selectedImage.image = filteredImage
        }
    }
}

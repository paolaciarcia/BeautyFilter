//
//  FilterManager.swift
//  BeautyFilter
//
//  Created by Erick Borges on 22/06/21.
//

import UIKit


class FilterManager {
    
    let originalImage: UIImage
    //região que será aplicada os efeitos do CoreImage
    let context = CIContext()
    
    let filterNames = [
        "CIComicEffect",
        "CISepiaTone",
        "CICMYHalftone",
        "CICrystallize",
        "CIVignette",
        "CIPhotoEffectNoir"
    ]
    
    init(image: UIImage) {
        self.originalImage = image
    }
    
    func applyFilter(type: FilterType) -> UIImage {
        let ciImage = CIImage(image: originalImage)
        let filter = CIFilter(name: filterNames[type.rawValue])!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        switch type {
        case .comic:
            break
        case .sepia:
            //intensidade do sépia
            filter.setValue(1.0, forKey: kCIInputIntensityKey)
        case .halftone:
            //largura dos "bloquinhos"
            filter.setValue(25, forKey: kCIInputWidthKey)
        case .crystallize:
            filter.setValue(25, forKey: kCIInputRadiusKey)
        case .vignette:
            filter.setValue(3, forKey: kCIInputIntensityKey)
            filter.setValue(30, forKey: kCIInputRadiusKey)
        case .noir:
            break
        }
        //a key da acesso a imagem de saída, ou seja, a imagem que já foi filtrada
        let filteredImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
        let cgImage = context.createCGImage(filteredImage, from: filteredImage.extent)
        
        return UIImage(cgImage: cgImage!)
    }
}

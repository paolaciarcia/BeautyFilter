//
//  SaveImageViewController.swift
//  BeautyFilter
//
//  Created by Erick Borges on 22/06/21.
//

import UIKit
import Photos

class SaveImageViewController: UIViewController {
    
    //MARK: - IBOutlets

    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var savePhoto: UIButton!
    @IBOutlet weak var restart: UIButton!
    
    //MARK: - Properties

    var image: UIImage?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImage.image = image
        selectedImage.layer.cornerRadius = 10
        savePhoto.layer.cornerRadius = 10
        restart.layer.cornerRadius = 10
    }
    
    //MARK: - IBAcitons

    @IBAction func savePressed(_ sender: UIButton) {
        //solicita ao usuário que de acesso ao album de fotos
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                self.saveImage()
            default:
                self.showAlert(title: "ERRO", message: "Você precisa autorizar o acesso ao álbum para pode salvar sua fotos")
            }
        }
    }
    
    @IBAction func restartPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: - Methods

    func saveImage() {
        PHPhotoLibrary.shared().performChanges {
            //será feita uma requisição para inserir a foto no album de fotos
            let newRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.image!)
            //determina onde será colocada a imagem. neste caso será colocado em um album padrão
            let addAssetRequest = PHAssetCollectionChangeRequest()
            addAssetRequest.addAssets([newRequest.placeholderForCreatedAsset as Any] as NSArray)
            
        } completionHandler: { (success, erro) in
            if success {
                DispatchQueue.main.async {
                    self.showAlert(title: "Imagem salva!", message: "Sua imagem foi salva no álbum de fotos!")
                    print("imagem salva com sucesso")
                }
            } else {
                print("ERRO")
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

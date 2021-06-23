//
//  ViewController.swift
//  BeautyFilter
//
//  Created by Erick Borges on 22/06/21.
//

import UIKit

class EntryViewController: UIViewController {
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - IBActions

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let alertController = UIAlertController(
            title: "Escolha uma imagem",
            message: "De onde você quer escolher sua imagem?",
            preferredStyle: .actionSheet
        )
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(
                UIAlertAction(
                    title: "Câmera",
                    style: .default,
                    handler: { _ in
                        imagePicker.sourceType = .camera
                        self.present(imagePicker, animated: true)
                    }
                )
            )
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alertController.addAction(
                UIAlertAction(
                    title: "Biblioteca",
                    style: .default,
                    handler: { _ in
                        imagePicker.sourceType = .photoLibrary
                        self.present(imagePicker, animated: true)
                    }
                )
            )
        }
        
        alertController.addAction(
            UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        )
        
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Prepare segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let effectsVC = segue.destination as? EffectsViewController
        effectsVC?.image = sender as? UIImage
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension EntryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //da acesso a imagem original que foi selecionada
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        //reduzir o tamanho da imagem para aplicar efeitos nela
        let originalWidth = selectedImage.size.width
        let originalHeight = selectedImage.size.height
        let aspectRatio = originalWidth / originalHeight
        var smallSize: CGSize
        //imagem em landscape
        if aspectRatio > 1 {
            smallSize = CGSize(width: 1000, height: 1000 / aspectRatio)
        } else {
            //imagem em portrait
            smallSize = CGSize(width: 1000 * aspectRatio, height: 1000)
        }
        
        //diminui a imagem
        UIGraphicsBeginImageContext(smallSize)
        //a imagem será redesenhada dentro de um outro tamanho
        selectedImage.draw(in: CGRect(x: 0, y: 0, width: smallSize.width, height: smallSize.height))
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "effectsSegue", sender: smallImage)
        }
    }
}

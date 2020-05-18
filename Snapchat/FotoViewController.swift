//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Victor Rodrigues Novais on 14/05/20.
//  Copyright © 2020 Victoriano. All rights reserved.
//

import UIKit
import FirebaseStorage

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var botaoProximo: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func proximoPasso(_ sender: Any) {
        
        self.botaoProximo.isEnabled = false
        self.botaoProximo.setTitle("Carregando...", for: .normal)
        
        let armazenamento = Storage.storage().reference()
        // Criar pasta no storage
        let imagens = armazenamento.child("imagens")
        
        // Recuperar imagem
        if let imagemSelecionada = imagem.image {
            print("Ah")
            if let imagemDados = UIImage.jpegData(imagemSelecionada) as? Data{
                print("Teste")
                imagens.child("imagem.jpg").putData(imagemDados, metadata: nil) { (metaDados, error) in
                    
                    if error == nil {
                        self.botaoProximo.isEnabled = true
                        self.botaoProximo.setTitle("Próximo", for: .normal)
                    } else {
                        print(error)
                    }
                    
                }
            }
        }
    }
    
    
    @IBAction func selecionarFoto(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagemRecuperada = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imagem.image = imagemRecuperada
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
}

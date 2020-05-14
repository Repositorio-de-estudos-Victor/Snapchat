//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Victor Rodrigues Novais on 14/05/20.
//  Copyright © 2020 Victoriano. All rights reserved.
//

import UIKit
import FirebaseAuth

class SnapsViewController: UIViewController {

    @IBAction func logout(_ sender: Any) {
        
        let autenticacao = Auth.auth()
        
        do {
            try autenticacao.signOut()
            dismiss(animated: true, completion: nil)
        } catch {}
        
    }
    
    func exibirMensagem(titulo: String, mensagem: String){
        
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alerta.addAction(acaoCancelar)
        
        present(alerta, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

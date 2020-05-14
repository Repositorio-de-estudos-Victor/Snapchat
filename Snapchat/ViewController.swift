//
//  ViewController.swift
//  Snapchat
//
//  Created by Victor Rodrigues Novais on 13/05/20.
//  Copyright © 2020 Victoriano. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let autenticacao = Auth.auth()
        
        autenticacao.addStateDidChangeListener { (autenticacao, user) in
            if let usuarioLogado = user {
                //Redireciona usuario para tela principal
                self.performSegue(withIdentifier: "loginAutomaticoSegue", sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}


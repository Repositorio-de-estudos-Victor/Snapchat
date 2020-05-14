//
//  EntrarViewController.swift
//  Snapchat
//
//  Created by Victor Rodrigues Novais on 13/05/20.
//  Copyright © 2020 Victoriano. All rights reserved.
//

import UIKit
import FirebaseAuth

class EntrarViewController: UIViewController {
    
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func exibirMensagem(titulo: String, mensagem: String){
        
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alerta.addAction(acaoCancelar)
        
        present(alerta, animated: true, completion: nil)
        
    }


    @IBAction func Entrar(_ sender: Any) {
        
        //Recupera dados digitados
        if let emailR = self.email.text {
            if let senhaR = self.senha.text {
                
                // Autenticar no Firebase
                let autenticacao = Auth.auth()
                autenticacao.signIn(withEmail: emailR, password: senhaR) { (user, error) in
                    
                    if error == nil {
                        
                        if user == nil {
                            self.exibirMensagem(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar autenticação, tente novamente.")
                        }else {
                            //Redireciona usuario para tela principal
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                        
                    }else {
                        self.exibirMensagem(titulo: "Dados incorretos", mensagem: "Verifique os dados digitados e tente novamente!")
                    }
                }
                
            }
        }
    }
}

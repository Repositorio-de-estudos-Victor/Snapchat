//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Victor Rodrigues Novais on 13/05/20.
//  Copyright © 2020 Victoriano. All rights reserved.
//

import UIKit
import FirebaseAuth

class CadastroViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var confirmarSenha: UITextField!

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
    
    @IBAction func cadastrar(_ sender: Any) {
        
        //Recuperar dados digitados
        if let emailR = self.email.text {
            if let senhaR = self.senha.text {
                if let confirmarSenhaR = self.confirmarSenha.text{
                    
                    // Validar senha
                    if senhaR == confirmarSenhaR {
                        
                        // Criar conta no Firebase
                        let autenticacao = Auth.auth()
                        autenticacao.createUser(withEmail: emailR, password: senhaR) { (user, error) in
                            
                            if error == nil {
                                if user == nil {
                                    self.exibirMensagem(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar autenticação, tente novamente.")
                                }else {
                                    //Redireciona usuario para tela principal
                                    self.performSegue(withIdentifier: "cadastroLoginSegue", sender: nil)
                                }
                            }else {
                                
                                //ERROR_INVALID_EMAIL
                                //ERROR_WEAK_PASSWORD
                                //ERROR_EMAIL_ALREADY_IN_USE
                                
                                let errorR = error! as NSError
                                if let codigoErro = errorR.userInfo["FIRAuthErrorUserInfoNameKey"] {
                                    
                                    let erroTexto = codigoErro as! String
                                    var mensagemErro = ""
                                    
                                    switch erroTexto {
                                        case "ERROR_INVALID_EMAIL":
                                            mensagemErro = "E-mail inválido, digite um e-mail válido!"
                                        break;
                                        case "ERROR_WEAK_PASSWORD":
                                            mensagemErro = "Senha precisa ter no mínimo 6 caracteres, com letras e números."
                                        break;
                                        case "ERROR_EMAIL_ALREADY_IN_USE":
                                            mensagemErro = "Esse e-mail já está sendo utilizado, crie sua conta com outro e-mail."
                                        break;
                                        default:
                                            mensagemErro = "Dados digitados estáo incorretos."
                                    }
                                    
                                    self.exibirMensagem(titulo: "Dados inválidos", mensagem: mensagemErro)
                                    
                                }
                                
                            } // Fim validação erro Firebase
                            
                        }
                        
                    }else {
                        self.exibirMensagem(titulo: "Dados incorretos",mensagem: "As senhas precisam ser iguais")
                    } // Fim da validação da senha
                    
                }
            }
        }
        
    }
    

}

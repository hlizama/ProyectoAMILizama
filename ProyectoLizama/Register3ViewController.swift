//
//  Register3ViewController.swift
//  ProyectoLizama
//
//  Created by user178641 on 11/11/20.
//

import UIKit
import Firebase

class Register3ViewController: UIViewController {
    
    
    @IBOutlet weak var txtPassUser: UITextField!
    
    @IBOutlet weak var lblMessageRegister: UILabel!
    @IBAction func EnviarUsuarioFirebase(_ sender: Any) {
        enviarUsuario()
    }
    
    var correo = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //btnEnviarCorreo.isEnabled = false
        // Do any additional setup after loading the view.
        //print(correo)
    }
    
    
    private func enviarUsuario () {
        
        if (txtPassUser.text != "") {
            password = txtPassUser.text!
            Auth.auth().createUser(withEmail: correo, password: password) { authResult, error in
                
                guard let user = authResult?.user, error == nil else {
                    self.lblMessageRegister.text = error!.localizedDescription
                    return
                }
                
                //print("\(user.email!) created")
                
                self.lblMessageRegister.text = "\(user.email!) creado"
            }
        } else {
            lblMessageRegister.text = "Ingrese una contraseña"
        }
    }
    
    
}

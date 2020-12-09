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
    
    var nombre = ""
    var apellido = ""
    var carrera = ""
    var sede = ""
    var correo = ""
    var password = ""
    
    var db: Firestore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()

        //btnEnviarCorreo.isEnabled = false
        // Do any additional setup after loading the view.
        //print(correo)
    }
    
    
    private func enviarUsuario () {
        
        var ref: DocumentReference? = nil
        
        if (txtPassUser.text != "") {
            password = txtPassUser.text!
            Auth.auth().createUser(withEmail: correo, password: password) { authResult, error in
                
                guard let user = authResult?.user, error == nil else {
                    self.lblMessageRegister.text = error!.localizedDescription
                    return
                }
                
                //print("\(user.email!) created")
                
                self.lblMessageRegister.text = "\(user.email!) creado"
                
                ref = self.db.collection("user").addDocument(data: [
                    "idUsuario": user.uid,
                    "nombre": self.nombre,
                    "apellido": self.apellido,
                    "carrera": self.carrera,
                    "sede": self.sede
                    
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
                
                
            }
        } else {
            lblMessageRegister.text = "Ingrese una contraseña"
        }
    }
    
    
}

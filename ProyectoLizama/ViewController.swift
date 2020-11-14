//
//  ViewController.swift
//  ProyectoLizama
//
//  Created by user178474 on 10/12/20.
//

import UIKit

import Firebase


class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtCorreo: UITextField!
    
    
    @IBOutlet weak var txtContrasena: UITextField!
    
    @IBOutlet weak var constraintBottomScroll: NSLayoutConstraint!
    
    @IBAction func tapToClodeKeyboard(_ sender: Any) {
            self.view.endEditing(true)
    }
    
    
    @IBOutlet weak var lblMensaje: UILabel!
    
    var email = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginUsuario(_ sender: Any) {
        login()
    }
    
    var handle: AuthStateDidChangeListenerHandle?
    
    var uid2 : String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SegueLoginSend") {
            let segundaVista = segue.destination as! HomeViewController
            segundaVista.uid = self.uid2
        }
    }
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // [START auth_listener]
       handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        
            if(user?.uid != nil){
               
                self.uid2 = user?.uid
                
                
            }
       }
        
    }
    
     override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       // [START remove_auth_listener]
       Auth.auth().removeStateDidChangeListener(handle!)
       // [END remove_auth_listener]
     }
    
    private func login() {
        
        print(txtCorreo.text!)
        print(txtContrasena.text!)
        
        if (txtCorreo.text != "" && txtContrasena.text != "") {
         
          email = txtCorreo.text!
          password = txtContrasena.text!
            
           Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
           
           if let error = error {
             let authError = error as NSError
             if (authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
             
             
             } else {
                self?.lblMensaje.text = error.localizedDescription
                      return
             }
         
           }
           
           // redirige home
            
            print("EXITO")
            
            //self.navigationController?.popViewController(animated: true)
            
           
         }
         

        } else {
         
            lblMensaje.text = "Ingrese correo y contraseña"
            
            return
         
        }
     
     }


}


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
    
    //var email = ""
    //var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginUsuario(_ sender: Any) {
        //login()
        if let email = txtCorreo.text, let password = txtContrasena.text {
            Auth.auth().signIn(withEmail: email, password: password) {
                
                (result, error) in
                
                if let result = result, error == nil {
                    self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
                } else {
                    self.lblMensaje.text = error?.localizedDescription
                }
                
            }
        } else {
            self.lblMensaje.text = "Ingrese usuario y contraseña"
        }
        
    }
    
    //var handle: AuthStateDidChangeListenerHandle?
    
    //var uid2 : String?
    
    /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SegueLoginSend") {
            let segundaVista = segue.destination as! HomeViewController
            segundaVista.uid = self.uid2
        }
    } */
    
     /* override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // [START auth_listener]
       handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        
            if(user?.uid != nil){
               
                self.uid2 = user?.uid
                
                //print(user?.uid)
                
            }
       }
        
    } */
    
     /* override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       // [START remove_auth_listener]
       Auth.auth().removeStateDidChangeListener(handle!)
       // [END remove_auth_listener]
     } */
    
    

}


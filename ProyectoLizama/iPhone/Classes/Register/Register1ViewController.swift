//
//  Register1ViewController.swift
//  ProyectoLizama
//
//  Created by user178474 on 10/14/20.
//

import UIKit

import Firebase

class Register1ViewController: UIViewController {

    
    @IBOutlet weak var txtCorreoRegister: BindingTextField!
    
    @IBOutlet weak var lblRegisterM: UILabel!
    
    @IBOutlet weak var btnEnviarCorreo: UIButton!
    
    
    var nombre = ""
    var apellido = ""
    var carrera = ""
    var sede = ""
    	
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        btnEnviarCorreo.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    private func setupTextField(){
        txtCorreoRegister.bind { [weak self] (text) in
            if let isValid = self?.isValidEmail(email: text){
                self?.lblRegisterM.text = isValid ? "Correo valido" : "Correo invalido"
                if (isValid) {
                    self?.btnEnviarCorreo.isEnabled = true
                } else {
                    self?.btnEnviarCorreo.isEnabled = false
                }
            }
        }
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SegueMailSend") {
            let segundaVista = segue.destination as! Register3ViewController
            segundaVista.correo = txtCorreoRegister.text!
            segundaVista.nombre = nombre
            segundaVista.apellido = apellido
            segundaVista.carrera = carrera
            segundaVista.sede = sede
        }
    }
    
}

class BindingTextField: UITextField {

     var textEdited: ((String) -> Void)? = nil
     
     func bind  (completion: @escaping (String) -> Void) {
     
        textEdited = completion
        addTarget( self, action:
            #selector(textFieldEditingChanged(_:)), for:
            .editingChanged)
     
     }
     
    @objc func textFieldEditingChanged (_ textField:UITextField){
        guard let text  = textField.text else {return}
        textEdited?(text)
        
    }

}

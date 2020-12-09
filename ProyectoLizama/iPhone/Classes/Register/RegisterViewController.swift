//
//  RegisterViewController.swift
//  ProyectoLizama
//
//  Created by user178641 on 12/8/20.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtApellido: UITextField!
    
    @IBOutlet weak var txtCarrera: UITextField!
    
    @IBOutlet weak var txtSede: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SegueDataSend") {
            let primeraVista = segue.destination as! Register1ViewController
            primeraVista.nombre = txtNombre.text!
            primeraVista.apellido = txtApellido.text!
            primeraVista.carrera = txtCarrera.text!
            primeraVista.sede = txtSede.text!
        }
    }
}

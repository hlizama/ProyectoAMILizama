//
//  ViewController.swift
//  ProyectoLizama
//
//  Created by user178474 on 10/12/20.
//

import UIKit

import FirebaseUI


class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtcelCorreo: UITextField!
    
    @IBOutlet weak var txtContrasena: UITextField!
    
    @IBOutlet weak var constraintBottomScroll: NSLayoutConstraint!
    
    @IBAction func tapToClodeKeyboard(_ sender: Any) {
            self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


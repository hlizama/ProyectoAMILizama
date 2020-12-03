//
//  PopUpViewController.swift
//  ProyectoLizama
//
//  Created by user178641 on 11/15/20.
//

import UIKit

import FontAwesome_swift

enum ProviderTypePopUp : String{
    case basic
}

class PopUpViewController: UIViewController {
    
    private let mensaje : String
    private let provider : ProviderTypePopUp
    
    init(mensaje:String, provider:ProviderTypePopUp) {
        self.mensaje = mensaje
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implement")
    }
    
    //var modalPresentationStyle: UIModalPresentationStyle{get}
    
    @IBOutlet weak var lblMensaje: UILabel!
    

    @IBAction func btnSali3(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblMensaje.text = mensaje
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
    
        //PopUpViewController.modalTransitionStyle = .crossDissolve
        
    }
    
}

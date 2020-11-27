//
//  HomeViewController.swift
//  ProyectoLizama
//
//  Created by user178641 on 11/13/20.
//

import UIKit

import Firebase

import FontAwesome_swift


enum ProviderType : String{
    case basic
}

class HomeViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var btnHome: UIButton!
    
    var uid : String?
    var handle: AuthStateDidChangeListenerHandle?
    private let email : String
    private let provider : ProviderType
    
    var arrayPublication = [PublicationBE]()
    
    init(email:String, provider:ProviderType) {
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implement")
    }
    
    @IBAction func btnSalir(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
         if(uid == nil) {
            self.dismiss(animated: true, completion: {})
             self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBOutlet weak var tbvPub: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PublicationTableViewCell",bundle: nil )
        
        tbvPub.register(nib, forCellReuseIdentifier :"PublicationTableViewCell")
    
        self.arrayPublication.append(PublicationBE(descripcion: "Los que me conocen saben que me gusta celebrar mi día .. y hoy más que nunca me siento feliz por tanto cariño, gracias a todos por sus saludos, por sus mensajes",
                                                 fecha: "27 de Septiembre",
                                                 foto:"" ))
        self.arrayPublication.append(PublicationBE(descripcion: "Los que me conocen saben que me gusta celebrar mi día .. y hoy más que nunca me siento feliz por tanto cariño, gracias a todos por sus saludos, por sus mensajes",
                                                 fecha: "27 de Septiembre",
                                                 foto:"" ))
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayPublication.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PublicationTableViewCell" //Debe coincidir con el nombre del storyboard y es KeySensitive
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PublicationTableViewCell
        cell.objPlace = self.arrayPublication[indexPath.row]
        
        return cell
    }


    
}

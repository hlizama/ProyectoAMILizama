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

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var btnHome: UIButton!
    
    var uid : String?
    var handle: AuthStateDidChangeListenerHandle?
    private let email : String
    private let provider : ProviderType
    
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func valida(){
       
    }
    
    
    
     /* override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // [START auth_listener]
       handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if(user?.uid == nil){
                self.navigationController?.popViewController(animated: true)
            }
        
        //print(user?.displayName)
          // [START_EXCLUDE]
          //self.setTitleDisplay(user)
          //self.tableView.reloadData()
          // [END_EXCLUDE]
        }
        
    } */
    
    /* override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       // [START remove_auth_listener]
       Auth.auth().removeStateDidChangeListener(handle!)
       // [END remove_auth_listener]
     }  */
    
}

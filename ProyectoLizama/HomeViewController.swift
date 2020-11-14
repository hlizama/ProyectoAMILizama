//
//  HomeViewController.swift
//  ProyectoLizama
//
//  Created by user178641 on 11/13/20.
//

import UIKit

import Firebase

class HomeViewController: UIViewController {
    
    
    var uid : String?
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        valida()
    }
    
    private func valida(){
        print(uid)
    }
    
    
    
    /* override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // [START auth_listener]
       handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if(user?.displayName == nil){
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
     } */
    
}

//
//  HomeViewController.swift
//  ProyectoLizama
//
//  Created by user178641 on 11/13/20.
//

import UIKit

import Firebase

import FontAwesome_swift



enum ProviderType1 : String{
    case basic
}

class PublicateViewController: UIViewController {
    
    
    @IBOutlet weak var btnHome: UIButton!
    
    var uid : String?
    var handle: AuthStateDidChangeListenerHandle?
    private let email : String
    private let provider1 : ProviderType
    var db: Firestore!

    
    init(email:String, provider1:ProviderType) {
        self.email = email
        self.provider1 = provider1
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implement")
    }
    
    @IBAction func btnSalir(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var txtCommentary: UITextField!
    
    
    @IBAction func btnPublicar(_ sender: Any) {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("publication").addDocument(data: [
            "idUsuario": uid,
            "decripcion": txtCommentary.text
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // [START setup]
        //let settings = FirestoreSettings()

        //Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
         
            if let user =  user {
                self.uid = user.uid
            }
            
        }
        
    }


    
}




//
//  HomeViewController.swift
//  ProyectoLizama
//
//  Created by user178641 on 11/13/20.
//

import UIKit

import Firebase

import FontAwesome_swift


enum ProviderType2 : String{
    case basic
}

class CommentaryViewController: UIViewController {
    
    
    @IBOutlet weak var btnHome: UIButton!
    
    var uid : String?
    var handle: AuthStateDidChangeListenerHandle?
    private let email : String
    private let provider2 : ProviderType2
    
    var db: Firestore!
    
    var arrayCommentary = [CommentaryBE]()
    
    init(email:String, provider2:ProviderType2) {
        self.email = email
        self.provider2 = provider2
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implement")
    }
    
    @IBAction func btnSalir(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var tbvPub: UITableView!
    
    
    
    @IBOutlet weak var txtCommentary: UITextField!
    
    
    
    @IBAction func btnEnviarComentario(_ sender: Any) {
        
        
        //print(email)
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("commentary").addDocument(data: [
            "idUsuario": uid,
            "idPublicacion":email,
            "descripcion": txtCommentary.text
            
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
        
        let nib = UINib(nibName: "CommentaryTableViewCell",bundle: nil )
        
        tbvPub.register(nib, forCellReuseIdentifier :"CommentaryTableViewCell")
        
        db = Firestore.firestore()
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
         
            if let user =  user {
                self.uid = user.uid
            }
            
        }
        
        
        
        db.collection("commentary").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
        
                    if let description = document.data()["descripcion"] as? String
                                       {
                        self.addPublication(descripcion: description)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tbvPub.reloadData()
                }
            }
        }
        
        
        
        
    }
    
    func addPublication(descripcion:String){
        self.arrayCommentary.append(CommentaryBE(descripcion: descripcion))
    }
    

    
}


//Sirve para construir el contenido de la tabla
extension CommentaryViewController: UITableViewDataSource { //Tiene 3 metodos principales: number, number, cellFor
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayCommentary.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CommentaryTableViewCell" //Debe coincidir con el nombre del storyboard y es KeySensitive
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommentaryTableViewCell
        cell.objPlace = self.arrayCommentary[indexPath.row]
        
        return cell
    }
    

}

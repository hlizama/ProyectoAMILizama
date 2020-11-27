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

class HomeViewController: UIViewController{
    
    
    @IBOutlet weak var btnHome: UIButton!
    
    var uid : String?
    var handle: AuthStateDidChangeListenerHandle?
    private let email : String
    private let provider : ProviderType
    var db: Firestore!
    
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
         /*if(uid == nil) {
            self.dismiss(animated: true, completion: {}) */
             //self.navigationController?.popViewController(animated: true)
             self.navigationController?.popToRootViewController(animated: true)
        //}
    }
    
    @IBAction func btnPublicar(_ sender: Any) {
        self.navigationController?.pushViewController(PublicateViewController(email: "prueba", provider1: .basic), animated: true)
    }
    
    @IBOutlet weak var tbvPub: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
         
            if let user =  user {
                self.uid = user.uid
            }
            
        }
        
        let nib = UINib(nibName: "PublicationTableViewCell",bundle: nil )
        
        tbvPub.register(nib, forCellReuseIdentifier :"PublicationTableViewCell")
        
        db.collection("publication").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
        
                    if let description = document.data()["decripcion"] as? String
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
        self.arrayPublication.append(PublicationBE(descripcion: descripcion,
                                                  fecha: "27 de Septiembre",
                                                  foto:"" ))
    }

    
}


extension HomeViewController: PublicationTableViewCellDelegate {
    
    func publicationTableViewCell(_ cell: PublicationTableViewCell, irCommentary publication: PublicationBE) {
        
        
    
    }
    
}




//Sirve para construir el contenido de la tabla
extension HomeViewController: UITableViewDataSource { //Tiene 3 metodos principales: number, number, cellFor
    
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




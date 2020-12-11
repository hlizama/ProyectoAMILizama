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
    
    var arrayProfile = [ProfileBE]()
    
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
    
    
    @IBAction func btnProfile(_ sender: Any) {
        
        self.navigationController?.pushViewController(ProfileViewController(email: uid!,provider2: .basic), animated: true)
        
    }
    
    
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
        
        
        db.collection("user").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
        
                    if let nombre = document.data()["nombre"] as? String
                    {
                        let apellido = document.data()["apellido"] as? String
                        let carrera = document.data()["carrera"] as? String
                        let sede = document.data()["sede"] as? String
                        let idUsuario = document.data()["idUsuario"] as? String
                        
                        self.addProfile(nombre: nombre, apellido: apellido ?? "", carrera:carrera ?? "", sede:sede ?? "", idUsuario:idUsuario ?? "")
                    }
                }
                
                DispatchQueue.main.async {
                    self.tbvPub.reloadData()
                }
            }
        }
        
        db.collection("publication").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
        
                    if let description = document.data()["decripcion"] as? String
                                       {
                        
                        let idPublicacion = document.documentID as? String
                        let idUsuario = document.data()["idUsuario"] as? String
                        
                        self.addPublication(descripcion: description, idPublicacion: idPublicacion ?? "", idUsuario:idUsuario ?? "")
                    }
                }
                
                DispatchQueue.main.async {
                    self.tbvPub.reloadData()
                }
            }
        }
        
        
        

        
        

        
    }
    
    func addPublication(descripcion:String, idPublicacion:String, idUsuario:String){
        self.arrayPublication.append(PublicationBE(descripcion: descripcion,
                                                  fecha: "27 de Septiembre",
                                                  foto:"",
                                                  idPublicacion: idPublicacion,
                                                  idUsuario: idUsuario))
    }
    
    func addProfile(nombre:String, apellido:String, carrera:String, sede:String, idUsuario:String){
        self.arrayProfile.append(ProfileBE(nombre: nombre, apellido:apellido, carrera:carrera, sede:sede, idUsuario: idUsuario))
    }

    
}


extension HomeViewController: PublicationTableViewCellDelegate {
    
    func publicationTableViewCell(_ cell: PublicationTableViewCell, irCommentary publication: PublicationBE) {
        self.navigationController?.pushViewController(CommentaryViewController(email:publication.pu_idPublicacion, provider2: .basic), animated: true)
    
    }
    
    func publicationLikeTableViewCell(_ cell: PublicationTableViewCell, publicationLike publication: PublicationBE) {
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("megusta").addDocument(data: [
            "idUsuario": uid,
            "idPublicacion": publication.pu_idPublicacion
            
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }

    }
    
    func publicationProfileTableViewCell(_ cell: PublicationTableViewCell, publicationProfile publication: PublicationBE) {
        self.navigationController?.pushViewController(ProfileViewController(email:publication.pu_idUsuario, provider2: .basic), animated: true)
        
    }
    
    func publicationFollowTableViewCell(_ cell: PublicationTableViewCell, publicationFollow publication: PublicationBE) {
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("seguidos").addDocument(data: [
            "idUsuario": uid,
            "idSeguidor" : publication.pu_idUsuario
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    
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
    cell.delegate = self
    cell.objPlace = self.arrayPublication[indexPath.row]
   
    return cell
}
    

}




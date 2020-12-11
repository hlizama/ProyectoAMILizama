//
//  HomeViewController.swift
//  ProyectoLizama
//
//  Created by user178641 on 11/13/20.
//

import UIKit

import Firebase

import FontAwesome_swift



enum ProviderType4 : String{
    case basic
}



class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var btnHome: UIButton!
    
    var uid : String?
    var handle: AuthStateDidChangeListenerHandle?
    private let email : String
    private let provider2 : ProviderType4
    
    var db: Firestore!
    
    var arrayPublication = [PublicationBE]()
    
    
    var arrayProfile = [ProfileBE]()
    
    init(email:String, provider2:ProviderType4) {
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
    
    @IBOutlet weak var lblNameLastname: UILabel!
    
    @IBOutlet weak var lblCarrera: UILabel!
    
    @IBOutlet weak var lblSede: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ProfileTableViewCell",bundle: nil )
        
        tbvPub.register(nib, forCellReuseIdentifier :"ProfileTableViewCell")
        
        db = Firestore.firestore()
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
         
            if let user =  user {
                self.uid = user.uid
            }
            
        }
        
        //print(email)
        
        db.collection("user").whereField("idUsuario",isEqualTo:email).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
        
                    if let nombre = document.data()["nombre"] as? String
                    {
                        let apellido = document.data()["apellido"] as? String
                        let carrera = document.data()["carrera"] as? String
                        let sede = document.data()["sede"] as? String
                        
                        
                        
                        self.lblNameLastname.text = nombre + " " + apellido!
                        self.lblCarrera.text = carrera!
                        self.lblSede.text = sede!
                        
                        //self.addProfile(nombre: nombre, apellido: apellido ?? "", carrera:carrera ?? "", sede:sede ?? "")
                    }
                }
                
                DispatchQueue.main.async {
                    self.tbvPub.reloadData()
                }
            }
        }
        
    
        
        db.collection("publication").whereField("idUsuario",isEqualTo:email).getDocuments() { (querySnapshot, err) in
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
        self.arrayPublication.append(PublicationBE(descripcion: descripcion, fecha:"10-12-2020", foto: "", idPublicacion: idPublicacion, idUsuario: idUsuario))
    }
    
    
    /* func addProfile(nombre:String, apellido:String, carrera:String, sede:String){
        self.arrayProfile.append(ProfileBE(nombre: nombre, apellido:apellido, carrera:carrera, sede:sede))
    } */
    

    
}

extension ProfileViewController: ProfileTableViewCellDelegate {
    
    func profileTableViewCell(_ cell: ProfileTableViewCell, delete publication: PublicationBE) {
         
        //print(publication.pu_idPublicacion)
        
        db.collection("publication").document(publication.pu_idPublicacion).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        
    }
    
}


//Sirve para construir el contenido de la tabla
extension ProfileViewController: UITableViewDataSource { //Tiene 3 metodos principales: number, number, cellFor
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayPublication.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ProfileTableViewCell" //Debe coincidir con el nombre del storyboard y es KeySensitive
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProfileTableViewCell
        cell.delegate = self
        cell.objPlace = self.arrayPublication[indexPath.row]
        
        return cell
    }
    

}




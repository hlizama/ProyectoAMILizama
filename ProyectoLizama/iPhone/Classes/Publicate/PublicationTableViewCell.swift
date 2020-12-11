//
//  PublicationTableViewCell.swift
//  ProyectoLizama
//
//  Created by user178641 on 11/27/20.
//

import UIKit


protocol PublicationTableViewCellDelegate {
    func publicationTableViewCell(_ cell: PublicationTableViewCell, irCommentary publication: PublicationBE)
    func publicationLikeTableViewCell(_ cell: PublicationTableViewCell, publicationLike publication: PublicationBE)
    func publicationFollowTableViewCell(_ cell: PublicationTableViewCell, publicationFollow publication: PublicationBE)
    func publicationProfileTableViewCell(_ cell: PublicationTableViewCell, publicationProfile publication: PublicationBE)
}


class PublicationTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var imgPlace     : UIImageView!
    @IBOutlet weak private var lblDescripcion      : UILabel!
    @IBOutlet weak private var lblFecha   : UILabel!
    @IBOutlet weak private var lblNombre   : UILabel!
    
    var delegate: PublicationTableViewCellDelegate?
    
   
    
    public var objPlace: PublicationBE! {
        didSet {
            self.updateData()
        }
    }
    
  /*   public var objPlace2: ProfileBE! {
        didSet {
            self.updateData1()
        }
    } */
    

    
    private func updateData() {
        self.lblDescripcion.text       = self.objPlace.pu_descripcion
        self.lblFecha.text    = self.objPlace.pu_fecha
        self.lblNombre.text = self.objPlace.pu_idUsuario
        
    }
    
    
    /* private func updateData1() {
        //print(self.objPlace.pu_idUsuario)
        //if(self.objPlace.pu_idUsuario == self.objPlace2.idUsuario) {
            self.lblNombre.text =  self.objPlace2.nombre + " " + self.objPlace2.apellido
        //}
    } */

    override func draw(_ rect: CGRect) {
        self.imgPlace.layer.cornerRadius = 20
    }
    
    
    
    @IBAction func btnIrComentario(_ sender: Any) {
        //print("asdfasdf")
        self.delegate?.publicationTableViewCell(self, irCommentary: self.objPlace)
    
    }
    
    
    @IBAction func btnMeGusta(_ sender: Any) {
        
        self.delegate?.publicationLikeTableViewCell(self, publicationLike: self.objPlace)
        
    }
    
    @IBAction func btnSeguir(_ sender: Any) {
        
        self.delegate?.publicationFollowTableViewCell(self, publicationFollow: self.objPlace)
        
    }
    
    @IBAction func btnPerfil(_ sender: Any) {
        
        self.delegate?.publicationProfileTableViewCell(self, publicationProfile: self.objPlace)
        
    }
    
    
    
}


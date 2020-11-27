//
//  PublicationTableViewCell.swift
//  ProyectoLizama
//
//  Created by user178641 on 11/27/20.
//

import UIKit


protocol PublicationTableViewCellDelegate {
    func publicationTableViewCell(_ cell: PublicationTableViewCell, irCommentary publication: PublicationBE)
}


class PublicationTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var imgPlace     : UIImageView!
    @IBOutlet weak private var lblDescripcion      : UILabel!
    @IBOutlet weak private var lblFecha   : UILabel!
    
    var delegate: PublicationTableViewCellDelegate?
    
    
    public var objPlace: PublicationBE! {
        didSet {
            self.updateData()
        }
    }
    
    private func updateData() {
        self.lblDescripcion.text       = self.objPlace.pu_descripcion
        self.lblFecha.text    = self.objPlace.pu_fecha
    }

    override func draw(_ rect: CGRect) {
        self.imgPlace.layer.cornerRadius = 20
    }
    
    
    
    @IBAction func btnIrComentario(_ sender: Any) {
        //print("asdfasdf")
        self.delegate?.publicationTableViewCell(self, irCommentary: self.objPlace)
    
    }
    
    
    
}


//
//  PublicationTableViewCell.swift
//  ProyectoLizama
//
//  Created by user178641 on 11/27/20.
//

import UIKit

class CommentaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var lblDescripcion      : UILabel!
    

    public var objPlace: CommentaryBE! {
        didSet {
            self.updateData()
        }
    }
    
    private func updateData() {
        self.lblDescripcion.text  = self.objPlace.pu_descripcion
    }

}


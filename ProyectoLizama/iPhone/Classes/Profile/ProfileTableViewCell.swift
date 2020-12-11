//
//  PublicationTableViewCell.swift
//  ProyectoLizama
//
//  Created by user178641 on 11/27/20.
//

import UIKit


protocol ProfileTableViewCellDelegate {
    func profileTableViewCell(_ cell: ProfileTableViewCell, delete publication: PublicationBE)
}


class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var lblDescripcion      : UILabel!
    
    
    var delegate: ProfileTableViewCellDelegate?
    

    public var objPlace: PublicationBE! {
        didSet {
            self.updateData()
        }
    }
    
    private func updateData() {
        self.lblDescripcion.text  = self.objPlace.pu_descripcion
    }
    
    @IBAction func btnEliminar(_ sender: Any) {
        self.delegate?.profileTableViewCell(self,delete: self.objPlace)
    }
    
    

}





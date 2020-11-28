//
//  PublicationBE.swift
//  ProyectoLizama
//
//  Created by user178641 on 11/27/20.
//

import Foundation

class PublicationBE {
    
    var pu_descripcion      : String
    var pu_fecha  : String
    var pu_foto   : String
    
    init(descripcion: String, fecha: String,  foto: String) {
        self.pu_descripcion      = descripcion
        self.pu_fecha           = fecha
        self.pu_foto            = foto
    }
    
}

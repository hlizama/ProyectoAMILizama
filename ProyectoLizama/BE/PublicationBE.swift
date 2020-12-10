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
    var pu_idPublicacion : String
    var pu_idUsuario :String
    
    init(descripcion: String, fecha: String,  foto: String, idPublicacion: String, idUsuario: String) {
        self.pu_descripcion      = descripcion
        self.pu_fecha           = fecha
        self.pu_foto            = foto
        self.pu_idPublicacion    = idPublicacion
        self.pu_idUsuario = idUsuario
    }
    
}

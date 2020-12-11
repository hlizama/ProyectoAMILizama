//
//  ProfileBE.swift
//  ProyectoLizama
//
//  Created by user178641 on 12/9/20.
//

import Foundation

class ProfileBE {
    
    var nombre      : String
    var apellido  : String
    var carrera   : String
    var sede : String
    var idUsuario : String
    
    init(nombre: String, apellido: String, carrera: String, sede: String, idUsuario: String) {
        self.nombre      = nombre
        self.apellido    = apellido
        self.carrera     = carrera
        self.sede       = sede
        self.idUsuario = idUsuario
    }
    
}


//
//  Item.swift
//  ListaCompra
//
//  Created by Otto Colomina Pardo on 21/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import Foundation


enum Prioridad : Int  {
    case urgente = 0
    case necesario
    case accesorio
    
    var titulo : String {
        switch self {
        case .urgente: return "Urgente"
        case .necesario: return "Necesario"
        case .accesorio: return "Accesorio"

        }
    }
}

struct Item {
    var nombre : String
    var prioridad : Prioridad
}

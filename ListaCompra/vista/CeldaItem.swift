//
//  CeldaItem.swift
//  ListaCompra
//
//  Created by Otto Colomina Pardo on 25/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import Foundation
import UIKit

class CeldaItem : UITableViewCell {
    static let nombre = "MiCelda"
    
    var nombre : String? {
        didSet {
            self.textLabel?.text = self.nombre
        }
    }
    
    var comprado : Bool? {
        didSet {
            self.accessoryType = self.comprado! ? .checkmark : .none
        }
    }
}

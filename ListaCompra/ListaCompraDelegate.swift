//
//  ListaCompraDelegate.swift
//  ListaCompra
//
//  Created by Otto Colomina Pardo on 13/1/23.
//  Copyright © 2023 Universidad de Alicante. All rights reserved.
//

import Foundation
import UIKit

class ListaCompraDelegate : NSObject, UITableViewDelegate{
    var lista : ListaCompraProtocol!
    
    func setLista(_ lista : ListaCompra) {
        self.lista = lista
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let celda = tableView.cellForRow(at: indexPath),
           let prioridad = Prioridad(rawValue:indexPath.section) {
            if let estado = lista.switchItemStatus(pos: indexPath.row, prioridad: prioridad) {
                celda.accessoryType = estado ? .checkmark : .none
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

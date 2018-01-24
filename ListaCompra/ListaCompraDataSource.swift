//
//  ListaCompraDataSource.swift
//  ListaCompra
//
//  Created by Otto Colomina Pardo on 25/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import Foundation
import UIKit

class ListaCompraDataSource : NSObject, UITableViewDataSource {
    var lista : ListaCompra!
    
    func setLista(_ lista : ListaCompra) {
        self.lista = lista
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let prioridad = Prioridad(rawValue: section) {
            return lista.contarItems(prioridad: prioridad)
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "MiCelda", for: indexPath)
        if let prioridad = Prioridad(rawValue: indexPath.section),
            let item = lista.getItem(pos: indexPath.row, prioridad: prioridad) {
            celda.textLabel?.text = item.nombre
            if item.comprado {
                celda.accessoryType = .checkmark
            }
            else {
                celda.accessoryType = .none
            }
        }
        return celda
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let prioridad = Prioridad(rawValue:indexPath.section) {
                self.lista.deleteItem(pos: indexPath.row, prioridad: prioridad)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Prioridad(rawValue:section)?.titulo
    }
}
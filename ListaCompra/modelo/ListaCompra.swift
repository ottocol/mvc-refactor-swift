//
//  ListaCompra.swift
//  ListaCompra
//
//  Created by Otto Colomina Pardo on 24/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import Foundation


class ListaCompra : ListaCompraProtocol, Codable  {
    var listaItems : [[Item]] = [[],[],[]]
    
    func addItem(_ item: Item) {
        listaItems[item.prioridad.rawValue].append(item)
    }
    
    func deleteItem(pos: Int, prioridad: Prioridad) {
        if pos<contarItems(prioridad:prioridad) {
            listaItems[prioridad.rawValue].remove(at: pos)
        }
    }
    
    func contarItems(prioridad:Prioridad) -> Int {
        return listaItems[prioridad.rawValue].count
    }
    
    func getItem(pos: Int, prioridad: Prioridad) -> Item? {
        if pos<contarItems(prioridad:prioridad) {
           return listaItems[prioridad.rawValue][pos]
        }
        else {
           return nil
        }
    }
    
    func switchItemStatus(pos: Int, prioridad: Prioridad) -> Bool? {
        if pos<contarItems(prioridad:prioridad) {
            listaItems[prioridad.rawValue][pos].comprado = !listaItems[prioridad.rawValue][pos].comprado
            return listaItems[prioridad.rawValue][pos].comprado
        }
        else {
            return nil
        }
    }
}

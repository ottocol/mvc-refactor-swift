//
//  ListaCompraProtocol.swift
//  ListaCompra
//
//  Created by Otto Colomina Pardo on 24/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import Foundation

protocol ListaCompraProtocol {
    func addItem(_ item: Item)
    func deleteItem(pos: Int, prioridad: Prioridad)
    func contarItems(prioridad:Prioridad) -> Int
    func getItem(pos: Int, prioridad: Prioridad) -> Item?
    func switchItemStatus(pos: Int, prioridad: Prioridad) -> Bool?
}

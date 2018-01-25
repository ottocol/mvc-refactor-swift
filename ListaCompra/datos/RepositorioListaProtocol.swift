//
//  RepositorioListaProtocol.swift
//  ListaCompra
//
//  Created by Otto Colomina Pardo on 24/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import Foundation


protocol RepositorioListaProtocol {
    func leerLista() -> ListaCompra
    func guardarLista(_ lista : ListaCompra)
}

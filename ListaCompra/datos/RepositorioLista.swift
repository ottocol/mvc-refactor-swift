//
//  RepositorioLista.swift
//  ListaCompra
//
//  Created by Otto Colomina Pardo on 24/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import Foundation


class RepositorioLista : RepositorioListaProtocol {
    var nombre_fichero = "lista_compra.plist"
    
    func leerLista() -> ListaCompra {
        let urlDocs = FileManager.default.urls(for:.documentDirectory,
                                               in:.userDomainMask)[0]
        let urlArchivo = urlDocs.appendingPathComponent(nombre_fichero)
        if let data = try? Data(contentsOf: urlArchivo) {
            let decoder = PropertyListDecoder()
            let lista = try! decoder.decode(ListaCompra.self, from: data)
            return lista
        }
        else {
            return ListaCompra()
        }
    }
    
    func guardarLista(_ lista : ListaCompra) {
        let urlDocs = FileManager.default.urls(for:.documentDirectory,
                                               in:.userDomainMask)[0]
        let urlArchivo = urlDocs.appendingPathComponent(nombre_fichero)
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        do {
            let data = try encoder.encode(lista)
            try data.write(to: urlArchivo)
        } catch {
            print("Error grave: ¡¡No se ha podido guardar la lista!!")
        }
    }
}

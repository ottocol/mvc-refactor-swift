//
//  RepositorioListaTests.swift
//  ListaCompraTests
//
//  Created by Otto Colomina Pardo on 24/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import XCTest
@testable import ListaCompra

class RepositorioListaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRepositorioOK() {
        let lista = ListaCompra()
        lista.addItem(Item(nombre: "test", prioridad: .urgente, comprado: false))
        lista.addItem(Item(nombre: "test2", prioridad: .accesorio, comprado: true))
 
        let repo = RepositorioLista()
        repo.nombre_fichero = "test.plist"
        repo.guardarLista(lista)
        let listaLeida = repo.leerLista()
        XCTAssertEqual(listaLeida.contarItems(prioridad: .urgente),1)
        XCTAssertEqual(listaLeida.getItem(pos: 0, prioridad: .accesorio)?.nombre, "test2")
    }
    
    
    
}

//
//  ListaCompraTests.swift
//  ListaCompraTests
//
//  Created by Otto Colomina Pardo on 24/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import XCTest
@testable import ListaCompra

class ListaCompraTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCrearListaOK() {
        let lista = ListaCompra()
        XCTAssertEqual(lista.contarItems(prioridad: .urgente),0)
        XCTAssertEqual(lista.contarItems(prioridad: .necesario),0)
        XCTAssertEqual(lista.contarItems(prioridad: .accesorio),0)
    }
    
    
    func testAddAndGetItem() {
        let lista = ListaCompra()
        lista.addItem(Item(nombre: "prueba", prioridad: .necesario, comprado: false))
        XCTAssertEqual(lista.contarItems(prioridad: .necesario), 1)
        let item = lista.getItem(pos: 0, prioridad: .necesario)
        XCTAssertEqual(item?.nombre,"prueba")
        
    }
    
    
    
}

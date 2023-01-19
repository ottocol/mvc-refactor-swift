//
//  ViewController.swift
//  ListaCompra
//
//  Created by Otto Colomina Pardo on 21/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import UIKit

class ListaViewController: UITableViewController {
    var lista = ListaCompra()
    var listaDataSource = ListaCompraDataSource()
    var listaDelegate = ListaCompraDelegate()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lista = RepositorioLista().leerLista()
        print("Lista leida...\(Date())")
        listaDataSource.setLista(lista)
        listaDelegate.setLista(lista)
        self.tableView.dataSource = listaDataSource
        self.tableView.delegate = listaDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
        if segue.identifier! == "guardar" {
            let vc = segue.source as! NuevoItemViewController
            if let nuevoItem = vc.nuevoItem {
               lista.addItem(nuevoItem)
               self.tableView?.reloadData()
            }
        }
    }
}


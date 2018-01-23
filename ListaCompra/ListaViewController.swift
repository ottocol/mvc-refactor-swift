//
//  ViewController.swift
//  ListaCompra
//
//  Created by Otto Colomina Pardo on 21/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import UIKit

class ListaViewController: UITableViewController {
    var listaItems : [Item] = []

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaItems.filter{$0.prioridad==Prioridad(rawValue:section)}.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "MiCelda", for: indexPath)
        let listaFiltrada = listaItems.filter{$0.prioridad==Prioridad(rawValue:indexPath.section)}
        celda.textLabel?.text = listaFiltrada[indexPath.row].nombre
        return celda
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.listaItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Prioridad(rawValue:section)?.titulo
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listaItems.append(Item(nombre: "pan", prioridad: .urgente))
        listaItems.append(Item(nombre: "langostinos", prioridad: .accesorio))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
        if segue.identifier! == "guardar" {
            let vc = segue.source as! NuevoItemViewController
            if let nuevoItem = vc.nuevoItem {
                listaItems.append(nuevoItem)
                self.tableView?.reloadData()
            }
        }
    }

}


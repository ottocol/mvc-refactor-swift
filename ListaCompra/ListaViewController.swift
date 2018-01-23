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
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let celda = tableView.cellForRow(at: indexPath) {
            let pos = indexPath.row
            listaItems[pos].comprado = !listaItems[pos].comprado
            if listaItems[pos].comprado {
                celda.accessoryType = .checkmark
            }
            else {
                celda.accessoryType = .none
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
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
        self.listaItems = leerLista()
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
    
    func leerLista() -> [Item] {
        let urlDocs = FileManager.default.urls(for:.documentDirectory,
                                               in:.userDomainMask)[0]
        let urlArchivo = urlDocs.appendingPathComponent("items.plist")
        if let data = try? Data(contentsOf: urlArchivo) {
            let decoder = PropertyListDecoder()
            let lista = try! decoder.decode([Item].self, from: data)
            return lista
        }
        else {
            let lista : [Item] = []
            return lista
        }
    }
}


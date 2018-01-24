//
//  ViewController.swift
//  ListaCompra
//
//  Created by Otto Colomina Pardo on 21/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import UIKit

class ListaViewController: UITableViewController {
    var listaItems : [[Item]] = [[],[],[]]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaItems[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "MiCelda", for: indexPath)
        let seccion = listaItems[indexPath.section]
        let item = seccion[indexPath.row]
        celda.textLabel?.text = item.nombre
        if item.comprado {
            celda.accessoryType = .checkmark
        }
        else {
            celda.accessoryType = .none
        }
        return celda
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.listaItems[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let celda = tableView.cellForRow(at: indexPath) {
            listaItems[indexPath.section][indexPath.row].comprado = !listaItems[indexPath.section][indexPath.row].comprado
            if listaItems[indexPath.section][indexPath.row].comprado {
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
        print("Lista leida...\(Date())")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
        if segue.identifier! == "guardar" {
            let vc = segue.source as! NuevoItemViewController
            if let nuevoItem = vc.nuevoItem {
                listaItems[nuevoItem.prioridad.rawValue].append(nuevoItem)
                self.tableView?.reloadData()
            }
        }
    }
    
    func leerLista() -> [[Item]] {
        let urlDocs = FileManager.default.urls(for:.documentDirectory,
                                               in:.userDomainMask)[0]
        let urlArchivo = urlDocs.appendingPathComponent("items.plist")
        if let data = try? Data(contentsOf: urlArchivo) {
            let decoder = PropertyListDecoder()
            let lista = try! decoder.decode([[Item]].self, from: data)
            return lista
        }
        else {
            let lista : [[Item]] = [[],[],[]]
            return lista
        }
    }
}


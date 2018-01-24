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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let prioridad = Prioridad(rawValue: section) {
           return lista.contarItems(prioridad: prioridad)
        }
        else {
           return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "MiCelda", for: indexPath)
        if let prioridad = Prioridad(rawValue: indexPath.section),
            let item = lista.getItem(pos: indexPath.row, prioridad: prioridad) {
            celda.textLabel?.text = item.nombre
            if item.comprado {
                celda.accessoryType = .checkmark
            }
            else {
                celda.accessoryType = .none
            }
        }
        return celda
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let prioridad = Prioridad(rawValue:indexPath.section) {
               self.lista.deleteItem(pos: indexPath.row, prioridad: prioridad)
               tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let celda = tableView.cellForRow(at: indexPath),
           let prioridad = Prioridad(rawValue:indexPath.section) {
            if let estado = lista.switchItemStatus(pos: indexPath.row, prioridad: prioridad) {
                celda.accessoryType = estado ? .checkmark : .none
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
        lista = leerLista()
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
               lista.addItem(nuevoItem)
               self.tableView?.reloadData()
            }
        }
    }
    
    func leerLista() -> ListaCompra {
        let urlDocs = FileManager.default.urls(for:.documentDirectory,
                                               in:.userDomainMask)[0]
        let urlArchivo = urlDocs.appendingPathComponent("lista_compra.plist")
        if let data = try? Data(contentsOf: urlArchivo) {
            let decoder = PropertyListDecoder()
            let lista = try! decoder.decode(ListaCompra.self, from: data)
            return lista
        }
        else {
            return ListaCompra()
        }
    }
}


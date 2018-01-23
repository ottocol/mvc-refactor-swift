//
//  NuevoItemViewController.swift
//  ListaCompra
//
//  Created by Otto Colomina Pardo on 21/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import UIKit

class NuevoItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var nuevoItem : Item?
    
    @IBOutlet weak var textoNombre: UITextField!
    @IBOutlet weak var prioridadPicker: UIPickerView!
    
    @IBAction func tapGuardar(_ sender: Any) {
        
     }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier=="guardar" {
            let nombre = self.textoNombre.text!
            let pickerRow = self.prioridadPicker.selectedRow(inComponent: 0)
            let prioridad = Prioridad(rawValue:pickerRow)!
            nuevoItem = Item(nombre: nombre, prioridad: prioridad, comprado: false)
        }
        return true
    }
    
    let opciones = [Prioridad.urgente.titulo,
                    Prioridad.necesario.titulo,
                    Prioridad.accesorio.titulo]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return opciones.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.opciones[row]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prioridadPicker.dataSource = self
        self.prioridadPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

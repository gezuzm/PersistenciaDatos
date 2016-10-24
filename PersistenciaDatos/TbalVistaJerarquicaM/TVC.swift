//
//  TVC.swift
//  TbalVistaJerarquicaM
//
//  Created by jesus serrano on 09/10/16.
//  Copyright © 2016 gezuzm. All rights reserved.
//

import UIKit
import CoreData

class TVC: UITableViewController {

    
    private var libros : Array<Array<String>> = Array<Array<String>>()
    let tituloSeccion = ["Listado de Libros"]
    var hayDatos : Bool?
    var datos_finales : Array<String> = Array<String>()
    //PD
    var contexto : NSManagedObjectContext? = nil
    
    
    //PD
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.libros.removeAll()
        
        //////////////////////////////////////////////////////////
        // BUSCA LOS DATOS DE LA BD
        //PD
        let libroEntidad = NSEntityDescription.entityForName("Libro", inManagedObjectContext: self.contexto!)
        //PD
        let peticion = libroEntidad?.managedObjectModel.fetchRequestTemplateForName("petLibros")
        
        //PD
        do{
            // ejecutar la peticion
            let libroEntidad2 = try self.contexto?.executeFetchRequest(peticion!)
            
            // si arroja un valor, es que ya se habia hecho la consulta
            if libroEntidad2?.count > 0
            {
                for libroEntidad3 in libroEntidad2!
                {
                    var libro : [String] = []
                    libro.append(libroEntidad3.valueForKey("titulo") as! String)
                    libro.append(libroEntidad3.valueForKey("isbn") as! String)
                    self.libros.append(libro)
                }
            }
        }
        catch{
        }
        
          self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Busquedas en OpenLibrary.org"
        
        //mostrar el UIBUTtonBAR
        self.navigationController?.toolbarHidden = false;

        //PD
        self.contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    // evento activado al regresar de otra pantalla
    @IBAction func fromViewControllerISBN(segue : UIStoryboardSegue!)
    {
       /* if self.hayDatos == true //!= "0"
        {
            self.libros =  InsertaLibro(datos_finales)
        }
 
        self.tableView.reloadData() */
    }
   
    
    /*
    func InsertaLibro(datos_finales : Array<String>) -> Array<Array<String>>
    {
       /var encontro : Bool = false
        
        for dato : [String] in self.libros
        {
            if dato[0] == datos_finales[0]
            {
                encontro = true
            }
        }
        
        if encontro == false
        {
            self.libros.append(datos_finales)
        }
 
        return self.libros
    }*/
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // numero de secciones de la tabla
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
         return self.tituloSeccion.count
    }
  
    // inserta el numero de secciones
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        if section < tituloSeccion.count {
            return tituloSeccion[section]
        }
        
        return nil
    }

    // numero de libros actualmente guardados en el listado
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
          return self.libros.count
    }

    // muestra los datos en el listado de busqueda
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Celda", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = self.libros[indexPath.row][0]
        
        return cell
    }
 
    
    // Antes de cambiar de vista, si se tiene seleccionado alguno del listado de busqueda
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let sigVista = segue.destinationViewController as! ViewControllerINBS
        
        let indiceListado = self.tableView.indexPathForSelectedRow
        
        if indiceListado != nil
        {
            // obtener uu ISBN
          //  sigVista.isbnSeleccionadoTabla = self.libros[indiceListado!.row][3]
             sigVista.isbnSeleccionadoTabla = self.libros[indiceListado!.row][1]
        }
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}

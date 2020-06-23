//
//  HospitalTableViewController.swift
//  Project01
//
//  Created by kpugame on 2020/06/23.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import UIKit

class HospitalTableViewController: UITableViewController, XMLParserDelegate {

    @IBOutlet var tbData: UITableView!
    
    
    
    var url:String?
    
    var parser = XMLParser()
      var posts = NSMutableArray()
      var elements = NSMutableDictionary()
      var element = NSString()
      var yadmNm = NSMutableString()
      var telno = NSMutableString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    override func tableView(_ tableView : UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
       
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           
           cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "yadmNm") as! NSString as String
           cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "telno") as! NSString as String
           
           return cell
       }

       
       
       

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
      func beginParsing(){
          posts = []
          parser = XMLParser(contentsOf: (URL(string:url!))!)!
          parser.delegate = self
          parser.parse()
          tbData!.reloadData()
      }
      
      func parser(_ parser: XMLParser, foundCharacters string: String){
          if element.isEqual(to: "yadmNm"){
              yadmNm.append(string)
          }
          else if element.isEqual(to: "telno"){
              telno.append(string)
          }
        
      }
      
      func parser (_ parser: XMLParser, didStartElement elementName: String, namespaceURI : String?, qualifiedName qName : String?, attributes attributeDict: [String : String]){
          element = elementName as NSString
          if (elementName as NSString).isEqual(to: "item"){
              elements = NSMutableDictionary()
              elements = [:]
              yadmNm = NSMutableString()
              yadmNm = ""
              telno = NSMutableString()
              telno = ""
              
           
          }
      }
    
    func parser(_ parser: XMLParser, didEndElement elementName : String, namespaceURI: String?, qualifiedName qName : String?){
        if (elementName as NSString).isEqual(to: "item"){
            if !yadmNm.isEqual(nil){
                elements.setObject(yadmNm, forKey: "yadmNm" as NSCopying)
            }
            if !telno.isEqual(nil){
                elements.setObject(telno, forKey: "telno" as NSCopying)
            }
          
            posts.add(elements)
        }
        
    }

    
}





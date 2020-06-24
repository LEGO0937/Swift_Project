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
    
    var url : String?
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var yadmNm = NSMutableString()
    var telno = NSMutableString()
    
  
    
    var hospitalName = ""
    var hospitalName_utf8 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
    }
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView : UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "yadmNm") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "telno") as! NSString as String
        
        return cell
    }

    
    
    
}

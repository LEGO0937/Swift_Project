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
    var posts : [Hospital] = []
    var filteredPosts : [Hospital] = []
      var elements = NSMutableDictionary()
      var element = NSString()
      var yadmNm = NSMutableString()
      var telno = NSMutableString()
    var sidoNm = NSMutableString()
    var sgguNm = NSMutableString()
    var spclAdmTyCd = NSMutableString()
    
    var firstId : String = "서울"
    var secondId : String = "종로구"
    
    
    @IBOutlet var searchFooter: SearchFooter!
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All"]
        searchController.searchBar.delegate = self
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
        if isFiltering(){
            return filteredPosts.count
        }
        
        return posts.count
    }
    
    override func tableView(_ tableView : UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
       
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           let hospital : Hospital
        if isFiltering(){
        
            hospital = filteredPosts[indexPath.row]
        }else{
            hospital = posts[indexPath.row]
        }
        
        cell.textLabel?.text = hospital.yadmNm
        
        cell.detailTextLabel?.text = hospital.telno
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
        filteredPosts = []
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
          else if element.isEqual(to: "sidoNm"){
            sidoNm.append(string)
            
        }else if element.isEqual(to: "sgguNm"){
            sgguNm.append(string)
            
        }
        else if element.isEqual(to: "spclAdmTyCd"){
            spclAdmTyCd.append(string)
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
            sidoNm = NSMutableString()
            sidoNm = ""
            sgguNm = NSMutableString()
            sgguNm = ""
            spclAdmTyCd = NSMutableString()
            spclAdmTyCd = ""
           
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
            if !sidoNm.isEqual(nil){
                elements.setObject(sidoNm, forKey: "sidoNm" as NSCopying)
            }
            if !sgguNm.isEqual(nil){
                elements.setObject(sgguNm, forKey: "sgguNm" as NSCopying)
            }
            if !spclAdmTyCd.isEqual(nil){
                elements.setObject(spclAdmTyCd, forKey: "spclAdmTyCd" as NSCopying)
            }
            var titles : [Substring] = []
            var name : Substring = ""
            titles = String(sgguNm).split(separator: " ")

            name = titles[0]
            
            if firstId == sidoNm as String && secondId == name{
                var element = Hospital(yadmNm: elements.value(forKey: "yadmNm") as! String,telno: elements.value(forKey: "telno") as! String,
                                       sidoNm: elements.value(forKey: "sidoNm") as! String,sgguNm: elements.value(forKey: "sgguNm")as! String,
                                       spclAdmTyCd: elements.value(forKey: "spclAdmTyCd") as! String)
                
                    posts.append(element)
            }
            
        }
        
    }

    


    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
          filteredPosts = posts.filter({( hospital : Hospital) -> Bool in
            let doesCategoryMatch = (scope == "All") || (hospital.spclAdmTyCd == scope)
            
            if searchBarIsEmpty() {
              return doesCategoryMatch
            } else {
                return doesCategoryMatch && hospital.yadmNm.lowercased().contains(searchText.lowercased())
            }
          })
          tbData.reloadData()
        }
        
        func searchBarIsEmpty() -> Bool {
          return searchController.searchBar.text?.isEmpty ?? true
        }
        
        func isFiltering() -> Bool {
          let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
          return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
        }
        
    }

    extension HospitalTableViewController: UISearchBarDelegate {
      // MARK: - UISearchBar Delegate
      func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
      }
    }

    extension HospitalTableViewController: UISearchResultsUpdating {
      // MARK: - UISearchResultsUpdating Delegate
      func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
      }
    }




//
//  MaskTablesViewController.swift
//  Project01
//
//  Created by KPUGAME on 5/26/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import UIKit

class MaskTablesViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var StoresTableView: UITableView!
    @IBOutlet weak var StoreDetailTableView: UITableView!
    
    @IBOutlet var searchFooter: SearchFooter!
    let searchController = UISearchController(searchResultsController: nil)
    
    var name : String = ""
    var MaskStores : [MaskStore] = []
    
    var filteredMaskStores = [MaskStore]()
    var storeName : String = ""
    var storeAddr : String = ""
    
    var currentX : CGFloat = 0
    var currentY : CGFloat = 0
    
    func loadInitialData(addr: String){
          // guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
            //   else{return}
           
           for i in 1...5{
           var fileN = "https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/stores/json?page="
               fileN = fileN + String(i) + "&perPage=5000"
           guard let url = URL(string: fileN) else {return}
           
           
           let optionalData = try? Data(contentsOf: url)
          
           guard
               let data = optionalData,
               let json = try? JSONSerialization.jsonObject(with: data),
               let dictionary = json as? [String: Any],
               let works = dictionary["storeInfos"] as? [Dictionary<String,Any>]
               //let dic2 =   dic as? [[Any]],
               //let works = dictionary["storeInfos"] as? [[Any]]
               else{return}
           //let t = works[0]
          // let t = works.compactMap{$0 as? [String : Any] }
            
           let validWorks = works.flatMap{ MaskStore(json: $0) }
           var stores : [MaskStore] = []
            stores.append(contentsOf: validWorks)
            var title : [Substring] = []
            var seperatedN : String = ""
            for i in 0..<stores.count{
                title = stores[i].title?.split(separator: " ") as! [Substring]
                seperatedN = String(title[0] + " " + title[1])
                if self.name == seperatedN{
                    MaskStores.append(stores[i])
                }
            }
            
           }
       }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData(addr: name)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "약국", "우체국", "마트"]
        searchController.searchBar.delegate = self
        
        
        StoresTableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
        if segue.identifier == "segueToMaskMapView"{
            if let navController = segue.destination as? UINavigationController{
              if let maskMapViewController = navController.topViewController as? MaskMapViewController{
                maskMapViewController.name = self.name//url + sgguCd
                maskMapViewController.storeName = self.storeName
              }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableView == StoreDetailTableView{
            return 1
        }
        else if tableView == StoresTableView{
            if isFiltering(){
                return filteredMaskStores.count
            }
            return MaskStores.count
        }
        return 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let touchPoint = touch.location(in: StoresTableView)
            currentX = touchPoint.x
            currentY = touchPoint.y
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == StoreDetailTableView{
            
        }
        else if tableView == StoresTableView{
            
            let store : MaskStore
            if isFiltering(){
                store = filteredMaskStores[indexPath.row]
            }else{
                store = MaskStores[indexPath.row]
            }
             
            // let tipAmt = possibleTips[tipPct]!.tipAmt
            
            storeName = store.name
            storeAddr = store.title ?? ""
            
            StoreDetailTableView.reloadData()
            
            let explore2 = ExplodeView(frame: CGRect(x: currentX, y: currentY, width: 10, height: 10))
            StoresTableView.superview?.addSubview(explore2)
            StoresTableView.superview?.sendSubviewToBack(_: explore2)
        }
    }
 
    //테이블 뷰 셀의 내용은 title과 subtitle을 posts 배열 원소(dictionary)에서 yadmNm과 addr에 해당하는 value로 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if tableView == StoreDetailTableView{
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2,reuseIdentifier: nil)
            
            //let store = MaskStores[indexPath.row]
             
            // let tipAmt = possibleTips[tipPct]!.tipAmt

            cell.textLabel!.text = storeName
            cell.detailTextLabel?.text = storeAddr
            return cell
        }
        else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let store : MaskStore
            
        if isFiltering(){
        
            store = filteredMaskStores[indexPath.row]
        }else{
            store = MaskStores[indexPath.row]
        }
        cell.textLabel?.text = store.name
        
        cell.detailTextLabel?.text = store.type
        // Configure the cell...
            return cell
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
      filteredMaskStores = MaskStores.filter({( store : MaskStore) -> Bool in
        let doesCategoryMatch = (scope == "All") || (store.type == scope)
        
        if searchBarIsEmpty() {
          return doesCategoryMatch
        } else {
          return doesCategoryMatch && store.name.lowercased().contains(searchText.lowercased())
        }
      })
      StoresTableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
      let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
      return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
}

extension MaskTablesViewController: UISearchBarDelegate {
  // MARK: - UISearchBar Delegate
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}

extension MaskTablesViewController: UISearchResultsUpdating {
  // MARK: - UISearchResultsUpdating Delegate
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}

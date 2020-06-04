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
    
    var name : String = ""
    var MaskStores : [MaskStore] = []
    
    var storeName : String = ""
    var storeAddr : String = ""
    
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
           MaskStores.append(contentsOf: validWorks)
           }
       }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData(addr: name)
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
            return MaskStores.count
        }
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == StoreDetailTableView{
        }
        else if tableView == StoresTableView{
            let store = MaskStores[indexPath.row]
             
            // let tipAmt = possibleTips[tipPct]!.tipAmt

            storeName = store.name
            storeAddr = store.title ?? ""
            
            StoreDetailTableView.reloadData()
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
        
        cell.textLabel?.text = MaskStores[indexPath.row].name
        
        cell.detailTextLabel?.text = MaskStores[indexPath.row].type
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

}

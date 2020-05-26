//
//  MaskTableViewController.swift
//  Project01
//
//  Created by KPUGAME on 5/25/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import UIKit

class MaskTableViewController: UITableViewController {
    var name : String = ""
    var MaskStores : [MaskStore] = []
    
    var storeName : String = ""
    var storeAddr : String = ""
    
    //전송받은 posts 배열에서 정보를 얻어서 Hospital 객체를 생성하고 배열에 추가 생성
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MaskStores.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let store = MaskStores[indexPath.row]
             
            // let tipAmt = possibleTips[tipPct]!.tipAmt

            storeName = store.name
            storeAddr = store.title ?? ""
        
    }
    //테이블 뷰 셀의 내용은 title과 subtitle을 posts 배열 원소(dictionary)에서 yadmNm과 addr에 해당하는 value로 설정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = MaskStores[indexPath.row].name
        
        cell.detailTextLabel?.text = MaskStores[indexPath.row].type
        // Configure the cell...
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

}

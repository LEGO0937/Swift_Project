//
//  MaskViewController.swift
//  Project01
//
//  Created by KPUGAME on 5/13/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import UIKit

class MaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var firstId : String = "서울특별시"
    
    
    @IBAction func doneToPickerViewController(segue: UIStoryboardSegue){
    
    }
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
          if segue.identifier == "segueToMask2View"{
              if let navController = segue.destination as? UINavigationController{
                  if let Mask2ViewController = navController.topViewController as? Mask2ViewController{
                      Mask2ViewController.firstId = firstId//url + sgguCd
                  }
              }
          }
      }
    
    @IBOutlet weak var firstName: UIPickerView!
    
    var pickerDataSource = ["서울특별시", "부산광역시","대구광역시","인천광역시", "광주광역시", "울산광역시", "경기도", "강원도",
    "충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주특별자치도"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstName.delegate = self;
        self.firstName.dataSource = self;
        // Do any additional setup after loading the view.
    }
    

    
     func numberOfComponents(in pickerView: UIPickerView) -> Int{
           return 1
       }
    // pickerView의 각 컴포넌트에 대한 row의 개수 = pickerDataSource 배열 원소 개수
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return pickerDataSource.count
       }
       //pickerView의 주어진 컴포넌트 /row에 대한 데이터 = pickerDataSource 배열의 원소
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return pickerDataSource[row]
       }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       firstId = pickerDataSource[row]
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

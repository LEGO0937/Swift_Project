import UIKit

class HospitalTableViewController: UITableViewController, XMLParserDelegate {

    @IBOutlet var tbData: UITableView!
    
    var url : String?
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var yadmNm = NSMutableString()
    var addr = NSMutableString()
    
    var XPos = NSMutableString()
    var YPos = NSMutableString()
    
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
        else if element.isEqual(to: "addr"){
            addr.append(string)
        }
        else if element.isEqual(to: "XPos"){
            XPos.append(string)
        }
        else if element.isEqual(to: "YPos"){
            YPos.append(string)
        }
    }
    
    func parser (_ parser: XMLParser, didStartElement elementName: String, namespaceURI : String?, qualifiedName qName : String?, attributes attributeDict: [String : String]){
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            elements = NSMutableDictionary()
            elements = [:]
            yadmNm = NSMutableString()
            yadmNm = ""
            addr = NSMutableString()
            addr = ""
            
            XPos = NSMutableString()
            YPos = NSMutableString()
            XPos = ""
            YPos = ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName : String, namespaceURI: String?, qualifiedName qName : String?){
        if (elementName as NSString).isEqual(to: "item"){
            if !yadmNm.isEqual(nil){
                elements.setObject(yadmNm, forKey: "yadmNm" as NSCopying)
            }
            if !addr.isEqual(nil){
                elements.setObject(addr, forKey: "addr" as NSCopying)
            }
            if !XPos.isEqual(nil){
                elements.setObject(XPos, forKey: "XPos" as NSCopying)
            }
            if !YPos.isEqual(nil){
                elements.setObject(YPos, forKey: "YPos" as NSCopying)
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
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr") as! NSString as String
        
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToMapView"{
            if let mapViewController = segue.destination as? MapViewController{
                mapViewController.posts = posts
            }
        }
        else if segue.identifier == "segueToDetailView"{
            if let cell = sender as? UITableViewCell{
                let indexPath = tableView.indexPath(for: cell)
                hospitalName = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "yadmNm") as! NSString as String
                hospitalName_utf8 = hospitalName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                
                if let dhtvController = segue.destination as? DetailHospitalViewController{
                    dhtvController.url = url! + "&yadmNm=" + hospitalName_utf8
                }
            }
        }
    }
    
}

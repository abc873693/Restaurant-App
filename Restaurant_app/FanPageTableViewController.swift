//
//  FanPageTableViewController.swift
//  Restaurant_app
//
//  Created by Ray on 2016/12/30.
//  Copyright © 2016年 kuas. All rights reserved.
//

import UIKit

class FanPageTableViewController: UITableViewController, URLSessionDelegate {
    var app_id = "139382513220064"
    var client_secret = "fef961682208c96dade5bdfb8124332e"
    var page_id = "656114697817019"
    var access_token = ""
    var posts = [(Post)]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAccessToken()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    func getAccessToken() -> Void {
        let targetURL = URL(string:"https://graph.facebook.com/v2.6/oauth/access_token?client_id=" + app_id + "&client_secret="
            + client_secret + "&grant_type=client_credentials")
        let sessionWithConfigure = URLSessionConfiguration.default
        
        //設定委任對象為自己
        let session = Foundation.URLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: OperationQueue.main)
        
        //設定下載網址
        let dataTask = session.dataTask(with: targetURL!, completionHandler: {(data, response, error) -> Void in
            if error == nil{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    print("JSON : " , String(describing: json))
                    if let dictionary = json as? [String: AnyObject]{
                        self.access_token = (dictionary["access_token"]as! String?)!
                        let token_type = dictionary["token_type"]as! String?
                        print("JSON : ",self.access_token+" \n", token_type!)
                        self.getPosts()
                    }
                }catch let JsonError{
                    print(JsonError)
                }
            }
        })
        //啟動或重新啟動下載動作
        dataTask.resume()
    }
    
    func getPosts() -> Void {
        print("start getPosts!")
        let str = "https://graph.facebook.com/v2.6/" + page_id + "/posts?fields=full_picture,shares,permalink_url,story,created_time,message,likes.limit(0).summary(true),source,attachments{subattachments},type&locale=zh_TW&limit=25&offset=0&show_expired=true&access_token=" + self.access_token as String
        let str2 = str.addingPercentEscapes(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        //print(str2)
        if let url = URL(string:str2!){
            //print("\(url)")
            let sessionWithConfigure = URLSessionConfiguration.default
            
            //設定委任對象為自己
            let session = Foundation.URLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: OperationQueue.main)
            
            //設定下載網址
            let dataTask = session.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
                if error == nil{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                        //print("JSON : " , String(describing: json))
                        if let dictionary = json as? [String: AnyObject]{
                            for post in dictionary["data"] as! [[String: AnyObject]]{
                                let model = Post()
                                model.id = post["id"] as? String ?? ""
                                model.date = post["created_time"]as? String ?? ""
                                model.type = post["type"]as? String ?? ""
                                model.image_picture_URL = post["full_picture"]as? String ?? ""
                                model.link_URL = post["permalink_url"]as? String ?? ""
                                model.content = post["message"] as? String ?? ""
                                if let shares = post["shares"] as? [String: AnyObject]{
                                    model.shares = String(shares["count"] as? Int ?? 0)
                                }else{ model.shares = "0" }
                                if let likes = post["likes"] as? [String: AnyObject]{
                                    if let summary = likes["summary"] as? [String: AnyObject]{
                                        model.likes = String(summary["total_count"] as? Int ?? 0)
                                    }
                                    //else{ model.likes = "0" }
                                }//else{ model.likes = "0" }
                                self.posts.append(model)
                                //print("Post :\(model)")
                            }
                            print("Post count = \(self.posts.count)")
                            self.tableView.reloadData()
                        }
                    }catch let JsonError{
                        print(JsonError)
                    }
                }
            })
            //啟動或重新啟動下載動作
            dataTask.resume()
        }
        else{
            print("transfer Fail!")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let knownHeight : CGFloat=350
        if(posts[indexPath.row].content != ""){
            if let statusText = posts[indexPath.row].content{
                let rect  = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width-40, height:10000) , options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                return CGFloat(rect.height+knownHeight+30)
            }
        }
        return CGFloat(knownHeight)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "post_cell", for: indexPath)as! PostTableViewCell
        let index = indexPath.row
        
        cell.text_message?.text = posts[index].content
        if cell.text_message?.text == "" {
            cell.text_message.frame = CGRect(x: 0, y: 0, width: cell.text_message.frame.width, height: 0)
            cell.image_main.frame.origin.y = 78
            cell.text_likes.frame.origin.y = 320
            cell.text_shares.frame.origin.y = 320
            cell.image_like.frame.origin.y = 320
            cell.text_message.sizeToFit()
        }else{
            cell.text_message.frame = CGRect(x: 8, y: 74, width: 359, height: 48)
            cell.image_main.frame.origin.y = 130
            cell.text_likes.frame.origin.y = 368
            cell.text_shares.frame.origin.y = 368
            cell.image_like.frame.origin.y = 368
        }
        cell.text_time?.text = convertDateFormater(date:posts[index].date!)
        cell.text_likes?.text = posts[index].likes! + " 喜歡"
        cell.text_shares?.text = posts[index].shares! + " 分享"
        if posts[index].image_picture_URL != "" {
            let url = posts[index].image_picture_URL
            let sessionWithConfigure = URLSessionConfiguration.default
            let session = Foundation.URLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: OperationQueue.main)
            
            //let dataTask = session.downloadTask(with: URL(string: url!)!)
            
            let dataTask = session.downloadTask(with: URL(string: url!)!, completionHandler: {(data, response, error) -> Void in
                guard let imageData = try? Data(contentsOf: data!) else {
                    return
                }
                let image = UIImage(data: imageData)
                if image != nil{
                    cell.image_main.image = image
                    
                }
            })
            
            dataTask.resume()
            
        }
        
        return cell
    }

    func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+0000"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        
        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

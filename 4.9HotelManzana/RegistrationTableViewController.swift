//
//  RegistrationTableViewController.swift
//  4.9HotelManzana
//
//  Created by Sophie Kim on 2020/09/29.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
    var registrations : [Registration] = []
}

extension RegistrationTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }
    
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue) {
        let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController
        if let registration =  addRegistrationTableViewController?.registration {
            registrations.append(registration)
            tableView.reloadData()
        }
    }
    

    @IBAction func unwind(unwindSegue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SeeDetail" {
            let indexPath = tableView.indexPathForSelectedRow!
            let addRegistrationTableViewController = segue.destination as! AddRegistrationTableViewController
            let registration = registrations[indexPath.row]
            addRegistrationTableViewController.registration = registration
        }
    }
}

extension RegistrationTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)
        
        let registration = registrations[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
      //  cell.textLabel?.text = [registration.firstName, registration.lastName].compactMap { $0 }.joined(separator: " ")
     //   let checkInCheckOutDate = [dateFormatter.string(from: registration.checkInDate), dateFormatter.string(from: registration.checkOutDate)].compactMap { $0 }.joined(separator: " - ")
      //  let roomTypeName = registration.roomType?.name
      //  let checkInCheckOutDateAndRoomType = [checkInCheckOutDate, roomTypeName].compactMap { $0 }.joined(separator: " : ")
      // cell.detailTextLabel?.text = checkInCheckOutDateAndRoomType
      
        cell.textLabel?.text = registration.firstName + " " + registration.lastName
        cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkInDate) + " - " + dateFormatter.string(from: registration.checkOutDate) + " : " + registration.roomType!.name
        return cell
    }
}

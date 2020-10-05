//
//  AddRegistrationTableViewController.swift
//  4.9HotelManzana
//
//  Created by Sophie Kim on 2020/09/25.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }
    
    let arrayToCountRows: [[String]] = [
    ["First Name","Last Name","Email"],
    ["CheckInDate", "CheckInDatePicker", "CheckOutDate", "checkOutDatePicker"],
    ["numberOfAdults", "numberOfChildren"],
    ["Wi-Fi"],
    ["Room Type"]
]
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }

    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet var wifiSwitch: UISwitch!
    
    @IBOutlet var roomTypeLabel: UILabel!
    
    var roomType: RoomType?
    
    var registration = Registration() {
        didSet {
            print("registration: \(registration)")
        }
    }
}

extension AddRegistrationTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        firstNameTextField.text = registration.firstName
        lastNameTextField.text = registration.lastName
        emailTextField.text = registration.lastName
        checkInDateLabel.text = dateFormatter.string(from: registration.checkInDate)
        checkOutDateLabel.text = dateFormatter.string(from: registration.checkOutDate)
        numberOfAdultsLabel.text = "\(Int(registration.numberOfAdults))"
        numberOfChildrenLabel.text = "\(Int(registration.numberOfChildren))"
        wifiSwitch.isOn = registration.wifi
        
        if registration.roomType != nil {
            roomTypeLabel.text = registration.roomType!.name
        } else {
            updateRoomType()
        }
        configureDatePicker()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationViewController = segue.destination as? SelectRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
    }
}


extension AddRegistrationTableViewController {
    @IBAction func didChangeFirstNameTextField(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
        registration.firstName = text
    }
    
    @IBAction func didChangeLastNameTextField(_ sender: UITextField) {
        guard let text = sender.text else { return }

        registration.lastName = text
    }
    
    @IBAction func didChangeEmailTextField(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
        registration.emailAddress = text
    }
    
    @IBAction func checkInDatePickerValueChanged(_ sender: UIDatePicker) {
        registration.checkInDate = sender.date
        checkInDateLabel.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func checkOutDatePickerValueChanged(_ sender: UIDatePicker) {
        registration.checkOutDate = sender.date
        checkOutDateLabel.text = dateFormatter.string(from: sender.date)
    }

    @IBAction func numberOfAdultsStepperValueChanged(_ sender: UIStepper) {
        registration.numberOfAdults = Int(sender.value)
        numberOfAdultsLabel.text = "\(registration.numberOfAdults)"
    }
    
    @IBAction func numberOfChildrenStepperValueChanged(_ sender: UIStepper) {
        registration.numberOfChildren = Int(sender.value)
        numberOfChildrenLabel.text = "\(registration.numberOfChildren)"
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        registration.wifi = sender.isOn
        wifiSwitch.isOn = registration.wifi
    }
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}

    

extension AddRegistrationTableViewController {
    
    func updateRoomType() {
        if let roomType = roomType {
            registration.roomType = roomType
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }
    
    private func configureDatePicker() {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
    }

    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
}

extension AddRegistrationTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayToCountRows[section].count
    }
}

extension AddRegistrationTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case checkInDateLabelCellIndexPath:
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case checkOutDateLabelCellIndexPath:
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShown {
                return 216.0
            }  else {
                return 0.0
            }
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        default:
            return 44.0
        }
    }
}

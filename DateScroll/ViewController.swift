//
//  ViewController.swift
//  DateScroll
//
//  Created by Vincent O'Sullivan on 22/08/2018.
//  Copyright © 2018 Vincent O'Sullivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

      private let rowOffset = 200
      private let monthFormatter = DateFormatter()
      private let dayFormatter = DateFormatter()

      @IBOutlet weak var calendarTable: UITableView!

      override func viewDidLoad() {
            super.viewDidLoad()

            monthFormatter.dateFormat = "MMMM"
            dayFormatter.dateFormat = "d"

            calendarTable.delegate = self
            calendarTable.dataSource = self

            let indexPath = IndexPath(row: rowOffset, section: 0)
            calendarTable.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: false)
      }

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1000
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let dateCell = calendarTable.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateCell
            let date = dateForRow(indexPath.row)
            dateCell.month.text = date.month
            dateCell.dayOfMonth.text = date.day
            return dateCell
      }


      /// Returns a tuple containg the date components for the given row.
      /// Row #rowOffset corresponds to today's date.  Each row above is a day earlier and each row below is a day later.
      ///
      private func dateForRow(_ row: Int) -> (month: String, day: String) {
            // Row #rowOffset contains today's date.
            let rowDate = Date().addingTimeInterval(TimeInterval((row - rowOffset) * 86400)) + Double(row)

            return (month: monthFormatter.string(from: rowDate), day: dayFormatter.string(from: rowDate))
      }
}


//
//  ViewController.swift
//  DateScroll
//
//  Created by Vincent O'Sullivan on 22/08/2018.
//  Copyright © 2018 Vincent O'Sullivan. All rights reserved.
//

import UIKit

fileprivate let todayRow = 365
fileprivate let todayIndexPath = IndexPath(row: todayRow, section: 0)

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let rowCount  = 4018
    private let monthFormatter = DateFormatter()
    private let dayFormatter = DateFormatter()
    
    @IBOutlet weak var calendarTable: UITableView!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var todayButtonTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthFormatter.dateFormat = "MMMM"
        dayFormatter.dateFormat = "d"
        
        calendarTable.delegate = self
        calendarTable.dataSource = self
        
        calendarTable.scrollToRow(at: todayIndexPath, at: UITableView.ScrollPosition.top, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateCell = calendarTable.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateCell
        let date = dateForRow(indexPath.row)
        dateCell.month.text = date.month
        dateCell.dayOfMonth.text = date.day
        dateCell.backgroundColor = indexPath.row % 2 == 0 ? .green : .yellow
        return dateCell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let visiblePaths = calendarTable.indexPathsForVisibleRows else { return }
        
        if visiblePaths.contains(todayIndexPath) {
            todayButton.isHidden = true
        } else {
            print(visiblePaths[0][1])
            setTodayButtonPosition(row: visiblePaths[0][1])
            todayButton.isHidden = false
        }
    }
    
    private func setTodayButtonPosition(row: Int) {
        
        if row < todayRow {
            todayButtonTopConstraint.constant = todayButton.frame.height
            todayButton.setTitle("Up to today", for: .normal)
        } else {
            let height = view.safeAreaLayoutGuide.layoutFrame.size.height - 2 * todayButton.frame.height
            todayButtonTopConstraint.constant = height
            todayButton.setTitle("Down to today", for: .normal)
        }
        view.layoutIfNeeded()
    }
    
    @IBAction func scrollToToday() {
        calendarTable.scrollToRow(at: todayIndexPath, at: UITableView.ScrollPosition.top, animated: true)
    }
    
    /// Returns a tuple containg the date components for the given row.
    /// Row #rowOffset corresponds to today's date.  Each row above is a day earlier and each row below is a day later.
    ///
    private func dateForRow(_ row: Int) -> (month: String, day: String) {
        // Row #rowOffset contains today's date.
        let rowDate = Date().addingTimeInterval(TimeInterval((row - todayRow) * 86400)) + Double(row)
        
        return (month: monthFormatter.string(from: rowDate), day: dayFormatter.string(from: rowDate))
    }
}


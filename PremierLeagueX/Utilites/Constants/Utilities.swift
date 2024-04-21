//
//  Utilities.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 20/04/2024.
//

import Foundation
import UIKit

class Utilities {
  static func convertUTCtoHHMM(_ utcString: String?) -> String? {
    guard let utcString = utcString else { return nil }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatter.timeZone = TimeZone(identifier: Constants.UTC_TIMEZONE)

    if let date = dateFormatter.date(from: utcString) {
      dateFormatter.dateFormat = Constants.HM_DATE_FORMAT
      dateFormatter.timeZone = TimeZone(identifier: Constants.CAIRO_TIMEZONE)

      let hhmmString = dateFormatter.string(from: date)
      return hhmmString
    }
    return nil
  }
  static func convertUTCtoYYYYMMDD(_ utcString: String?) -> String? {
    guard let utcString = utcString else { return nil }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatter.timeZone = TimeZone(identifier: Constants.UTC_TIMEZONE)

    if let date = dateFormatter.date(from: utcString) {
      dateFormatter.dateFormat = Constants.YMD_DATE_FORMAT
      dateFormatter.timeZone = TimeZone(identifier: Constants.CAIRO_TIMEZONE)

      let ymdString = dateFormatter.string(from: date)
      return ymdString
    }
    return nil
  }

  static func getcurrentDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Constants.YMD_DATE_FORMAT
    dateFormatter.timeZone = TimeZone(identifier: Constants.CAIRO_TIMEZONE)

    let currentDateInCairo = Date()

    dateFormatter.timeZone = TimeZone(identifier: Constants.UTC_TIMEZONE)
    let currentDateInUTC = dateFormatter.string(from: currentDateInCairo)

    return currentDateInUTC
  }

  static func getNextYearDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Constants.YMD_DATE_FORMAT
    dateFormatter.timeZone = TimeZone(identifier: Constants.CAIRO_TIMEZONE)

        let currentDateInCairo = Date()

        if let oneYearLater = Calendar.current.date(byAdding: .year, value: 1, to: currentDateInCairo) {
          dateFormatter.timeZone = TimeZone(identifier: Constants.UTC_TIMEZONE)
            let currentDateInUTC = dateFormatter.string(from: oneYearLater)
            return currentDateInUTC
        } else {
            return "Date calculation error"
        }
  }

  static func makeCellBorderRadius(cell: UITableViewCell){
    cell.contentView.backgroundColor = .white
    cell.contentView.layer.borderWidth = 0.5
    cell.contentView.layer.borderColor = UIColor.systemGray2.cgColor
    cell.contentView.layer.cornerRadius = 16
  }


  static func displayDestructiveAlert(_ viewController: UIViewController, title: String, text: String, completion: @escaping () -> ()) {
    let redAlert = UIAlertController(title: title, message: text, preferredStyle: .alert)
    let mainAction = UIAlertAction(title: title, style: .destructive) {_ in
      completion()
    }
    let cancelAction = UIAlertAction(title: Constants.CANCEL, style: .cancel)
    redAlert.addAction(mainAction)
    redAlert.addAction(cancelAction)
    viewController.present(redAlert, animated: true)
  }
}

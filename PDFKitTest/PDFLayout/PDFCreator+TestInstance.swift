//
//  PDFCreator+TestData.swift
//  TravelCosts
//
//  Created by Bart van Kuik on 11/02/2021.
//

import Foundation

extension PDFLayout {
    static func makeTestInstance() -> PDFLayout {
        var pdfLayout = PDFLayout()
        var table = PDFLayout.Table(columns: 2)
        table.append(["Column 1", "Column 2"])
        table.append(["Column 1", "Column 2"])
        table.append(["Column 1", "Column 2"])
        table.append(["Column 1", "Column 2"])
        table.append(["Column 1", "Column 2"])
        pdfLayout.append(table)
        return pdfLayout
    }
}

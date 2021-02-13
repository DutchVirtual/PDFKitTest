//
//  ContentView.swift
//  PDFKitTest
//
//  Created by Bart van Kuik on 07/02/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PDFViewer(pdfLayout: PDFLayout.makeTestInstance())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  PDFViewer.swift
//  PDFKitTest
//
//  Created by Bart van Kuik on 07/02/2021.
//

import PDFKit
import SwiftUI

struct PDFViewer: UIViewRepresentable {
    let pdfLayout: PDFLayout
    
    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        view.autoScales = true
        let data = pdfLayout.data
        view.document = PDFDocument(data: data)
        return view
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: PDFViewer

        init(_ parent: PDFViewer) {
            self.parent = parent
        }
    }
}

struct PDFViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        PDFViewer(pdfLayout: PDFLayout())
    }
}

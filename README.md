# PDFKitTest

Example app that generates a PDF and then previews it. Interface
built with SwiftUI where possible.

# A couple of points

* There's no concept of pages, it's just a single page
* Page size is hardcoded in A4 format, the locale is not checked
* All content is text in a single font size
* Primitive layout is done, with a table that has columns

# Tips for further improvements

If you wish to generate multiple pages, you should return
true/false from the Table its render() function, indicating
whether it fit or not. Then in the PDFLayout its data property,
handle that return value in the loop.

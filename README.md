# TableView-DataSource-On-Server

License:
------------

* Code - free. I wrote and give permission to use anywhere
* Images - taken from Pixabay. They are free, but if you about to extend the use of the images for any commercial purposes or not sure what you can do with them, please visit Pixabay to make sure you comply to any licenses introduced there
* Json File - Same rule as fro Pixabay applies here : the service is free, but if you want to use it commercially or not sure about something please visit myjson.com for details

Disclaimer:
------------
All names in table are fictitious. No identification with actual persons (living or deceased), is intended or should be inferred.

Main classes:
------------

* ViewController class - Main VC. On first launch will issue a call in the background (In Global Q ,to allow UI responsivenss) for fetching the contents of the data source from server (it's a file residing on myjson.com which I prepared earlier - see property `remoteJsonUrl`).
I perform Newtworking via class `NetworkSession` that makes use of URLSession.
When the data source is fetched, it is parsed (class `ProductsParser`) from json to data structure that would fit the data source of the table (array of cells containing text and url of avatar).
Important to mind that all fetches are done asynchronously in the global Q and when that data is fetched and needed to be embedded in UI, only then we call main Q (and also aysnc - for a better UI response).
Also mind that we need another network call to fetch the thumbnail, since in first fetch we just brought its url in the json (If you start to posses lots of images, you might wanna consider some sort of cache for them - there are good frameworks for that in GitHub (e.g. KingFisher))

Screenshot added in project for general impression.

Enjoy:)

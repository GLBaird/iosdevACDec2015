

let requestURL = NSURL(string:"http://leonbaird.co.uk/iphone/process.php")!
let imageData = UIImageJPEGRepresentation(imagePreview.image, 1.0)!
let descriptionText = descriptionTextField.text // get from outlet to UITextField

let boundary = "----LeonBairdUploader1234567"
let seperator = "\r\n--\(boundary)\r\n".dataUsingEncoding(
    NSUTF8StringEncoding, allowLossyConversion:false)!

// make the body
var bodyData = NSMutableData()
bodyData.appendData(seperator)
bodyData.appendData("Content-Disposition: form-data; name=\"description\"".dataUsingEncoding(
    NSUTF8StringEncoding, allowLossyConversion:false)!)
bodyData.appendData(descriptionText.dataUsingEncoding(
    NSUTF8StringEncoding, allowLossyConversion:false)!)
bodyData.appendData(seperator)
bodyData.appendData("Content-Disposition: form-data; name=\"image[]\"; filename=\"uploaded_image.jpg\"\r\n".dataUsingEncoding(
    NSUTF8StringEncoding, allowLossyConversion:false)!)
bodyData.appendData("Content-Type: application/octet-stream\r\n\r\n".dataUsingEncoding(
    NSUTF8StringEncoding, allowLossyConversion:false)!)
bodyData.appendData(imageData)
bodyData.appendData("\r\n--\(boundary)--\r\n".dataUsingEncoding(
    NSUTF8StringEncoding, allowLossyConversion:false)!)
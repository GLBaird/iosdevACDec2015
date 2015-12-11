

NSString *deviceID = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceID"];
NSString *textContent = @"This is a new note";

// Build the request body
NSString *boundary = @"SportuondoFormBoundary";
NSMutableData *body = [NSMutableData data];
// Body part for "deviceId" parameter. This is a string.
[body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"deviceId"] dataUsingEncoding:NSUTF8StringEncoding]];
[body appendData:[[NSString stringWithFormat:@"%@\r\n", deviceID] dataUsingEncoding:NSUTF8StringEncoding]];
// Body part for "textContent" parameter. This is a string.
[body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"textContent"] dataUsingEncoding:NSUTF8StringEncoding]];
[body appendData:[[NSString stringWithFormat:@"%@\r\n", textContent] dataUsingEncoding:NSUTF8StringEncoding]];
// Body part for the attachament. This is an image.
NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"ranking"], 0.6);
if (imageData) {
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", @"image"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];
    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
}
[body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

// Setup the session
NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
sessionConfiguration.HTTPAdditionalHeaders = @{
                                               @"api-key"       : @"55e76dc4bbae25b066cb",
                                               @"Accept"        : @"application/json",
                                               @"Content-Type"  : [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary]
                                               };

// Create the session
// We can use the delegate to track upload progress
NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];

// Data uploading task. We could use NSURLSessionUploadTask instead of NSURLSessionDataTask if we needed to support uploads in the background
NSURL *url = [NSURL URLWithString:@"URL_TO_UPLOAD_TO"];
NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
request.HTTPMethod = @"POST";
request.HTTPBody = body;
NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    // Process the response
}];
[uploadTask resume];
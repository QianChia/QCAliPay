# AFNetworking

- 网络数据请求

- Version 3.1.0

- Github 网址：https://github.com/AFNetworking/AFNetworking

- AFNetworking 系统需求：

	  AFNetworking Version | Minimum iOS Target | Target Notes
	-----------------------|--------------------|--------------------------------------------------------------------------
	  3.x                  |       iOS 7        | Xcode 7+ is required. NSURLConnectionOperation support has been removed.
	  2.6 -> 2.6.3		   |       iOS 7        | Xcode 7+ is required.
	  2.0 -> 2.5.4		   |       iOS 6        | Xcode 5+ is required. NSURLSession subspec requires iOS 7 or OS X 10.9.
	  1.x                  |       iOS 5        |
	  0.10.x               |       iOS 4        |
        
- AFNetworking 使用 ARC 

# 1、添加 AFNetworking

- Objective-C
	
	```objc
	 	// 添加第三方库文件
	 	AFNetworking	
		
	 	// 包含头文件
	 	#import "AFNetworking.h"
	```

# 2、AFNetworking 的设置

- Objective-C

	- Manager 的创建
	
		```objc
	    	// AFHTTPSessionManager
	    
	        	AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
	
	        	NSURL *baseURL2 = [NSURL URLWithString:@"http://192.168.88.200"];
	        	AFHTTPSessionManager *manager2 = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL2];
	
	        	NSURL *baseURL3 = [NSURL URLWithString:@"http://192.168.88.200"];
	        	NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
	        	AFHTTPSessionManager *manager3 = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL3 sessionConfiguration:config];
	    
	    	// AFURLSessionManager
	    
	        	AFURLSessionManager *manager4 = [[AFURLSessionManager alloc] 
	        	                                  initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	    
	    		// 取消挂起的 task
	        	[[AFURLSessionManager alloc] invalidateSessionCancelingTasks:YES];                  
		```
	
	- URLRequest 的创建
	
		```objc
	    	NSURL *url1 = [NSURL URLWithString:@"http://192.168.88.200:8080/MJServer/video?type=JSON"];
	    	NSURL *url2 = [NSURL URLWithString:@"http://192.168.88.200:8080/MJServer/video"];
	
	    	NSString *urlStr = @"http://192.168.88.200:8080/MJServer/video";
	    	NSDictionary *params = @{@"type":@"JSON"};
	
	    	// GET 创建方式
	
	        	NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
	
	        	NSURLRequest *request2 = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" 
	        	                                                                       URLString:urlStr 
	        	                                                                      parameters:params 
	        	                                                                           error:NULL];
	
	    	// POST 创建方式
	
	        	NSMutableURLRequest *request3 = [NSMutableURLRequest requestWithURL:url2];
	        	request3.HTTPMethod = @"POST";
	        	request3.HTTPBody = [@"type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
	
	        	NSURLRequest *request4 = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" 
	        	                                                                       URLString:urlStr 
	        	                                                                      parameters:params 
	        	                                                                           error:NULL];
	
	        	NSURLRequest *request5 = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" 
	        	                                                                                    URLString:urlStr 
	        	                                                                                   parameters:params
	        	                                                                  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
	
	        	} error: NULL];
		```
	
	- Request 的设置
	
		```objc
	    	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	
	    	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.88.200:8080/MJServer/video?type=JSON"]];
	
	    	// 设置参数编码方式
	    	/*
	    		`NSUTF8StringEncoding` by default
	    	*/
			manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
	
	    	// 设置缓存策略
	    	/*
	    		`NSURLRequestUseProtocolCachePolicy` by default.
	    	*/
	    	manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
	
	     	request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
	
	    	// 设置网络服务类型
	    	/*
	    		`NSURLNetworkServiceTypeDefault` by default.
	    	*/
	      	manager.requestSerializer.networkServiceType = NSURLNetworkServiceTypeDefault;
	
	     	request.networkServiceType = NSURLNetworkServiceTypeDefault;
	
	    	// 设置请求超时时间
	    	/*
	    		The default timeout interval is 60 seconds.
	    	*/
			manager.requestSerializer.timeoutInterval = 15;
	
			request.timeoutInterval = 15;
	
	    	// 是否允许蜂窝网络访问
	    	/*
	    		`YES` by default.
	    	*/
			manager.requestSerializer.allowsCellularAccess = YES;
	
			request.allowsCellularAccess = YES;
	
	    	// 设置是否应用默认的 Cookies
	    	/*
	    		`YES` by default.
	    	*/
			manager.requestSerializer.HTTPShouldHandleCookies = YES;
	
			request.HTTPShouldHandleCookies = YES;
	
	    	// 设置是否使用 Pipelining
	    	/*
	    		`NO` by default.
	    	*/
			manager.requestSerializer.HTTPShouldUsePipelining = NO;
	
			request.HTTPShouldUsePipelining = NO;
	
	    	// 请求头设置
	    	
			[manager.requestSerializer setValue:@"iPhone" forHTTPHeaderField:@"User-Agent"];
	
			[request setValue:@"iPhone" forHTTPHeaderField:@"User-Agent"];
	
	    	// 设置用户验证
	    	
			[manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"admin" password:@"adminpasswd"];
	
			NSString *username = @"admin";
			NSString *password = @"adminpasswd";
			NSString *userPasswordString = [NSString stringWithFormat:@"%@:%@", username, password];
			NSData   *userPasswordData = [userPasswordString dataUsingEncoding:NSUTF8StringEncoding];
			NSString *base64EncodedCredential = [userPasswordData base64EncodedStringWithOptions:0];
			NSString *authString = [NSString stringWithFormat:@"Basic: %@", base64EncodedCredential];
	
			[request setValue:authString forHTTPHeaderField:@"Authorization"];
	
			// 清除用户验证信息
			
			[manager.requestSerializer clearAuthorizationHeader];
	
			[request setValue:nil forHTTPHeaderField:@"Authorization"];
	
			// 设置请求体
			request.HTTPBody = [@"type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
	
			// 设置请求模式
	
				// 单独设置
				/*
					默认是 GET
				*/
				request.HTTPMethod = @"POST";
	
				// 直接设置
	
				NSString *urlStr = @"http://192.168.88.200:8080/MJServer/video";
				NSDictionary *parameters = @{@"type":@"XML"};
	
				NSURLRequest *request1 = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" 
				                                                                       URLString:urlStr 
				                                                                      parameters:parameters 
				                                                                           error:NULL];
		```
	
	- 设置数据请求格式
	
		```objc
	    	NSString *urlStr = @"http://example.com";
	    	NSDictionary *parameters = @{@"foo": @"bar", @"baz": @[@1, @2, @3]};
	    
	    	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	    
	    	// 二进制 格式
	    
	        	// POST http://example.com/
	        	// Content-Type: application/x-www-form-urlencoded
	        
	        	// foo=bar&baz[]=1&baz[]=2&baz[]=3
	    
	        	manager.requestSerializer = [AFHTTPRequestSerializer serializer];      // 默认
	    
	        	NSURLRequest *request1 = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" 
	        	                                                                       URLString:urlStr 
	        	                                                                      parameters:parameters 
	        	                                                                           error:NULL];
	    
	    	// JSON 格式
	    
	        	// POST http://example.com/
	        	// Content-Type: application/json
	        
	        	// {"foo": "bar", "baz": [1,2,3]}
	        
	        	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	    
	        	NSURLRequest *request2 = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" 
	        	                                                                       URLString:urlStr 
	        	                                                                      parameters:parameters 
	        	                                                                           error:NULL];
	
	    	// Plist 格式
	    
	        	manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
	    
	        	NSURLRequest *request3 = [[AFPropertyListRequestSerializer serializer] requestWithMethod:@"POST" 
	        	                                                                               URLString:urlStr 
	        	                                                                              parameters:parameters 
	        	                                                                                   error:NULL];
		```
	
	- 设置数据响应格式
	
		```objc
	    	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	    
	    	AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] 
	    	                                  initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	    
	    	// 二进制
	    	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	    
	    	// JSON，默认，application/json, text/json, text/javascript
	    	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	    
	    	// XMLParser，SAX 解析
	    	manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
	    
	    	// Plist
	    	manager.responseSerializer = [AFPropertyListResponseSerializer serializer];
	    
	    	// Image
	    	manager.responseSerializer = [AFImageResponseSerializer serializer];
	    
	    	// Compound
	    	manager.responseSerializer = [AFCompoundResponseSerializer serializer];
		```
		
	- AFHTTPSessionManager 请求
	
		```objc
	    	// GET
		
				// DEPRECATED_ATTRIBUTE
				- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
				                            parameters:(nullable id)parameters
				                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
				                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
		
				- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
				                            parameters:(nullable id)parameters
				                              progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
				                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
				                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
	
	    	// HEAD
	
				- (nullable NSURLSessionDataTask *)HEAD:(NSString *)URLString
				                             parameters:(nullable id)parameters
				                                success:(nullable void (^)(NSURLSessionDataTask *task))success
				                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
	
	    	// POST
	
				// DEPRECATED_ATTRIBUTE
	        	- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
				                             parameters:(nullable id)parameters
				                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
				                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
	
	        	- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
				                             parameters:(nullable id)parameters
				                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
				                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
				                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
	
				// DEPRECATED_ATTRIBUTE
	        	- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
				                             parameters:(nullable id)parameters
				              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
				                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
				                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
	
	        	- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
				                             parameters:(nullable id)parameters
				              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
				                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
				                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
				                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
	
	    	// PUT
	
	        	- (nullable NSURLSessionDataTask *)PUT:(NSString *)URLString
				                            parameters:(nullable id)parameters
				                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
				                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
	
	    	// PATCH
	
	        	- (nullable NSURLSessionDataTask *)PATCH:(NSString *)URLString
				                              parameters:(nullable id)parameters
				                                 success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
				                                 failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
	
	    	// DELETE
	
	        	- (nullable NSURLSessionDataTask *)DELETE:(NSString *)URLString
				                               parameters:(nullable id)parameters
				                                  success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
				                                  failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
		```
	
	- AFURLSessionManager 请求
	
		```objc	
	    	// Data Tasks
	
	        	- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
	        	                            completionHandler:(nullable void (^)(NSURLResponse *response, 
	        	                                                                  id _Nullable responseObject, 
	        	                                                                       NSError * _Nullable error))completionHandler;
	
	        	- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
	        	                               uploadProgress:(nullable void (^)(NSProgress *uploadProgress))uploadProgressBlock
	        	                             downloadProgress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
	        	                            completionHandler:(nullable void (^)(NSURLResponse *response, 
	        	                                                                  id _Nullable responseObject, 
	        	                                                                       NSError * _Nullable error))completionHandler;
		
	    	// Upload Tasks
	
	        	- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request
	        	                                         fromFile:(NSURL *)fileURL
	        	                                         progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgressBlock
	        	                                completionHandler:(nullable void (^)(NSURLResponse *response, 
	        	                                                                      id _Nullable responseObject, 
	        	                                                                           NSError * _Nullable error))completionHandler;
	
	        	- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request
	        	                                         fromData:(nullable NSData *)bodyData
	        	                                         progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgressBlock
	        	                                completionHandler:(nullable void (^)(NSURLResponse *response, 
	        	                                                                      id _Nullable responseObject, 
	        	                                                                           NSError * _Nullable error))completionHandler;
	
	        	- (NSURLSessionUploadTask *)uploadTaskWithStreamedRequest:(NSURLRequest *)request
	        	                                                 progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgressBlock
	        	                                        completionHandler:(nullable void (^)(NSURLResponse *response, 
	        	                                                                              id _Nullable responseObject, 
	        	                                                                                   NSError * _Nullable error))completionHandler;
	
	    	// Download Tasks
	
	        	- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
	        	                                             progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
	        	                                          destination:(nullable NSURL * (^)(NSURL *targetPath, 
	        	                                                                    NSURLResponse *response))destination
	        	                                    completionHandler:(nullable void (^)(NSURLResponse *response, 
	        	                                                                                 NSURL * _Nullable filePath, 
	        	                                                                               NSError * _Nullable error))completionHandler;
	
	        	- (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData
	                                                          progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
	                                                       destination:(nullable NSURL * (^)(NSURL *targetPath, 
	                                                                                 NSURLResponse *response))destination
	                                                 completionHandler:(nullable void (^)(NSURLResponse *response, 
	                                                                                              NSURL * _Nullable filePath, 
	                                                                                            NSError * _Nullable error))completionHandler;
		```

# 3、AFNetworking 网络状态监测

- Objective-C
	
	- 网络连接状态：
	
		```objc
			AFNetworkReachabilityStatusUnknown          = -1,               网络状态未知
			AFNetworkReachabilityStatusNotReachable     = 0,                无网络连接
			AFNetworkReachabilityStatusReachableViaWWAN = 1,                无线网络（蜂窝移动网络）
			AFNetworkReachabilityStatusReachableViaWiFi = 2,                WiFi 网络
		```
		
	- 由于检测网络有一定的延迟，如果启动 App 立即去检测调用 [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus 有可能得到的是 netStatus == 					AFNetworkReachabilityStatusUnknown; 但是此时明明是有网的，建议在收到监听网络状态回调以后再取 [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus。或者延时调用 [self performSelector:@selector(networkReachability:) withObject:nil afterDelay:0.35f];。
	
	- 必须开启监听，才能获得网络状态。
		
		- AFNetworkReachabilityManager 方式
	
			```objc
				// 开启监听网络状态
		    	[[AFNetworkReachabilityManager sharedManager] startMonitoring];
		    
		    	// 关闭网络状态监听
		    	[[AFNetworkReachabilityManager sharedManager] stopMonitoring];
		    
		    	// 监听网络状态回调
		    	[[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
		
		    		// 开启网络状态监听后，只要网络状态发生改变就会调用该 Block 代码段
		    	}];
		    
		    	// 判断网络是否连接
		    	BOOL isReachable = [AFNetworkReachabilityManager sharedManager].isReachable;
		
				// 判断 WiFi 是否连接
		    	BOOL isReachableViaWiFi = [AFNetworkReachabilityManager sharedManager].isReachableViaWiFi;
		
				// 判断 无线网络 是否连接
		    	BOOL isReachableViaWWAN = [AFNetworkReachabilityManager sharedManager].isReachableViaWWAN;
		    
		    	// 获取网络连接状态
		    	AFNetworkReachabilityStatus netStatus = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
		
				// 转换网络状态为字符串格式
		    	NSString *netStatusStr1 = AFStringFromNetworkReachabilityStatus(netStatus);
		    
		    	// 获取网络连接状态
		    	NSString *netStatusStr2 = [[AFNetworkReachabilityManager sharedManager] localizedNetworkReachabilityStatusString];
			```
	
		- AFHTTPSessionManager/AFURLSessionManager 方式
	
			```objc
	        	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	    
	        	AFURLSessionManager * manager = [[AFURLSessionManager alloc] 
	        	                                  initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	
				// 开启监听网络状态
	        	[manager.reachabilityManager startMonitoring];
	    
	        	NSOperationQueue *operationQueue = manager.operationQueue;
	    
	        	[manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
	            
	            	// 开启网络状态监听后，只要网络状态发生改变就回调用该 Block 代码段
	             
	            	NSString *netStatus = AFStringFromNetworkReachabilityStatus(status);
	            	NSLog(@"Reachability: %@", netStatus);
	            
	            	switch (status) {
	                	case AFNetworkReachabilityStatusReachableViaWWAN:
	                	case AFNetworkReachabilityStatusReachableViaWiFi:
	                	
						// 继续 queue
	                   	[operationQueue setSuspended:NO];
	                   	break;
	                    
	                	case AFNetworkReachabilityStatusNotReachable:
	                	default:
	                	
						// 暂停 queue
	                   	[operationQueue setSuspended:YES];
	                   	break;
	            	}
	        	}];
			```
	
# 4、AFNetworking 安全策略设置

- Objective-C
	
	- AFSecurityPolicy 方式
	
		```objc
			AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
	    
	    	// 设置是否信任无效或过期的 SSL 证书的服务器。默认为否
			securityPolicy.allowInvalidCertificates = YES;                                                              
	    
	    	// 设置安全验证模式，默认为 AFSSLPinningModeNone
			securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];                        
		```
	
	- AFHTTPSessionManager/AFURLSessionManager 方式
	
		```objc
			AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	    
			AFURLSessionManager * manager = [[AFURLSessionManager alloc] 
			                                  initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	
			// 设置是否信任无效或过期的 SSL 证书的服务器。默认为否
			manager.securityPolicy.allowInvalidCertificates = YES;
	
			// 设置安全验证模式，默认为 AFSSLPinningModeNone
			manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
		```

# 5、AFHTTPRequestOperationManager 的使用

- Objective-C
	
	- Manager 的创建
	
		```objc
	    	NSURL *baseURL = [NSURL URLWithString:@"http://192.168.88.200"];
	    
	    	AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
	    	
	    	AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
		```
	
	- 设置数据请求格式
	
		```objc
	    	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	    
	    	// 二进制，默认
	    	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	    
	    	// JSON
	    	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	    
	    	// Plist
	    	manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
		```
	
	- 设置数据响应格式
	
		```objc
	    	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	    
	    	// 二进制
	    	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	    
	    	// JSON，默认
	    	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	    
	    	// XMLParser，SAX 解析
	    	manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
	    
	    	// Plist
	    	manager.responseSerializer = [AFPropertyListResponseSerializer serializer];
	    
	    	// Image
	    	manager.responseSerializer = [AFImageResponseSerializer serializer];
	    
	    	// Compound
	    	manager.responseSerializer = [AFCompoundResponseSerializer serializer];
		```
	
	- GET 请求
		
		- 数据请求
	    
	    	```objc
	        	NSString *urlStr = @"http://192.168.88.200/demo.json";
	        
	        	AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
	        
	        	[manger GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
	            
	            	NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
	            
	        	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	            
	            	NSLog(@"failure: %@", error);
	        	}];
			```
			
		- 文件下载
	    
	    	```objc
	        	NSString *urlStr = @"http://192.168.88.200/download/file/minion_01.mp4";
	        
	        	AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
	        	
	        	// 设置接收数据的类型为二进制格式
	        	manger.responseSerializer = [AFHTTPResponseSerializer serializer];
	        
	        	[manger GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
	            
	            	[responseObject writeToFile:[operation.response.suggestedFilename q_appendDocumentPath] atomically:YES];
	            
	            	NSLog(@"success: %@", [responseObject class]);
	            
	        	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	            
	            	NSLog(@"failure: %@", error);
	        	}];
			```
			
	- HEAD 请求
	
		```objc
	    	NSString *urlStr = @"http://192.168.88.200/download/file/minion_01.mp4";
	    
	    	AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
	    
	    	[manger HEAD:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation) {
	        
	        	NSLog(@"success: %@ --- %lld", operation.response.suggestedFilename, operation.response.expectedContentLength);
	        
	    	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	        
	        	NSLog(@"failure: %@", error);
	    	}];
		```
		
	- POST 请求
		
		- 数据请求
	    
	    	```objc
	        	NSString *urlStr = @"http://192.168.88.200:8080/MJServer/video";
	        	NSDictionary *params = @{@"type":@"JSON"};
	        
	        	AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
	        
	        	[manger POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
	            
	            	NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
	            
	        	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	            
	            	NSLog(@"failure: %@", error);
	        	}];
			```
			
		- 文件上传
	    
	    	```objc
	        	NSString *urlStr = @"http://192.168.88.200/upload/upload.php";
	        
	        	AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
	        
	        	[manger POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
	            
	            	NSData *fileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HQ_0005.jpg" ofType:nil]];
	            	[formData appendPartWithFileData:fileData name:@"userfile" fileName:@"test.jpg" mimeType:@"image/jpg"];
	            	[formData appendPartWithFormData:[@"qian" dataUsingEncoding:NSUTF8StringEncoding] name:@"username"];
	            
	        	} success:^(AFHTTPRequestOperation *operation, id responseObject) {
	            
	            	NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
	            
	        	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	            
	            	NSLog(@"failure: %@", error);
	        	}];
			```
	
# 6、AFHTTPSessionManager 的使用

- Objective-C
	
	- Manager 的创建
	
		```objc
	    	NSURL *baseURL = [NSURL URLWithString:@"http://192.168.88.200"];
	    	NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
	    
	    	AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
	    	
	    	AFHTTPSessionManager *manager2 = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
	    	
	    	AFHTTPSessionManager *manager3 = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:config];
		```
	
	- 设置数据请求格式
	
		```objc
	    	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	    
	    	// 二进制，默认
	    	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	    
	    	// JSON
	    	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	    
	    	// Plist
	    	manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
		```
	
	- 设置数据响应格式
	
		```objc
	    	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	    	    
	    	// 二进制
	    	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	    
	    	// JSON，默认
	    	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	    
	    	// XMLParser，SAX 解析
	    	manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
	    
	    	// Plist
	    	manager.responseSerializer = [AFPropertyListResponseSerializer serializer];
	    
	    	// Image
	    	manager.responseSerializer = [AFImageResponseSerializer serializer];
	    
	    	// Compound
	    	manager.responseSerializer = [AFCompoundResponseSerializer serializer];
		```
	
	- Request 设置
	
		```objc
	    	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	    
	    	// 设置参数编码方式，`NSUTF8StringEncoding` by default
	    	manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
	    
	    	// 设置缓存策略，`NSURLRequestUseProtocolCachePolicy` by default.
	    	manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
	    
	    	// 设置网络服务类型，`NSURLNetworkServiceTypeDefault` by default.
	    	manager.requestSerializer.networkServiceType = NSURLNetworkServiceTypeDefault;
	    
	    	// 设置请求超时时间，The default timeout interval is 60 seconds.
	    	manager.requestSerializer.timeoutInterval = 15;
	    
	    	// 是否允许蜂窝网络访问，`YES` by default.
	    	manager.requestSerializer.allowsCellularAccess = YES;
	    
	    	// 设置是否应用默认的 Cookies，`YES` by default.
	    	manager.requestSerializer.HTTPShouldHandleCookies = YES;
	    
	    	// 设置是否使用 Pipelining，`NO` by default.
	    	manager.requestSerializer.HTTPShouldUsePipelining = NO;
	    
	    	// 请求头设置
	    
	    		// 设置请求头
	        	[manager.requestSerializer setValue:@"iPhone" forHTTPHeaderField:@"User-Agent"];
	        
	        	// 设置用户验证
	        	[manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"admin" password:@"adminpasswd"];
	        
	        	// 清除用户验证信息
	        	[manager.requestSerializer clearAuthorizationHeader];
		```
	
	- GET 请求
		
		- 数据请求
		
			```objc
				NSString *urlStr = @"http://192.168.88.200/demo.json";
		        
				AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
		        
				[manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, 
				                                                                            id _Nullable responseObject) {
		            
					NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
		            
				} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		            
					NSLog(@"failure: %@", error);
		   		}];
			```
	
		- 文件下载
		
			```objc
				NSString *urlStr = @"http://192.168.88.200/download/file/minion_01.mp4";
		        
				AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
		        
				// 设置接收数据的类型为二进制格式
				manager.responseSerializer = [AFHTTPResponseSerializer serializer];                                              
		        
				[manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
		            
		       	float progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
		            
		         	dispatch_async(dispatch_get_main_queue(), ^{
		          		[self.progressBtn q_setButtonWithProgress:progress lineWidth:10 lineColor:nil 
		          	                                                              backgroundColor:[UIColor yellowColor]];
		        	});
		            
				} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		            
		        	[responseObject writeToFile:[task.response.suggestedFilename q_appendDocumentPath] atomically:YES];
		            
		    		NSLog(@"success: %@", [responseObject class]);
		            
				} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		            
		        	NSLog(@"failure: %@", error);
				}];
			```
	
	- HEAD 请求
	
		```objc
	    	NSString *urlStr = @"http://192.168.88.200/download/file/minion_01.mp4";
	    
	    	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	    
	    	[manager HEAD:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task) {
	        
	        	NSLog(@"success: %@ --- %lld", task.response.suggestedFilename, task.response.expectedContentLength);
	        
	    	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
	        
	        	NSLog(@"failure: %@", error);
	    	}];
		```
	
	- POST 请求
		
		- 数据请求
		
			```objc
	        	NSString *urlStr = @"http://192.168.88.200:8080/MJServer/video";
	        	NSDictionary *params = @{@"type":@"JSON"};
	        
	        	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	    
	        	[manager POST:urlStr parameters:params 
	        	                       progress:nil 
	        	                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
	            
	            	NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
	            
	        	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
	            
	            	NSLog(@"failure: %@", error);
	        	}];
			```
	
		- 文件上传
	
			```objc
	        	NSString *urlStr = @"http://192.168.88.200/upload/upload.php";
	    
	        	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	        
	        	[manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
	            
	            	NSData *fileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HQ_0005.jpg" ofType:nil]];
	            	[formData appendPartWithFileData:fileData name:@"userfile" fileName:@"test.jpg" mimeType:@"image/jpg"];
	            	[formData appendPartWithFormData:[@"qian" dataUsingEncoding:NSUTF8StringEncoding] name:@"username"];
	            
	        	} progress:^(NSProgress * _Nonnull uploadProgress) {
	            
	            	float progress = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
	            	dispatch_async(dispatch_get_main_queue(), ^{
	                	[self.progressBtn q_setButtonWithProgress:progress lineWidth:10 lineColor:nil 
	                	                                                          backgroundColor:[UIColor yellowColor]];
	            	});
	            
	        	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
	            
	            	NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
	            
	        	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
	            
	            	NSLog(@"failure: %@", error);
	        	}];
			```

# 7、AFURLSessionManager 的使用

- Objective-C
	
	- Manager 的创建
	
		```objc
	    	// 创建 manager
	    	AFURLSessionManager *manager = [[AFURLSessionManager alloc] 
	    	                                 initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	    
	    	// 取消挂起的 task
	    	[[AFURLSessionManager alloc] invalidateSessionCancelingTasks:YES];
		```
	
	- 设置数据响应格式
	
		```objc
	    	AFURLSessionManager *manager = [[AFURLSessionManager alloc] 
	    	                                 initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	    
	    	// 二进制
	    	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	    
	    	// JSON，默认
	    	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	    
	    	// XMLParser，SAX 解析
	    	manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
	    
	    	// Plist
	    	manager.responseSerializer = [AFPropertyListResponseSerializer serializer];
	    
	    	// Image
	    	manager.responseSerializer = [AFImageResponseSerializer serializer];
	    
	    	// Compound
	    	manager.responseSerializer = [AFCompoundResponseSerializer serializer];
		```
	
	- 获取上传下载进度
	
		```objc
	    	AFURLSessionManager *manager = [[AFURLSessionManager alloc] 
	    	                                 initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	    
	    	// 获取上传进度
	    	NSProgress *uploadProgress = [manager uploadProgressForTask:uploadTask];
	    
	    	// 获取下载进度
	    	NSProgress *downloadProgress = [manager uploadProgressForTask:downloadTask];
		```
	
	- Data Tasks
	
	    - GET 数据请求
	
			```objc
	        	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:
	        	                                                           @"http://192.168.88.200:8080/MJServer/video?type=JSON"]];
	    
	        	AFURLSessionManager *manager = [[AFURLSessionManager alloc] 
	    	                                 initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	    
	        	[[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, 
	        	                                                                     id _Nullable responseObject, 
	        	                                                                NSError * _Nullable error) {
	            
	            	if (error == nil && responseObject != nil) {
	                	NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
	            	} else {
	                	NSLog(@"failure: %@", error);
	            	}
	        	}] resume];
			```
	
	    - POST 数据请求
	
			```objc
	        	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:
	        	                                                                     @"http://192.168.88.200:8080/MJServer/video"]];
	        	request.HTTPMethod = @"POST";
	        	request.HTTPBody = [@"type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
	    
	        	AFURLSessionManager *manager = [[AFURLSessionManager alloc] 
	    	                                 initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	        
	        	[[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, 
	        	                                                                     id _Nullable responseObject, 
	        	                                                                NSError * _Nullable error) {
	            
	            	if (error == nil && responseObject != nil) {
	                	NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
	            	} else {
	                	NSLog(@"failure: %@", error);
	            	}
	        	}] resume];
			```
	
	- Upload Tasks
		
	    - POST 文件上传
	
			```objc
	        	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:
	        	                                                                        @"http://192.168.88.200/upload/upload.php"]];
	        	request.HTTPMethod = @"POST";
	    
	        	NSData *fileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HQ_0005.jpg" ofType:nil]];
	        	NSData *formData = [NSData q_formDataWithRequest:request 
	        	                                            text:@"qian" 
	        	                                        textName:@"username" 
	        	                                        fileData:fileData 
	        	                                            name:@"userfile" 
	        	                                        fileName:@"test.jpg" 
	        	                                        mimeType:@"imge/jpg"];
	    
	        	AFURLSessionManager *manager = [[AFURLSessionManager alloc] 
	        	                                 initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	        
	        	[[manager uploadTaskWithRequest:request fromData:formData progress:^(NSProgress * _Nonnull uploadProgress) {
	            
	            	float progress = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
	            	dispatch_async(dispatch_get_main_queue(), ^{
	                	[self.progressBtn q_setButtonWithProgress:progress lineWidth:10 lineColor:nil backgroundColor:[UIColor yellowColor]];
	            	});
	            
	        	} completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
	            
	            	if (error == nil && responseObject != nil) {
	                	NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
	            	} else {
	                	NSLog(@"failure: %@", error);
	            	}
		     	}] resume];
			```
	
	    - POST 文件上传，fileData 形式
	
			```objc
	        	NSString *urlStr = @"http://192.168.88.200/upload/upload.php";
	    
	        	NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] 
	        	                                     multipartFormRequestWithMethod:@"POST" 
	        	                                                          URLString:urlStr 
	        	                                                         parameters:nil
	        	                                          constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
	            
	            	// 指定文件数据形式上传
	            
	            	NSData *fileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HQ_0005.jpg" ofType:nil]];
	            	[formData appendPartWithFileData:fileData name:@"userfile" fileName:@"test.jpg" mimeType:@"imge/jpg"];
	            	[formData appendPartWithFormData:[@"qian" dataUsingEncoding:NSUTF8StringEncoding] name:@"username"];
	            
	        	} error: NULL];
	    
	        	AFURLSessionManager *manager = [[AFURLSessionManager alloc] 
	        	                                 initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	    
	        	[[manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
	            
	            	float progress = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
	            	dispatch_async(dispatch_get_main_queue(), ^{
	                	[self.progressBtn q_setButtonWithProgress:progress lineWidth:10 lineColor:nil backgroundColor:[UIColor yellowColor]];
	            	});
	            
	        	} completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
	            
	            	if (error == nil && responseObject != nil) {
	                	NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
	            	} else {
	                	NSLog(@"failure: %@", error);
	            	}
	        	}] resume];
			```
	
	    - POST 文件上传，fileUrl 形式
	
			```objc
	        	NSString *urlStr = @"http://192.168.88.200/upload/upload.php";
	        
	        	NSMutableURLRequest *urlRequest = [[AFHTTPRequestSerializer serializer] 
	        	                                        multipartFormRequestWithMethod:@"POST" 
	        	                                                             URLString:urlStr 
	        	                                                            parameters:nil 
	        	                                             constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
	            
	            	// 指定文件路径形式上传
	            
	            	NSURL *fileUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"HQ_0005" ofType:@"jpg"]];
	            	[formData appendPartWithFileURL:fileUrl name:@"userfile" fileName:@"test.png" mimeType:@"image/jpg" error:nil];
	            	[formData appendPartWithFormData:[@"qian" dataUsingEncoding:NSUTF8StringEncoding] name:@"username"];
	            
	        	} error: NULL];
	        
	        	AFURLSessionManager *manager = [[AFURLSessionManager alloc] 
	        	                                 initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	        
	        	[[manager uploadTaskWithStreamedRequest:urlRequest progress:^(NSProgress * _Nonnull uploadProgress) {
	            
	            	float progress = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
	            	dispatch_async(dispatch_get_main_queue(), ^{
	                	[self.progressBtn q_setButtonWithProgress:progress lineWidth:10 lineColor:nil backgroundColor:[UIColor yellowColor]];
	            	});
	            
	        	} completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
	            
	            	if (error == nil && responseObject != nil) {
	                	NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
	            	} else {
	                	NSLog(@"failure: %@", error);
	            	}
	        	}] resume];
			```
	
	    - PUT 文件上传
	
			```objc
	        	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:
	        	                                                                            @"http://192.168.88.200/uploads/123.jpg"]];
	        	request.HTTPMethod = @"PUT";
	    
	        	[request setValue:[@"admin:adminpasswd" q_basic64AuthEncode] forHTTPHeaderField:@"Authorization"];
	        
	        	NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"HQ_0005.jpg" withExtension:nil];
	    
	        	AFURLSessionManager *manager = [[AFURLSessionManager alloc] 
	        	                                 initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	        	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	    
	        	[[manager uploadTaskWithRequest:request fromFile:fileURL progress:^(NSProgress * _Nonnull uploadProgress) {
	            
	            	float progress = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
	            	dispatch_async(dispatch_get_main_queue(), ^{
	                	[self.progressBtn q_setButtonWithProgress:progress lineWidth:10 lineColor:nil backgroundColor:[UIColor yellowColor]];
	            	});
	            
	        	} completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
	            
	            	if (error == nil && responseObject != nil) {
	                	NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
	            	} else {
	                	NSLog(@"failure: %@", error);
	            	}
	        	}] resume];
			```
	
	- Download Tasks
		
	    - 普通下载
	
			```objc
	        	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.88.200/download/file/minion_01.mp4"]];
	        
	        	AFURLSessionManager *manager = [[AFURLSessionManager alloc] 
	        	                                 initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	    
	        	[[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
	            
	            	float progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
	            	dispatch_async(dispatch_get_main_queue(), ^{
	                	[self.progressBtn q_setButtonWithProgress:progress lineWidth:10 lineColor:nil backgroundColor:[UIColor yellowColor]];
	            	});
	            
	        	} destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
	            
	            	return [NSURL fileURLWithPath:[response.suggestedFilename q_appendDocumentPath]];
	            
	        	} completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
	            
	            	if (error == nil) {
	                	NSLog(@"success: %@ --- %@", response, [response class]);
	            	} else {
	                	NSLog(@"failure: %@", error);
	            	}
	        	}] resume];
			```
	
	    - 断点下载
	
			```objc
	        	@property (nonatomic, strong) AFURLSessionManager *manager;
	        	@property (nonatomic, retain) NSURLSessionDownloadTask *downloadTask;
	
	        	@property (nonatomic, strong) NSData   *resumeData;
	        	@property (nonatomic, strong) NSString *resumeTmpPath;
	
	        	@property (nonatomic, assign) BOOL isDownloading;
	        	@property (nonatomic, assign) BOOL isPause;
	
	        	- (AFURLSessionManager *)manager {
	            	if (_manager == nil) {
	                	_manager = [[AFURLSessionManager alloc] 
	                	             initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	                	_manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	            	}
	            	return _manager;
	        	}
	
	        	- (NSString *)resumeTmpPath {
	            	if (_resumeTmpPath == nil) {
	                	_resumeTmpPath = [@"resumeTmpData.tmp" q_appendCachePath];
	            	}
	            	return _resumeTmpPath;
	        	}
	
	        	// 开始下载
	
	        	- (void)start {
	            
	            	if (self.isDownloading) {
	                	NSLog(@"已经开始下载");
	                	return;
	            	}
	            
	            	if (self.isPause) {
	                
	                	NSLog(@"继续下载");
	                
	                	[self.downloadTask resume];
	                
	                	self.isPause = NO;
	                	self.isDownloading = YES;
	                	return;
	            	}
	
	            	if (![[NSFileManager defaultManager] fileExistsAtPath:self.resumeTmpPath]) {
	            
	                	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:
	                	                                                      @"http://120.25.226.186:32812/resources/videos/minion_01.mp4"]];
	                
	                	self.downloadTask = [self.manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
	                    
							[self downloadProgress:downloadProgress];
	                    
	                	} destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
	                    
							return [NSURL fileURLWithPath:[response.suggestedFilename q_appendDocumentPath]];
	                    
	                	} completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
	                    
							[self downloadCompletion:filePath error:error];
	                	}];
	                
	                	[self.downloadTask resume];
	                
	                	self.isPause = NO;
	                	self.isDownloading = YES;
	                
	            	} else {
	                	[self goon];
	            	}
	        	}
	
	        	// 继续下载
	
	        	- (void)goon {
	            
	            	if (self.isDownloading) {
	                	NSLog(@"已经开始下载");
	                	return;
	            	}
	            
	            	if (self.isPause) {
	                
	                	[self.downloadTask resume];
	                	NSLog(@"继续下载");
	                
	            	} else {
	                
	                	self.resumeData = [NSData dataWithContentsOfFile:self.resumeTmpPath];
	                
	                	self.downloadTask = [self.manager downloadTaskWithResumeData:self.resumeData 
	                	                                                    progress:^(NSProgress * _Nonnull downloadProgress) {
	                    
							[self downloadProgress:downloadProgress];
	                    
	                	} destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
	                    
							return [NSURL fileURLWithPath:[response.suggestedFilename q_appendDocumentPath]];
	                    
	                	} completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
	                    
							[self downloadCompletion:filePath error:error];
	                	}];
	                	
	                	[self.downloadTask resume];
	                
	                	NSLog(@"继续下载");
	            	}
	            
	            	self.isPause = NO;
	            	self.isDownloading = YES;
	        	}
	
	        	// 暂停下载
	
	        	- (void)pause {
	            
	            	if (!self.isDownloading) {
	                	NSLog(@"已经停止下载");
	                	return;
	            	}
	            
	            	[self.downloadTask suspend];
	            
	            	NSLog(@"暂停下载");
	            
	            	self.isPause = YES;
	            	self.isDownloading = NO;
	        	}
	
	        	// 停止下载
	
	        	- (void)stop {
	            
	            	if (!self.isDownloading) {
	                	NSLog(@"已经停止下载");
	                	return;
	            	}
	            
	            	[self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
	                
	                	if (resumeData) {
	                    
							self.resumeData = resumeData;
	                    
							[self.resumeData writeToFile:self.resumeTmpPath atomically:YES];
	                	}
	                
	                	self.downloadTask = nil;
	                
	                	NSLog(@"停止下载");
	            	}];
	            
	            	self.isDownloading = NO;
	        	}
	
	        	- (void)downloadProgress:(NSProgress *)downloadProgress {
	            
	            	float progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
	            	dispatch_async(dispatch_get_main_queue(), ^{
						[self.progressBtn q_setButtonWithProgress:progress lineWidth:10 lineColor:nil 
	               	                                                              backgroundColor:[UIColor yellowColor]];
	            	});
	        	}
	
	        	- (void)downloadCompletion:(NSURL *)filePath error:(NSError *)error {
	            
	            	self.isDownloading = NO;
	            
	            	if (error == nil) {
	                
	                	NSLog(@"success: %@", filePath.path);
	                
	                	[[NSFileManager defaultManager] removeItemAtPath:self.resumeTmpPath error:nil];
	                
	            	} else {
	                
	                	NSLog(@"%@", error);
	                
	                	if (error) {
							NSLog(@"failure: %@", error.userInfo[NSLocalizedDescriptionKey]);
	                    
							self.resumeData = error.userInfo[NSURLSessionDownloadTaskResumeData];
	                	}
	                
	                	if ([error.localizedFailureReason isEqualToString:@"No such file or directory"]) {
	                	
							[[NSFileManager defaultManager] removeItemAtPath:self.resumeTmpPath error:nil];
	                    
							[self start];
	                	}
	            	}
	        	}
			```
	
# 8、AFNetworking 单例封装

- AFNetworking 官方使用建议，建立 AFHTTPSesssionManager 的单例子类，统一管理全局的所有网络访问。
	
- Objective-C
	
	- NetworkTools.h
	
		```objc
	    	#import <AFNetworking/AFNetworking.h>
	
	    	@interface NetworkTools : AFHTTPSessionManager
	
	    	+ (instancetype)sharedNetworkTools;
	
	    	@end
		```
		
	- NetworkTools.m
	
		```objc
	    	@implementation NetworkTools
	
	    	+ (instancetype)sharedNetworkTools {
	        	static NetworkTools *tools;
	        
	        	static dispatch_once_t onceToken;
	        	dispatch_once(&onceToken, ^{
	            
	            	// baseURL 的目的，就是让后续的网络访问直接使用 相对路径即可，baseURL 的路径一定要有 / 结尾
	            	NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/"];
	            
	            	NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
	            
	            	tools = [[self alloc] initWithBaseURL:baseURL sessionConfiguration:config];
	            
	            	// 修改 解析数据格式 能够接受的内容类型 － 官方推荐的做法，民间做法：直接修改 AFN 的源代码
	            	tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", 
	            	                                                                        @"text/json", 
	            	                                                                        @"text/javascript", 
	            	                                                                        @"text/html", 
	            	                                                                        nil];
	        	});
	        	return tools;
	    	}
	
	    	@end
		```






//
//  JZNetWorkHelp.m
//  JZProject
//
//  Created by zjz on 2019/6/22.
//  Copyright © 2019 zjz. All rights reserved.
//

#import "JZNetWorkHelp.h"
#import <AFNetworking/AFNetworking.h>
#import "JZBaseObject.h"
#import "JZBaseNetModel.h"
@implementation JZNetWorkHelp
//1.post请求

//2.get请求
+ (JZNetWorkHelp *)shareNetWork{
    static JZNetWorkHelp *netWork;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWork = [[JZNetWorkHelp alloc] init];
        netWork.token = @"";
        netWork.userId = @"";
        netWork.zbToken = @"";
        netWork.zbuserpwd = @"";
        netWork.zbusername = @"";
        netWork.zbip = @"";
    });
    return netWork;
}
- (NSString *)backStringWithDic:(NSDictionary *)dic{
    NSString *string = @"?";
    for (NSString *key in dic.allKeys) {
        if (dic[key]) {
            NSString *value =  [NSString stringWithFormat:@"%@",dic[key]];
            if (value.length >0) {
                if ([string isEqualToString:@"?"]) {
                    string = [NSString stringWithFormat:@"%@%@=%@",string,key,[value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
                }else{
                   string = [NSString stringWithFormat:@"%@&%@=%@",string,key,[value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
                }
             
            }
        }

    }
    return string;
}
//-(NSData *)getBodyData
//{
//    NSMutableData *fileData = [NSMutableData data];
    //5.1 文件参数
    /*
     --分隔符
     Content-Disposition: form-data; name="file"; filename="Snip20160225_341.png"
     Content-Type: image/png(MIMEType:大类型/小类型)
     空行
     文件参数
     */
//    [fileData appendData:[[NSString stringWithFormat:@"--%@",Kboundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:KNewLine];
    
    //name:file 服务器规定的参数
    //filename:Snip20160225_341.png 文件保存到服务器上面的名称
    //Content-Type:文件的类型
//    [fileData appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"Sss.png\"" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:KNewLine];
//    [fileData appendData:[@"Content-Type: image/png" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:KNewLine];
//    [fileData appendData:KNewLine];
//
//    UIImage *image = [UIImage imageNamed:@"Snip20160227_128"];
//    //UIImage --->NSData
//    NSData *imageData = UIImagePNGRepresentation(image);
//    [fileData appendData:imageData];
//    [fileData appendData:KNewLine];
    
    //5.2 非文件参数
    /*
     --分隔符
     Content-Disposition: form-data; name="username"
     空行
     123456
     */
//    [fileData appendData:[[NSString stringWithFormat:@"--%@",Kboundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:KNewLine];
//    [fileData appendData:[@"Content-Disposition: form-data; name=\"username\"" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:KNewLine];
//    [fileData appendData:KNewLine];
//    [fileData appendData:[@"123456" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:KNewLine];
    
    //5.3 结尾标识
    /*
     --分隔符--
     */
//    [fileData appendData:[[NSString stringWithFormat:@"--%@--",Kboundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    return fileData;
//}

-(void)upload:(NSData *)data
{
    NSString *urlStr = @"http://api.fire2008.com.cn/operationscenter/project/uploadProjectFile";
    NSDictionary *dic = @{};
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.1url
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/upload"];
    
    //2.2创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //2.3 设置请求方法
    request.HTTPMethod = @"POST";
    
    //2.4 设请求头信息
    [request setValue:[NSString stringWithFormat:@"multipart/form-data"] forHTTPHeaderField:@"Content-Type"];
    
    //3.发送请求上传文件
    [manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data
                                    name:[NSString stringWithFormat:@"image"]
                                fileName:@"image.png"
                                mimeType:@" image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        JZLog(@"上传成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        JZLog(@"上传失败%@",error);
    }];
}
- (void)uploadImageWithData:(NSData *)data urlStr:(NSString *)url backData:(data)backData {
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
    //post 发送json格式数据的时候加上这两句
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    if ([JZNetWorkHelp shareNetWork].token) {
        [session.requestSerializer setValue:[JZNetWorkHelp shareNetWork].token forHTTPHeaderField:@"Token"];
    }
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *token = [NSMutableDictionary new];
    if ([JZNetWorkHelp shareNetWork].token) {
        [token setObject:[JZNetWorkHelp shareNetWork].token forKey:@"Token"];
    }
    [session POST:url parameters:token constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data
                                    name:[NSString stringWithFormat:@"image"]
                                fileName:@"image.png"
                                mimeType:@" image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"ok"]) {
            backData(YES,responseObject[@"data"][@"url"]);
        } else{
            backData(NO,@"图片上传失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         backData(NO,@"图片上传失败");
    }];
}
- (void)postWithDic:(NSDictionary *)dic url:(NSString *)url backData:(data)backData{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
    
    //post 发送json格式数据的时候加上这两句
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    if ([JZNetWorkHelp shareNetWork].token) {
        [session.requestSerializer setValue:[JZNetWorkHelp shareNetWork].token forHTTPHeaderField:@"Token"];
    }
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *token = [NSMutableDictionary new];
    if ([JZNetWorkHelp shareNetWork].token) {
        [token setObject:[JZNetWorkHelp shareNetWork].token forKey:@"Token"];
    }
    NSString *newStr = [NSString stringWithFormat:@"%@%@",url,[self backStringWithDic:dic]];
    [session POST:newStr parameters:token progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"ok"]) {
            backData(YES,responseObject[@"data"]);
        } else{
            backData(NO,responseObject[@"businessMsg"][@"businessNote"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        backData(NO,error.localizedDescription);
    }];
}
- (void)getWithDic:(NSDictionary *)dic url:(NSString *)url backData:(data)backData{
    
}
- (void)zbLoginNetWithParameter:(NSDictionary *)parament urlStr:(NSString *)url backData:(nonnull data)backData{
    if (![JZNetWorkHelp shareNetWork].zbuserpwd) {
        [JZTost showTost:@"暂无zb信息"];
        return;
    }
    NSDictionary *dic = @{
                          @"user":@"Admin",
                          @"password":@"Fire@2019",
                          };
    NSDictionary *newPar = @{
                             @"jsonrpc": @"2.0",
                             @"method": @"user.login",
                             @"params": dic,
                             @"id": @1,
                             };
    // 初始化Manager
    
    AFURLSessionManager *manager2 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 关键! 转化为NSaData作为HTTPBody
    NSString *jsonString = [self convertToJsonData:newPar];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [[manager2 dataTaskWithRequest:req uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            backData(false,@{});
        }else{
//            if (responseObject[@"data"]) {
//                <#statements#>
//            }
            [JZNetWorkHelp shareNetWork].zbToken = responseObject[@"result"];
            [JZBaseObject shareBaseObj].token = responseObject[@"result"];
            backData(YES,responseObject);
        }
    }] resume] ;
}
- (void)zbGetItemNetWithParameter:(NSDictionary *)parament urlStr:(NSString *)url backData:(data)backData{
    if (![JZBaseObject shareBaseObj].token) {
        [JZTost showTost:@"zb为获取数据未获取到"];
        return;
    }
    NSDictionary *newPar = @{
                             @"jsonrpc": @"2.0",
                             @"method": @"item.get",
                             @"params": parament,
                             @"auth":[JZBaseObject shareBaseObj].token,
                             @"id": @1,
                             };
    // 初始化Manager
    
    AFURLSessionManager *manager2 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 关键! 转化为NSaData作为HTTPBody
    NSString *jsonString = [self convertToJsonData:newPar];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [[manager2 dataTaskWithRequest:req uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            backData(false,@{});
        }else{
            backData(YES,responseObject);
        }
    }] resume] ;
}
- (void)zbGetHostNetWithParameter:(NSDictionary *)parament urlStr:(NSString *)url backData:(data)backData{//hostid 10271  10084 10272
    if (![JZBaseObject shareBaseObj].token) {
        [JZTost showTost:@"zb为获取数据未获取到"];
        return;
    }
    NSDictionary *hostDic = @{};
    NSDictionary *filter = @{@"filter":hostDic};
    
    NSDictionary *newPar = @{
                             @"jsonrpc": @"2.0",
                             @"method": @"host.get",
                             @"params": filter,
                             @"auth":[JZBaseObject shareBaseObj].token,
                             @"id": @1,
                             };
    AFURLSessionManager *manager2 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 关键! 转化为NSaData作为HTTPBody
    NSString *jsonString = [self convertToJsonData:newPar];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [[manager2 dataTaskWithRequest:req uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            backData(false,@{});
        }else{
            backData(YES,responseObject);
        }
    }] resume] ;
}
-(void)zbGetHistoryNetWithParameter:(NSDictionary *)parament urlStr:(NSString *)url backData:(data)backData{
    if (![JZBaseObject shareBaseObj].token) {
        [JZTost showTost:@"zb为获取数据未获取到"];
        return;
    }
    NSDictionary *newPar = @{
                             @"jsonrpc": @"2.0",
                             @"method": @"history.get",
                             @"params": parament,
                             @"auth":[JZBaseObject shareBaseObj].token,
                             @"id": @1,
                             };
    // 初始化Manager
    
    AFURLSessionManager *manager2 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 关键! 转化为NSaData作为HTTPBody
    NSString *jsonString = [self convertToJsonData:newPar];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [[manager2 dataTaskWithRequest:req uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            backData(false,@{});
        }else{
            backData(YES,responseObject);
        }
    }] resume] ;
}
-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
@end

//
//  CFCitiesDataTool.m
//  ClearFamily
//
//  Created by 谢腾飞 on 2019/1/17.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFCitiesDataTool.h"
#import "FMDB.h"
#import "CFAddressItem.h"

@interface CFCitiesDataTool ()

@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) FMDatabase *fmdb;
@end

@implementation CFCitiesDataTool
static NSString * const dbName = @"location.db";
static NSString * const locationTabbleName = @"locationTabble";

static CFCitiesDataTool *shareInstance = nil;

+ (instancetype)sharedManager
{
    @synchronized (self) {
        if (shareInstance == nil) {
            shareInstance = [[self alloc] init];
        }
    }
    return shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized (self) {
        if (shareInstance == nil) {
            shareInstance = [super allocWithZone:zone];
        }
    }
    return shareInstance;
}

- (id)copy
{
    return shareInstance;
}

- (id)init
{
    if ([super init]) {
        [self creatDB];
    }
    return self;
}

- (void)creatDB
{
    NSString *dbPath = [self pathForName:dbName];
    self.fmdb = [FMDatabase databaseWithPath:dbPath];
}

- (void)deleteDB
{
    NSString *dbPath = [self pathForName:dbName];
    [[NSFileManager defaultManager] removeItemAtPath:dbPath error:nil];
}

/*** 获得指定名字的文件的全路径 ***/
- (NSString *)pathForName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths lastObject];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:name];
    
    return dbPath;
}

/*** 判断是否存在表 ***/
- (BOOL)isCanRead
{
    BOOL openSuccess = [self.fmdb open];
    
    if (!openSuccess) {
        CFLog(@"地址数据库打开失败");
    } else {
        CFLog(@"地址数据库打开成功");
        FMResultSet *rs = [self.fmdb executeQuery:@"SELECT count(*) as 'count' FROM sqlite_master WHERE type ='table' and name = ?", locationTabbleName];
        
        while ([rs next]) {
            NSInteger count = [rs intForColumn:@"count"];
            
            if (0 == count) {
                [self.fmdb close];
                return NO;
            } else {
                [self.fmdb close];
                return YES;
            }
        }
    }
    [self.fmdb close];
    return NO;
}

/*** 数据请求 ***/
- (void)requestData
{
    if ([self isCanRead]) return;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Cities" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSArray *objectArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    for (NSDictionary *dict in objectArray) {
        CFAddressItem *item = [[CFAddressItem alloc] initWithDict:dict];
        [self.dataArray addObject:item];
    }
    if (self.dataArray.count > 0  && [self createTable]) {
        [self insertRecords];
    }
}

/*** 插入数据 ***/
- (void)insertRecords
{
    NSDate *startTime = [NSDate date];
    
    if ([self.fmdb open] && [self.fmdb beginTransaction]) {
        
        BOOL isRollBack = NO;
        @try {
            for (CFAddressItem *item in self.dataArray) {
                if (item.level.integerValue == 3 && [item.name isEqualToString:@"市辖区"]) {
                    continue;
                }
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ ('code','province','city','area','name', 'level') VALUES ('%@','%@','%@','%@','%@','%@')",locationTabbleName, item.code, item.province, item.city, item.area, item.name, item.level];
                
                BOOL isSuccessful = [self.fmdb executeUpdate:sql];
                if (!isSuccessful) {
                    CFLog(@"插入地址信息数据失败!");
                } else {
                    CFLog(@"批量插入地址信息数据成功!");
                }
                
                NSDate *endTime = [NSDate date];
                NSTimeInterval time = [endTime timeIntervalSince1970] - [startTime timeIntervalSince1970];
                
                CFLog(@"使用事务地址信息用时%.3f秒",time);
            }
        } @catch (NSException *exception) {
            
            isRollBack = YES;
            [self.fmdb rollback];
        } @finally {
            
            if (!isRollBack) {
                [self.fmdb commit];
            }
        }
        [self.fmdb close];
    } else {
        [self insertRecords];
    }
}

/*** 删除数据 ***/
- (BOOL)deleteRecords
{
    BOOL openSuccess = [self.fmdb open];
    if (!openSuccess) {
        CFLog(@"地址数据库打开失败");
    } else {
        CFLog(@"地址数据库打开成功");
        NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", locationTabbleName];
        
        if (![self.fmdb executeUpdate:sqlstr]) {
            [self.fmdb close];
            return NO;
        }
    }
    [self.fmdb close];
    return YES;
}

/*** 创建表 ***/
- (BOOL)createTable
{
    BOOL result = NO;
    BOOL openSuccess = [self.fmdb open];
    if (!openSuccess) {
        CFLog(@"地址数据库打开失败");
    } else {
        CFLog(@"地址数据库打开成功");
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (code text primary key,province text,city text,area text,name text,level text);",locationTabbleName];
        result = [self.fmdb executeUpdate:sql];
        if (!result) {
            CFLog(@"创建地址表失败");
        } else {
            CFLog(@"创建地址表成功");
        }
    }
    [self.fmdb close];
    return result;
}

/*** 查询 ***/
- (NSMutableArray *)queryAllProvincialLevel
{
    if ([self.fmdb open]) {
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE `level` = 1", locationTabbleName];
        FMResultSet *result = [self.fmdb  executeQuery:sql];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        
        while ([result next]) {
            
            CFAddressItem *addressItem = [[CFAddressItem alloc] init];
            addressItem.code = [result stringForColumn:@"code"];
            addressItem.province = [result stringForColumn:@"province"];
            addressItem.city = [result stringForColumn:@"city"];
            addressItem.area = [result stringForColumn:@"area"];
            addressItem.name = [result stringForColumn:@"name"];
            addressItem.level = [result stringForColumn:@"level"];
            [array addObject:addressItem];
        }
        [self.fmdb close];
        
        return array;
    }
    return nil;
}

- (NSString *)queryRecordWithAreaCode:(NSString *)areaCode
{
    if ([self.fmdb open]) {
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE  `code` = %@", locationTabbleName,areaCode];
        FMResultSet *result = [self.fmdb executeQuery:sql];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        
        while ([result next]) {
            
            CFAddressItem *addressItem = [[CFAddressItem alloc] init];
            addressItem.code = [result stringForColumn:@"code"];
            addressItem.province = [result stringForColumn:@"province"];
            addressItem.city = [result stringForColumn:@"city"];
            addressItem.area = [result stringForColumn:@"area"];
            addressItem.name = [result stringForColumn:@"name"];
            addressItem.level = [result stringForColumn:@"level"];
            [array addObject:addressItem];
        }
        [self.fmdb close];
        if (array.count > 0) {
            CFAddressItem *model = array.firstObject;
            return model.name;
        }
    }
    return nil;
}

- (NSMutableArray *)queryRecordWithProvincial:(NSString *)provincial
{
    if ([self.fmdb  open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE `level` = 2 AND  `province` = %@",locationTabbleName ,provincial];
        FMResultSet *result = [self.fmdb  executeQuery:sql];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        
        while ([result next]) {
            
            CFAddressItem *addressItem = [[CFAddressItem alloc] init];
            addressItem.code = [result stringForColumn:@"code"];
            addressItem.province = [result stringForColumn:@"province"];
            addressItem.city = [result stringForColumn:@"city"];
            addressItem.area = [result stringForColumn:@"area"];
            addressItem.name = [result stringForColumn:@"name"];
            addressItem.level = [result stringForColumn:@"level"];
            [array addObject:addressItem];
        }
        [self.fmdb close];
        return array;
    }
    return nil;
}

- (NSMutableArray *)queryRecordWithProvincial:(NSString *)provincial city:(NSString *)city
{
    if ([self.fmdb open]) {
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE `level` = 3 AND  `province` = %@  AND `city` = '%@'"  , locationTabbleName, provincial, city];
        FMResultSet *result = [self.fmdb  executeQuery:sql];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        
        while ([result next]) {
            
            CFAddressItem *addressItem = [[CFAddressItem alloc] init];
            addressItem.code = [result stringForColumn:@"code"];
            addressItem.province = [result stringForColumn:@"province"];
            addressItem.city = [result stringForColumn:@"city"];
            addressItem.area = [result stringForColumn:@"area"];
            addressItem.name = [result stringForColumn:@"name"];
            addressItem.level = [result stringForColumn:@"level"];
            [array addObject:addressItem];
        }
        [self.fmdb close];
        return array;
    }
    return nil;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
@end

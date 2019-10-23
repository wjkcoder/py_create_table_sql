import re

import pandas as pd

# content = pd.read_excel('表创建模板.xlsx', sheet_name='Sheet1',
#                         usecols=['字段名', '数据类型', '是否为空', '默认值', '主键', '备注'])
content = pd.read_excel('表创建模板.xlsx', sheet_name='Sheet1')

# print(content.index)
# print(content.columns)
key_arr = []
key_str = ''
header = content[:3]
#
table_name = content.columns[1].lower()
table_name_comment = header.iat[0, 1]
sql_init = '''CREATE TABLE `''' + table_name + '''`  (
  `CREATED_BY` bigint(20) NOT NULL COMMENT '创建人',
  `CREATION_DATE` datetime(0) NOT NULL COMMENT '创建时间',
  `LAST_UPDATED_BY` bigint(20) NOT NULL COMMENT '最后更新人',
  `LAST_UPDATE_DATE` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后更新时间',
  `LAST_UPDATE_LOGIN` bigint(20) NOT NULL COMMENT '最后更新时登录ID',
  `CID` bigint(20) NOT NULL DEFAULT 1,
  `TENANT_ID` bigint(20) NOT NULL COMMENT '关联SYS_TENANT表中的TENANT_ID','''
content = content[3:]
for row in content.values:
    fieldName = row[0]
    if fieldName in ['CREATED_BY', 'CREATION_DATE', 'LAST_UPDATED_BY', 'LAST_UPDATE_DATE', 'LAST_UPDATE_LOGIN', 'CID',
                     'TENANT_ID']:
        continue
    data_type = row[1]
    allow_null = row[2]
    default_value = str(row[3])
    primary_key = str(row[4])
    remark = str(row[5])
    type_sql_str = ''
    allow_null_sql_str = ''
    default_str = ''
    comment_str = ''
    switch = {
        'BIGINT': lambda x: 'bigint(20)',
        'BIT': lambda x: 'bit(1)',
        'DATETIME': lambda x: 'datetime(0)',
        'TIMESTAMP': lambda x: 'timestamp(0)'
    }
    if isinstance(data_type, str):
        if data_type.startswith('VARCHAR'):
            varchar_length = re.findall(r'[(](.*?)[)]', data_type)
            type_sql_str = data_type.lower()
            type_sql_str += ' CHARACTER SET utf8 COLLATE utf8_bin '
        elif data_type.startswith('DECIMAL'):
            type_sql_str = data_type.lower()
        else:
            type_sql_str = switch[data_type](type_sql_str)
    if allow_null == 'N':
        allow_null_sql_str = ' NOT NULL'
    if default_value is not None and default_value != 'nan':
        default_str = 'DEFAULT ' + default_value
    if remark is not None and remark != 'nan':
        comment_str = " COMMENT '" + remark + "'"
    row_sql = "\n`" + fieldName + "` " + type_sql_str + allow_null_sql_str + default_str + comment_str + ','
    if primary_key is not None and primary_key != 'nan' and primary_key == 'Y':
        key_arr.append(fieldName)
    # print(row_sql)
    sql_init += row_sql
if len(key_arr) > 0:
    key_str = '\nPRIMARY KEY ('
    for key in key_arr:
        key_str += '`' + key + '`,'
    key_str = key_str.strip(',')
    key_str += ') USING BTREE,'
sql_init += key_str
sql_init = sql_init.strip(',')
sql_init += "\n) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '" + table_name_comment + "' ROW_FORMAT = Dynamic;"
print('**************Here is your generate sql*********************')
print(sql_init)
print('***************************END******************************')
file_name = 'generate.sql'
with open(file_name, 'w', encoding="utf-8") as file_object:
    file_object.write(sql_init)

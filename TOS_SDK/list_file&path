# volcengine TOS SDK 获取多样本名字 & 路径

import tos
import re
import csv

# AK/SK 从右上角头像-API访问密钥
ak = ""
sk = ""

endpoint = "tos-cn-beijing.volces.com"
region = "cn-beijing"
bucket_name = "bioos-wce6mpileig41ecp3t0fg" 

# 创建 TosClientV2 对象，对桶和对象的操作都通过 TosClientV2 实现
client = tos.TosClientV2(ak, sk, endpoint, region)

# 列举指定桶下指定前缀的所有对象
truncated = True
marker = ''

suffix = ".*\.sra"
sra_files_path = []

while truncated:
    result = client.list_objects(bucket_name,marker)

    # for iterm in result.contents:
    # print('key={}, etag={}, hash_crc64_ecma={}, last_modified={}'.format(iterm.key, iterm.etag, iterm.hash_crc64_ecma, iterm.last_modified))

    for iterm in result.contents:
        if re.search(suffix, iterm.key):
            sra_files_path.append(iterm.key)
      
    truncated = result.is_truncated
    marker = result.next_marker
    
with open('SRA.csv', 'w', encoding='UTF8', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['SRA_id','SRA_path'])
    data = []

    for iterm in sra_files_path:
        sample_name = str(iterm.replace("sample/sra/",""))
        sample_path = str("s3://bioos-wce6mpileig41ecp3t0fg/" + str(iterm))
        sample = [sample_name ,sample_path]
        print(sample)
        data.append(sample)

    writer.writerows(data)

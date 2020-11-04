# KaggleViz
a benchmark dataset for visualization recommendation

```
.
├── airplane_crashes 
│   ├── airplane_crashes.json 
│   ├── airplane_crashes_drop_unused_cols.csv 
│   ├── notebooks 
│   │   ├── airplane_crashes_1.ipynb 
│   │   ├── airplane_crashes_2.ipynb 
│   │   ... 
│   ├── raw_json 
│   │   ├── airplane_crashes_1.json 
│   │   ├── airplane_crashes_2.json 
│   │   ... 
│   └── type 
│        └── types.json 
... 
```

The directory structure of this dataset is shown above. 
For each dataset(e.g., airplane_crashes), it contains the followings: 
1. The raw dataset file airplane_crashes_drop_unused_cols.csv (omitted due to file size limitation), see here https://stuscueducn-my.sharepoint.com/:f:/g/personal/vengeji_stu_scu_edu_cn/ErvLbAEpd7BOl99haBYrsXMBLMgBKxEQ_6wIJt-M8ZdKFw?e=Kejp6x
2. The collected notebooks containing the interactive analysis logs under the directory /notebooks 
3. The collected visualization results in JSON format under the directory /raw_json 
4. The merged visualization results in JSON format in the file airplane_crashes.json 
5. The schema of attributes (using pandas data types) in the file /type/types.json 

![exmaple](https://github.com/vengeji/vizrec_bench/blob/master/benchmark.png)

A sample dataset kickstarter in the KaggleViz. For each dataset, we collect visualization results in JSON format recorded in files kickstarter\_*.json (A)(B). Then we merge results based on the votes to generate an ordered list with 25 visualizations in file kickstarter.json (C). The used attributes are recorded in file types.json.

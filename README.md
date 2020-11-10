# KaggleViz —— benchmark for visualization recommendation

|Name| #-Row| #-Attr | #-Attr-used|#-Viz|
| ------ | ------ | ------ |------ | ------ | 
|airplane_crashes|5268|13|6|22|
|avito_demand|1503424|18|14|33|
|avocados_price|18249|14|7|20|
|flight_delay|5819079|32|8|18|
|google_play_store|9659|13|11|33|
|gun_violence|239677|29|6|21|
|h1b_visa|3002458|11|7|14|
|home_credit_risk|307511|122|20|50|
|kickstarter|378661|15|10|25|
|lending_club|2260668|149|15|29|
|patient_charge|1338|10|9|14|
|sberbank_russian_housing_market|30471|292|16|29|
|student_performance|1000|8|8|34|
|suicide_rates|27820|12|9|25|
|terrorism|170350|136|30|40|
|titan|891|12|8|23|
|videogame|16719|17|15|48|
|zomato|51717|17|11|49|

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

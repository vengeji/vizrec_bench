# vizrec_bench
benchmark dataset for visualization recommendation

.<br>
├── airplane_crashes <br>
│   ├── airplane_crashes.json <br>
│   ├── airplane_crashes_raw.csv <br>
│   ├── notebooks <br>
│   │   ├── airplane_crashes_1.ipynb <br>
│   │   ├── airplane_crashes_2.ipynb <br>
│   │   ... <br>
│   ├── raw_json <br>
│   │   ├── airplane_crashes_1.json <br>
│   │   ├── airplane_crashes_2.json <br>
│   │   ... <br>
│   └── type <br>
│       └── types.json <br>
... <br>


The directory structure of this dataset is shown above. 
For each dataset(e.g., airplane_crashes), it contains the followings: 
1. The raw dataset file airplane_crashes_raw.csv 
2. The collected notebooks containing the interactive analysis logs under the directory /notebooks 
3. The collected visualization results in JSON format under the directory /raw_json 
4. The merged visualization results in JSON format in the file airplane_crashes.json 
5. The schema of attributes (using pandas data types) in the file /type/types.json 

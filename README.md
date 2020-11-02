# vizrec_bench
benchmark dataset for visualization recommendation
.
├── airplane_crashes
│   ├── airplane_crashes.json
│   ├── airplane_crashes_raw.csv
│   ├── notebooks
│   │   ├── airplane_crashes_1.ipynb
│   │   ├── airplane_crashes_2.ipynb
|   |   ...
│   ├── raw_json
│   │   ├── airplane_crashes_1.json
│   │   ├── airplane_crashes_2.json
|   |   ...
│   └── type
│       └── types.json
...

The directory structure of this dataset is shown above.
For each dataset(e.g., airplane_crashes), it contains the followings:
1. The raw dataset file airplane_crashes_raw.csv
2. The collected notebooks containing the interactive analysis logs under the directory /notebooks
3. The collected visualization results in JSON format under the directory /raw_json
4. The merged visualization results in JSON format in the file airplane_crashes.json
5. The schema of attributes (using pandas data types) in the file /type/types.json

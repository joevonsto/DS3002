# Joe von Storch (jhv9wsz)
# DS 3002 Project 1

# Import packages
import pandas as pd
from sqlalchemy import create_engine
import requests


# Open Charlottesville Real Estate data using API address (BENCHMARK 1)
df = []
try:
    url = "https://opendata.arcgis.com/datasets/bc72d0590bf940ff952ab113f10a36a8_8.geojson"
    response = requests.get(url)
    d = response.json()
    # convert data to dataframe to make more accessible
    d2 = d['features']
    df = pd.json_normalize(d2)
except:
    print("Please enter a valid URL")

# Ask user to convert what was originally a JSON file to either a CSV or SQL (BENCHMARK 2)
convert_to = input("Convert file to CSV or SQL: ")
engine = create_engine('sqlite://', echo=False)

# Convert according to user input, throw error if input was not SQL or CSv
if convert_to == 'CSV':
    df.to_csv('real_estate.csv')
    print("The file has been converted into a CSV")
elif convert_to == "SQL":
    df.to_sql('real_estate', con=engine)
    print("The file has been converted into a SQL table")
else:
    print(convert_to +" is not a valid file type")

# Ask user to delete any column, throw error if invalid column name is entered (BENCHMARK 3)
del_col = input("Enter a column name to be deleted: ")
df_modified = df
try:
    df_modified = df.drop(del_col, 1)
except:
    print(del_col + " is not a valid column name")

# Convert modified dataframe to SQL database (BENCHMARK 4)
df_modified.to_sql('Real_Estate_Modified', con=engine)

# Brief summary of file: number of rows and columns from modified data frame (BENCHMARK 5)
print("ROWS: "+str(len(df_modified)))
print("COLUMNS (in modified data frame): "+str(len(df_modified.columns)))

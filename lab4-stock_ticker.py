# Joe von Storch
# Stock Ticker API Lab

import requests
import json

stock_ticker = input("Enter stock abbreviation: ")

stock_number = stock_ticker.count(",")+1


try:
    url = "https://yfapi.net/v6/finance/quote"
    querystring = {"symbols": stock_ticker}
    headers = {
        'x-api-key': "MVz4PpGSfo8WV2Rtiu5VF4uIqmfiq3Czyh7Rf6bd"
    }

    response = requests.request("GET", url, headers=headers, params=querystring)

    stock_json = response.json()
    for i in range(stock_number):
        print(stock_json['quoteResponse']['result'][i]['longName'], stock_json['quoteResponse']['result'][i]['regularMarketPrice'])

except:
    print("Please enter a valid stock")

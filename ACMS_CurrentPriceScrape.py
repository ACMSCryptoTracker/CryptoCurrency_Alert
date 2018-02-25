import coinmarketcap
import json
import pandas as pd
import time

#Call the Api

market=coinmarketcap.Market()

#this grabs all of the coin data available

coins = (market.ticker())
for i in range(96):
    #this creates a dataframe with the top 10 coins
    #timestamps and stores the csv file
    #waits 5 minutes  until collecting data again
    count=1;
    for j in range(10):
        coinArray=pd.DataFrame([pd.Series(coins[j])]).set_index("id")
       # print(coinArray)
        location="./"+str(count)+'.csv'
        coinArray.to_csv(location,mode='a',header=True)
        count=count+1
        print(count)
        time.sleep(5)


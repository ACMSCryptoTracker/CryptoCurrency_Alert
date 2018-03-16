import psycopg2
import requests
import json
import csv
from collections import defaultdict
import sched,time
hostname = 'baasu.db.elephantsql.com'
username = 'dbuzkqmi'
password = 'vi24qSFc5TG77k5GPa4aQr3XlnLOBIRf'
database = 'dbuzkqmi'
port='5432'
url = "https://api.coinmarketcap.com/v1/ticker/?limit=5"


s=sched.scheduler(time.time,time.sleep)

def insertIntoDatabase():
	print("Function called")
	myConnection = psycopg2.connect(host=hostname, user=username, password=password, dbname=database,port=port)
	curr=myConnection.cursor()
	response=requests.get(url)
	X=json.loads(response.text)
	count=0
	values=dict()
	for x in X:
		if count == 0 :
			header=x.keys()
			count+=1
		val=x.values()
		for i in range(len(header)) :
			if val[i] is None :
				val[i]=0
			if header[i] in values:
				values[header[i]].append(val[i])
			else:
				values[header[i]]=[val[i]]
			count+=1
	for i in range(len(X)) :
		insertquery="INSERT INTO public.currency(name,symbol,rank,price_usd,price_btc,c_24h_volume_usd,market_cap_usd,available_supply,total_supply,max_supply,percentage_change_1h,percentage_change_24h,percentage_change_7d,last_updated) values('{}','{}',{},{},{},{},{},{},{},{},{},{},{},{})".format(values['name'][i],values['symbol'][i],values['rank'][i],values['price_usd'][i],values['price_btc'][i],values['24h_volume_usd'][i],values['market_cap_usd'][i],values['available_supply'][i],values['total_supply'][i],values['max_supply'][i],values['percent_change_1h'][i],values['percent_change_24h'][i],values['percent_change_7d'][i],values['last_updated'][i])
		curr.execute(insertquery)
	myConnection.commit()
	myConnection.close()
	s.enter(1800, 1, insertIntoDatabase, ())

s.enter(1800, 1, insertIntoDatabase, ())
s.run()


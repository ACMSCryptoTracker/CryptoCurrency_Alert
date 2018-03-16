import psycopg2

hostname = 'baasu.db.elephantsql.com'
username = 'dbuzkqmi'
password = 'vi24qSFc5TG77k5GPa4aQr3XlnLOBIRf'
database = 'dbuzkqmi'
port='5432'
conn = psycopg2.connect(host=hostname, user=username, password=password, dbname=database,port=port)
curr=conn.cursor()

user_id=1
AlertType='THRESHOLD_ALERT'
coinSymb='BTC'
coinConversion='USD'
price=8205.19
thresholdMin=10000
thresholdMax=7000
curr.execute("insert into public.alert (user_id,alert_type,coin_symbol,conversion_symbol,price,threshold_min,threshold_max) values ({},'{}','{}','{}',{},{},{})".format(user_id,AlertType,coinSymb,coinConversion,price,thresholdMin,thresholdMax))
conn.commit()
conn.close()

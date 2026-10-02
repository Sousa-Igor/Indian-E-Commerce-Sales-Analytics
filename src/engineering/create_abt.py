#%%
import pandas as pd
import sqlalchemy
from tqdm import tqdm
import datetime as dt
#%%
def ingest_date(start,stop, monthly = False):
    datas = []
    while start <= stop:
        datas.append(start)
        start = dt.datetime.strptime(start, '%Y-%m-%d') + dt.timedelta(days=1)
        start = dt.datetime.strftime(start, '%Y-%m-%d')

    if monthly:
        return [i for i in datas if i.endswith("01")]


    return datas
# %%

engine = sqlalchemy.create_engine('sqlite:///../../data/database.db')
target = sqlalchemy.create_engine('sqlite:///../../data/abt.db')

tabelas = ['fs_customer',
'fs_purchase',
'fs_spend',
'fs_product',
'fs_cupom',
'fs_cancel',
'fs_period',
'fs_churn']


datas = ingest_date('2024-06-01','2026-06-01', monthly=True)
datas
# %%
for i in tabelas:
    for DtRef in tqdm(datas):
        with open(f'{i}.sql', 'r') as open_file:
            query = open_file.read()
        query = query.format(date = DtRef)

        df = pd.read_sql(query, engine)
        df.to_sql(f'{i}', target, index=False, if_exists='append')

#%%
dt.datetime.strptime('2024-06-01', '%Y-%m-%d')
dt.timedelta()

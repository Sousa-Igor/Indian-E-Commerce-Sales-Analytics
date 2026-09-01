#%%
import pandas as pd
import sqlalchemy
from tqdm import tqdm
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

# %%
for i in tqdm(tabelas):
    with open(f'{i}.sql', 'r') as open_file:
        query = open_file.read()

    df = pd.read_sql(query, engine)
    df.to_sql(f'{i}', target, index=False, if_exists='replace')


# %%

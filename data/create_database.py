#%%
import sqlalchemy
import pandas as pd
from tqdm import tqdm

# %%
def createdb(tabela):
    engine = sqlalchemy.create_engine("sqlite:///database.db")
    for i in tqdm(tabela):
        nome = str(i)
        df = pd.read_csv(f"{nome}.csv")
        df.to_sql(f"{nome}", engine, if_exists="replace", index=False)
        
tabela = ["customers","products","sales"]

createdb(tabela)

# %%

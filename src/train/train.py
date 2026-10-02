#%%
import pandas as pd
import sqlalchemy

from sklearn import model_selection



#%%
con = sqlalchemy.create_engine('sqlite:///../../data/abt.db')
df = pd.read_sql('abt', con)
df.head()


# %%
# SAMPLE
df_oot = df[df['DtRef'] == df['DtRef'].max()]
df_oot.head()

target = 'churn'
features = df.drop(columns=target).columns.tolist()

df_train_test = df[df['DtRef'] < df['DtRef'].max()]

y = df_train_test[target]
X = df_train_test.drop(columns = target)
X.head()

#%%

X_train, X_test, y_train, y_test = model_selection.train_test_split(X,
                                                                    y,
                                                                    test_size=0.2,
                                                                    random_state=42,
                                                                    stratify=y)

print('Base de Treino:', f'{y_train.mean():.3f}')
print('Base de Test:', f'{y_test.mean():.3f}')

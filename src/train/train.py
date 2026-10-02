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
features = df.columns.tolist()[2:]
features.remove(target)

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

#%%
# EXPLORER

s_nas = X_train.isna().mean()
s_nas = s_nas[s_nas>0]
s_nas

#%%

# EXPLORER - Bivariada

cat_features = ['FavPeriod','FavoriteCategory','FavoriteBrand']
num_features = list(set(features) - set(cat_features))

df_train = X_train.copy()
df_train[target] = y_train.copy()
df_train[num_features] = df_train[num_features].astype(float)
# %%
bivariada = df_train.groupby(target)[num_features].median().T
bivariada['ratio'] = (bivariada[1]+0.001)/(bivariada[0] + 0.001)
bivariada = bivariada.sort_values(by = 'ratio', ascending = False)
bivariada

#%%
df_train.groupby(cat_features[0])[target].mean().T
#%%
df_train.groupby(cat_features[1])[target].mean().T

#%%
df_train.groupby(cat_features[2])[target].mean().T
# %%

# MODIFY

#!/usr/bin/env python
# coding: utf-8

# In[102]:


import numpy as np
import pandas as pd
import random 
import datetime
import math


# In[103]:


n=10000
filename="cube"


# In[104]:


def users(n):
    data = pd.DataFrame({'user_id':[1], 'date_of_birth':"15/08/2000",'gender':["male"]})
    for i in range(n-1):
        while True:
            x=math.floor(np.random.normal(1992,20))
            if x<=2012 and x>=1940:
                break
        data.loc[len(data.index)] = [int(i+2),datetime.datetime(x,random.randint(1,12), random.randint(1,28)).strftime("%d/%m/%Y"),random.choice(["male", "female", "other"])]
    data=data.set_index("user_id")
    data.to_csv("users.csv")


# In[105]:


def join(filename):
    data=pd.read_csv(f"{filename}.csv")
    x=len(data)
    column=[0 for i in range(x)]
    for i in range(x):
        column[i]=random.randint(1,n)
    data["user_id"]=column
    data.to_csv(f"{filename}.csv")
    


# In[106]:


users(n)
join(filename)


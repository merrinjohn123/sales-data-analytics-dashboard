
import pandas as pd
import random
from faker import Faker
def get_random_date():
    year= random.randint(2022,2025)
    month= random.randint(1,12)
    day= random.randint(1,28)
    return f"{year}-{month:02d}-{day:02d}"
items=["Shampoo","Laptop","Phone","Book","Bag","Watch","Spray","Spectacles","Medicine","Pen","Bottle"]
adjectives=["Red", "Blue", "Small", "Large", "Ergonomic", "Portable"]
cities_data=[ ("Ney York","NY","USA"),
              ("Los Angeles", "CA", "USA"),
    ("Chicago", "IL", "USA"),
    ("Mumbai", "MH", "India"),
    ("Delhi", "DL", "India"),
    ("Bangalore", "KA", "India"),
    ("London", "England", "UK"),
    ("Toronto", "Ontario", "Canada"),
    ("Sydney", "NSW", "Australia")]
product_lists=[]
fake = Faker()
for i in  range(100):
    name=random.choice(adjectives) + ' ' + random.choice(items)
    product = { "product_id" : f"P{i}",
    "name" : name,
    "category" : "General",
    "unit_price" : round(random.uniform(10,500),2) }
    product_lists.append(product)
#print(product_lists)
df=pd.DataFrame(product_lists)
print("The dataframe is",df)
df.to_csv('products.csv',index=False)
print("Products csv file is created")
customer_lists=[]
for i in range(200):
    city, state, country = random.choice(cities_data)
    customer={ "customer_id" : f"C{i+1}" ,
               "name" : fake.name(),
               "city" : city,
               "state" : state,
               "country" : country,
               "signup_date" : get_random_date()
               }
    customer_lists.append(customer)
dfcust=pd.DataFrame(customer_lists)
print("Dataframe is",dfcust)
dfcust.to_csv('customers.csv',index=False)
print("Customers csv file is created")
order_list=[]
custidlist=[f"C{i+1}" for i in range(200)]
prdtlist=[f"P{i}" for i in range(100)]
for i in range(2000):
    order={
        "order_id" : f"O{i+1}",
        "customer_id" : random.choice(custidlist),
        "order_date" : get_random_date(),
        "order_status" : random.choice(["Pending", "Shipped", "Delivered", "Cancelled"])
    }
    order_list.append(order)
dforder=pd.DataFrame(order_list)
print("Dataframe is ",dforder)
dforder.to_csv('orders_list.csv',index=False)
print("Orders list csv is created")
order_items=[]
order_item_id = 1
for orders in order_list :
    num_items = random.randint(1,5)
    chosen_item = random.sample(prdtlist,num_items)
    for pdt in chosen_item :
        quantity = random.randint(1,10)
        unit_price = round(random.uniform(10, 500), 2)
        line_amount = round(quantity * unit_price, 2)
        item = {
            "order_item_id" : order_item_id,
            "order_id" : orders["order_id"],
            "product_id" : pdt,
            "quantity" : quantity,
            "unit_price" : unit_price,
            "line_amount" : line_amount
        }
        order_items.append(item)
        order_item_id += 1
dfoitem=pd.DataFrame(order_items)
print("Dataframe is ",dfoitem)
dfoitem.to_csv('orders_item_list.csv',index=False)
print("Orders_items list csv is created")

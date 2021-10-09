from typing import List
from databases import Database
import sqlalchemy
from fastapi import FastAPI, status
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import os
import urllib
import asyncio

app = FastAPI()


@app.get("/")
def read_root():
    asyncio.run(db_test())
    return {"Hello": "Worl"}

async def db_test():
    # DB TEST
    DATABASE_URL = 'postgresql://{}:{}@{}:{}/{}?sslmode={}'.format('user1','password', 'db', '5432','app','prefer')
    database = Database(DATABASE_URL)
    await database.connect()

    # Create a table.
    query = """CREATE TABLE HighScores (id INTEGER PRIMARY KEY, name VARCHAR(100), score INTEGER)"""
    await database.execute(query=query)

    # Insert some data.
    query = "INSERT INTO HighScores(id, name, score) VALUES (:id, :name, :score)"
    values = [
        {"id":1,"name": "Daisy", "score": 92},
        {"id":2,"name": "Neil", "score": 87},
        {"id":3,"name": "Carol", "score": 43},
    ]
    await database.execute_many(query=query, values=values)

    # Run a database query.
    query = "SELECT * FROM HighScores"
    rows = await database.fetch_all(query=query)
    print('High Scores:', rows)
    

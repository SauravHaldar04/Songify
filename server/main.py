
from fastapi import FastAPI
from sqlalchemy import create_engine
from routes import auth;
from models.base import Base
from database import engine
app = FastAPI()

app.include_router(auth.router,prefix="/auth")

Base.metadata.create_all(engine)

from fastapi import HTTPException
import uuid
import bcrypt
from models.user import User
from pydantic_schemas.user_login import UserLogin
from pydantic_schemas.user_schema import UserCreate
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database import get_db

router = APIRouter()

@router.post("/signup",status_code=201)
def signupuser(user:UserCreate,db:Session=Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()
    if user_db:
        raise HTTPException(400,"Email already registered")
    hashed_pw = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())
    user_db = User(name=user.name,email=user.email,password=hashed_pw,id=str(uuid.uuid4()))
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
    return user_db

@router.post("/login")
def login_user(user:UserLogin,db:Session = Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()
    if not user_db:
        raise HTTPException(400,"User with the given email does not exist")
    is_match = bcrypt.checkpw(user.password.encode(),user_db.password)

    if not is_match:
        raise HTTPException(400,"Incorrect password")
    return user_db
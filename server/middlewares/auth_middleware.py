from fastapi import HTTPException, Header
import jwt
import os


def auth_middleware(x_auth_token=Header()):
    try:
        if not x_auth_token:
            raise HTTPException(401,"Access denied, token required")
        verified_token = jwt.decode(x_auth_token,os.getenv("PASSWORD_SALT"),algorithms=["HS256"])
        if not verified_token:
            raise HTTPException(401,"Invalid token , verification failed")
        uid = verified_token.get("id")
    except:
        raise HTTPException(401,"Invalid token")
    return {"uid":uid , "token":x_auth_token}
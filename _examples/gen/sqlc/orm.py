# Code generated by sqlc. DO NOT EDIT.
# versions:
#   sqlc v1.20.0
import sqlalchemy
from typing import Optional


class Base(sqlalchemy.orm.DeclarativeBase):
    pass


class Author(hello.Base):
    id: int
    name: str
    age: int
    bio: Optional[str]
    is_active: bool

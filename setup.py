#bring in sqlite3
import sqlite3

#set up database, connect, and add cursor
conn = sqlite3.connect('chat-sprint-challenge.db')
c = conn.cursor()

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-CREATE TABLES FUNCTIONS-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

def create_organization_table():
    c.execute("""CREATE TABLE organization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
)""")
conn.commit()

def create_channel_table():
    c.execute("""CREATE TABLE channel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128),
    org_id INTEGER REFERENCES organization(id)
)""")
conn.commit()

def create_user_table():
    c.execute("""CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128)
)""")
conn.commit()

def create_message_table():
    c.execute("""CREATE TABLE missage (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content TEXT,
    post_time TIMESTAMP NOT NULL DEFAULT(DATETIME()),
    user_id INTEGER REFERENCES user(id),
    channel_id INTEGER REFERENCES channel(id)
)""")
conn.commit()

conn.close()
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

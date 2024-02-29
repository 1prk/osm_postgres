from geoalchemy2 import Geometry
from sqlalchemy import create_engine, Column, func
from sqlalchemy.orm import sessionmaker, scoped_session
from sqlalchemy.types import Integer, BigInteger, String
from sqlalchemy.ext.declarative import declarative_base
import geopandas as gpd

Base = declarative_base()

# hier die user credentials ersetzen
username = 'USERNAME'
password = 'PASSWORD'
host = 'HOST_IP'
port = 'PORT'
db = 'DB'

class PlanetOsmLine(Base):
    __tablename__ = 'planet_osm_line'

    # hier werden die spalten aus der datenbank deklariert, gerne können mehr verwendet werden.
    # das schema ist: spaltenname = Column(datentyp)
    osm_id = Column(BigInteger, primary_key=True)
    highway = Column(String)
    way = Column(Geometry('LINESTRING'))

engine = create_engine('postgresql://{}:{}@{}:{}/{}'.format{username, password, host, port, db},
                    echo=True, pool_recycle=1800, client_encoding='utf8')

Session = scoped_session(sessionmaker(bind=engine))
s = Session()

try:
    Session = scoped_session(sessionmaker(bind=engine))
    s = Session()
    osm_lines = s.query(PlanetOsmLine.osm_id,
                        PlanetOsmLine.highway,
                        func.St_AsText(PlanetOsmLine.way).label('way_wkt'))
                        ).
                        filter(PlanetOsmLine.highway.isnot(None)).
                        all()

except Exception as e:
    print(f"Error occurred: {e}")
    s.rollback()  
finally:
    s.close()

highway_lines = []
for line in osm_lines:
    highway_lines.append({'osm_id': line.osm_id, 'highway': line.highway, 'geometry': line.way_wkt})

highway_lines = gpd.GeoDataFrame(highway_lines)

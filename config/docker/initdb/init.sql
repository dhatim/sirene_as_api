
CREATE DATABASE sirene_as_api_docker_production WITH OWNER sirene_etalab;

\c sirene_as_api_docker_production;
CREATE EXTENSION pg_trgm;

\c sirene_as_api_docker_development;
CREATE EXTENSION pg_trgm;

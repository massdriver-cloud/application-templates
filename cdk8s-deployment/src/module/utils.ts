import { readFileSync } from 'fs';
import { join } from 'path';

const PARAMS_FILE = '_params.auto.json';
const CONNECTIONS_FILE = '_connections.auto.json';
const METADATA_FILE = '_md_metadata.auto.json';

function syncReadFile(filename: string) {
  const stepDir = process.cwd();
  const result = readFileSync(join(stepDir, filename), 'utf-8');
  return result;
}

function getParams() {
  return JSON.parse(syncReadFile(PARAMS_FILE));
}

function getConnections() {
  return JSON.parse(syncReadFile(CONNECTIONS_FILE));
}

function getMetadata() {
  return JSON.parse(syncReadFile(METADATA_FILE));
}

export {
  getParams,
  getConnections,
  getMetadata,
};

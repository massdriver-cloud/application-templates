import { readFileSync } from 'fs';
import { join } from 'path';

const PARAMS_FILE = '_params_variables.json';
const CONNECTIONS_FILE = '_params_connections.json';

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


export {
  getParams,
  getConnections,
};

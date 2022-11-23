import { readFileSync } from 'fs';
import { join } from 'path';
import YAML from 'yaml';
import {
  CONNECTIONS_FILE, MASSDRIVER_FILE, METADATA_FILE, PARAMS_FILE
} from './contants';

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

function getMassdriverYAML() {
  return YAML.parse(syncReadFile(MASSDRIVER_FILE));
}

export {
  getMassdriverYAML,
  getParams,
  getConnections,
  getMetadata,
};

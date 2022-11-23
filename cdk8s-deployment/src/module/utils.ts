import { readFileSync, writeFileSync } from 'fs';
import { join } from 'path';
import YAML from 'yaml';
import {
  CONNECTIONS_FILE, MASSDRIVER_FILE, METADATA_FILE, PARAMS_FILE
} from './contants';

function syncReadFile(filename: string) {
  const stepDir = process.cwd();
  return readFileSync(join(stepDir, filename), 'utf-8');
}

function syncWriteFile(filename: string, data: any) {
  const stepDir = process.cwd();
  return writeFileSync(join(stepDir, filename), data);
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
// TODO: make artifact type
// TODO: generate from json schema?
function writeArtifact(data: any) {
  return syncWriteFile('artifact.json', data);
}

export {
  getMassdriverYAML,
  getParams,
  getConnections,
  getMetadata,
  writeArtifact,
};

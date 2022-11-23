import { getConnections, getMassdriverYAML } from "./utils";
const jq = require('node-jq')

function getEnvs() {
  const massdriverYAML = getMassdriverYAML();
  const connections = getConnections();
  const appEnvs = massdriverYAML.app.envs

  const options = {
    input: 'json',
  }
  const envs = new Map<string, string[]>();

  appEnvs.forEach((value: string, key: string) => {
    const envKey = key;
    const filter = value;
    jq.run(filter, connections, options)
      .then((output: any) => {
        envs.set(envKey, output);
      })
  })

  return envs
}

export {
  getEnvs,
};

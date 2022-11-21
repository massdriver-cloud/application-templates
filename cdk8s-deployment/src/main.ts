import { App, Chart, ChartProps } from 'cdk8s';
import { Construct } from 'constructs';
import { readFileSync } from 'fs';
import { join } from 'path';
import { IntOrString, KubeService } from './imports/k8s';

function syncReadFile(filename: string) {
  const result = readFileSync(join(__dirname, filename), 'utf-8');

  console.log(result); // 👉️ "hello world hello world ..."

  return result;
}


export class MyChart extends Chart {
  constructor(scope: Construct, id: string, props: ChartProps = { }) {
    super(scope, id, props);

    const params =  JSON.parse(syncReadFile('params.json'));
    console.log(params);

    const label = { app: params['name'] };

    new KubeService(this, 'service', {
      spec: {
        type: 'LoadBalancer',
        ports: [ { port: 80, targetPort: IntOrString.fromNumber(8080) } ],
        selector: label
      }
    });

  }
}

const app = new App();
new MyChart(app, 'cdk8s');

// generate the yaml
app.synth();





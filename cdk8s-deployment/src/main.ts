import { App, Chart, ChartProps } from 'cdk8s';
import { Construct } from 'constructs';
import { getApplicationStack, writeArtifact } from './module';

export class MyChart extends Chart {
  constructor(scope: Construct, id: string, props: ChartProps = { }) {
    super(scope, id, props);
    getApplicationStack(this);
    writeArtifact({
      name: 'cdk8s',
      artifact: {
        data: {
          infrastructure: {},
          security: {},
        }
      }
    })
  }
}

const app = new App();
new MyChart(app, 'cdk8s');

// this line is required
app.synth();


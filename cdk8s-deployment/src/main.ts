import { App, Chart, ChartProps } from 'cdk8s';
import { Construct } from 'constructs';
import { getApplicationStack } from './module';

export class MyChart extends Chart {
  constructor(scope: Construct, id: string, props: ChartProps = { }) {
    super(scope, id, props);
    getApplicationStack(this);
  }
}

const app = new App();
new MyChart(app, 'cdk8s');

// this line is required
app.synth();


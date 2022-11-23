import { App, Chart, ChartProps } from 'cdk8s';
import { Construct } from 'constructs';
import { getDeployment } from './module/deployment';
import { getConnections, getParams } from './module/utils';

export class MyChart extends Chart {
  constructor(scope: Construct, id: string, props: ChartProps = { }) {
    super(scope, id, props);

    const params =  getParams();

    getConnections();

    const label = { app: params['name'] };
    const options = {
      label,
    }
    getDeployment(this, options);
  }
}

const app = new App();
new MyChart(app, 'cdk8s');

// generate the yaml
app.synth();





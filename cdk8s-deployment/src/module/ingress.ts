import { IntOrString, KubeService } from '../imports/k8s';

const getIngress = function(thisChart: any, opts: any) {
  return new KubeService(thisChart, 'service', {
    metadata: {
      name: opts['name'] || 'no-name',
    },
  spec: {
    type: 'LoadBalancer',
    ports: [ { port: 80, targetPort: IntOrString.fromNumber(8080) } ],
    // selector: 'label'
  }
});
}

export {
  getIngress,
};

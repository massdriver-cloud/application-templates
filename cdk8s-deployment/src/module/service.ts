import { IntOrString, KubeService } from '../imports/k8s';

const getService = function(thisChart: any) {
  return new KubeService(thisChart, 'service', {
  spec: {
    type: 'LoadBalancer',
    ports: [ { port: 80, targetPort: IntOrString.fromNumber(8080) } ],
    // selector: 'label'
  }
});
}

export {
  getService,
};

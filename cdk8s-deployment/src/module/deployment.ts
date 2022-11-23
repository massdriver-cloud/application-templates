import { KubeDeployment } from '../imports/k8s';

const getDeployment = function(thisChart: any, opts: any) {
  return new KubeDeployment(thisChart, 'deployment', {
    metadata: {
      name: opts['name'] || 'deployment',
    },
  spec: {
    selector: {
      matchLabels: {
        "app.kubernetes.io/name": opts['name'] || 'deployment',
      },
    },
    template: {
      metadata: {
        labels: {
          app: opts['name'] || 'deployment',
        },
      },
      spec: {
        containers: [
          {
            image: opts['image'] || 'nginx',
            name: opts['name'] || 'deployment',
          }
        ]
      }
    }
  }
});
}

export {
  getDeployment,
};

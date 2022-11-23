import { KubeDeployment } from '../imports/k8s';
import { getEnvs } from './envs';

const getDeployment = function(thisChart: any, opts: any) {
  const envs = getEnvs();

  return new KubeDeployment(thisChart, 'deployment', {
    metadata: {
      name: opts['name'] || 'no-name',
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
            environment: envs,
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

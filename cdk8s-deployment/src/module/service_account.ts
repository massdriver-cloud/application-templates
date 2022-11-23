import { KubeServiceAccount } from '../imports/k8s';

const getServiceAccount = function(thisChart: any, opts: any) {
  return new KubeServiceAccount(thisChart, 'service', {
    metadata: {
      name: opts['name'] || 'no-name',
    },
});
}

export {
  getServiceAccount,
};

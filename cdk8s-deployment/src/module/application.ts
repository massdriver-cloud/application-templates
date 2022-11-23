import { getDeployment } from "./deployment";
import { getIngress } from "./ingress";
import { getService } from "./service";
import { getServiceAccount } from "./service_account";
import { getParams } from "./utils";

const getApplicationStack = function(thisChart: any) {
  const params =  getParams();
  const label = { app: params['name'] };
  const options = {
    name: params['name'],
    image: params['image'],
    label,
  }

  getDeployment(thisChart, options);
  getServiceAccount(thisChart, options);
  if (params['endpoint']) {
    getService(thisChart, options);
    getIngress(thisChart, options);
  }
}

export {
  getApplicationStack,
};


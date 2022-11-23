import { getDeployment } from "./deployment";
import { getIngress } from "./ingress";
import { getService } from "./service";
import { getServiceAccount } from "./service_account";
import { getMetadata, getParams } from "./utils";

const getApplicationStack = function(thisChart: any) {
  const params =  getParams();
  const metadata  = getMetadata();
  const label = { app: params['name'] };
  const options = {
    name: metadata.name_prefix,
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


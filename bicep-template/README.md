[![Massdriver][logo]][website]

# {{name}}

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]

{{description}}

---

## Design

For detailed information, check out our [Operator Guide](operator.md) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle

<!-- COMPLIANCE:START -->

Security and compliance scanning of our bundles is performed using [Bridgecrew](https://www.bridgecrew.cloud/). Massdriver also offers security and compliance scanning of operational infrastructure configured and deployed using the platform.

| Benchmark                                                                                                                                                                                                                                                       | Description                        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------- |
| [![Infrastructure Security](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/{{name}}/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo={{repoNameEncoded}}&benchmark=INFRASTRUCTURE+SECURITY) | Infrastructure Security Compliance |
{% if cloudPrefix == "k8s" -%}
| [![CIS KUBERNETES](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/{{name}}/cis_kubernetes>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo={{repoNameEncoded}}&benchmark=CIS+KUBERNETES+V1.5) | Center for Internet Security, KUBERNETES Compliance |
{% elsif cloudPrefix == "aws" -%}
| [![CIS AWS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/{{name}}/cis_aws>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo={{repoNameEncoded}}&benchmark=CIS+AWS+V1.2) | Center for Internet Security, AWS Compliance |
{% elsif cloudPrefix == "azure" -%}
| [![CIS AZURE](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/{{name}}/cis_azure>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo={{repoNameEncoded}}&benchmark=CIS+AZURE+V1.1) | Center for Internet Security, AZURE Compliance |
{% elsif cloudPrefix == "gcp" -%}
| [![CIS GCP](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/{{name}}/cis_gcp>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo={{repoNameEncoded}}&benchmark=CIS+GCP+V1.1) | Center for Internet Security, GCP Compliance |
{% endif %}
| [![PCI-DSS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/{{name}}/pci>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo={{repoNameEncoded}}&benchmark=PCI-DSS+V3.2) | Payment Card Industry Data Security Standards Compliance |
| [![NIST-800-53](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/{{name}}/nist>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo={{repoNameEncoded}}&benchmark=NIST-800-53) | National Institute of Standards and Technology Compliance |
| [![ISO27001](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/{{name}}/iso>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo={{repoNameEncoded}}&benchmark=ISO27001) | Information Security Management System, ISO/IEC 27001 Compliance |
| [![SOC2](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/{{name}}/soc2>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo={{repoNameEncoded}}&benchmark=SOC2)| Service Organization Control 2 Compliance |
| [![HIPAA](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/{{name}}/hipaa>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo={{repoNameEncoded}}&benchmark=HIPAA) | Health Insurance Portability and Accountability Compliance |

<!-- COMPLIANCE:END -->

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->

**Params coming soon**

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->

**Connections coming soon**

<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->

**Artifacts coming soon**

<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/{{name}}/issues>) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]


<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg

[docs]: https://docs.massdriver.cloud?utm_source={{name}}&utm_medium={{name}}&utm_campaign={{name}}&utm_content={{name}}
[website]: https://www.massdriver.cloud?utm_source={{name}}&utm_medium={{name}}&utm_campaign={{name}}&utm_content={{name}}
[github]: https://github.com/massdriver-cloud
[linkedin]: https://www.linkedin.com/company/massdriver/

[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/{{name}}.svg?style=for-the-badge>
[contributors_url]: https://github.com/massdriver-cloud/{{name}}/graphs/contributors>
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/{{name}}.svg?style=for-the-badge>
[forks_url]: https://github.com/massdriver-cloud/{{name}}/network/members>
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/{{name}}.svg?style=for-the-badge>
[stars_url]: https://github.com/massdriver-cloud/{{name}}/stargazers>
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/{{name}}.svg?style=for-the-badge>
[issues_url]: https://github.com/massdriver-cloud/{{name}}/issues>
[release_url]: https://github.com/massdriver-cloud/{{name}}/releases/latest>
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/{{name}}.svg?style=for-the-badge>
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/{{name}}.svg?style=for-the-badge>
[license_url]: https://github.com/massdriver-cloud/{{name}}/blob/main/LICENSE>

[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2
[twitter_url]: https://twitter.com/massdriver
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->

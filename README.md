<img src="/assets/logos/full.png" alt="team spiral racing logo" width="400"/>
<a href="https://github.com/Team-Spiral-Racing/blog/releases"><img src="https://img.shields.io/github/v/release/Team-Spiral-Racing/blog?color=f56827"></a>
<a href="https://github.com/Team-Spiral-Racing/blog/blob/main/LICENSE"><img src="https://img.shields.io/github/license/Team-Spiral-Racing/blog"></a>

# Team Spiral Racing Blog
This repository contains the files to build the blog website. This website is built via [Hugo](https://gohugo.io/) using the [Blowfish](https://blowfish.page/) theme. Blog files are published via the [Team Spiral Racing Website](www.teamspiralracing.com/) and CMS is managed by the [TSR Data Service](https://github.com/Team-Spiral-Racing/data-service). This website is deployed using GitHub pages.

## Running Locally
1. Clone the repo
2. Install Huge ([Instructions](https://gohugo.io/installation/))
3. Install Blowfish tools ([Instructions](https://blowfish.page/docs/installation/#blowfish-tools-recommended))
4. Run `hugo server` and navigate to http://localhost:1313/

## Deployment Strategy
Currently the website is build via a GitHub action and deployed to the `gh-pages` branch where it is served. The `CNAME` is hard coded and directly injected during the build process. CMS and content is managed by the aformention TSR Data Service which uploads the markdown content into this Git repository.

However, an alternative exists in the form of a Docker image. These [images](https://github.com/orgs/Team-Spiral-Racing/packages?repo_name=blog) are built upon [releases](https://github.com/Team-Spiral-Racing/blog/releases). Releases are kicked off by pushing tags and can be done by running the following commands:
```
git tag v*.*.*
git push origin tag v*.*.*
```

## License
This project is licensed under the Creative Commons BY-NC 4.0 License. See `LICENSE` for more information.

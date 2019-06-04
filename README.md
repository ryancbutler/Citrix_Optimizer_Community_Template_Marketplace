[![Build status](https://ci.appveyor.com/api/projects/status/ji7x6c05hnv0ik3o/branch/master?svg=true)](https://ci.appveyor.com/project/ryancbutler/citrix-optimizer-community-template-marketplace/branch/master)

# Citrix Optimizer Community Template Marketplace
Currated list of custom templates created by the Citrix Community that can be added to [Citrix Optimizer](https://support.citrix.com/article/CTX224676). See [Blog Post](https://www.techdrabble.com/citrix/35-citrix-optimizer-community-template-marketplace) for more detail.

## To Use Community Marketplace
NOTE: You must be using **Citrix Optimizer 2.0** or higher

1. Open Citrix Optimizer
2. Select Template Marketplace from left
3. Select "Add New Marketplace" from the bottom left
4. Add the following URL:
**https://raw.githubusercontent.com/ryancbutler/Citrix_Optimizer_Community_Template_Marketplace/master/communitymarketplace.xml**
5. Select Done

## To Submit a template

1. Create a fork of this repo
2. Create a new folder under the *templates* folder reflecting the author of the template
3. Copy any created templates to this new folder
4. (Optional) Add a README.md to your author folder if desired with anything you desire
5. Commit and push any changes to your fork (**NO NEED TO EDIT communitymarketplace.xml**)
6. Create Pull Request making sure to fill out the questionaire
7. The following tests will be run and must pass in order to be approved
    - Author of the template file must match directory name
    - Template display name must be unique for all templates
    - Template ID must be unique for all templates
    - lastupdatedate date format should be **M/DD/YYYY**

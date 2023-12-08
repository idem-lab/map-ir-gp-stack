
# map-ir-gp-stack

<!-- badges: start -->
<!-- badges: end -->

The goal of map-ir-gp-stack is to tidy up the original code from https://github.com/pahanc/Mapping-insecticide-resistance into a pipeline of sorts so we can reuse it.

I've rearranged the repository to help me with this process.

I will write down notes here to discuss the overall restructuring and reasons why.

- `GP meta-model` has been renamed `gp-meta-model` to avoid spaced and ahve consistent lowercase.
- put all analysis code into an `analysis` directory. This is to help separate out the inputs and outputs, and also so this README file is the first one the user sees. Mostly cosmetic.
- There is some really nice `demo` code inside each of the models, which run in a short time period. These are being moved into `demo` directory:

```
analysis
|- README.md
|- bgam/
|- rf/
|- xgb/
|- gp-meta-model/
|- demo/
  |- bgam/
  |- rf/
  |- xgb/
  |- gp-meta-model/


```

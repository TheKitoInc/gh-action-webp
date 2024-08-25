# gh-action-webp

Create webp images from jpg and png images

## Example usage

```yaml
name: Create webp images
on:
  push:
    branches:
      - master

jobs:
  GH-ACTION-WEBP:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Create webp images
        uses: TheKitoInc/gh-action-webp@master
        with:
          image_extensions: "jpg jpeg png"
```

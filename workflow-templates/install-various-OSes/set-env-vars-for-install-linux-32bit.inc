env:
  GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  GH_REPOSITORY: ${{ github.repository }}
  AUTOMATED_TESTING: 1
  PERL_MM_USE_DEFAULT: 1

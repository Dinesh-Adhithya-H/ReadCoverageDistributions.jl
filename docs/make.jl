using Documenter
using ReadCoverageDistributions

makedocs(
    sitename = "ReadCoverageDistributions",
    format = Documenter.HTML(prettyurls = true),
    modules = [ReadCoverageDistributions]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com:Dinesh-Adhithya-H/ReadCoverageDistributions.jl.git"
)

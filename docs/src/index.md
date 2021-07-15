# ReadCoverageDistributions.jl

Upon simulation of reads onto a reference genome , regions of various coverages are obtained. The insertion of reads is thought to be a completely random processs. 


<img width="581" alt="Screen Shot 2020-10-20 at 10 58 39 AM" src="https://user-images.githubusercontent.com/68704516/125725854-0ad6a382-f8e3-49f4-8bad-7bd700e24092.png">

## Usage

### ReadCoverageDistributions.simulate_readcoverage()
The length of regions belonging to a particular coverage can be plotted as a histogram. By default histogram arrays for regions of coverage 0,1 and 2 can be obtained using the function. 

### ReadCoverageDistributions.plot_readcoverage_simulation()
The result of the simulation along with coverage number when passes through the function will give a plot of the histogram corresponding to that coverage.

### ReadCoverageDistributions.simulate_oceansislands()
Instead of considering regions of coverage 0,1,2,3,4,.... . we reduce the problem to oceans(regions with no reads ie. zero coverages) and islands(regions with reads obove ie.non- zero coverages). The function returns histogram for regions of coverage 0 and non-zero.

### ReadCoverageDistributions.plot_oceansislands_simulation()
The result of the simulation along with coverage number(either 0 or 1) when passes through the function will give a plot of the histogram corresponding to that coverage.0 can be considered as ocean and 1 as islands.

### ReadCoverageDistributions.avg_length_islands_vs_no_reads_simulation()

### ReadCoverageDistributions.avg_length_oceans_vs_no_reads_simulation()

### ReadCoverageDistributions.no_islands_vs_no_reads_simulation()
### ReadCoverageDistributions.no_oceans_vs_no_reads_simulation()
### ReadCoverageDistributions.no_reads_vs_no_islands()


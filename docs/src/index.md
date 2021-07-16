# ReadCoverageDistributions.jl

Upon simulation of reads onto a reference genome , regions of various coverages are obtained. The insertion of reads is thought to be a completely random processs. 


<img width="581" alt="Screen Shot 2020-10-20 at 10 58 39 AM" src="https://user-images.githubusercontent.com/68704516/125725854-0ad6a382-f8e3-49f4-8bad-7bd700e24092.png">


## Installation

To use the package use the following commands

```julia
using Pkg
Pkg.add("ReadCoverageDistributions")
using ReadCoverageDistributions
```
To run tests on the package use 

```julia
Pkg.test("ReadCoverageDistributions")
```

To know all functions and structures available in the package use

```julia
Pkg.names("ReadCoverageDistributions")
```
To read the documentation use 

```julia
?ReadCoverageDistributions
```

## Usage

```julia
n=100
genome_length=10^7
read_length=100
no_reads=2*10^5
```

### ReadCoverageDistributions.simulate_readcoverage(n::Int,genome_length::Int,read_length::Int,no_reads::Int) returns OffsetArrays.OffsetVector{Vector{Float64}, Vector{Vector{Float64}}} 

The length of regions belonging to a particular coverage can be plotted as a histogram. By default histogram arrays for regions of coverage 0,1 and 2 can be obtained using the function. 

### ReadCoverageDistributions.plot_readcoverage_simulation(hist::OffsetArrays.OffsetVector{Vector{Float64}, Vector{Vector{Float64}}} ,coverage::Int) prints a plot 

The result of the simulation along with coverage number when passes through the function will give a plot of the histogram corresponding to that coverage.

```julia
hist1=ReadCoverageDistributions.simulate_readcoverage(n,genome_length,read_length,no_reads)
ReadCoverageDistributions.plot_readcoverage_simulation(hist1,0)
```
![image](https://user-images.githubusercontent.com/68704516/125935311-79cc2705-27f8-4ffa-9b2d-7cccffecc716.png)



### ReadCoverageDistributions.simulate_oceansislands(n::Int,genome_lengthn::Int,read_lengthn::Int,no_readsn::Int) returns OffsetArrays.OffsetVector{Vector{Float64}, Vector{Vector{Float64}}}

Instead of considering regions of coverage 0,1,2,3,4,.... . we reduce the problem to oceans(regions with no reads ie. zero coverages) and islands(regions with reads obove ie.non- zero coverages). The function returns histogram for regions of coverage 0 and non-zero.

### ReadCoverageDistributions.plot_oceansislands_simulation(hist::OffsetArrays.OffsetVector{Vector{Float64}, Vector{Vector{Float64}}},coverage::Int) prints a plot 

The result of the simulation along with coverage number(either 0 or 1) when passes through the function will give a plot of the histogram corresponding to that coverage.0 can be considered as ocean and 1 as islands.


```julia
hist1=ReadCoverageDistributions.simulate_oceansislands(n,genome_length,read_length,no_reads)
plot_oceansislands_simulation(hist1,1)
```





### ReadCoverageDistributions.avg_length_islands_vs_no_reads_simulation(genome_length::Int,read_length::Int,number_reads::Int,width::Int,n::Int)

This function returns the average length of islands upon increase in no. of reads

### ReadCoverageDistributions.avg_length_oceans_vs_no_reads_simulation(genome_length::Int,read_length::Int,number_reads::Int,width::Int,n::Int)

This function returns the average length of oceans upon increase in no. of reads

### ReadCoverageDistributions.no_islands_vs_no_reads_simulation(genome_length::Int,read_length::Int,number_reads::Int,width::Int,n::Int)

This function returns an array of the no. of islands versus in no. of reads

### ReadCoverageDistributions.no_oceans_vs_no_reads_simulation(genome_length::Int,read_length::Int,number_reads::Int,width::Int,n::Int)

This function returns an array of the no. of oceans versus in no. of reads

### ReadCoverageDistributions.no_reads_vs_no_islands(n::Int,genome_length::Int,read_length::Int,read_number::Int)

Returns an histogram of no. of islands vs no. of reads.


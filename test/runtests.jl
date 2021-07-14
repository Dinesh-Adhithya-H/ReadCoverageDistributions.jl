using OffsetArrays
using ProgressMeter
using PyPlot
using LsqFit
using ReadCoverageDistributions,Test

@testset "ReadCoverageDistributions.jl" begin
n=100
genome_length=10^7
read_length=100
no_reads=2*10^5
hist=ReadCoverageDistributions.simulate_readcoverage(n,genome_length,read_length,no_reads)
ReadCoverageDistributions.plot_readcoverage_simulation(hist,0)
#ReadCoverageDistributions.plot_simulation(hist,1)
#ReadCoverageDistributions.plot_simulation(hist,2)
end

@testset "OceanIslandsDistributions.jl" begin
n=100
genome_length=10^7
read_length=100
no_reads=2*10^5
hist1=ReadCoverageDistributions.simulate_oceansislands(n,genome_length,read_length,no_reads)
#plot(1:no_reads:genome_length,hist1[1],label="oceans")
#plot(1:no_reads:genome_length,hist1[2],label="islands")
#xlabel("length of reads")
#ylabel("no. of regions")
#title("Histogram")
#legend()
end
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

@testset "Histogram Helpers" begin
	# increment!
	h = zeros(Int64, 10)
	@test all(h .== 0) 

	increment!(h, 1)
	@test h[1] == 1

	@test length(h) < 20
	increment!(h, 20)
	@test h[20] == 1
	@test length(h) >= 20
	@test h[19] == 0

	# hist_add!
	h1 = [0, 0, 1]
	h2 = [1, 1, 0, 1, 1]
	h = hist_add!(h1, h2)
	@test length(h) == max(length(h1), length(h2))
	@test all(h .== 1)

	h1 = [0, 0, 1]
	h2 = [1, 1, 0, 1, 1]
	h = hist_add!(h2, h1)
	@test length(h) == max(length(h1), length(h2))
	@test all(h .== 1)
end
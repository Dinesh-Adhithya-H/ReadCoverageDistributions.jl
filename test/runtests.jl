using OffsetArrays
using ProgressMeter
using PyPlot
using LsqFit
using ReadCoverageDistributions,Test

@testset "simulate_readcoverage" begin
n=100
genome_length=10^7
read_length=100
no_reads=2*10^5
hist=ReadCoverageDistributions.simulate_readcoverage(n,genome_length,read_length,no_reads)
@test size(hist1)==(3,)
@test typeof(hist1)==OffsetArrays.OffsetVector{Vector{Float64}, Vector{Vector{Float64}}}
end

@testset "simulate_oceansislands" begin
n=100
genome_length=10^7
read_length=100
no_reads=2*10^5
hist1=ReadCoverageDistributions.simulate_oceansislands(n,genome_length,read_length,no_reads)
sum=0
for j in 0:1
    for i in 1:length(hist1[j])
        sum+=i*hist1[j][i]
    end
end
@test sum==genome_length
@test size(hist1)==(2,)
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
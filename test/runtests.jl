using OffsetArrays
using ProgressMeter
using PyPlot
using LsqFit
using ReadCoverageDistributions,Test

@testset "simulate_readcoverage" begin
n=10
genome_length=10^2
read_length=5
no_reads=1
hist1=ReadCoverageDistributions.simulate_readcoverage(n,genome_length,read_length,no_reads)
@test size(hist1)==(3,)
sum=0
for j in 0:2
    for i in 1:length(hist1[j])
        sum+=i*hist1[j][i]
    end
end
#@test (genome_length*sum-genome_length)<10
end

@testset "simulate_oceansislands" begin
n=100
genome_length=10^7
read_length=100
no_reads=10^5
hist1=ReadCoverageDistributions.simulate_oceansislands(n,genome_length,read_length,no_reads)
sum=0
for j in 0:1
    for i in 1:length(hist1[j])
        sum+=i*hist1[j][i]
    end
end
@test (genome_length-sum)<5000
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
    
    #vec_hist_add!
    @test vec_hist_add!([[1.0,3.0]],[[2.0,4.0]])==[[3.0, 7.0]]
    @test vec_hist_add!([[1.0,3.0]],[[2.0,4.0,5.0]])==[[3.0, 7.0, 5.0]]
end

@testset "IslandIterator discrete version" begin
    starts = [3, 5, 9, 40]
    length_read = 2
    @test collect(IslandIterator(starts, length_read)) == [(2, 4), (1, 2), (1, 2)]
    
    length_read = 3
    @test collect(IslandIterator(starts, length_read)) == [(2, 5), (1, 3), (1, 3)]
    
    length_read = 5
    @test collect(IslandIterator(starts, length_read)) == [(3, 11), (1, 5)]

    starts = [3, 5, 9, 40, 40]
    length_read = 2
    @test collect(IslandIterator(starts, length_read)) == [(2, 4), (1, 2), (2, 2)]

    starts = [3, 5, 9, 40, 41]
    length_read = 2
    @test collect(IslandIterator(starts, length_read)) == [(2, 4), (1, 2), (2, 3)]
end

@testset "IslandIterator continious version" begin
    starts = [3.0, 5.0, 9.0, 40.0] 
    length_read = 3.0
    @test collect(IslandIterator(starts, length_read)) == [(2, 5.0), (1, 3.0), (1, 3.0)] 

    length_read = 2.0
    @test collect(IslandIterator(starts, length_read)) == [(2, 4.0), (1, 2.0), (1, 2.0)] 

    starts = [3.0, 5.0, 9.0, 40.0] .+ 0.5
    length_read = 3.0
    @test collect(IslandIterator(starts, length_read)) == [(2, 5.0), (1, 3.0), (1, 3.0)] 
    
    starts = [3.0, 5.0 + 0.000001, 9.0, 40.0] 
    length_read = 2.0
    @test collect(IslandIterator(starts, length_read)) == 
        [(1, 2.0), (1, 2.0), (1, 2.0), (1, 2.0)] 
end
	
@testset "Merge_sort" begin
    s = 1:0.000001:10000000
    L = 100000
    x = sort(rand(s, L))
    y = sort(rand(s, L))
    @test length(merge_sorted_arrays(x,y)) == length(x) + length(y)
    @test merge_sorted_arrays(x,y)  == sort(vcat(x,y))

    s = 1:10
    L = 10
    x = sort(rand(s, L))
    y = sort(rand(s, 2*L))
    @test length(merge_sorted_arrays(x,y)) == length(x) + length(y)
    @test merge_sorted_arrays(x,y)  == sort(vcat(x,y))
end

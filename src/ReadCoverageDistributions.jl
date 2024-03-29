module ReadCoverageDistributions

include("IslandIterator.jl")
include("HistogramReadCoverages.jl")
include("OceanIslandsDistributions.jl")
include("merge_sort.jl")
include("count_islands_and_append_to_array.jl")

export simulate_and_get_coverage_hist_2,
	simulate_oceansislands,
	no_islands_vs_no_reads_simulation,
	no_oceans_vs_no_reads_simulation,
	avg_length_oceans_vs_no_reads_simulation,
	avg_length_islands_vs_no_reads_simulation,
	simulate_and_get_coverage_hist_3,
	no_reads_vs_no_islands,simulate_readcoverage,
	Para,
	increment!,
	hist_add!,vec_hist_add!,
	simulate_and_get_coverage_hist,
	IslandIterator,
	merge_sorted_arrays


end

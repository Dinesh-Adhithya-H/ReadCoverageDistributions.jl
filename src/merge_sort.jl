function merge_sorted_arrays(x::Vector{T}, y::Vector{T})::Vector{T} where {T}
    x_len=length(x)
    y_len=length(y)
    a,b=1,1
    i = 1
    merged_array=Vector{T}(undef, x_len + y_len)
    @inbounds while (a <= x_len) && (b <= y_len)
        if x[a] < y[b]
            merged_array[i] = x[a]
            a += 1
            i += 1
        else
            merged_array[i] = y[b]
            b += 1
            i += 1
        end
    end
    while a <= x_len
        @inbounds merged_array[i] = x[a]
        a += 1
        i += 1
    end
    while b <= y_len
        @inbounds merged_array[i] = y[b]
        b += 1
        i += 1
    end
    return merged_array
end
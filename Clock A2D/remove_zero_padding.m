function O = remove_zero_padding(I, sz)

    O = I(1+sz:size(I,1)-sz,1+sz:size(I,2)-sz);

end
function [lfsr_seq] = LFSR(string_seed, iterations)
  
  seed = string_seed - '0';
  
  % accepting numerical 8-bit seed
  lfsr_seq = zeros(iterations, 1);
  
  % convert lfsr_seq to 8-bit binary vector rather than zeros vector
  lfsr_seq = cellstr(dec2bin(lfsr_seq, 8));
  
  %from binary to double to perform calculations
  for i = 1 : iterations
    lfsr_seq{i} = lfsr_seq{i} - '0'; 
  end
  
  % XORing 1st, 5th, 6th and 7th bits of the seed.
  tempBit = xor(seed(1), seed(5));
  tempBit = xor(tempBit, seed(6));
  tempBit = xor(tempBit, seed(7));
  newBit = tempBit;
  
  
  % discarding the first bit from the left and 
  % adding the newBit resulted from XORing operation to the right
  newByte = [seed(2:8) newBit];
   
  % initializing first element in the sequence
  lfsr_seq{1} = newByte;
  
  % repeating the previous steps to get an array of iterations size
  % with values generated by LFSR.
  for i = 2 : iterations
    % XORing 1st, 5th, 6th and 7th bits of the previous byte.    
    newBit = xor(lfsr_seq{i-1}(1), lfsr_seq{i-1}(5));
    newBit = xor(newBit, lfsr_seq{i-1}(6));
    newBit = xor(newBit, lfsr_seq{i-1}(7));
    
    % discarding the first bit from the left 
    % concatinating the newBit to the right
    newByte = [lfsr_seq{i-1}(2:8) newBit];
    
    % assigning the new byte to the array
    lfsr_seq{i} = newByte;
  end
end 
module main_code(a, b, c, d, F1, F2, F3); 
	input a, b, c, d; 
	output F1, F2, F3; 
	
	wire S1, S2, S3;
	
	and(S1, ~b, d);  
	and(S2, ~a, b, ~d);  
	and(S3, b, c, ~d); 
	
	or(F1, S1, S2, S3);
	
	wire A1, A2, A3;
	
	and(A1, ~c, ~d);
	and(A2, ~b, ~d);
	and(A3, a, ~b, c);
	
	or(F2, A1, A2, A3);
	
	wire B1, B2, B3, B4;
	
	and(B1, ~a, ~b, d);
	and(B2, ~a, b, c);
	and(B3, ~a, c, d);
	and(B4, a, b, ~c, d);
	
	or(F3, A3, B1, B2, B3, B4);
	
endmodule
E = csvread('C:\Users\s152126\Documents\kth\DataMining\spectral_partitioning\example2.dat');
col1 = E(:,1);
col2 = E(:,2);
max_ids = max(max(col1,col2));
As = sparse(col1, col2, 1, max_ids, max_ids);
A = full(As);

%plot sparsity pattern
spy(A);

%{
G = graph(A,'OmitSelfLoops');
L = laplacian(G);
% 2 eigen or 5 as the sparsity patterns shows 4 components
%[V,D] = eigs(L,2,'sm');
[v,D] = eigs(L,5,'sa');
D;
fiedler = V(:,2);
fiedler
sorted_fiedler = sort(fiedler);
plot(sorted_fiedler);
%}

% now we have to compute D, the degree matrix
sumA = sum(A,2);
%form D Degree  matrix
D =diag(sumA);
%Calculate Laplacian
L =D-A;

%select k the number of connected componets. 
%k= 4 for example1.dat. K=1 for example2.dat
k=1;
%get eigen values , eigen vectors
[eigVecs,eigVals] = eig(L);
% print eigenvalues for ke connected componets the first k eigen values
% willl be 0
sort(diag(eigVals))
%selcect (k+1)th eigen vector and plot it to analyze the nature of connected
%componets
eigVec = eigVecs(:,k+1); %if k=1 this would be the fieldler vector.
sorted_vec = sort(eigVec);
figure;
plot(sorted_vec)
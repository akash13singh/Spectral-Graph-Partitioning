%set seed
rng(47,'twister')
%choose K = number of clusters for K-means
%k= 4 for example1.dat. K=2 for example2.dat
K=2;
E = csvread('C:\Users\s152126\Documents\kth\DataMining\spectral_partitioning\example2.dat');
col1 = E(:,1);
col2 = E(:,2);
max_ids = max(max(col1,col2));
As = sparse(col1, col2, 1, max_ids, max_ids);
A = full(As);
names = (1:241);
G = graph(A);
G.Edges;

%plot sparsity pattern
spy(A);

%A(1:2,:);
sumA = sum(A,2);

%form D matrix
D =diag(sumA);
L = (D^(-1/2))*A*(D^(-1/2));

[eigVecsK,eigValsK] = eigs(L,K,'la');
diag(eigValsK)
%[eigVecs,eigVals] = eig(L);

%normalize denominator sqr elements, take rowize sum, & take sqr root.
denom  =(sum( eigVecsK.^2,2)).^(1/2);
%normalize
Y = bsxfun(@rdivide,eigVecsK,denom);

%kmeans clustering
[idx,C] = kmeans(Y,K,'MaxIter',100);
size(idx)
idx;
figure;
h = plot(G);
highlight(h,find(idx==1),'NodeColor','r')
highlight(h,find(idx==2),'NodeColor','g')
highlight(h,find(idx==3),'NodeColor','b')
highlight(h,find(idx==4),'NodeColor','m')


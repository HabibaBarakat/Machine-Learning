clear all
ds = datastore('heart_DD.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
size(T);
Alpha=.01;
lamda=0.001;
m=length(T{:,1});
%some features
U0=T{:,2};
U=T{:,4};
U1=T{:,20:21};
U2=U.^2;

X=[ones(m,1) U U1 U.^2 U.^3]; 

%normalization of x
n=length(X(1,:));
for w=2:n
    if max(abs(X(:,w)))~=0
    X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
    end
end

%normalization of y (scaling)
Y=T{:,3}/mean(T{:,3});

Theta=zeros(n,1);
k=1;
[J,grad]=costFunctionReg(theta,X,Y,lamda);
R=1; %flag
%update theta
while R==1
Alpha=Alpha*1;
Theta=Theta-(Alpha/m)*X'*(X*Theta-Y);
k=k+1;

E(k)=(1/(2*m))*sum((X*Theta-Y).^2);
if E(k-1)-E(k)<0 %break or minimize alpha as the error is becoming bigger
    break
end 
q=(E(k-1)-E(k))./E(k-1);
if q <.000001; %stopping condition as we assume that it is converged
    R=0;
end
end

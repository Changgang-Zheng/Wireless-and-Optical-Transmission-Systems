function mseq = mseries(coefficients)
len=length(coefficients);
L=2^len-1;%�������λ�Ĵ����ĳ���
registers=[zeros(1,len-1),1]; %��ʼ�Ĵ�������
mseq(1)=registers(1);
for i= 2:L
    newregisters(1:len-1) = registers(2:len);
    newregisters(len) = mod(sum(coefficients.*registers),2);
    registers=newregisters;
    mseq(i)=registers(1);
end
mseq(find(mseq>0)) = -1;
mseq(find(mseq>-1)) = 1;
for i=1:L
mseqtemp(i,:)=mseq;
temp=mseq(1);
for j=1:L-1
mseq(j)=mseq(j+1);
end
mseq(L)=temp;
end
mseq=mseqtemp;
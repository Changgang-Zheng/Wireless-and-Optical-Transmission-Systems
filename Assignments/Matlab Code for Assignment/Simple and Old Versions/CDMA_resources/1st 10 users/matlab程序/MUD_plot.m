%��DS-spread spectrumϵͳ��,����Ϊ���Ը�˹������,��ͳ���û����,���Խ���ض��û�������С���������û��������ܱȽ�
clear all
close all
clc;
%prompt={'Enter the numbers of user:','Enter the length of user code:','Enter the power of the user code','Enter the power of Noise'};
%name=['CDMA MUD TEST'];
%line=1;
%defaultanswer={'10','5000','1 2 3 4 5 6 7 8 9 10', '10'};
%glabel=inputdlg(prompt,name,line,defaultanswer);
%num1=str2num(char(glabel(1,1)));
%num2=str2num(char(glabel(2,1)));
%num3=str2num(char(glabel(3,1)));
%num4=str2num(char(glabel(4,1)));
UserNumber=10;%�û���
inflength=5000;%�û���Ϣ���г���
a=[1 1 1 1 1 1 1 1 1 1];  %�û���Ϣ����
Pn=30; %��������
sigma=1;%������׼��
N=31;
R=(ones(UserNumber)+(N-1)*eye(UserNumber))/N; %���ϵ������
b=2*randint(UserNumber,inflength)-1;   %�û���Ϣ����(���+1��-1����)

%******Generate M sequence******************
coefficients=[1 0 1 0 0]; %5������m�����뷢�����ķ���ϵ��
mseq=mseries(coefficients); %����31��31��m���������
mseq=mseq(1:UserNumber,1:N);
%*******************************************



%**********Generate noise*******************
n1=Pn*normrnd(0,1,1,inflength*N);
n=zeros(UserNumber,inflength);
for j=1:inflength
   ntemp=n1(1,((j-1)*N+1):j*N);
   n(:,j)=(mseq*ntemp')/N;
end
%*******************************************

for k=1:1000
    a1=a+a*0.1*k;
    A=diag(a1);
    y=R*A*b+n;  %��ͳ���û����
    ydec=inv(R)*y;   %���Խ���ض��û����
    ymmse=inv(R+sigma^2*inv(A))*y;  %��С���������û����
    ylen=length(find(sign(real(y(1,:)))-b(1,:)));  
    ydeclen=length(find(sign(real(ydec(1,:)))-b(1,:)));
    ymmselen=length(find(sign(real(ymmse(1,:)))-b(1,:)));
    BER_y(1,k)=ylen/inflength;
    BER_ydec(1,k)=ydeclen/inflength;
    BER_ymmse(1,k)=ymmselen/inflength;
    snr(1,k)=20*log10(a1(1)/Pn);
    disp('�������Ϊ');
    disp(ylen);
    disp(ydeclen);
    disp(ymmselen);
    disp('������Ϊ');
    disp( BER_y(1,k));
    disp(BER_ydec(1,k));
    disp(BER_ymmse(1,k));    
end

%***�������ּ�ⷽ����BER-SNR�Ա�ͼ********
plot(snr,BER_y,'r-',snr,BER_ydec,'g:',snr,BER_ymmse,'y-.');
legend('\itƥ���˲���','\it����ؼ��','\it��С���������');
xlabel('�����(dB)'),ylabel('������');
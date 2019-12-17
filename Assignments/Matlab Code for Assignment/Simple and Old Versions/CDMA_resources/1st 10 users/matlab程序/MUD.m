%��DS-spread spectrumϵͳ��,����Ϊ���Ը�˹������,��ͳ���û����,���Խ���ض��û�������С���������û��������ܱȽ�
clear all
close all
clc;
prompt={'Enter the numbers of user:','Enter the length of user code:','Enter the power of the user code','Enter the power of Noise','Enter the kth user which you want to test?'};
name=['CDMA MUD TEST'];
line=1;
defaultanswer={'10','5000','1 2 3 4 5 6 7 8 9 10', '10','1'};
glabel=inputdlg(prompt,name,line,defaultanswer);
num1=str2num(char(glabel(1,1)));
num2=str2num(char(glabel(2,1)));
num3=str2num(char(glabel(3,1)));
num4=str2num(char(glabel(4,1)));
k=str2num(char(glabel(5,1)));
UserNumber=num1;%�û���
inflength=num2;%�û���Ϣ���г���
a=num3;  %�û���Ϣ����
Pn=num4; %��������
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

    A=diag(a);
    y=R*A*b+n;  %��ͳ���û����
    ydec=inv(R)*y;   %���Խ���ض��û����
    ymmse=inv(R+sigma^2*inv(A))*y;  %��С���������û����
   for i=1:UserNumber
    ylen(i)=length(find(sign(real(y(i,:)))-b(i,:)));  
    ydeclen(i)=length(find(sign(real(ydec(i,:)))-b(i,:)));
    ymmselen(i)=length(find(sign(real(ymmse(i,:)))-b(i,:)));
    BER_y(i)=ylen(i)/inflength;
    BER_ydec(i)=ydeclen(i)/inflength;
    BER_ymmse(i)=ymmselen(i)/inflength;
   end
  
    snr=20*log10(a(1)/Pn);
    disp('�����Ϊ');
    disp(snr);
    disp('�������Ϊ');
    disp(ylen(k));
    disp(ydeclen(k));
    disp(ymmselen(k));
    disp('������Ϊ');
    disp( BER_y(k));
    disp(BER_ydec(k));
    disp(BER_ymmse(k)); 


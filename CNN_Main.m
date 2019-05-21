close all;
clear;
load 'C:\Users\HP\Desktop\MNISTData.mat';

margin=3;%�ü�ͼƬ����Χ��Ȧ
X=zeros(28-2*margin,28-2*margin,60000);%X���ڴ洢���ù����ͼƬ����
for i=1:size(X_Train,3)
    X(:,:,i)=X_Train(margin+1:end-margin,margin+1:end-margin,i);
end

W1=randn(9,9,20);%��ʼ��20�������
W2=(2*rand(100,980)-1);
W3=(2*rand(10,100)-1);
dW1=zeros(size(W1));%��Ϊ������ĳ�ʼ0����
dW2=zeros(size(W2));
dW3=zeros(size(W3));

lambda=2e-6;%����ϵ��0.000002

tic%��ʼ��ʱ
for epoch=1:5
    for each=1:6e4
        i=round(unifrnd(1,60000));%iΪ1~6w֮��һ�����ȷֲ����������
        x=X(:,:,i);
        d=D_Train(:,i);
%         flag=rand();
%         if flag>0.9
%             x=Data_Aug(x);
%         end
        [dW1,dW2,dW3]=CNN_BP_Mt(x,d,W1,W2,W3,dW1,dW2,dW3);
        %����Ȩֵ
        W1=W1+dW1-lambda*W1;
        W2=W2+dW2-lambda*W2;
        W3=W3+dW3-lambda*W3;
    end
end
toc%���ѵ��ʱ��

%��ʾ��ȷ��
errors=CNN_Test(W1,W2,W3,X_Test,D_Test,margin);
rate=1-size(errors,2)/size(X_Test,3);
disp(['��ȷ��Ϊ��',num2str(rate)]);

%��ʾ25��ʶ������ͼƬ
for i=1:25
    x=X_Test(:,:,errors(1,i));
    subplot(5,5,i);
    imshow(x);
    text(26,3,num2str(errors(2,i)),'fontsize',20,'horiz','center','color','r');%ʶ����Ĵ����ǩ
    text(26,24,num2str(errors(3,i)),'fontsize',20,'horiz','center','color','r');%��ȷ�ı�ǩ
end

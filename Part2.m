close all;clear;clc;
disp('************* Welcome To General Signal Generator *************');
fprintf('----------------------------------\n');
Fs=input('Enter the Sampling Frequency ( Fs ) : ');
fprintf('----------------------------------\n');
startTime=input('Enter the Start of Time Scale : ');
fprintf('----------------------------------\n');
EndTime=input('Enter the End of Time Scale : ');
fprintf('----------------------------------\n');
breakPoints=input('Enter Number of the Break points : ');
fprintf('----------------------------------\n');
ss=input('Enter the Positions of the Break points : ');
fprintf('----------------------------------\n');
s1=1;
ys=[];
ts=[];

while (Fs<=0)||((breakPoints ~= numel(ss))||(breakPoints<=0)) || (ss(1)<= startTime)  || (ss(1) >= EndTime)||(startTime>EndTime)||(ss(end)<= startTime)||(ss(end) >= EndTime)
    fprintf('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n');
    disp('##The Sampling Frequency must be greater than zero ');
    fprintf('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n');
    disp('##The Numbers And The Positions of Break Points must match the number of the Break points Entered ');
    fprintf('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n');
    disp('##The Number of Break Points must be greater than zero ');
    fprintf('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n');
    disp('##The Positions of Break Points Must be included Between Start Time and End Time ');
    fprintf('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n');
    disp('##Start Time must be less than End Time ,( Please Try Again )');
    fprintf('----------------------------------\n');
    Fs=input('Enter the Sampling Frequency ( Fs ) : ');
    fprintf('----------------------------------\n');
    startTime=input('Enter the Start of Time Scale : ');
    fprintf('----------------------------------\n');
    EndTime=input('Enter the End of Time Scale : ');
    fprintf('----------------------------------\n');
    breakPoints=input('Enter Number of the Break points : ');
    fprintf('----------------------------------\n');
    ss=input('Enter the Positions of the Break points : ');
end
sp=[startTime];
fo=1;
for q=ss
    sp(fo+1)=q;
    fo=fo+1;
end
ss(end+1)=EndTime;
R=0;
while R<breakPoints+1
    disp('------------------------------------------------------------------');
    disp('              ******** Available Signals ********');
    fprintf('1- DC Signal \n2- Ramp Signal \n3- General Order Polynomial \n4- Exponential Signal \n5- Sinusoidal Signal\n');
    fprintf('----------------------------------\n');
    x=input('Enter the Type of the Signal from 1 to 5 : ');
    switch x 
        
        case 1
        endpoint=ss(s1);
        startpoint=sp(s1);
        fprintf('----------------------------------\n');
        DC=input('Enter the Amplitude of DC Signal : ');
        b=[startpoint:endpoint]*0;
        y=b+DC;
        T=[startpoint:endpoint];
    
        
        case 2     
        endpoint=ss(s1);
        startpoint=sp(s1);
        fprintf('----------------------------------\n');
        slope=input('Enter the Slope of Ramp Signal : ');
        fprintf('----------------------------------\n');
        inter=input('Enter the intercept of Ramp Signal : ');
        time=linspace(startpoint,endpoint,(endpoint-startpoint).*Fs);
%         T=time(time>0);
        T=time;
        y=(slope.*T)+inter;
       
       
        case 3       
        endpoint=ss(s1);
        startpoint=sp(s1);
        fprintf('----------------------------------\n');
        amp=input('Enter the Amplitude of General Order Polynomial : ');
        fprintf('----------------------------------\n');
        power=input('Enter the Power of General Order Polynomial : ');
        fprintf('----------------------------------\n');
        inter1=input('Enter the intercept of General Order Polynomial : ');
        T=linspace(startpoint,endpoint,(endpoint-startpoint).*Fs);
        y=0;
        for i = power:-1:1
            coeff=input('Enter the Coefficient : ');
            y=y+(coeff*T.^i);
        end
        y= amp*(y+inter1);
  
        case 4       
        endpoint=ss(s1);
        startpoint=sp(s1);
        fprintf('----------------------------------\n');
        amp=input('Enter the Amplitude of Exponential Signal : ');
        fprintf('----------------------------------\n');
        exp1=input('Enter the Exponent of Exponential Signal : ');
        T=linspace(startpoint,endpoint,(endpoint-startpoint).*Fs);
        y=amp.*exp(exp1.*T);


        case 5       
        endpoint=ss(s1);
        startpoint=sp(s1);
        T=linspace(startpoint,endpoint,(endpoint-startpoint).*Fs);
        fprintf('----------------------------------\n');
        amp=input('Enter the Amplitude of Sinusoidal Signal : ');
        fprintf('----------------------------------\n');
        freq=input('Enter the Frequency of Sinusoidal Signal  : ');
        fprintf('----------------------------------\n');
        phaseShift=input('Enter the Phase Shift of Sinusoidal Signal : ');
        fprintf('----------------------------------\n');
        yShift=input('Enter the Y Shift of Sinusoidal Signal ( DC Offset ): ');
        y=amp.*sin((2*pi*freq.*T)+phaseShift)+yShift;
        
        otherwise 
        fprintf('----------------------------------\n');
        x=input('Enter the Valid Number for Type of the Signal from 1 to 5 : ');
     
    end
    
    ys=[ys y];
    ts=[ts T];
    s1=s1+1;
    R=R+1;
end
figure ;
plot(ts,ys,'LineWidth',2);
title('Signal  ( Before Doing Any Operation ) ');
xlabel('Time'); 
ylabel('Amplitude');
disp('------------------------------------------------------------------');
disp('              ******** Available Operations ********');
fprintf('----------------------------------\n');
fprintf('1- Amplitude Scaling\n2- Time Reversal\n3- Time Shift\n4- Expanding the Signal\n5- Compressing the Signal\n6- NONE\n');
regraph=0;
while regraph ~= 6
    fprintf('----------------------------------\n');
    regraph=input('Enter the Required Operation from ( 1 to 5 ) or Enter ( 6 ) to Stop and Plot the Modified Signal : ');
    switch regraph
        case 1
        fprintf('----------------------------------\n');
        amp=input('Enter the Amplitude Scaling Value : ');
        ys= amp.*ys;
        case 2
        ts=ts.*-1;
        case 3
        fprintf('----------------------------------\n');
        shiftvalue=input('Enter the Shift Value (+ve) for Shift Right (-ve) for Shift Left : ');
        ts=ts+shiftvalue;
        case 4
        fprintf('----------------------------------\n');
        expanding=input('Enter the Expanding Value : ');
        ts=(ts.*expanding);
        case 5
        fprintf('----------------------------------\n');
        compresing=input('Enter the Compressing Value : ');
        ts=(ts./compresing);
        case 6
        fprintf('----------------------------------\n');
        disp('*************************** Thank You ****************************');   
        otherwise
        fprintf('----------------------------------\n');
        regraph=input('Enter the Valid Number of Required Operation from ( 1 to 5 ) or Enter ( 6 ) to Stop and Plot the Modified Signal : ');

    end
end
figure;
plot(ts,ys,'LineWidth',2);
title('Signal  ( After Doing Some Operations ) ');
xlabel('Time'); 
ylabel('Amplitude'); 

        
        
        
    

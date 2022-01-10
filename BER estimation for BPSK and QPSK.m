clc
clear 


SNR_dB=0:1:25;
SNR=10.^(SNR_dB/10);
N=64; 
N_iterations=10^3;
Mod_type='BPSK'; %'BPSK' , 'QPSK' , '16QAM' , '64QAM' , '256QAM'

switch Mod_type
    
    case{'BPSK'}
        Nb=1;
        BPSKMod=comm.PSKModulator(2,'BitInput',true,'PhaseOffset',0);
        BPSKDemod=comm.PSKDemodulator(2,'BitOutput',true,'PhaseOffset',0);
        
    case{'QPSK'}
        Nb=2;
        QPSKMod=comm.PSKModulator(4,'BitInput',true,'PhaseOffset',pi/4);
        QPSKDemod=comm.PSKDemodulator(4,'BitOutput',true,'PhaseOffset',pi/4);
        
    case{'16QAM'}
        Nb=4;
        QAM16Mod=comm.RectangularQAMModulator(16,'BitInput',true,...
            'NormalizationMethod','Average power','SymbolMapping','Gray');
        QAM16Demod=comm.RectangularQAMDemodulator(16,'BitOutput',true,...
            'NormalizationMethod','Average power','SymbolMapping','Gray');     
        
    case{'64QAM'}
        Nb=6;
        QAM64Mod=comm.RectangularQAMModulator(64,'BitInput',true,...
            'NormalizationMethod','Average power','SymbolMapping','Gray');
        QAM64Demod=comm.RectangularQAMDemodulator(64,'BitOutput',true,...
            'NormalizationMethod','Average power','SymbolMapping','Gray');       

    case{'256QAM'}
        Nb=8;
        QAM256Mod=comm.RectangularQAMModulator(256,'BitInput',true,...
            'NormalizationMethod','Average power','SymbolMapping','Gray');
        QAM256Demod=comm.RectangularQAMDemodulator(256,'BitOutput',true,...
            'NormalizationMethod','Average power','SymbolMapping','Gray');   
    
end


for n=1:length(SNR_dB)
    for k=1:N_iterations
        d=round(rand(N*Nb,1));
        switch Mod_type
            case{'BPSK'}
                x=step(BPSKMod,d);
            case{'QPSK'}
                x=step(QPSKMod,d);
            case{'16QAM'}
                x=step(QAM16Mod,d);
            case{'64QAM'}
                x=step(QAM64Mod,d);
            case{'256QAM'}
                x=step(QAM256Mod,d);
        end
     y=awgn(x,SNR_dB(n),'measured');
     
        switch Mod_type
            case{'BPSK'}
                y_est=step(BPSKDemod,y);
            case{'QPSK'}
                y_est=step(QPSKDemod,y);
            case{'16QAM'}
                y_est=step(QAM16Demod,y);
            case{'64QAM'}
                y_est=step(QAM64Demod,y);
            case{'256QAM'}
                y_est=step(QAM256Demod,y);
        end
        
        error(k)=sum(y_est~=d);
    end
    BER(n)=mean(error)/(N*Nb);
end

%figure
semilogy(SNR_dB,BER,'-ok','linewidth',1.5) ; hold on
xlabel('SNR[dB]')
ylabel('BER')
title('AWGN , N=64')
axis([0 25 10^(-4) 1])
grid


             
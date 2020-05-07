function [res] = clip(data, a)
    N = length(data);
    for k = 1 : N
        new = 0;
        x = data(k)
        if abs(x) <= a then
            new = x;
        else
            new = a * sign(x);
        end
        res(k) = new;    
    end
endfunction

function [res] = distort(data, a, b)
    N = length(data);
    for k = 1 : N
        res(k) = a * atan(b * data(k))
    end
endfunction


raw_signal = loadwave('guitar.wav');
first_ch = raw_signal(1,:);

// plot original signal 
// in time and frequecny domains
figure(1);

subplot(221);
plot(first_ch);
title("Original signal in time domain");
xlabel("Time t");
ylabel("signal(t)");

subplot(223);
plot(fft(first_ch));
title("Original signal in frequency domain");
xlabel("Frequency x");
ylabel("signal(x)")


// pass the signal throught clipping filter
// and plot the result
// in time and frequency domains
clipped_signal = clip(first_ch, 0.025)';

//figure(2)
//
//subplot(221);
//plot(clipped_signal);
//title("Clipped signal in time domain");
//xlabel("Time t");
//ylabel("clipped(t)");
//
//subplot(223);
//plot(fft(clipped_signal));
//title("Clipped signal in frequency domain");
//xlabel("Freq x");
//ylabel("clipped(x)");


// pass the signal throught clipping filter
// and plot the result
// in time and frequency domains
distorted_signal = distort(first_ch, 2, 200)';

figure(3)

subplot(221);
plot(distorted_signal);
title("Distorted signal in time domain");
xlabel("Time t");
ylabel("distorted(t)");

subplot(223);
plot(fft(distorted_signal));
title("Distorted signal in frequency domain");
xlabel("Freq x");
ylabel("distorted(x)");


savewave("clipped_0025.wav", clipped_signal, 44100);
savewave("distorted_2-200.wav", distorted_signal, 44100);

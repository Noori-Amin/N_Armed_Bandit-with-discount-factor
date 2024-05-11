clear all
close all
clc
Q=zeros(5,5);
epsilon=0.8;
alpha=0.1;
gamma=0.9;
for day=1:10000
    state_num(1)=1;
    Return=0;
    for Coin=1:10
        action_num(Coin)=epsilon_greedy(Q,state_num(Coin),epsilon);
        r(Coin)=reward_function(state_num(Coin),action_num(Coin));
        %         Q(state_num,action_num)=Q(state_num,action_num)+alpha*(r-Q(state_num,action_num));
        if Coin==10
            break
        end
        state_num(Coin+1)=action_num(Coin);
        Return=Return+r(Coin);
    end
    epsilon=epsilon*0.9999;
    for Coin=10:-1:1
        string_reward=[r(Coin:end)];
        weighted_reward=gamma.^(10-(10:-1:Coin)).*string_reward;
        sum_reward=sum(weighted_reward);
        Q(state_num(Coin),action_num(Coin))=Q(state_num(Coin),action_num(Coin))+alpha*(sum_reward-Q(state_num(Coin),action_num(Coin)));
        r_total(day)=Return;
    end
    
end
sum=sum(r_total);
figure(1)
plot(r_total)
figure(2)
bar(r_total)
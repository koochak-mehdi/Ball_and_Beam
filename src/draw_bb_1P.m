function theta = draw_bb_1P(x)

if ~ishandle(1) %   if figure is not initialized than 
     figure('Name', 'Ball and Beam_1P',...
            'Position', [500 500 1700 200]); %   initialize it
end

clf



d = x(1);
a = -x(2)*pi/180;

r_ball = .015;
l_beam = 1;

p0 = [-l_beam; 0; 0];
p2 = RotZ(a)*[l_beam; 0; 0] + p0;   % beam

p1 = RotZ(a)*[l_beam-d; 0; 0] + p0; % ball
%p1 = RotZ(a)*[0-d; 0; 0] + p0; % ball

%% Floor
line([-5 7], [0 0], 'LineWidth', 2, 'Color', 'k')

%% Ball
rectangle('Position', [p1(1)-r_ball, p1(2)+.0015, 2*r_ball, 2*r_ball],...
          'Curvature', [1 1],...
          'FaceColor', [0.4660 0.6740 0.1880])

%% Beam
line([p0(1) p2(1)], [p0(2), p2(2)],...
      'LineWidth', 3,...
      'Color', 'r');

%% Gear
p_gear = [-.1; -5*r_ball; 0];
r_gear = r_ball*2;
rectangle('Position', [p_gear(1)-r_gear, p_gear(2)-r_gear, 2*r_gear, 2*r_gear],...
          'Curvature', [1 1],...
          'FaceColor', [0.7 0.5 0.1]);

%% Lever Arm
l_lever = 5*r_ball;
d_lever = r_ball/2;
theta = l_beam*a/d_lever;
p0_lever = RotZ(theta) *[d_lever; 0; 0] + p_gear;
rectangle('Position', [p0_lever(1), p0_lever(2), d_lever, l_lever],...
          'FaceColor', [0.7 0.5 0.1])



%% Triangle
hold on
x_t = [-l_beam-.05, -l_beam, -l_beam+.05];
y_t = [-.05 0 -.05];
plot(x_t, y_t,...
     'LineWidth', 3,...
     'Color', [.2 .4 .2])
fill(x_t, y_t, [.2 .4 .2]);

hold off
xlim([-1.2 .2])      
ylim([-.1 .1])

pause(.02)
end

function R = RotZ(qz)
    R = [cos(qz)  -sin(qz) 0;sin(qz) cos(qz) 0; 0 0 1];
end
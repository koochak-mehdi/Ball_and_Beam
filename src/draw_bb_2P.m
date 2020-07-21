function draw_bb_2P(x)

if ~ishandle(1) %   if figure is not initialized than 
     figure('Name', 'Ball and Beam_2P',...
            'Position', [500 500 1000 100]); %   initialize it
end

clf



d = x(1);
a = -x(2)*pi/180;

r_ball = .015;
l_beam = 20*r_ball;

p0 = [0; 0; 0];
p2 = RotZ(a)*[l_beam; 0; 0] + p0;   % beam

p1 = RotZ(a)*[l_beam-d; 0; 0] + p0; % ball
%p1 = RotZ(a)*[0-d; 0; 0] + p0; % ball

%% Floor
line([-5 7], [0 0], 'LineWidth', 2, 'Color', 'k')

%% Ball
rectangle('Position', [p1(1)-r_ball, p1(2), 2*r_ball, 2*r_ball],...
          'Curvature', [1 1],...
          'FaceColor', 'k')

%% Beam
line([p0(1) p2(1)], [p0(2), p2(2)],...
      'LineWidth', 3,...
      'Color', 'r');
line([p0(1) -p2(1)], [p0(2), -p2(2)],...
      'LineWidth', 3,...
      'Color', 'r');
  
xlim([-1 1])      
ylim([-.04 .04])

pause(.02)
end

function R = RotZ(qz)
    R = [cos(qz)  -sin(qz) 0;sin(qz) cos(qz) 0; 0 0 1];
end
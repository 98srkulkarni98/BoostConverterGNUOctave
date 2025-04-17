function boost_converter_gui()
  % Create a figure window
  f = figure('Name', 'Boost Converter Parameter Input', 'Position', [300, 300, 600, 700]);

  % Load the SVG image
  axes('Units', 'pixels', 'Position', [100, 450, 400, 200]); % Position for the SVG image
  img = imread('boost_converter_diagram.svg'); % Read the SVG file
  imshow(img); % Display the SVG image

  % Define default values
  default_uz = 10;
  default_L = 10e-3;
  default_C = 10e-6;
  default_R = 10;
  default_il = 2;
  default_a = 0.25;
  default_fs = 10e3;

  % Input Voltage
  uicontrol('Style', 'text', 'Position', [50, 400, 150, 20], 'String', 'Input Voltage (uz):');
  uz_input = uicontrol('Style', 'edit', 'Position', [250, 400, 150, 20], 'String', num2str(default_uz));

  % Inductance
  uicontrol('Style', 'text', 'Position', [50, 360, 150, 20], 'String', 'Inductance (L):');
  L_input = uicontrol('Style', 'edit', 'Position', [250, 360, 150, 20], 'String', num2str(default_L));

  % Capacitance
  uicontrol('Style', 'text', 'Position', [50, 320, 150, 20], 'String', 'Capacitance (C):');
  C_input = uicontrol('Style', 'edit', 'Position', [250, 320, 150, 20], 'String', num2str(default_C));

  % Resistance
  uicontrol('Style', 'text', 'Position', [50, 280, 150, 20], 'String', 'Resistance (R):');
  R_input = uicontrol('Style', 'edit', 'Position', [250, 280, 150, 20], 'String', num2str(default_R));

  % Load Current
  uicontrol('Style', 'text', 'Position', [50, 240, 150, 20], 'String', 'Load Current (il):');
  il_input = uicontrol('Style', 'edit', 'Position', [250, 240, 150, 20], 'String', num2str(default_il));

  % Duty Ratio
  uicontrol('Style', 'text', 'Position', [50, 200, 150, 20], 'String', 'Duty Ratio (a):');
  a_input = uicontrol('Style', 'edit', 'Position', [250, 200, 150, 20], 'String', num2str(default_a));

  % Switching Frequency
  uicontrol('Style', 'text', 'Position', [50, 160, 150, 20], 'String', 'Switching Freq (fs):');
  fs_input = uicontrol('Style', 'edit', 'Position', [250, 160, 150, 20], 'String', num2str(default_fs));

  % Submit button
  uicontrol('Style', 'pushbutton', 'Position', [150, 100, 200, 40], 'String', 'Submit', ...
            'Callback', @(src, event) submit_callback());

  % Callback function
  function submit_callback()
    % Get values from input fields
    uz = str2double(get(uz_input, 'String'));
    L = str2double(get(L_input, 'String'));
    C = str2double(get(C_input, 'String'));
    R = str2double(get(R_input, 'String'));
    il = str2double(get(il_input, 'String'));
    a = str2double(get(a_input, 'String'));
    fs = str2double(get(fs_input, 'String'));

    % Calculate dependent parameters
    Ts = 1 / fs;
    Ton = a * Ts;
    Toff = (1 - a) * Ts;

    % Matrices
    A = [0, -(1 - a) / L;
         (1 - a) / C, -1 / (R * C)];
    Bu = [1 / L; 0];
    Bl = [0; -1 / C];
    Aon = [0, 0;
           0, -1 / (R * C)];
    Aoff = [0, -1 / L;
            1 / C, -1 / (R * C)];

    % Display the collected and calculated values
    disp("Collected Parameters:");
    disp(["uz = ", num2str(uz)]);
    disp(["L = ", num2str(L)]);
    disp(["C = ", num2str(C)]);
    disp(["R = ", num2str(R)]);
    disp(["il = ", num2str(il)]);
    disp(["a = ", num2str(a)]);
    disp(["fs = ", num2str(fs)]);
    disp(["Ton = ", num2str(Ton)]);
    disp(["Toff = ", num2str(Toff)]);

    disp("Calculated Matrices:");
    disp("A:");
    disp(A);
    disp("Bu:");
    disp(Bu);
    disp("Bl:");
    disp(Bl);
    disp("Aon:");
    disp(Aon);
    disp("Aoff:");
    disp(Aoff);
  end
end


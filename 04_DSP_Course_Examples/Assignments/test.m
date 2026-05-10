% --- Configuration ---
filename = 'energizante-motivation-197455.mp3'; % Specify the audio file
output_header_file = 'audiorecord.h'; % Specify the output C header file name
duration_to_extract_sec = 1.0; % Duration to extract from the end (in seconds)

% --- Check if file exists ---
if ~isfile(filename)
    error('Audio file not found: %s', filename);
end

% --- Read Audio File Information ---
try
    info = audioinfo(filename);
catch ME
    error('Could not read audio file info: %s\n%s', filename, ME.message);
end

Fs = info.SampleRate; % Get the ACTUAL sample rate from the file
total_samples = info.TotalSamples;
num_channels = info.NumChannels;

fprintf('Audio Info:\n');
fprintf('  Sample Rate (Fs): %d Hz\n', Fs);
fprintf('  Total Samples: %d\n', total_samples);
fprintf('  Duration: %.2f seconds\n', info.Duration);
fprintf('  Channels: %d\n', num_channels);

% --- Calculate Samples to Read (Last Second) ---
samples_to_extract = round(duration_to_extract_sec * Fs);

% Ensure we don't try to read more samples than exist
if samples_to_extract > total_samples
    samples_to_extract = total_samples;
    fprintf('Warning: Requested duration (%.2f s) is longer than file duration (%.2f s). Extracting entire file.\n', ...
            duration_to_extract_sec, info.Duration);
end

% Calculate the start and end sample indices for the last segment
start_sample = max(1, total_samples - samples_to_extract + 1);
end_sample = total_samples;
samples_to_read = [start_sample, end_sample];

fprintf('Extracting samples from %d to %d (approx. last %.2f seconds).\n', ...
        start_sample, end_sample, (end_sample - start_sample + 1)/Fs);

% --- Read the Specified Audio Segment ---
try
    [y, ~] = audioread(filename, samples_to_read); % Fs is already known from info
catch ME
    error('Could not read audio data from file: %s\n%s', filename, ME.message);
end

% --- Process Audio Data ---
% Select first channel if stereo/multi-channel
if size(y, 2) > 1
    y = y(:, 1);
    fprintf('Selected first channel for processing.\n');
end

% Get the actual length of the extracted data
L = length(y);

% Normalize (optional, but good practice if source levels vary)
% y = y / max(abs(y)); % Uncomment if normalization is needed

% Convert to int16, scaling to use the full range [-32767, 32767]
% Use intmax('int16') which is 32767
scaling_factor = double(intmax('int16')); % Use double for calculation precision
b_short = int16(y * scaling_factor);

fprintf('Converted %d samples to int16 format.\n', L);

% --- Write to C Header File ---
fprintf('Writing data to header file: %s\n', output_header_file);
fid = fopen(output_header_file, 'w');

if fid == -1
    error('Could not open file for writing: %s', output_header_file);
end

% Write header guard (optional but good practice)
[~, header_name_upper, ~] = fileparts(upper(output_header_file));
header_guard = ['__', header_name_upper, '_H__'];
fprintf(fid, '#ifndef %s\n', header_guard);
fprintf(fid, '#define %s\n\n', header_guard);

% Write the buffer size definition
fprintf(fid, '// Audio Data Buffer Size (Number of Samples)\n');
fprintf(fid, '#define SPEECHBUF %d\n\n', L);

% Write the array definition
fprintf(fid, '// Audio Data (int16 format)\n');
fprintf(fid, 'const short Speech[SPEECHBUF] = {\n'); % Use const if data shouldn't change

% Write the data elements, formatted for readability
% Print all elements except the last one, followed by a comma
if L > 0
    fprintf(fid, '  %d,\n', b_short(1:end-1));
    % Print the last element without a comma
    fprintf(fid, '  %d\n', b_short(end));
end

% Close the array definition
fprintf(fid, '};\n\n');

% End the header guard
fprintf(fid, '#endif // %s\n', header_guard);

% Close the file
fclose(fid);

fprintf('Finished writing header file.\n');
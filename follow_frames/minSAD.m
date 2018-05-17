function v = minSAD(target, anchor, block, range)
% MINSAD get the movement of a block

% V = MINSAD(TARGET, ANCHOR, BLOCK, RANGE) get the shift V that is necessary
% to apply in order to put it in the position with smaller SAD from TARGET.
% BLOCK has the coordinates of the upper left corner and the width and heigth
% of the block, that's to say, BLOCK = [x y width heigth]. RANGE is the search
% range. RANGE has two dimentios, [Rx,Ry], corresponding to the search range
% horizontally and verically, respectively

% Default values
dxmin = 0; dymin = 0;

target = im2double(rgb2gray(target));
anchor = im2double(rgb2gray(anchor));

minssd  = inf;
% Anchor's block to use as comparer
anchor_block = anchor(block(2):block(2)+block(4),block(1):block(1)+block(3));

% Img size to scan
[m,n] = size(target);

% For evert position in the search area
for dx=-range(1):range(1)
    for dy=-range(2):range(2)
        % Calculate the difference between the reference pic and the
        % other img shifted [dy,dx]
        target_block = target(...
            max(1, block(2) + dy):min(m, block(2) + block(4) + dy), ...
            max(1, block(1) + dx):min(n, block(1) + block(3) + dx) ...
        );
        if size(target_block) == size(anchor_block)
            dif = target_block - anchor_block;
            % Addition of the squares of the differences
            ssd = sum(abs(dif(:))); 
            % Get the position with the smaller ssd
            if (ssd < minssd)
                dxmin = dx;
                dymin = dy;
                minssd = ssd;
            end
        end
    end
end

v = round([dxmin dymin]);
end
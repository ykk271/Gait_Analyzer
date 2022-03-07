function [] = YKK_drawInterval(START,END,n)
y = [-2000 -2000 2000 2000];

x = [START END END START];

switch n
    case 6
        p = patch(x,y,'k','FaceColor','#888888'); hold on;
    case 5
        p = patch(x,y,'k','FaceColor','#fcbd80'); hold on;
    case 4
        p = patch(x,y,'k','FaceColor','#c8b0dd'); hold on;
    case 3
        p = patch(x,y,'k','FaceColor','#a3c6e0'); hold on;
    case 2
        p = patch(x,y,'k','FaceColor','#a7d6a6'); hold on;
    case 1
        p = patch(x,y,'k','FaceColor','#e5b1b0'); hold on;
        
end
p.EdgeColor = 'none';
alpha(0.5)

end

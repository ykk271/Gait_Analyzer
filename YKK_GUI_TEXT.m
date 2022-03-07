function [] = YKK_GUI_TEXT(TEXT,COLOR)
plot(1,1)
text(8,10,TEXT,'Color',COLOR,'FontSize',30)
ylim([0 20]); xlim([0 20])
xticks([]); yticks([]);

box on
-- Author Ryker MacArthur (rkrkity)
-- coAuthors: Gideon Landry (Dead Moose)
-- GitHub: https://github.com/GideonLandry/Stormworks

function onTick()
    upSideDown=input.getBool(1)
    w,h=input.getNumber(1),input.getNumber(2)
    roll=input.getNumber(3)*math.rad(360)
    pitch=input.getNumber(4)*math.rad(360)
    if upSideDown then
        roll=-roll
        pitch=-pitch
    end
    offsetX=math.cos(-roll)*w
    offsetY=math.sin(-roll)*w
    
    pitchOffsetY=pitch*32
    
    downX=math.sin(-roll)*h*2
    downY=-math.cos(-roll)*h*2
end
function onDraw()
    screen.setColor(50,25,0)
    screen.drawRectF(0,0,w,h)
    screen.setColor(0,25,150)
    screen.drawTriangleF((w/2)-offsetX,(h/2)-offsetY+pitchOffsetY,(w/2)+offsetX,(h/2)+offsetY+pitchOffsetY,(w/2)+offsetX+downX,(h/2)+offsetY+downY)
    screen.drawTriangleF((w/2)-offsetX,(h/2)-offsetY+pitchOffsetY,(w/2)-offsetX+downX,(h/2)-offsetY+downY,(w/2)+offsetX+downX,(h/2)+offsetY+downY)
    screen.setColor(255,255,255)
    screen.drawLine((w/2)-offsetX,(h/2)-offsetY+pitchOffsetY,(w/2)+offsetX,(h/2)+offsetY+pitchOffsetY)
    rollLineOffset=math.sin(roll)*h/8
    pitchLineOffset=math.cos(roll)*h/8
    for i=-16,16 do
        
        x1 = w/2-5 + pitchLineOffset
        y1 = (h/2+(i+(pitch*math.rad(10)))*(h/8))+rollLineOffset
        x2 = w/2+5 - pitchLineOffset
        y2 = (h/2+(i+(pitch*math.rad(10)))*(h/8))-rollLineOffset
        
        screen.drawLine(x1,y1,x2,y2)
    end
end
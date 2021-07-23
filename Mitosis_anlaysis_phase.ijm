//Get purified image
	tifName = getTitle();
	rename("1");
	run("Split Channels");
	selectWindow("C1-"+ 1);
	close();
	selectWindow("C2-"+ 1);
	close();
//Segment image
	run("Set Measurements...", "area mean standard fit display redirect=None decimal=2");
	setThreshold(1, 255);
	run("Analyze Particles...", "display add stack");
//Calculate normalized value
	ColN = nResults;
	Std1 = getResult("StdDev", 0);
	Std2 = getResult("StdDev", 1);
	Std3 = getResult("StdDev", 2);
	StdForNormal = (Std1+Std2+Std3)/3;
	Mean1 = getResult("Mean", 0);
	Mean2 = getResult("Mean", 1);
	Mean3 = getResult("Mean", 2);
	MeanForNormal = (Mean1+Mean2+Mean3)/3;
	AreaL6 = getResult("Area", ColN-6);
	AreaL5 = getResult("Area", ColN-5);
	AreaL4 = getResult("Area", ColN-4);
	AreaL3 = getResult("Area", ColN-3);
	AreaL2 = getResult("Area", ColN-2);
	AreaL1 = getResult("Area", ColN-1);
	AreaForNormal = (AreaL1+AreaL2+AreaL3+AreaL4+AreaL5+AreaL6)/6;
	for (i = 0; i<ColN; i++){
		c = getResult("Major", i);
		b = getResult("Minor", i);
		a = 1;
		Ellipticity = (2*a*a/(a*a+b*b))*(1-((a*a+b*b)/(2*c*c)));
		Table.set("Ellipticity",i, Ellipticity); 
	}
	E1 = getResult("Ellipticity", 0);
	E2 = getResult("Ellipticity", 1);
	E3 = getResult("Ellipticity", 2);
	EForNormal = (E1+E2+E3)/3;
//Restructure results
	for (i = 0; i<ColN; i++){
		label = getResultString("Label", i);
		label = replace(label, "C3-1:", "");
		Table.set("Frame",i, label);
	}
	for (i = 0; i<ColN; i++){
		Std = getResult("StdDev", i);
		NmStd = Std/StdForNormal;
		Table.set("Nm Std",i, NmStd);
	}	
	for (i = 0; i<ColN; i++){
		E = getResult("Ellipticity", i);
		NmE = E/EForNormal;
		Table.set("Nm E",i, NmE);
	}
	for (i = 0; i<ColN; i++){
		Area = getResult("Area", i);
		NmArea = Area/AreaForNormal;
		Table.set("Nm Area",i, NmArea);
	}
	for(i =0; i<ColN-1; i++){
		FrameA = getResult("Frame", i);
		FrameB = getResult("Frame", i+1);
		FrameDifferFromPrevious = FrameB-FrameA;
		Table.set("Frame diff", i+1, FrameDifferFromPrevious);
	}
	for(i =0; i<ColN; i++){
		Mean = getResult("Mean", i);
		NmMean = Mean/MeanForNormal;
		Table.set("Nm Mean",i, NmMean);
	}
//Find Prophase start
	LargeStd = newArray(0);
	for (i = 0; i<ColN; i++){
		NmStd = getResult("Nm Std", i);
		if (NmStd>1.4) {
			Pro = getResult("Frame", i);
			LargeStd = Array.concat(LargeStd, Pro);
		}
	}
	//Array.print(LargeStd);
	Array.getStatistics(LargeStd, min, max, mean, stdDev);
	ProphaseStart = min;
//Find Metaphase start
	LargeE = newArray(0);
	for (i = ProphaseStart; i < ColN; i++) {
		NmE = getResult("Nm E", i);
		NmStd = getResult("Nm Std", i);
		if(NmE>1.6 && NmStd >2.1){
			Meta = getResult("Frame", i);
			LargeE = Array.concat(LargeE, Meta);
		}
	}
	Array.getStatistics(LargeE, min, max, mean, stdDev);
	MetaphaseStart = min;
//Find Anaphase start
	PossibleAna = newArray(0);
	for(i = MetaphaseStart; i< ColN; i++){
		FrameDifferFromPrevious = getResult("Frame diff", i);
		if(FrameDifferFromPrevious==0){
			Ana = getResult("Frame", i);
			PossibleAna = Array.concat(PossibleAna, Ana);
		}
	}
	Array.getStatistics(PossibleAna, min, max, mean, stdDev);
	AnaphaseStart = min;
//Find Telophase start
	smallStd = newArray(0);
	for(i = AnaphaseStart; i < ColN; i++){
		NmStd = getResult("Nm Std", i);
		NmMean = getResult("Nm Mean", i);
		if(NmMean<1.06){
			Tel = getResult("Frame", i);
			smallStd = Array.concat(smallStd, Tel);
		}
	}
	Array.getStatistics(smallStd, min, max, mean, stdDev);
	TelophaseStart = min;
//Get Telophase end
	TelophaseEnd = getResult("Frame", ColN-1);	
//print(ProphaseStart+ ";"+ MetaphaseStart + ";" + AnaphaseStart + ";" +TelophaseStart);
//Create final result
	Table.create("Mitosis analysis");
	Table.set("File Name", 0, tifName);
	Table.set("ProphaseStart", 0, ProphaseStart);
	Table.set("MetaphaseStart", 0, MetaphaseStart);
	Table.set("AnaphaseStart", 0, AnaphaseStart);
	Table.set("TelophaseStart", 0, TelophaseStart);
	Table.set("TelophaseEnd", 0, TelophaseEnd);
	Table.set("Pro duration", 0, MetaphaseStart-ProphaseStart);
	Table.set("Meta duration", 0, AnaphaseStart-MetaphaseStart);
	Table.set("Ana duration", 0, TelophaseStart-AnaphaseStart);
	Table.set("Telo duration", 0, TelophaseEnd-TelophaseStart);
//Clear
	roiManager("Show None");
	resetThreshold();

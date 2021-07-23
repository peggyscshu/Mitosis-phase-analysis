# Mitosis-phase-analysis
A cell cycle occurs as a cell divides. The somatic cell leaves interphase, undergoes mitosis and eventually give out two daughter cells. Mitosis is composed by a series of events including prophase, metaphase, anaphase and telophase. Each phase is featured by DNA condensation, chromosomes lining up along the metaphase plate, segregation of duplicated chromosomes, and DNA decondensation, respectively. Here I offerd a tool generated on Fiji plate form to identify the start of each phase and calcualte the duration of them.

# Applications
1.	Cell cycle analysis
2.	Cancer research
3.	Cell proliferation

# Demo image  
![image](https://user-images.githubusercontent.com/67047201/126726322-1cdc1df4-4901-4d32-99bd-6339dec0be29.png)

# Description
1.	Two scripts are available in this repository. The one named “Mitosis analysis_phase.ijm” will give the start of each phase (Fig. 1D upper). Another one “Mitosis analysis_condensation.ijm”will show the start of DNA condensation and decondensation (Fig. 1D lower).
2.	The mitotic cell lineage from a single ancient cell was masked out by using Imaris tracking module (Fig. 1A). This simplified the data content to increase the accuracy in the analysis.
3.	The Imaris processed image could be transferred to Fiji directly from Imaris to make sure the file format is still intact.
4.	When chromosomes undergo the condensation, the difference of DNA intensity within individual pixels is larger than the one during DNA decondensation. Therefore, the standard deviation of DNA intensity can be used to identify the start of prophas and telophase.
5.	 During Metaphase, the chromosomes are aligned in the metaphase plate. This changes the shape of chromosomes from the round to oval. Hence, it is easier to identify the metaphase by the increase in ellipticity.
6.	The anaphase is featured by the segregation of duplicated chromosomes. By measuring the area of chromosomes, anaphase is easily identified.
7.	The values of standard deviation in DNA intensity, DNA intensity and ellipticity for normalization were caculated by the first three images in the timelapse. After cell dividing, the chromosomes have smaller area. The area for normalization was calcualted by the last six images.
8.	The necessary paramters from each time point were normalized by the previous values and used to define each phase in a cell cycle.
9.	The duration of each phase is calculated along with the result table.

# Instructions Mitosis phase analysis.ijm
1.	Clone this repository to your own account.
2.	Install “Fiji is just Image J“ in your PC.
3.	Tracking cells by Imaris.
4.	Select a cell lineage which underwent mitosis.
5.	Convert the outside of the selected cell lineage with the gray value 0 and duplicate it as an additional channel.
6.	Send the image to Fiji directly by Imaris.
7.	Execute the script under Plugins\Macros\Run
8.	Check out the result.

# Feedback
Made changes to the layout templates or some other part of the code? Fork this repository, make your changes, and send a pull request.
Do these codes help on your research? Please cite as the follows. Skin cells undergo asynthetic fission to support expanding body surfaces in zebrafish. KY Chan, CCS Yan, HY Roan, SC Hsu, CD Hsiao, CP Hsu, CH Chen.

# Structure
![image](https://user-images.githubusercontent.com/67047201/126726730-be344dc8-d0d3-4608-a6f6-5856fc0c9d0d.png)


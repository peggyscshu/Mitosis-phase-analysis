# Mitosis-phase-analysis [![DOI](https://zenodo.org/badge/388534324.svg)](https://zenodo.org/badge/latestdoi/388534324)
A cell cycle occurs as a cell divides. The somatic cell leaves interphase, undergoes mitosis and eventually gives out two daughter cells. Mitosis is composed by a series of events including prophase, metaphase, anaphase and telophase. Each phase is featured by DNA condensation, chromosomes lining up along the metaphase plate, segregation of duplicated chromosomes, and DNA decondensation, respectively. Here I offered a tool generated on Fiji plateform to identify the start of each phase and calculate the duration of them.

# Applications
1.	Cell cycle analysis
2.	Cancer research
3.	Cell proliferation

# Demo image  
![image](https://user-images.githubusercontent.com/67047201/127088763-cf784b17-3675-4486-a5fc-8746714689f1.png)

# Description
1.	Two scripts are available in this repository. The one named “Mitosis analysis_phase.ijm” will give the start of each phase (Fig. 1D upper). Another one “Mitosis analysis_condensation.ijm” will show the period of DNA condensation (Fig. 1D lower).
2.	The mitotic cell lineage from a single ancient cell was masked out by using Imaris tracking module (Fig. 1A). This simplified the data content to increase the accuracy in the analysis.
3.	The Imaris processed image could be transferred to Fiji directly from Imaris to make sure the file format is still intact.
4.	When chromosomes undergo the condensation, the difference of DNA intensity within each pixel is larger than the difference during DNA decondensation. Therefore, the standard deviation of DNA intensity can be used to identify the start of prophase.
5.	During Metaphase, the chromosomes are aligned in the metaphase plate. This changes the shape of chromosomes from a round one to an oval. Hence, it is easier to identify the metaphase by the increase in ellipticity.
6.	The anaphase is featured by the segregation of duplicated chromosomes. By measuring the area of chromosomes, anaphase is easily been identified.
7.	At the beginning of the telophase, this difference in DNA intensity remained but the intensity of DNA labeling decreased. Therefore, the chromosome decondensation was determined by the mean intensity of the DNA labeling.
8.	The values of standard deviation and mean in DNA intensity, and ellipticity for normalization were calculated by the first three images in the timelapse. Along with the chromosome segregation, the chromosomes occupy a smaller area. Therefore, the area for normalization was calcualted by the last six images.
9.	The measurements from each time point were normalized by the previous values and used to define each phase in a cell cycle.
10.	The start time frame and duration of each phase is calculated in the result table.
11.	These two scripts support the batch process function on Fiji.

# Instruction Mitosis phase analysis.ijm
1.	Clone this repository to your own account.
2.	Install “Fiji is just Image J“ in your PC.
3.	Tracking cells by Imaris.
4.	Select a cell lineage which underwent the mitosis.
5.	Convert the outside of the selected cell lineage with the gray value 0 and duplicate it as an additional channel.
6.	Send the image to Fiji directly by Imaris.
7.	Execute the script under Plugins\Macros\Run
8.	Check out the result.

# Feedback
Made changes to the layout templates or some other part of the code? Fork this repository, make your changes, and send a pull request.
Do these codes help on your research? Please cite as the follows. Chan, K.Y., Yan, CC.S., Roan, HY. et al. Skin cells undergo asynthetic fission to expand body surfaces in zebrafish. Nature (2022). https://doi.org/10.1038/s41586-022-04641-0

# Structure
![image](https://user-images.githubusercontent.com/67047201/126728236-45dd8b37-e047-4b65-af1f-6efabfbf79dd.png)


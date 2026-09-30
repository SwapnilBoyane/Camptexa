

# maximum clade credibility tree (simple summarization) from all gene trees using dendropy:
# gives info about which nodes have support from what proportion of gene trees
sumtrees.py --output=texanus.tre --min-clade-freq=0.05 texanus.trees



# coalescent tree of all gene trees using ASTRAL III
# automatically calculates local branch support using quartets, described here: https://doi.org/10.1093/molbev/msw079
java -jar /lustre/work/sboyane/Astral/astral.5.7.8.jar -i texanus.trees -o texanus_astral.tre 2> texanus_astral.log




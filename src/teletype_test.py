#!/usr/bin/python3

# Read the file
vcf_file = input("Enter the name of the file:\n")

#Declare variables
pop_1_count = 0
pop_2_count = 0
pop_11_count = 0
pop_12_count = 0
pop_13_count = 0
pop_18_count = 0
pop_20_count = 0
pop_24_count = 0

# Open the file and read it
with open(vcf_file,"r") as infile:
	for line in infile:
		if not line.startswith("#"):
			split_line = line.split("\t")
			pop_1_split = split_line[9].split(":")
			pop_1_genotype_split = pop_1_split[0].split("/")
			if "1" in pop_1_genotype_split:
				pop_1_count += 1
			pop_2_split = split_line[10].split(":")
			pop_2_genotype_split = pop_2_split[0].split("/")
			if "1" in pop_2_genotype_split:
				pop_2_count += 1
			pop_11_split = split_line[11].split(":")
			pop_11_genotype_split = pop_11_split[0].split("/")
			if "1" in pop_11_genotype_split:
				pop_11_count += 1
			pop_12_split = split_line[12].split(":")
			pop_12_genotype_split = pop_12_split[0].split("/")
			if "1" in pop_12_genotype_split:
				pop_12_count += 1
			pop_13_split = split_line[13].split(":")
			pop_13_genotype_split = pop_13_split[0].split("/")
			if "1" in pop_13_genotype_split:
				pop_13_count += 1
			pop_18_split = split_line[14].split(":")
			pop_18_genotype_split = pop_18_split[0].split("/")
			if "1" in pop_18_genotype_split:
				pop_18_count += 1
			pop_20_split = split_line[15].split(":")
			pop_20_genotype_split = pop_20_split[0].split("/")
			if "1" in pop_20_genotype_split:
				pop_20_count += 1
			pop_24_split = split_line[16].split(":")
			pop_24_genotype_split = pop_24_split[0].split("/")
			if "1" in pop_24_genotype_split:
				pop_24_count += 1

print ("Pop 1:\t",pop_1_count,"\n","Pop 2:\t", pop_2_count,"\n","Pop 11:\t",pop_11_count,"\n","Pop 12:\t",pop_12_count,"\n","Pop 13:\t",pop_13_count,"\n","Pop 18:\t",pop_18_count,"\n","Pop 20:\t",pop_20_count,"\n","Pop 24:\t",pop_24_count)

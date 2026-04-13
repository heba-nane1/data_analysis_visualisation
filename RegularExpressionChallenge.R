df <- read.csv("dung_beetles_v2.csv")
str(df)

# create a vector with only column names, first 2 not wanted so subset column 3-50
col_names = colnames(df)[3:50] 

#first genus name starts with C
grep_out <- grep(pattern = '^C', x = col_names)
grep_out
col_names[grep_out]

# second word (epithet) starts with r, _ is the unique identifier
grep_out <- grep(pattern = '_r', x = col_names)

gsub_out <- gsub(pattern = 'Copis', x = col_names, replacement = 'Copris')
gsub_out

gsub_out <- gsub(pattern = 'Microcopis', x = col_names, replacement = 'Microcopris')
gsub_out

# to do the both gsubs in one go, remove the c
gsub_out <- gsub(pattern = 'opis', x = col_names, replacement = 'opris')
gsub_out

colnames(df)[3:50] <- gsub_out


assign.unique.name = function(cnames) {
    uniq.names = cnames
    num.names = length(cnames)
    
    for (i in 2:num.names) {
        name.i = uniq.names[i]
        names.before.i = uniq.names[1:(i - 1)]
        
        if (name.i %in% names.before.i) {
            j = 2
            while (T) {
                new.name = paste(name.i, j, sep='_')
                if (!(new.name %in% names.before.i)) {
                    uniq.names[i] = new.name
                    break
                }
                
                j = j + 1
            }
        }
    }
    
    uniq.names
}
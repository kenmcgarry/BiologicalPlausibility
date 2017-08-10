

entropy <- function( X, method = "emp")
{
  X<-data.frame(X)
  X<-data.matrix(X)
  n <- NCOL(X)
  N <- NROW(X)
  Z<-na.omit(X)
  if( !(all(Z==round(Z))))
    stop("This method requires discrete values")                      
  #if(n>32000)
  #stop("too many variables")
  res <- NULL 
  
  if( method == "emp")
    choi<-0
  else if( method == "mm" )
    choi<-1
  else if( method == "sg" )
    choi<-2
  else if(method == "shrink")
    choi<-3
  else stop("unknown method")
  res <- .Call( "entropyR",X,N,n, choi, PACKAGE="infotheo")
  res
}

multiinformation <- function( X, method = "emp")
{
  X<-data.frame(X)
  X<-data.matrix(X)
  n <- NCOL(X)
  N <- NROW(X)
  Z<-na.omit(X)
  if( !(all(Z==round(Z))))
    stop("This method requires discrete values")                      
  #if(n>32000)
  #stop("too many variables")
  res <- NULL 
  
  if( method == "emp")
    choi<-0
  else if( method == "mm" )
    choi<-1
  else if( method == "sg" )
    choi<-2
  else if(method == "shrink")
    choi<-3
  else stop("unknown method")
  res <- .Call( "multiinformationR",X,N,n, choi, PACKAGE="infotheo")
  res
}

interinformation <- function( X, method = "emp")
{
  X<-data.frame(X)
  X<-data.matrix(X)
  n <- NCOL(X)
  N <- NROW(X)
  
  Z<-na.omit(X)
  if( !(all(Z==round(Z))))
    stop("This method requires discrete values")                      
  if(n>500)
    stop("too many variables")
  res <- NULL 
  
  if( method == "emp")
    choi<-0
  else if( method == "mm" )
    choi<-1
  else if( method == "sg" )
    choi<-2
  else if(method == "shrink")
    choi<-3
  else stop("unknown method")
  res <- .Call( "interactionR",X,N,n, choi, PACKAGE="infotheo")
  res
}

#compute H(X|Y)
condentropy<-function(X, Y=NULL, method="emp")
{
  if(is.null(Y))
    Hres<-entropy(X, method)
  else
  {
    Hyx<-entropy(data.frame(Y,X), method)
    Hy<-entropy(Y, method)
    Hres<-Hyx-Hy
  }
  Hres
}

#compute I(X;Y)
mutinformation<-function(X, Y=NULL, method="emp")
{
  res <- NULL 
  if (is.null(Y))
    if(is.atomic(X))
      stop("supply both 'X' and 'Y' or a matrix-like 'X'")
  else {
    var.id <- NULL
    if( is.matrix(X) )
      X<-data.frame(X)
    if(is.data.frame(X)) 
      var.id <- names(X) 
    else stop("supply a matrix-like argument")
    
    X <- data.matrix(X)
    n <- NCOL(X)
    N <- NROW(X)
    Z<-na.omit(X)
    if( !(all(Z==round(Z))))
      stop("This method requires discrete values")                      
    #if(n>32000)
    #stop("too many variables")
    if( method == "emp")
      choi<-0
    else if( method == "mm" )
      choi<-1
    else if( method == "sg" )
      choi<-2
    else if(method == "shrink")
      choi<-3
    else stop("unknown method")
    
    res <- .Call( "buildMIM",X,N,n, choi,PACKAGE="infotheo")
    dim(res) <- c(n,n)
    res <- as.matrix(res)
    rownames(res) <- var.id
    colnames(res) <- var.id
  }
  else {
    U<-data.frame(Y,X)
    Hyx<-entropy(U, method) 
    Hx<-entropy(X, method)
    Hy<-entropy(Y, method)
    res<-Hx+Hy-Hyx
    if(res < 0)
      res<-0
  }
  res
}

#compute I(X;Y|S)
condinformation<-function(X,Y,S=NULL, method="emp")
{
  if(is.null(S))
    Ires<-mutinformation(X,Y, method)
  else
  {
    U<-data.frame(S,X,Y)
    Hysx<-entropy(U,method)
    Hsx<-entropy(U[,c(1,2)],method)
    Hys<-entropy(U[,c(1,3)],method)
    Hs<-entropy(S,method)
    Ires<- Hys - Hs - Hysx + Hsx
  }
  Ires
}

natstobits<-function(H)
{ H*1.442695 }

discretize <- function( X, disc="equalfreq", nbins=NROW(X)^(1/3) )
{
  X <- as.data.frame(X)
  varnames <- names(X)
  dimensions <- dim(X)
  X <- data.matrix(X)
  #if(!is.numeric(X))
  #stop("Supply numeric data")
  dim(X) <- dimensions
  res <- NULL
  if( disc=="equalfreq" )
    res <- .Call("discEF",X,NROW(X),NCOL(X),
                 as.integer(nbins), PACKAGE="infotheo")
  else if( disc=="equalwidth" )
    res <- .Call("discEW",X,NROW(X),NCOL(X),
                 as.integer(nbins), PACKAGE="infotheo")
  else if( disc=="globalequalwidth") 
    res <- as.vector(cut(X, nbins, labels = FALSE))
  
  else stop("unknown discretization method")  
  dim(res) <- dimensions
  res <- as.data.frame(res)
  names(res) <- varnames
  res
}


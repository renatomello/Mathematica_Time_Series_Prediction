(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 11.3' *)

(***************************************************************************)
(*                                                                         *)
(*                                                                         *)
(*  Under the Wolfram FreeCDF terms of use, this file and its content are  *)
(*  bound by the Creative Commons BY-SA Attribution-ShareAlike license.    *)
(*                                                                         *)
(*        For additional information concerning CDF licensing, see:        *)
(*                                                                         *)
(*         www.wolfram.com/cdf/adopting-cdf/licensing-options.html         *)
(*                                                                         *)
(*                                                                         *)
(***************************************************************************)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[      1088,         20]
NotebookDataLength[    815480,      14517]
NotebookOptionsPosition[    806376,      14365]
NotebookOutlinePosition[    806820,      14385]
CellTagsIndexPosition[    806777,      14382]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["An\[AAcute]lise de S\[EAcute]ries Temporais e \
Predi\[CCedilla]\[OTilde]es com Redes Neurais", "Title",ExpressionUUID->\
"3d0bbfab-9b4c-45d3-9b6d-ecd1f5bb6e15"],

Cell[CellGroupData[{

Cell["Introdu\[CCedilla]\[ATilde]o", "Section",
 Background->RGBColor[
  0.87, 0.94, 1],ExpressionUUID->"5465f75d-6859-4757-8cd9-a6c12a53561f"],

Cell[TextData[{
 "Neste projeto apresento uma introdu\[CCedilla]\[ATilde]o ao uso de redes \
neurais como ferramenta auxiliar na modelagem de s\[EAcute]ries temporais. \
Primeiro, diversas fun\[CCedilla]\[OTilde]es importantes para an\[AAcute]lise \
\[OpenCurlyDoubleQuote]cl\[AAcute]ssica\[CloseCurlyDoubleQuote] de \
s\[EAcute]ries temporais, al\[EAcute]m da inicializa\[CCedilla]\[ATilde]o de \
redes neurais ",
 StyleBox["long short-term memory",
  FontSlant->"Italic"],
 " usando a biblioteca de redes neurais do Mathematica. Em seguida, apresento \
tr\[EHat]s aplica\[CCedilla]\[OTilde]es, na seguinte ordem: primeiro, utilizo \
um exemplo de s\[EAcute]rie temporal em que, apesar de clara tend\[EHat]ncia \
sazonal, as redes neurais n\[ATilde]o conseguem predizer um n\[UAcute]mero \
significativo de pontos no futuro. Este exemplo \[EAcute] utilizado para \
mostrar a import\[AHat]ncia de um bom pr\[EAcute]-processamento \
\[OpenCurlyDoubleQuote]cl\[AAcute]ssico\[CloseCurlyDoubleQuote] das \
s\[EAcute]ries. Segundamente, mostro um exemplo onde o \
pr\[EAcute]-processamento de uma s\[EAcute]rie temporal \[EAcute] bem \
sucedido, levando a um processo de predi\[CCedilla]\[ATilde]o \
razo\[AAcute]vel. Por \[UAcute]ltimo, mostro um exemplo em que uma \
s\[EAcute]rie temporal \[EAcute] extremamente dif\[IAcute]cil de ser predita \
por interven\[CCedilla]\[OTilde]es externas irregulares, independentes de pr\
\[EAcute]-processamento."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"9bbaa863-e044-456f-ae44-367c6bf25996"]
}, Closed]],

Cell[CellGroupData[{

Cell["Definindo Fun\[CCedilla]\[OTilde]es \[UAcute]teis", "Section",
 Background->RGBColor[
  0.87, 0.94, 1],ExpressionUUID->"180044bb-9101-4fe5-a835-4bd4baa50b7e"],

Cell[CellGroupData[{

Cell["Differencing", "Subsection",ExpressionUUID->"325d1f03-4999-4eaa-a391-9394f4072b8a"],

Cell["\<\
Fun\[CCedilla]\[ATilde]o que retorna uma s\[EAcute]rie de \
diferen\[CCedilla]as normalizada pela m\[EAcute]dia da  s\[EAcute]rie original\
\>", "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"17c13414-bf97-415f-a334-fe96993f09a9"],

Cell[BoxData[
 RowBox[{
  RowBox[{"differencing", "[", "data_", "]"}], ":=", 
  FractionBox[
   RowBox[{"Differences", "[", "data", "]"}], 
   RowBox[{"Mean", "[", "data", "]"}]]}]], "Input",ExpressionUUID->"c4246e9c-\
bcae-434c-839e-ddc6f775d247"]
}, Closed]],

Cell[CellGroupData[{

Cell["Detrending", "Subsection",ExpressionUUID->"1051fd06-7d92-4403-b620-f16751f0044d"],

Cell["\<\
Fun\[CCedilla]\[ATilde]o que recebe lista como input e retorna tupla com fit \
linear, s\[EAcute]rie j\[AAcute] sem tend\[EHat]ncia e plot\
\>", "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"6b0c4719-ca3e-46b1-832a-d5affabb96d3"],

Cell[BoxData[
 RowBox[{
  RowBox[{"detrending", "[", "data_", "]"}], ":=", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"t", ",", "linearFit", ",", "detrended"}], "}"}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"linearFit", ",", "detrended"}], "}"}], "=", 
     RowBox[{"{", "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"LinearModelFit", "[", 
        RowBox[{"data", ",", "t", ",", "t"}], "]"}], ",", 
       "\[IndentingNewLine]", 
       RowBox[{"MapThread", "[", 
        RowBox[{
         RowBox[{
          RowBox[{"#2", " ", "-", " ", 
           RowBox[{"linearFit", "[", "#1", "]"}]}], "&"}], ",", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"Range", "[", 
            RowBox[{"Length", "[", "data", "]"}], "]"}], ",", "data"}], 
          "}"}]}], "]"}]}], "\[IndentingNewLine]", "}"}]}]}], 
   "\[IndentingNewLine]", "]"}]}]], "Input",ExpressionUUID->"c5856905-1b3d-\
49d1-bdfc-6be2965f5346"]
}, Closed]],

Cell[CellGroupData[{

Cell["Cross-Correlation", "Subsection",ExpressionUUID->"1b84ed5d-528e-4bac-819c-c26596717725"],

Cell["Correla\[CCedilla]\[ATilde]o cruzada entre duas s\[EAcute]ries", "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"f422922a-8e06-4e17-8e01-b699bdda1b44"],

Cell[BoxData[
 RowBox[{
  RowBox[{"crossCorrelation", "[", 
   RowBox[{"data1_", ",", "data2_", ",", "lag_"}], "]"}], ":=", 
  FractionBox[
   RowBox[{"Sum", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"(", 
       RowBox[{
        RowBox[{"data1", "[", 
         RowBox[{"[", "i", "]"}], "]"}], "-", 
        RowBox[{"Mean", "[", "data1", "]"}]}], ")"}], " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"data2", "[", 
         RowBox[{"[", 
          RowBox[{"i", "+", "lag"}], "]"}], "]"}], "-", 
        RowBox[{"Mean", "[", "data2", "]"}]}], ")"}]}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", 
       RowBox[{
        RowBox[{"Length", "[", "data1", "]"}], "-", "lag"}]}], "}"}]}], "]"}], 
   RowBox[{
    RowBox[{"StandardDeviation", "[", "data1", "]"}], " ", 
    RowBox[{"StandardDeviation", "[", "data2", "]"}], " ", 
    RowBox[{"(", 
     RowBox[{
      RowBox[{"Length", "[", "data1", "]"}], "-", "lag"}], 
     ")"}]}]]}]], "Input",ExpressionUUID->"dd012333-a602-4421-b142-\
3896ee7c88c2"]
}, Closed]],

Cell[CellGroupData[{

Cell["Relevant Peaks", "Subsection",ExpressionUUID->"ce0950f7-0389-4063-8690-5ff1c816b13e"],

Cell[TextData[{
 "Fun\[CCedilla]\[ATilde]o recebe s\[EAcute]rie e retorna lista de pares \
{posi\[CCedilla]\[ATilde]o do pico, altura do pico}. Poss\[IAcute]vel \
especificar um ",
 StyleBox["threshold",
  FontSlant->"Italic"],
 " para m\[IAcute]nima altura de picos relevantes (Default = ",
 Cell[BoxData[
  FormBox[
   FractionBox["2", 
    RowBox[{"\[Sqrt]", 
     RowBox[{"Length", "[", "data", "]"}]}]], TraditionalForm]],
  ExpressionUUID->"449a6e6a-c00c-4ec5-a2fa-5a5d2728cb75"],
 ")."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"59addbe1-5e0b-46f1-8927-a01b5e926704"],

Cell[BoxData[
 RowBox[{
  RowBox[{"relevantPeaks", "[", 
   RowBox[{"data_", ",", "\[Sigma]_", ",", "s_", ",", "threshold_"}], "]"}], ":=", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"peaks", ",", "positivePeaks", ",", "negativePeaks"}], "}"}], 
    ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"positivePeaks", "=", 
      RowBox[{"If", "[", 
       RowBox[{
        RowBox[{"threshold", "\[NotEqual]", "0"}], ",", 
        RowBox[{"FindPeaks", "[", 
         RowBox[{"data", ",", "\[Sigma]", ",", "s", ",", "threshold"}], "]"}],
         ",", 
        RowBox[{"FindPeaks", "[", 
         RowBox[{"data", ",", "1", ",", "0", ",", 
          FractionBox["2", 
           RowBox[{"\[Sqrt]", 
            RowBox[{"Length", "[", "data", "]"}]}]]}], "]"}]}], "]"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"negativePeaks", "=", 
      RowBox[{"If", "[", 
       RowBox[{
        RowBox[{"threshold", "\[NotEqual]", "0"}], ",", 
        RowBox[{"FindPeaks", "[", 
         RowBox[{
          RowBox[{"-", "data"}], ",", "\[Sigma]", ",", "s", ",", 
          "threshold"}], "]"}], ",", 
        RowBox[{"FindPeaks", "[", 
         RowBox[{
          RowBox[{"-", "data"}], ",", "1", ",", "0", ",", 
          FractionBox["2", 
           RowBox[{"\[Sqrt]", 
            RowBox[{"Length", "[", "data", "]"}]}]]}], "]"}]}], "]"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"peaks", "=", 
      RowBox[{"SortBy", "[", 
       RowBox[{
        RowBox[{"Join", "[", "\[IndentingNewLine]", 
         RowBox[{"positivePeaks", ",", "\[IndentingNewLine]", 
          RowBox[{"Thread", "[", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"negativePeaks", "[", 
              RowBox[{"[", 
               RowBox[{"All", ",", "1"}], "]"}], "]"}], ",", 
             RowBox[{"-", 
              RowBox[{"negativePeaks", "[", 
               RowBox[{"[", 
                RowBox[{"All", ",", "2"}], "]"}], "]"}]}]}], "}"}], "]"}]}], 
         "]"}], ",", "\[IndentingNewLine]", "First"}], "]"}]}]}]}], 
   "\[IndentingNewLine]", "]"}]}]], "Input",ExpressionUUID->"737c7efc-81b5-\
4340-933b-d8c25ebe5064"]
}, Closed]],

Cell[CellGroupData[{

Cell["Periodogram per Frequency", "Subsection",ExpressionUUID->"20998a47-f8bd-4d12-9fd5-9cf8ee4164d5"],

Cell[TextData[{
 "Fun\[CCedilla]\[ATilde]o recebe s\[EAcute]rie e taxa de amostragem por \
unidade de tempo (",
 StyleBox["rate",
  FontSlant->"Italic"],
 ") e retorna espectro obtido de Transformada de Fourier (FFT) em fun\
\[CCedilla]\[ATilde]o de frequ\[EHat]ncias. Fun\[CCedilla]\[ATilde]o foi \
necess\[AAcute]ria pois built-in Periodogram retorna FFT em fun\[CCedilla]\
\[ATilde]o do tempo."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"098976a9-0d9d-47de-ac72-17412acaa9b2"],

Cell[BoxData[
 RowBox[{
  RowBox[{"periodogramFrequency", "[", 
   RowBox[{"data_", ",", "rate_"}], "]"}], ":=", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
     "fastFourierTransform", ",", "freq", ",", "fullspectrum", ",", 
      "halfspectrum"}], "}"}], ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"fastFourierTransform", "=", " ", 
      SuperscriptBox[
       RowBox[{"Abs", "[", 
        RowBox[{"Fourier", "[", "data", "]"}], "]"}], "2"]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"freq", " ", "=", " ", 
      RowBox[{
       RowBox[{"N", "[", 
        FractionBox["rate", 
         RowBox[{"Length", "[", "data", "]"}]], "]"}], " ", 
       RowBox[{"Range", "[", 
        RowBox[{"0", ",", 
         RowBox[{
          RowBox[{"Length", "[", "data", "]"}], "-", "1"}]}], "]"}]}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"fullspectrum", "=", 
      RowBox[{"Transpose", "[", 
       RowBox[{"{", 
        RowBox[{"freq", ",", "fastFourierTransform"}], "}"}], "]"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"halfspectrum", "=", 
      RowBox[{"Table", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"fullspectrum", "[", 
           RowBox[{"[", 
            RowBox[{"i", ",", "1"}], "]"}], "]"}], ",", 
          RowBox[{"fullspectrum", "[", 
           RowBox[{"[", 
            RowBox[{"i", ",", "2"}], "]"}], "]"}]}], "}"}], ",", 
        RowBox[{"{", 
         RowBox[{"i", ",", 
          RowBox[{"IntegerPart", "[", 
           FractionBox[
            RowBox[{"Length", "[", "fullspectrum", "]"}], "2"], "]"}]}], 
         "}"}]}], "]"}]}]}]}], "\[IndentingNewLine]", "]"}]}]], "Input",Expres\
sionUUID->"95aec2da-a36a-4935-b504-d435fb0b383a"]
}, Closed]],

Cell[CellGroupData[{

Cell["Removing Seasonalities", "Subsection",ExpressionUUID->"d81e8cbd-4ef8-4fcb-8517-16593285dd09"],

Cell[BoxData[
 RowBox[{
  RowBox[{"seasonalities", "[", 
   RowBox[{
   "data_", ",", "rate_", ",", "\[Sigma]_", ",", "s_", ",", "threshold_"}], 
   "]"}], " ", ":=", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
     "sz", ",", "peaks", ",", "periodogram", ",", "return1", ",", "return2"}],
      "}"}], ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"periodogram", "=", 
      RowBox[{"periodogramFrequency", "[", 
       RowBox[{"data", ",", "rate"}], "]"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"peaks", "=", 
      RowBox[{"relevantPeaks", "[", 
       RowBox[{
        RowBox[{"periodogram", "[", 
         RowBox[{"[", 
          RowBox[{"All", ",", "2"}], "]"}], "]"}], ",", "\[Sigma]", ",", "s", 
        ",", "threshold"}], "]"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"sz", " ", "=", " ", 
      RowBox[{"Table", "[", 
       RowBox[{
        RowBox[{"Sum", "[", 
         RowBox[{
          FractionBox[
           RowBox[{"Sum", "[", 
            RowBox[{
             RowBox[{"data", "[", 
              RowBox[{"[", 
               RowBox[{
                RowBox[{"(", 
                 RowBox[{
                  RowBox[{"Mod", "[", 
                   RowBox[{"i", ",", 
                    RowBox[{"peaks", "[", 
                    RowBox[{"[", 
                    RowBox[{"l", ",", "1"}], "]"}], "]"}]}], "]"}], "+", 
                  "1"}], ")"}], "+", 
                RowBox[{"k", " ", 
                 RowBox[{"peaks", "[", 
                  RowBox[{"[", 
                   RowBox[{"l", ",", "1"}], "]"}], "]"}]}]}], "]"}], "]"}], 
             ",", 
             RowBox[{"{", 
              RowBox[{"k", ",", "0", ",", 
               RowBox[{
                RowBox[{"IntegerPart", "[", 
                 FractionBox[
                  RowBox[{"Length", "[", "data", "]"}], 
                  RowBox[{"peaks", "[", 
                   RowBox[{"[", 
                    RowBox[{"l", ",", "1"}], "]"}], "]"}]], "]"}], "-", 
                "1"}]}], "}"}]}], "]"}], 
           RowBox[{"IntegerPart", "[", 
            FractionBox[
             RowBox[{"Length", "[", "data", "]"}], 
             RowBox[{"peaks", "[", 
              RowBox[{"[", 
               RowBox[{"l", ",", "1"}], "]"}], "]"}]], "]"}]], ",", 
          RowBox[{"{", 
           RowBox[{"l", ",", 
            RowBox[{"Length", "[", "peaks", "]"}]}], "}"}]}], "]"}], ",", 
        RowBox[{"{", 
         RowBox[{"i", ",", 
          RowBox[{"Length", "[", "data", "]"}]}], "}"}]}], "]"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"return1", ",", " ", "return2"}], "}"}], "=", 
      RowBox[{"{", 
       RowBox[{"sz", ",", 
        RowBox[{"data", "-", "sz"}]}], "}"}]}]}]}], "\[IndentingNewLine]", 
   "]"}], " "}]], "Input",ExpressionUUID->"447ffb96-78c7-4d4b-84ab-\
f908bcbd347c"]
}, Closed]],

Cell[CellGroupData[{

Cell["Removing Sinusoidal Components", "Subsection",ExpressionUUID->"676fdf79-ea05-4fe4-9418-bd61f663c916"],

Cell[TextData[{
 "Fun\[CCedilla]\[ATilde]o recebe s\[EAcute]rie e ",
 StyleBox["rate",
  FontSlant->"Italic"],
 ", calcula frequ\[EHat]ncias relevantes, e retorna s\[EAcute]rie sem \
respectivas componentes senoidais"
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"c27b8df4-4977-4e70-a85b-63e2d858f03d"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"removingSinusoidalComponents0", "[", 
   RowBox[{
   "data_", ",", "rate_", ",", "\[Sigma]_", ",", "s_", ",", "threshold_"}], 
   "]"}], ":=", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
     "peaks", ",", "peaksAux", ",", "periodogram", ",", "seasonalities", ",", 
      "deseasonalized", ",", "sum", ",", "A", ",", "B", ",", "t", ",", 
      "return"}], "}"}], ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"periodogram", "=", 
      RowBox[{"periodogramFrequency", "[", 
       RowBox[{"data", ",", "rate"}], "]"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"peaksAux", "=", 
      RowBox[{"relevantPeaks", "[", 
       RowBox[{
        RowBox[{"periodogram", "[", 
         RowBox[{"[", 
          RowBox[{"All", ",", "2"}], "]"}], "]"}], ",", "\[Sigma]", ",", "s", 
        ",", "threshold"}], "]"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"peaks", "=", 
      RowBox[{"Table", "[", 
       RowBox[{
        RowBox[{"{", "\[IndentingNewLine]", 
         RowBox[{
          RowBox[{"periodogram", "[", 
           RowBox[{"[", 
            RowBox[{
             RowBox[{"peaksAux", "[", 
              RowBox[{"[", 
               RowBox[{"i", ",", "1"}], "]"}], "]"}], ",", "1"}], "]"}], 
           "]"}], ",", "\[IndentingNewLine]", 
          RowBox[{"peaksAux", "[", 
           RowBox[{"[", 
            RowBox[{"i", ",", "2"}], "]"}], "]"}]}], "}"}], ",", 
        "\[IndentingNewLine]", 
        RowBox[{"{", 
         RowBox[{"i", ",", 
          RowBox[{"Length", "[", "peaksAux", "]"}]}], "}"}]}], 
       "\[IndentingNewLine]", "]"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"seasonalities", "=", 
      RowBox[{"Table", "[", 
       RowBox[{
        RowBox[{"NonlinearModelFit", "[", 
         RowBox[{"data", ",", 
          RowBox[{
           RowBox[{"A", " ", 
            RowBox[{"Cos", "[", 
             RowBox[{"2", "\[Pi]", " ", 
              RowBox[{"peaks", "[", 
               RowBox[{"[", 
                RowBox[{"i", ",", "1"}], "]"}], "]"}], "t"}], "]"}]}], "+", 
           RowBox[{"B", " ", 
            RowBox[{"Sin", "[", 
             RowBox[{"2", "\[Pi]", " ", 
              RowBox[{"peaks", "[", 
               RowBox[{"[", 
                RowBox[{"i", ",", "1"}], "]"}], "]"}], "t"}], "]"}]}]}], ",", 
          
          RowBox[{"{", 
           RowBox[{"A", ",", "B"}], "}"}], ",", "t"}], "]"}], ",", 
        RowBox[{"{", 
         RowBox[{"i", ",", 
          RowBox[{"Length", "[", "peaks", "]"}]}], "}"}]}], "]"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"sum", "=", 
      RowBox[{"Table", "[", 
       RowBox[{
        RowBox[{"Sum", "[", 
         RowBox[{
          RowBox[{
           RowBox[{"seasonalities", "[", 
            RowBox[{"[", "k", "]"}], "]"}], "[", "i", "]"}], ",", 
          RowBox[{"{", 
           RowBox[{"k", ",", 
            RowBox[{"Length", "[", "seasonalities", "]"}]}], "}"}]}], "]"}], 
        ",", 
        RowBox[{"{", 
         RowBox[{"i", ",", 
          RowBox[{"Length", "[", "data", "]"}]}], "}"}]}], "]"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"return", ",", "deseasonalized"}], "}"}], "=", 
      RowBox[{"{", 
       RowBox[{"seasonalities", ",", 
        RowBox[{"data", "-", "sum"}]}], "}"}]}]}]}], "\[IndentingNewLine]", 
   "]"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"removingSinusoidalComponents", "[", 
   RowBox[{"data_", ",", 
    RowBox[{"threshold_:", "1"}], ",", 
    RowBox[{"rate_:", "1"}], ",", 
    RowBox[{"\[Sigma]_:", "1"}], ",", 
    RowBox[{"s_:", "0"}]}], "]"}], ":=", 
  RowBox[{"removingSinusoidalComponents0", "[", 
   RowBox[{"data", ",", "rate", ",", "\[Sigma]", ",", "s", ",", "threshold"}],
    "]"}]}]}], "Input",ExpressionUUID->"3946e6eb-015f-421a-a698-840374316c12"]
}, Closed]],

Cell[CellGroupData[{

Cell["Partitioning Train & Test sets", "Subsection",ExpressionUUID->"ae46bf8e-020d-4b93-a109-595955df62b7"],

Cell[TextData[{
 "Fun\[CCedilla]\[ATilde]o recebe s\[EAcute]rie, particionando a mesma em um \
vetores do tipo {",
 StyleBox["Input",
  FontSlant->"Italic"],
 "} \[Rule] {",
 StyleBox["output",
  FontSlant->"Italic"],
 "}. Retorno da fun\[CCedilla]\[ATilde]o \[EAcute] um par {",
 StyleBox["train",
  FontSlant->"Italic"],
 " , ",
 StyleBox["test",
  FontSlant->"Italic"],
 "}, onde lista ",
 StyleBox["train",
  FontSlant->"Italic"],
 " \[EAcute] usada para treinamento da rede neural e lista ",
 StyleBox["test",
  FontSlant->"Italic"],
 " \[EAcute] usada como ",
 StyleBox["set",
  FontSlant->"Italic"],
 " de valida\[CCedilla]\[ATilde]o. ",
 StyleBox["Split",
  FontSlant->"Italic"],
 " {",
 StyleBox["train",
  FontSlant->"Italic"],
 " , ",
 StyleBox["test",
  FontSlant->"Italic"],
 "}, se n\[ATilde]o especificado, \[EAcute] de 80%-20% por padr\[ATilde]o."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"20fbbdbd-aca3-4b74-ae9e-fb09bcc05989"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"singleOutputSampleSplit", "[", 
   RowBox[{"data_", ",", "inputNumber_", ",", "split_"}], "]"}], ":=", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"sample", ",", "train", ",", "test"}], "}"}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"sample", "=", 
      RowBox[{
       RowBox[{
        RowBox[{
         RowBox[{"List", "/@", 
          RowBox[{"Most", "[", "#", "]"}]}], " ", "\[Rule]", " ", 
         RowBox[{"List", "@", 
          RowBox[{"Last", "[", "#", "]"}]}]}], " ", "&"}], " ", "/@", " ", 
       RowBox[{"(", 
        RowBox[{"Partition", "[", 
         RowBox[{"data", ",", 
          RowBox[{"UpTo", "[", 
           RowBox[{"inputNumber", "+", "1"}], "]"}], ",", 
          RowBox[{"inputNumber", "+", "1"}], ",", 
          RowBox[{"{", 
           RowBox[{"1", ",", 
            RowBox[{"-", "1"}]}], "}"}]}], "]"}], ")"}]}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"train", ",", "test"}], "}"}], "=", 
      RowBox[{"TakeDrop", "[", 
       RowBox[{"sample", ",", 
        RowBox[{"IntegerPart", "[", 
         RowBox[{"split", " ", 
          RowBox[{"Length", "[", "sample", "]"}]}], "]"}]}], "]"}]}]}]}], 
   "\[IndentingNewLine]", "]"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"sampleSplit", "[", 
   RowBox[{"data_", ",", "inputNumber_", ",", 
    RowBox[{"split_:", "0.8"}]}], "]"}], ":=", 
  RowBox[{"singleOutputSampleSplit", "[", 
   RowBox[{"data", ",", "inputNumber", ",", "split"}], "]"}]}]}], "Input",Expr\
essionUUID->"4b935518-970e-41b1-a921-7dec8f056a79"]
}, Closed]],

Cell[CellGroupData[{

Cell["Neural Networks", "Subsection",ExpressionUUID->"07afeece-4831-4b83-ba23-2a09056b35f2"],

Cell[TextData[{
 "Fun\[CCedilla]\[ATilde]o define rede neural chamada ",
 StyleBox["Long Short-Term Memory",
  FontSlant->"Italic"],
 " (LSTM) com ",
 StyleBox["dropout.",
  FontSlant->"Italic"],
 " Rede LSTM \[EAcute] uma rede que guarda mem\[OAcute]rias de curto prazo \
que podem se extender por um longo per\[IAcute]odo. S\[ATilde]o usadas duas \
LSTM em pararelo. Inputs passam por uma rede LSTM e pelo inverso dessa mesma \
rede, sendo o resultado final a concatena\[CCedilla]\[ATilde]o de ambos."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"88185e0f-bd11-411f-8523-26df63409540"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"neuralnetwork0", "[", 
   RowBox[{
   "data_", ",", "neurons_", ",", "inputNumber_", ",", "outputNumber_", ",", 
    "train_", ",", "test_", ",", "batchSize_", ",", "split_", ",", 
    "dropout_"}], "]"}], ":=", 
  RowBox[{"Module", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"net", ",", "netModel"}], "}"}], ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"net", " ", "=", " ", 
      RowBox[{"NetInitialize", "@", 
       RowBox[{"NetChain", "[", 
        RowBox[{
         RowBox[{"{", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"NetBidirectionalOperator", "[", 
            RowBox[{"{", 
             RowBox[{
              RowBox[{"LongShortTermMemoryLayer", "[", 
               RowBox[{"neurons", ",", 
                RowBox[{"\"\<Dropout\>\"", "\[Rule]", "dropout"}]}], "]"}], 
              ",", 
              RowBox[{"LongShortTermMemoryLayer", "[", 
               RowBox[{"neurons", ",", 
                RowBox[{"\"\<Dropout\>\"", "\[Rule]", "dropout"}]}], "]"}]}], 
             "}"}], "]"}], ",", "\[IndentingNewLine]", 
           RowBox[{"LinearLayer", "[", "1", "]"}]}], "}"}], ",", 
         "\[IndentingNewLine]", 
         RowBox[{"\"\<Input\>\"", "\[Rule]", 
          RowBox[{"{", 
           RowBox[{"inputNumber", ",", "outputNumber"}], "}"}]}], ",", " ", 
         RowBox[{"\"\<Output\>\"", "\[Rule]", "outputNumber"}]}], 
        "\[IndentingNewLine]", "]"}]}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"netModel", "=", 
      RowBox[{"NetTrain", "[", 
       RowBox[{"net", ",", "train", ",", "All", ",", 
        RowBox[{"Method", "\[Rule]", 
         RowBox[{"{", "\"\<ADAM\>\"", "}"}]}], ",", 
        RowBox[{"ValidationSet", "\[Rule]", "test"}], ",", 
        RowBox[{"BatchSize", "\[Rule]", "batchSize"}]}], "]"}]}]}]}], 
   "\[IndentingNewLine]", "]"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"neuralNetwork", "[", 
   RowBox[{
   "data_", ",", "neurons_", ",", "inputNumber_", ",", "outputNumber_", ",", 
    "train_", ",", "test_", ",", 
    RowBox[{"batchSize_:", "1"}], ",", 
    RowBox[{"split_:", "0.8"}], ",", 
    RowBox[{"dropout_:", "0.2"}]}], "]"}], ":=", 
  RowBox[{"neuralnetwork0", "[", 
   RowBox[{
   "data", ",", "neurons", ",", "inputNumber", ",", "outputNumber", ",", 
    "train", ",", "test", ",", "batchSize", ",", "split", ",", "dropout"}], 
   "]"}]}]}], "Input",ExpressionUUID->"78d5c017-ccb4-4af0-add8-05c578036e35"]
}, Open  ]]
}, Closed]],

Cell[CellGroupData[{

Cell["Aplica\[CCedilla]\[OTilde]es", "Section",
 Background->RGBColor[
  0.87, 0.94, 1],ExpressionUUID->"45b8bd69-cfe6-47db-8554-8ec24e031287"],

Cell[CellGroupData[{

Cell["Temperatura M\[EAcute]dia de Rio de Janeiro, RJ", "Subsection",ExpressionUUID->"007d137f-9a78-40d5-ade9-586848744b14"],

Cell["\<\
Usando a base de dados do Mathematica, \[EAcute] poss\[IAcute]vel baixar \
dados meteorol\[OAcute]gicos de uma dada localiza\[CCedilla]\[ATilde]o. Como \
exemplo, foi obtida a s\[EAcute]rie temporal da Temperatura M\[EAcute]dia \
semanal da cidade do Rio de Janeiro entre 01/01/2000 e 01/01/2018.\
\>", "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"8929fa79-dc4c-405f-b029-34c2ee5b4f57"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"temp", "=", 
   RowBox[{"WeatherData", "[", 
    RowBox[{
    "\"\<Rio de Janeiro\>\"", ",", " ", "\"\<MeanTemperature\>\"", ",", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"DateString", "[", 
        RowBox[{"{", 
         RowBox[{"2000", ",", "01", ",", "01"}], "}"}], "]"}], ",", 
       RowBox[{"DateString", "[", 
        RowBox[{"{", 
         RowBox[{"2018", ",", "01", ",", "01"}], "}"}], "]"}], ",", 
       "\"\<Week\>\""}], "}"}]}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"tempLinearTrend", ",", "tempDetrended"}], "}"}], "=", 
   RowBox[{"detrending", "[", 
    RowBox[{
     RowBox[{"temp", "[", "\"\<Path\>\"", "]"}], "[", 
     RowBox[{"[", 
      RowBox[{"All", ",", "2", ",", "1"}], "]"}], "]"}], "]"}]}], 
  ";"}]}], "Input",ExpressionUUID->"e865170a-bb77-4acf-addd-084cf53eb056"],

Cell[TextData[{
 "No primeiro gr\[AAcute]fico abaixo mostro a s\[EAcute]rie temporal. No \
segundo gr\[AAcute]fico \[EAcute] plotada a diferen\[CCedilla]a semanal de m\
\[EAcute]dia de temperatura dividida pela m\[EAcute]dia da s\[EAcute]rie como \
fun\[CCedilla]\[ATilde]o das semanas. Daqui para frente trabalhamos com a s\
\[EAcute]rie de diferen\[CCedilla]as, pois queremos trabalhar com uma ",
 StyleBox["s\[EAcute]rie estacion\[AAcute]ria fraca, i.e.",
  FontSlant->"Italic"],
 " uma s\[EAcute]rie onde primeiro e segundo momentos estat\[IAcute]sticos n\
\[ATilde]o dependem do tempo. Isso \[EAcute] necess\[AAcute]rio pois queremos \
usar as redes neurais para prever res\[IAcute]duos n\[ATilde]o-lineares. A S\
\[EAcute]rie de Diferen\[CCedilla]as \[EAcute] uma s\[EAcute]rie que, al\
\[EAcute]m de quantificiar a varia\[CCedilla]\[ATilde]o de temperatura m\
\[EAcute]dia de uma semana para outra, n\[ATilde]o apresenta tend\[EHat]ncia \
linear com o tempo."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"f05e6667-a491-4735-a931-7eba453c69ea"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"{", 
   RowBox[{
    RowBox[{"DateListPlot", "[", 
     RowBox[{"temp", ",", 
      RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
      RowBox[{"Frame", "\[Rule]", "True"}], ",", 
      RowBox[{"FrameStyle", "\[Rule]", 
       RowBox[{"Directive", "[", 
        RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
      RowBox[{"FrameLabel", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"\"\<Temperatura M\[EAcute]dia (\.baC)\>\"", ",", "None"}], 
          "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"\"\<Anos\>\"", ",", "\"\<S\[EAcute]rie Original\>\""}], 
          "}"}]}], "}"}]}], ",", 
      RowBox[{"FrameTicks", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{"Automatic", ",", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
            "\"\<2000\>\"", ",", "\"\<2003\>\"", ",", "\"\<2006\>\"", ",", 
             "\"\<2009\>\"", ",", "\"\<2012\>\"", ",", "\"\<2015\>\"", ",", 
             "\"\<2018\>\""}], "}"}], ",", "None"}], "}"}]}], "}"}]}]}], 
     "]"}], ",", "\[IndentingNewLine]", 
    RowBox[{"ListLinePlot", "[", 
     RowBox[{"tempDetrended", ",", 
      RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
      RowBox[{"Frame", "\[Rule]", "True"}], ",", 
      RowBox[{"FrameStyle", "\[Rule]", 
       RowBox[{"Directive", "[", 
        RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
      RowBox[{"FrameLabel", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
          "\"\<\!\(\*FractionBox[\(\[CapitalDelta]T\), \(\[LeftAngleBracket]T\
\[RightAngleBracket]\)]\)\>\"", ",", "None"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{
          "\"\<Semanas\>\"", ",", 
           "\"\<S\[EAcute]rie de Diferen\[CCedilla]as\>\""}], "}"}]}], 
        "}"}]}], ",", 
      RowBox[{"Axes", "\[Rule]", "False"}]}], "]"}]}], "\[IndentingNewLine]", 
   "}"}], "//", "GraphicsRow"}]], "Input",ExpressionUUID->"12084e41-e485-4332-\
b98f-23be4f7ad43b"],

Cell[BoxData[
 GraphicsBox[{{}, {InsetBox[
     GraphicsBox[{{}, {{}, {}, 
        {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
         0.0055000000000000005`], AbsoluteThickness[1.6], 
         LineBox[CompressedData["
1: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
OzleIh4P3+X8//73/wCEo2x2
          "]]}}, {}, {}, {}, {}},
      AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
      Axes->{False, False},
      AxesLabel->{None, None},
      AxesOrigin->{3.1556736*^9, 17.026500000000002`},
      DisplayFunction->Identity,
      Frame->{{True, True}, {True, True}},
      FrameLabel->{{
         FormBox["\"Temperatura M\[EAcute]dia (\.baC)\"", TraditionalForm], 
         None}, {
         FormBox["\"Anos\"", TraditionalForm], 
         FormBox["\"S\[EAcute]rie Original\"", TraditionalForm]}},
      FrameStyle->Directive[18, 
        Thickness[Large]],
      FrameTicks->{{Automatic, Automatic}, {{{3.1556736*^9, 
           FormBox["\"2000\"", TraditionalForm], {0.0125, 0}}, {3.250368*^9, 
           FormBox["\"2003\"", TraditionalForm], {0.0125, 0}}, {
          3.3450624*^9, 
           FormBox["\"2006\"", TraditionalForm], {0.0125, 0}}, {
          3.4397568*^9, 
           FormBox["\"2009\"", TraditionalForm], {0.0125, 0}}, {
          3.5343648*^9, 
           FormBox["\"2012\"", TraditionalForm], {0.0125, 0}}, {
          3.6290592*^9, 
           FormBox["\"2015\"", TraditionalForm], {0.0125, 0}}, {
          3.7237536*^9, 
           FormBox["\"2018\"", TraditionalForm], {0.0125, 0}}}, None}},
      GridLines->{None, None},
      GridLinesStyle->Directive[
        GrayLevel[0.5, 0.4]],
      ImagePadding->All,
      Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& ), "CopiedValueFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& )}},
      PlotRange->{{3.1556736*^9, 3.7237536*^9}, {17.66, 30.33}},
      PlotRangeClipping->True,
      PlotRangePadding->{{
         Scaled[0.02], 
         Scaled[0.02]}, {
         Scaled[0.05], 
         Scaled[0.05]}},
      Ticks->{{}, Automatic}], {192., -116.80842387373012}, 
     ImageScaled[{0.5, 0.5}], {360., 222.49223594996212}], InsetBox[
     GraphicsBox[{{}, {{}, {}, 
        {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
          NCache[
           Rational[1, 120], 0.008333333333333333]], AbsoluteThickness[1.6], 
         LineBox[CompressedData["
1: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
          
          "]]}}, {}, {}, {}, {}},
      AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
      Axes->{False, False},
      AxesLabel->{None, None},
      AxesOrigin->{0, 0},
      DisplayFunction->Identity,
      Frame->{{True, True}, {True, True}},
      FrameLabel->{{
         FormBox[
         "\"\\!\\(\\*FractionBox[\\(\[CapitalDelta]T\\), \\(\
\[LeftAngleBracket]T\[RightAngleBracket]\\)]\\)\"", TraditionalForm], None}, {
        
         FormBox["\"Semanas\"", TraditionalForm], 
         FormBox[
         "\"S\[EAcute]rie de Diferen\[CCedilla]as\"", TraditionalForm]}},
      FrameStyle->Directive[18, 
        Thickness[Large]],
      FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
      GridLines->{None, None},
      GridLinesStyle->Directive[
        GrayLevel[0.5, 0.4]],
      ImagePadding->All,
      Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& ), "CopiedValueFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& )}},
      PlotRange->{{0, 955.}, {-6.684636983512796, 5.705794124734346}},
      PlotRangeClipping->True,
      PlotRangePadding->{{
         Scaled[0.02], 
         Scaled[0.02]}, {
         Scaled[0.05], 
         Scaled[0.05]}},
      Ticks->{Automatic, Automatic}], {576., -116.80842387373012}, 
     ImageScaled[{0.5, 0.5}], {360., 222.49223594996212}]}, {}},
  ContentSelectable->True,
  ImageSize->{1201., Automatic},
  PlotRangePadding->{6, 5}]], "Output",ExpressionUUID->"383a2972-ba69-4d74-\
acb7-81aaeaea14a7"]
}, Open  ]],

Cell["\<\
Ap\[OAcute]s remover tend\[EHat]ncias lineares da s\[EAcute]rie original, \
olhamos para o espectro da s\[EAcute]rie de diferen\[CCedilla]as. \
\[CapitalEAcute] poss\[IAcute]vel ver um pico altamente dominante. Usamos as \
fun\[CCedilla]\[OTilde]es definidas na se\[CCedilla]\[ATilde]o anterior para \
identificar a frequ\[EHat]ncia respons\[AAcute]vel por esse pico, fazer um \
ajuste n\[ATilde]o-linear de uma fun\[CCedilla]\[ATilde]o do senoidal e \
remover tal fun\[CCedilla]\[ATilde]o da s\[EAcute]rie de diferen\[CCedilla]as.\
\>", "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"49ef5300-1835-4895-8cd6-63144ae473cc"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"tempSinusoidalComponents1", ",", "tempSC1"}], "}"}], "=", 
   RowBox[{"removingSinusoidalComponents", "[", 
    RowBox[{"tempDetrended", ",", "10", ",", "1", ",", "0"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"{", 
   RowBox[{
    RowBox[{"Periodogram", "[", 
     RowBox[{"tempDetrended", ",", 
      RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
      RowBox[{"ScalingFunctions", "\[Rule]", "\"\<Absolute\>\""}], ",", 
      RowBox[{"Frame", "\[Rule]", "True"}], ",", 
      RowBox[{"FrameStyle", "\[Rule]", 
       RowBox[{"Directive", "[", 
        RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
      RowBox[{"FrameLabel", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"\"\<Pot\[EHat]ncia (u.a.)\>\"", ",", "None"}], "}"}], ",", 
         
         RowBox[{"{", 
          RowBox[{
          "\"\<Frequ\[EHat]ncia (u.a.)\>\"", ",", 
           "\"\<Espectro - tempDetrended\>\""}], "}"}]}], "}"}]}]}], "]"}], 
    ",", "\[IndentingNewLine]", 
    RowBox[{"ListLinePlot", "[", 
     RowBox[{"tempSC1", ",", 
      RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
      RowBox[{"Frame", "\[Rule]", "True"}], ",", 
      RowBox[{"FrameStyle", "\[Rule]", 
       RowBox[{"Directive", "[", 
        RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
      RowBox[{"FrameLabel", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"None", ",", "None"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{
          "\"\<Semanas\>\"", ",", 
           "\"\<S\[EAcute]rie sem componentes senoidais 1\>\""}], "}"}]}], 
        "}"}]}]}], "]"}], ",", "\[IndentingNewLine]", 
    RowBox[{"Periodogram", "[", 
     RowBox[{"tempSC1", ",", 
      RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
      RowBox[{"ScalingFunctions", "\[Rule]", "\"\<Absolute\>\""}], ",", 
      RowBox[{"Frame", "\[Rule]", "True"}], ",", 
      RowBox[{"FrameStyle", "\[Rule]", 
       RowBox[{"Directive", "[", 
        RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
      RowBox[{"FrameLabel", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"\"\<Pot\[EHat]ncia (u.a.)\>\"", ",", "None"}], "}"}], ",", 
         
         RowBox[{"{", 
          RowBox[{
          "\"\<Frequ\[EHat]ncia (u.a.)\>\"", ",", 
           "\"\<Espectro - tempSC1\>\""}], "}"}]}], "}"}]}]}], "]"}]}], "}"}],
   "//", "GraphicsRow"}]}], "Input",ExpressionUUID->"c07090bb-0d33-4d68-8300-\
5a5d6af17869"],

Cell[BoxData[
 GraphicsBox[{{}, {InsetBox[
     GraphicsBox[{{}, {{}, {}, 
        {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
          NCache[
           Rational[1, 90], 0.011111111111111112`]], AbsoluteThickness[1.6], 
         LineBox[CompressedData["
1:eJw1mQlYTO0bxttDoUUKKQoRUVESn/so2UMi2dcs2eXL1keUJckuS7IlFKXS
pqJ936dtZpqZ9k3a903/OXPef1fX1TXXnDnzvu/zPPf9u09T95/aZCchJiYm
EBcTo//+/+fe75aOWoSafo1rcnOfY4UNjbrlp++uoZjX+3DJzIa1//x8SuJd
9fr8hKPYPN1yrd0JSfL+GahKnlr0+bopVaJ/9Hjg+X+h+1lH1tbdiFx/ETvz
nkTLHleh9BT3GnSOvoLIb0U6HvP0yOev4dGjVbcGLaZQ8RdmD6hvckG+88K7
qgXq5H43UPf0dsuZ5W34U/+RD+9bWNHj6W4zshXM/d0gXV1xkpWkTqlu04rb
X++OM6v9Z1vPVSDfdw+zr0wL9qucSIkun/AABV++x17fNwTm+x+i3yF8scIZ
bSr81V2zzXgEt8M/Im7GGJL1PMYKcZM3a0NeUVmbM77XHHyC5celxk9SlyPr
ewqFhP27HSf+RYX8iOnn73iiyGdzONtiLMWs9xlULFac0r5Yj54kC88RQc/h
Oe2QVJRLP1n/C+zqvXdfYcoTyP/nIvuy6CWKX+52/LS9Fcx+vDBsOVyoJCVN
aRnRK3qF+qP308od+sHs7zUO/V6yZdUDbWph09+GmClv0PDwp+V9C0my37fo
6Nly3bmwBx83vdbT8XkL3vPQdePX1JD9v8Nvn4PlSofkqeC5/9S2hL0DLjXs
RGYnmPN4j2ubHlhZXRxBxYzivY5Me4/FVa2mfudVyPn4YP4/7gGFJ0yp1NpL
W6+V+sAzV5pqu6VFzusDJqmum3nUtR3CxSisaf6A9qexW1cfliLn54tvFpY1
er0SFH13JfGPMPGbFnDQQJFizvMjdMIbD8pSXNTRt1f+BK/GdJPCcEVyvp+g
ZXbR/KSFEtVu073ow4zPML+q11XlJkkx5/0Zd+zKrULsKjFo+LT9+CI/7Jh6
8YLyukfk/P0Qbx30as6TuZTs2AVfjNb5w/yCrcrAOD6phz/W7J16c82Uv1Bq
ZB34u/sLkvinR0RGdJD6fMFk36aTVdPioZ56Rvj7Ffa30k9I1SmRen2FnQM3
TNdUhtLxUSi67xqAzm7+8Kd9kqQ/A6F4YI73tzU9MLz6zcP2WSDe3tg32+tq
NZh6fsMfydkrbkurU//sWL9iqv83LKp3fvfwRw+Y+gYhNzTTqMOiBh+8HIfP
7Q7CyEL9irFqwaTeQfBf/+DrCttq+I1M2cGpC8KsuVqnT3e1kvoHQ/78e+Ol
OwUIPK8S+c+ZYAw+TDFJlesD0w/BSLcs0JuZ0YXQmoPj3vcHQ0syaJ1tfhPp
jxCMtjlsuuNIB35Yh56WcQ1B3S6317qWXWD6JQRzsy8+eJOnQcXGS2bbj/4O
1zQFRw35LjD98x1eFc45sWPHUEnzrGflen6HjrbD3xz1EaSfvuPFKkMtNf9S
pHu/vzF/SihkP2qExVr+v79CEaSWbn22oBS5cu0Vz/xCcfJyVGDrMgWK6bdQ
PLl87XdcehsKLy5bOmgYhuzwH2/OXpQm/ReG4NKCHrlLQeDUPXi5NyYMrBeF
C1lDiWD6MRw3tL+MNRYbRNmW8u4ki3CsaJq+XUru//Mejgt2j/LEXXtQnUhv
IBxZLpIfNWU0KaZfI1BUs62TY69NNRjQBY7A+Vkn1MQ8+4ieRaBJ/VyV1WMx
quVNjnAHEbij8iuUbdsEpp8joezu9mU4lY3O0RpHbI5FYu6T8692bPhL9CQS
+v3rXwp2SlD9l08kRXVGIrj8jF6XRh/p9x8YmJkeNXipH8PCbtK88gN3m7jh
istViD7/gFNdWpqryTxKypbu+CgsPWQzzokjTuYhCpceagS9TNekRtHt8yAK
doGPCqsXV5D5iIJZ0JWJCt5SlOjyidHQKZoSo/3tD5mXaODIZ6/KT3KUsHke
BvlEw3T2NXunEAmi19FYdG7bhJ2jplIThdUapxeDommnvzrdUKSYeYrBwdId
5vHZMpTmlRdrLobH4JNunAXvaA6Y+YpB/6hzH8T1dalpogP9CZ1eiXtKYYVg
5u0ntt3Xnl10XYrS3W4iaZb+E4v1P0iU5bcR/fyFufpLUk6Zj6Lmpd3a83HT
L0ywSZojPyBGMfP4C/FeXYkzSkdQRsYl0aN4v5DvMFZv/TIVorexCF0nd15l
2V+YfpihdsouFn8WzPSVbegHM6+xyDzmHpZUL05ByfFcQbPw+vsebb6j+WR+
45AkCZ5c3yDo05i0JA6tW53/Tj+cQ+Y5Dsck6x4Yr86HsNnG5zjH4ZLJNoud
njVkvuPwXkqmZqefODVzbshy5+Q4pKT9qZseqUgx8x4HlvlgZ4JBH3RrOGcN
R8XD6XvCClcFOeK/8fg25Ou8ql+J0nslLlxSPFinyy7Ul42hGD2IxxJxu70O
NkPQp8fzcTysor3Y1PZ+og/xWC034YntSHnKcJTV0Cp2PIxh/qX9RgTRi3gk
tdz8+NuPA1G51BOgPVTlY2suS/w2AXOXWlr/VJhCmVx4uy1gXwKKVujzlht3
Ez1JQKei48VXV/phKipQAu4YzzscGl9O9CUB+nnRIdKuhaBXo9iYgEzt/xK6
m+rA6E0iIkbFHZX+mwXKW1U4oomYJsi5dr5NnPhXIsJnvtSiTMUo8810hRKx
Z6t/2pqFLDB6lIglaqrvxHzDYCF3mJr5IxFBT6qyFBK7wOhTIswWKgSaxrtj
VcK9k1yhbmzm1ht9aBWnGL1KwgMT/nudfwew9iK94ySEeZUF2O98D0a/kuDj
2cl6Oj8WlvqCjKW3klD5X4rm2wWdRM+S4OGwdFPAZXFqY510X2tmEiQ3niiv
esImfpqEUS5L5jZP7oQ13Q4KyaDMvYIWjJKkGL1LxtulVhI27p3YIvpJhobU
5SssZwEY/UvGSaPd+4KiZSjR+L9MxsWbOBV+sproYTJSle84dd+pwY7ED8E/
BMm4E7U4nzvQSvQxBVptzmrjhkZSuy5llR3TTkGUfVagxF8VitHLFEyzKbYd
eNUEeto0jqRg8r1gjZwVvUQ/U3A4753Z6AUhOCDs/ryvKWi5rHN84S4VitHT
FFSdmOR0laVC2b0xt7/elgJzzzE9xpQs0ddUeJe/zbfYOoESiuPzBcapUDu5
SO+uZRkYvU2FYn5AwJzlwzg2+nFK7aVUHDZlzQ5/KEH4IRX+nx+5LEvuB62e
z2NT8WLX1f9S9wvA6HEqrk3Quzxk2YPTlyu11kql4U3ai16H9QVEn9MQt0d8
9VZ3WcpBNABpONbikjC6LpnodRoW71VOsY6SpBxFC0rD9TfLXzqUixM+SUPb
6EcjPf3ZELU/Kw3y60NvOPT3gNHzNJjNoCaZjSvBZXq7qul4+ltWZWjw//qe
jjhDl7vT9bi4Moae+HQYqDTFvphQR/Q+Hb7zvC8FDMTDOTlv4YW36ZCpcXKf
Y9xB+CcdLU8tfttmdcHFqddOtyYdDqvV340sHAbjBxnYeHn48B9FDm7On/KE
NysDo3c3ptZ/Vyb+kIEQ7yXJ+4Vccvv3SuEEZCDhwdFZ1oqSxC8y4Hdb9Zcu
pxfu7061Ut8zsN3Gw+3NonziHxnQMlmtwy6XoO7ZPtPo6MnA6n9Gv1hmHQvG
TzKh65s3mHk/HQ/Gxq7zXZKJ6qTkkOgsPvGXTPw+KrMh4qU4RVd367VM9NYF
Gxu9rQTjN5m4x31hqtdUC8//6APKhO3hP3pGXxMJv2Viw4VU5fITqpSweYQC
n4XMU9O+/TrZA8aPsqClNXp6hJZAyJ27pE9uyIJjZp1n5ucGwntZsOrbLnu3
MQev6XF/kgUj7tIs6zORYPwqC5bcu2Jrjr2GqLzsLPRYZIdLVbcS/8pCoOOD
w0mJKRDZ1eRsVK9vdYvflAfGz7KxoXPALXtgCB9TB38a78+G5j+Rc1qjpAlP
ZmPMkPcjfet++F2hP5GNd1nBG/f8LAfjd9lQVeWWVcY1gz5Nr8ZsOKqu9//0
pZb4Xw7+jCnYpVYqTQX+cVhlqZ8D7uUt2Wy5IDB+mIN1elNS3rCbEexDG1IO
tC/PCK2QCyS8moOksh07br8uwffttEDkwHx+9PhN6jwwfpkD/vOX5+VyWxCu
SBcsB0FWi2ZJ8nMI3+YiQnn8SBNnBeqHUE3Gm+eiWT5N/1uqOMX4aS4mjPO0
1nw7jOirtAPkwnf6yVUjS9OJv+bCbGlEqGZ4BX4Z7xdKkPD1pseh9T+6wfht
Lobq/l0SzU0GrUaeI/LAfb5dYLWGTfw3D0b21yV8dndiP4u9s0U3D7+3uYrd
U4wmfpwH1/ZrZ1uau1AVQB9QHs7Np9rcSsuJP+cheprJum97u3HQTUzY4nnY
7O43RnN8AfHrPOSWP6nzuNGGWtoOH+bBof/bvJaCRuLfefgpGKF0dL4ERbuL
dWgeykZucTw1vRuMn+fh6h89y5prBRDJY3EelsTwWp+9Gk/8PQ+xWQtWJz5r
hH3PBqFD5MHn0ezLDj9/EL/Px5VyH7G7FRyIxmVSPia2BTbJfGon/J+PepP/
Zucq1eG4yPDzYW9luW3QrAMMD+SjMqbhCGuZFNUsvFpxbz7uuRla7D0xTPJC
PvLkN9uFKKpRp0QCnY86n6HvlqdGUAwv5GO2SfpBz1u9EA6/sEPy8VbMbI+L
0wSSN/NhdSem6VlpFc6KBiof+l5KgznZIWB4Ih+KDfqKrQFjqY4e7u1/G/Lx
Rvra9I1v6wlf5MPC3HHp7WshEBZbqNgsjF+p6z9VIp3wBgt7m3P9Xui2oztQ
IkJnLgsq/IknPgrKSH5h4dq93uTRU1ogKtdGFnjrTs1g9wyC4REWWpTMbhl6
SFO0OnLOsrCwZJPF27ZkwicsmKYfz4vfKkZdou32KQv6iYsPs+oaCK+wsNsy
ygGcCAhhQ/luBAvyzp/nt6lmEn5hQY3bKm36JgH/ib6AhbhH25VG1pYRnmHB
YPv+ob5p9fhbQBs6CzrZ8XsmXeETvimAjH/2gLTwOtE4ahSgl/dgaouzOMXw
TgFcd/y8aOZWAnGRABfg+desX0nv20n+KsDFbZkSYS7puH4o7ObqAwXQ1Zza
ZTrx/zxUgFTVmDtphl0QiomQaISfT3Tfd/fqCJLXCjCU0xC77PEI6sZkfujA
pwLMWfFp86MBPuGlAqEPOWWtMO+GjJBeNmcUQH2Hn/+lhaWEnwpgJ3HVcJrn
MG4VSglHrABtX6qOJ89qIDwl7HuN9i0VsiyMDFLrlxlbiNf3Rmj5L0okebAQ
pd+G9qTEKVF36PY0KMTGjYfimsM6CW8Vwv6Df2Xnk78QLce6ELVewx8bpOoJ
fxViX1rCyPttVfAwozdciB088bWVysmExwpxdWBW7Ofb1RhD2/lz4ftNKVe3
2LUSPivEr2oszZfsxf0+2rALcePgUM77n4NgeK0QM1r+VUhNlaYUaXnnF2J+
765Valo1hN8KsbJ40fN9O1PxKIgW2EJozpLV1jsjSTE8V4T28ZHvjGYKIGye
kNypRXi7luXZoRpM8mwRFhdNPeLoK0E9PZyZPnN5Edbev3oA+6oJ7xXhwKLp
ltxdFRhvXlZ+7VARthcG6rT7y5D8W4Sk5pS/pzdxQLsv93aRMH+pdas3s8Dw
YBHqY18VuM1rxwTh6S/4UoQN4y5zgkqVKIYPi3C+MG3gTEMPXhZNnOGRXYR5
uTpfJmcUE14sQqaNyab9KzMxSTTwRRjza0z5UdQRfizGn7V/rJ9Oaoc3PY5K
xdjt7pLb65UIhieLIZnS59q0QJkSHf+CYiz4Lp52M72L5PFiZDy7n7n9QCtE
eGhTjGTXgUDbcR2EN4vx73SJhOqbnZgqMuRi9G0eKNbV7yL8WYxgzxuFYX+7
IMIFL+H97B9Uuh7pJjxajC177k6aHCxOaRf7Ch24GHe9l48L8O0neb8Yk1VV
tCo8i+Er3O2W8mLMP/HKSsOfC4ZXi1EuZar0oisSwsPpCpQogZfa7UPT2+LJ
86wSPGrvOD1h8zA+HaFXVIL9ncFO0tf/guHZEsz3FCRmVw5g1vIu7X0rS3BF
fdlnjbt3CN+WwOBIWJdrQDX8NUcujjpagkMv+WPi3cQphndLIFEwjnuX24fZ
IgEqQdGFKx5vnWQJ/5ZAv9jAY7khGwHFdEOU4P7UyU+O87oJD5fgfdsOwa+K
VjB2JLzf9G5vMd4fwsclmGh3W7o4RpoSyU9HCYzDvduaDwURXmbj6/avCdm6
MpQB3W4qbGy5rPKsV6aR8DMbe8Q7XhRHsyC6/UI2Or07c59vbwHD02y8mcZh
PZOKwAIaP7ez8Wlg3VLDgyzC12xMWR73NYAtR4UNfOq47sTGwZIVHidNJhPe
ZiO3Z6Gzx/NOiHDkNRvzjdesl4gZIs9P2Jh6eNIJ9ZNZiBROl1E8Gyv6I2/p
+FQQHmcjqtZ4/dOMDiy6V2Vyr4qNmdE5PYbVLYTP2bA41P2n+Wgloo7SBsxB
zuwpHvzbMhTD6xw4TXy++dPqUiwRCSIHN0ZNLo6q+k34nYN/GwMXtzp04+cU
ukE58BjR9nuTTDnheQ6O2E7Z+i26HEtFH+DAly1WufvWeIrhe+H1f5ep15vy
EVey4uva+xy8bHdc5hjfRHifgw8VjjrWzlVYJgI0DkZ5PA67qJxF+J8DSS3P
tUuX9oGRWw5ur9GUdL/zneQBDqZZHBoq31OJ5fR4dXPQdnrG1cxNfSQfcPHz
ZqH0jRY+kunjVOMiIXSM3J7z0hSTF7iY9xM3WUd9IIQ1YYdyYa2cvmbbhdEk
P3Cx5+GZmHqtZqTReLuLC5dtrNka4n4kT3DxKtlUVXE9D6vZ+ZbRV4XvzzF6
wDkrTfIFF9LzXd2O9wWCVvNx77nYWXH8vUezFMXkDS781u5vHraJxzqRQHPh
bGB1rli5juQPLuTTl9g92dULoZkKB4YL76Aqb78FHWDyCBctr81ydPsasF60
gVJkfbTnBc0qIfmkFMfOOnoKOGJU3lSaOEoR+tzC7nPHEMkrpZBtk1ZLteyD
iGYsSxGxTtq0XSaf5JdSqKhO2ya9SIwS4efpUtQ6eJ12/NgHJs+UIuqxg9PU
R93YTOPGo1LMcDY89jKoieSbUthbRE9dvEGo27S9hJZiofz74UnD7STvlOKj
qtW+39l5YOSkFMpHVDTtPOJI/ikF4mVr5AzSwabbp68URe9dMq821oLJQzxM
Vpp8Y71NJkSXT+JhU7Rxec6dRpKPePh18Ffbh99sCJtH6Eg8ZM66lTOwwpXk
JR7sW46O7licjp0iw+AhcueFEV1KjSQ/8fCPG3eg2CMPND10XOchuH3ep43s
cpKnhPdP3Rpw9vU4arfoQHnwlKpLiIuuI/mKh1t6/X+kzGpQfoxWaB4WaJut
8/EPJ3mLhwTBx2lV22KwbyWdOHi4V+eoZLC4iuQvHqKqvqfYz60CrVa28nwU
muZlrJzXT/IYHyrnHb7XyNfgoJCeg+fyYXbzkkuIdgXJZ3w8m5fIvr6uACLc
tuJD1dfHvW6gjeQ1Ps4F/JfGkS3FYRqvHPhwfrd6X+xQB3k+ycfW+A9dlfZN
qKft9Ckfq86qVgoUCkme40Nh/u+PIRZNEMlnJB8rFbdwp8g0kHzHB3un8rJZ
lDcaRePCh5XLBa15BjIUk/f4qLIXnBoXJsBxkYHxMfd1dI3ylTqS/wSo7eke
6zDcC1Ec0xTApa7htOWudjB5UACen6X7oQV1OCUqsAAmo2wsxRc3kXwowIna
Uz5KIwfRStPqAQHmRoRz7kpWkrwogPym4tAThqU483C6xJybAqy72VK9854b
yY8CbJvYbDQjmoOO44sm3PgsgHXdE9dBGwHJkwJEeSRoFqoW4Ry9mgwBNM6o
2x77t4DkSwHWWpzL0rerB+2OC5sEmDf06efxKi7JmwKEcOzPWdX+wXlhWnsw
tgwBw7/qDjrVkfxZhoOxwdHmXTHopeOFQRkMXHJWRi8qAJNHy9CnLaNXa1kB
EU5uLsNmzYvShuJc8ry3DPqLHOR5FTwM0PjgWIbvV05FsTmjKSavlkHXKPOA
RnIKnESGWgYZlREa/teaSH4tg9axo3lpgmKI5CG6DGdCN7ykfLNJni2D0eqT
U9xqv+CqqB3KQOXt02t/VkXybRlGGRy7k97cCOa/ueWQHHOh4LyhFPU/JsO/
6w==
          "]]}}, {}, {}, {}, {}},
      AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
      Axes->{True, True},
      AxesLabel->{None, None},
      AxesOrigin->{0, 0},
      DisplayFunction->Identity,
      Frame->{{True, True}, {True, True}},
      FrameLabel->{{
         FormBox["\"Pot\[EHat]ncia (u.a.)\"", TraditionalForm], None}, {
         FormBox["\"Frequ\[EHat]ncia (u.a.)\"", TraditionalForm], 
         FormBox["\"Espectro - tempDetrended\"", TraditionalForm]}},
      FrameStyle->Directive[18, 
        Thickness[Large]],
      FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
      GridLines->{None, None},
      GridLinesStyle->Directive[
        GrayLevel[0.5, 0.4]],
      ImagePadding->All,
      Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& ), "CopiedValueFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& )}},
      PlotRange->{{0, 0.5}, {0, 1836.5738495589044`}},
      PlotRangeClipping->True,
      PlotRangePadding->{{
         Scaled[0.02], 
         Scaled[0.02]}, {
         Scaled[0.02], 
         Scaled[0.05]}},
      Ticks->{Automatic, Automatic}], {193.5, -116.80842387373012}, 
     ImageScaled[{0.5, 0.5}], {360., 222.49223594996212}], InsetBox[
     GraphicsBox[{{}, {{}, {}, 
        {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
          NCache[
           Rational[1, 120], 0.008333333333333333]], AbsoluteThickness[1.6], 
         LineBox[CompressedData["
1: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
4UNNBqx3Dv9+Mf/B9P8B1lxHgQ==
          "]]}}, {}, {}, {}, {}},
      AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
      Axes->{True, True},
      AxesLabel->{None, None},
      AxesOrigin->{0, 0},
      DisplayFunction->Identity,
      Frame->{{True, True}, {True, True}},
      FrameLabel->{{None, None}, {
         FormBox["\"Semanas\"", TraditionalForm], 
         FormBox[
         "\"S\[EAcute]rie sem componentes senoidais 1\"", TraditionalForm]}},
      FrameStyle->Directive[18, 
        Thickness[Large]],
      FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
      GridLines->{None, None},
      GridLinesStyle->Directive[
        GrayLevel[0.5, 0.4]],
      ImagePadding->All,
      Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& ), "CopiedValueFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& )}},
      PlotRange->{{0, 955.}, {-4.222728818452458, 4.552741639603137}},
      PlotRangeClipping->True,
      PlotRangePadding->{{
         Scaled[0.02], 
         Scaled[0.02]}, {
         Scaled[0.05], 
         Scaled[0.05]}},
      Ticks->{Automatic, Automatic}], {580.5, -116.80842387373012}, 
     ImageScaled[{0.5, 0.5}], {360., 222.49223594996212}], InsetBox[
     GraphicsBox[{{}, {{}, {}, 
        {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
          NCache[
           Rational[1, 90], 0.011111111111111112`]], AbsoluteThickness[1.6], 
         LineBox[CompressedData["
1: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
Vd9XlqLVkXechRFlVqbP29IJn7BglH24KPlfCeoMbbf3WRiTutyBVf+T8AoL
meZfXMCLhQg2VG/EsuDv+W5hm0Yu4RcWOPxWWcNnKTgn/gAWzt3bpqLwo5Lw
DAuF2/YO9k5twF82begsXM9L3jXBo4LwDRulwfn9sqL7xOOoyUZb+e0pLecl
KYZ32Hi3/evp1d5lkBQLMBs3P+R9S3vZTvIXG45bc6WiL2Xj4v7oK2b/sTFX
a0qX4fj/8xAbXhoJ17P0uyASExHRsHEp1WfPDc9hJK+x0VLwM3HVvWHU5UkV
Uf1v2Viw5u3mu/0VhJfYUPjlnrfGuBtyInrZnMPG4LbgkDNLBISf2Jgl5ak/
1X8IVzkyohFjI+R97eH0mT8JT7EhpdW+pVqeBYXwsX1yozhQuzlMO2RZKsmD
HHz/OLgrI0mFuk635wIODm3an9Qc3Ul4i4OTr0JqOv3+Qrwcaw4Ej4be/JRp
IPzFwc6sFIVbbbXwXU1vmIPn5ZIbalTTCY9xYNU/M/Hdte8YSdv5Qw6cmjI8
t9i3Ej7jgPMdRsXSf3CrlzZsDk7tGyx4+XUADK9xMKrl5OjMTFlKmZb3Cg7W
/Nmxbqx2HeE3DhpLlz3cY5eJu+G0wHIwf6a8jp6zNMXwXAk8xsS9WDxDCFHz
fCqcUoJQc5Z/h0YEybMlWFAy5YDraynqvkNu9gyTEry75fkf9nwnvFeCr8t0
Lfg7qjHGuLLqwv4SvOKETW8PkSP5twRoyfh7zIoH2n3510rwYurY7onNLDA8
WAKrpMds73ntGCeq/qL3JZigdpYXLlChGD4sgRknq9/5Zw8CS8ZP880vQXDB
9PeTckoJL5agwWap1d61uZggHvgSOHwbWeWIesKPpeja8Nv6/oR2PKHHUaUU
0T6XCv88SgXDk6WQzuj1alqkSonLv6gUGyMls65kd5E8XoqbD27lbvuvFWI8
tClFiVd/mK1aB+HNUgTqSqV8v9KJKWJDLkXv5v7SWfO7CH+WIsL/Mif6bxfE
uPCoFAkHb9d4HegmPFoK+103JkyKkKR0Sl+LHLgUL56YqIW+7iN5vxTyGura
1f6leC3a7ZaqUjgeeWypGcIHw6ul6JM2VAnoioOoOF1hUmW4Pvbaft22ZPJ9
Vhny2zuOjds8hLcH6BWVYUZnhLvsxb9geLYMY/yFqfk1/Zhp0qWzZ20ZDk5c
9U7zxnXCtyIuPBDd5RX6HSFaCsu/OJbBK7BiZLK3JMXwbhkWs9X4N/i9mC0W
oDJkn/Lwfe4uT/i3DPySBb4m+lyEltINUYb1Uyb5HS7vJjxchpi27cJv1a1g
7KgMVVO7n0iU/yZ8XIZR9tdkSxNkKbH8dJRhMPpJW/P+cMLLXIRv+5CSP0uO
WkC3mzoXVmfVH/yRayT8zMUqyY6A0ngWxI9fwsX4p52FD7e1gOFpLkx0eawH
MrFYROPnNi5K+82N9PexCF9zoWqS9CGUq0hF97/tuOjOxdayNb5Hl04ivM1F
Q8+S874POyHGkadcbDZYv1EqYZB8f8KFjcOEIxOP5iFONF2Lk7mw6Iu7Oj2o
mvA4FxE/DDbez+nAspu1S2/WckX5t6BH/3sL4XMuNu7v/t3sWIMvjrQB85A3
e7JvxTU5iuF1HoLHP9z81kyAFWJB5OHm8EmlX2p/EX4X5eLGsOWtLt34Oplu
UB7WDGv7ZSVXRXiehy22k//9GF8FI/EbeMjiStTsvDqGYvieh1NDqyY2GFYg
qWzNhw23eDjZ7rrKNbmJ8D4PR6pdp1ufr8UqMaDxMNL3XvRp1TzC/zys1Pbf
YGTUC0ZueRCYaUn7XI8keYCHsab7B6t21cCEHq9uHkY5T/PMteol+YCPSVc5
spdbKpBOl3MsHwFRIxV3uclSTF7gw/orrrAcgyCCNVGH8uGnmr1+6yklkh/4
mHfXOaFBuxlZNN7u4CPejjVbUzKY5Ak+ZmcYaihvLIcZt9gi3lOUc+Ysvs07
LkvyBR/TFnp5H+4NA63mai/52FN9+KVvswzF5A0+uBv2Ng/ZJMNcLNB8rFhg
eaJUtZ7kDz5GZK+w99vxR5Rb6YHhwze89knwog4weUT0+rPVBbN6f2KjeAMC
PH5zsDx8ZhnJJwJcOO7qL+RJUEVTaOIQ4OtDU/t3HYMkrwig2SY7NtOiF2Ka
sRDgirmsYbtcMckvAqhrTN0qu0yCEuPnMQHcXR4dc33TCybPCJB2z8V9yt1u
bKZx464AYZ76hwLDm0i+EWCrSfyU5f+UQGwvUQJcH/FyaMJQO8k7AjRrWO75
lV8ERk4EEDioa9n7JpH8I0BVknyd4oJscOn26RW9/+WlXM/GH2DyUDnsVCZd
3miTC/HtE8rhFW9QVXC9keSjcrjs+9b26hcXouYROVI5ds65WtC/xovkpXLo
tDgqdSzPhp3YMMrxe/upYV0qjSQ/lePENX5/qW8RaHrouFiOpR3z3m7iVpE8
VY59mf+GHn+qRu0UF7QctTL1KUnx9SRflcNEr++3zOo6VB2iFbocx3VWmweF
xJC8VQ4n4ZuptVsTsGctnThE1/WuKguW15L8VY6o2siMg3NrQauV7YgK1BoW
5ayd10fyWAUmublE1o2owz4RPUfMrQCunLn0Saea5LMKBM9L5V40Z0OM25YV
mPE6yKe+v43ktQqsDz2XxZMXwIHGK5cKvHlhtidxsIN8P1mBoORXXTUHm9BA
2+n9Cnw8rlEjHM0hea4CAfq/3nwybYJYPuMqIDdqC3+y3E+S7yogv0V11Uzq
CRrF41KBv5dOac9bIEcxeU+0/kNCJ7VoIQ6LDawC3Y/j61Q96kn+E2JNT/co
l6E/EMcxLSFO1P88ZrGjHUweFOJ6sIXP/kX1cBIfsFCkXzYWksubSD4U4uQP
pyAVhQG00rT6nxCLYmN4N6RrSF4UItWqNOqIvgDOd3Sl5lwRIuBqy3e7m94k
PwoRPb558bR4HjoOLxt3+Z0QrQ1+XgM2QpInhdjom6LF0SjBCXo1OUI4O0+0
PXSSTfKlEO6mJ/Lm2zeAdsclTUKUDbz9eriWT/KmEAO8gycsf/yGmyit3R5V
ic1D3+r3udeT/FmJZ4kR8cZdCfhDx4sFlTh/qWBt/DI2mDxaiX4dOb0fFtUQ
4+TmShzROi2rL8kn3/dWIniZy4jy6nL00/jgWglfD6cvXJ4SxeRV0fMW5/6n
mZ4Bd7GhVqJdbZhmyIUmkl8rMfyQY1GWsBRieYivxNSofwKp1/kkz1Yizvjo
ZO8f7+EpbodKTCrco9f+oJbk20oI5h66nt3cCOa/uVVIUzrFdtOXof4HX83J
mA==
          "]]}}, {}, {}, {}, {}},
      AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
      Axes->{True, True},
      AxesLabel->{None, None},
      AxesOrigin->{0, 0},
      DisplayFunction->Identity,
      Frame->{{True, True}, {True, True}},
      FrameLabel->{{
         FormBox["\"Pot\[EHat]ncia (u.a.)\"", TraditionalForm], None}, {
         FormBox["\"Frequ\[EHat]ncia (u.a.)\"", TraditionalForm], 
         FormBox["\"Espectro - tempSC1\"", TraditionalForm]}},
      FrameStyle->Directive[18, 
        Thickness[Large]],
      FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
      GridLines->{None, None},
      GridLinesStyle->Directive[
        GrayLevel[0.5, 0.4]],
      ImagePadding->All,
      Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& ), "CopiedValueFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& )}},
      PlotRange->{{0, 0.5}, {0, 21.544311949903328`}},
      PlotRangeClipping->True,
      PlotRangePadding->{{
         Scaled[0.02], 
         Scaled[0.02]}, {
         Scaled[0.02], 
         Scaled[0.05]}},
      Ticks->{Automatic, Automatic}], {967.5, -116.80842387373012}, 
     ImageScaled[{0.5, 0.5}], {360., 222.49223594996212}]}, {}},
  ContentSelectable->True,
  ImageSize->{1704., Automatic},
  PlotRangePadding->{6, 5}]], "Output",ExpressionUUID->"1b5c5a26-3d2a-480c-\
8406-87f77017781a"]
}, Open  ]],

Cell["\<\
Ainda \[EAcute] poss\[IAcute]vel remover algumas outras frequ\[EHat]ncias de \
menor pot\[EHat]ncia, por\[EAcute]m n\[ATilde]o \[EAcute] poss\[IAcute]vel \
eliminar uma quantidade suficiente para que a s\[EAcute]rie fique \
suficientemente estacion\[AAcute]ria. Isso \[EAcute] feito em dois passos, \
mostrados abaixo.\
\>", "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"ffd907e4-60df-400d-a319-22c984ef1902"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"tempSinusoidalComponents2", ",", "tempSC2"}], "}"}], "=", 
   RowBox[{"removingSinusoidalComponents", "[", 
    RowBox[{"tempSC1", ",", "5"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"tempSinusoidalComponents3", ",", "tempSC3"}], "}"}], "=", 
   RowBox[{"removingSinusoidalComponents", "[", 
    RowBox[{"tempSC2", ",", "3"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"{", 
   RowBox[{
    RowBox[{"ListLinePlot", "[", 
     RowBox[{"tempSC2", ",", 
      RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
      RowBox[{"Frame", "\[Rule]", "True"}], ",", 
      RowBox[{"FrameStyle", "\[Rule]", 
       RowBox[{"Directive", "[", 
        RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
      RowBox[{"FrameLabel", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"None", ",", "None"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{
          "\"\<Semanas\>\"", ",", 
           "\"\<S\[EAcute]rie sem componentes senoidais 2\>\""}], "}"}]}], 
        "}"}]}]}], "]"}], ",", "\[IndentingNewLine]", 
    RowBox[{"Periodogram", "[", 
     RowBox[{"tempSC1", ",", 
      RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
      RowBox[{"ScalingFunctions", "\[Rule]", "\"\<Absolute\>\""}], ",", 
      RowBox[{"Frame", "\[Rule]", "True"}], ",", 
      RowBox[{"FrameStyle", "\[Rule]", 
       RowBox[{"Directive", "[", 
        RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
      RowBox[{"FrameLabel", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"\"\<Pot\[EHat]ncia (u.a.)\>\"", ",", "None"}], "}"}], ",", 
         
         RowBox[{"{", 
          RowBox[{
          "\"\<Frequency (u.a.)\>\"", ",", 
           "\"\<Power Spectrum - tempSC2\>\""}], "}"}]}], "}"}]}]}], "]"}]}], 
   "\[IndentingNewLine]", "}"}], "//", "GraphicsRow"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"{", 
   RowBox[{
    RowBox[{"ListLinePlot", "[", 
     RowBox[{"tempSC3", ",", 
      RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
      RowBox[{"Frame", "\[Rule]", "True"}], ",", 
      RowBox[{"FrameStyle", "\[Rule]", 
       RowBox[{"Directive", "[", 
        RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
      RowBox[{"FrameLabel", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"None", ",", "None"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{
          "\"\<Semanas\>\"", ",", 
           "\"\<S\[EAcute]rie sem componentes senoidais 3\>\""}], "}"}]}], 
        "}"}]}]}], "]"}], ",", "\[IndentingNewLine]", 
    RowBox[{"Periodogram", "[", 
     RowBox[{"tempSC3", ",", 
      RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
      RowBox[{"ScalingFunctions", "\[Rule]", "\"\<Absolute\>\""}], ",", 
      RowBox[{"Frame", "\[Rule]", "True"}], ",", 
      RowBox[{"FrameStyle", "\[Rule]", 
       RowBox[{"Directive", "[", 
        RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
      RowBox[{"FrameLabel", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"\"\<Pot\[EHat]ncia (a.u.)\>\"", ",", "None"}], "}"}], ",", 
         
         RowBox[{"{", 
          RowBox[{
          "\"\<Frequ\[EHat]ncia (a.u.)\>\"", ",", 
           "\"\<Power Spectrum - tempSC3\>\""}], "}"}]}], "}"}]}]}], "]"}]}], 
   "}"}], "//", "GraphicsRow"}]}], "Input",ExpressionUUID->"6cb81fc6-82e5-\
48d5-878b-5455ee7f6f31"],

Cell[BoxData[
 GraphicsBox[{{}, {InsetBox[
     GraphicsBox[{{}, {{}, {}, 
        {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
          NCache[
           Rational[1, 120], 0.008333333333333333]], AbsoluteThickness[1.6], 
         LineBox[CompressedData["
1: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
Dds0DbhtzH1RMppnTVJZv5PqPcNk3NfcPWqcCuEp5Ptvmvio/B3Jb5YMbt6j
m2unUHxykuGUE2Y86hb5o0My7q7UimUPoHzJTYbSkoN+SZpUH3snY3tSrurt
dvJHXjIcHgs0/PrT9yOTUad1IEY5lOm/JWP9jDGX1ecR3xEl47dqBj/cjewp
TgZ/+iz23g66f8qVn69r6fDI1JOE/8lg7zodYPrqINk/GSkjbBexqimeK5JR
mth7dPkkwvvKZIxevzHETMS8T5Dr1/Gw8yYl4sP1yUB504Q7k+j9TlMydoxf
fvblJ8p/LcmI3X67w+8D09+Xn9+iaPyMqdSv7EyGmef7FcXaZA9ZMqq2nnlh
u5L03ZMMfwvnxOXxxLdZKTDXMdr6eyPhu3IKng/1uroyiuRXTcGXrX9buoqZ
+E+BWE/7zisR8Qt2CtLP2ObeeU35TicFazVbZzb70/66Kbg2X2ARXU36NUxB
+Ii31YabyR+RgtP1/f7KvEPxaZaCgMQ316wVKF44KdCcoPWlZwOD/ymI8jzz
kfOG8J6bAuWCfNnIORQP3vLzOr488k/KLbJ/CjhaCXtubyT9R6ZAN/5s7+wf
zPsl+fqTI4oVpxEeilJQVTz92Y+rNBan4FNCXLL5UzpvbgqafTVr1ZPI//JT
MMZz15/DrnR/V5qCoyl1KubnqD9ekYL4v8tDZjHv5ypT8G/T+BVPBcSHJClw
2Tx82IZe4sf1KQgapj+Un0P2akqBwdoz05KryF9bUuDZzHFNn8jc76UAVdNX
DpgkIvunQHDhdcm0T3TfKEuB7GX6jD0jKZ57UuCIWXMX5DH376l44P95i4eM
9KGcikxbg0djEqk/qZoK8YkNA+Yuof67eip0lW5fEIwl/2an4tmiuXOcmffh
Oql41C8vfqMC4ZVuKoKb5qjz7en+3TAVqxU+jVQzo/fDSEX9o2Nbmu8RvzFL
RXhp+wCpMtmTk4qhNUtXTMim/ohDKvKTh9hsy7pA8Z+K91s0/s57T/r0TsXW
7LF7ODXUX+GlQn2Mhd/2SeSfkakotRJNMllB9/F8+fc3zm139aF6QJQKM4fJ
OpuGkbziVLQrlxsMUSR+mZuKUybn3/pMoHyRn4ofJbN+tjH3GaXy/XVOJ1sm
MfdV/9PP3vLtifRepDIVk538PU2iyH8kqei/97OSdyPxi/pU3Guse3SWuV9s
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
          
          "]]}}, {}, {}, {}, {}},
      AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
      Axes->{True, True},
      AxesLabel->{None, None},
      AxesOrigin->{0, 0},
      DisplayFunction->Identity,
      Frame->{{True, True}, {True, True}},
      FrameLabel->{{None, None}, {
         FormBox["\"Semanas\"", TraditionalForm], 
         FormBox[
         "\"S\[EAcute]rie sem componentes senoidais 2\"", TraditionalForm]}},
      FrameStyle->Directive[18, 
        Thickness[Large]],
      FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
      GridLines->{None, None},
      GridLinesStyle->Directive[
        GrayLevel[0.5, 0.4]],
      ImagePadding->All,
      Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& ), "CopiedValueFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& )}},
      PlotRange->{{0, 955.}, {-3.507549528161936, 3.610332038639373}},
      PlotRangeClipping->True,
      PlotRangePadding->{{
         Scaled[0.02], 
         Scaled[0.02]}, {
         Scaled[0.05], 
         Scaled[0.05]}},
      Ticks->{Automatic, Automatic}], {192., -116.80842387373012}, 
     ImageScaled[{0.5, 0.5}], {360., 222.49223594996212}], InsetBox[
     GraphicsBox[{{}, {{}, {}, 
        {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
          NCache[
           Rational[1, 90], 0.011111111111111112`]], AbsoluteThickness[1.6], 
         LineBox[CompressedData["
1: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
Vd9XlqLVkXechRFlVqbP29IJn7BglH24KPlfCeoMbbf3WRiTutyBVf+T8AoL
meZfXMCLhQg2VG/EsuDv+W5hm0Yu4RcWOPxWWcNnKTgn/gAWzt3bpqLwo5Lw
DAuF2/YO9k5twF82begsXM9L3jXBo4LwDRulwfn9sqL7xOOoyUZb+e0pLecl
KYZ32Hi3/evp1d5lkBQLMBs3P+R9S3vZTvIXG45bc6WiL2Xj4v7oK2b/sTFX
a0qX4fj/8xAbXhoJ17P0uyASExHRsHEp1WfPDc9hJK+x0VLwM3HVvWHU5UkV
Uf1v2Viw5u3mu/0VhJfYUPjlnrfGuBtyInrZnMPG4LbgkDNLBISf2Jgl5ak/
1X8IVzkyohFjI+R97eH0mT8JT7EhpdW+pVqeBYXwsX1yozhQuzlMO2RZKsmD
HHz/OLgrI0mFuk635wIODm3an9Qc3Ul4i4OTr0JqOv3+Qrwcaw4Ej4be/JRp
IPzFwc6sFIVbbbXwXU1vmIPn5ZIbalTTCY9xYNU/M/Hdte8YSdv5Qw6cmjI8
t9i3Ej7jgPMdRsXSf3CrlzZsDk7tGyx4+XUADK9xMKrl5OjMTFlKmZb3Cg7W
/Nmxbqx2HeE3DhpLlz3cY5eJu+G0wHIwf6a8jp6zNMXwXAk8xsS9WDxDCFHz
fCqcUoJQc5Z/h0YEybMlWFAy5YDraynqvkNu9gyTEry75fkf9nwnvFeCr8t0
Lfg7qjHGuLLqwv4SvOKETW8PkSP5twRoyfh7zIoH2n3510rwYurY7onNLDA8
WAKrpMds73ntGCeq/qL3JZigdpYXLlChGD4sgRknq9/5Zw8CS8ZP880vQXDB
9PeTckoJL5agwWap1d61uZggHvgSOHwbWeWIesKPpeja8Nv6/oR2PKHHUaUU
0T6XCv88SgXDk6WQzuj1alqkSonLv6gUGyMls65kd5E8XoqbD27lbvuvFWI8
tClFiVd/mK1aB+HNUgTqSqV8v9KJKWJDLkXv5v7SWfO7CH+WIsL/Mif6bxfE
uPCoFAkHb9d4HegmPFoK+103JkyKkKR0Sl+LHLgUL56YqIW+7iN5vxTyGura
1f6leC3a7ZaqUjgeeWypGcIHw6ul6JM2VAnoioOoOF1hUmW4Pvbaft22ZPJ9
Vhny2zuOjds8hLcH6BWVYUZnhLvsxb9geLYMY/yFqfk1/Zhp0qWzZ20ZDk5c
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
mA==
          "]]}}, {}, {}, {}, {}},
      AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
      Axes->{True, True},
      AxesLabel->{None, None},
      AxesOrigin->{0, 0},
      DisplayFunction->Identity,
      Frame->{{True, True}, {True, True}},
      FrameLabel->{{
         FormBox["\"Pot\[EHat]ncia (u.a.)\"", TraditionalForm], None}, {
         FormBox["\"Frequency (u.a.)\"", TraditionalForm], 
         FormBox["\"Power Spectrum - tempSC2\"", TraditionalForm]}},
      FrameStyle->Directive[18, 
        Thickness[Large]],
      FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
      GridLines->{None, None},
      GridLinesStyle->Directive[
        GrayLevel[0.5, 0.4]],
      ImagePadding->All,
      Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& ), "CopiedValueFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& )}},
      PlotRange->{{0, 0.5}, {0, 21.544311949903328`}},
      PlotRangeClipping->True,
      PlotRangePadding->{{
         Scaled[0.02], 
         Scaled[0.02]}, {
         Scaled[0.02], 
         Scaled[0.05]}},
      Ticks->{Automatic, Automatic}], {576., -116.80842387373012}, 
     ImageScaled[{0.5, 0.5}], {360., 222.49223594996212}]}, {}},
  ContentSelectable->True,
  ImageSize->{1178., Automatic},
  PlotRangePadding->{6, 5}]], "Output",ExpressionUUID->"48b2c333-d5ad-43c4-\
8fa3-a2cb8f45575e"],

Cell[BoxData[
 GraphicsBox[{{}, {InsetBox[
     GraphicsBox[{{}, {{}, {}, 
        {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
          NCache[
           Rational[1, 120], 0.008333333333333333]], AbsoluteThickness[1.6], 
         LineBox[CompressedData["
1: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
aluO
          "]]}}, {}, {}, {}, {}},
      AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
      Axes->{True, True},
      AxesLabel->{None, None},
      AxesOrigin->{0, 0},
      DisplayFunction->Identity,
      Frame->{{True, True}, {True, True}},
      FrameLabel->{{None, None}, {
         FormBox["\"Semanas\"", TraditionalForm], 
         FormBox[
         "\"S\[EAcute]rie sem componentes senoidais 3\"", TraditionalForm]}},
      FrameStyle->Directive[18, 
        Thickness[Large]],
      FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
      GridLines->{None, None},
      GridLinesStyle->Directive[
        GrayLevel[0.5, 0.4]],
      ImagePadding->All,
      Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& ), "CopiedValueFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& )}},
      PlotRange->{{0, 955.}, {-3.181364457813751, 3.296932494096761}},
      PlotRangeClipping->True,
      PlotRangePadding->{{
         Scaled[0.02], 
         Scaled[0.02]}, {
         Scaled[0.05], 
         Scaled[0.05]}},
      Ticks->{Automatic, Automatic}], {192., -116.80842387373012}, 
     ImageScaled[{0.5, 0.5}], {360., 222.49223594996212}], InsetBox[
     GraphicsBox[{{}, {{}, {}, 
        {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
          NCache[
           Rational[1, 90], 0.011111111111111112`]], AbsoluteThickness[1.6], 
         LineBox[CompressedData["
1:eJw1mQlYTO0bxtuLZCn7miwRWfqIxve5j5QlhYpIthAia0RkL6QiIWRXpGyV
9kL7XmqmpplpZto3Ke07/efMef9zdV1dXXPmnPd9n+e57989Td1zzMJOTkZG
RiwrI0P//v+rIW5c2SLHCNaHhEZ3j7nmMPQ/YhwY0mrA/G2LvYNWd3Q5/zWQ
e1W1viDJHu0zzNbZHZGnmPdPoJd95p+EB9tYxQvsHT6dOQ3hGMUznjl6LOZ6
ZxjXTPEoWTmcpTti98J2tYv4opTKmay8hjzvCi5331PRtN7LSjw7p2+ixTU0
uASbXjc3IvdzQ/GDm79PGLXgV91bEZ7dwKouXw+rQc1g7u+OpVXlR9kpE6kx
1loJe+o8IFwTPMdy3nCKed5tVOtojvVpNGdJLx/njTMfv3y/avsHzPPvQhgQ
5xn0rzEr8qmn4Sb4oFV7BOXvtoqs5x58rWot7dQtWTmbsr5U77uPL4cVRk+Y
qEox63uA2O97djqN/4vyISozztzyxbcE+ci+1fNZzHofYpbxqmPTnOvQlWLs
qxLyCIbT9ivEXusl638M/+7bd4Zr3seQC9eU/Yr8kOO30ylwWzOY/TyBm9lA
obqCIqW1mF7RU2QcvJNR5tgLZn/PMZguT9s61pLGv/Xxmi/Qfver2R1jeYrZ
70us7Np89XJhF95aPNfV9n+JpMfhpqNNqsn+X+Hl8Jn6htmjWaHz/qv5HfEK
Fc7125HdDuY8XmOyube5ubMKFT9Y+Dw64zWGZo4uePpgPTkff1QmHT4UxJvE
Sq85t+VKiT8GS8q7RVaXnFcAhKNNZ9m7tkKymOEmTQH47Pt9y9oDCuT83uCw
sVm1brccRd9dXfYtFk63MXK0msVizvMt8sMb9ilTAtTSt9cIxNqGzKWFkSMo
5nwD8ba3L97snD6r1arTIGDmO6hc1O2odJenmPN+hy0HyszD7CrQr/eg1cEg
CFmznM9qmPqQ8w/CqA3ntysqWLGUhy16v9g0GElnt47qGyki9QjGm11Tr5to
/oV6A3vv353vYS0+rhId1Ubq8x6dLxqPVk5PxMT0E5KfD7h7/WL3vYxeA6Ze
H+B6UhChw1KitP2HF91x/YgfXaKBQFt50p+fMGLf3GefTbqgd+mz19aHn5Dq
ZjvnyaUqMPX8DKNHPBXdsnWs/2zWr5oa/Bl29Zdf3Y3pAlPfEKSHZy9uM65G
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
JFPUeA==
          "]]}}, {}, {}, {}, {}},
      AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
      Axes->{True, True},
      AxesLabel->{None, None},
      AxesOrigin->{0, 0},
      DisplayFunction->Identity,
      Frame->{{True, True}, {True, True}},
      FrameLabel->{{
         FormBox["\"Pot\[EHat]ncia (a.u.)\"", TraditionalForm], None}, {
         FormBox["\"Frequ\[EHat]ncia (a.u.)\"", TraditionalForm], 
         FormBox["\"Power Spectrum - tempSC3\"", TraditionalForm]}},
      FrameStyle->Directive[18, 
        Thickness[Large]],
      FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
      GridLines->{None, None},
      GridLinesStyle->Directive[
        GrayLevel[0.5, 0.4]],
      ImagePadding->All,
      Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& ), "CopiedValueFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& )}},
      PlotRange->{{0, 0.5}, {0, 7.192208988702127}},
      PlotRangeClipping->True,
      PlotRangePadding->{{
         Scaled[0.02], 
         Scaled[0.02]}, {
         Scaled[0.02], 
         Scaled[0.05]}},
      Ticks->{Automatic, Automatic}], {576., -116.80842387373012}, 
     ImageScaled[{0.5, 0.5}], {360., 222.49223594996212}]}, {}},
  ContentSelectable->True,
  ImageSize->{1178., Automatic},
  PlotRangePadding->{6, 5}]], "Output",ExpressionUUID->"6dd5d7f1-a7e1-49a6-\
a17e-4492c1c54279"]
}, Open  ]],

Cell["\<\
A natureza oscilat\[OAcute]ria das fun\[CCedilla]\[OTilde]es de correla\
\[CCedilla]\[ATilde]o, correla\[CCedilla]\[ATilde]o parcial e \
covari\[AHat]ncia abaixo indicam que ainda h\[AAcute] na s\[EAcute]rie final \
alguma contribui\[CCedilla]\[ATilde]o senoidal importante que n\[ATilde]o \
pode ser removida. Isto mostra que a s\[EAcute]rie n\[ATilde]o est\[AAcute] \
exatamente no regime estacion\[AAcute]rio fraco, i.e. primeiros e segundos \
momentos estacion\[AAcute]rios. O fato de os segundos momentos ainda \
apresentarem um claro comportamento oscilat\[OAcute]rio \[EAcute] \
particularmente crucial para o mal funcionamento do modelo.\
\>", "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"35627877-54fd-467a-9150-8a2b2615e118"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"{", 
   RowBox[{
    RowBox[{"ListPlot", "[", 
     RowBox[{
      RowBox[{"CorrelationFunction", "[", 
       RowBox[{"tempSC3", ",", 
        RowBox[{"{", 
         RowBox[{"1", ",", 
          RowBox[{
           RowBox[{"Length", "@", "tempSC2"}], "-", "1"}]}], "}"}]}], "]"}], 
      ",", 
      RowBox[{"Filling", "\[Rule]", "Axis"}], ",", 
      RowBox[{"PlotRange", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"0", ",", 
           RowBox[{
            RowBox[{"Length", "@", "tempSC3"}], "-", "1"}]}], "}"}], ",", 
         "All"}], "}"}]}], ",", 
      RowBox[{"Frame", "\[Rule]", "True"}], ",", 
      RowBox[{"FrameStyle", "\[Rule]", 
       RowBox[{"Directive", "[", 
        RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
      RowBox[{"FrameLabel", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"\"\<Correlation\>\"", ",", "None"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"\"\<Weeks\>\"", ",", "\"\<tempSC3\>\""}], "}"}]}], 
        "}"}]}]}], "]"}], ",", "\[IndentingNewLine]", 
    RowBox[{"Show", "[", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"ListPlot", "[", 
        RowBox[{
         RowBox[{"PartialCorrelationFunction", "[", 
          RowBox[{"tempSC3", ",", 
           RowBox[{"{", 
            RowBox[{"1", ",", 
             RowBox[{
              RowBox[{"Length", "@", "tempSC3"}], "-", "1"}]}], "}"}]}], 
          "]"}], ",", 
         RowBox[{"Filling", "\[Rule]", "Axis"}], ",", 
         RowBox[{"PlotRange", "\[Rule]", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{"0", ",", 
              RowBox[{
               RowBox[{"Length", "@", "tempSC3"}], "-", "1"}]}], "}"}], ",", 
            "All"}], "}"}]}], ",", 
         RowBox[{"Frame", "\[Rule]", "True"}], ",", 
         RowBox[{"FrameStyle", "\[Rule]", 
          RowBox[{"Directive", "[", 
           RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
         RowBox[{"FrameLabel", "\[Rule]", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{"\"\<Partial Correlation\>\"", ",", "None"}], "}"}], ",", 
            RowBox[{"{", 
             RowBox[{"\"\<Weeks\>\"", ",", "\"\<tempSC3\>\""}], "}"}]}], 
           "}"}]}]}], "]"}], ",", 
       RowBox[{"Plot", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
           RowBox[{"y", "=", 
            RowBox[{"2.", "/", 
             RowBox[{"\[Sqrt]", 
              RowBox[{"Length", "[", "tempSC3", "]"}]}]}]}], ",", 
           RowBox[{"y", "=", 
            RowBox[{
             RowBox[{"-", "2."}], "/", 
             RowBox[{"\[Sqrt]", 
              RowBox[{"Length", "[", "tempSC3", "]"}]}]}]}]}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"x", ",", "0", ",", 
           RowBox[{"Length", "[", "tempSC2", "]"}]}], "}"}], ",", 
         RowBox[{"PlotStyle", "\[Rule]", "Orange"}]}], "]"}]}], "}"}], "]"}], 
    ",", "\[IndentingNewLine]", 
    RowBox[{"ListPlot", "[", 
     RowBox[{
      RowBox[{"CovarianceFunction", "[", 
       RowBox[{"tempSC3", ",", 
        RowBox[{"{", 
         RowBox[{"1", ",", 
          RowBox[{
           RowBox[{"Length", "@", "tempSC2"}], "-", "1"}]}], "}"}]}], "]"}], 
      ",", 
      RowBox[{"Filling", "\[Rule]", "Axis"}], ",", 
      RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
      RowBox[{"Frame", "\[Rule]", "True"}], ",", 
      RowBox[{"FrameStyle", "\[Rule]", 
       RowBox[{"Directive", "[", 
        RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
      RowBox[{"FrameLabel", "\[Rule]", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"\"\<Covariance\>\"", ",", "None"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"\"\<Weeks\>\"", ",", "\"\<tempSC3\>\""}], "}"}]}], 
        "}"}]}]}], "]"}]}], "\[IndentingNewLine]", "}"}], "//", 
  "GraphicsRow"}]], "Input",ExpressionUUID->"bacece00-d67d-4581-ae1b-\
c96b7cf3d853"],

Cell[BoxData[
 GraphicsBox[{{}, {InsetBox[
     GraphicsBox[{{}, GraphicsComplexBox[CompressedData["
1:eJzt3fdXU1nbN/CjMyrqqLFjj9iwR0XF/rVjJTZAQI2oFBEMPfRDD01jx56x
IirGNmLPWLHHjnVixx479od3cZ33WVz/wsP8cq/PvdnZZ/dyjms395g7flZ5
QRA6VRWE//e/Jf9ZBuiXjd7WdvLeAfR/YH8rlwEjl4QeLaEV9v49oZzd8FUU
LkNqd99+L9wMFF4HqTZtK82ou5jCrfGk/PHrkK0lN4ZCN6KvvT6BLMdW9ZtP
wQWJZBv81erXns9D08ktcamf4K7v7EO/3xpj+wzu+SYmnGyLHQv839daNY/c
DqeP1Yu2yltF7oBak/qusxyQwjtB0fHA/Q97k8kKXPK90bBcQSyl1wVzHTPv
/Ki5iNwVzX1NLbdPkPLXDSeU6beO3FlA4XZw2VXkNuzKSgrvjsYbTXqrvnEU
3gOF999naZ5L+e+J/TZp9rPGLKe/t8fr3lF2R6/qKLwXPMoLq9a5LaHw3rhe
4/hA861UCu+DRQuckJSbTeF9sbnSgB3+a5LI/dCo8+D4W+V2kvtDmW07JjFC
+v0B6Dg7W8wOlPILvA0ucs8eROUlAhNnWZsUjSIp/kAc/W+496J1yyh8IGrE
urzdtXUzhQ/CzeDL6zLeLKbwQRjz/I82jk30FD4YobG5Sdk3KD1xMDaY3Rq9
HyrVzxCcH/nn3jF31lD8IfhkPS9ZszCHwoeicqUsz5f+YRR/KLasGHqzZYvN
9PzDELG5et1Kh4Io/jDE2lV78mzq3xR/OBZrvw4utyuLwodj4vAavxCxkcId
0KNC0qGptyLo9x3QbtkVh/pN1tHvj0Cya25IkPUOij8Ckb36Z7ktXkDxRyKn
8vrmLol/U/yR+ONuT71zolQfo2C3r1D3cD3VnzgKFXv4HS3Ur6bw0ehef2bg
52AfCh+NBo3zrdO6Sb8/BtNbherG/UPlKY7BylW2Nz2uraHnG4tuDtsmXMol
i2MxdpBm8LcKUvk6Yt7r+PtuhhAKd4TX7bD9lQ4vpXAl7CZNcmibHFViKPG9
2mu/puvV9PdKbN7+V+9dBYYSG5Wo62RuebnlSkp/HJaMvj1V339FiTEOk6t+
HRL+idq7OA6KV7nPdRop/jhcfKlOaFpOKp/xuKsNsWvYChR/PA4ODaofn031
K45HX7fjHZx1NB4Zx+Mv19+X2ten+hImYJVw0rZ+ArU/TIDR8NdFT8+NFH8C
do4vcqguTC0JN07AzJ/Oo2dXlPrfRCxv97CWx44Mij8RVWU6uyp1pfY+Eb3s
bfdl19VT+hMxsPuB2ed7Un0Lk1D1eMA/+QMpv5iE/Uemt53+OI3SnwSvvifq
t15J7d84Cc2XevW+eGshpe+E+K+b77yZlUjpO2FkcPf27s+WUXwnVDzuvHmv
I6VndEKs7WLrsBoULjhjzr17Y8foqT7gjBrba9tbfaXxVXTG1qkeR5Y+WU7x
ndEg7OmQ+dU6U/ouGJc3bbbdL/o9uOBi5Qo/c1JTKL4LPs+9l9L691yK74Jy
O0JmTjs/hdKfjJRRH+2G9lbR809GXNfGZ0zzPaj8JmNwTP0WqcepPRsn42iL
Rhdtvq6l9F1RfvLCaT7fVlP6ruh8Kvf9az9PSt8VY8bez3BYtYjiuwLTxiq+
xVJ9C274WaWWl6bbVIrvBs9Hz5t37LKB0ndDr4m1qnh2nk/x3fC93dcudyOk
8ndHI7eKDRw30O/DHV0q9miyZYYU3x2n6j1NrmWVRPl3x+bfY9cnd02m/E/B
z8Ep+/8JlOJPQdfBN2qUT5P66xRoW9Q7cCRsEsWfgmlbRsY8+v/9eypqz7cE
3nkRR/GnYv6wwLGR+Vso/lTU99Ut0dym/mycitmdX/W+uE0aX6fhzLFWa9+f
ovkJ06Cu5ujovofmD3EarK8+6PfpoNR+puHY0WfXa6/UUXwV9j6u7hXdicpD
rsKgZm+anJpH8wdUkJu+3/Y+RO1TpcKObQXqF3bSeKrC6LhG9/x9p5RYr0LH
TTOEHrZSealgXSv4bXkvel6zCpW253aa2i6Dym86XLJaHD8bP4PSnw7VjZ82
V41U/piOsM/mzy/aTS/5e9V0LAxYXr23uyelPx1PBw7c1CaF1if66VBvixg4
wnEcldd0TB7tnJa/fV5JfPN0hH9vurS5IpLS98C/E1InTW6yocRyD9iL+/UL
7Wl+hwf+mjs181R8JqXvgXcrRt0824fCRQ84714YXnnr+hLrPeDQ15yf/sib
8u8BK1Pc/D07F1L6HuiQbfMgdwDNJ8IMfKnh9vXRpaWU/gwM/HioY9YBGm8w
A/dsVxqGSPOLagYCbb6pGlSk9MQZiLQ5UuHR0WjK/wwcm9DGd54P1a9xBvY9
e3zwzDDqX+YZGPr4ek35T3oeYSYSH5yY0nboLEp/JnBiXJ8XFlrfYSauRTos
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
p/evPKL3fcoUPNk6t1mn7tL6LwXrV701tXOj+VWVgrFnxfJ/m2g+8k7BI8fn
OR5W1F7VKRjU/PXrB3uoP2tS8HHe4Ovx96h/iSmYe775hmevqby0KUgPXLZ3
dXlKX1dcHvt3rTWepP1/VgrGu15x+ehB77/1Kbh9Y/HZd/mU/+wUJD/Kq9e8
PD2PIQWLHvnt6N2cvmfMS4E+OUiW1I9+35iCyI/LemHkEOr/KXBPsI6eMZPW
j6YUrIk8YHKrRfVTkFLcnn1fKB5L77dTkFb5S+TTbvS+rTAF0wYts51Xkcrf
koIe86xfW12l+aUoBQ1WbEv6x2Ey1b8WFRsNtP3uR+O7lRYVbLMLC5T0/DIt
dk7fMN/Uj+rLWou+T0bcHnWazu/lWqx5btl64iPVj60WUZFNHzZuSe+rFFrY
NFVnzPOn9Oy1CK+SOujJFDqPghYnFpsVS7uOp/rXYuHaifVcjtN+SKnF1dE7
G9X+RuOfixYN27fOzJPOn1VaWIXX2BAg0H7TW4ttcYGJm3bS+xW1Flq7/poO
U2l80Wixu9d315cnaD4WtVAsPPK422paH2q1OHdw6aujdjR+6bTYWzVjXosQ
+v0sLc6sj8/7ZUv1rddiVflDuQP7jKDxX4tnir4JA7vQesaghV9f7yW9TNR/
8rT460j0xSPXpO+TtBj1MDdtfEMqj/zi59f/mK7YTeOVSQvXLf3eDfGh7yML
tKh37UPPQ6tp/jZrMXrHy4tLj1L9FGpR90SQ8+3PNB5btBh5Jf1h7TD6+yIt
Nhw/fKDtaWoPQirEe/vOe9+j72usUlF3wovwWE9p/Z+KEQf7r7lWSOt561Qo
cyY9/+8Slb88Fb3b5F20LpT2f6lIP7J80O6KNB4qUnG/tyHh+BNaT9unYoph
z8rdctovIxVNAyO6n69M+0WHVDRJdtzbpSutD5Sp0OaMSa69gtbLLql4tf9g
YYJA6zdVKv6cuCXmwhIa/7xTkVphtu/9dKpvdSpa1XZxj19K7/c0qZizxNTA
ZxytT8VUGMqf+tzvPNW3NhXGzTvEt3/S+29dcfrtamd+iqH3S1mpiDv36Gnj
pdL7qeL4j9e8qC+9v8tORb9DVdrkrG9J/T8V1cYvPtXupBf1/1TkHanr2OOi
9D1yKi4kr74+eDKNx/mpqCCTd7KeTOttUypm7bhd8fkK2p8WpKLb1x7tz+TQ
/tecisyFNab1K0/PV5gK9PPddEw6b7Ok4ujOQQffpdJ8X5SKtq+dM0YJND4I
aZhxpJxGb0Pfx1ul4ajof+XDXPp9WRomhXZ6dO8LzU/WafizyPyqon0U1X8a
Wnsvl331pPHINg01V8offw6k8y9FGmbN2jsxZK+0/0/D2jMPjvadLn0vnYbK
Xi1biu2o/Tqkoe7Nlzv9l9C/P1GmYbPvCP/HHag+XNIw7Oi3wvx4+j5JlYZT
kz+st1lE/ck7DSd6rE8y7qbxXZ2GgFxlvR9dqfw0aShSvz7zSkvfq4tpuBy8
G41taP7RpuFqTWtL9cXUvnVpsGgHzFgZTuurrDTsO3OgmkMhzQf6NNysHanM
WEPzW3YaRocHDA8F7UcMaWjV4I9vw09QfeeloeGiVc37PKH3DcY0bDJ9/rt+
Ofr+JL84vz9uJ1fvR+OFKQ0XYpMujf1E68OCNMwu6NB4+OEgmv/TMHHPLqv4
nRRemIZuU2pcfyWNP5Y0bI/O7Xlkubzk74vScDYsQOV/gMpTSEdujm5jj39o
vWqVDtfA3w4vvtN8KUvHo1XNxj0QqT9ap2PmgG6zNU+l7zXT8fPxk1q9U8i2
6XCzrZNk35P6nyId046+2Nr+FK1n7NPx+WrN4KvlaT2KdNhF6vZ9e0LvLx3S
8d/KXsdzC+l9pDIdDh+3+M92o/7pko42jfwe135M+xlVOjKX2j2ZlUP7Ye/i
9F7GbR52heZndTqGrOn5zWOwG9V/OpoFVTqX60Dzr5iO6IerXx+dQfOTNh3Z
vxQPbzztTv0/HWcLZY9/+NB6MSsdYZeQmd2L1u/6dDxzCpv58yu9r8xOR0Ja
e9+PNjQ/GtJx+PmAdmsq0viWl46ASxfXL53mR+N/OpRzPsX51ehb4vx0NI5d
eGTDSJrvTMX5N3ZY5K6j9UNBOmb1bf559HDq7+Z0jPnttPPQZmrPhemoveu2
/bUd1D8t6ai3+fivG0NoPVeUjvy4BZod32h8FjLQfsnLXyF9aH6xysDNRQ0X
LU6Q1n8Z8Gr3POxgDu3HrDPw7VGLrm2qSuN/BtZcsFs3rhr1L9sMBK6pMTju
lHT+n4HjNgl9xsyV5v8M7A39/WjohUFU/xkYLFvpOqr3zBI7ZKDahY5/zsui
9Y8yAzes2w8MDSa7ZGB5cLjdd3fKvyoD29YtexuQ3Y/6fwaO7O19f/wVmv/U
GUjKvbEn5zvlR5OBpsu6LN7+ifYvYgaEep6eY25Q/9NmYN3JwZkr/h5M9Z+B
pesvbXW5Q/uDrAwcHNTufrVgmj/0Gfjj08vZFQ7S72dn4MOSqe8SHGn9YciA
85T2Hbzdaf2el4H4qPlhEaM8qP4z4DZm7z/FlU71n4HbV1t2ubee/v2MKQO/
+v/6Y/+/ztT/i59PbDzNaR/tz80ZsIRMj25krlfiwuLnO35nzvkc2l9YMtD5
Xq4u+z6Vf1Fxfax9k2e/m74HFjJxLmiqyru+A/X/TDyqbnZq6UvzgywTHk8L
vjfWSef/mWi7rqla+Z3C5Zl4/k1rvbkznWfYZmLFPnPI8+nS+J8J4Wffgkdz
aH6zz0TN7NrRx35Qf0UmnCO2zd+5ezr1/0w0O/k9ZGOhtP7PxOg9USOnHKHv
FVwy0f9GhYzai2i+UmXi0uhZuTF16DzPOxPvjq0Y8CPcl/p/JnaNmbF4dhtp
/Z+Jq56dQ/u1lv79QrEd1ulrt6D+oM3Esr5974n/0vpVl4ncTdPbampRfrMy
scc6WJj8gcpPn4mGjuc7Ha5O7weyi5//7c3Rn23o7w2Z6Hu7c6DTfgrPy8Ts
3km3Uv1H0PifiWvx+VsHFVL+8zOL59uLh50OzKL6Ly7/saedl2yk9ipYSurp
f/9DaVoxy5jrMFszN2aWM9swt2RuzWzL3I65A3MnZgVzF+auzN2Y7Zi7M/dg
7slsz9yLuTdzH+a+zP2Y+zMPYEZpi8zCQBbOLAxi4czCYBbOLAxh4czCUBbO
LAxj4czCcBbOLDiwcGZhBAtnFkaycGZhFAtnFkazcGZhDAtnFsaycGbBkYUz
C8rSBrPIbGQWxrH4zCKzkVkYz+Izi8xGZmECi88sMhuZhYksPrPIbGQWJrH4
zCKzkVlwYvGZRWYjs+DM4jOLzEZmwYXFZxaZjczCZBafWWQ2MguuLD6zyGxk
FtxYfGaR2cgsuLP4zCKzkVmYwuIzi8xGZmEqi88sMhuZhWksPrPIbGQWVKUt
Zwazillk1jMbmc3MwnSWPjOYVcwis57ZyGxmFjxY+sxgVjGLzHpmI7OZWZjB
0mcGs4pZZNYzG5nNzMJMlj4zmFXMIrOe2chsZhZmsfSZwaxiFpn1zEZmM7Pg
ydJnBrOKWWTWMxuZzcyCF0ufGcwqZpFZz2xkNjML3ix9ZjCrmEVmPbOR2cws
+LD0mcGsYhaZ9cxGZjOzMJulzwxmFbPIrGc2MpuZBV+WPjOYVcwis57ZyGxm
Fuaw9JnBrGIWmfXMRmYzs+DH0mcGs4pZZNYzG5nNzII/S58ZzCpmkVnPbGQ2
MwtzWfrMYFYxi8x6ZiOzmVlQl7aMWc6sYAazklnFrGYWmXXMemYDs5HZxGxm
tjALAaUtY5YzK5jBrGRWMauZRWYds57ZwGxkNjGbmS3MQmBpy5jlzApmMCuZ
VcxqZpFZx6xnNjAbmU3MZmYLsxBU2jJmObOCGcxKZhWzmllk1jHrmQ3MRmYT
s5nZwiwEl7aMWc6sYAazklnFrGYWmXXMemYDs5HZxGxmtjALIaUtY5YzK5jB
rGRWMauZRWYds57ZwGxkNjGbmS3MQmhpy5jlzApmMCuZVcxqZpFZx6xnNjAb
mU3MZmYLsxBW2jJmObOCGcxKZhWzmllk1jHrmQ3MRmYTs5nZwixoSlvGLGdW
MINZyaxiVjOLzDpmPbOB2chsYjYzW5iF8NKWMcuZFcxgVjKrmNXMIrOOWc9s
YDYym5jNzBZmIaK0ZcxyZgUzmJXMKmY1s8isY9YzG5iNzCZmM7OFWYgsbRmz
nFnBDGYls4pZzSwy65j1zAZmI7OJ2cxsYRaiSlvGLGdWMINZyaxiVjOLzDpm
PbOB2chsYjYzW5iF6NKWMcuZFcxgVjKrmNXMIrOOWc9sYDYym5jNzBZmIaa0
ZcxyZgUzmJXMKmY1s8isY9YzG5iNzCZmM7OFWYgtbRmznFnBDGYls4pZzSwy
65j1zAZmI7OJ2cxsYRbE0rZiljFbM8uZbZkVzPbMYHZgVjK7MKuYvZnVzBpm
kVnLrGPOYtYzZzMbmPOYjcz5zCbmAmYzcyGzhbmIWYgrbStmGbM1s5zZllnB
bM8MZgdmJbMLs4rZm1nNrGEWmbXMOuYsZj1zNrOBOY/ZyJzPbGIuYDYzFzJb
mIuYhfjStmKWMVszy5ltmRXM9sxgdmBWMrswq5i9mdXMGmaRWcusY85i1jNn
MxuY85iNzPnMJuYCZjNzIbOFuYhZSChtK2YZszWznNmWWcFszwxmB2Ylswuz
itmbWc2sYRaZtcw65ixmPXM2s4E5j9nInM9sYi5gNjMXMluYi5iFxNK2YpYx
WzPLmW2ZFcz2zGB2YFYyuzCrmL2Z1cwaZpFZy6xjzmLWM2czG5jzmI3M+cwm
5gJmM3Mhs4W5iFlIKm0rZhmzNbOc2ZZZwWzPDGYHZiWzC7OK2ZtZzaxhFpm1
zDrmLGY9czazgTmP2cicz2xiLmA2MxcyW5iLmIXk0rZiljFbM8uZbZkVzPbM
YHZgVjK7MKuYvZnVzBpmkVnLrGPOYtYzZzMbmPOYjcz5zCbmAmYzcyGzhbmI
WUgpbStmGbM1s5zZllnBbM8MZgdmJbMLs4rZm1nNrGEWmbXMOuYsZj1zNrOB
OY/ZyJzPbGIuYDYzFzJbmIuYBW1pWzHLmK2Z5cy2zApme2YwOzArmV2YVcze
zGpmDbPIrGXWMWcx65mzmQ3MecxG5nxmE3MBs5m5kNnCXMQspJa2FbOM2ZpZ
zmzLrGC2ZwazA7OS2YVZxezNrGbWMIvMWmYdcxaznjmb2cCcx2xkzmc2MRcw
m5kLmS3MRcxCWmlbMcuYrZnlzLbMCmZ7ZjA7MCuZXZhVzN7MamYNs8isZdYx
ZzHrmbOZDcx5zEbmfGYTcwGzmbmQ2cJcxCykl7YVs4zZmlnObMusYLZnBrMD
s5LZhVnF7M2sZtYwi8xaZh1zFrOeOZvZwJzHbGTOZzYxFzCbmQuZLcxFzEJG
aVsxy5itmeXMtswKZntmMDswK5ldmFXM3sxqZg2zyKxl1jFnMeuZs5kNzHnM
RuZ8ZhNzAbOZuZDZwlzELGSWthWzjNmaWc5sy6xgtmcGswOzktmFWcXszaxm
1jCLzFpmHXMWs545m9nAnMdsZM5nNjGX3Z9bdn9u2f25Zffnlt2fS+Vddn9u
2f25Zffnlt2fW3Z/bkn6Zffnlt2fW3Z/btn9uWX355akX3Z/btn9uWX355bd
n1t2f25J/svuzy27P7fs/tyy+3PL7s8tyX/Z/bll9+eW3Z9bdn9u2f25Jfkv
uz+37P7csvtzy+7PLbs/t6T+y+7PLbs/t+z+3LL7c8vuzy2p/7L7c8vuzy27
P7fs/tyy+3NL6r/s/tyy+3PL7s8tuz+37P7ckvovuz+37P7csvtzy+7PLbs/
t6T+y+7PLbs/t+z+3P8L9+f+D2xSqlc=
        "], {{{}, {}, {}, 
          {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
           LineBox[{956, 2}], LineBox[{958, 4}], LineBox[{964, 10}], 
           LineBox[{965, 11}], LineBox[{966, 12}], LineBox[{967, 13}], 
           LineBox[{968, 14}], LineBox[{969, 15}], LineBox[{972, 18}], 
           LineBox[{974, 20}], LineBox[{977, 23}], LineBox[{979, 25}], 
           LineBox[{981, 27}], LineBox[{982, 28}], LineBox[{983, 29}], 
           LineBox[{986, 32}], LineBox[{987, 33}], LineBox[{988, 34}], 
           LineBox[{989, 35}], LineBox[{990, 36}], LineBox[{991, 37}], 
           LineBox[{993, 39}], LineBox[{994, 40}], LineBox[{995, 41}], 
           LineBox[{998, 44}], LineBox[{999, 45}], LineBox[{1000, 46}], 
           LineBox[{1001, 47}], LineBox[{1004, 50}], LineBox[{1005, 51}], 
           LineBox[{1007, 53}], LineBox[{1009, 55}], LineBox[{1011, 57}], 
           LineBox[{1012, 58}], LineBox[{1015, 61}], LineBox[{1017, 63}], 
           LineBox[{1018, 64}], LineBox[{1025, 71}], LineBox[{1030, 76}], 
           LineBox[{1032, 78}], LineBox[{1033, 79}], LineBox[{1034, 80}], 
           LineBox[{1035, 81}], LineBox[{1041, 87}], LineBox[{1042, 88}], 
           LineBox[{1049, 95}], LineBox[{1054, 100}], LineBox[{1055, 101}], 
           LineBox[{1056, 102}], LineBox[{1057, 103}], LineBox[{1060, 106}], 
           LineBox[{1061, 107}], LineBox[{1063, 109}], LineBox[{1064, 110}], 
           LineBox[{1065, 111}], LineBox[{1066, 112}], LineBox[{1067, 113}], 
           LineBox[{1070, 116}], LineBox[{1071, 117}], LineBox[{1073, 119}], 
           LineBox[{1074, 120}], LineBox[{1075, 121}], LineBox[{1076, 122}], 
           LineBox[{1077, 123}], LineBox[{1078, 124}], LineBox[{1079, 125}], 
           LineBox[{1081, 127}], LineBox[{1082, 128}], LineBox[{1083, 129}], 
           LineBox[{1084, 130}], LineBox[{1085, 131}], LineBox[{1086, 132}], 
           LineBox[{1088, 134}], LineBox[{1090, 136}], LineBox[{1091, 137}], 
           LineBox[{1093, 139}], LineBox[{1094, 140}], LineBox[{1095, 141}], 
           LineBox[{1105, 151}], LineBox[{1110, 156}], LineBox[{1111, 157}], 
           LineBox[{1116, 162}], LineBox[{1117, 163}], LineBox[{1119, 165}], 
           LineBox[{1120, 166}], LineBox[{1125, 171}], LineBox[{1127, 173}], 
           LineBox[{1130, 176}], LineBox[{1131, 177}], LineBox[{1132, 178}], 
           LineBox[{1133, 179}], LineBox[{1134, 180}], LineBox[{1135, 181}], 
           LineBox[{1136, 182}], LineBox[{1137, 183}], LineBox[{1139, 185}], 
           LineBox[{1140, 186}], LineBox[{1141, 187}], LineBox[{1142, 188}], 
           LineBox[{1143, 189}], LineBox[{1144, 190}], LineBox[{1145, 191}], 
           LineBox[{1149, 195}], LineBox[{1152, 198}], LineBox[{1153, 199}], 
           LineBox[{1155, 201}], LineBox[{1156, 202}], LineBox[{1157, 203}], 
           LineBox[{1158, 204}], LineBox[{1162, 208}], LineBox[{1163, 209}], 
           LineBox[{1165, 211}], LineBox[{1166, 212}], LineBox[{1167, 213}], 
           LineBox[{1168, 214}], LineBox[{1169, 215}], LineBox[{1170, 216}], 
           LineBox[{1174, 220}], LineBox[{1176, 222}], LineBox[{1185, 231}], 
           LineBox[{1186, 232}], LineBox[{1187, 233}], LineBox[{1189, 235}], 
           LineBox[{1190, 236}], LineBox[{1191, 237}], LineBox[{1192, 238}], 
           LineBox[{1193, 239}], LineBox[{1195, 241}], LineBox[{1198, 244}], 
           LineBox[{1200, 246}], LineBox[{1208, 254}], LineBox[{1209, 255}], 
           LineBox[{1210, 256}], LineBox[{1211, 257}], LineBox[{1213, 259}], 
           LineBox[{1214, 260}], LineBox[{1215, 261}], LineBox[{1218, 264}], 
           LineBox[{1219, 265}], LineBox[{1221, 267}], LineBox[{1223, 269}], 
           LineBox[{1224, 270}], LineBox[{1225, 271}], LineBox[{1226, 272}], 
           LineBox[{1227, 273}], LineBox[{1228, 274}], LineBox[{1229, 275}], 
           LineBox[{1230, 276}], LineBox[{1231, 277}], LineBox[{1232, 278}], 
           LineBox[{1233, 279}], LineBox[{1234, 280}], LineBox[{1235, 281}], 
           LineBox[{1236, 282}], LineBox[{1237, 283}], LineBox[{1238, 284}], 
           LineBox[{1252, 298}], LineBox[{1255, 301}], LineBox[{1258, 304}], 
           LineBox[{1263, 309}], LineBox[{1264, 310}], LineBox[{1267, 313}], 
           LineBox[{1270, 316}], LineBox[{1275, 321}], LineBox[{1276, 322}], 
           LineBox[{1277, 323}], LineBox[{1281, 327}], LineBox[{1282, 328}], 
           LineBox[{1283, 329}], LineBox[{1284, 330}], LineBox[{1285, 331}], 
           LineBox[{1291, 337}], LineBox[{1294, 340}], LineBox[{1296, 342}], 
           LineBox[{1297, 343}], LineBox[{1298, 344}], LineBox[{1299, 345}], 
           LineBox[{1300, 346}], LineBox[{1301, 347}], LineBox[{1302, 348}], 
           LineBox[{1303, 349}], LineBox[{1304, 350}], LineBox[{1306, 352}], 
           LineBox[{1309, 355}], LineBox[{1310, 356}], LineBox[{1311, 357}], 
           LineBox[{1312, 358}], LineBox[{1313, 359}], LineBox[{1318, 364}], 
           LineBox[{1321, 367}], LineBox[{1323, 369}], LineBox[{1324, 370}], 
           LineBox[{1326, 372}], LineBox[{1328, 374}], LineBox[{1329, 375}], 
           LineBox[{1333, 379}], LineBox[{1345, 391}], LineBox[{1349, 395}], 
           LineBox[{1350, 396}], LineBox[{1352, 398}], LineBox[{1353, 399}], 
           LineBox[{1354, 400}], LineBox[{1358, 404}], LineBox[{1362, 408}], 
           LineBox[{1363, 409}], LineBox[{1364, 410}], LineBox[{1366, 412}], 
           LineBox[{1367, 413}], LineBox[{1369, 415}], LineBox[{1371, 417}], 
           LineBox[{1372, 418}], LineBox[{1374, 420}], LineBox[{1375, 421}], 
           LineBox[{1378, 424}], LineBox[{1380, 426}], LineBox[{1381, 427}], 
           LineBox[{1382, 428}], LineBox[{1383, 429}], LineBox[{1385, 431}], 
           LineBox[{1386, 432}], LineBox[{1387, 433}], LineBox[{1388, 434}], 
           LineBox[{1389, 435}], LineBox[{1391, 437}], LineBox[{1392, 438}], 
           LineBox[{1393, 439}], LineBox[{1394, 440}], LineBox[{1395, 441}], 
           LineBox[{1396, 442}], LineBox[{1398, 444}], LineBox[{1402, 448}], 
           LineBox[{1403, 449}], LineBox[{1405, 451}], LineBox[{1411, 457}], 
           LineBox[{1412, 458}], LineBox[{1417, 463}], LineBox[{1418, 464}], 
           LineBox[{1422, 468}], LineBox[{1425, 471}], LineBox[{1426, 472}], 
           LineBox[{1427, 473}], LineBox[{1428, 474}], LineBox[{1429, 475}], 
           LineBox[{1430, 476}], LineBox[{1431, 477}], LineBox[{1432, 478}], 
           LineBox[{1433, 479}], LineBox[{1434, 480}], LineBox[{1438, 484}], 
           LineBox[{1442, 488}], LineBox[{1444, 490}], LineBox[{1445, 491}], 
           LineBox[{1447, 493}], LineBox[{1449, 495}], LineBox[{1451, 497}], 
           LineBox[{1453, 499}], LineBox[{1454, 500}], LineBox[{1455, 501}], 
           LineBox[{1456, 502}], LineBox[{1459, 505}], LineBox[{1460, 506}], 
           LineBox[{1461, 507}], LineBox[{1462, 508}], LineBox[{1464, 510}], 
           LineBox[{1466, 512}], LineBox[{1468, 514}], LineBox[{1471, 517}], 
           LineBox[{1472, 518}], LineBox[{1473, 519}], LineBox[{1475, 521}], 
           LineBox[{1476, 522}], LineBox[{1477, 523}], LineBox[{1478, 524}], 
           LineBox[{1481, 527}], LineBox[{1482, 528}], LineBox[{1486, 532}], 
           LineBox[{1487, 533}], LineBox[{1489, 535}], LineBox[{1492, 538}], 
           LineBox[{1493, 539}], LineBox[{1494, 540}], LineBox[{1495, 541}], 
           LineBox[{1496, 542}], LineBox[{1497, 543}], LineBox[{1498, 544}], 
           LineBox[{1500, 546}], LineBox[{1503, 549}], LineBox[{1506, 552}], 
           LineBox[{1508, 554}], LineBox[{1513, 559}], LineBox[{1515, 561}], 
           LineBox[{1516, 562}], LineBox[{1519, 565}], LineBox[{1520, 566}], 
           LineBox[{1521, 567}], LineBox[{1524, 570}], LineBox[{1525, 571}], 
           LineBox[{1527, 573}], LineBox[{1528, 574}], LineBox[{1529, 575}], 
           LineBox[{1530, 576}], LineBox[{1532, 578}], LineBox[{1535, 581}], 
           LineBox[{1536, 582}], LineBox[{1537, 583}], LineBox[{1541, 587}], 
           LineBox[{1543, 589}], LineBox[{1544, 590}], LineBox[{1546, 592}], 
           LineBox[{1547, 593}], LineBox[{1549, 595}], LineBox[{1550, 596}], 
           LineBox[{1552, 598}], LineBox[{1559, 605}], LineBox[{1560, 606}], 
           LineBox[{1566, 612}], LineBox[{1567, 613}], LineBox[{1572, 618}], 
           LineBox[{1575, 621}], LineBox[{1577, 623}], LineBox[{1578, 624}], 
           LineBox[{1580, 626}], LineBox[{1582, 628}], LineBox[{1587, 633}], 
           LineBox[{1588, 634}], LineBox[{1589, 635}], LineBox[{1590, 636}], 
           LineBox[{1591, 637}], LineBox[{1592, 638}], LineBox[{1598, 644}], 
           LineBox[{1601, 647}], LineBox[{1602, 648}], LineBox[{1603, 649}], 
           LineBox[{1608, 654}], LineBox[{1609, 655}], LineBox[{1610, 656}], 
           LineBox[{1611, 657}], LineBox[{1612, 658}], LineBox[{1617, 663}], 
           LineBox[{1618, 664}], LineBox[{1619, 665}], LineBox[{1620, 666}], 
           LineBox[{1625, 671}], LineBox[{1629, 675}], LineBox[{1634, 680}], 
           LineBox[{1636, 682}], LineBox[{1637, 683}], LineBox[{1638, 684}], 
           LineBox[{1639, 685}], LineBox[{1641, 687}], LineBox[{1642, 688}], 
           LineBox[{1643, 689}], LineBox[{1644, 690}], LineBox[{1645, 691}], 
           LineBox[{1650, 696}], LineBox[{1651, 697}], LineBox[{1657, 703}], 
           LineBox[{1660, 706}], LineBox[{1661, 707}], LineBox[{1667, 713}], 
           LineBox[{1669, 715}], LineBox[{1670, 716}], LineBox[{1672, 718}], 
           LineBox[{1676, 722}], LineBox[{1677, 723}], LineBox[{1678, 724}], 
           LineBox[{1680, 726}], LineBox[{1686, 732}], LineBox[{1687, 733}], 
           LineBox[{1688, 734}], LineBox[{1689, 735}], LineBox[{1690, 736}], 
           LineBox[{1691, 737}], LineBox[{1692, 738}], LineBox[{1693, 739}], 
           LineBox[{1694, 740}], LineBox[{1695, 741}], LineBox[{1697, 743}], 
           LineBox[{1698, 744}], LineBox[{1699, 745}], LineBox[{1703, 749}], 
           LineBox[{1704, 750}], LineBox[{1705, 751}], LineBox[{1706, 752}], 
           LineBox[{1707, 753}], LineBox[{1709, 755}], LineBox[{1710, 756}], 
           LineBox[{1713, 759}], LineBox[{1714, 760}], LineBox[{1716, 762}], 
           LineBox[{1717, 763}], LineBox[{1719, 765}], LineBox[{1720, 766}], 
           LineBox[{1721, 767}], LineBox[{1724, 770}], LineBox[{1725, 771}], 
           LineBox[{1727, 773}], LineBox[{1728, 774}], LineBox[{1729, 775}], 
           LineBox[{1730, 776}], LineBox[{1734, 780}], LineBox[{1735, 781}], 
           LineBox[{1740, 786}], LineBox[{1741, 787}], LineBox[{1743, 789}], 
           LineBox[{1744, 790}], LineBox[{1746, 792}], LineBox[{1747, 793}], 
           LineBox[{1748, 794}], LineBox[{1749, 795}], LineBox[{1750, 796}], 
           LineBox[{1752, 798}], LineBox[{1753, 799}], LineBox[{1756, 802}], 
           LineBox[{1759, 805}], LineBox[{1762, 808}], LineBox[{1765, 811}], 
           LineBox[{1766, 812}], LineBox[{1771, 817}], LineBox[{1772, 818}], 
           LineBox[{1777, 823}], LineBox[{1778, 824}], LineBox[{1780, 826}], 
           LineBox[{1781, 827}], LineBox[{1782, 828}], LineBox[{1783, 829}], 
           LineBox[{1784, 830}], LineBox[{1785, 831}], LineBox[{1786, 832}], 
           LineBox[{1787, 833}], LineBox[{1790, 836}], LineBox[{1791, 837}], 
           LineBox[{1792, 838}], LineBox[{1793, 839}], LineBox[{1794, 840}], 
           LineBox[{1795, 841}], LineBox[{1796, 842}], LineBox[{1797, 843}], 
           LineBox[{1799, 845}], LineBox[{1800, 846}], LineBox[{1801, 847}], 
           LineBox[{1802, 848}], LineBox[{1808, 854}], LineBox[{1809, 855}], 
           LineBox[{1810, 856}], LineBox[{1811, 857}], LineBox[{1812, 858}], 
           LineBox[{1814, 860}], LineBox[{1815, 861}], LineBox[{1817, 863}], 
           LineBox[{1819, 865}], LineBox[{1826, 872}], LineBox[{1830, 876}], 
           LineBox[{1831, 877}], LineBox[{1832, 878}], LineBox[{1833, 879}], 
           LineBox[{1834, 880}], LineBox[{1835, 881}], LineBox[{1839, 885}], 
           LineBox[{1840, 886}], LineBox[{1845, 891}], LineBox[{1846, 892}], 
           LineBox[{1848, 894}], LineBox[{1849, 895}], LineBox[{1850, 896}], 
           LineBox[{1851, 897}], LineBox[{1854, 900}], LineBox[{1855, 901}], 
           LineBox[{1856, 902}], LineBox[{1861, 907}], LineBox[{1864, 910}], 
           LineBox[{1865, 911}], LineBox[{1866, 912}], LineBox[{1867, 913}], 
           LineBox[{1870, 916}], LineBox[{1871, 917}], LineBox[{1875, 921}], 
           LineBox[{1876, 922}], LineBox[{1880, 926}], LineBox[{1881, 927}], 
           LineBox[{1883, 929}], LineBox[{1884, 930}], LineBox[{1885, 931}], 
           LineBox[{1886, 932}], LineBox[{1887, 933}], LineBox[{1888, 934}], 
           LineBox[{1889, 935}], LineBox[{1890, 936}], LineBox[{1891, 937}], 
           LineBox[{1892, 938}], LineBox[{1893, 939}], LineBox[{1894, 940}], 
           LineBox[{1895, 941}], LineBox[{1896, 942}], LineBox[{1897, 943}], 
           LineBox[{1898, 944}], LineBox[{1899, 945}], LineBox[{1900, 946}], 
           LineBox[{1901, 947}], LineBox[{1902, 948}], LineBox[{1903, 949}], 
           LineBox[{1904, 950}], LineBox[{1905, 951}], LineBox[{1906, 952}], 
           LineBox[{1907, 953}], LineBox[{1908, 954}]}, 
          {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
           LineBox[{955, 1}], LineBox[{957, 3}], LineBox[{959, 5}], 
           LineBox[{960, 6}], LineBox[{961, 7}], LineBox[{962, 8}], 
           LineBox[{963, 9}], LineBox[{970, 16}], LineBox[{971, 17}], 
           LineBox[{973, 19}], LineBox[{975, 21}], LineBox[{976, 22}], 
           LineBox[{978, 24}], LineBox[{980, 26}], LineBox[{984, 30}], 
           LineBox[{985, 31}], LineBox[{992, 38}], LineBox[{996, 42}], 
           LineBox[{997, 43}], LineBox[{1002, 48}], LineBox[{1003, 49}], 
           LineBox[{1006, 52}], LineBox[{1008, 54}], LineBox[{1010, 56}], 
           LineBox[{1013, 59}], LineBox[{1014, 60}], LineBox[{1016, 62}], 
           LineBox[{1019, 65}], LineBox[{1020, 66}], LineBox[{1021, 67}], 
           LineBox[{1022, 68}], LineBox[{1023, 69}], LineBox[{1024, 70}], 
           LineBox[{1026, 72}], LineBox[{1027, 73}], LineBox[{1028, 74}], 
           LineBox[{1029, 75}], LineBox[{1031, 77}], LineBox[{1036, 82}], 
           LineBox[{1037, 83}], LineBox[{1038, 84}], LineBox[{1039, 85}], 
           LineBox[{1040, 86}], LineBox[{1043, 89}], LineBox[{1044, 90}], 
           LineBox[{1045, 91}], LineBox[{1046, 92}], LineBox[{1047, 93}], 
           LineBox[{1048, 94}], LineBox[{1050, 96}], LineBox[{1051, 97}], 
           LineBox[{1052, 98}], LineBox[{1053, 99}], LineBox[{1058, 104}], 
           LineBox[{1059, 105}], LineBox[{1062, 108}], LineBox[{1068, 114}], 
           LineBox[{1069, 115}], LineBox[{1072, 118}], LineBox[{1080, 126}], 
           LineBox[{1087, 133}], LineBox[{1089, 135}], LineBox[{1092, 138}], 
           LineBox[{1096, 142}], LineBox[{1097, 143}], LineBox[{1098, 144}], 
           LineBox[{1099, 145}], LineBox[{1100, 146}], LineBox[{1101, 147}], 
           LineBox[{1102, 148}], LineBox[{1103, 149}], LineBox[{1104, 150}], 
           LineBox[{1106, 152}], LineBox[{1107, 153}], LineBox[{1108, 154}], 
           LineBox[{1109, 155}], LineBox[{1112, 158}], LineBox[{1113, 159}], 
           LineBox[{1114, 160}], LineBox[{1115, 161}], LineBox[{1118, 164}], 
           LineBox[{1121, 167}], LineBox[{1122, 168}], LineBox[{1123, 169}], 
           LineBox[{1124, 170}], LineBox[{1126, 172}], LineBox[{1128, 174}], 
           LineBox[{1129, 175}], LineBox[{1138, 184}], LineBox[{1146, 192}], 
           LineBox[{1147, 193}], LineBox[{1148, 194}], LineBox[{1150, 196}], 
           LineBox[{1151, 197}], LineBox[{1154, 200}], LineBox[{1159, 205}], 
           LineBox[{1160, 206}], LineBox[{1161, 207}], LineBox[{1164, 210}], 
           LineBox[{1171, 217}], LineBox[{1172, 218}], LineBox[{1173, 219}], 
           LineBox[{1175, 221}], LineBox[{1177, 223}], LineBox[{1178, 224}], 
           LineBox[{1179, 225}], LineBox[{1180, 226}], LineBox[{1181, 227}], 
           LineBox[{1182, 228}], LineBox[{1183, 229}], LineBox[{1184, 230}], 
           LineBox[{1188, 234}], LineBox[{1194, 240}], LineBox[{1196, 242}], 
           LineBox[{1197, 243}], LineBox[{1199, 245}], LineBox[{1201, 247}], 
           LineBox[{1202, 248}], LineBox[{1203, 249}], LineBox[{1204, 250}], 
           LineBox[{1205, 251}], LineBox[{1206, 252}], LineBox[{1207, 253}], 
           LineBox[{1212, 258}], LineBox[{1216, 262}], LineBox[{1217, 263}], 
           LineBox[{1220, 266}], LineBox[{1222, 268}], LineBox[{1239, 285}], 
           LineBox[{1240, 286}], LineBox[{1241, 287}], LineBox[{1242, 288}], 
           LineBox[{1243, 289}], LineBox[{1244, 290}], LineBox[{1245, 291}], 
           LineBox[{1246, 292}], LineBox[{1247, 293}], LineBox[{1248, 294}], 
           LineBox[{1249, 295}], LineBox[{1250, 296}], LineBox[{1251, 297}], 
           LineBox[{1253, 299}], LineBox[{1254, 300}], LineBox[{1256, 302}], 
           LineBox[{1257, 303}], LineBox[{1259, 305}], LineBox[{1260, 306}], 
           LineBox[{1261, 307}], LineBox[{1262, 308}], LineBox[{1265, 311}], 
           LineBox[{1266, 312}], LineBox[{1268, 314}], LineBox[{1269, 315}], 
           LineBox[{1271, 317}], LineBox[{1272, 318}], LineBox[{1273, 319}], 
           LineBox[{1274, 320}], LineBox[{1278, 324}], LineBox[{1279, 325}], 
           LineBox[{1280, 326}], LineBox[{1286, 332}], LineBox[{1287, 333}], 
           LineBox[{1288, 334}], LineBox[{1289, 335}], LineBox[{1290, 336}], 
           LineBox[{1292, 338}], LineBox[{1293, 339}], LineBox[{1295, 341}], 
           LineBox[{1305, 351}], LineBox[{1307, 353}], LineBox[{1308, 354}], 
           LineBox[{1314, 360}], LineBox[{1315, 361}], LineBox[{1316, 362}], 
           LineBox[{1317, 363}], LineBox[{1319, 365}], LineBox[{1320, 366}], 
           LineBox[{1322, 368}], LineBox[{1325, 371}], LineBox[{1327, 373}], 
           LineBox[{1330, 376}], LineBox[{1331, 377}], LineBox[{1332, 378}], 
           LineBox[{1334, 380}], LineBox[{1335, 381}], LineBox[{1336, 382}], 
           LineBox[{1337, 383}], LineBox[{1338, 384}], LineBox[{1339, 385}], 
           LineBox[{1340, 386}], LineBox[{1341, 387}], LineBox[{1342, 388}], 
           LineBox[{1343, 389}], LineBox[{1344, 390}], LineBox[{1346, 392}], 
           LineBox[{1347, 393}], LineBox[{1348, 394}], LineBox[{1351, 397}], 
           LineBox[{1355, 401}], LineBox[{1356, 402}], LineBox[{1357, 403}], 
           LineBox[{1359, 405}], LineBox[{1360, 406}], LineBox[{1361, 407}], 
           LineBox[{1365, 411}], LineBox[{1368, 414}], LineBox[{1370, 416}], 
           LineBox[{1373, 419}], LineBox[{1376, 422}], LineBox[{1377, 423}], 
           LineBox[{1379, 425}], LineBox[{1384, 430}], LineBox[{1390, 436}], 
           LineBox[{1397, 443}], LineBox[{1399, 445}], LineBox[{1400, 446}], 
           LineBox[{1401, 447}], LineBox[{1404, 450}], LineBox[{1406, 452}], 
           LineBox[{1407, 453}], LineBox[{1408, 454}], LineBox[{1409, 455}], 
           LineBox[{1410, 456}], LineBox[{1413, 459}], LineBox[{1414, 460}], 
           LineBox[{1415, 461}], LineBox[{1416, 462}], LineBox[{1419, 465}], 
           LineBox[{1420, 466}], LineBox[{1421, 467}], LineBox[{1423, 469}], 
           LineBox[{1424, 470}], LineBox[{1435, 481}], LineBox[{1436, 482}], 
           LineBox[{1437, 483}], LineBox[{1439, 485}], LineBox[{1440, 486}], 
           LineBox[{1441, 487}], LineBox[{1443, 489}], LineBox[{1446, 492}], 
           LineBox[{1448, 494}], LineBox[{1450, 496}], LineBox[{1452, 498}], 
           LineBox[{1457, 503}], LineBox[{1458, 504}], LineBox[{1463, 509}], 
           LineBox[{1465, 511}], LineBox[{1467, 513}], LineBox[{1469, 515}], 
           LineBox[{1470, 516}], LineBox[{1474, 520}], LineBox[{1479, 525}], 
           LineBox[{1480, 526}], LineBox[{1483, 529}], LineBox[{1484, 530}], 
           LineBox[{1485, 531}], LineBox[{1488, 534}], LineBox[{1490, 536}], 
           LineBox[{1491, 537}], LineBox[{1499, 545}], LineBox[{1501, 547}], 
           LineBox[{1502, 548}], LineBox[{1504, 550}], LineBox[{1505, 551}], 
           LineBox[{1507, 553}], LineBox[{1509, 555}], LineBox[{1510, 556}], 
           LineBox[{1511, 557}], LineBox[{1512, 558}], LineBox[{1514, 560}], 
           LineBox[{1517, 563}], LineBox[{1518, 564}], LineBox[{1522, 568}], 
           LineBox[{1523, 569}], LineBox[{1526, 572}], LineBox[{1531, 577}], 
           LineBox[{1533, 579}], LineBox[{1534, 580}], LineBox[{1538, 584}], 
           LineBox[{1539, 585}], LineBox[{1540, 586}], LineBox[{1542, 588}], 
           LineBox[{1545, 591}], LineBox[{1548, 594}], LineBox[{1551, 597}], 
           LineBox[{1553, 599}], LineBox[{1554, 600}], LineBox[{1555, 601}], 
           LineBox[{1556, 602}], LineBox[{1557, 603}], LineBox[{1558, 604}], 
           LineBox[{1561, 607}], LineBox[{1562, 608}], LineBox[{1563, 609}], 
           LineBox[{1564, 610}], LineBox[{1565, 611}], LineBox[{1568, 614}], 
           LineBox[{1569, 615}], LineBox[{1570, 616}], LineBox[{1571, 617}], 
           LineBox[{1573, 619}], LineBox[{1574, 620}], LineBox[{1576, 622}], 
           LineBox[{1579, 625}], LineBox[{1581, 627}], LineBox[{1583, 629}], 
           LineBox[{1584, 630}], LineBox[{1585, 631}], LineBox[{1586, 632}], 
           LineBox[{1593, 639}], LineBox[{1594, 640}], LineBox[{1595, 641}], 
           LineBox[{1596, 642}], LineBox[{1597, 643}], LineBox[{1599, 645}], 
           LineBox[{1600, 646}], LineBox[{1604, 650}], LineBox[{1605, 651}], 
           LineBox[{1606, 652}], LineBox[{1607, 653}], LineBox[{1613, 659}], 
           LineBox[{1614, 660}], LineBox[{1615, 661}], LineBox[{1616, 662}], 
           LineBox[{1621, 667}], LineBox[{1622, 668}], LineBox[{1623, 669}], 
           LineBox[{1624, 670}], LineBox[{1626, 672}], LineBox[{1627, 673}], 
           LineBox[{1628, 674}], LineBox[{1630, 676}], LineBox[{1631, 677}], 
           LineBox[{1632, 678}], LineBox[{1633, 679}], LineBox[{1635, 681}], 
           LineBox[{1640, 686}], LineBox[{1646, 692}], LineBox[{1647, 693}], 
           LineBox[{1648, 694}], LineBox[{1649, 695}], LineBox[{1652, 698}], 
           LineBox[{1653, 699}], LineBox[{1654, 700}], LineBox[{1655, 701}], 
           LineBox[{1656, 702}], LineBox[{1658, 704}], LineBox[{1659, 705}], 
           LineBox[{1662, 708}], LineBox[{1663, 709}], LineBox[{1664, 710}], 
           LineBox[{1665, 711}], LineBox[{1666, 712}], LineBox[{1668, 714}], 
           LineBox[{1671, 717}], LineBox[{1673, 719}], LineBox[{1674, 720}], 
           LineBox[{1675, 721}], LineBox[{1679, 725}], LineBox[{1681, 727}], 
           LineBox[{1682, 728}], LineBox[{1683, 729}], LineBox[{1684, 730}], 
           LineBox[{1685, 731}], LineBox[{1696, 742}], LineBox[{1700, 746}], 
           LineBox[{1701, 747}], LineBox[{1702, 748}], LineBox[{1708, 754}], 
           LineBox[{1711, 757}], LineBox[{1712, 758}], LineBox[{1715, 761}], 
           LineBox[{1718, 764}], LineBox[{1722, 768}], LineBox[{1723, 769}], 
           LineBox[{1726, 772}], LineBox[{1731, 777}], LineBox[{1732, 778}], 
           LineBox[{1733, 779}], LineBox[{1736, 782}], LineBox[{1737, 783}], 
           LineBox[{1738, 784}], LineBox[{1739, 785}], LineBox[{1742, 788}], 
           LineBox[{1745, 791}], LineBox[{1751, 797}], LineBox[{1754, 800}], 
           LineBox[{1755, 801}], LineBox[{1757, 803}], LineBox[{1758, 804}], 
           LineBox[{1760, 806}], LineBox[{1761, 807}], LineBox[{1763, 809}], 
           LineBox[{1764, 810}], LineBox[{1767, 813}], LineBox[{1768, 814}], 
           LineBox[{1769, 815}], LineBox[{1770, 816}], LineBox[{1773, 819}], 
           LineBox[{1774, 820}], LineBox[{1775, 821}], LineBox[{1776, 822}], 
           LineBox[{1779, 825}], LineBox[{1788, 834}], LineBox[{1789, 835}], 
           LineBox[{1798, 844}], LineBox[{1803, 849}], LineBox[{1804, 850}], 
           LineBox[{1805, 851}], LineBox[{1806, 852}], LineBox[{1807, 853}], 
           LineBox[{1813, 859}], LineBox[{1816, 862}], LineBox[{1818, 864}], 
           LineBox[{1820, 866}], LineBox[{1821, 867}], LineBox[{1822, 868}], 
           LineBox[{1823, 869}], LineBox[{1824, 870}], LineBox[{1825, 871}], 
           LineBox[{1827, 873}], LineBox[{1828, 874}], LineBox[{1829, 875}], 
           LineBox[{1836, 882}], LineBox[{1837, 883}], LineBox[{1838, 884}], 
           LineBox[{1841, 887}], LineBox[{1842, 888}], LineBox[{1843, 889}], 
           LineBox[{1844, 890}], LineBox[{1847, 893}], LineBox[{1852, 898}], 
           LineBox[{1853, 899}], LineBox[{1857, 903}], LineBox[{1858, 904}], 
           LineBox[{1859, 905}], LineBox[{1860, 906}], LineBox[{1862, 908}], 
           LineBox[{1863, 909}], LineBox[{1868, 914}], LineBox[{1869, 915}], 
           LineBox[{1872, 918}], LineBox[{1873, 919}], LineBox[{1874, 920}], 
           LineBox[{1877, 923}], LineBox[{1878, 924}], LineBox[{1879, 925}], 
           LineBox[{1882, 928}]}}, {{}, 
          {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           0.0055000000000000005`], AbsoluteThickness[1.6], 
           PointBox[CompressedData["
1:eJwN02MDFQYAAMC3bNt2Ldu1ZdvL5pZt27Zt27Zt2959uJ9wiRu0rdjmj0Ag
sC1oINAxZCDQic50oSvd6E4PetKL3vShL/3ozwAGMojBDGEowxjOCEYyitGM
YSzjGM8EJjKJyUxhKtOYzgxmMovZzGEu85jPAhayiMUsYSnLWM4KVrKK1axh
LetYzwY2sonNbGEr29jODnayi93sYS/72M8BDnKIwxzhKMc4zglOcorTnOEs
5zjPBS5yictc4SrXuM4NbnKL29zhLve4zwMe8ojHPOEpz3jOC17yite84S3v
eM8HPvKJz3zhK9/4zg9+8ovfBEIFAn8QhKAEIzghCEkoQhOGsIQjPBGISCQi
E4WoRCM6MYhJLGITh7jEIz4JSEgiEpOEpCQjOSlISSpSk4a0pCM9GfiTjGQi
M1nISjayk4Oc5CI3echLPvJTgIIUojBFKMpf/E0xilOCkpSiNGUoSznKU4GK
VKIyVahKNapTg5rUojZ1qEs9/qE+DWhIIxrThKY0ozktaEkrWtOGtrSjPR34
l//oSCc604WudKM7PehJL3rTh770oz8DGMggBjOEoQxjOCMYyShGM4axjGM8
E5jIJCYzhalMYzozmMksZjOHucxjPgtYyCIWs4SlLGM5K1jJKlazhrWsYz0b
2MgmNrOFrWxjOzvYyS52s4e97GM/BzjIIQ5zhKMc4zgnOMkpTnOGs5zjPBe4
yCUuc4WrXOM6N7jJLW5zh7vc4z4PeMgjHvOEpzzjOS94ySte84a3vOM9H/jI
Jz7zha984zs/+MkvfhMI7T9BCEowghOCkIQiNGEISzjCE4GIRCIyUYhKNKIT
g5jEIjZxiEs84pOAhCQiMUlISjKSk4KUpCI1aUhLOtKTgT/JSCYyk4WsZCM7
OchJLnKTh7zkIz8FKEghClOEovzF3xSjOCUoSSlKU4aylKM8FahIJSpThapU
ozo1qEktalOHutTjH+rTgIY0ojFNaEozmtOClrSiNW1oSzva04F/+Y+OdKIz
XehKN7rTg570ojd96Es/+jOAgQxiMEMYyjCGM4KRjGI0YxjLOMYzgYlMYjJT
mMo0pjODmcxiNnOYyzzms4CFLGIxS1jKMpazgpWsYjVrWMs61rOBjWxiM1vY
yja2s4Od7GI3e9jLPvZzgIMc4jBHOMoxjnOCk5ziNGc4yznOc4GLXOIyV7jK
Na5zg5vc4jZ3uMs97vOAhzziMU94yjOe84KXvOI1b3jLO97zgY984jNf+Mo3
vvODn/ziN4Ew/hOEoAQjOCEISShCE4awhCM8EYhIJCIThahEIzoxiEksYhOH
uMQjPglISCISk4SkJCM5KUhJKlKThrSkIz0Z+JOMZCIzWchKNrKTg5zkIjd5
yEs+8lOAghSiMEUoyl/8TTGKU4KSlKI0ZShLOcpTgYpUojJVqEo1qlODmtSi
NnWoSz3+oT4NaEgjGtOEpjSjOS1oSSta04a2tKM9HfiX/+hIJzrTha50ozs9
6EkvetOHvvSjPwMYyCAGM4ShDGM4IxjJKEYzhrGMYzwTmMgkJjOFqUxjOjOY
ySxmM4e5zGM+C1jIIhazhKUsYzkrWMkqVrOGtaxjPRvYyCY2s4WtbGM7O9jJ
Lnazh73sYz8HOMghDnOEoxzjOCc4ySlOc4aznOM8F7jIJS5zhatc4zo3uMkt
bnOHu9zjPg94yCMe84SnPOM5L3jJK17zhre84z0f+MgnPvOFr3zjOz/4yS9+
EwjrP0EISjCCE4KQhCI0YQhLOMITgYhEIjJRiEo0ohODmMQiNnGISzzik4CE
JCIxSUhKMpKTgpSkIjVpSEs60pOB/wFt6QsY
            "]]}, {}}}], {}, {}, {}, {}},
      
      AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
      Axes->{True, True},
      AxesLabel->{None, None},
      AxesOrigin->{0, 0},
      DisplayFunction->Identity,
      Frame->{{True, True}, {True, True}},
      FrameLabel->{{
         FormBox["\"Correlation\"", TraditionalForm], None}, {
         FormBox["\"Weeks\"", TraditionalForm], 
         FormBox["\"tempSC3\"", TraditionalForm]}},
      FrameStyle->Directive[18, 
        Thickness[Large]],
      FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
      GridLines->{None, None},
      GridLinesStyle->Directive[
        GrayLevel[0.5, 0.4]],
      ImagePadding->All,
      Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& ), "CopiedValueFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& )}},
      PlotRange->{{0, 954}, {-0.09190873622617055, 0.08445939930022339}},
      PlotRangeClipping->True,
      PlotRangePadding->{{0, 0}, {
         Scaled[0.05], 
         Scaled[0.05]}},
      Ticks->{Automatic, Automatic}], {193.5, -116.80842387373012}, 
     ImageScaled[{0.5, 0.5}], {360., 222.49223594996212}], InsetBox[
     GraphicsBox[{{{}, GraphicsComplexBox[CompressedData["
1:eJzt3fdXU1m0B/DYUUfNWLHHNmKPioqj4tcOChg7YgsgiBQNPfRLD01jxx4V
FCvBijpq7NijoyP2jBXLaKxgQR9vse9bi/0vPPxl1mdubk5O26fcyzrt3BZO
9KgqkUh61pVI/ve/5f/MQ3WrHHZ1mX5gKP0PjLi/8oT3wZQT5bRA6+uT3d3r
bKDrUuwsetJs+ok8ut4Ym1qFV7+l1NF1SxwMrHdp95RMcius8li+6o8P8WQZ
up01BE966UVujzo1L7QeXy+D3BFjp748sFc3j77/Dxyo/9cJlVpNtsLZmdlN
UwIWk7tizJw3xvvjVpO7Y2neg+/6dRpyT/TPO7TTOTOBLEfS2oePP9UTf09v
VF9nHlI9YjG5D+4k/PqzoIGYv754ErjQ+2j1jXTdGkXhT+qP66yj6/1gPX1f
4p6aq+h6f3jeNXUxLllCHoDWPZ+N7jVwJX3eBo0u/t4z0rSUrg9E7EuLO/vC
xN//J442ntgr6/FKuj4IqzeeMVtV20PXB2NJi2n9DBfc6PoQRAa/P3hi9166
bovf30UMOmS5ma4PRcIY1yaPk+LoOrCyRcnN8yPp9wjAi2rVdkd1FOt7GG5s
36Rvszedrg/Dr27HPMYqN9P14ahRZdGwz7kr6PpwtLi2OuqWPJOuj8Dfk7Yp
J3rFlacvjMDUKxYvH/4Qy2skzro2n65dvIruH4mjucsc1hTtpuuj4PjNNmV1
l9V0/yjEDPI4mrJebF+j4d7JLSr5B7UPYTSanLfuMOBmDt0/BqNzcuteepVE
18egy4Eq9keSxet2GPOwytf3Naj8BTv87Gwdc0NH6UnsYZHr1XDNVypPwR4j
fnonGOap6P6xuDrx2gHLe1Tfwlh8nPTOYe+cYLo+DsMWdJ43oCF9XhiHtedc
Aj59EsvPAQUL+i3+VkdL9zvgWNOHq6WeYv07ok2kfPuKepvofkdsm1bN+Y6d
2B6c8HXBns6LrorpO2Gf8OPfpcH0ecl49F52u5dvp2F0fTzCdr6Zqf+/9qWA
qm1zpxuJ1D+ggLVd9JR7j2MpPQX23NuQf+T3vPL7DQrMLBm19bz9Mkp/Akqq
9upZT+NI90/AkEEY2G0X9XdhAlot7CrU1Ojp/gmY8E9p83MpYvuYiPiDi6Qz
LKLKr2MiFkw6Ouf6iHV0/0TYdpuzo5qC4pFhIrb82bT7P23W0v2TEH0+Zn+j
zZRfTELXm/ptpsgddP8kHD/n3Nz1/Bi6fxJibjrUz/wplv9klC4dNmrroyV0
/2T0ufew6LkxjfI/Gf9tnuildqH2YJiMBaXd4vLbrKf8T8F/LToPdHhG/QtT
0GZWmzd9WlA8E6YgWT9ocvWB7nT/FAS9cFYXtKb0JFPRYe/ZVe/+0dD9UxGN
N12ze6yl+6fC8Fpevckjap+GqbAY9aTZjuVJlP40DD2TH3Zn6XK6fxpaq0zv
vRxW0P3T0CA3O8twjtqLYRrOrdk+9FmtFLrfGVVHSvY/fyve74zi9R2TUiMp
/gnOyG252Ol0mD/d74xnp//S/L1dTH86/GoOeNLHzorKbzrCZ55eYvostufp
sOnn9KT1CWr/hun4dPm35ktTl1P+XZDctln6d+dsSt8FTqFLmqzSTKH7XXBg
0Oo1/0YFUPou+FW3Sdvh78T+NwP15lokai5Op/RnQDXyUtvEOmI8mgF3m+Ub
32nE3z8Dk/+e9dcKIYTun4ms3pP7zOtL8RAzcXKCssXn7lvo/pnIODQgyLEZ
1a9hJhLeWvz9MUccn2Zh/UB56b4+FL8wC8s0G2LDAsR4NgudWue83Z9D9WGY
hehaEYmZxxWU/mwc/RzsGWFwp/tnI6z2HbeZ23fS/bPxtXfoxw/rF1H5zUb+
RI8x42zF8WMOftTWV+ubRO0Zc2Bb6vCtcXUt3T8Hz14cnthtKtWHYQ7uTrJZ
OLiKGN+VGH0G164nCuWWKZG8aG7No3/TeAclpmhL48Na0/ilVGLdAbVfSAnV
n6DE4jonml7uElJ+XadErRXv+g/e40rpKTHqTrXJyTHbyj9vUsJ2X4e9zy+J
8csVBbEN81+dpfKSuaLPncJ32nNbKX1XXN3a5+76V/7lVrpiyLgBK+rIKF4J
rigaWbzyWR0qD50rnBJX9j3ZmPJjcEWPx/EfNvWmeGxyxZYPmgnTrMXx3w1b
A7p+qF2L4qfMDfeD8r+7Nl5E7dENnzWvLwQnULxTusFqy5sizS36fsENkf8l
rFJMX0P5d0P19X4WYeOjKX039Jp2uOmcfL/y6yY3uCy79P7x1/2Uvju6/Xzy
b+tRlJ7MHXVn/ltvVjPq/3BHm0H9fwV3pniodMembcfy/4wV44M7xiT98Xz3
R2qvOnck93w/M+rlBkrfHcv+ybEfnJBO6bsjxapFs4jFYv+di/+avbVf9Jbi
kWwuap3WxG0Zl0bpz4VN0eijNVr4UfnPRY5/vk+ky0bK/1zcvn1rvF1n6m+6
uZDV6pM148hSSn8uHh1dduD25e1U/nPRb3/X9D8WJ1D6HjjY/f6S4Uol5d8D
fgXrO/2rjaX0PWCc1+a4e3dqH0oP6J6OnF4atZ7S90CzhXaehy5S/NB54F6P
o2OWBCRS+/NA6fjlJSHK7ZR/D6xfONug9llI5e+J6iPPRAunqb3LPDH5ZDsH
SaQPtT9PqF8P2tNRn03pe2JT6lv5gn40fxE8MWXGBMW4ZsmUf08cSQrpXbqE
vs/gCQx5tPb4J2rPJk8U3X7549jsGEp/HhYUj1/UrtcESn8ehqW2rF13rAOl
Pw+dR6+5dtad+o9yHgpy2tf2bUXfJ8xDy8XZRe1OU/zQzYPj4dwvq6fR7zPM
Q9N6H8d27Ev9wzQPU36v3sN9nTj+eGFdlzHDH4ym8pN5wSO5c/ERWxpv4IVV
ra3u3/Wk8U7phb313iwquCxQ+/PC8UUugiqN5gc6LygHnPyyLJ3mewYvRFt3
7t2lCvUXkxdK998u8NttS/U/HzGbvwe6bKf5tGw+0h5MXPaPJ/1+zEej0jo+
9dodpvzPx7f7a+yPDBbjz3ycfPX4cIfdlB/dfJja5o873Jb6m2E+4hel91TN
oP5rmg+rCReflmSL83NvuN8ZOviqsyeVvzfmnvm7nfppBqXvjb8Obr+e6kPx
TemNPldu92n1Voyv3tilv5+RPZD6g84bY7cfXD9HT/HJ4I0WVZwWnVpB/cPk
DZX9J592b3ZR+ftgvHZS+53vaT4v88Hm7Z0+u3mK/d8HwdETOp4eR/NdpQ/C
d39LbTuV5kOCD7IMC4ubuVH70PnAu6PtwC3XxPHKBy2dbBtEHKX5kckHezKe
TbziIM7ffBH56G9jE4HmazJftJ995Nz3IVsofV/stElf/KdyHZW/L+qEq07u
c6DyFXwR41I194uW5i86Xxw9Urf1qmX0ew2+SOz4zs8qJZTK3xf7F/eVezSm
8pD44fvmTL1/KZWnzA9OV9bVn3ckmdL3Q0qnRWlHXKg/K/1wMKfJpt71KR4J
fqh7f/wBu1jKn84P7y6WBlpsFdu/H9wPff7ldFUcf/wweNtfp5b3oHgpWYDv
YZuXfGqYSukvQOsJJwpU7am9YgEmuSc1zDpL9aFcgAe/Tc+7P4/ip7AALrZf
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
NKD60iVgjLlw7fIomp/mJODPr+kHo8X1rj4Bz6p5/ttsNs3H8svKM3vuzmZh
4vtICbiReMqm6kkqn4IEvPjRpnp+e4p/xgQ0uTEgun8zej+gMAH1puxvXexP
++umsvwNrLbb8h9KvygB7wsDe6xYRfHRXFZfPf/+NaINrSdKEhB26PGHwz/F
928SMSg6LXjLEZovWCQiXiHzvd2E5mvSRGSN7fb0cATNFywT4fPl4fjRx6g+
ZImorVp21K0V1bdVIvwGvJGs+yw+L0lETuC1jFZXaT5nk4hbOSUxVm28qf8n
4tqZwz+m/U7zG7tEvB6XeGxac/F5QiI+DtyRdaIL7Yc5J6Ka8a+dV6eJ7wMk
4pJ3kcOr+zR/9kpE/+H9BweP7ULxPxFxPfq9Tu5O+8nqROhe/zyc9dWN6j8R
mZ+a9S7+SfFWk4jmdfrMODyG4qk2ESXy+ie29qfxLTMRI+c3vnc4leb/ukR0
s3974rGY35xEPAsM7+WTTe8z6BORlto92sufPp+fiHk5H8JHtab9cUMiJvTe
cbGuGO8KEjFuVJp1ogfVpzERtRp+Md8qpfVQYSKq/jJ7xg8X5/eJuF9Hdfvq
OYoHRWXlZRk/ofVKmg+YE6Gd49/A7xON5yWJqLFNHXdnJ/UHSRIsfw8KPN6R
fq9FEjZ+cGuatJviiTQJ1S6WqAacovW/ZRIyv88tTbgoxv8kXJw28cvqLvT+
glUSXqq3O47xFft/Ekq6bl2x4S96n9AmCTOLJoVM1NH7D0gqG/9/qxtjTeOP
XRLezP4QWCWN9nMVSZhzeeDezM3U35yT8Paq9s/6taZT/0+CvmmzVoH1KD55
JWF/KHR1iim/qiQoDlp3d7Sj+KBOQofl/Zas8hTfd03CKbmr3/IUGh81SVg1
7el/W67T8xptEoZF5KS160z7A5llv+ddk5PT3ej5ny4JuqVusbGvaP2fkwT5
uNrrlSdovNInocmEOw47k6i88pNwuUdP/5/e4vtgSXC27dlx0RlarxQkYVrN
ku4/xtL61ZiE5T+GbJqWTeu3wiR4hRu+JPeh9YcpCR82z7+3pgPF46Ik2Nct
3oo8am/mJPw2OnZPVBKVf0lZfoPfCb1NVD6SZPgrem7w7+FA9Z+MWfEZtxR9
6fukySi6uipjZweKR5bJ6Nk5Nybg8Wyq/2QsfLZ7Vtgmqh+rZLR/4llwMIXG
X3kytB2PzXEA7UfZJCM48shQ0+/i86NkbJg00KXxYksa/5Pxrn9/d41/Der/
yXBc/HJTrc40vjgn4/WQ9tWWivvhymTc6X8zJUJB8wuvZPTKz44srUnjiyoZ
Te/XCJq/Qaz/ZPzK98/rnSG+v5SMbwOulj66MJLqPxnnZT9Pvbso7kckIzTH
vtrQdKqfzGTkql26Tjwlvm9Qlr/HE3uOSJlK9Z+Mi5ndOxfPpvWjPhnX5sXe
iHlC42t+MsZ+Xjl765NZVP/J8HDvPXBUMs2HCpLRKEi7zqca5c+YjBcTmlRJ
09Dzp8Jk7PHOmXtsgfg+W1n5dE29lBVF9xclw/NY6YiI6dSfzMn4r3FO0N3a
NL6UJONnw+1TEvqL+58aOJ462jL0KvUfCw1sn337vWMk9WepBsFznA9MXUXz
TUsNuurjxtfaSZZp8Lrvoy8NxPW0lQYB7eZ1CgS1F7kGdW/taPs1nT5vo8Hk
Lnl/jFOK77tqMMn/+/odk6m922nws0qrc54bKH8KDXw3Fhnu5VA8cNZgV9yV
TvbWdF2pwdv/8jd8y6P3a700qClMLLbQFB8vr38NLr/36pp6kdq7WoMhF457
uZ0Snz9r8KR26QQXX6pPjQY9D8XceFGV4rFWg0ef33VzcZVS/WvwdMvjgp5O
4vtGGlx6mZruMJjae44GWd3cDbZ+Y6n+NUj5d4xg8Ynab37Z73n2ZEp0A/H9
KA26D7M+GVjHhepfg7RQ6R+T71F/Mmpwq8PQVqH9KH4UamB1r/kA6XraDzJp
4D3bdutQT5rPF2nQxMez1rIztD9j1qCGcf4W22xq7yUaHFwVeGFuKcUDSQqe
XE9xXfCC5hcWKWj6c+f+xi1pvSNNQfGBlFeX29H60DIFl8/Y3W8qvo8hS0GG
Qe+WZyWO/ylo+bp0/80t1L/lKbjt1zDiThNx/ZeCqz1st0WepvSRgkvthn+2
vETrXbsU5K6v0sWhmJ5HKlIg2/W7IP9I8cM5BRaxv2ws/qL5gjIFs0bMXbsr
lPYbvFIwbUWJV1SQOP8r+30HjmT13EXzbXUKnv1d1Ly5o/j3CCkwmHyOddhH
7UuTgrM9W717sISua1Owzr5K2oa9NP/OTMH8UUsupIj7v7oUBB0sujT6Ec0X
clKwxCflD9Vlen9Gn4JO50/+tHpGzzfzU6D94/DzLG+KV4ay+0cu3VQ/jsqv
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
bZjBbMesYHZmVjJ7MauY1cwCs4ZZy5zJrGPOYdYz5zMbmAuYjcyFzCbmImYz
cwmzJLGiLZilzJbMMmYrZjmzDTOY7ZgVzM7MSmYvZhWzmllg1jBrmTOZdcw5
zHrmfGYDcwGzkbmQ2cRcxGxmLmGWJFW0BbOU2ZJZxmzFLGe2YQazHbOC2ZlZ
yezFrGJWMwvMGmYtcyazjjmHWc+cz2xgLmA2Mhcym5iLmM3MJcyS5Iq2YJYy
WzLLmK2Y5cw2zGC2Y1YwOzMrmb2YVcxqZoFZw6xlzmTWMecw65nzmQ3MBcxG
5kJmE3MRs5m5hFmiqWgLZimzJbOM2YpZzmzDDGY7ZgWzM7OS2YtZxaxmFpg1
zFrmTGYdcw6znjmf2cBcwGxkLmQ2MRcxm5lLmCUpFW3BLGW2ZJYxWzHLmW2Y
wWzHrGB2ZlYyezGrmNXMArOGWcucyaxjzmHWM+czG5gLmI3Mhcwm5iJmM3MJ
syS1oi2YpcyWzDJmK2Y5sw0zmO2YFczOzEpmL2YVs5pZYNYwa5kzmXXMOcx6
5nxmA3MBs5G5kNnEXMRsZi5hlqRVtAWzlNmSWcZsxSxntmEGsx2zgtmZWcns
xaxiVjMLzBpmLXMms445h1nPnM9sYC5gNjIXMpuYi5jNzCXMkvSKtmCWMlsy
y5itmOXMNsxgtmNWMDszK5m9mFXMamaBWcOsZc5k1jHnMOuZ85kNzAXMRuZC
ZhNzEbOZuYRZklHRFsxSZktmGbMVs5zZhhnMdswKZmdmJbMXs4pZzSwwa5i1
zJnMOuYcZj1zPrOBuYDZyFx5fm7l+bmV5+dWnp9beX4u5b/y/NzK83Mrz8+t
PD+38vzc8vQrz8+tPD+38vzcyvNzK8/PLU+/8vzcyvNzK8/PrTw/t/L83PL8
V56fW3l+buX5uZXn51aen1ue/8rzcyvPz608P7fy/NzK83PL8195fm7l+bmV
5+dWnp9beX5uef1Xnp9beX5u5fm5lefnVp6fW17/lefnVp6fW3l+buX5uZXn
55bXf+X5uZXn51aen1t5fm7l+bnl9V95fm7l+bmV5+dWnp9beX5uef1Xnp9b
eX5u5fm5/x/Oz/0feUQCjg==
         "], {{{}, {}, {}, 
           {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
            LineBox[{956, 2}], LineBox[{958, 4}], LineBox[{964, 10}], 
            LineBox[{965, 11}], LineBox[{966, 12}], LineBox[{967, 13}], 
            LineBox[{968, 14}], LineBox[{969, 15}], LineBox[{972, 18}], 
            LineBox[{974, 20}], LineBox[{977, 23}], LineBox[{979, 25}], 
            LineBox[{981, 27}], LineBox[{983, 29}], LineBox[{985, 31}], 
            LineBox[{986, 32}], LineBox[{987, 33}], LineBox[{988, 34}], 
            LineBox[{989, 35}], LineBox[{990, 36}], LineBox[{991, 37}], 
            LineBox[{993, 39}], LineBox[{994, 40}], LineBox[{995, 41}], 
            LineBox[{998, 44}], LineBox[{999, 45}], LineBox[{1000, 46}], 
            LineBox[{1001, 47}], LineBox[{1004, 50}], LineBox[{1005, 51}], 
            LineBox[{1007, 53}], LineBox[{1008, 54}], LineBox[{1009, 55}], 
            LineBox[{1011, 57}], LineBox[{1012, 58}], LineBox[{1015, 61}], 
            LineBox[{1017, 63}], LineBox[{1018, 64}], LineBox[{1019, 65}], 
            LineBox[{1022, 68}], LineBox[{1025, 71}], LineBox[{1029, 75}], 
            LineBox[{1030, 76}], LineBox[{1033, 79}], LineBox[{1034, 80}], 
            LineBox[{1035, 81}], LineBox[{1041, 87}], LineBox[{1054, 100}], 
            LineBox[{1056, 102}], LineBox[{1057, 103}], LineBox[{1061, 107}], 
            LineBox[{1062, 108}], LineBox[{1063, 109}], LineBox[{1065, 111}], 
            LineBox[{1066, 112}], LineBox[{1067, 113}], LineBox[{1070, 116}], 
            LineBox[{1071, 117}], LineBox[{1073, 119}], LineBox[{1074, 120}], 
            LineBox[{1075, 121}], LineBox[{1076, 122}], LineBox[{1077, 123}], 
            LineBox[{1078, 124}], LineBox[{1079, 125}], LineBox[{1081, 127}], 
            LineBox[{1082, 128}], LineBox[{1083, 129}], LineBox[{1085, 131}], 
            LineBox[{1088, 134}], LineBox[{1090, 136}], LineBox[{1091, 137}], 
            LineBox[{1092, 138}], LineBox[{1093, 139}], LineBox[{1094, 140}], 
            LineBox[{1095, 141}], LineBox[{1096, 142}], LineBox[{1097, 143}], 
            LineBox[{1101, 147}], LineBox[{1103, 149}], LineBox[{1105, 151}], 
            LineBox[{1110, 156}], LineBox[{1111, 157}], LineBox[{1114, 160}], 
            LineBox[{1116, 162}], LineBox[{1117, 163}], LineBox[{1118, 164}], 
            LineBox[{1119, 165}], LineBox[{1120, 166}], LineBox[{1124, 170}], 
            LineBox[{1125, 171}], LineBox[{1129, 175}], LineBox[{1130, 176}], 
            LineBox[{1131, 177}], LineBox[{1132, 178}], LineBox[{1133, 179}], 
            LineBox[{1134, 180}], LineBox[{1135, 181}], LineBox[{1136, 182}], 
            LineBox[{1137, 183}], LineBox[{1138, 184}], LineBox[{1139, 185}], 
            LineBox[{1140, 186}], LineBox[{1141, 187}], LineBox[{1142, 188}], 
            LineBox[{1143, 189}], LineBox[{1144, 190}], LineBox[{1145, 191}], 
            LineBox[{1152, 198}], LineBox[{1155, 201}], LineBox[{1156, 202}], 
            LineBox[{1157, 203}], LineBox[{1158, 204}], LineBox[{1162, 208}], 
            LineBox[{1163, 209}], LineBox[{1165, 211}], LineBox[{1166, 212}], 
            LineBox[{1167, 213}], LineBox[{1168, 214}], LineBox[{1169, 215}], 
            LineBox[{1170, 216}], LineBox[{1174, 220}], LineBox[{1176, 222}], 
            LineBox[{1180, 226}], LineBox[{1185, 231}], LineBox[{1186, 232}], 
            LineBox[{1189, 235}], LineBox[{1190, 236}], LineBox[{1191, 237}], 
            LineBox[{1192, 238}], LineBox[{1193, 239}], LineBox[{1194, 240}], 
            LineBox[{1195, 241}], LineBox[{1198, 244}], LineBox[{1208, 254}], 
            LineBox[{1209, 255}], LineBox[{1210, 256}], LineBox[{1213, 259}], 
            LineBox[{1214, 260}], LineBox[{1218, 264}], LineBox[{1219, 265}], 
            LineBox[{1221, 267}], LineBox[{1224, 270}], LineBox[{1225, 271}], 
            LineBox[{1226, 272}], LineBox[{1227, 273}], LineBox[{1228, 274}], 
            LineBox[{1229, 275}], LineBox[{1230, 276}], LineBox[{1232, 278}], 
            LineBox[{1235, 281}], LineBox[{1236, 282}], LineBox[{1237, 283}], 
            LineBox[{1242, 288}], LineBox[{1243, 289}], LineBox[{1248, 294}], 
            LineBox[{1254, 300}], LineBox[{1255, 301}], LineBox[{1256, 302}], 
            LineBox[{1258, 304}], LineBox[{1263, 309}], LineBox[{1264, 310}], 
            LineBox[{1266, 312}], LineBox[{1267, 313}], LineBox[{1270, 316}], 
            LineBox[{1276, 322}], LineBox[{1277, 323}], LineBox[{1281, 327}], 
            LineBox[{1282, 328}], LineBox[{1284, 330}], LineBox[{1285, 331}], 
            LineBox[{1290, 336}], LineBox[{1292, 338}], LineBox[{1294, 340}], 
            LineBox[{1296, 342}], LineBox[{1297, 343}], LineBox[{1298, 344}], 
            LineBox[{1299, 345}], LineBox[{1301, 347}], LineBox[{1302, 348}], 
            LineBox[{1303, 349}], LineBox[{1306, 352}], LineBox[{1308, 354}], 
            LineBox[{1309, 355}], LineBox[{1311, 357}], LineBox[{1312, 358}], 
            LineBox[{1313, 359}], LineBox[{1314, 360}], LineBox[{1318, 364}], 
            LineBox[{1320, 366}], LineBox[{1321, 367}], LineBox[{1323, 369}], 
            LineBox[{1324, 370}], LineBox[{1326, 372}], LineBox[{1328, 374}], 
            LineBox[{1331, 377}], LineBox[{1335, 381}], LineBox[{1339, 385}], 
            LineBox[{1342, 388}], LineBox[{1343, 389}], LineBox[{1345, 391}], 
            LineBox[{1346, 392}], LineBox[{1347, 393}], LineBox[{1348, 394}], 
            LineBox[{1349, 395}], LineBox[{1350, 396}], LineBox[{1352, 398}], 
            LineBox[{1353, 399}], LineBox[{1355, 401}], LineBox[{1357, 403}], 
            LineBox[{1363, 409}], LineBox[{1364, 410}], LineBox[{1365, 411}], 
            LineBox[{1371, 417}], LineBox[{1372, 418}], LineBox[{1374, 420}], 
            LineBox[{1375, 421}], LineBox[{1379, 425}], LineBox[{1382, 428}], 
            LineBox[{1386, 432}], LineBox[{1389, 435}], LineBox[{1391, 437}], 
            LineBox[{1392, 438}], LineBox[{1393, 439}], LineBox[{1394, 440}], 
            LineBox[{1395, 441}], LineBox[{1400, 446}], LineBox[{1401, 447}], 
            LineBox[{1402, 448}], LineBox[{1403, 449}], LineBox[{1405, 451}], 
            LineBox[{1411, 457}], LineBox[{1412, 458}], LineBox[{1414, 460}], 
            LineBox[{1415, 461}], LineBox[{1418, 464}], LineBox[{1423, 469}], 
            LineBox[{1425, 471}], LineBox[{1426, 472}], LineBox[{1428, 474}], 
            LineBox[{1429, 475}], LineBox[{1430, 476}], LineBox[{1432, 478}], 
            LineBox[{1433, 479}], LineBox[{1434, 480}], LineBox[{1436, 482}], 
            LineBox[{1438, 484}], LineBox[{1442, 488}], LineBox[{1445, 491}], 
            LineBox[{1446, 492}], LineBox[{1447, 493}], LineBox[{1450, 496}], 
            LineBox[{1452, 498}], LineBox[{1453, 499}], LineBox[{1457, 503}], 
            LineBox[{1458, 504}], LineBox[{1459, 505}], LineBox[{1460, 506}], 
            LineBox[{1462, 508}], LineBox[{1464, 510}], LineBox[{1465, 511}], 
            LineBox[{1466, 512}], LineBox[{1467, 513}], LineBox[{1470, 516}], 
            LineBox[{1472, 518}], LineBox[{1473, 519}], LineBox[{1475, 521}], 
            LineBox[{1476, 522}], LineBox[{1477, 523}], LineBox[{1482, 528}], 
            LineBox[{1486, 532}], LineBox[{1487, 533}], LineBox[{1489, 535}], 
            LineBox[{1491, 537}], LineBox[{1492, 538}], LineBox[{1493, 539}], 
            LineBox[{1494, 540}], LineBox[{1496, 542}], LineBox[{1497, 543}], 
            LineBox[{1498, 544}], LineBox[{1499, 545}], LineBox[{1501, 547}], 
            LineBox[{1502, 548}], LineBox[{1504, 550}], LineBox[{1512, 558}], 
            LineBox[{1513, 559}], LineBox[{1514, 560}], LineBox[{1515, 561}], 
            LineBox[{1516, 562}], LineBox[{1518, 564}], LineBox[{1521, 567}], 
            LineBox[{1523, 569}], LineBox[{1524, 570}], LineBox[{1528, 574}], 
            LineBox[{1529, 575}], LineBox[{1534, 580}], LineBox[{1535, 581}], 
            LineBox[{1536, 582}], LineBox[{1537, 583}], LineBox[{1539, 585}], 
            LineBox[{1540, 586}], LineBox[{1544, 590}], LineBox[{1547, 593}], 
            LineBox[{1550, 596}], LineBox[{1551, 597}], LineBox[{1552, 598}], 
            LineBox[{1554, 600}], LineBox[{1555, 601}], LineBox[{1557, 603}], 
            LineBox[{1558, 604}], LineBox[{1559, 605}], LineBox[{1562, 608}], 
            LineBox[{1565, 611}], LineBox[{1566, 612}], LineBox[{1567, 613}], 
            LineBox[{1568, 614}], LineBox[{1572, 618}], LineBox[{1575, 621}], 
            LineBox[{1577, 623}], LineBox[{1579, 625}], LineBox[{1580, 626}], 
            LineBox[{1581, 627}], LineBox[{1582, 628}], LineBox[{1584, 630}], 
            LineBox[{1588, 634}], LineBox[{1589, 635}], LineBox[{1592, 638}], 
            LineBox[{1593, 639}], LineBox[{1594, 640}], LineBox[{1595, 641}], 
            LineBox[{1596, 642}], LineBox[{1601, 647}], LineBox[{1602, 648}], 
            LineBox[{1603, 649}], LineBox[{1604, 650}], LineBox[{1607, 653}], 
            LineBox[{1609, 655}], LineBox[{1611, 657}], LineBox[{1619, 665}], 
            LineBox[{1625, 671}], LineBox[{1627, 673}], LineBox[{1628, 674}], 
            LineBox[{1629, 675}], LineBox[{1631, 677}], LineBox[{1632, 678}], 
            LineBox[{1634, 680}], LineBox[{1636, 682}], LineBox[{1637, 683}], 
            LineBox[{1638, 684}], LineBox[{1641, 687}], LineBox[{1642, 688}], 
            LineBox[{1643, 689}], LineBox[{1644, 690}], LineBox[{1645, 691}], 
            LineBox[{1646, 692}], LineBox[{1648, 694}], LineBox[{1654, 700}], 
            LineBox[{1661, 707}], LineBox[{1662, 708}], LineBox[{1664, 710}], 
            LineBox[{1665, 711}], LineBox[{1666, 712}], LineBox[{1667, 713}], 
            LineBox[{1670, 716}], LineBox[{1673, 719}], LineBox[{1675, 721}], 
            LineBox[{1676, 722}], LineBox[{1677, 723}], LineBox[{1679, 725}], 
            LineBox[{1680, 726}], LineBox[{1683, 729}], LineBox[{1684, 730}], 
            LineBox[{1687, 733}], LineBox[{1688, 734}], LineBox[{1692, 738}], 
            LineBox[{1693, 739}], LineBox[{1695, 741}], LineBox[{1697, 743}], 
            LineBox[{1702, 748}], LineBox[{1703, 749}], LineBox[{1705, 751}], 
            LineBox[{1707, 753}], LineBox[{1709, 755}], LineBox[{1712, 758}], 
            LineBox[{1716, 762}], LineBox[{1717, 763}], LineBox[{1719, 765}], 
            LineBox[{1722, 768}], LineBox[{1723, 769}], LineBox[{1724, 770}], 
            LineBox[{1725, 771}], LineBox[{1727, 773}], LineBox[{1728, 774}], 
            LineBox[{1730, 776}], LineBox[{1731, 777}], LineBox[{1732, 778}], 
            LineBox[{1733, 779}], LineBox[{1735, 781}], LineBox[{1738, 784}], 
            LineBox[{1741, 787}], LineBox[{1742, 788}], LineBox[{1748, 794}], 
            LineBox[{1749, 795}], LineBox[{1752, 798}], LineBox[{1753, 799}], 
            LineBox[{1759, 805}], LineBox[{1760, 806}], LineBox[{1761, 807}], 
            LineBox[{1762, 808}], LineBox[{1763, 809}], LineBox[{1765, 811}], 
            LineBox[{1767, 813}], LineBox[{1770, 816}], LineBox[{1772, 818}], 
            LineBox[{1774, 820}], LineBox[{1776, 822}], LineBox[{1777, 823}], 
            LineBox[{1780, 826}], LineBox[{1782, 828}], LineBox[{1784, 830}], 
            LineBox[{1791, 837}], LineBox[{1794, 840}], LineBox[{1796, 842}], 
            LineBox[{1798, 844}], LineBox[{1799, 845}], LineBox[{1800, 846}], 
            LineBox[{1802, 848}], LineBox[{1803, 849}], LineBox[{1806, 852}], 
            LineBox[{1807, 853}], LineBox[{1808, 854}], LineBox[{1810, 856}], 
            LineBox[{1811, 857}], LineBox[{1812, 858}], LineBox[{1813, 859}], 
            LineBox[{1814, 860}], LineBox[{1817, 863}], LineBox[{1819, 865}], 
            LineBox[{1820, 866}], LineBox[{1823, 869}], LineBox[{1824, 870}], 
            LineBox[{1825, 871}], LineBox[{1826, 872}], LineBox[{1827, 873}], 
            LineBox[{1829, 875}], LineBox[{1831, 877}], LineBox[{1833, 879}], 
            LineBox[{1834, 880}], LineBox[{1840, 886}], LineBox[{1841, 887}], 
            LineBox[{1842, 888}], LineBox[{1843, 889}], LineBox[{1844, 890}], 
            LineBox[{1845, 891}], LineBox[{1846, 892}], LineBox[{1848, 894}], 
            LineBox[{1849, 895}], LineBox[{1856, 902}], LineBox[{1858, 904}], 
            LineBox[{1859, 905}], LineBox[{1860, 906}], LineBox[{1863, 909}], 
            LineBox[{1864, 910}], LineBox[{1865, 911}], LineBox[{1870, 916}], 
            LineBox[{1871, 917}], LineBox[{1874, 920}], LineBox[{1875, 921}], 
            LineBox[{1880, 926}], LineBox[{1882, 928}], LineBox[{1883, 929}], 
            LineBox[{1885, 931}], LineBox[{1888, 934}], LineBox[{1889, 935}], 
            LineBox[{1891, 937}], LineBox[{1892, 938}], LineBox[{1893, 939}], 
            LineBox[{1896, 942}], LineBox[{1897, 943}], LineBox[{1899, 945}], 
            LineBox[{1900, 946}], LineBox[{1901, 947}], LineBox[{1902, 948}], 
            LineBox[{1904, 950}], LineBox[{1906, 952}], LineBox[{1907, 953}], 
            LineBox[{1908, 954}]}, 
           {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
            LineBox[{955, 1}], LineBox[{957, 3}], LineBox[{959, 5}], 
            LineBox[{960, 6}], LineBox[{961, 7}], LineBox[{962, 8}], 
            LineBox[{963, 9}], LineBox[{970, 16}], LineBox[{971, 17}], 
            LineBox[{973, 19}], LineBox[{975, 21}], LineBox[{976, 22}], 
            LineBox[{978, 24}], LineBox[{980, 26}], LineBox[{982, 28}], 
            LineBox[{984, 30}], LineBox[{992, 38}], LineBox[{996, 42}], 
            LineBox[{997, 43}], LineBox[{1002, 48}], LineBox[{1003, 49}], 
            LineBox[{1006, 52}], LineBox[{1010, 56}], LineBox[{1013, 59}], 
            LineBox[{1014, 60}], LineBox[{1016, 62}], LineBox[{1020, 66}], 
            LineBox[{1021, 67}], LineBox[{1023, 69}], LineBox[{1024, 70}], 
            LineBox[{1026, 72}], LineBox[{1027, 73}], LineBox[{1028, 74}], 
            LineBox[{1031, 77}], LineBox[{1032, 78}], LineBox[{1036, 82}], 
            LineBox[{1037, 83}], LineBox[{1038, 84}], LineBox[{1039, 85}], 
            LineBox[{1040, 86}], LineBox[{1042, 88}], LineBox[{1043, 89}], 
            LineBox[{1044, 90}], LineBox[{1045, 91}], LineBox[{1046, 92}], 
            LineBox[{1047, 93}], LineBox[{1048, 94}], LineBox[{1049, 95}], 
            LineBox[{1050, 96}], LineBox[{1051, 97}], LineBox[{1052, 98}], 
            LineBox[{1053, 99}], LineBox[{1055, 101}], LineBox[{1058, 104}], 
            LineBox[{1059, 105}], LineBox[{1060, 106}], LineBox[{1064, 110}], 
            LineBox[{1068, 114}], LineBox[{1069, 115}], LineBox[{1072, 118}], 
            LineBox[{1080, 126}], LineBox[{1084, 130}], LineBox[{1086, 132}], 
            LineBox[{1087, 133}], LineBox[{1089, 135}], LineBox[{1098, 144}], 
            LineBox[{1099, 145}], LineBox[{1100, 146}], LineBox[{1102, 148}], 
            LineBox[{1104, 150}], LineBox[{1106, 152}], LineBox[{1107, 153}], 
            LineBox[{1108, 154}], LineBox[{1109, 155}], LineBox[{1112, 158}], 
            LineBox[{1113, 159}], LineBox[{1115, 161}], LineBox[{1121, 167}], 
            LineBox[{1122, 168}], LineBox[{1123, 169}], LineBox[{1126, 172}], 
            LineBox[{1127, 173}], LineBox[{1128, 174}], LineBox[{1146, 192}], 
            LineBox[{1147, 193}], LineBox[{1148, 194}], LineBox[{1149, 195}], 
            LineBox[{1150, 196}], LineBox[{1151, 197}], LineBox[{1153, 199}], 
            LineBox[{1154, 200}], LineBox[{1159, 205}], LineBox[{1160, 206}], 
            LineBox[{1161, 207}], LineBox[{1164, 210}], LineBox[{1171, 217}], 
            LineBox[{1172, 218}], LineBox[{1173, 219}], LineBox[{1175, 221}], 
            LineBox[{1177, 223}], LineBox[{1178, 224}], LineBox[{1179, 225}], 
            LineBox[{1181, 227}], LineBox[{1182, 228}], LineBox[{1183, 229}], 
            LineBox[{1184, 230}], LineBox[{1187, 233}], LineBox[{1188, 234}], 
            LineBox[{1196, 242}], LineBox[{1197, 243}], LineBox[{1199, 245}], 
            LineBox[{1200, 246}], LineBox[{1201, 247}], LineBox[{1202, 248}], 
            LineBox[{1203, 249}], LineBox[{1204, 250}], LineBox[{1205, 251}], 
            LineBox[{1206, 252}], LineBox[{1207, 253}], LineBox[{1211, 257}], 
            LineBox[{1212, 258}], LineBox[{1215, 261}], LineBox[{1216, 262}], 
            LineBox[{1217, 263}], LineBox[{1220, 266}], LineBox[{1222, 268}], 
            LineBox[{1223, 269}], LineBox[{1231, 277}], LineBox[{1233, 279}], 
            LineBox[{1234, 280}], LineBox[{1238, 284}], LineBox[{1239, 285}], 
            LineBox[{1240, 286}], LineBox[{1241, 287}], LineBox[{1244, 290}], 
            LineBox[{1245, 291}], LineBox[{1246, 292}], LineBox[{1247, 293}], 
            LineBox[{1249, 295}], LineBox[{1250, 296}], LineBox[{1251, 297}], 
            LineBox[{1252, 298}], LineBox[{1253, 299}], LineBox[{1257, 303}], 
            LineBox[{1259, 305}], LineBox[{1260, 306}], LineBox[{1261, 307}], 
            LineBox[{1262, 308}], LineBox[{1265, 311}], LineBox[{1268, 314}], 
            LineBox[{1269, 315}], LineBox[{1271, 317}], LineBox[{1272, 318}], 
            LineBox[{1273, 319}], LineBox[{1274, 320}], LineBox[{1275, 321}], 
            LineBox[{1278, 324}], LineBox[{1279, 325}], LineBox[{1280, 326}], 
            LineBox[{1283, 329}], LineBox[{1286, 332}], LineBox[{1287, 333}], 
            LineBox[{1288, 334}], LineBox[{1289, 335}], LineBox[{1291, 337}], 
            LineBox[{1293, 339}], LineBox[{1295, 341}], LineBox[{1300, 346}], 
            LineBox[{1304, 350}], LineBox[{1305, 351}], LineBox[{1307, 353}], 
            LineBox[{1310, 356}], LineBox[{1315, 361}], LineBox[{1316, 362}], 
            LineBox[{1317, 363}], LineBox[{1319, 365}], LineBox[{1322, 368}], 
            LineBox[{1325, 371}], LineBox[{1327, 373}], LineBox[{1329, 375}], 
            LineBox[{1330, 376}], LineBox[{1332, 378}], LineBox[{1333, 379}], 
            LineBox[{1334, 380}], LineBox[{1336, 382}], LineBox[{1337, 383}], 
            LineBox[{1338, 384}], LineBox[{1340, 386}], LineBox[{1341, 387}], 
            LineBox[{1344, 390}], LineBox[{1351, 397}], LineBox[{1354, 400}], 
            LineBox[{1356, 402}], LineBox[{1358, 404}], LineBox[{1359, 405}], 
            LineBox[{1360, 406}], LineBox[{1361, 407}], LineBox[{1362, 408}], 
            LineBox[{1366, 412}], LineBox[{1367, 413}], LineBox[{1368, 414}], 
            LineBox[{1369, 415}], LineBox[{1370, 416}], LineBox[{1373, 419}], 
            LineBox[{1376, 422}], LineBox[{1377, 423}], LineBox[{1378, 424}], 
            LineBox[{1380, 426}], LineBox[{1381, 427}], LineBox[{1383, 429}], 
            LineBox[{1384, 430}], LineBox[{1385, 431}], LineBox[{1387, 433}], 
            LineBox[{1388, 434}], LineBox[{1390, 436}], LineBox[{1396, 442}], 
            LineBox[{1397, 443}], LineBox[{1398, 444}], LineBox[{1399, 445}], 
            LineBox[{1404, 450}], LineBox[{1406, 452}], LineBox[{1407, 453}], 
            LineBox[{1408, 454}], LineBox[{1409, 455}], LineBox[{1410, 456}], 
            LineBox[{1413, 459}], LineBox[{1416, 462}], LineBox[{1417, 463}], 
            LineBox[{1419, 465}], LineBox[{1420, 466}], LineBox[{1421, 467}], 
            LineBox[{1422, 468}], LineBox[{1424, 470}], LineBox[{1427, 473}], 
            LineBox[{1431, 477}], LineBox[{1435, 481}], LineBox[{1437, 483}], 
            LineBox[{1439, 485}], LineBox[{1440, 486}], LineBox[{1441, 487}], 
            LineBox[{1443, 489}], LineBox[{1444, 490}], LineBox[{1448, 494}], 
            LineBox[{1449, 495}], LineBox[{1451, 497}], LineBox[{1454, 500}], 
            LineBox[{1455, 501}], LineBox[{1456, 502}], LineBox[{1461, 507}], 
            LineBox[{1463, 509}], LineBox[{1468, 514}], LineBox[{1469, 515}], 
            LineBox[{1471, 517}], LineBox[{1474, 520}], LineBox[{1478, 524}], 
            LineBox[{1479, 525}], LineBox[{1480, 526}], LineBox[{1481, 527}], 
            LineBox[{1483, 529}], LineBox[{1484, 530}], LineBox[{1485, 531}], 
            LineBox[{1488, 534}], LineBox[{1490, 536}], LineBox[{1495, 541}], 
            LineBox[{1500, 546}], LineBox[{1503, 549}], LineBox[{1505, 551}], 
            LineBox[{1506, 552}], LineBox[{1507, 553}], LineBox[{1508, 554}], 
            LineBox[{1509, 555}], LineBox[{1510, 556}], LineBox[{1511, 557}], 
            LineBox[{1517, 563}], LineBox[{1519, 565}], LineBox[{1520, 566}], 
            LineBox[{1522, 568}], LineBox[{1525, 571}], LineBox[{1526, 572}], 
            LineBox[{1527, 573}], LineBox[{1530, 576}], LineBox[{1531, 577}], 
            LineBox[{1532, 578}], LineBox[{1533, 579}], LineBox[{1538, 584}], 
            LineBox[{1541, 587}], LineBox[{1542, 588}], LineBox[{1543, 589}], 
            LineBox[{1545, 591}], LineBox[{1546, 592}], LineBox[{1548, 594}], 
            LineBox[{1549, 595}], LineBox[{1553, 599}], LineBox[{1556, 602}], 
            LineBox[{1560, 606}], LineBox[{1561, 607}], LineBox[{1563, 609}], 
            LineBox[{1564, 610}], LineBox[{1569, 615}], LineBox[{1570, 616}], 
            LineBox[{1571, 617}], LineBox[{1573, 619}], LineBox[{1574, 620}], 
            LineBox[{1576, 622}], LineBox[{1578, 624}], LineBox[{1583, 629}], 
            LineBox[{1585, 631}], LineBox[{1586, 632}], LineBox[{1587, 633}], 
            LineBox[{1590, 636}], LineBox[{1591, 637}], LineBox[{1597, 643}], 
            LineBox[{1598, 644}], LineBox[{1599, 645}], LineBox[{1600, 646}], 
            LineBox[{1605, 651}], LineBox[{1606, 652}], LineBox[{1608, 654}], 
            LineBox[{1610, 656}], LineBox[{1612, 658}], LineBox[{1613, 659}], 
            LineBox[{1614, 660}], LineBox[{1615, 661}], LineBox[{1616, 662}], 
            LineBox[{1617, 663}], LineBox[{1618, 664}], LineBox[{1620, 666}], 
            LineBox[{1621, 667}], LineBox[{1622, 668}], LineBox[{1623, 669}], 
            LineBox[{1624, 670}], LineBox[{1626, 672}], LineBox[{1630, 676}], 
            LineBox[{1633, 679}], LineBox[{1635, 681}], LineBox[{1639, 685}], 
            LineBox[{1640, 686}], LineBox[{1647, 693}], LineBox[{1649, 695}], 
            LineBox[{1650, 696}], LineBox[{1651, 697}], LineBox[{1652, 698}], 
            LineBox[{1653, 699}], LineBox[{1655, 701}], LineBox[{1656, 702}], 
            LineBox[{1657, 703}], LineBox[{1658, 704}], LineBox[{1659, 705}], 
            LineBox[{1660, 706}], LineBox[{1663, 709}], LineBox[{1668, 714}], 
            LineBox[{1669, 715}], LineBox[{1671, 717}], LineBox[{1672, 718}], 
            LineBox[{1674, 720}], LineBox[{1678, 724}], LineBox[{1681, 727}], 
            LineBox[{1682, 728}], LineBox[{1685, 731}], LineBox[{1686, 732}], 
            LineBox[{1689, 735}], LineBox[{1690, 736}], LineBox[{1691, 737}], 
            LineBox[{1694, 740}], LineBox[{1696, 742}], LineBox[{1698, 744}], 
            LineBox[{1699, 745}], LineBox[{1700, 746}], LineBox[{1701, 747}], 
            LineBox[{1704, 750}], LineBox[{1706, 752}], LineBox[{1708, 754}], 
            LineBox[{1710, 756}], LineBox[{1711, 757}], LineBox[{1713, 759}], 
            LineBox[{1714, 760}], LineBox[{1715, 761}], LineBox[{1718, 764}], 
            LineBox[{1720, 766}], LineBox[{1721, 767}], LineBox[{1726, 772}], 
            LineBox[{1729, 775}], LineBox[{1734, 780}], LineBox[{1736, 782}], 
            LineBox[{1737, 783}], LineBox[{1739, 785}], LineBox[{1740, 786}], 
            LineBox[{1743, 789}], LineBox[{1744, 790}], LineBox[{1745, 791}], 
            LineBox[{1746, 792}], LineBox[{1747, 793}], LineBox[{1750, 796}], 
            LineBox[{1751, 797}], LineBox[{1754, 800}], LineBox[{1755, 801}], 
            LineBox[{1756, 802}], LineBox[{1757, 803}], LineBox[{1758, 804}], 
            LineBox[{1764, 810}], LineBox[{1766, 812}], LineBox[{1768, 814}], 
            LineBox[{1769, 815}], LineBox[{1771, 817}], LineBox[{1773, 819}], 
            LineBox[{1775, 821}], LineBox[{1778, 824}], LineBox[{1779, 825}], 
            LineBox[{1781, 827}], LineBox[{1783, 829}], LineBox[{1785, 831}], 
            LineBox[{1786, 832}], LineBox[{1787, 833}], LineBox[{1788, 834}], 
            LineBox[{1789, 835}], LineBox[{1790, 836}], LineBox[{1792, 838}], 
            LineBox[{1793, 839}], LineBox[{1795, 841}], LineBox[{1797, 843}], 
            LineBox[{1801, 847}], LineBox[{1804, 850}], LineBox[{1805, 851}], 
            LineBox[{1809, 855}], LineBox[{1815, 861}], LineBox[{1816, 862}], 
            LineBox[{1818, 864}], LineBox[{1821, 867}], LineBox[{1822, 868}], 
            LineBox[{1828, 874}], LineBox[{1830, 876}], LineBox[{1832, 878}], 
            LineBox[{1835, 881}], LineBox[{1836, 882}], LineBox[{1837, 883}], 
            LineBox[{1838, 884}], LineBox[{1839, 885}], LineBox[{1847, 893}], 
            LineBox[{1850, 896}], LineBox[{1851, 897}], LineBox[{1852, 898}], 
            LineBox[{1853, 899}], LineBox[{1854, 900}], LineBox[{1855, 901}], 
            LineBox[{1857, 903}], LineBox[{1861, 907}], LineBox[{1862, 908}], 
            LineBox[{1866, 912}], LineBox[{1867, 913}], LineBox[{1868, 914}], 
            LineBox[{1869, 915}], LineBox[{1872, 918}], LineBox[{1873, 919}], 
            LineBox[{1876, 922}], LineBox[{1877, 923}], LineBox[{1878, 924}], 
            LineBox[{1879, 925}], LineBox[{1881, 927}], LineBox[{1884, 930}], 
            LineBox[{1886, 932}], LineBox[{1887, 933}], LineBox[{1890, 936}], 
            LineBox[{1894, 940}], LineBox[{1895, 941}], LineBox[{1898, 944}], 
            LineBox[{1903, 949}], LineBox[{1905, 951}]}}, {{}, 
           {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
            0.0055000000000000005`], AbsoluteThickness[1.6], 
            PointBox[CompressedData["
1:eJwN02MDFQYAAMC3bNt2Ldu1ZdvL5pZt27Zt27Zt2959uJ9wiRu0rdjmj0Ag
sC1oINAxZCDQic50oSvd6E4PetKL3vShL/3ozwAGMojBDGEowxjOCEYyitGM
YSzjGM8EJjKJyUxhKtOYzgxmMovZzGEu85jPAhayiMUsYSnLWM4KVrKK1axh
LetYzwY2sonNbGEr29jODnayi93sYS/72M8BDnKIwxzhKMc4zglOcorTnOEs
5zjPBS5yictc4SrXuM4NbnKL29zhLve4zwMe8ojHPOEpz3jOC17yite84S3v
eM8HPvKJz3zhK9/4zg9+8ovfBEIFAn8QhKAEIzghCEkoQhOGsIQjPBGISCQi
E4WoRCM6MYhJLGITh7jEIz4JSEgiEpOEpCQjOSlISSpSk4a0pCM9GfiTjGQi
M1nISjayk4Oc5CI3echLPvJTgIIUojBFKMpf/E0xilOCkpSiNGUoSznKU4GK
VKIyVahKNapTg5rUojZ1qEs9/qE+DWhIIxrThKY0ozktaEkrWtOGtrSjPR34
l//oSCc604WudKM7PehJL3rTh770oz8DGMggBjOEoQxjOCMYyShGM4axjGM8
E5jIJCYzhalMYzozmMksZjOHucxjPgtYyCIWs4SlLGM5K1jJKlazhrWsYz0b
2MgmNrOFrWxjOzvYyS52s4e97GM/BzjIIQ5zhKMc4zgnOMkpTnOGs5zjPBe4
yCUuc4WrXOM6N7jJLW5zh7vc4z4PeMgjHvOEpzzjOS94ySte84a3vOM9H/jI
Jz7zha984zs/+MkvfhMI7T9BCEowghOCkIQiNGEISzjCE4GIRCIyUYhKNKIT
g5jEIjZxiEs84pOAhCQiMUlISjKSk4KUpCI1aUhLOtKTgT/JSCYyk4WsZCM7
OchJLnKTh7zkIz8FKEghClOEovzF3xSjOCUoSSlKU4aylKM8FahIJSpThapU
ozo1qEktalOHutTjH+rTgIY0ojFNaEozmtOClrSiNW1oSzva04F/+Y+OdKIz
XehKN7rTg570ojd96Es/+jOAgQxiMEMYyjCGM4KRjGI0YxjLOMYzgYlMYjJT
mMo0pjODmcxiNnOYyzzms4CFLGIxS1jKMpazgpWsYjVrWMs61rOBjWxiM1vY
yja2s4Od7GI3e9jLPvZzgIMc4jBHOMoxjnOCk5ziNGc4yznOc4GLXOIyV7jK
Na5zg5vc4jZ3uMs97vOAhzziMU94yjOe84KXvOI1b3jLO97zgY984jNf+Mo3
vvODn/ziN4Ew/hOEoAQjOCEISShCE4awhCM8EYhIJCIThahEIzoxiEksYhOH
uMQjPglISCISk4SkJCM5KUhJKlKThrSkIz0Z+JOMZCIzWchKNrKTg5zkIjd5
yEs+8lOAghSiMEUoyl/8TTGKU4KSlKI0ZShLOcpTgYpUojJVqEo1qlODmtSi
NnWoSz3+oT4NaEgjGtOEpjSjOS1oSSta04a2tKM9HfiX/+hIJzrTha50ozs9
6EkvetOHvvSjPwMYyCAGM4ShDGM4IxjJKEYzhrGMYzwTmMgkJjOFqUxjOjOY
ySxmM4e5zGM+C1jIIhazhKUsYzkrWMkqVrOGtaxjPRvYyCY2s4WtbGM7O9jJ
Lnazh73sYz8HOMghDnOEoxzjOCc4ySlOc4aznOM8F7jIJS5zhatc4zo3uMkt
bnOHu9zjPg94yCMe84SnPOM5L3jJK17zhre84z0f+MgnPvOFr3zjOz/4yS9+
EwjrP0EISjCCE4KQhCI0YQhLOMITgYhEIjJRiEo0ohODmMQiNnGISzzik4CE
JCIxSUhKMpKTgpSkIjVpSEs60pOB/wFt6QsY
             
             "]]}, {}}}], {}, {}, {}, {}}, {{{}, {}, 
         TagBox[
          {RGBColor[1, 0.5, 0], AbsoluteThickness[1.6], Opacity[1.], 
           LineBox[CompressedData["
1:eJxTTMoPSmViYGAwAWIQXV5zePKB/C92lfeOvk6euME+y/HQh4v7lBxgfD2L
Yysv7DOC84V2nTZf3OEM58+xaeOtZfWF83Wdar5GaAbD+X6a3//cMYmA87cy
3a41eBUD56/zP3DajCkRzg/gb5TKaU6G80U9vql23kyF86uTzvyVSsqA81m+
hU2asj8Lzr9Vdf6FimAunB/4cAW31tR8OL80YXYp9/cCOF/44CTvPTZFcH64
VGNTRU0xwj8bTk5fsawEzr+8zUlY+FUpnM/9SzT3o3g5wrx1krpc8RVw/qEo
ET+9BZVwPpNLpu+x01UI9fPebZohUAPnbzM59+2efS2c///wktkGmXVwvsSR
1cv2rK6H85Ma2DzichrgfIXw8/nV/I1wvuEqYY956xH8bulW/t8uTXC+71E+
rq/PEPyI3qOfNeqaEe65+L03SagFzq/xc4q23Izgd7/cKe7l2Yrw315P9h+v
EfxD69ie3W9ug/OvydiXnpVoh/ODDvebR+xC8MU7eF/KBHbA+S6ti8/WfUHw
j/zbkvRsSiec3zvt87N2rS44f1+a17xjZxB8i9BzLvYp3XA+64Gzs/f+QPCt
kp+q3pzZA+fvUNGar2fQC+ebK1V6ibcg+NvkT3z9fx3BBwAeyb92
            "]]},
          Annotation[#, "Charting`Private`Tag$809293#1"]& ], 
         TagBox[
          {RGBColor[1, 0.5, 0], AbsoluteThickness[1.6], Opacity[1.], 
           LineBox[CompressedData["
1:eJxTTMoPSmViYGAwAWIQXV5zePKB/C92lfeOvk6euGF/luOhDxf3KTnA+HoW
x1Ze2GcE5wvtOm2+uMMZzp9j08Zby+oL5+s61XyN0AyG8/00v/+5YxIB529l
ul1r8CoGzl/nf+C0GVMinB/A3yiV05wM54t6fFPtvJkK51cnnfkrlZQB57N8
C5s0ZX8WnH+r6vwLFcFcOD/w4Qpuran5cH5pwuxS7u8FcL7wwUnee2yK4Pxw
qcamippihH82nJy+YlkJnH95m5Ow8KtSOJ/7l2juR/FyhHnrJHW54ivg/ENR
In56CyrhfCaXTN9jp6sQ6ue92zRDoAbO32Zy7ts9+1o4///hJbMNMuvgfIkj
q5ftWV0P5yc1sHnE5TTA+Qrh5/Or+RvhfMNVwh7z1iP43dKt/L9dmuB836N8
XF+fIfgRvUc/a9Q1I9xz8XtvklALnF/j5xRtuRnB7365U9zLsxXhv72e7D9e
I/iH1rE9u9/cBudfk7EvPSvRDucHHe43j9iF4It38L6UCeyA811aF5+t+4Lg
H/m3JenZlE44v3fa52ftWl1w/r40r3nHziD4FqHnXOxTuuF81gNnZ+/9geBb
JT9VvTmzB87foaI1X8+gF843V6r0Em9B8LfJn/j6/zqCDwCrMNl2
            "]]},
          Annotation[#, "Charting`Private`Tag$809293#2"]& ]}, {}, {}}},
      AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
      Axes->{True, True},
      AxesLabel->{None, None},
      AxesOrigin->{0, 0},
      DisplayFunction->Identity,
      Frame->{{True, True}, {True, True}},
      FrameLabel->{{
         FormBox["\"Partial Correlation\"", TraditionalForm], None}, {
         FormBox["\"Weeks\"", TraditionalForm], 
         FormBox["\"tempSC3\"", TraditionalForm]}},
      FrameStyle->Directive[18, 
        Thickness[Large]],
      FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
      GridLines->{None, None},
      GridLinesStyle->Directive[
        GrayLevel[0.5, 0.4]],
      ImagePadding->All,
      Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& ), "CopiedValueFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& )}},
      PlotRange->{{0, 954}, {-0.0981605898223175, 0.08339176613352928}},
      PlotRangeClipping->True,
      PlotRangePadding->{{0, 0}, {
         Scaled[0.05], 
         Scaled[0.05]}},
      Ticks->{Automatic, Automatic}], {580.5, -116.80842387373012}, 
     ImageScaled[{0.5, 0.5}], {360., 222.49223594996212}], InsetBox[
     GraphicsBox[{{}, GraphicsComplexBox[CompressedData["
1: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
yn8OKtedOeN9DP095iAlPr3nrjBvav85iEjrO/ZosC/V/xw83ah+PfH5TCr/
HJzYa1CsHUPjU5yD1BG3/zoQQuuRpfjvX6zc6n1EGj9eEH2nfEqqTPOlwgub
BvdfN+UHrS/wQnH4NqnIYzSV3wuNq0VG+/pL67kXbjyc9KzaAqo/Y/Hf3+nT
/uUPgfL3wrPl5Y8VpdL6YfHCQN8/+tm3l+KpuejWW1gTcXkv9b+5sG90N3Pb
OerfmIvxy5aaeo6k/NRzcSdnW9f2VaT5YS5u2jxe+qCm1P/n4kphaOPbc2j8
iHPxLrebgxhJ8YxlLj4cWxww7NIqav95aG//cuKXzVFU/nnY2remg+7KIMp/
Htr8KD8xyHUT5T8PMxZO3R5oT58nzIOPne+Ow+sp3jDOw5SW/nade9J4E+fh
od+3nr9u0POWeQht8ax9rzHJlL83poxc86HmQFpvFd74GTzJKe0X9Q9441yH
eW7Nb1N/V3sjfe8h76Zyafx5I2Lnl6Bjabuo/r3RrHl4p65NKd4UvWH9OkBz
oVEG5e8N2amz04Y1k+Lv+Vj1/uSX3Oe0/ijm49KP9FY/XGn9xXwkF656ccT1
EJV/PlokpHx/l0TxrzAfkVMHe3VsRPOXcT6C9iytPbAtxQfifLwbJ6958GcK
tf98FJw42Do+Vdpf+MC+T7vWLlc11P4+cMwO+nPOQqn9fXBg4763TRXTqfw+
CGj16l2lZGl+90GD9CjHe3qaz40+yL+0puC5fxzVvw8Shh9fVbUhxfsWHyz+
WvXjGONGKr8vAtq+37mkFeWn8MVOyKMs+Sup/n1xYXbloLGnqH3UxRblThn5
f9L498XvnSeTnjySyu+L6hunnhvpRuUTffG21vOYRrG0f7L44lfBljv9e0jx
kx/G3W/b4d1vGm8KPzRJdK700ZPS4YdeL0d4OjSMp/z9kHcw/sS181J854d5
h33brP6D2s/ohwN1Dtat2ZnmJ9EPLT7tuqILpPXA4gcHx2+NH5ik+G8Blib/
6b5pgrT+LMDdXX07nkzXU/0vwJxGP1rbXqH4Rb0AnqadS1OiqT8JxelnV++/
o0il8i/A7enpnRyvUn2LC+BSZ4QxIprWQ8sCaE9sO2Y3QNof+sMwzz2iWhTt
1xT+eH620vxjVyZT/v64H/PcZ+4Vmg/V/nCOHe/d5z7Nz4I/Zg58OWP8dmn8
+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
TqL525QEuamfSzktjaecJBye8W759L2Un5iEl3McnjTqTucHuUmY3C7eOfEN
tZ85Cf3aV+nzLI3Gb15xfkOjJ2047UbjPwmG/ZVDGsZR/8pPwt2Ep9cayqX9
ThI8B8/avUek9ixMwsz0DNkNFyqPTIf4/duM2pq0PtvosO+x3unPKtJ5sA7+
EYNHL82g8trqYHJt2nWM19yS5xU6jN5So5NdU+o/9jo0mhb+39aPVP9KHc5f
+rFv36cx1P46dDm764lqO62f0OG5/ry41I7WM2cd9v6sEO/6jX7Po9Jhg/NM
J0yX4j8dYivmDrvameZTdXG6/t2517EUT3nrkNPec/GSi9QfNTq0vnTOb9dh
qh+tDpY6Gy4LwTQeBB1eNLz7VLeX9rt6HTwe2A3b406fZ9DBz84rOy2e8s/S
IXGpLMz0jtYzow7j9+2PyFlA81e2DkMmLe9X8QGtxyYdAmb+rFDuAdVPjg57
KtV3yV9P40/UoZWx5ZBpPyh+zdXhbGvr7coV6H3MxeWrdWln57f0/nk6fCty
b+ezQzrf1mGa14lmW4sofsjXwfi7T/a/76n+rTpM6IcLhZVo/i7U4VA5218T
YqTv/5OxLbz24GotpfGfjJs3Pj27/4s+X56MY7azHobHU3xpm4xm/9vYeaXX
fGr/5OL45ERNdQKtH/bJaOenyd3kKLV/Mm437blvlgfNp07JUOoyVnV1ln7f
koyPHS7G/H5C+0HnZGSd7bUiZDTVryoZlzbMHHmyBe03XJIx+catD5+GUfyr
TobdpgUz5QW9qf2T0V0+/Ni4obS+aZIhXvD8sd9A+1ttMk71NP81dpcnrf/J
OHD0ZPe9d+n3RfpkZLfOelPQjva7hmQErXdybbCD9m9ZyVhyt9bJk80onjAm
o4NdUeNHIsXX2cnwsx4qN0xL/deUjNPdbDa8GDyA1v9kPFz28cL5q3T+JxaX
t+H6u2OruND8n4zx9b896GSQ4v9kfJr20MOpFe2n85LhuGBQ2x0qaX+XjEHy
Ow8SetH6m5+MZTu7Xsvwkub/ZMS45U3s0oXGQ2EyUt+tjH3mRuuFLAXWopvn
6jel/Z1NChaef9uhqCmVV56C9XZzyg89tpDaPwUzztTc3eqedD6YgmEz6/Z3
DqH51T4FXWpPiX41kr7/VKbAw82z6VCfYGr/FEz+d8KmhOEULyEFX7ptfBVh
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
PwPm4U8ezvlC329oMlA4KcTO7yiVR5uBRrvsDtiupf2LkIF1i5PNhr30+y99
BgZlXq31detgav8M/DvRq1bwV9ofZGVgbaDT+YQUWj+MGXiz7lVUhVj6/OwM
PDl+LK1udYo/TBlY3qRLjdZtKH7PycCpPxrEflN7UPtn4EyXJUPDM+nf4+Vm
YGb024FvD9C/nzFnIO55pwNdF0+l8Z+BDF3EGoua9ueWDOTGVnZ6fKRBifMz
8H7p3OZTcqk/WjNw3qgdVWMp1X9hBjTrIs+uDpP+PWUm8oJt/lr5ZDiN/0wM
fRbvHGdL8bs8E2/OvdSvDpfO/zPR8fVVVfBGSldk4sD7ff/oh9N5hn0mzjRd
GWSbKM3/mWgit2+WnEnrm1Mm5rQ60uOoJ41XZOLS8tt9c81qGv+ZqNB3vH3q
Win+z4R7desj20E0nlwy8deFWzH21d2p/TORXHPXoMxd02n8ZyLh8wmvC43p
9xSaTNiNCjHXbSvF/5mIXVtxifdxShcyYVaeOvhxKcUr+kw0z1/UQHOTfm9l
yISyzThxyFl6n6xMyHesqqHbT/VnzER7j7QKQ1fT9wPZmRgcFBr57rr0e8VM
jEkvFz6xnx+N/0yEVX9yIc2e5gMxExOC0pP+Kk/tnZuJk3N9Wl7bTOuBORPB
QfPsK6iov8qsJe30f/9Dadowy5nrM9syN2NWMLdibsPcjtmeuSNzJ2ZHZiVz
F+auzN2YuzP3YO7J3IvZibk3cx/mvsz9mPszD2AeyIzSFphlg1g6s2wwS2eW
DWHpzLKhLJ1ZNoylM8uGs3Rm2QiWzixzZunMspEsnVk2iqUzy0azdGbZGJbO
LBvL0pll41g6s2w8S2eWqUobzAKzyCybwJ5nFphFZtlE9jyzwCwyyyax55kF
ZpFZNpk9zywwi8yyKex5ZoFZZJZNZc8zC8wis2wae55ZYBaZZS7seWaBWWSW
ubLnmQVmkVk2nT3PLDCLzDI39jyzwCwyy2aw55kFZpFZ5s6eZxaYRWbZTPY8
s8AsMstmseeZBWaRWaYubQUzmNXMArORWWS2MMs8WP7MYFYzC8xGZpHZwizz
ZPkzg1nNLDAbmUVmC7NsNsufGcxqZoHZyCwyW5hlc1j+zGBWMwvMRmaR2cIs
82L5M4NZzSwwG5lFZguzbC7LnxnMamaB2cgsMluYZfNY/sxgVjMLzEZmkdnC
LPNm+TODWc0sMBuZRWYLs2w+y58ZzGpmgdnILDJbmGU+LH9mMKuZBWYjs8hs
YZb5svyZwaxmFpiNzCKzhVnmx/JnBrOaWWA2MovMFmbZApY/M5jVzAKzkVlk
tjDL/Fn+zGBWMwvMRmaR2cIsC2D5M4NZzSwwG5lFZguzTFPacmYFs5IZzCpm
NbOGWWA2MBuZTcwis5nZwmxllgWWtpxZwaxkBrOKWc2sYRaYDcxGZhOzyGxm
tjBbmWVBpS1nVjArmcGsYlYza5gFZgOzkdnELDKbmS3MVmZZcGnLmRXMSmYw
q5jVzBpmgdnAbGQ2MYvMZmYLs5VZFlLacmYFs5IZzCpmNbOGWWA2MBuZTcwi
s5nZwmxlloWWtpxZwaxkBrOKWc2sYRaYDcxGZhOzyGxmtjBbmWVhpS1nVjAr
mcGsYlYza5gFZgOzkdnELDKbmS3MVmZZeGnLmRXMSmYwq5jVzBpmgdnAbGQ2
MYvMZmYLs5VZpi1tObOCWckMZhWzmlnDLDAbmI3MJmaR2cxsYbYyyyJKW86s
YFYyg1nFrGbWMAvMBmYjs4lZZDYzW5itzLLI0pYzK5iVzGBWMauZNcwCs4HZ
yGxiFpnNzBZmK7MsqrTlzApmJTOYVcxqZg2zwGxgNjKbmEVmM7OF2cosiy5t
ObOCWckMZhWzmlnDLDAbmI3MJmaR2cxsYbYyy2JKW86sYFYyg1nFrGbWMAvM
BmYjs4lZZDYzW5itzLLY0pYzK5iVzGBWMauZNcwCs4HZyGxiFpnNzBZmK7Ms
rrTlzApmJTOYVcxqZg2zwGxgNjKbmEVmM7OF2cosE0rbhlnObMusYLZnVjI7
MYPZmVnF7MKsZvZm1jBrmQVmPbOBOYvZyJzNbGLOYRaZc5nNzHnMFuZ8Zitz
IbMsvrRtmOXMtswKZntmJbMTM5idmVXMLsxqZm9mDbOWWWDWMxuYs5iNzNnM
JuYcZpE5l9nMnMdsYc5ntjIXMssSStuGWc5sy6xgtmdWMjsxg9mZWcXswqxm
9mbWMGuZBWY9s4E5i9nInM1sYs5hFplzmc3MecwW5nxmK3MhsyyxtG2Y5cy2
zApme2YlsxMzmJ2ZVcwuzGpmb2YNs5ZZYNYzG5izmI3M2cwm5hxmkTmX2cyc
x2xhzme2Mhcyy5JK24ZZzmzLrGC2Z1YyOzGD2ZlZxezCrGb2ZtYwa5kFZj2z
gTmL2ciczWxizmEWmXOZzcx5zBbmfGYrcyGzTFfaNsxyZltmBbM9s5LZiRnM
zswqZhdmNbM3s4ZZyyww65kNzFnMRuZsZhNzDrPInMtsZs5jtjDnM1uZC5ll
yaVtwyxntmVWMNszK5mdmMHszKxidmFWM3sza5i1zAKzntnAnMVsZM5mNjHn
MIvMucxm5jxmC3M+s5W5kFmWUto2zHJmW2YFsz2zktmJGczOzCpmF2Y1szez
hlnLLDDrmQ3MWcxG5mxmE3MOs8icy2xmzmO2MOczW5kLmWX60rZhljPbMiuY
7ZmVzE7MYHZmVjG7MKuZvZk1zFpmgVnPbGDOYjYyZzObmHOYReZcZjNzHrOF
OZ/ZylzILEstbRtmObMts4LZnlnJ7MQMZmdmFbMLs5rZm1nDrGUWmPXMBuYs
ZiNzNrOJOYdZZM5lNjPnMVuY85mtzIXMsrTStmGWM9syK5jtmZXMTsxgdmZW
Mbswq5m9mTXMWmaBWc9sYM5iNjJnM5uYc5hF5lxmM3Mes4U5n9nKXMgsSy9t
G2Y5sy2zgtmeWcnsxAxmZ2YVswuzmtmbWcOsZRaY9cwG5ixmI3M2s4k5h1lk
zmU2M+cxW5jzma3MhcyyjNK2YZYz2zIrmO2ZlcxOzGB2ZlYxuzCrmb2ZNcxa
ZoFZz2xgzmI2Mmczm5hzmEXmXGYzcx6zhTmf2cpcyCzLLG0bZjmzLbOC2Z5Z
yezEDGZnZhWzC7Oa2ZtZw6xlFpj1zAbmLGYjczaziTmHWWTOZTYzl92fW3Z/
btn9uWX355bdn0v1XXZ/btn9uWX355bdn1t2f25J/mX355bdn1t2f27Z/bll
9+eW5F92f27Z/bll9+eW3Z9bdn9uSfnL7s8tuz+37P7csvtzy+7PLSl/2f25
Zffnlt2fW3Z/btn9uSXlL7s/t+z+3LL7c8vuzy27P7ek/cvuzy27P7fs/tyy
+3PL7s8taf+y+3PL7s8tuz+37P7csvtzS9q/7P7csvtzy+7PLbs/t+z+3JL2
L7s/t+z+3LL7c8vuzy27P7ek/cvuzy27P7fs/tz/F+7P/T8wOM6h
        "], {{{}, {}, {}, 
          {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
           LineBox[{956, 2}], LineBox[{958, 4}], LineBox[{964, 10}], 
           LineBox[{965, 11}], LineBox[{966, 12}], LineBox[{967, 13}], 
           LineBox[{968, 14}], LineBox[{969, 15}], LineBox[{972, 18}], 
           LineBox[{974, 20}], LineBox[{977, 23}], LineBox[{979, 25}], 
           LineBox[{981, 27}], LineBox[{982, 28}], LineBox[{983, 29}], 
           LineBox[{986, 32}], LineBox[{987, 33}], LineBox[{988, 34}], 
           LineBox[{989, 35}], LineBox[{990, 36}], LineBox[{991, 37}], 
           LineBox[{993, 39}], LineBox[{994, 40}], LineBox[{995, 41}], 
           LineBox[{998, 44}], LineBox[{999, 45}], LineBox[{1000, 46}], 
           LineBox[{1001, 47}], LineBox[{1004, 50}], LineBox[{1005, 51}], 
           LineBox[{1007, 53}], LineBox[{1009, 55}], LineBox[{1011, 57}], 
           LineBox[{1012, 58}], LineBox[{1015, 61}], LineBox[{1017, 63}], 
           LineBox[{1018, 64}], LineBox[{1025, 71}], LineBox[{1030, 76}], 
           LineBox[{1032, 78}], LineBox[{1033, 79}], LineBox[{1034, 80}], 
           LineBox[{1035, 81}], LineBox[{1041, 87}], LineBox[{1042, 88}], 
           LineBox[{1049, 95}], LineBox[{1054, 100}], LineBox[{1055, 101}], 
           LineBox[{1056, 102}], LineBox[{1057, 103}], LineBox[{1060, 106}], 
           LineBox[{1061, 107}], LineBox[{1063, 109}], LineBox[{1064, 110}], 
           LineBox[{1065, 111}], LineBox[{1066, 112}], LineBox[{1067, 113}], 
           LineBox[{1070, 116}], LineBox[{1071, 117}], LineBox[{1073, 119}], 
           LineBox[{1074, 120}], LineBox[{1075, 121}], LineBox[{1076, 122}], 
           LineBox[{1077, 123}], LineBox[{1078, 124}], LineBox[{1079, 125}], 
           LineBox[{1081, 127}], LineBox[{1082, 128}], LineBox[{1083, 129}], 
           LineBox[{1084, 130}], LineBox[{1085, 131}], LineBox[{1086, 132}], 
           LineBox[{1088, 134}], LineBox[{1090, 136}], LineBox[{1091, 137}], 
           LineBox[{1093, 139}], LineBox[{1094, 140}], LineBox[{1095, 141}], 
           LineBox[{1105, 151}], LineBox[{1110, 156}], LineBox[{1111, 157}], 
           LineBox[{1116, 162}], LineBox[{1117, 163}], LineBox[{1119, 165}], 
           LineBox[{1120, 166}], LineBox[{1125, 171}], LineBox[{1127, 173}], 
           LineBox[{1130, 176}], LineBox[{1131, 177}], LineBox[{1132, 178}], 
           LineBox[{1133, 179}], LineBox[{1134, 180}], LineBox[{1135, 181}], 
           LineBox[{1136, 182}], LineBox[{1137, 183}], LineBox[{1139, 185}], 
           LineBox[{1140, 186}], LineBox[{1141, 187}], LineBox[{1142, 188}], 
           LineBox[{1143, 189}], LineBox[{1144, 190}], LineBox[{1145, 191}], 
           LineBox[{1149, 195}], LineBox[{1152, 198}], LineBox[{1153, 199}], 
           LineBox[{1155, 201}], LineBox[{1156, 202}], LineBox[{1157, 203}], 
           LineBox[{1158, 204}], LineBox[{1162, 208}], LineBox[{1163, 209}], 
           LineBox[{1165, 211}], LineBox[{1166, 212}], LineBox[{1167, 213}], 
           LineBox[{1168, 214}], LineBox[{1169, 215}], LineBox[{1170, 216}], 
           LineBox[{1174, 220}], LineBox[{1176, 222}], LineBox[{1185, 231}], 
           LineBox[{1186, 232}], LineBox[{1187, 233}], LineBox[{1189, 235}], 
           LineBox[{1190, 236}], LineBox[{1191, 237}], LineBox[{1192, 238}], 
           LineBox[{1193, 239}], LineBox[{1195, 241}], LineBox[{1198, 244}], 
           LineBox[{1200, 246}], LineBox[{1208, 254}], LineBox[{1209, 255}], 
           LineBox[{1210, 256}], LineBox[{1211, 257}], LineBox[{1213, 259}], 
           LineBox[{1214, 260}], LineBox[{1215, 261}], LineBox[{1218, 264}], 
           LineBox[{1219, 265}], LineBox[{1221, 267}], LineBox[{1223, 269}], 
           LineBox[{1224, 270}], LineBox[{1225, 271}], LineBox[{1226, 272}], 
           LineBox[{1227, 273}], LineBox[{1228, 274}], LineBox[{1229, 275}], 
           LineBox[{1230, 276}], LineBox[{1231, 277}], LineBox[{1232, 278}], 
           LineBox[{1233, 279}], LineBox[{1234, 280}], LineBox[{1235, 281}], 
           LineBox[{1236, 282}], LineBox[{1237, 283}], LineBox[{1238, 284}], 
           LineBox[{1252, 298}], LineBox[{1255, 301}], LineBox[{1258, 304}], 
           LineBox[{1263, 309}], LineBox[{1264, 310}], LineBox[{1267, 313}], 
           LineBox[{1270, 316}], LineBox[{1275, 321}], LineBox[{1276, 322}], 
           LineBox[{1277, 323}], LineBox[{1281, 327}], LineBox[{1282, 328}], 
           LineBox[{1283, 329}], LineBox[{1284, 330}], LineBox[{1285, 331}], 
           LineBox[{1291, 337}], LineBox[{1294, 340}], LineBox[{1296, 342}], 
           LineBox[{1297, 343}], LineBox[{1298, 344}], LineBox[{1299, 345}], 
           LineBox[{1300, 346}], LineBox[{1301, 347}], LineBox[{1302, 348}], 
           LineBox[{1303, 349}], LineBox[{1304, 350}], LineBox[{1306, 352}], 
           LineBox[{1309, 355}], LineBox[{1310, 356}], LineBox[{1311, 357}], 
           LineBox[{1312, 358}], LineBox[{1313, 359}], LineBox[{1318, 364}], 
           LineBox[{1321, 367}], LineBox[{1323, 369}], LineBox[{1324, 370}], 
           LineBox[{1326, 372}], LineBox[{1328, 374}], LineBox[{1329, 375}], 
           LineBox[{1333, 379}], LineBox[{1345, 391}], LineBox[{1349, 395}], 
           LineBox[{1350, 396}], LineBox[{1352, 398}], LineBox[{1353, 399}], 
           LineBox[{1354, 400}], LineBox[{1358, 404}], LineBox[{1362, 408}], 
           LineBox[{1363, 409}], LineBox[{1364, 410}], LineBox[{1366, 412}], 
           LineBox[{1367, 413}], LineBox[{1369, 415}], LineBox[{1371, 417}], 
           LineBox[{1372, 418}], LineBox[{1374, 420}], LineBox[{1375, 421}], 
           LineBox[{1378, 424}], LineBox[{1380, 426}], LineBox[{1381, 427}], 
           LineBox[{1382, 428}], LineBox[{1383, 429}], LineBox[{1385, 431}], 
           LineBox[{1386, 432}], LineBox[{1387, 433}], LineBox[{1388, 434}], 
           LineBox[{1389, 435}], LineBox[{1391, 437}], LineBox[{1392, 438}], 
           LineBox[{1393, 439}], LineBox[{1394, 440}], LineBox[{1395, 441}], 
           LineBox[{1396, 442}], LineBox[{1398, 444}], LineBox[{1402, 448}], 
           LineBox[{1403, 449}], LineBox[{1405, 451}], LineBox[{1411, 457}], 
           LineBox[{1412, 458}], LineBox[{1417, 463}], LineBox[{1418, 464}], 
           LineBox[{1422, 468}], LineBox[{1425, 471}], LineBox[{1426, 472}], 
           LineBox[{1427, 473}], LineBox[{1428, 474}], LineBox[{1429, 475}], 
           LineBox[{1430, 476}], LineBox[{1431, 477}], LineBox[{1432, 478}], 
           LineBox[{1433, 479}], LineBox[{1434, 480}], LineBox[{1438, 484}], 
           LineBox[{1442, 488}], LineBox[{1444, 490}], LineBox[{1445, 491}], 
           LineBox[{1447, 493}], LineBox[{1449, 495}], LineBox[{1451, 497}], 
           LineBox[{1453, 499}], LineBox[{1454, 500}], LineBox[{1455, 501}], 
           LineBox[{1456, 502}], LineBox[{1459, 505}], LineBox[{1460, 506}], 
           LineBox[{1461, 507}], LineBox[{1462, 508}], LineBox[{1464, 510}], 
           LineBox[{1466, 512}], LineBox[{1468, 514}], LineBox[{1471, 517}], 
           LineBox[{1472, 518}], LineBox[{1473, 519}], LineBox[{1475, 521}], 
           LineBox[{1476, 522}], LineBox[{1477, 523}], LineBox[{1478, 524}], 
           LineBox[{1481, 527}], LineBox[{1482, 528}], LineBox[{1486, 532}], 
           LineBox[{1487, 533}], LineBox[{1489, 535}], LineBox[{1492, 538}], 
           LineBox[{1493, 539}], LineBox[{1494, 540}], LineBox[{1495, 541}], 
           LineBox[{1496, 542}], LineBox[{1497, 543}], LineBox[{1498, 544}], 
           LineBox[{1500, 546}], LineBox[{1503, 549}], LineBox[{1506, 552}], 
           LineBox[{1508, 554}], LineBox[{1513, 559}], LineBox[{1515, 561}], 
           LineBox[{1516, 562}], LineBox[{1519, 565}], LineBox[{1520, 566}], 
           LineBox[{1521, 567}], LineBox[{1524, 570}], LineBox[{1525, 571}], 
           LineBox[{1527, 573}], LineBox[{1528, 574}], LineBox[{1529, 575}], 
           LineBox[{1530, 576}], LineBox[{1532, 578}], LineBox[{1535, 581}], 
           LineBox[{1536, 582}], LineBox[{1537, 583}], LineBox[{1541, 587}], 
           LineBox[{1543, 589}], LineBox[{1544, 590}], LineBox[{1546, 592}], 
           LineBox[{1547, 593}], LineBox[{1549, 595}], LineBox[{1550, 596}], 
           LineBox[{1552, 598}], LineBox[{1559, 605}], LineBox[{1560, 606}], 
           LineBox[{1566, 612}], LineBox[{1567, 613}], LineBox[{1572, 618}], 
           LineBox[{1575, 621}], LineBox[{1577, 623}], LineBox[{1578, 624}], 
           LineBox[{1580, 626}], LineBox[{1582, 628}], LineBox[{1587, 633}], 
           LineBox[{1588, 634}], LineBox[{1589, 635}], LineBox[{1590, 636}], 
           LineBox[{1591, 637}], LineBox[{1592, 638}], LineBox[{1598, 644}], 
           LineBox[{1601, 647}], LineBox[{1602, 648}], LineBox[{1603, 649}], 
           LineBox[{1608, 654}], LineBox[{1609, 655}], LineBox[{1610, 656}], 
           LineBox[{1611, 657}], LineBox[{1612, 658}], LineBox[{1617, 663}], 
           LineBox[{1618, 664}], LineBox[{1619, 665}], LineBox[{1620, 666}], 
           LineBox[{1625, 671}], LineBox[{1629, 675}], LineBox[{1634, 680}], 
           LineBox[{1636, 682}], LineBox[{1637, 683}], LineBox[{1638, 684}], 
           LineBox[{1639, 685}], LineBox[{1641, 687}], LineBox[{1642, 688}], 
           LineBox[{1643, 689}], LineBox[{1644, 690}], LineBox[{1645, 691}], 
           LineBox[{1650, 696}], LineBox[{1651, 697}], LineBox[{1657, 703}], 
           LineBox[{1660, 706}], LineBox[{1661, 707}], LineBox[{1667, 713}], 
           LineBox[{1669, 715}], LineBox[{1670, 716}], LineBox[{1672, 718}], 
           LineBox[{1676, 722}], LineBox[{1677, 723}], LineBox[{1678, 724}], 
           LineBox[{1680, 726}], LineBox[{1686, 732}], LineBox[{1687, 733}], 
           LineBox[{1688, 734}], LineBox[{1689, 735}], LineBox[{1690, 736}], 
           LineBox[{1691, 737}], LineBox[{1692, 738}], LineBox[{1693, 739}], 
           LineBox[{1694, 740}], LineBox[{1695, 741}], LineBox[{1697, 743}], 
           LineBox[{1698, 744}], LineBox[{1699, 745}], LineBox[{1703, 749}], 
           LineBox[{1704, 750}], LineBox[{1705, 751}], LineBox[{1706, 752}], 
           LineBox[{1707, 753}], LineBox[{1709, 755}], LineBox[{1710, 756}], 
           LineBox[{1713, 759}], LineBox[{1714, 760}], LineBox[{1716, 762}], 
           LineBox[{1717, 763}], LineBox[{1719, 765}], LineBox[{1720, 766}], 
           LineBox[{1721, 767}], LineBox[{1724, 770}], LineBox[{1725, 771}], 
           LineBox[{1727, 773}], LineBox[{1728, 774}], LineBox[{1729, 775}], 
           LineBox[{1730, 776}], LineBox[{1734, 780}], LineBox[{1735, 781}], 
           LineBox[{1740, 786}], LineBox[{1741, 787}], LineBox[{1743, 789}], 
           LineBox[{1744, 790}], LineBox[{1746, 792}], LineBox[{1747, 793}], 
           LineBox[{1748, 794}], LineBox[{1749, 795}], LineBox[{1750, 796}], 
           LineBox[{1752, 798}], LineBox[{1753, 799}], LineBox[{1756, 802}], 
           LineBox[{1759, 805}], LineBox[{1762, 808}], LineBox[{1765, 811}], 
           LineBox[{1766, 812}], LineBox[{1771, 817}], LineBox[{1772, 818}], 
           LineBox[{1777, 823}], LineBox[{1778, 824}], LineBox[{1780, 826}], 
           LineBox[{1781, 827}], LineBox[{1782, 828}], LineBox[{1783, 829}], 
           LineBox[{1784, 830}], LineBox[{1785, 831}], LineBox[{1786, 832}], 
           LineBox[{1787, 833}], LineBox[{1790, 836}], LineBox[{1791, 837}], 
           LineBox[{1792, 838}], LineBox[{1793, 839}], LineBox[{1794, 840}], 
           LineBox[{1795, 841}], LineBox[{1796, 842}], LineBox[{1797, 843}], 
           LineBox[{1799, 845}], LineBox[{1800, 846}], LineBox[{1801, 847}], 
           LineBox[{1802, 848}], LineBox[{1808, 854}], LineBox[{1809, 855}], 
           LineBox[{1810, 856}], LineBox[{1811, 857}], LineBox[{1812, 858}], 
           LineBox[{1814, 860}], LineBox[{1815, 861}], LineBox[{1817, 863}], 
           LineBox[{1819, 865}], LineBox[{1826, 872}], LineBox[{1830, 876}], 
           LineBox[{1831, 877}], LineBox[{1832, 878}], LineBox[{1833, 879}], 
           LineBox[{1834, 880}], LineBox[{1835, 881}], LineBox[{1839, 885}], 
           LineBox[{1840, 886}], LineBox[{1845, 891}], LineBox[{1846, 892}], 
           LineBox[{1848, 894}], LineBox[{1849, 895}], LineBox[{1850, 896}], 
           LineBox[{1851, 897}], LineBox[{1854, 900}], LineBox[{1855, 901}], 
           LineBox[{1856, 902}], LineBox[{1861, 907}], LineBox[{1864, 910}], 
           LineBox[{1865, 911}], LineBox[{1866, 912}], LineBox[{1867, 913}], 
           LineBox[{1870, 916}], LineBox[{1871, 917}], LineBox[{1875, 921}], 
           LineBox[{1876, 922}], LineBox[{1880, 926}], LineBox[{1881, 927}], 
           LineBox[{1883, 929}], LineBox[{1884, 930}], LineBox[{1885, 931}], 
           LineBox[{1886, 932}], LineBox[{1887, 933}], LineBox[{1888, 934}], 
           LineBox[{1889, 935}], LineBox[{1890, 936}], LineBox[{1891, 937}], 
           LineBox[{1892, 938}], LineBox[{1893, 939}], LineBox[{1894, 940}], 
           LineBox[{1895, 941}], LineBox[{1896, 942}], LineBox[{1897, 943}], 
           LineBox[{1898, 944}], LineBox[{1899, 945}], LineBox[{1900, 946}], 
           LineBox[{1901, 947}], LineBox[{1902, 948}], LineBox[{1903, 949}], 
           LineBox[{1904, 950}], LineBox[{1905, 951}], LineBox[{1906, 952}], 
           LineBox[{1907, 953}], LineBox[{1908, 954}]}, 
          {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
           LineBox[{955, 1}], LineBox[{957, 3}], LineBox[{959, 5}], 
           LineBox[{960, 6}], LineBox[{961, 7}], LineBox[{962, 8}], 
           LineBox[{963, 9}], LineBox[{970, 16}], LineBox[{971, 17}], 
           LineBox[{973, 19}], LineBox[{975, 21}], LineBox[{976, 22}], 
           LineBox[{978, 24}], LineBox[{980, 26}], LineBox[{984, 30}], 
           LineBox[{985, 31}], LineBox[{992, 38}], LineBox[{996, 42}], 
           LineBox[{997, 43}], LineBox[{1002, 48}], LineBox[{1003, 49}], 
           LineBox[{1006, 52}], LineBox[{1008, 54}], LineBox[{1010, 56}], 
           LineBox[{1013, 59}], LineBox[{1014, 60}], LineBox[{1016, 62}], 
           LineBox[{1019, 65}], LineBox[{1020, 66}], LineBox[{1021, 67}], 
           LineBox[{1022, 68}], LineBox[{1023, 69}], LineBox[{1024, 70}], 
           LineBox[{1026, 72}], LineBox[{1027, 73}], LineBox[{1028, 74}], 
           LineBox[{1029, 75}], LineBox[{1031, 77}], LineBox[{1036, 82}], 
           LineBox[{1037, 83}], LineBox[{1038, 84}], LineBox[{1039, 85}], 
           LineBox[{1040, 86}], LineBox[{1043, 89}], LineBox[{1044, 90}], 
           LineBox[{1045, 91}], LineBox[{1046, 92}], LineBox[{1047, 93}], 
           LineBox[{1048, 94}], LineBox[{1050, 96}], LineBox[{1051, 97}], 
           LineBox[{1052, 98}], LineBox[{1053, 99}], LineBox[{1058, 104}], 
           LineBox[{1059, 105}], LineBox[{1062, 108}], LineBox[{1068, 114}], 
           LineBox[{1069, 115}], LineBox[{1072, 118}], LineBox[{1080, 126}], 
           LineBox[{1087, 133}], LineBox[{1089, 135}], LineBox[{1092, 138}], 
           LineBox[{1096, 142}], LineBox[{1097, 143}], LineBox[{1098, 144}], 
           LineBox[{1099, 145}], LineBox[{1100, 146}], LineBox[{1101, 147}], 
           LineBox[{1102, 148}], LineBox[{1103, 149}], LineBox[{1104, 150}], 
           LineBox[{1106, 152}], LineBox[{1107, 153}], LineBox[{1108, 154}], 
           LineBox[{1109, 155}], LineBox[{1112, 158}], LineBox[{1113, 159}], 
           LineBox[{1114, 160}], LineBox[{1115, 161}], LineBox[{1118, 164}], 
           LineBox[{1121, 167}], LineBox[{1122, 168}], LineBox[{1123, 169}], 
           LineBox[{1124, 170}], LineBox[{1126, 172}], LineBox[{1128, 174}], 
           LineBox[{1129, 175}], LineBox[{1138, 184}], LineBox[{1146, 192}], 
           LineBox[{1147, 193}], LineBox[{1148, 194}], LineBox[{1150, 196}], 
           LineBox[{1151, 197}], LineBox[{1154, 200}], LineBox[{1159, 205}], 
           LineBox[{1160, 206}], LineBox[{1161, 207}], LineBox[{1164, 210}], 
           LineBox[{1171, 217}], LineBox[{1172, 218}], LineBox[{1173, 219}], 
           LineBox[{1175, 221}], LineBox[{1177, 223}], LineBox[{1178, 224}], 
           LineBox[{1179, 225}], LineBox[{1180, 226}], LineBox[{1181, 227}], 
           LineBox[{1182, 228}], LineBox[{1183, 229}], LineBox[{1184, 230}], 
           LineBox[{1188, 234}], LineBox[{1194, 240}], LineBox[{1196, 242}], 
           LineBox[{1197, 243}], LineBox[{1199, 245}], LineBox[{1201, 247}], 
           LineBox[{1202, 248}], LineBox[{1203, 249}], LineBox[{1204, 250}], 
           LineBox[{1205, 251}], LineBox[{1206, 252}], LineBox[{1207, 253}], 
           LineBox[{1212, 258}], LineBox[{1216, 262}], LineBox[{1217, 263}], 
           LineBox[{1220, 266}], LineBox[{1222, 268}], LineBox[{1239, 285}], 
           LineBox[{1240, 286}], LineBox[{1241, 287}], LineBox[{1242, 288}], 
           LineBox[{1243, 289}], LineBox[{1244, 290}], LineBox[{1245, 291}], 
           LineBox[{1246, 292}], LineBox[{1247, 293}], LineBox[{1248, 294}], 
           LineBox[{1249, 295}], LineBox[{1250, 296}], LineBox[{1251, 297}], 
           LineBox[{1253, 299}], LineBox[{1254, 300}], LineBox[{1256, 302}], 
           LineBox[{1257, 303}], LineBox[{1259, 305}], LineBox[{1260, 306}], 
           LineBox[{1261, 307}], LineBox[{1262, 308}], LineBox[{1265, 311}], 
           LineBox[{1266, 312}], LineBox[{1268, 314}], LineBox[{1269, 315}], 
           LineBox[{1271, 317}], LineBox[{1272, 318}], LineBox[{1273, 319}], 
           LineBox[{1274, 320}], LineBox[{1278, 324}], LineBox[{1279, 325}], 
           LineBox[{1280, 326}], LineBox[{1286, 332}], LineBox[{1287, 333}], 
           LineBox[{1288, 334}], LineBox[{1289, 335}], LineBox[{1290, 336}], 
           LineBox[{1292, 338}], LineBox[{1293, 339}], LineBox[{1295, 341}], 
           LineBox[{1305, 351}], LineBox[{1307, 353}], LineBox[{1308, 354}], 
           LineBox[{1314, 360}], LineBox[{1315, 361}], LineBox[{1316, 362}], 
           LineBox[{1317, 363}], LineBox[{1319, 365}], LineBox[{1320, 366}], 
           LineBox[{1322, 368}], LineBox[{1325, 371}], LineBox[{1327, 373}], 
           LineBox[{1330, 376}], LineBox[{1331, 377}], LineBox[{1332, 378}], 
           LineBox[{1334, 380}], LineBox[{1335, 381}], LineBox[{1336, 382}], 
           LineBox[{1337, 383}], LineBox[{1338, 384}], LineBox[{1339, 385}], 
           LineBox[{1340, 386}], LineBox[{1341, 387}], LineBox[{1342, 388}], 
           LineBox[{1343, 389}], LineBox[{1344, 390}], LineBox[{1346, 392}], 
           LineBox[{1347, 393}], LineBox[{1348, 394}], LineBox[{1351, 397}], 
           LineBox[{1355, 401}], LineBox[{1356, 402}], LineBox[{1357, 403}], 
           LineBox[{1359, 405}], LineBox[{1360, 406}], LineBox[{1361, 407}], 
           LineBox[{1365, 411}], LineBox[{1368, 414}], LineBox[{1370, 416}], 
           LineBox[{1373, 419}], LineBox[{1376, 422}], LineBox[{1377, 423}], 
           LineBox[{1379, 425}], LineBox[{1384, 430}], LineBox[{1390, 436}], 
           LineBox[{1397, 443}], LineBox[{1399, 445}], LineBox[{1400, 446}], 
           LineBox[{1401, 447}], LineBox[{1404, 450}], LineBox[{1406, 452}], 
           LineBox[{1407, 453}], LineBox[{1408, 454}], LineBox[{1409, 455}], 
           LineBox[{1410, 456}], LineBox[{1413, 459}], LineBox[{1414, 460}], 
           LineBox[{1415, 461}], LineBox[{1416, 462}], LineBox[{1419, 465}], 
           LineBox[{1420, 466}], LineBox[{1421, 467}], LineBox[{1423, 469}], 
           LineBox[{1424, 470}], LineBox[{1435, 481}], LineBox[{1436, 482}], 
           LineBox[{1437, 483}], LineBox[{1439, 485}], LineBox[{1440, 486}], 
           LineBox[{1441, 487}], LineBox[{1443, 489}], LineBox[{1446, 492}], 
           LineBox[{1448, 494}], LineBox[{1450, 496}], LineBox[{1452, 498}], 
           LineBox[{1457, 503}], LineBox[{1458, 504}], LineBox[{1463, 509}], 
           LineBox[{1465, 511}], LineBox[{1467, 513}], LineBox[{1469, 515}], 
           LineBox[{1470, 516}], LineBox[{1474, 520}], LineBox[{1479, 525}], 
           LineBox[{1480, 526}], LineBox[{1483, 529}], LineBox[{1484, 530}], 
           LineBox[{1485, 531}], LineBox[{1488, 534}], LineBox[{1490, 536}], 
           LineBox[{1491, 537}], LineBox[{1499, 545}], LineBox[{1501, 547}], 
           LineBox[{1502, 548}], LineBox[{1504, 550}], LineBox[{1505, 551}], 
           LineBox[{1507, 553}], LineBox[{1509, 555}], LineBox[{1510, 556}], 
           LineBox[{1511, 557}], LineBox[{1512, 558}], LineBox[{1514, 560}], 
           LineBox[{1517, 563}], LineBox[{1518, 564}], LineBox[{1522, 568}], 
           LineBox[{1523, 569}], LineBox[{1526, 572}], LineBox[{1531, 577}], 
           LineBox[{1533, 579}], LineBox[{1534, 580}], LineBox[{1538, 584}], 
           LineBox[{1539, 585}], LineBox[{1540, 586}], LineBox[{1542, 588}], 
           LineBox[{1545, 591}], LineBox[{1548, 594}], LineBox[{1551, 597}], 
           LineBox[{1553, 599}], LineBox[{1554, 600}], LineBox[{1555, 601}], 
           LineBox[{1556, 602}], LineBox[{1557, 603}], LineBox[{1558, 604}], 
           LineBox[{1561, 607}], LineBox[{1562, 608}], LineBox[{1563, 609}], 
           LineBox[{1564, 610}], LineBox[{1565, 611}], LineBox[{1568, 614}], 
           LineBox[{1569, 615}], LineBox[{1570, 616}], LineBox[{1571, 617}], 
           LineBox[{1573, 619}], LineBox[{1574, 620}], LineBox[{1576, 622}], 
           LineBox[{1579, 625}], LineBox[{1581, 627}], LineBox[{1583, 629}], 
           LineBox[{1584, 630}], LineBox[{1585, 631}], LineBox[{1586, 632}], 
           LineBox[{1593, 639}], LineBox[{1594, 640}], LineBox[{1595, 641}], 
           LineBox[{1596, 642}], LineBox[{1597, 643}], LineBox[{1599, 645}], 
           LineBox[{1600, 646}], LineBox[{1604, 650}], LineBox[{1605, 651}], 
           LineBox[{1606, 652}], LineBox[{1607, 653}], LineBox[{1613, 659}], 
           LineBox[{1614, 660}], LineBox[{1615, 661}], LineBox[{1616, 662}], 
           LineBox[{1621, 667}], LineBox[{1622, 668}], LineBox[{1623, 669}], 
           LineBox[{1624, 670}], LineBox[{1626, 672}], LineBox[{1627, 673}], 
           LineBox[{1628, 674}], LineBox[{1630, 676}], LineBox[{1631, 677}], 
           LineBox[{1632, 678}], LineBox[{1633, 679}], LineBox[{1635, 681}], 
           LineBox[{1640, 686}], LineBox[{1646, 692}], LineBox[{1647, 693}], 
           LineBox[{1648, 694}], LineBox[{1649, 695}], LineBox[{1652, 698}], 
           LineBox[{1653, 699}], LineBox[{1654, 700}], LineBox[{1655, 701}], 
           LineBox[{1656, 702}], LineBox[{1658, 704}], LineBox[{1659, 705}], 
           LineBox[{1662, 708}], LineBox[{1663, 709}], LineBox[{1664, 710}], 
           LineBox[{1665, 711}], LineBox[{1666, 712}], LineBox[{1668, 714}], 
           LineBox[{1671, 717}], LineBox[{1673, 719}], LineBox[{1674, 720}], 
           LineBox[{1675, 721}], LineBox[{1679, 725}], LineBox[{1681, 727}], 
           LineBox[{1682, 728}], LineBox[{1683, 729}], LineBox[{1684, 730}], 
           LineBox[{1685, 731}], LineBox[{1696, 742}], LineBox[{1700, 746}], 
           LineBox[{1701, 747}], LineBox[{1702, 748}], LineBox[{1708, 754}], 
           LineBox[{1711, 757}], LineBox[{1712, 758}], LineBox[{1715, 761}], 
           LineBox[{1718, 764}], LineBox[{1722, 768}], LineBox[{1723, 769}], 
           LineBox[{1726, 772}], LineBox[{1731, 777}], LineBox[{1732, 778}], 
           LineBox[{1733, 779}], LineBox[{1736, 782}], LineBox[{1737, 783}], 
           LineBox[{1738, 784}], LineBox[{1739, 785}], LineBox[{1742, 788}], 
           LineBox[{1745, 791}], LineBox[{1751, 797}], LineBox[{1754, 800}], 
           LineBox[{1755, 801}], LineBox[{1757, 803}], LineBox[{1758, 804}], 
           LineBox[{1760, 806}], LineBox[{1761, 807}], LineBox[{1763, 809}], 
           LineBox[{1764, 810}], LineBox[{1767, 813}], LineBox[{1768, 814}], 
           LineBox[{1769, 815}], LineBox[{1770, 816}], LineBox[{1773, 819}], 
           LineBox[{1774, 820}], LineBox[{1775, 821}], LineBox[{1776, 822}], 
           LineBox[{1779, 825}], LineBox[{1788, 834}], LineBox[{1789, 835}], 
           LineBox[{1798, 844}], LineBox[{1803, 849}], LineBox[{1804, 850}], 
           LineBox[{1805, 851}], LineBox[{1806, 852}], LineBox[{1807, 853}], 
           LineBox[{1813, 859}], LineBox[{1816, 862}], LineBox[{1818, 864}], 
           LineBox[{1820, 866}], LineBox[{1821, 867}], LineBox[{1822, 868}], 
           LineBox[{1823, 869}], LineBox[{1824, 870}], LineBox[{1825, 871}], 
           LineBox[{1827, 873}], LineBox[{1828, 874}], LineBox[{1829, 875}], 
           LineBox[{1836, 882}], LineBox[{1837, 883}], LineBox[{1838, 884}], 
           LineBox[{1841, 887}], LineBox[{1842, 888}], LineBox[{1843, 889}], 
           LineBox[{1844, 890}], LineBox[{1847, 893}], LineBox[{1852, 898}], 
           LineBox[{1853, 899}], LineBox[{1857, 903}], LineBox[{1858, 904}], 
           LineBox[{1859, 905}], LineBox[{1860, 906}], LineBox[{1862, 908}], 
           LineBox[{1863, 909}], LineBox[{1868, 914}], LineBox[{1869, 915}], 
           LineBox[{1872, 918}], LineBox[{1873, 919}], LineBox[{1874, 920}], 
           LineBox[{1877, 923}], LineBox[{1878, 924}], LineBox[{1879, 925}], 
           LineBox[{1882, 928}]}}, {{}, 
          {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           0.0055000000000000005`], AbsoluteThickness[1.6], 
           PointBox[CompressedData["
1:eJwN02MDFQYAAMC3bNt2Ldu1ZdvL5pZt27Zt27Zt2959uJ9wiRu0rdjmj0Ag
sC1oINAxZCDQic50oSvd6E4PetKL3vShL/3ozwAGMojBDGEowxjOCEYyitGM
YSzjGM8EJjKJyUxhKtOYzgxmMovZzGEu85jPAhayiMUsYSnLWM4KVrKK1axh
LetYzwY2sonNbGEr29jODnayi93sYS/72M8BDnKIwxzhKMc4zglOcorTnOEs
5zjPBS5yictc4SrXuM4NbnKL29zhLve4zwMe8ojHPOEpz3jOC17yite84S3v
eM8HPvKJz3zhK9/4zg9+8ovfBEIFAn8QhKAEIzghCEkoQhOGsIQjPBGISCQi
E4WoRCM6MYhJLGITh7jEIz4JSEgiEpOEpCQjOSlISSpSk4a0pCM9GfiTjGQi
M1nISjayk4Oc5CI3echLPvJTgIIUojBFKMpf/E0xilOCkpSiNGUoSznKU4GK
VKIyVahKNapTg5rUojZ1qEs9/qE+DWhIIxrThKY0ozktaEkrWtOGtrSjPR34
l//oSCc604WudKM7PehJL3rTh770oz8DGMggBjOEoQxjOCMYyShGM4axjGM8
E5jIJCYzhalMYzozmMksZjOHucxjPgtYyCIWs4SlLGM5K1jJKlazhrWsYz0b
2MgmNrOFrWxjOzvYyS52s4e97GM/BzjIIQ5zhKMc4zgnOMkpTnOGs5zjPBe4
yCUuc4WrXOM6N7jJLW5zh7vc4z4PeMgjHvOEpzzjOS94ySte84a3vOM9H/jI
Jz7zha984zs/+MkvfhMI7T9BCEowghOCkIQiNGEISzjCE4GIRCIyUYhKNKIT
g5jEIjZxiEs84pOAhCQiMUlISjKSk4KUpCI1aUhLOtKTgT/JSCYyk4WsZCM7
OchJLnKTh7zkIz8FKEghClOEovzF3xSjOCUoSSlKU4aylKM8FahIJSpThapU
ozo1qEktalOHutTjH+rTgIY0ojFNaEozmtOClrSiNW1oSzva04F/+Y+OdKIz
XehKN7rTg570ojd96Es/+jOAgQxiMEMYyjCGM4KRjGI0YxjLOMYzgYlMYjJT
mMo0pjODmcxiNnOYyzzms4CFLGIxS1jKMpazgpWsYjVrWMs61rOBjWxiM1vY
yja2s4Od7GI3e9jLPvZzgIMc4jBHOMoxjnOCk5ziNGc4yznOc4GLXOIyV7jK
Na5zg5vc4jZ3uMs97vOAhzziMU94yjOe84KXvOI1b3jLO97zgY984jNf+Mo3
vvODn/ziN4Ew/hOEoAQjOCEISShCE4awhCM8EYhIJCIThahEIzoxiEksYhOH
uMQjPglISCISk4SkJCM5KUhJKlKThrSkIz0Z+JOMZCIzWchKNrKTg5zkIjd5
yEs+8lOAghSiMEUoyl/8TTGKU4KSlKI0ZShLOcpTgYpUojJVqEo1qlODmtSi
NnWoSz3+oT4NaEgjGtOEpjSjOS1oSSta04a2tKM9HfiX/+hIJzrTha50ozs9
6EkvetOHvvSjPwMYyCAGM4ShDGM4IxjJKEYzhrGMYzwTmMgkJjOFqUxjOjOY
ySxmM4e5zGM+C1jIIhazhKUsYzkrWMkqVrOGtaxjPRvYyCY2s4WtbGM7O9jJ
Lnazh73sYz8HOMghDnOEoxzjOCc4ySlOc4aznOM8F7jIJS5zhatc4zo3uMkt
bnOHu9zjPg94yCMe84SnPOM5L3jJK17zhre84z0f+MgnPvOFr3zjOz/4yS9+
EwjrP0EISjCCE4KQhCI0YQhLOMITgYhEIjJRiEo0ohODmMQiNnGISzzik4CE
JCIxSUhKMpKTgpSkIjVpSEs60pOB/wFt6QsY
            "]]}, {}}}], {}, {}, {}, {}},
      
      AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
      Axes->{True, True},
      AxesLabel->{None, None},
      AxesOrigin->{0, 0},
      DisplayFunction->Identity,
      Frame->{{True, True}, {True, True}},
      FrameLabel->{{
         FormBox["\"Covariance\"", TraditionalForm], None}, {
         FormBox["\"Weeks\"", TraditionalForm], 
         FormBox["\"tempSC3\"", TraditionalForm]}},
      FrameStyle->Directive[18, 
        Thickness[Large]],
      FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
      GridLines->{None, None},
      GridLinesStyle->Directive[
        GrayLevel[0.5, 0.4]],
      ImagePadding->All,
      Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& ), "CopiedValueFunction" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& )}},
      PlotRange->{{0, 954.}, {-0.08730667238157439, 0.08023033943262409}},
      PlotRangeClipping->True,
      PlotRangePadding->{{
         Scaled[0.02], 
         Scaled[0.02]}, {
         Scaled[0.05], 
         Scaled[0.05]}},
      Ticks->{Automatic, Automatic}], {967.5, -116.80842387373012}, 
     ImageScaled[{0.5, 0.5}], {360., 222.49223594996212}]}, {}},
  ContentSelectable->True,
  ImageSize->{1632., Automatic},
  PlotRangePadding->{6, 5}]], "Output",ExpressionUUID->"e7faeb6d-947a-4981-\
9f75-6fac7af0cc3c"]
}, Open  ]],

Cell[TextData[{
 "Ainda assim, pode-se utilizar uma rede neural para tentar extrair alguma \
propriedade da s\[EAcute]rie residual. Como na literatura de redes neurais \
ainda n\[ATilde]o h\[AAcute] m\[EAcute]todos determin\[IAcute]sticos para \
optimiza\[CCedilla]\[ATilde]o dos hiperpar\[AHat]metros da rede, os \
par\[AHat]metros abaixo foram determinados atrav\[EAcute]s de tentativa e \
erro. Uma boa pr\[AAcute]tica com rela\[CCedilla]\[ATilde]o ao n\[UAcute]mero \
de inputs \[EAcute] observar quais correla\[CCedilla]\[OTilde]es parciais s\
\[ATilde]o relevantes , o que aqui \[EAcute] definido como correla\[CCedilla]\
\[OTilde]es parciais com valores acima de ",
 Cell[BoxData[
  FormBox[
   FractionBox["2", 
    RowBox[{"\[Sqrt]", 
     RowBox[{"Length", "[", "tempSC3", "]"}]}]], TraditionalForm]],
  ExpressionUUID->"bf24716b-bb12-43ad-9991-02b91506a94a"],
 ". Aqui, o n\[UAcute]mero 29 \[EAcute] bom pois \[EAcute] grande o \
suficiente para representar um pouco mais de um semestre de \
correla\[CCedilla]\[OTilde]es, por\[EAcute]m n\[ATilde]o t\[ATilde]o grande a \
ponto de pequenas correla\[CCedilla]\[OTilde]es serem suavizadas por \
comportamentos de longo prazo. Outra boa pr\[AAcute]tica \[EAcute] escolher o \
n\[UAcute]mero de neur\[OHat]nios tal que input > neurons > output."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"c1857bb8-1253-4a2d-b5ef-bad1d4c013bb"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"tempNeurons", "=", "5"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"tempInputNumber", "=", "29"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"tempOutputNumber", "=", "1"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"tempTrain", ",", "tempTest"}], "}"}], "=", 
   RowBox[{"sampleSplit", "[", 
    RowBox[{"tempSC3", ",", "tempInputNumber"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"tempBatchSize", "=", "1"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"tempNetModel", "=", 
   RowBox[{"neuralNetwork", "[", 
    RowBox[{
    "tempSC3", ",", "tempNeurons", ",", "tempInputNumber", ",", 
     "tempOutputNumber", ",", "tempTrain", ",", "tempTest", ",", 
     "tempBatchSize"}], "]"}]}], ";"}]}], "Input",ExpressionUUID->"66f15b18-\
6691-4ef3-badd-812b85c27364"],

Cell[TextData[{
 "Abaixo uma propriedade crucial do treinamento: a evolu\[CCedilla]\[ATilde]o \
da fun\[CCedilla]\[ATilde]o ",
 StyleBox["loss",
  FontSlant->"Italic"],
 " em fun\[CCedilla]\[ATilde]o das rodadas de treinamento. Fun\[CCedilla]\
\[ATilde]o ",
 StyleBox["Loss",
  FontSlant->"Italic"],
 " \[EAcute] a norma Euclidiana tanto para ",
 StyleBox["set",
  FontSlant->"Italic"],
 " de treinamento quanto para ",
 StyleBox["set",
  FontSlant->"Italic"],
 " de teste (",
 StyleBox["validation",
  FontSlant->"Italic"],
 ")."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"f3787f1d-64e7-4287-92dc-0fe2f5b2dc5b"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"tempNetModel", "[", "\"\<LossEvolutionPlot\>\"", "]"}]], "Input",Exp\
ressionUUID->"9455a642-ef74-4aae-8a75-6ea089b8a2a5"],

Cell[BoxData[
 TemplateBox[{GraphicsBox[{
     AbsoluteThickness[1.25], {{
       InsetBox[
        FormBox["100", TraditionalForm], 
        Offset[{-2, 0}, {100., 0.30000000000000004`}], {1., 1.}], 
       InsetBox[
        FormBox["200", TraditionalForm], 
        Offset[{-2, 0}, {200., 0.30000000000000004`}], {1., 1.}], 
       InsetBox[
        FormBox["300", TraditionalForm], 
        Offset[{-2, 0}, {300., 0.30000000000000004`}], {1., 1.}], 
       InsetBox[
        FormBox["400", TraditionalForm], 
        Offset[{-2, 0}, {400., 0.30000000000000004`}], {1., 1.}], 
       InsetBox[
        FormBox["500", TraditionalForm], 
        Offset[{-2, 0}, {500., 0.30000000000000004`}], {1., 1.}]}, {
       InsetBox[
        FormBox[
         TemplateBox[{"10", "\"-2\""}, "Superscript", SyntaxForm -> 
          SuperscriptBox], TraditionalForm], 
        Offset[{3, 0}, {0, -2.}], {-1, -1.}], 
       InsetBox[
        FormBox[
         TemplateBox[{"10", "\"-1\""}, "Superscript", SyntaxForm -> 
          SuperscriptBox], TraditionalForm], 
        Offset[{3, 0}, {0, -1.}], {-1, -1.}], 
       InsetBox[
        FormBox[
         TemplateBox[{"10", "\"0\""}, "Superscript", SyntaxForm -> 
          SuperscriptBox], TraditionalForm], 
        Offset[{3, 0}, {0, 0.}], {-1, -1.}]}}, {{
       Hue[0.083, 1., 1.], 
       LineBox[CompressedData["
1:eJw9WHlczen3v6ksUW62sU4lpaIsGRLpbUm7FpW03m7ltt3b3Vu03JksEQoZ
lFEMZSwjlCJ0MyrTWMJoRCpCKApRmOE7v9c859c/vc7rPOc55/0+73OeTxnx
470jB3A4nCQNDuf/ftOPg//pNLNOnv1/Vo/9aP2NWwOyK6qYG31pnjWlZ84y
ezByn3yaE1FbzWwuRN3HHZdYVjF7FBKKP9Q23SH/WIQGrbupffQ6syfit/GD
N6ZWXWO2Iead1inyGHaZ2ZPRUfb40c16sqfgpWbM+cGiP5ltiroTn/PKvtYx
2wxJm3N9MkfcYbYFpI6RU1UPyZ6OUR/Vc6R7bjDbCmkD9zhJ/BuYPRNmIzMK
b0xuYvYsLJDfXLski+JnIzjLX8v0xl/MtsbHY4/KfP+5z+w5ePbBbtK0aor/
DgXmyS+OXab4ueh/+0O6ljHFz4P/sjz3R+9vM9sGKfsNdMUF5J8Px8jlpkN+
aWa2LX7f/neFjQflW4CGyz3mV3Vbmb0Qfi/0vs+YQ347BGrmTykMpPhFmPY2
XOpgRrY9djpw39Y8pHqBBdNyB+oYt/xnqwDXnXsLvltB9S9G1NWCpc0hbcy/
GBucXQ1TrlP+JVi67uvewOpHzL8Eb+uGLpp6gZ3nLEXlyAmpPVefMv9SPPvs
YPHronbmXwb7bRF/xPEeM/8yfKcIDnTZQvEO0Nw6NmGFI+V3wIWxU1JO/MTO
c5ajXCfROdeV3adaDotxBmM+6pDfEe72/VWD7cnvCNdF/roiA1YPxwmS4oo8
m3svmd8Jrs3zDw+JZXg4zviCV07tBuR3xn5uwIZDzlS/C3qnDvm1KOAJ87vg
qt7hG7EznzG/K2Qvhkdkl1B+VwRUdw4KMGf3cdygPvl+seMP7LzKDZmZ5//Z
OIDqc8fAhLt6Db/Q/e7g9k52DLKm+lYgMUXSdvw18bcCzy89nO06mZ3neCDh
VFvtekPK74E+j+PCjNYO5vdESyYaNIxf/GfDE/EX8i2VowmvJ1acMXG/Marz
P1vtifcTRjnM3sxsjheePv+9b/yRVyzeC3yR1aHlBRTvhcW/h3mn2T9n8V4o
qNwXbWlM+L0hUGaGhOazeuGN0q7c+M+z2XmVNzpWXRyQLab83sg7axh7166b
xa9Efq1TZPaSNyx+JWQXOt9sP0R4V8LvRGGt+2GGT70SXIH2kOWhVL8Pdjc/
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
        "]]}, {}}, {{
       Hue[0.59, 0.5, 0.9], 
       LineBox[{{1, -0.3409363593889738}, {2, -0.3909726395101758}, {
         3, -0.5072335346740257}, {4, -0.3601884143645473}, {
         5, -0.4795429903436345}, {6, -0.40800482943864114`}, {
         7, -0.27803551069887616`}, {8, -0.43852550510160465`}, {
         9, -0.3902517912484736}, {10, -0.3018659790847455}, {
         11, -0.34034793579803124`}, {12, -0.3345760858292294}, {
         13, -0.32451160036054755`}, {14, -0.3346139238711466}, {
         15, -0.3034113086259051}, {16, -0.3603660458555701}, {
         17, -0.20203596291918866`}, {18, -0.2980419549511913}, {
         19, -0.30976543706095755`}, {20, -0.2387296045606276}, {
         21, -0.2643594452336446}, {22, -0.3529371063343484}, {
         23, -0.21804507042880494`}, {24, -0.28051977767672764`}, {
         25, -0.25858269844171833`}, {26, -0.27634050706320096`}, {
         27, -0.28476558041041916`}, {28, -0.22025133438882671`}, {
         29, -0.22096334484022342`}, {30, -0.22088688112181767`}, {
         31, -0.26630664379982555`}, {32, -0.30103120987938015`}, {
         33, -0.22886216941494417`}, {34, -0.24746929477096824`}, {
         35, -0.19432183220786442`}, {36, -0.2321037093691153}, {
         37, -0.2611479112391023}, {38, -0.32585266389817585`}, {
         39, -0.1839077363617161}, {40, -0.20094534665205943`}, {
         41, -0.3030381161529065}, {42, -0.2288718757438449}, {
         43, -0.24577461113933535`}, {44, -0.21354231024937975`}, {
         45, -0.38072423993699}, {46, -0.18291508849457733`}, {
         47, -0.21483103070197437`}, {48, -0.21665057678834188`}, {
         49, -0.1347022790946138}, {50, -0.3203949170578008}, {
         51, -0.2765831506061954}, {52, -0.3669627729417283}, {
         53, -0.23667150601062714`}, {54, -0.26033456643167785`}, {
         55, -0.2733848255913023}, {56, -0.2847046720871833}, {
         57, -0.2752782885169234}, {58, -0.19869634073151365`}, {
         59, -0.29218982581945074`}, {60, -0.24316102849104765`}, {
         61, -0.1906069218223495}, {62, -0.38868072467071657`}, {
         63, -0.26283009193530776`}, {64, -0.4210621731419264}, {
         65, -0.20101548850938292`}, {66, -0.30422729624132305`}, {
         67, -0.26827905716053196`}, {68, -0.4585157428193475}, {
         69, -0.2557593700143616}, {70, -0.2571887225375685}, {
         71, -0.24397208790485742`}, {72, -0.310542745235563}, {
         73, -0.21440805389974674`}, {74, -0.2262895128024339}, {
         75, -0.1805524792821534}, {76, -0.25210495886439727`}, {
         77, -0.26826815206430576`}, {78, -0.35615066256205224`}, {
         79, -0.3567249896900174}, {80, -0.2595624588543895}, {
         81, -0.29070165384331886`}, {82, -0.4290608894253391}, {
         83, -0.3096713544883579}, {84, -0.2480854813687664}, {
         85, -0.31998097034046813`}, {86, -0.23282053586404217`}, {
         87, -0.26525955553253444`}, {88, -0.2992574079368366}, {
         89, -0.2179391227491797}, {90, -0.25341003828158964`}, {
         91, -0.2447190636988764}, {92, -0.2446747705119957}, {
         93, -0.26958377445588066`}, {94, -0.2864082209059194}, {
         95, -0.2884996652867419}, {96, -0.22608023811614286`}, {
         97, -0.20215597466541524`}, {98, -0.2417457378097253}, {
         99, -0.24523646276108252`}, {100, -0.20010232595638233`}, {
         101, -0.24183323992576902`}, {102, -0.2214510534321865}, {
         103, -0.2915306857884785}, {104, -0.24051837871111761`}, {
         105, -0.18225712218191972`}, {106, -0.22612273388256005`}, {
         107, -0.3887490311802577}, {108, -0.25056979876574464`}, {
         109, -0.32344883707829647`}, {110, -0.28275477394364856`}, {
         111, -0.3205018221511044}, {112, -0.27813651788897914`}, {
         113, -0.2613957747365517}, {114, -0.29307069929581264`}, {
         115, -0.3007977972842164}, {116, -0.2984694670114243}, {
         117, -0.37206967955265385`}, {118, -0.2708117335469415}, {
         119, -0.25900724572810657`}, {120, -0.18685776915035876`}, {
         121, -0.20855996743104757`}, {122, -0.19821593130068607`}, {
         123, -0.35731865074461344`}, {124, -0.4748209628840578}, {
         125, -0.31662414903400476`}, {126, -0.4657746175205866}, {
         127, -0.30517016674377184`}, {128, -0.35021508174314775`}, {
         129, -0.34536003191661285`}, {130, -0.3125620407457005}, {
         131, -0.4672593235835061}, {132, -0.26109349542376736`}, {
         133, -0.2480144737359881}, {134, -0.2756737401801368}, {
         135, -0.36120607136387856`}, {136, -0.25107259963297496`}, {
         137, -0.2572909194859194}, {138, -0.3475697132666029}, {
         139, -0.2601057766227832}, {140, -0.20817996798644145`}, {
         141, -0.24069360776399623`}, {142, -0.39437029132005497`}, {
         143, -0.26323120294128677`}, {144, -0.2553797948085228}, {
         145, -0.28513599022094127`}, {146, -0.27882321557481116`}, {
         147, -0.30752836538770884`}, {148, -0.33373387075128275`}, {
         149, -0.22946806425018518`}, {150, -0.30572795679269343`}, {
         151, -0.22590515372782624`}, {152, -0.32748239194403544`}, {
         153, -0.2609678005699371}, {154, -0.18945882752666918`}, {
         155, -0.2417503016005226}, {156, -0.34348435226833013`}, {
         157, -0.3688663722143997}, {158, -0.2003886531378438}, {
         159, -0.24282269604763085`}, {160, -0.2481396348129334}, {
         161, -0.21394873789885702`}, {162, -0.18094204305136186`}, {
         163, -0.21711171218432354`}, {164, -0.21031630749402683`}, {
         165, -0.2689772361103069}, {166, -0.2767219119343052}, {
         167, -0.27352219895722024`}, {168, -0.3548223268553465}, {
         169, -0.25455274774680703`}, {170, -0.291036508273151}, {
         171, -0.2267950146426647}, {172, -0.23009983483475765`}, {
         173, -0.232749817597683}, {174, -0.2821229171210192}, {
         175, -0.18178305350252266`}, {176, -0.29031782709921256`}, {
         177, -0.29474148867068894`}, {178, -0.21909867621589155`}, {
         179, -0.2547076768280984}, {180, -0.33230785779174143`}, {
         181, -0.3128786671314203}, {182, -0.2647791241387067}, {
         183, -0.25040832343733505`}, {184, -0.24698625775391908`}, {
         185, -0.2534368799083098}, {186, -0.22474625894391578`}, {
         187, -0.2141104711510813}, {188, -0.20916295362334858`}, {
         189, -0.2672310116660864}, {190, -0.24572241860219424`}, {
         191, -0.26839458394016497`}, {192, -0.250753688804154}, {
         193, -0.2344158436706369}, {194, -0.23036237030961004`}, {
         195, -0.2261432739081815}, {196, -0.2150422153895412}, {
         197, -0.2940731134206568}, {198, -0.2303603435992294}, {
         199, -0.21740284989024172`}, {200, -0.2760141855553804}, {
         201, -0.30466328564974515`}, {202, -0.18514673215924074`}, {
         203, -0.2422388223971771}, {204, -0.27496284731901177`}, {
         205, -0.2507681681458563}, {206, -0.26930861560381886`}, {
         207, -0.23504157379867852`}, {208, -0.20569018265555186`}, {
         209, -0.29307302198991114`}, {210, -0.23162241168898284`}, {
         211, -0.20854898479349804`}, {212, -0.21685777006494744`}, {
         213, -0.23551010120435897`}, {214, -0.28829323302818594`}, {
         215, -0.2011302316899701}, {216, -0.28358128562287294`}, {
         217, -0.2655574628407689}, {218, -0.22794575298895622`}, {
         219, -0.24436957130287196`}, {220, -0.30626005780312154`}, {
         221, -0.25464276351468523`}, {222, -0.27484370628746085`}, {
         223, -0.27944617204257255`}, {224, -0.19046097476367077`}, {
         225, -0.20678032797140644`}, {226, -0.2545182865823975}, {
         227, -0.20313379152336503`}, {228, -0.26548005705799527`}, {
         229, -0.1534232596452628}, {230, -0.25736820093929635`}, {
         231, -0.20520250198697323`}, {232, -0.26285427828795416`}, {
         233, -0.21266453649043407`}, {234, -0.17908252973149907`}, {
         235, -0.15581085748587675`}, {236, -0.1581513219938231}, {
         237, -0.18250662365003248`}, {238, -0.15750671103059274`}, {
         239, -0.1659369590214293}, {240, -0.19510031686720625`}, {
         241, -0.14051858812672194`}, {242, -0.17598265866567336`}, {
         243, -0.1773148623083905}, {244, -0.2067744103018264}, {
         245, -0.2622847765308411}, {246, -0.19201218299767195`}, {
         247, -0.25183572976459434`}, {248, -0.24940242947874677`}, {
         249, -0.22766596287096566`}, {250, -0.2586870858374823}, {
         251, -0.2719969224531931}, {252, -0.2961884559931968}, {
         253, -0.22294581934957997`}, {254, -0.24897042995681942`}, {
         255, -0.31157312276054394`}, {256, -0.24248749616115223`}, {
         257, -0.2770021590383939}, {258, -0.3056907028089902}, {
         259, -0.24837651304682645`}, {260, -0.2852043190576416}, {
         261, -0.23360178498217504`}, {262, -0.33307136531051584`}, {
         263, -0.21448394462650427`}, {264, -0.30077840447531823`}, {
         265, -0.2259377029749431}, {266, -0.2866492654977689}, {
         267, -0.21092114072360893`}, {268, -0.20394957608149486`}, {
         269, -0.18880524658713274`}, {270, -0.2851911851243556}, {
         271, -0.2921681523845954}, {272, -0.2696825316375032}, {
         273, -0.22622644062617162`}, {274, -0.18956669094465012`}, {
         275, -0.2593539461952344}, {276, -0.22121595332940444`}, {
         277, -0.3320192687202895}, {278, -0.2385102252125034}, {
         279, -0.22621007431598772`}, {280, -0.27871786244115354`}, {
         281, -0.24565063391586883`}, {282, -0.24179714473953873`}, {
         283, -0.2324713463036881}, {284, -0.21981055237858652`}, {
         285, -0.2291865677119388}, {286, -0.2099326457732416}, {
         287, -0.153863589601119}, {288, -0.19453176137889924`}, {
         289, -0.17670376956570402`}, {290, -0.22785639153744247`}, {
         291, -0.24487952705325464`}, {292, -0.15190530312414374`}, {
         293, -0.23781496218921427`}, {294, -0.2119848075718866}, {
         295, -0.19502055894741072`}, {296, -0.23247181511416046`}, {
         297, -0.1430073076033857}, {298, -0.19808442823687453`}, {
         299, -0.20542789115615576`}, {300, -0.27145466419783437`}, {
         301, -0.2706448341793096}, {302, -0.23127001698775856`}, {
         303, -0.18567155808738384`}, {304, -0.24594762725499655`}, {
         305, -0.17570004083271504`}, {306, -0.13560659774403747`}, {
         307, -0.11882851868240081`}, {308, -0.16193634505783386`}, {
         309, -0.1364048530576708}, {310, -0.11958166850720912`}, {
         311, -0.1821121077372964}, {312, -0.22476779544184428`}, {
         313, -0.16076843417491013`}, {314, -0.1702705128315507}, {
         315, -0.1914704622553882}, {316, -0.17244216247458868`}, {
         317, -0.145512071975845}, {318, -0.1451371233436466}, {
         319, -0.16613433489837873`}, {320, -0.1906482357099417}, {
         321, -0.17811464479415762`}, {322, -0.15146981070446275`}, {
         323, -0.27627487449585175`}, {324, -0.1580643234777668}, {
         325, -0.19852925129359453`}, {326, -0.12987233334216952`}, {
         327, -0.18485796427006282`}, {328, -0.15919938443864626`}, {
         329, -0.15559678639712465`}, {330, -0.162543298844942}, {
         331, -0.18802334085635927`}, {332, -0.13357213266351156`}, {
         333, -0.11590846396451851`}, {334, -0.15577592788071465`}, {
         335, -0.13664482435639838`}, {336, -0.15535975380019335`}, {
         337, -0.12779003271100747`}, {338, -0.1872930095206769}, {
         339, -0.2573994186514476}, {340, -0.1388090365943032}, {
         341, -0.15395920671469868`}, {342, -0.1972267207316406}, {
         343, -0.16857387418105022`}, {344, -0.19438270863950272`}, {
         345, -0.16955494202841379`}, {346, -0.1772481933175723}, {
         347, -0.23857983436427949`}, {348, -0.2299451758058384}, {
         349, -0.2513695148741994}, {350, -0.19246696227511959`}, {
         351, -0.2088507126060212}, {352, -0.15079901675323576`}, {
         353, -0.170140102727016}, {354, -0.1852560627313188}, {
         355, -0.17438360375459488`}, {356, -0.17545462328745948`}, {
         357, -0.21982856394494424`}, {358, -0.15427010778152775`}, {
         359, -0.2118783407894432}, {360, -0.20708009899150642`}, {
         361, -0.22497907014280893`}, {362, -0.14206338612843378`}, {
         363, -0.17654505025938352`}, {364, -0.1552071506315563}, {
         365, -0.18253448213005563`}, {366, -0.14428026824985138`}, {
         367, -0.1584141600528899}, {368, -0.17598080427087742`}, {
         369, -0.22140988221921312`}, {370, -0.17350606344891115`}, {
         371, -0.1814620424137088}, {372, -0.22386285214126353`}, {
         373, -0.19413682925792328`}, {374, -0.1892743191316888}, {
         375, -0.16965268966705127`}, {376, -0.17779175633123517`}, {
         377, -0.11933605846591987`}}]}, {}}}, ImageSize -> {471, 201}, Frame -> 
    True, Axes -> None, AspectRatio -> Full, 
    BaseStyle -> {
     FontFamily -> "Verdana", FontSize -> 8, FontColor -> GrayLevel[0.5], 
      ScriptSizeMultipliers -> 0.2, ScriptMinSize -> 6}, 
    PlotRange -> {{0, 376}, {-1.8, 0.2}}, 
    GridLines -> {{100., 200., 300., 400., 500.}, {{-2., 
        GrayLevel[0.3001]}, {-1., 
        GrayLevel[0.3001]}, {0., 
        GrayLevel[0.3001]}, {-1.6989700043360185`, 
        GrayLevel[0.8501]}, {-1.3979400086720375`, 
        GrayLevel[0.8501]}, {-1.2218487496163564`, 
        GrayLevel[0.8501]}, {-1.0969100130080565`, 
        GrayLevel[0.8501]}, {-0.6989700043360187, 
        GrayLevel[0.8501]}, {-0.39794000867203755`, 
        GrayLevel[0.8501]}, {-0.22184874961635626`, 
        GrayLevel[0.8501]}, {-0.09691001300805638, 
        GrayLevel[0.8501]}, {0.30102999566398114`, 
        GrayLevel[0.8501]}, {0.6020599913279623, 
        GrayLevel[0.8501]}, {0.7781512503836435, 
        GrayLevel[0.8501]}, {0.9030899869919434, 
        GrayLevel[0.8501]}}}, PlotRangePadding -> {0, 
      Scaled[0.05]}, PlotRangeClipping -> True, Background -> GrayLevel[1], 
    FrameStyle -> GrayLevel[0.5], {}, FrameLabel -> {{
       FormBox["\"loss\"", TraditionalForm], None}, {None, 
       FormBox["\"rounds\"", TraditionalForm]}}, 
    ImagePadding -> {{20, 1}, {1, 20}}, FrameTicks -> None],FormBox[
    FormBox[
     TemplateBox[{"\"validation\"", "\"training\""}, "LineLegend", 
      DisplayFunction -> (FormBox[
        StyleBox[
         StyleBox[
          PaneBox[
           TagBox[
            GridBox[{{
               TagBox[
                GridBox[{{
                   GraphicsBox[{{
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[0.5], 
                    AbsoluteThickness[1.6], 
                    Hue[0.59, 0.5, 0.9]], {
                    LineBox[{{0, 10}, {20, 10}}]}}, {
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[0.5], 
                    AbsoluteThickness[1.6], 
                    Hue[0.59, 0.5, 0.9]], {}}}, AspectRatio -> Full, 
                    ImageSize -> {20, 10}, PlotRangePadding -> None, 
                    ImagePadding -> Automatic, 
                    BaselinePosition -> (Scaled[0.1] -> Baseline)], #}, {
                   GraphicsBox[{{
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[0.5], 
                    AbsoluteThickness[1.6], 
                    Hue[0.083, 1., 1.]], {
                    LineBox[{{0, 10}, {20, 10}}]}}, {
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[0.5], 
                    AbsoluteThickness[1.6], 
                    Hue[0.083, 1., 1.]], {}}}, AspectRatio -> Full, 
                    ImageSize -> {20, 10}, PlotRangePadding -> None, 
                    ImagePadding -> Automatic, 
                    BaselinePosition -> (Scaled[0.1] -> Baseline)], #2}}, 
                 GridBoxAlignment -> {
                  "Columns" -> {Center, Left}, "Rows" -> {{Baseline}}}, 
                 AutoDelete -> False, 
                 GridBoxDividers -> {
                  "Columns" -> {{False}}, "Rows" -> {{False}}}, 
                 GridBoxItemSize -> {"Columns" -> {{All}}, "Rows" -> {{All}}},
                  GridBoxSpacings -> {
                  "Columns" -> {{0.5}}, "Rows" -> {{0.8}}}], "Grid"]}}, 
             GridBoxAlignment -> {"Columns" -> {{Left}}, "Rows" -> {{Top}}}, 
             AutoDelete -> False, 
             GridBoxItemSize -> {
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}, 
             GridBoxSpacings -> {"Columns" -> {{1}}, "Rows" -> {{0}}}], 
            "Grid"], Alignment -> Left, AppearanceElements -> None, 
           ImageMargins -> {{5, 5}, {5, 5}}, ImageSizeAction -> 
           "ResizeToFit"], LineIndent -> 0, StripOnInput -> False], {
         FontFamily -> "Arial"}, Background -> Automatic, StripOnInput -> 
         False], TraditionalForm]& ), 
      InterpretationFunction :> (RowBox[{"LineLegend", "[", 
         RowBox[{
           RowBox[{"{", 
             RowBox[{
               InterpretationBox[
                ButtonBox[
                 TooltipBox[
                  GraphicsBox[{{
                    GrayLevel[0], 
                    RectangleBox[{0, 0}]}, {
                    GrayLevel[0], 
                    RectangleBox[{1, -1}]}, {
                    Hue[0.59, 0.5, 0.9], 
                    RectangleBox[{0, -1}, {2, 1}]}}, DefaultBaseStyle -> 
                   "ColorSwatchGraphics", AspectRatio -> 1, Frame -> True, 
                   FrameStyle -> Hue[0.59, 0.5, 0.6000000000000001], 
                   FrameTicks -> None, PlotRangePadding -> None, ImageSize -> 
                   Dynamic[{
                    Automatic, 
                    1.35 (CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[
                    Magnification])}]], 
                  StyleBox[
                   RowBox[{"Hue", "[", 
                    RowBox[{"0.59`", ",", "0.5`", ",", "0.9`"}], "]"}], 
                   NumberMarks -> False]], Appearance -> None, 
                 BaseStyle -> {}, BaselinePosition -> Baseline, 
                 DefaultBaseStyle -> {}, ButtonFunction :> 
                 With[{Typeset`box$ = EvaluationBox[]}, 
                   If[
                    Not[
                    AbsoluteCurrentValue["Deployed"]], 
                    SelectionMove[Typeset`box$, All, Expression]; 
                    FrontEnd`Private`$ColorSelectorInitialAlpha = 1; 
                    FrontEnd`Private`$ColorSelectorInitialColor = 
                    Hue[0.59, 0.5, 0.9]; 
                    FrontEnd`Private`$ColorSelectorUseMakeBoxes = True; 
                    MathLink`CallFrontEnd[
                    FrontEnd`AttachCell[Typeset`box$, 
                    FrontEndResource["HueColorValueSelector"], {
                    0, {Left, Bottom}}, {Left, Top}, 
                    "ClosingActions" -> {
                    "SelectionDeparture", "ParentChanged", 
                    "EvaluatorQuit"}]]]], BaseStyle -> Inherited, Evaluator -> 
                 Automatic, Method -> "Preemptive"], 
                Hue[0.59, 0.5, 0.9], Editable -> False, Selectable -> False], 
               ",", 
               InterpretationBox[
                ButtonBox[
                 TooltipBox[
                  GraphicsBox[{{
                    GrayLevel[0], 
                    RectangleBox[{0, 0}]}, {
                    GrayLevel[0], 
                    RectangleBox[{1, -1}]}, {
                    Hue[0.083, 1., 1.], 
                    RectangleBox[{0, -1}, {2, 1}]}}, DefaultBaseStyle -> 
                   "ColorSwatchGraphics", AspectRatio -> 1, Frame -> True, 
                   FrameStyle -> Hue[0.083, 1., 0.6666666666666667], 
                   FrameTicks -> None, PlotRangePadding -> None, ImageSize -> 
                   Dynamic[{
                    Automatic, 
                    1.35 (CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[
                    Magnification])}]], 
                  StyleBox[
                   RowBox[{"Hue", "[", 
                    RowBox[{"0.083`", ",", "1.`", ",", "1.`"}], "]"}], 
                   NumberMarks -> False]], Appearance -> None, 
                 BaseStyle -> {}, BaselinePosition -> Baseline, 
                 DefaultBaseStyle -> {}, ButtonFunction :> 
                 With[{Typeset`box$ = EvaluationBox[]}, 
                   If[
                    Not[
                    AbsoluteCurrentValue["Deployed"]], 
                    SelectionMove[Typeset`box$, All, Expression]; 
                    FrontEnd`Private`$ColorSelectorInitialAlpha = 1; 
                    FrontEnd`Private`$ColorSelectorInitialColor = 
                    Hue[0.083, 1., 1.]; 
                    FrontEnd`Private`$ColorSelectorUseMakeBoxes = True; 
                    MathLink`CallFrontEnd[
                    FrontEnd`AttachCell[Typeset`box$, 
                    FrontEndResource["HueColorValueSelector"], {
                    0, {Left, Bottom}}, {Left, Top}, 
                    "ClosingActions" -> {
                    "SelectionDeparture", "ParentChanged", 
                    "EvaluatorQuit"}]]]], BaseStyle -> Inherited, Evaluator -> 
                 Automatic, Method -> "Preemptive"], 
                Hue[0.083, 1., 1.], Editable -> False, Selectable -> False]}],
              "}"}], ",", 
           RowBox[{"{", 
             RowBox[{#, ",", #2}], "}"}]}], "]"}]& ), Editable -> True], 
     TraditionalForm], TraditionalForm]},
  "Legended",
  DisplayFunction->(GridBox[{{
      TagBox[
       ItemBox[
        PaneBox[
         TagBox[#, "SkipImageSizeLevel"], Alignment -> {Center, Baseline}, 
         BaselinePosition -> Baseline], DefaultBaseStyle -> "Labeled"], 
       "SkipImageSizeLevel"], 
      ItemBox[#2, DefaultBaseStyle -> "LabeledLabel"]}}, 
    GridBoxAlignment -> {"Columns" -> {{Center}}, "Rows" -> {{Center}}}, 
    AutoDelete -> False, GridBoxItemSize -> Automatic, 
    BaselinePosition -> {1, 1}]& ),
  Editable->True,
  InterpretationFunction->(RowBox[{"Legended", "[", 
     RowBox[{#, ",", 
       RowBox[{"Placed", "[", 
         RowBox[{#2, ",", "After"}], "]"}]}], "]"}]& )]], "Output",ExpressionU\
UID->"75cfb6e1-c67f-4923-9213-6554c7a75cf2"]
}, Open  ]],

Cell[TextData[{
 "Pelo fato de a s\[EAcute]rie n\[ATilde]o ser c\[IAcute]clica, ",
 StyleBox["i.e. ",
  FontSlant->"Italic"],
 "tempSC3[[-1]] \[NotEqual] tempSC3[[1]], e pelo fato de na hora do \
treinamento estarmos dividindo a s\[EAcute]rie tempSC3 em sequ\[EHat]ncias de \
tempInputNumber valores de ",
 StyleBox["input",
  FontSlant->"Italic"],
 " levando a um valor de ",
 StyleBox["output",
  FontSlant->"Italic"],
 ", tempos que alguns valores finais da s\[EAcute]rie n\[ATilde]o entram em \
qualquer um dos ",
 StyleBox["sets",
  FontSlant->"Italic"],
 " train ou test. Assim, usamos estes pontos numa vistos antes pela rede para \
analisarmos como a rede se comporta na previs\[ATilde]o de pontos futuros. \
Abaixo s\[ATilde]o calculados tempFuturePoints pontos futuros, que \
s\[ATilde]o mostrados em um gr\[AAcute]fico junto com a s\[EAcute]rie tempSC3."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"226f6c5b-3b0c-48da-8e24-0c96330dc8de"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"tempFuturePoints", "=", "tempInputNumber"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"tempTrained", " ", "=", " ", 
   RowBox[{"Flatten", "[", 
    RowBox[{
     RowBox[{"NestList", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"Rest", "[", 
         RowBox[{"Append", "[", 
          RowBox[{"#", ",", 
           RowBox[{
            RowBox[{"tempNetModel", "[", "\"\<TrainedNet\>\"", "]"}], "[", 
            "#", "]"}]}], "]"}], "]"}], "&"}], ",", 
       RowBox[{"tempTest", "[", 
        RowBox[{"[", 
         RowBox[{
          RowBox[{"-", "1"}], ",", "1"}], "]"}], "]"}], ",", 
       "tempFuturePoints"}], "]"}], "[", 
     RowBox[{"[", 
      RowBox[{"-", "2"}], "]"}], "]"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"tempPlot", "=", 
   RowBox[{"Thread", "[", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"Range", "[", 
       RowBox[{
        RowBox[{
         RowBox[{"Length", "@", "tempSC3"}], "-", 
         RowBox[{"Mod", "[", 
          RowBox[{
           RowBox[{"Length", "@", "tempSC3"}], ",", 
           RowBox[{"tempInputNumber", "+", "1"}]}], "]"}], "-", "1"}], ",", 
        RowBox[{
         RowBox[{"Length", "@", "tempSC3"}], "-", 
         RowBox[{"Mod", "[", 
          RowBox[{
           RowBox[{"Length", "@", "tempSC3"}], ",", 
           RowBox[{"tempInputNumber", "+", "1"}]}], "]"}], "+", 
         RowBox[{"Length", "@", "tempTrained"}], "-", "2"}]}], "]"}], ",", 
      "tempTrained"}], "}"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{"ListLinePlot", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"tempSC3", ",", "tempPlot"}], "}"}], ",", 
   RowBox[{"Joined", "\[Rule]", "True"}], ",", 
   RowBox[{"PlotLegends", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"\"\<Original\>\"", ",", "\"\<Previs\[ATilde]o\>\""}], "}"}]}], 
   ",", 
   RowBox[{"PlotRange", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"tempPlot", "[", 
         RowBox[{"[", 
          RowBox[{"1", ",", "1"}], "]"}], "]"}], ",", 
        RowBox[{"tempPlot", "[", 
         RowBox[{"[", 
          RowBox[{
           RowBox[{"-", "1"}], ",", "1"}], "]"}], "]"}]}], "}"}], ",", 
      "All"}], "}"}]}], ",", 
   RowBox[{"PlotStyle", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"Blue", ",", "Red"}], "}"}]}], ",", 
   RowBox[{"Axes", "\[Rule]", "False"}], ",", "\[IndentingNewLine]", 
   RowBox[{"Frame", "\[Rule]", "True"}], ",", 
   RowBox[{"FrameStyle", "\[Rule]", 
    RowBox[{"Directive", "[", 
     RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
   RowBox[{"FrameLabel", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"None", ",", "None"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"\"\<Semanas\>\"", ",", "\"\<S\[EAcute]rie Residual\>\""}], 
       "}"}]}], "}"}]}]}], "\[IndentingNewLine]", "]"}]}], "Input",ExpressionU\
UID->"318c9a37-d3b5-4216-a5ac-e97bc832d4ab"],

Cell[BoxData[
 TemplateBox[{GraphicsBox[{{}, {{{}, {}, {
        Hue[0.67, 0.6, 0.6], 
        Directive[
         PointSize[
          NCache[
           Rational[1, 120], 0.008333333333333333]], 
         AbsoluteThickness[1.6], 
         RGBColor[0, 0, 1]], 
        LineBox[CompressedData["
1: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
aluO
         "]]}, {
        Hue[0.9060679774997897, 0.6, 0.6], 
        Directive[
         PointSize[
          NCache[
           Rational[1, 120], 0.008333333333333333]], 
         AbsoluteThickness[1.6], 
         RGBColor[1, 0, 0]], 
        LineBox[CompressedData["
1:eJxTTMoPSmViYGCQBWIQDQYcvQ7Pl3MuXLvg334wX6DXAURVNR+zB/MlIPzY
oJMQvgKYn+BgvgWiXgPMP8BauhzCN4DIz36wEaLeAsx32Kt+CMJ3APMXFNYd
gfA9IPL/0+9C+AEQ81773IDwI8D8hmN8JyHmJ0DML4i8COFnQPgB76DuKYCY
Xy60C6K/AsLPy7kC4TdA/HPC9xSE3wGx74nMDgh/Apiv4Oa9HWLeDDD/wXzO
TRD5BRC+1If9EP4KiPpq+a0Q9Rsg/IMP9kDkd0Dcv3EC1P8HIO693L8Nwj8B
MU/h1kEI/wJE/o/1dAj/BkS/8f1iiPkPIOafVe+GyL+AhN8X4XX7AekBcoU=

         "]]}}}, {}, {}, {}, {}}, {
    DisplayFunction -> Identity, PlotRangePadding -> {{0, 0}, {
        Scaled[0.05], 
        Scaled[0.05]}}, AxesOrigin -> {929.14, 0}, 
     PlotRange -> {{929, 957}, {-3.181364457813751, 3.296932494096761}}, 
     PlotRangeClipping -> True, ImagePadding -> All, DisplayFunction -> 
     Identity, AspectRatio -> NCache[GoldenRatio^(-1), 0.6180339887498948], 
     Axes -> {False, False}, AxesLabel -> {None, None}, 
     AxesOrigin -> {929.14, 0}, DisplayFunction :> Identity, 
     Frame -> {{True, True}, {True, True}}, FrameLabel -> {{None, None}, {
        FormBox["\"Semanas\"", TraditionalForm], 
        FormBox["\"S\[EAcute]rie Residual\"", TraditionalForm]}}, FrameStyle -> 
     Directive[18, 
       Thickness[Large]], 
     FrameTicks -> {{Automatic, Automatic}, {Automatic, Automatic}}, 
     GridLines -> {None, None}, GridLinesStyle -> Directive[
       GrayLevel[0.5, 0.4]], 
     Method -> {"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
           (Identity[#]& )[
            Part[#, 1]], 
           (Identity[#]& )[
            Part[#, 2]]}& ), "CopiedValueFunction" -> ({
           (Identity[#]& )[
            Part[#, 1]], 
           (Identity[#]& )[
            Part[#, 2]]}& )}}, 
     PlotRange -> {{929, 957}, {-3.181364457813751, 3.296932494096761}}, 
     PlotRangeClipping -> True, PlotRangePadding -> {{0, 0}, {
        Scaled[0.05], 
        Scaled[0.05]}}, Ticks -> {Automatic, Automatic}}],FormBox[
    FormBox[
     TemplateBox[{"\"Original\"", "\"Previs\[ATilde]o\""}, "LineLegend", 
      DisplayFunction -> (FormBox[
        StyleBox[
         StyleBox[
          PaneBox[
           TagBox[
            GridBox[{{
               TagBox[
                GridBox[{{
                   GraphicsBox[{{
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[3, 20], 0.15]], 
                    AbsoluteThickness[1.6], 
                    RGBColor[0, 0, 1]], {
                    LineBox[{{0, 10}, {20, 10}}]}}, {
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[3, 20], 0.15]], 
                    AbsoluteThickness[1.6], 
                    RGBColor[0, 0, 1]], {}}}, AspectRatio -> Full, 
                    ImageSize -> {20, 10}, PlotRangePadding -> None, 
                    ImagePadding -> Automatic, 
                    BaselinePosition -> (Scaled[0.1] -> Baseline)], #}, {
                   GraphicsBox[{{
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[3, 20], 0.15]], 
                    AbsoluteThickness[1.6], 
                    RGBColor[1, 0, 0]], {
                    LineBox[{{0, 10}, {20, 10}}]}}, {
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[3, 20], 0.15]], 
                    AbsoluteThickness[1.6], 
                    RGBColor[1, 0, 0]], {}}}, AspectRatio -> Full, 
                    ImageSize -> {20, 10}, PlotRangePadding -> None, 
                    ImagePadding -> Automatic, 
                    BaselinePosition -> (Scaled[0.1] -> Baseline)], #2}}, 
                 GridBoxAlignment -> {
                  "Columns" -> {Center, Left}, "Rows" -> {{Baseline}}}, 
                 AutoDelete -> False, 
                 GridBoxDividers -> {
                  "Columns" -> {{False}}, "Rows" -> {{False}}}, 
                 GridBoxItemSize -> {"Columns" -> {{All}}, "Rows" -> {{All}}},
                  GridBoxSpacings -> {
                  "Columns" -> {{0.5}}, "Rows" -> {{0.8}}}], "Grid"]}}, 
             GridBoxAlignment -> {"Columns" -> {{Left}}, "Rows" -> {{Top}}}, 
             AutoDelete -> False, 
             GridBoxItemSize -> {
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}, 
             GridBoxSpacings -> {"Columns" -> {{1}}, "Rows" -> {{0}}}], 
            "Grid"], Alignment -> Left, AppearanceElements -> None, 
           ImageMargins -> {{5, 5}, {5, 5}}, ImageSizeAction -> 
           "ResizeToFit"], LineIndent -> 0, StripOnInput -> False], {
         FontFamily -> "Arial"}, Background -> Automatic, StripOnInput -> 
         False], TraditionalForm]& ), 
      InterpretationFunction :> (RowBox[{"LineLegend", "[", 
         RowBox[{
           RowBox[{"{", 
             RowBox[{
               RowBox[{"Directive", "[", 
                 RowBox[{
                   RowBox[{"PointSize", "[", 
                    FractionBox["1", "120"], "]"}], ",", 
                   RowBox[{"AbsoluteThickness", "[", "1.6`", "]"}], ",", 
                   InterpretationBox[
                    ButtonBox[
                    TooltipBox[
                    GraphicsBox[{{
                    GrayLevel[0], 
                    RectangleBox[{0, 0}]}, {
                    GrayLevel[0], 
                    RectangleBox[{1, -1}]}, {
                    RGBColor[0, 0, 1], 
                    RectangleBox[{0, -1}, {2, 1}]}}, DefaultBaseStyle -> 
                    "ColorSwatchGraphics", AspectRatio -> 1, Frame -> True, 
                    FrameStyle -> RGBColor[0., 0., 0.6666666666666666], 
                    FrameTicks -> None, PlotRangePadding -> None, ImageSize -> 
                    Dynamic[{
                    Automatic, 
                    1.35 (CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[
                    Magnification])}]], 
                    StyleBox[
                    RowBox[{"RGBColor", "[", 
                    RowBox[{"0", ",", "0", ",", "1"}], "]"}], NumberMarks -> 
                    False]], Appearance -> None, BaseStyle -> {}, 
                    BaselinePosition -> Baseline, DefaultBaseStyle -> {}, 
                    ButtonFunction :> With[{Typeset`box$ = EvaluationBox[]}, 
                    If[
                    Not[
                    AbsoluteCurrentValue["Deployed"]], 
                    SelectionMove[Typeset`box$, All, Expression]; 
                    FrontEnd`Private`$ColorSelectorInitialAlpha = 1; 
                    FrontEnd`Private`$ColorSelectorInitialColor = 
                    RGBColor[0, 0, 1]; 
                    FrontEnd`Private`$ColorSelectorUseMakeBoxes = True; 
                    MathLink`CallFrontEnd[
                    FrontEnd`AttachCell[Typeset`box$, 
                    FrontEndResource["RGBColorValueSelector"], {
                    0, {Left, Bottom}}, {Left, Top}, 
                    "ClosingActions" -> {
                    "SelectionDeparture", "ParentChanged", 
                    "EvaluatorQuit"}]]]], BaseStyle -> Inherited, Evaluator -> 
                    Automatic, Method -> "Preemptive"], 
                    RGBColor[0, 0, 1], Editable -> False, Selectable -> 
                    False]}], "]"}], ",", 
               RowBox[{"Directive", "[", 
                 RowBox[{
                   RowBox[{"PointSize", "[", 
                    FractionBox["1", "120"], "]"}], ",", 
                   RowBox[{"AbsoluteThickness", "[", "1.6`", "]"}], ",", 
                   InterpretationBox[
                    ButtonBox[
                    TooltipBox[
                    GraphicsBox[{{
                    GrayLevel[0], 
                    RectangleBox[{0, 0}]}, {
                    GrayLevel[0], 
                    RectangleBox[{1, -1}]}, {
                    RGBColor[1, 0, 0], 
                    RectangleBox[{0, -1}, {2, 1}]}}, DefaultBaseStyle -> 
                    "ColorSwatchGraphics", AspectRatio -> 1, Frame -> True, 
                    FrameStyle -> RGBColor[0.6666666666666666, 0., 0.], 
                    FrameTicks -> None, PlotRangePadding -> None, ImageSize -> 
                    Dynamic[{
                    Automatic, 
                    1.35 (CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[
                    Magnification])}]], 
                    StyleBox[
                    RowBox[{"RGBColor", "[", 
                    RowBox[{"1", ",", "0", ",", "0"}], "]"}], NumberMarks -> 
                    False]], Appearance -> None, BaseStyle -> {}, 
                    BaselinePosition -> Baseline, DefaultBaseStyle -> {}, 
                    ButtonFunction :> With[{Typeset`box$ = EvaluationBox[]}, 
                    If[
                    Not[
                    AbsoluteCurrentValue["Deployed"]], 
                    SelectionMove[Typeset`box$, All, Expression]; 
                    FrontEnd`Private`$ColorSelectorInitialAlpha = 1; 
                    FrontEnd`Private`$ColorSelectorInitialColor = 
                    RGBColor[1, 0, 0]; 
                    FrontEnd`Private`$ColorSelectorUseMakeBoxes = True; 
                    MathLink`CallFrontEnd[
                    FrontEnd`AttachCell[Typeset`box$, 
                    FrontEndResource["RGBColorValueSelector"], {
                    0, {Left, Bottom}}, {Left, Top}, 
                    "ClosingActions" -> {
                    "SelectionDeparture", "ParentChanged", 
                    "EvaluatorQuit"}]]]], BaseStyle -> Inherited, Evaluator -> 
                    Automatic, Method -> "Preemptive"], 
                    RGBColor[1, 0, 0], Editable -> False, Selectable -> 
                    False]}], "]"}]}], "}"}], ",", 
           RowBox[{"{", 
             RowBox[{#, ",", #2}], "}"}], ",", 
           RowBox[{"LegendMarkers", "\[Rule]", 
             RowBox[{"{", 
               RowBox[{
                 RowBox[{"{", 
                   RowBox[{"False", ",", "Automatic"}], "}"}], ",", 
                 RowBox[{"{", 
                   RowBox[{"False", ",", "Automatic"}], "}"}]}], "}"}]}], ",", 
           RowBox[{"Joined", "\[Rule]", 
             RowBox[{"{", 
               RowBox[{"True", ",", "True"}], "}"}]}], ",", 
           RowBox[{"LabelStyle", "\[Rule]", 
             RowBox[{"{", "}"}]}], ",", 
           RowBox[{"LegendLayout", "\[Rule]", "\"Column\""}]}], "]"}]& ), 
      Editable -> True], TraditionalForm], TraditionalForm]},
  "Legended",
  DisplayFunction->(GridBox[{{
      TagBox[
       ItemBox[
        PaneBox[
         TagBox[#, "SkipImageSizeLevel"], Alignment -> {Center, Baseline}, 
         BaselinePosition -> Baseline], DefaultBaseStyle -> "Labeled"], 
       "SkipImageSizeLevel"], 
      ItemBox[#2, DefaultBaseStyle -> "LabeledLabel"]}}, 
    GridBoxAlignment -> {"Columns" -> {{Center}}, "Rows" -> {{Center}}}, 
    AutoDelete -> False, GridBoxItemSize -> Automatic, 
    BaselinePosition -> {1, 1}]& ),
  Editable->True,
  InterpretationFunction->(RowBox[{"Legended", "[", 
     RowBox[{#, ",", 
       RowBox[{"Placed", "[", 
         RowBox[{#2, ",", "After"}], "]"}]}], "]"}]& )]], "Output",ExpressionU\
UID->"b11e024a-387b-49ff-8710-148c2abf770a"]
}, Open  ]],

Cell["\<\
Podemos ver que o modelo \[EAcute] inst\[AAcute]vel, n\[ATilde]o capturando a \
magnitude das amplitudes da s\[EAcute]rie tempSC3. Pouqu\[IAcute]ssimos \
pontos futuros t\[EHat]m uma predi\[CCedilla]\[ATilde]o confi\[AAcute]vel. \
Abaixo mostro em um outro exemplo que uma s\[EAcute]rie no regime estacion\
\[AAcute]rio apresenta resultados mais consistentes.\
\>", "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"48efee99-2695-4a3f-ba37-1019fcfe4449"]
}, Closed]],

Cell[CellGroupData[{

Cell["Carga de Energia - Submercado Sudeste / Centro-Oeste", "Subsection",ExpressionUUID->"82e3e2ff-848c-4b62-bbdc-b28753b12867"],

Cell[TextData[{
 "Vamos usar uma s\[EAcute]rie disponibilizada pelo Operador Nacional do \
Sistema El\[EAcute]trico (ONS). A s\[EAcute]rie representa a carga de energia \
m\[EAcute]dia por semana operacional para o submercado Sudeste / \
Centro-Oeste. Por \[OpenCurlyDoubleQuote]carga de energia\
\[CloseCurlyDoubleQuote] entenda-se demanda m\[EAcute]dia requerida de uma \
instala\[CCedilla]\[ATilde]o ou conjunto de instala\[CCedilla]\[OTilde]es \
durante um per\[IAcute]odo de refer\[EHat]ncia. Sua unidade \[EAcute] o ",
 StyleBox["MWmed",
  FontSlant->"Italic"],
 "."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"8f4eb3c9-0137-42e9-9217-7ad3ae66b84f"],

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", 
   RowBox[{
    RowBox[{"SetDirectory", "[", 
     RowBox[{"NotebookDirectory", "[", "]"}], "]"}], ";", 
    "\[IndentingNewLine]", 
    RowBox[{"cargaEnergiaRaw", "=", 
     RowBox[{"Import", "[", "\"\<Sudeste_Carga_de_Energia.csv\>\"", "]"}]}], 
    ";", "\[IndentingNewLine]", 
    RowBox[{"cargaEnergia", " ", "=", " ", 
     RowBox[{"Reverse", "[", 
      RowBox[{"Rest", "[", 
       RowBox[{"cargaEnergiaRaw", "[", 
        RowBox[{"[", 
         RowBox[{"All", ",", "9"}], "]"}], "]"}], "]"}], "]"}]}]}], "*)"}], 
  "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"cargaEnergia", "=", 
    RowBox[{"{", 
     RowBox[{
     "20000.7595238`", ",", "19703.20654761`", ",", "19998.82559523`", ",", 
      "20105.58154761`", ",", "19674.00595238`", ",", "20121.22797619`", ",", 
      "20135.97619047`", ",", "20427.24023809`", ",", "20651.89404761`", ",", 
      "20644.42142857`", ",", "20906.59636904`", ",", "20445.24940476`", ",", 
      "21111.66190476`", ",", "20854.40642857`", ",", "20505.88898809`", ",", 
      "20719.61653726`", ",", "20886.7597619`", ",", "21112.31607142`", ",", 
      "20998.87380952`", ",", "21136.64345238`", ",", "21515.28511904`", ",", 
      "22453.20059523`", ",", "22030.7720238`", ",", "22711.79380952`", ",", 
      "22075.29803571`", ",", "19297.72303571`", ",", "19791.16244069`", ",", 
      "22772.34208315`", ",", "22396.5129174`", ",", "22627.28696422`", ",", 
      "24119.02095183`", ",", "23214.61428435`", ",", "22310.38541739`", ",", 
      "23970.9701782`", ",", "24343.61898779`", ",", "25311.89601133`", ",", 
      "25996.67499992`", ",", "25673.80690457`", ",", "24421.43196371`", ",", 
      "25471.68595279`", ",", "25344.38720221`", ",", "25786.27196571`", ",", 
      "25919.74089216`", ",", "24933.81904792`", ",", "25361.8475599`", ",", 
      "25365.73916617`", ",", "24763.25351145`", ",", "23510.47619049`", ",", 
      "24754.11029822`", ",", "25307.4815461`", ",", "24907.96779752`", ",", 
      "24304.7159515`", ",", "24456.00833239`", ",", "23828.22875038`", ",", 
      "23985.77020074`", ",", "24346.02693104`", ",", "24311.64143034`", ",", 
      "24817.70105512`", ",", "25173.53258087`", ",", "25374.65464291`", ",", 
      "25308.68613097`", ",", "24444.60017899`", ",", "24905.46976186`", ",", 
      "25802.43880987`", ",", "24830.50327368`", ",", "25999.34374976`", ",", 
      "27160.2417858`", ",", "27268.03750082`", ",", "27138.14684427`", ",", 
      "26883.49583447`", ",", "25511.19810006`", ",", "26002.3761304`", ",", 
      "26853.94458329`", ",", "27234.34660712`", ",", "27626.58029767`", ",", 
      "26512.01624967`", ",", "26198.61565399`", ",", "23856.51982199`", ",", 
      "23289.23339208`", ",", "25813.62535544`", ",", "25807.56761814`", ",", 
      "26319.03529681`", ",", "25698.47238163`", ",", "27049.44797695`", ",", 
      "27808.08869163`", ",", "27211.9300003`", ",", "27976.44922596`", ",", 
      "26114.37315368`", ",", "27206.63821648`", ",", "26885.34791588`", ",", 
      "26026.56297592`", ",", "26672.38626837`", ",", "26313.6151964`", ",", 
      "25087.20007173`", ",", "25725.84998836`", ",", "26429.87129749`", ",", 
      "25086.26267937`", ",", "25417.83124879`", ",", "25929.02797651`", ",", 
      "25078.53077517`", ",", "25578.82529768`", ",", "26030.28422612`", ",", 
      "24969.76124961`", ",", "25223.5166087`", ",", "25042.22904883`", ",", 
      "25150.26589263`", ",", "24891.98636806`", ",", "25403.48636957`", ",", 
      "25571.57374981`", ",", "25974.0100601`", ",", "25509.28672626`", ",", 
      "25339.7949998`", ",", "25636.83059533`", ",", "25425.00851181`", ",", 
      "26168.85386802`", ",", "25813.52738025`", ",", "26940.93136936`", ",", 
      "26506.78517885`", ",", "27160.15089282`", ",", "25866.55750038`", ",", 
      "26723.10668689`", ",", "26829.4856541`", ",", "25677.55708012`", ",", 
      "27071.7242679`", ",", "26760.91719254`", ",", "27396.48017808`", ",", 
      "27536.52732017`", ",", "27332.4706549`", ",", "27849.29744165`", ",", 
      "24906.40488138`", ",", "23710.37994014`", ",", "25477.52892749`", ",", 
      "26856.12559616`", ",", "26557.78511805`", ",", "27432.31958298`", ",", 
      "28026.66190397`", ",", "26638.75244012`", ",", "27637.03190477`", ",", 
      "25503.20636954`", ",", "27301.84904736`", ",", "27891.78166769`", ",", 
      "27512.92178537`", ",", "26842.87476203`", ",", "27443.61351318`", ",", 
      "27047.5653589`", ",", "27318.16559516`", ",", "27587.01547643`", ",", 
      "26926.28077374`", ",", "27067.14029795`", ",", "26889.86648793`", ",", 
      "26541.39345139`", ",", "26573.71148821`", ",", "26650.60488036`", ",", 
      "25744.67315465`", ",", "26424.22160645`", ",", "26761.54785608`", ",", 
      "27119.70791999`", ",", "26963.50040696`", ",", "26767.89660735`", ",", 
      "26340.04749878`", ",", "26294.64464324`", ",", "26900.39529762`", ",", 
      "26733.67815432`", ",", "27100.28422638`", ",", "27914.17029715`", ",", 
      "27841.25357254`", ",", "27390.42618999`", ",", "28135.35422669`", ",", 
      "28862.3614881`", ",", "29095.44913674`", ",", "27473.62720278`", ",", 
      "27518.71744095`", ",", "28354.02779945`", ",", "28143.25392793`", ",", 
      "27982.58492411`", ",", "28476.84243996`", ",", "27573.6799394`", ",", 
      "28279.61119184`", ",", "28264.27876146`", ",", "28953.36107046`", ",", 
      "28277.02898888`", ",", "27322.21779724`", ",", "25698.99011932`", ",", 
      "26738.7677975`", ",", "28439.89220298`", ",", "28725.31500059`", ",", 
      "28128.45148609`", ",", "27773.47523853`", ",", "26067.44452232`", ",", 
      "28748.86089397`", ",", "29793.40369059`", ",", "29262.00303647`", ",", 
      "29403.59869118`", ",", "30243.18351231`", ",", "28729.84369003`", ",", 
      "28833.01422881`", ",", "30408.95035723`", ",", "30706.63452083`", ",", 
      "29255.99428587`", ",", "28292.12839451`", ",", "27270.19654985`", ",", 
      "28486.96619142`", ",", "29193.76499862`", ",", "27245.29625032`", ",", 
      "27382.02738096`", ",", "27960.7585113`", ",", "28237.69795291`", ",", 
      "27597.74125077`", ",", "27561.41523721`", ",", "27574.79821509`", ",", 
      "26992.89452287`", ",", "27355.5757744`", ",", "27347.88684483`", ",", 
      "27685.84827367`", ",", "27931.18113064`", ",", "28482.4269656`", ",", 
      "28585.26779712`", ",", "29288.85293452`", ",", "27766.26647023`", ",", 
      "28538.84730357`", ",", "28365.0238869`", ",", "27730.28750595`", ",", 
      "28718.1485238`", ",", "29036.31643452`", ",", "29418.45547101`", ",", 
      "29798.4388988`", ",", "27464.78308928`", ",", "28115.75996428`", ",", 
      "27823.81903571`", ",", "29329.51755357`", ",", "28965.38005952`", ",", 
      "28400.80321428`", ",", "28636.21529761`", ",", "28788.75092857`", ",", 
      "26578.86333333`", ",", "27063.27005952`", ",", "29169.79732142`", ",", 
      "30249.83755952`", ",", "30882.21773809`", ",", "29689.84771428`", ",", 
      "31056.04910119`", ",", "29949.81783333`", ",", "30851.3655238`", ",", 
      "28988.17969642`", ",", "30812.54232142`", ",", "30285.3072619`", ",", 
      "30890.73089285`", ",", "30206.97315476`", ",", "29562.40208333`", ",", 
      "29304.72291666`", ",", "28058.48303571`", ",", "29743.86779761`", ",", 
      "28141.20672619`", ",", "28378.95053571`", ",", "28070.42803571`", ",", 
      "28446.76773809`", ",", "28758.41547619`", ",", "28614.84934523`", ",", 
      "27848.2947619`", ",", "28473.80071428`", ",", "28453.67630952`", ",", 
      "28401.93613095`", ",", "29137.86845238`", ",", "28708.04176785`", ",", 
      "29210.46118452`", ",", "28815.38279761`", ",", "29656.05303571`", ",", 
      "30377.36505952`", ",", "29319.02125`", ",", "29285.39714285`", ",", 
      "27651.71`", ",", "29770.02008333`", ",", "29859.9338869`", ",", 
      "29006.07178571`", ",", "29488.08069047`", ",", "28853.65144642`", ",", 
      "29489.60440476`", ",", "29131.86547619`", ",", "29548.13928571`", ",", 
      "29450.72887681`", ",", "28671.75488095`", ",", "30256.9725`", ",", 
      "30910.60886904`", ",", "30474.656875`", ",", "30350.32488095`", ",", 
      "30975.25744047`", ",", "28135.42607142`", ",", "27148.58708333`", ",", 
      "30153.79839285`", ",", "30252.00869047`", ",", "30567.20458333`", ",", 
      "31135.90160714`", ",", "31356.34589285`", ",", "30825.115`", ",", 
      "29909.36154761`", ",", "32098.44190476`", ",", "32634.96535119`", ",", 
      "32900.16645833`", ",", "32044.02547023`", ",", "32979.43444642`", ",", 
      "32215.84515476`", ",", "31178.66345238`", ",", "31842.43523809`", ",", 
      "31844.88369047`", ",", "28983.04357142`", ",", "29989.47773809`", ",", 
      "30472.63970238`", ",", "29961.20107142`", ",", "29122.15928571`", ",", 
      "28458.1320238`", ",", "29762.96892857`", ",", "30034.38261904`", ",", 
      "29951.43160714`", ",", "29620.6307738`", ",", "29512.46857142`", ",", 
      "29840.39619047`", ",", "30010.11041666`", ",", "29268.7882738`", ",", 
      "30283.80238095`", ",", "30388.61565476`", ",", "30485.86204761`", ",", 
      "30988.4375`", ",", "30614.80925`", ",", "31013.63360714`", ",", 
      "32016.74095238`", ",", "31740.6652738`", ",", "31429.75489285`", ",", 
      "31818.42541666`", ",", "32061.18263975`", ",", "31623.00428571`", ",", 
      "32187.46839285`", ",", "31441.69690476`", ",", "30883.79755952`", ",", 
      "30810.79886904`", ",", "31591.12047619`", ",", "32464.37017857`", ",", 
      "32781.88119047`", ",", "31713.04535714`", ",", "28919.21720238`", ",", 
      "30027.96071428`", ",", "31823.12440476`", ",", "31971.03672619`", ",", 
      "30859.90936904`", ",", "30315.53821428`", ",", "28927.26683333`", ",", 
      "32339.75801785`", ",", "32569.29089285`", ",", "32131.06273809`", ",", 
      "33274.59732142`", ",", "33037.03071428`", ",", "31239.50839285`", ",", 
      "32191.53940476`", ",", "32205.47773809`", ",", "32233.40065476`", ",", 
      "32681.60785714`", ",", "31289.81511904`", ",", "31262.53375`", ",", 
      "30615.20505952`", ",", "31025.40083333`", ",", "30783.50041666`", ",", 
      "31503.2407738`", ",", "30792.12773809`", ",", "31794.5170238`", ",", 
      "31443.58023809`", ",", "31285.89494047`", ",", "31352.45428571`", ",", 
      "30640.32886904`", ",", "30934.97404761`", ",", "31639.98434523`", ",", 
      "31699.97422619`", ",", "32154.84386904`", ",", "32339.48136904`", ",", 
      "32997.3385119`", ",", "32615.85767857`", ",", "32188.82755952`", ",", 
      "32985.31619047`", ",", "31922.74053571`", ",", "31339.23291666`", ",", 
      "31741.52369047`", ",", "31875.30040476`", ",", "33397.9797619`", ",", 
      "32626.2250414`", ",", "33620.67809523`", ",", "32359.22017857`", ",", 
      "31709.37767857`", ",", "30250.60034523`", ",", "30458.77690476`", ",", 
      "30402.98660714`", ",", "30871.8`", ",", "28989.00547619`", ",", 
      "26603.14232142`", ",", "25682.11630952`", ",", "28309.09017857`", ",", 
      "31139.69928571`", ",", "30203.11630952`", ",", "30169.13684523`", ",", 
      "31569.4135119`", ",", "31943.66625`", ",", "31666.15214285`", ",", 
      "29924.17232142`", ",", "33589.44422619`", ",", "33029.33220238`", ",", 
      "31957.34392857`", ",", "31290.02291666`", ",", "31254.49029761`", ",", 
      "30455.81833333`", ",", "30221.07071428`", ",", "29053.41089285`", ",", 
      "29547.00583333`", ",", "29435.31494047`", ",", "30733.13392857`", ",", 
      "29755.41011904`", ",", "30535.5775`", ",", "29031.765`", ",", 
      "28756.74089285`", ",", "28680.26267857`", ",", "29534.71940476`", ",", 
      "29796.19482142`", ",", "29566.91494047`", ",", "29740.46065476`", ",", 
      "30087.38261904`", ",", "30402.97422619`", ",", "30696.54113095`", ",", 
      "30689.57761904`", ",", "31493.2075`", ",", "30487.17571428`", ",", 
      "31842.11208333`", ",", "31311.94011904`", ",", "32260.39583333`", ",", 
      "31751.65875`", ",", "31782.51877857`", ",", "32220.31595238`", ",", 
      "31099.65595238`", ",", "32138.18012681`", ",", "32424.91279761`", ",", 
      "32118.76482142`", ",", "33309.79940476`", ",", "33925.55154761`", ",", 
      "34997.80738095`", ",", "34742.25190476`", ",", "32860.64625`", ",", 
      "33180.42220238`", ",", "31051.945`", ",", "29669.29174367`", ",", 
      "32789.19810515`", ",", "34508.58781057`", ",", "34496.59566223`", ",", 
      "34231.86591086`", ",", "35822.83763539`", ",", "35927.0385119`", ",", 
      "33715.83738095`", ",", "35999.2872619`", ",", "33168.28059523`", ",", 
      "34843.01422619`", ",", "35142.49744047`", ",", "35320.44458333`", ",", 
      "33898.65107142`", ",", "31933.93404761`", ",", "32219.72232142`", ",", 
      "33510.18255952`", ",", "34100.0435119`", ",", "32842.47440476`", ",", 
      "31902.67714285`", ",", "32323.46797619`", ",", "32497.71398809`", ",", 
      "31260.22761904`", ",", "31552.50291666`", ",", "31711.19958333`", ",", 
      "32624.64166666`", ",", "32208.07005952`", ",", "32115.90791666`", ",", 
      "32687.30767857`", ",", "32315.19428571`", ",", "32556.40833333`", ",", 
      "32571.27744047`", ",", "32590.58797619`", ",", "32329.55791666`", ",", 
      "33653.35416666`", ",", "34264.20011904`", ",", "32508.33898809`", ",", 
      "34252.19303571`", ",", "34538.24196428`", ",", "34372.76017857`", ",", 
      "33621.15922619`", ",", "31943.73982142`", ",", "33640.8213561`", ",", 
      "33848.74285714`", ",", "32518.2547619`", ",", "33725.01571428`", ",", 
      "31999.5285119`", ",", "34387.02761904`", ",", "35492.5520238`", ",", 
      "35960.65619047`", ",", "35617.90648809`", ",", "34357.73053571`", ",", 
      "30786.89232142`", ",", "32162.2845238`", ",", "35190.33553571`", ",", 
      "35499.86619047`", ",", "36435.17148809`", ",", "37082.00940476`", ",", 
      "37498.34011904`", ",", "37091.90161428`", ",", "37272.9507738`", ",", 
      "35356.0220238`", ",", "32635.18071428`", ",", "35390.29380952`", ",", 
      "35048.36944866`", ",", "36424.35699853`", ",", "35000.14607142`", ",", 
      "35814.60345238`", ",", "34477.50642857`", ",", "34134.92654761`", ",", 
      "34019.87761904`", ",", "34093.42880952`", ",", "32906.08220238`", ",", 
      "33073.81190476`", ",", "32773.9522619`", ",", "32770.20172619`", ",", 
      "32410.33392857`", ",", "32295.77113095`", ",", "32566.51422619`", ",", 
      "32720.71678571`", ",", "32775.55648809`", ",", "33770.65910714`", ",", 
      "33399.1432738`", ",", "33933.08892857`", ",", "34529.44232142`", ",", 
      "35019.09035714`", ",", "34437.45565476`", ",", "34948.65892857`", ",", 
      "33952.65315476`", ",", "34940.92267857`", ",", "35133.93095238`", ",", 
      "35250.5297619`", ",", "35299.6035119`", ",", "35175.22922619`", ",", 
      "33743.72567028`", ",", "34792.54005952`", ",", "33094.30583333`", ",", 
      "35366.15321428`", ",", "34302.08791666`", ",", "35351.03172619`", ",", 
      "35507.16315476`", ",", "35782.33285714`", ",", "35986.83017857`", ",", 
      "36160.76875`", ",", "32785.98559523`", ",", "32570.21130952`", ",", 
      "34753.27446428`", ",", "35926.8832738`", ",", "36579.65517857`", ",", 
      "36066.35880952`", ",", "38979.11589285`", ",", "37489.85553571`", ",", 
      "35487.50994047`", ",", "39233.84005952`", ",", "38856.97773809`", ",", 
      "38336.97559523`", ",", "37287.79875`", ",", "37659.6525`", ",", 
      "36433.19232142`", ",", "37254.0110119`", ",", "37092.59208333`", ",", 
      "36001.97392857`", ",", "33686.76854166`", ",", "34515.80297619`", ",", 
      "34181.7135119`", ",", "33405.7770238`", ",", "34542.55773652`", ",", 
      "33943.91869066`", ",", "33644.49571466`", ",", "34498.15969009`", ",", 
      "33948.36111238`", ",", "34123.10512576`", ",", "33230.62428571`", ",", 
      "33257.77940476`", ",", "34224.74`", ",", "34641.89347823`", ",", 
      "34509.47757942`", ",", "34727.90836233`", ",", "34695.32330961`", ",", 
      "34422.93984838`", ",", "34442.69067261`", ",", "36402.11682142`", ",", 
      "37384.97261904`", ",", "34696.72953571`", ",", "36030.70168452`", ",", 
      "36397.11110714`", ",", "35154.06048809`", ",", "37082.36618892`", ",", 
      "37453.58524404`", ",", "35143.83397619`", ",", "33729.40200595`", ",", 
      "33781.18735266`", ",", "35410.53972616`", ",", "37354.1588869`", ",", 
      "38699.90879166`", ",", "37628.80650595`", ",", "35262.32119047`", ",", 
      "33984.33147619`", ",", "37670.88000595`", ",", "35380.15686309`", ",", 
      "36157.21656547`", ",", "36501.87028571`", ",", "36824.69440476`", ",", 
      "36491.26280357`", ",", "40253.723625`", ",", "39191.45417857`", ",", 
      "39305.92054761`", ",", "39687.97711309`", ",", "37080.85055952`", ",", 
      "36031.69597619`", ",", "36510.58721428`", ",", "36783.1120238`", ",", 
      "35315.55253571`", ",", "34539.86519642`", ",", "34735.46747023`", ",", 
      "34895.50036309`", ",", "35311.71328571`", ",", "34620.54791666`", ",", 
      "33643.14513052`", ",", "34009.61618452`", ",", "34642.05648214`", ",", 
      "35068.41466071`", ",", "35143.75366071`", ",", "34497.11054761`", ",", 
      "33294.74025595`", ",", "34770.29799404`", ",", "34533.38088095`", ",", 
      "34082.60558928`", ",", "35608.30635714`", ",", "35154.1402619`", ",", 
      "35265.40785714`", ",", "35123.91510119`", ",", "35517.17509523`", ",", 
      "35532.95209523`", ",", "37037.15249404`", ",", "36434.62645833`", ",", 
      "36586.4564609`", ",", "34893.1957738`", ",", "35989.67558333`", ",", 
      "37244.78740424`", ",", "36378.47357142`", ",", "35509.03358333`", ",", 
      "36824.01892857`", ",", "37035.01875`", ",", "36539.01079166`", ",", 
      "37970.7907738`", ",", "37380.9982738`", ",", "36122.21136904`", ",", 
      "33050.76148809`", ",", "34725.28917261`", ",", "39518.49151785`", ",", 
      "40004.35945238`", ",", "39429.32548214`", ",", "41276.20549404`", ",", 
      "42691.66942616`", ",", "42476.40522023`", ",", "39013.58194649`", ",", 
      "40570.55511738`", ",", "37144.64811309`", ",", "39426.0592131`", ",", 
      "41462.53524973`", ",", "38309.74273809`", ",", "39029.21613095`", ",", 
      "38770.67005952`", ",", "36577.50189285`", ",", "35482.77092857`", ",", 
      "33806.23902976`", ",", "36188.68468452`", ",", "34839.05475492`", ",", 
      "35680.60521368`", ",", "34583.45723639`", ",", "34337.44567948`", ",", 
      "34888.36278709`", ",", "33420.11281048`", ",", "33663.2824375`", ",", 
      "33977.80869047`", ",", "33799.1653988`", ",", "33763.00304761`", ",", 
      "33807.37542261`", ",", "33414.59251785`", ",", "34213.71848214`", ",", 
      "34239.46658333`", ",", "34472.39548495`", ",", "35137.35106778`", ",", 
      "34992.98330357`", ",", "35266.67420238`", ",", "36147.31657142`", ",", 
      "35789.28582738`", ",", "36349.30652976`", ",", "34987.90343452`", ",", 
      "38763.24217261`", ",", "36982.07374042`", ",", "35970.71961309`", ",", 
      "37590.62685119`", ",", "36497.28316071`", ",", "34228.50720238`", ",", 
      "36891.12183333`", ",", "36321.20342857`", ",", "36633.3412619`", ",", 
      "36243.07779166`", ",", "33971.03323349`", ",", "34907.69307142`", ",", 
      "39016.76850595`", ",", "42603.02864285`", ",", "42644.26441071`", ",", 
      "40352.74279761`", ",", "39508.13106494`", ",", "39290.81472624`", ",", 
      "37251.7434891`", ",", "40638.60432011`", ",", "39369.8382854`", ",", 
      "38599.30350595`", ",", "38187.66911904`", ",", "37153.06003571`", ",", 
      "36828.92550595`", ",", "35916.14306595`", ",", "36750.83586029`", ",", 
      "35785.45663095`", ",", "33572.67144642`", ",", "33573.0600238`", ",", 
      "33205.81014285`", ",", "33231.2902619`", ",", "34322.70086309`", ",", 
      "32257.86771965`", ",", "33231.16367261`", ",", "33232.63759523`", ",", 
      "31770.62798214`", ",", "31955.95373809`", ",", "31963.14806547`", ",", 
      "33292.82291666`", ",", "32927.8543869`", ",", "33121.76491071`", ",", 
      "33764.88036904`", ",", "33849.90357738`", ",", "34439.74407753`", ",", 
      "34266.0463988`", ",", "34489.26770238`", ",", "33163.32771428`", ",", 
      "35003.6100238`", ",", "37624.22804761`", ",", "36540.91971428`", ",", 
      "36235.35691666`", ",", "36656.19445238`", ",", "37645.20766925`", ",", 
      "35882.8958988`", ",", "35516.23842857`", ",", "37103.92740476`", ",", 
      "37066.129875`", ",", "36118.89272023`", ",", "36201.01349404`", ",", 
      "36502.93122023`", ",", "38240.97705952`", ",", "36019.00413095`", ",", 
      "34442.68216468`", ",", "36265.28621284`", ",", "38242.21717639`", ",", 
      "35315.05839384`", ",", "37654.96776066`", ",", "39941.29675164`", ",", 
      "37879.49124582`", ",", "40016.13750369`", ",", "39746.54203638`", ",", 
      "38510.26266601`", ",", "39000.72143316`", ",", "37926.00540911`", ",", 
      "38022.56668545`", ",", "38792.27283975`", ",", "39264.02741727`", ",", 
      "39515.41707264`", ",", "38347.90520287`", ",", "36596.1329918`", ",", 
      "33404.58032885`", ",", "35286.78054761`", ",", "34304.37018452`", ",", 
      "33230.0188988`", ",", "34493.33985714`", ",", "34313.22548214`", ",", 
      "32143.26667261`", ",", "32751.93532738`", ",", "32545.18498809`", ",", 
      "33171.69551785`", ",", "33784.54874404`", ",", "33010.5626488`", ",", 
      "33557.71907738`", ",", "33535.14735774`", ",", "34133.90023214`", ",", 
      "34592.39319047`", ",", "33772.40655952`", ",", "34818.15430952`", ",", 
      "33669.89548214`", ",", "35663.99482142`", ",", "35143.86019047`", ",", 
      "34275.18464285`", ",", "33285.51841666`", ",", "33929.38422023`", ",", 
      "38131.757956`", ",", "36571.9917619`", ",", "34301.52910119`", ",", 
      "35752.20181547`", ",", "33262.82960714`", ",", "33809.64958333`", ",", 
      "35654.72642857`", ",", "35893.85264285`", ",", "35900.0931369`", ",", 
      "35131.98815476`", ",", "36453.26892857`", ",", "38143.383625`", ",", 
      "40404.47385714`", ",", "38472.59243089`", ",", "38465.50527976`", ",", 
      "39579.36643452`", ",", "39536.10522023`", ",", "40799.10110714`", ",", 
      "42088.4325119`", ",", "37953.97697619`", ",", "40866.24026785`", ",", 
      "41063.18275595`", ",", "37517.40092857`", ",", "37505.20795833`", ",", 
      "37290.23679761`", ",", "36867.14784523`", ",", "35395.46297619`", ",", 
      "35290.328`", ",", "33069.43648809`", ",", "34546.31594047`", ",", 
      "34775.80164821`", ",", "34701.31699404`", ",", "33954.08085714`", ",", 
      "35100.47394642`", ",", "33290.69108928`", ",", "33486.33482142`", ",", 
      "33209.51320238`", ",", "32500.01973809`", ",", "32782.49173809`", ",", 
      "32652.4530119`", ",", "33002.79763095`", ",", "32893.4751369`", ",", 
      "33514.81649404`", ",", "34039.51580952`", ",", "33560.10090476`", ",", 
      "34071.49717261`", ",", "33511.46267857`", ",", "36037.86963511`", ",", 
      "36639.16445892`", ",", "36252.25720833`", ",", "35257.79898214`", ",", 
      "36982.24827976`", ",", "37459.67450698`", ",", "36726.10018452`", ",", 
      "35231.0382619`", ",", "35733.66041071`", ",", "35773.30320238`", ",", 
      "35785.73924404`", ",", "36621.61079761`", ",", "36536.85075595`", ",", 
      "37303.42033333`", ",", "38392.05610327`", ",", "35874.70301785`", ",", 
      "35315.06515476`", ",", "37228.58968452`", ",", "40034.82309523`", ",", 
      "41921.83280357`", ",", "39052.16291666`", ",", "38253.29732142`", ",", 
      "37777.30070238`", ",", "39529.58460714`", ",", "39243.86898809`", ",", 
      "40467.07914285`", ",", "40773.49663095`", ",", "40437.15958928`", ",", 
      "38604.61404166`", ",", "38392.76434523`"}], "}"}]}], ";"}]}]], "Input",\
ExpressionUUID->"9f33aafe-db7c-4cee-8578-4273bae26b81"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ListLinePlot", "[", 
  RowBox[{"cargaEnergia", ",", 
   RowBox[{"PlotRange", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"All", ",", 
      RowBox[{"{", 
       RowBox[{"18000", ",", "44000"}], "}"}]}], "}"}]}], ",", 
   RowBox[{"Frame", "\[Rule]", "True"}], ",", 
   RowBox[{"FrameStyle", "\[Rule]", 
    RowBox[{"Directive", "[", 
     RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
   RowBox[{"FrameLabel", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"\"\<Carga de Energia (MWmed)\>\"", ",", "None"}], "}"}], ",", 
      
      RowBox[{"{", 
       RowBox[{
       "\"\<Semanas\>\"", ",", "\"\<Submercado Sudeste / Centro-Oeste\>\""}], 
       "}"}]}], "}"}]}]}], "]"}]], "Input",ExpressionUUID->"a1ab81cd-62a0-\
4f55-9fc2-04a1a59f4fb2"],

Cell[BoxData[
 GraphicsBox[{{}, {{}, {}, 
    {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
      NCache[
       Rational[1, 120], 0.008333333333333333]], AbsoluteThickness[1.6], 
     LineBox[CompressedData["
1:eJw9WXc81t8X1/wpDUmlojRJJaWByFtJWogSJT22UB578+xBCi2aKtH4krb2
0y4tqdASbRo0Sevn+/neU/94vTv33PM5933Wvc8g71Bnv7ZqamrB7dTU/v37
379Ga++jnTabKO6C/QeEMT3NbloRVscwXnrFYTlhTU7ut4OwNjz6yLwEEwnr
QDt8xAaHfMK6uLfhddzvPYT18Xltd97tT4QHc/t9N7rH8FDwlfub+40gPBzX
utQZ5QcRNsRbL+tvjk2kb4R5V3d51G8h+Shot7xru3EJYWNMn2v8MrYjYRMM
OOgW9Xoy4bFw4jVuK/YjPA4dt4kttLcSNsX9C8nvjgkJj8eIF87GI/IIT0CP
Dz7W5W3vMzyRO6857wlPwhhxReABMWEz1IddvvlpdAXD5njq2b7n3VUkt0DP
rEl2K6rKGZ6MyzuW+5W6kL+WCDte/KKXFelbYadg5139p6Q/BW1Gb1tSrkNy
a4xws1t4Lr2SYSDEIdSpYB+TC4CFhwr3Zl8jfRv0dPDvcyaQrRfYYN+35C2v
L5H+VNx8be32/VgVk0/F3CfjTEf6PGDyabim6ZIXocWwYBpq9WbvWvyA9G1R
L89/9fYp6dvC/MrbKzoqhtWmQ/rkWUCmMelPh+3ny0ENjrS/HTKaZgRHupO+
HVpqgqdEXyT9GdiyLcUh9BLJZ+BEb4V5mTHJ7eFQ+Dpu61fy3x7vp+l3l48i
+UycO5l/p/oo6c+ET1u/xl/OJJ8FodXw8tGn6HxmYecaiULtGfk3G9N2VO3s
Np3ksxGk0TwrLITkc9Cu2fK48DLJ52BK5diudadJPhd2s3tXh1iS/bm4qnWr
l/c6su8AG96+l3uukNwBk59m1o0kPtQcETFkwbLhT2l/RwR0Wavp+ff7nTD+
d1SvzePYecIJg2/vmJBrTfs5Ye7v33/uE58qJ9QNC47rLnvI9OehumKZf9vt
DGMenEQv/ZQChgXzYCZQnXwKhlXzcP7pvsIbdWTfGeetpFrZvmTfGcdju0Ym
mpO+M6y23zZen036zsivyB6yq4Xsu8Chm2XnNi9I3wWjfz/1L1hH8eKCQxEX
bAfNYf6rXFC84GWDwxnKh/m4Xl7eIXAC6c/HD/VHLi9MSX8+DNLnTj1/iPyf
jw4jBJO36lD8LUCAuGCfRxD5vwBZuwcWdjB8xPQXIKxloPRHFn3/AhRZDVDp
OjO5miv+NJ+t3SAg+65wa1BW7c4k/12xoQm2rjak74oJBjf+lxdE9hfCsHlr
iU4Xsr8QBSW8pQEH6fsXYu7u7zdvpLDzVi1El7UT/KMHkr4bRqx0vRBzm+y7
4emg07czaL3ADd8HGptGlZO+G2p+Lim1cSZ9d4wMNmvensTkcIetR+Gdwy2k
7w6J6rxJVjCdnzsu2DuV8L2J/0W436CnWbud9BdBFHJq96pI0l8EmdS7feZq
sr8ItSkF+n8cSH8xJt8v1H96i/QXQzRwXsmLZtJfDP0Bd/MES8j+YgT0Pe7u
/Df+PLCg0q720xnS90CeU5zhhE50fh7wGxCVhntk3wPoennXxFXk/xKs7ZOj
8vobP0uwfPKqTZMdib8lyCz1xMFnZH8JLi+22N3pb/544rVW76KdU0nfE9XW
X+9e1iF9T4xs+KK91JT494QRz7TApyfZX4p2qoBFH0KJ/6V47Gp/yGIw6S9F
TKXlyQHnSH8pRvbdcnbQC7LPw80TEwYOOMCwPg+3Dtl3chnH4hM8xGxYU5dD
9YLHQ0N4o1O2AdUTHmr2f3rgVcvkuTy8j7vYSd2C7PGgeWWpdXgD+94aHp6M
7BKpXUr2vaAZu8Njryezp++FVxtbDIrbkT9eaJh7ovPUXwzzvDBnveGEm6+J
Xy/8OlXqGr2HyXO9YP62suMnS7afygtSTcVvi2omr/HC7tq+P49NJPve+Hj1
xrTXN8h/bwh0Ko1fLCP73hgWppuTWkj2vTH6YcYvVSOdrzdKgsc1Z84m+944
jbyWqyvIf2+EliojY6aSfW8YnHYwdn9L/PnAo6qDcvlnhvV90EXP42h+R7Lv
gxNWTdojhzI5zwf379ww7naL4tMH2z9pafoQ37k+cNy12uF9Atn3wfe6vR1r
5pN9HwRcb+f9fQj574tCZ7PO7Y6TfV+4l9y32VNI8egLmc+qOX2nk/++EPNq
/YP7k/++OFB5wUQrhuz7Iqb98FepU+n8fbF1nsLCyYThGl9Yeh2023SW7Pth
ckj+voo44t8PD35sHbxhzGNm3w+hHXefebyMYZ4f2g/qMzTwHtn3g214en3h
U7Lvh+FuMVeExWTfD8c/LEJZAtn3w2WFX+guF6q//pg2W1k/4TbZ90dmmr4k
+D2dvz90vC7qvd7C5Dx/SB0sKntspPruDye7K/0X2rHvy/XH81FfHtrQepU/
Tt/3aUwvovP3x44QPc+zf/tHAPT0s4cc0KX4C4C+/GHf75co/wLQw7LZcH5X
8j8ApXXDXurGkv0AdK52CPIcyHBuAPaf6RrxOJLqTQC2dniuM6kn068JAL9b
jwp3nSfMfiAqas6OFaxhcv1A5N7+4vTqKJ1/IGKC9p65rmDreYE4HNP+T1Q3
JhcEIuDLwDoYkv+B2DCooNzyIFuvCsRSm1+bdv9kuCYQO0y9dvzJZOvVlsFj
05ZJ6tvp/JchvHz62pV/54ll2KXUrjh9h85/GXIunfrKF5H9Zfj66sJX503E
/zI09NisEp6m+F+Gay3haSYOxP8y5BdN3ReyhvgPQnmPAn7oZzr/IEztY71m
UT3ZD0LRmS+9DlE88IKg8fCxtbkHxV8QYqsTH7w4SvaDsPSO5vnmw2Q/CIW7
9GZFdyL7QbjSlLfhuh3ZD8YgWYDLpjLyPxh9FOuHzKsn/oMxdV/8+okbif9g
3Bz+oGumHvEfjFMqM4uj1cR/MNa89ZDbHKL4C4bR4hT/LG2yH4y3TcuESg06
/xAUZUVDezHxH4JutaHDt5wg/kOg+bu+9+a+xH8InqQMHjCunPwPwRgzm52N
kWQ/BKPPaQd/GUn2QzC9bc5ArzyKvxBYGr10dptJ9pdDq/pxgOkp8n85YnJD
r3RtIv+XI/zwxO4meuT/csTxH+LYF6p/y5F9vMD+znI6/+W4G+z0v4hEtl61
HMemrNkYlUrxtxx1p4Mb0g2rmf0VsPL7jOjf5P8KOM2LG9puPpNjBRI2eS2M
tCb/V+BEw2nfSn0mF6zAlWXDBBqOFP8rcPiV75HBfZhctQJfykbvdVlD9lfg
zc1Pl4uMyH4oOr02sj+TwuT6oTAoOXkyp5rOPxS6Vra2xlvJ/1A4be5Wv9Wf
+A9F7s/fyiYNpp8bCudEtclzqd6pQqF+cs39U0eJ/1D8ft7gu2kZxR8fuh+3
Dj5whWFNPndf39iLzoOPGJ1/Fh/9yOQmfBi093qi9Xc+4EPc//WUiFsMO/E5
PoKvUb7yce5aZl0C8cvnY/Ws42tjIil/+Qjv7vJP204MZ/BxpGcXyRYZnScf
P9POpVQNYbiYz31/u2/ELx81GwcvWbiX+V/Gx4Wvhh7ntlO88TG86lqQew7D
jXx0rtzJf69G/ofBZ4PGTKEW09cMQ9Dqmxd/GBIfYRjbZ0i2xIXpm4SB76Fu
1OEG8RMGuMw5sGw0w06t8rmZRf4k54Whdso3n6ZwhvlhHH/qj8j/MIS9rd9V
dJ78D4OhSbNj4x/KpzC0fq7VlJXse4rDsP7Bkab8MRRfYcjjW3Xee578D0NF
zIPStTsp3sK495Yya7a+MQx7u5+zfUT9Vi0c2V8vZQ0Ts/zRDMf/XKp1IsLJ
/3DoxnmvUktj2CQc9YUv+tx8wDDC0Sn0w6HvAWx/p3Dsu9B/SO9tDPPCOT5m
9GOYHw7z9dlDFk5g+oJwLv43uz1l/ocjfbHT1dPVDOeGgx+c6yLVrGH+h8Ps
+dztbWYzuSocJaN/vlrej8nLwpH5q12fb1FMXhOOnc1q0XvDyf9w7Hjc+HCT
DpOrRXD+mfVlWDMCP688vXZ+LsV/BAyuTl3jOZP8j2i94T5rNKTzRgRs9yyq
njOVYacIXC8+NTaVT/xH4O7nnhGKUor/CO496owm+R+BN5n3ErPnM5wRgXPp
EdseUb3JjUCaVo6n4XuK/wiM+aH1S6+c4j8CddPHLO47lPhvxZ169JA7EP//
2R+3juI/AjdyJyz6nEX9PxJfzZ77GxRS/EdiyOlrI2MuEf+R3F/daez8TCKh
JVaVHnpJ/kdi/Lf26YEzif/W9YoLwWNs2XnyIhG3umqN0R/iPxL7+xo58Q9Q
/YxE7I2OFpu0iP9IzN3hWTzbkfiP5N6/VLVsfXEkdNsMb3mygviPhGFI740h
h5m8LBLnek3S+Ez1vSYSwzfv0z/Um/hv/b6LtUeuPKD6G4WvkW0O9DlM/EfB
bvHRcafasHjSj4LljkGvpzaT/1Eoup336qYV5X8UFp1dmPjLmfiP4t4jr/Qk
/6NgdavE/bwZw/woHDLtZ9oymPyPwlGHfuHPNhL/UYjqd6PnHWuqf1F4NmeJ
uHEt0y+OgrvGry3Ot8j/KIzd9qrdRR7DZVEQ37bRc7Fm318TBYl484/cQQw3
RqGHkUhZIyT/o1GTukn6LJT8j/4v3iMY1o/Gjccuee7xDJtEc+fhX88worn3
2MhVxH80Vp//arhDTvkfjU5NBwbepHjht9qrQIH7HPI/GtNz7nas6c5wRjT3
Pnr7AsO50VB5PR6lrkX8R3PzyPYu5H80179e/uU/Gtt9D9vFpRP/0dx7qt5W
4j8a1SdMuvR6R/Efg+XXrruemcDkmjE4Mlj85/dLhvVjOP5+fyH+Y2Ax63Ob
o/7kfwz+10d1q5r4cYpB/Jve9/fqsvPmxcBw9/gX3x4Q/zGIG3/q23g6b0EM
/sRNHmDUn63PiOH62/5RFP8xcJ/R/82tjeR/DGLVh0m8KJ9UMfj47J75XX3i
P4bL77MOxH8MnDS0A1Y9ZvLGGKy6+OXguiAmV4uFx6OAPrdyiP9Y7Dz1bKRb
E/kfi1n+3ULyaX4yiYX2mVslB85Q/seip13W0LPFFP+xMG3993kY8R/LnR9o
PuLHov/c6/2vtdD8FguDxC1hcm2GM1rXuyZemr6L+l8szj3QOfcukPz/b/2V
ZLpfxKI6Weu8fTTVv1iotrREL7pH/Lfu19rw68eS/7GwXXLklPIdxX8cNy9q
mFP9i8P5yr6Tivwp/+NQ8sx/+159hk3iuPrtOoH4j4MjPyZG+Df+46Bp0clr
m5T8j4Pf+aylX05T/Mfh15h1Mlsx1f84WMh6zFm0lPr/f+tVDyn/43BU66fB
vTNU/+PQecjMLPt2xH8c93vDw27kfxw8WhPwxR2q///hRneq/3HcPDSG5ju1
eNRePn5bsy3DmvEYN+1E56JK6n/xeDL1S0wXmv9N4rl+eeIp1b94WPXzTNCj
+dMpnutnVV40L8dz/J+h+ODHY8aR59sHt5D/8dw849tM9S8eCdpFM+aeo/yP
5+bL69SPilu/b/XSUXLq36p4rv78XEP5H49z8xYs6Cuk/h/P1aP6NsR/PNqo
7zPd3on6fwJuzM8w046h+E/A1+KBP+o8Kf4TIM0ZJ0/zpvqXgMN77YIt9hL/
CViZev9T8RLK/wRuvj0+jfI/Ab6jZuQfyGCY37p/lmbF8d61zP8EWGVt7H71
G+V/AmrjtYvWajCcm4CbGUWidFOafxJQNKM2/qcz8Z8Az7z3+5y/Mz7KEpC+
ucY1vy3lf6u+rtvtrAdU/xOw13Jv955VlP+JGHAg9ciPowxrJuLcyTc3Hyax
79NPRI1D0uTaVIZNEjFv8N3r8dFsPRJhWW09tm4NkzslQv3Bjhb1ceR/InIS
UiN57Zicn4jrdupvbxuS/4mouNPRops1wxmJ3H1lfjr5n8jdBxPGUP9L5H6P
+xBN/CfiT3d55SUPmv8Swe8R4SvMJ/8Tud/nHDuR/4mo/ubgus+A+E9CZYDz
5ycZxH8StPr9OLD8FPW/JJhEOGZ2o35mkoR7i6+N0S+j+2ESrht+v3SD6qVT
Ejd/jaB6y2uVv3uY0D6S6n8SVsY79G/xoPqfxM0fd9/S/JOEHfNHh95YRfU/
CasGDB7c7zr5nwTHf9adu/O3/ydx9WnXXar/SRiu/eawTxbFfxKXD/tWkP9J
EGvwAjqeJP6TOX97nSX/k1Fo7j5adpzqXyt+OvLMjCdU/5Ixoq23S/ZV4j8Z
lVIvnV3UT5yS8alxsnsD1VteMhLXr7Tvt5ziP5mr733kDAuSMfZRe4eMc+R/
MiomnxTkxhD/yRCvGXK31pr8T8Y4F5tnvFImVyVz9+vM+Sx+ypLR01D8R3s1
wzXJyHb83MbKl+HGZNSErOQdu0z+p3D96Lgm9f8U/HTcOSErkPhPwU7vI6dK
jSn+U5Dd8/6xhAUMIwUzNtxL9Cul+E+B9kSNuej/jPmfwn3vLEeG+Sm4YtLx
YaIuw4IU6I0+HTLAlOGMFGywCT4smMb2y03B9tzyjOt0HypO4eb1azOYXJUC
9T/Scg098j8F3saKEI1r5H8K4pq3/NO+D/mfgpwlCY53ExlWE8CqeM/44vvs
PNQFXL16spfqgQB+ssheiZsZ1hFw/b9wF8WHgIu/qT0YNhRw9dN8OMWLAMc+
vY89o8awmYCrB3aEIUBFQ6+l6/KZf/YCbn75qKR6KoBpk3Zd7k2G3QT4Z+Sd
p6O/UHy1fp+u6tZH2i9QwM0zC5Io3lrXNxxc94LmoVgBEk4IqnZkUvwJYIAU
A+PHDCsE3Lzm3ZfqkYCr50VlTJ4tgLPnx17rNIkfAXcf0F7L5Ltb7U9YJ9vS
ncmLBZixy6P0tAHDJa3fa3H7s9NE4k/A3fcjLBm+2rrfiPIFr0cRnwJ0qi02
a4pj+1cJuPtyj19U31rPq8X72jVDht8IuPn8oi3xLUBozsSy82eZvLnVn7xX
7WqnEv9Crv/5uTKsLsS89hfzS2MZ1hRCLb88Y1EWwzpCbMzJydHZTf1BiN9t
/iitqd8YChG6REeWTvXJpHU/p2VXDZuJfyHSg65Me0z9BEL4dzFvinzMsL2Q
mydmb6Z8EqLnO98jPurP/8NuQi5/Jzs8+w/zhBhXuGJeowtbHyjETsHFWgtD
tp7fqu+7febA72x9rBBPE3uaDSxhWCDEN0OP1d/HM6wQonX8qI30YThDyMXH
cMrvbCEXnyoTJs8VYvFpt09ZlM+7hcixDjGyXkv8C/99L9lQFc78LxEibOCP
A3EPqX4JufvC0WKGrwq597USR+pnQgyf2lJ1h+pvlRAJX+r8fmUR/0Js+vXi
8Wqqr2+EsPE11p1O/b1RiGsrJ69KW0P8C7HroMkSnz1U/0SI7zi85a455b+I
e98ws6L8F3HzSB+aD3REGLt76QbLesp/ES7tmG+/n+YLQxGUNXN7/PpC+S+C
sV+6W30j8S9C/RvLntW3KP9F6Bj+q6/rHYbtRZhjp3Z62mXiX8TdHwfasPN1
E6Fp+mK3Ph9pvhDBRMc0smID8S/CutUmq3ZeonlDBI0SSYONEcOxIoTfvXNs
NtVngQgpR+adODiTYYUIR+9/2N9C80mGCG3XTX4yKpbyX4SwNtd/70qm/iSC
6nro9Hmz2PrdIrxpyek13YrtVyyCs3W5dtJLhktEqMt4eStnKcMqEVZZjp1R
OonyX4QVXyI2dc4m/kX4aNl2xGNftr6q1d8zHTpI7ai+i+BzpN+H/AKG34hw
L8jrwclyyn8Rl9+9fzDcLIKD+vPAwDuU/2Ic3NJgcKyA5Yu6GL1Ttis+DGZY
U4x3U/WjrMYyrCPGuX0i2z88hvXFmJhzdVJ/Ok9DMR49Cp3+jfgwEUNjY1Rp
+V2GzcRcPX7+lfJfjFTPpUVhUyj/xegRULw/geLdSYxj+pKvH74y7CZGdOT3
to2d2HqeGLvSLe9+syL+xfgiUSgyX1P9F2PH+Td5vpQfsdz3HjPdRPVfjHY7
Dt2yoXhWiLFS+co2fSDx32pf85deM8VDthimQzcph1B+5Yrxa8ro4kobqv9i
dLxhpJzZQvM6Jzf5h/pLiRhdL/3kueRR/osxPKnwZicf4l+MUbKOSbYUr2Vi
lAQZdR1txnCVGBGzRPZJw4l/Me44em3ctZD4FyMsKCNmqzvxL8Z848m1eb0Y
P81ifHX9pDGf6pmaBIXPXTY5PKH6L+Hqcz6dr6YEog+8rUf+1n8JwnhB43LG
sP30JVx9dLzA5IYStHHX67md+omJBHm9NTepUfyZSbj+waPvgQTuqgA3XiXx
L+HmQfdUJneSIPTlo4/bwLCbBHZtlBfsdhL/EiyeruvpNoT6vwSP6l9hD9Uf
vgR+eeITt2ezeI2VQGvGDkGagmGBBAul7kF7wbBC0no/ClwjM3jxH86QoNOy
xuCoKoazJf+eb9PK0wznSlA+xWHbwS5Mf7cEPWTSC/NuM1wswZE9C09rD2Hf
XyKB2lOtlzZkTyXBgc4X9e9MYftdlfybXxePHWbryySwikyrz+/G1ldJkLNH
P2zBByavkaB/trC7CfXPNxJE+4bvc6N+2CiB9elB+VeEVP8l2C9qeLNuH/Ev
RYVPuqq2LfEvhat23ZKeIcS/FIcmFG3/8IzqvxTPN7eZZnyR6r8UT/d93qRB
8WIohf3xoZvF86j+SzHB80SnulCq/1IYVpTWmG+g+i/FxpBPs14KqP5LMWJu
kw4vkfJfivYzotu9o+93k0L4+/XXcieq/1Kct7n16+hh4l+K1yPw4cMx4l+K
0q5lBV1ovo2Vwjzl0+SRf++f0n/nj5iBdB9XSJFbrblmAeVbhhTN3osGBeVT
/ksxOjpl2J44mv+kuJXS5/aes1T/pdz5Jvai/i/F70s1ZwPeM75KpFBWa3uc
78awSor6/2n9b2EG5b8UmhZG3e8tYvIyKbZ1Keg+gup5lZT7fS+D+nGNFL/a
dn/l046tf9Pq//ZE0fBTxL8UiT23vjV6TvVfiogG2yTvg8S/DL2LrDW91lP/
l8FVL290tAbxL4NNac4Gna5U/2VQW5ZXz7vJ4lVfhg4RXaMV5QwbyuCU/Odi
n8NsvYkM1X33j5XMYthMBsEFS61FYxiGDMYFe0pjaJ6ylyFbf4Pr3Uomd5Jh
0uvJdy3Maf6TYbSu89G6KraeJ8OUBSHLonYxHCiDV9uyt4OGMsyXgV9wZssW
qj+xMnTV+LNGoiT+ZRin7Xn24UfiX4Y1opLNxsRvhgxPTJMS1/lS/5fBWv3Y
2+2Ec2U4ebD43fGJVP9l+O58d2YdzVPFMsxbEbvc9TzVfxmO/jmmiBHQ/V0G
/4W3LF/S+qsybNU1DtC2oP4vQ5jaY5PdHdn6Khl4iRqdf42n+72M+33v2kSG
38i4+/5G6keNMowfN2Thj56U/7J/5714s1E0/8kRcODHyM2Ub+pyaOr2r7ek
+7mmHIOKEm430f1HRw4t176JNvR+oC/Hy7XtMw0raf6Tw2v3jsSgsZT/cjzY
7iSNoPunmRweAqM5/6P5B3LY581ZseVv/ZfjQuLj4OADNP/JsWHcF7OOrxh2
kyPvh/mufC+mz5PjzlfTfR5S6v9y3P08fruc+iFfjtln5xT+0mPrY+XcvGPb
l2GBHJ3bG2U+3kH8y5HRNW2FfiHxL4eB56obTyj/suVY56JlO/Afpp/b6r9F
5SDeesp/OZ53mH1vAc2zxXLw7xUYjjhC97/W/V/1/2xH+io5hpz3qPai+eeq
HIPHv2yq9mbyMjk2zf6VvEdA9V8Of4OZJQ3JTF4jR+SQFf7tU5n8jRz7Cj3c
5gUy3CjHwpXnA67eZOub5Vj1u6VXHw0mV1Og/LjjKJWEydUV8JDNHFyewbCm
AkHL+51U/8iwjgIq4401aqNo/lNgU8lut+XUXw0VWNI2pCnxOFtvosCX9rE2
kmriX4Fvt7pmZdH9BgpY/ZjSUmVB/CvweHx6lYaK6r8CvwvubFRRfrgpcFhb
t2YvxRtPgaHOwycZnKP6r8A/v0f0uOND720KdF4a8PjHD4ZjFRg9s6pi9lV6
f1MgLL/IJpreKxUKTNzjuLpHCr3HKuDbzayN8wDKf8W/77Ftj3lT/itgu9bg
2IullP8Kbp48Re8nxQqYGbdf1+UF5b8CM3WVbdPpfUKlwClJv0ZbNeJfAeMR
pQWn+JT/Cu499M8yqv8KDDQqkv2g/lWjgN3A7Dd+p+j+p0BXZfX6YlD+KzDL
XDF7FL13NCvQ0jjKJnYr40dNidMR4lMpj6j/KxG01e9DMb0XaCoRemx6VMco
mv+UeDh96MqHdD/UV3LvD+NFlP9K1Oq/nlIZSPOfEkm7H9iflBH/SoRbtrSI
5DT/K2F68tvWFHofsVdy8+LuG5T/SmxtKLB7t419r5sSdeEVI1afYPHGU2Ji
7tivWteYPFCJzCiMNLnKMF/57+9jx4NdaP5TorLs25J2DjT/KRHdebrl87c0
/yn/rZeVXdNp/lNiUJbPNGsF2y9biXOmdsUzvrD1uUqktxny4GUXtn63Eh0N
Au/9M4+tL1ZipkV2wXAnhkta7a+tWjNjAsMqJWLeDjvpq8bwVSU8wg6VrbCn
+V+JIY++J8+aTPwr8bX6SFPhMOr/StiajNGdVU38K7FpWL+C73T/aFRi0f6y
oXvpvtysRPJRr/VT6b1KLRVnizKNVg8h/lPxP9sAPVfqH5qp0Fv26GipO9X/
VFz3MwgxmUT8p+L8Sp9pbU6zfDJMRZVk3qnb9Pu5SSpubhv2W/c5k5ulInPh
WJm7HuV/Ku7NcR6/vzvNf6l41b9Ef9ESyv9UhDSJhI1bKf9TId+62aKdD+V/
KtIVFW8adlD+p6Jy5rRbH+j3AH4qtrTteu9kNvX/VHgusp72kuYhQSoOfesy
WXGI6n8qRv2emmlO9/GMVIzxe/PxCs1r2akQ7lm9LmoWw7mp2GZ0dPyFD1T/
UzG8Q5h5rSnNf6375fUafCSc6n8qpsffP7Qnht7/UvFJ73nBJJo3rqbiw/KC
tEO1xH8qLqb6mven/liVCvNnnhHvJzL7Nak42SvnepuzDL9Jhf2sgSmuEpr/
Ws8v9Gwvb+ovzanQ0DpYnTWarVdLw/Vb110XraT7fxqG/eOSbxHL4lkzDRV/
Nk+U9qD5Lw31E3aL9xQyff00/M5etG1EOMOGaQhS73dk3Fya/9K499mEETT/
paH7eleF93ma/9LQbYP/i/1vGLZPw9yWRf13naH5Lw3tDlrkr3nA9ndL+/c9
IEqn1d//A/yi6uQ=
      "]]}}, {}, {}, {}, {}},
  AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
  Axes->{True, True},
  AxesLabel->{None, None},
  AxesOrigin->{0, 18130.},
  DisplayFunction->Identity,
  Frame->{{True, True}, {True, True}},
  FrameLabel->{{
     FormBox["\"Carga de Energia (MWmed)\"", TraditionalForm], None}, {
     FormBox["\"Semanas\"", TraditionalForm], 
     FormBox["\"Submercado Sudeste / Centro-Oeste\"", TraditionalForm]}},
  FrameStyle->Directive[18, 
    Thickness[Large]],
  FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
  GridLines->{None, None},
  GridLinesStyle->Directive[
    GrayLevel[0.5, 0.4]],
  ImagePadding->All,
  ImageSize->{743., Automatic},
  Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& ), "CopiedValueFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& )}},
  PlotRange->{{0, 875.}, {18000, 44000}},
  PlotRangeClipping->True,
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {0, 0}},
  Ticks->{Automatic, Automatic}]], "Output",ExpressionUUID->"74f1c397-f37e-\
4950-af30-00693442515e"]
}, Open  ]],

Cell["\<\
De novo passamos pelo processo de tornar a s\[EAcute]rie \
estacion\[AAcute]ria. Aqui j\[AAcute] removo tend\[EHat]ncias lineares e \
senoidais de uma vez.\
\>", "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"2e4157f5-2327-43c4-a224-b44d3da95701"],

Cell[BoxData[
 RowBox[{
  RowBox[{"Clear", "[", 
   RowBox[{
   "energiaLinearTrend", ",", "energiaS1", ",", 
    "energiaSinusoidalComponents1", ",", "energiaS2", ",", 
    "energiaSinusoidalComponents2", ",", "energiaS3"}], "]"}], ";"}]], "Input",\
ExpressionUUID->"319be279-e644-4bdf-8d12-20aec74ecc37"],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"energiaLinearTrend", ",", "energiaS1"}], "}"}], "=", 
   RowBox[{"detrending", "[", 
    RowBox[{"differencing", "[", "cargaEnergia", "]"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"energiaSinusoidalComponents1", ",", "energiaS2"}], "}"}], "=", 
   RowBox[{"removingSinusoidalComponents", "[", 
    RowBox[{"energiaS1", ",", "0.003", ",", "1"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"energiaSinusoidalComponents2", ",", "energiaS3"}], "}"}], "=", 
   RowBox[{"removingSinusoidalComponents", "[", 
    RowBox[{"energiaS2", ",", "0.0025", ",", "1"}], "]"}]}], ";"}]}], "Input",\
ExpressionUUID->"feec0665-5635-4c56-899a-b961a8d5db36"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"{", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"ListLinePlot", "[", 
       RowBox[{"energiaS1", ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Axes", "\[Rule]", "False"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "->", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"None", ",", "None"}], "}"}], ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Semanas\>\"", ",", 
             "\"\<S\[EAcute]rie \!\(\*SubscriptBox[\(s\), \(1\)]\) sem tend\
\[EHat]ncia linear\>\""}], "}"}]}], "}"}]}]}], "]"}], ",", 
      RowBox[{"ListLinePlot", "[", 
       RowBox[{"energiaS2", ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Axes", "\[Rule]", "False"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "->", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"None", ",", "None"}], "}"}], ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Semanas\>\"", ",", 
             "\"\<S\[EAcute]rie \!\(\*SubscriptBox[\(s\), \(2\)]\) sem \
primeiras componentes senoidais\>\""}], "}"}]}], "}"}]}]}], "]"}], ",", 
      RowBox[{"ListLinePlot", "[", 
       RowBox[{"energiaS3", ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Axes", "\[Rule]", "False"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "->", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"None", ",", "None"}], "}"}], ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Semanas\>\"", ",", 
             "\"\<S\[EAcute]rie final \!\(\*SubscriptBox[\(s\), \
\(3\)]\)\>\""}], "}"}]}], "}"}]}]}], "]"}]}], "}"}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"ListLinePlot", "[", 
       RowBox[{
        RowBox[{"periodogramFrequency", "[", 
         RowBox[{"energiaS1", ",", "1"}], "]"}], ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "\[Rule]", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"\"\<Pot\[EHat]ncia (u.a.)\>\"", ",", " ", "None"}], 
            "}"}], ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Frequ\[EHat]ncia (u.a.)\>\"", ",", 
             "\"\<Espectro - \!\(\*SubscriptBox[\(s\), \(1\)]\)\>\""}], 
            "}"}]}], "}"}]}]}], "]"}], ",", "\[IndentingNewLine]", 
      RowBox[{"ListLinePlot", "[", 
       RowBox[{
        RowBox[{"periodogramFrequency", "[", 
         RowBox[{"energiaS2", ",", "1"}], "]"}], ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "\[Rule]", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"\"\<Pot\[EHat]ncia (u.a.)\>\"", ",", " ", "None"}], 
            "}"}], ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Frequ\[EHat]ncia (u.a.)\>\"", ",", 
             "\"\<Espectro - \!\(\*SubscriptBox[\(s\), \(2\)]\)\>\""}], "}"}]}
           ], "}"}]}]}], "]"}], ",", "\[IndentingNewLine]", 
      RowBox[{"ListLinePlot", "[", 
       RowBox[{
        RowBox[{"periodogramFrequency", "[", 
         RowBox[{"energiaS3", ",", "1"}], "]"}], ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "\[Rule]", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"\"\<Pot\[EHat]ncia (u.a.)\>\"", ",", " ", "None"}], 
            "}"}], ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Frequ\[EHat]ncia (u.a.)\>\"", ",", 
             "\"\<Espectro - \!\(\*SubscriptBox[\(s\), \(3\)]\)\>\""}], 
            "}"}]}], "}"}]}]}], "]"}]}], "}"}], ",", "\[IndentingNewLine]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"ListPlot", "[", 
       RowBox[{
        RowBox[{"CorrelationFunction", "[", 
         RowBox[{"energiaS3", ",", 
          RowBox[{"{", 
           RowBox[{"1", ",", "60"}], "}"}]}], "]"}], ",", 
        RowBox[{"Filling", "\[Rule]", "Axis"}], ",", 
        RowBox[{"Axes", "\[Rule]", "False"}], ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "\[Rule]", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
            "\"\<Correla\[CCedilla]\[ATilde]o\>\"", ",", " ", "None"}], "}"}],
            ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Semanas\>\"", ",", 
             "\"\<\!\(\*SubscriptBox[\(s\), \(3\)]\)\>\""}], "}"}]}], 
          "}"}]}]}], "]"}], ",", "\[IndentingNewLine]", 
      RowBox[{"Show", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"ListPlot", "[", 
          RowBox[{
           RowBox[{"PartialCorrelationFunction", "[", 
            RowBox[{"energiaS3", ",", 
             RowBox[{"{", 
              RowBox[{"1", ",", "60"}], "}"}]}], "]"}], ",", 
           RowBox[{"Filling", "\[Rule]", "Axis"}], ",", 
           RowBox[{"Axes", "\[Rule]", "False"}], ",", 
           RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
           RowBox[{"Frame", "\[Rule]", "True"}], ",", 
           RowBox[{"FrameStyle", "\[Rule]", 
            RowBox[{"Directive", "[", 
             RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
           RowBox[{"FrameLabel", "\[Rule]", 
            RowBox[{"{", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{
               "\"\<Correla\[CCedilla]\[ATilde]o Parcial\>\"", ",", " ", 
                "None"}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{
               "\"\<Semanas\>\"", ",", 
                "\"\<\!\(\*SubscriptBox[\(s\), \(3\)]\)\>\""}], "}"}]}], 
             "}"}]}]}], "]"}], ",", 
         RowBox[{"Plot", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"y", "=", 
              RowBox[{"2.", "/", 
               RowBox[{"\[Sqrt]", 
                RowBox[{"Length", "[", "energiaS3", "]"}]}]}]}], ",", 
             RowBox[{"y", "=", 
              RowBox[{
               RowBox[{"-", "2."}], "/", 
               RowBox[{"\[Sqrt]", 
                RowBox[{"Length", "[", "energiaS3", "]"}]}]}]}]}], "}"}], ",", 
           RowBox[{"{", 
            RowBox[{"x", ",", "0", ",", 
             RowBox[{"Length", "@", "energiaS3"}]}], "}"}], ",", 
           RowBox[{"PlotStyle", "\[Rule]", "Orange"}]}], "]"}]}], "}"}], 
       "]"}], ",", "\[IndentingNewLine]", 
      RowBox[{"ListPlot", "[", 
       RowBox[{
        RowBox[{"CovarianceFunction", "[", 
         RowBox[{"energiaS3", ",", 
          RowBox[{"{", 
           RowBox[{"1", ",", "800"}], "}"}]}], "]"}], ",", 
        RowBox[{"Axes", "\[Rule]", "False"}], ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Filling", "\[Rule]", "Axis"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "\[Rule]", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"\"\<Covari\[AHat]ncia\>\"", ",", " ", "None"}], "}"}], 
           ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Semanas\>\"", ",", 
             "\"\<\!\(\*SubscriptBox[\(s\), \(3\)]\)\>\""}], "}"}]}], 
          "}"}]}]}], "]"}]}], "}"}]}], "}"}], "//", "GraphicsGrid"}]], "Input",\
ExpressionUUID->"9a0cff71-a904-429f-8c54-2220d751c5df"],

Cell[BoxData[
 GraphicsBox[{{}, {{InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           NCache[
            Rational[1, 120], 0.008333333333333333]], AbsoluteThickness[1.6], 
          LineBox[CompressedData["
1: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
wLupzzvKW0fyx+FJQcfX5EnUb6bHQSh+qpsiJvly4zDf7t3EhTzC5yVxyHZ7
sHnMBQZfx2FKg2jQwHuUz1Rx8FZo/O9nP9pXx6FzX2Dl5K1zyf/jcLRG26Kh
inlfiIdOZqNaz5nys1Y8hhdfCxnhRP0DOx4brv1bXaNN/BvE44Btv8+J/ame
IR7/suvzNt6j+Tin676ox1LuWMJf3HjIi9ePut1M9/HiISrRdr5XxeS/eCz6
drL17E6Kl/R4HDySZ3HImOp7bjxsOT/cTFfR/KskHivTrEalpzPz9Hj8OWCz
oqm1guSPx8sEz/JUS5rPqeMRXM19FavikP3jEV6pvO/iSP0FKwGXRPd4fDPC
m1oJcPod7/pI6E3yJyDX8FpbdTvRN0iAR/3bhyNml5H9ExBz03DC/95RfeQk
QPglvGr0bupPuAkYOr80NbKDsX8C3mR9GRm0kvInPwFnCu5XBM+ifJOegBXV
e1e9aqX+PreLfufL/ZVD6XxJAi6fqYlNCaR4UCagWbsjaZwV9VeqBFyz6/Hj
kILymzoBbp+shw1vpPzRnoD7+ROm3blO70WsRPQ8fCm/uYH8WSsRGh8vVa4x
ovPsRJgsK2zuIWbsn4ge1iEzejQy8+ZEsKPmslLPU3/ISUTfNb1m6Q+ifM9N
RLboq8OPa4TveIm47qS41XaB8Aw/EfM8R2+cMpvwVXoiRsx57WMtoPl4biIi
jGrHt0yZQPZPBL/ldPQMycO/80NlIip/hd7a1ofsqUrEzbZP1dWdpB91InwP
ZBj170n+2J6IWT5rbBIUTP5Lgrcqcenic+QvWklIT+n18LY+yctOwrOVIfmX
lVRfDZLAXjLoW3EV4S8kIXJwTuU/K2n+xEkCf8+9/Tu+M/ZPgsO6V4verqH+
gJeEf6fObrIso/k3PwlCEyfz77o070lPwie98zMu9yP+cpMwqkJ6NqPvSbJ/
Eg5Uvgm6F0N4R5mEPLsX1w81Uf1RJaGO55K6wYzeH9Vd/KUKYs5sJXu2JyE4
q9ebno/Pk/zJKPTbOyRQRflFKxkmFae9fWdTPLGToZ59t6R/OdP/JCPvuWvy
pHjKN0jG7ZCTv57OY+p/MrzPfuwI2kX+xU1G4CFW35MbqJ/lJeNPfN0P7zbG
/5OR9dZgwcTR5O/pybjyvL7udQ+Kp9xkjOheXRfHonpYkoyKaTKLcfoknzIZ
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
UjFz22yD1n3xl/4PSN+vPA==
           "]]}}, {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{False, False},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{None, None}, {
          FormBox["\"Semanas\"", TraditionalForm], 
          FormBox[
          "\"S\[EAcute]rie \\!\\(\\*SubscriptBox[\\(s\\), \\(1\\)]\\) sem \
tend\[EHat]ncia linear\"", TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 874.}, {-0.12999457543129558`, 0.15013714760119207`}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.05], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {193.5, -119.58957682310464}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}], InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           NCache[
            Rational[1, 120], 0.008333333333333333]], AbsoluteThickness[1.6], 
          LineBox[CompressedData["
1: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
rt2cnntblETyd+w/ZEfF2UyyT04SlBquwf0ujP8ngXPz0r3PCrJPeRLOyD/X
5d9l6pskHB62quWGG/mfJglXK7Y4RrZT/GmT0N6QNmKHvy/Jn4RY875nexsT
H2UlQzn94oB6pv/NTsaISxZ/xG6ifhwnGZpfyT+z7jLyJ2P/OdX6PeuoH4Nk
mBkGrJhwn/CU1/F8V7lFxlPaj58M3y4rV+QtpnlBMkzLPNc2/031pygZFcHz
Evw+HqH4T4akeqFrKZ/h88lQ9xxn/HUI9VPLk8EyHDI0oojJf8ko8bHpF7iH
wb9kcKc9lNw/RflZmwy3Y8md8/Ko/6tLhr2SP+bpSOa+LQW3o9sXmBdQPctO
gf9K6aMX1Uw/MAXWDYXdLj1k8l8KfibVXZGMYPq1KejkOOrDrj3Uz+alwGOG
/9vbU6m/zk/B9HmZcyK6EJ4KUsCfqjf340ryN1EKdIqd94bqM/iXgk1S/fs2
VdRfVaWg85vOXe76UL+7PAXfioK+r3h+iOL///MDZF49CS80KdhiaeDmlEb8
VpuCtOrNzhEl1A/UpSD8zKHbTecY/p+KZ0rlQqNq6j+xUyGYOXB9KIiPcFI7
6sehe38V0zw3FdZXdp1R5nlS/Kdie8SZfqlzGf6fCuPzHmdCe1A+4Kei88Sc
hB4/iR8IUrFvTsuEk+3MfUwqENWy2nod8aOcVLhdDD++TxtG8qdixikzl2VO
ZI/yVHCnCKzD7Amv1alwlakdUkUUr5pUNM6vTVsmpPpCm4opvkvXCMaSvXUd
Y12fo18N6HysNGCIr9HSZuIP7DTo2U6cxx5E+ZiThoJtGdFT11D/g5uGgesM
Lj4cSv6HNNxd1TVA9pLsxUtDevWFSaNcmX5NGsbsMrDyZSeQ/GkIT35433wc
k//SMGHPtLGuHwjfctKwoPvIJ4vl5A+qNDim/6iJiWXiPw1JabMXfLFm7qM6
3mc6XPvfduIbmjSEzny/bcEyBv/SkFAwvPPUNRR/ujS8Co/vK485SvKnwz+h
/cBBPeJ77HQsexnb78Nm6vdz0nFqPscpuoz4Azcd2/c9jmruRvwM6eDeD9cu
Hk31PS8dqZ3KJSNdyV78dDhFb3BtUxIfEaRDNazfwitt5iR/OoZ/b9tQqCP9
5aQj99XCH2ta6T5UlY7eq8tW3xHTfuXpaJrxs/aWMdU76nTUXupStOA13V9q
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
pyiZuA==
           "]]}}, {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{False, False},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{None, None}, {
          FormBox["\"Semanas\"", TraditionalForm], 
          FormBox[
          "\"S\[EAcute]rie \\!\\(\\*SubscriptBox[\\(s\\), \\(2\\)]\\) sem \
primeiras componentes senoidais\"", TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 874.}, {-0.10096491108745194`, 0.09057395160941926}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.05], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {580.5, -119.58957682310464}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}], InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           NCache[
            Rational[1, 120], 0.008333333333333333]], AbsoluteThickness[1.6], 
          LineBox[CompressedData["
1:eJw1W3lYjG8XDiFLyVqWMkISMgiR5aYkEZVS2kx7aZv2aZ9mmmmakiwlScaW
EKZs/WQZS4QkW7KPFJFl7Nny9V3O6x/X0/M+79nPuc953hnlHe7g11VNTW1t
NzW1////759q/sYTr/juwtxz9AeULLuefCpNMP/fUgPD7/44Y6ovo7U25qjN
8vjwPYWeH4QND1nZq2KZ87q42k1rwapzW+j5EWhnWWZs+hRI+yxU5g4cadzA
7BtgHi/C2jqbT+sxOFesKF86LYueN8S1wZqlN4uLaW2EvquaLDNK8ul5Y+ib
9tqQ2q2Q9ifiU1HHkNJXObQ2gfbBsI7v5Vx6ng2/ngeS/GYF0XoKjN3Pxr16
V0jrqWAV//41/K6Mzk/DwlQNN+6DdNo3RbZmy7UN171oPR2FfYVF30dtpvUM
GBk4LOwhzaP1TMyQGXHxcSe9zww307xrJwxn9DULYYZz7um820Tr2bCLW8Py
XsjoxxwlQ9xvVcp20HoOfjltvbVzNKOfubB5pFek/ltC+/Mw+PP4qdXF22g9
Hy6hr3sl32T0D2RvcrziMC7m3z4fGCRomazqHkT7C2AUxDuyUL6I9hcgzLyv
j3EF876FqDycu+VVSf6/5/kLUW6xYMmzICntW+DP7Nb1PzZk0nkLmLhO/i0o
Zvi1BDtsbf2J4H103hJnD1RJo5YU0flFSD4sr8NX8gf+IiwPH8JpurOLzlvh
9tL2AzZLdtK+FVYHmIoNtzL6Wwy1/5xy2MVr6P2L8a3Sqp+fbgbtW2PwrIeN
Tx130XlruLDaej74s5L2l+BA/Pzywhgh7S+BWHbx/LLHRbRvg3qVRmjjNIa+
Dfq6a477YudL+0vBS993xyKG9MFfivwbZYUZi2Jofxne5swar/doN+0vQ80d
c7+ats20bwsX29gY0bsc2rfFw4dam8658Ug/y9F2WKYZNYnk4S/H7EGBB37N
3ULnV2DjCXvLR3/If/grMGjqm+2755K91exQcPPmrOB+fv+ehx2C857t4/RO
puftsGX7fOk3jfX/1go7dDzZf2re0HX0fnuMtKxxH9Qz6t8+7KGZ3TxLrZhP
/Nhj9ocLYzMHk78r7BG7PNxh00zGPxwQZx+bZRa+h8474J7eR56+diKdd4Ca
Tp8WR/sQOu+AU9W/CwKSthP9lWgL6GL/1WwP8b8SJ1ofGS17Qvv8lRCwx9j1
v0v5QbESf1Y0deP8ZvzXESu1T/NbLu2g844oea6d77GUsacjWrR29i6QE78K
R2h6GIct35lF551QeMnq+UWTODrvhPmB2m3xuSI674SxA0bNnr41mvh3wq/R
3FejTlcQ/6tg6G8vdPImfrAK7tdPhfg9Iv3yV6F5YO2SxzmxRH8VWtW19Pe/
l9J5Z+gv1W3GlQKi7wxlRnP93Q7yT74zTC5dHfp3cijRd4ZOqc3lF+4Uj2ou
6Fka0tesO9kLLvgp+vxmcvUm4t8Fgo/C+8tiKJ8pXKB20SKtJKAPnV+Nx1qS
tL4zmPOrYRK0RLN4bxTRX42Hs8aUTdtO8aNYjaJpE35E6pI/qbni1EL9m+yk
NJLfFdouAQdDS+2JviuUE89c8H+6hs67wuTuIa9RGzbQeTdYRbbN+7yd+IUb
Dt1463ZazOjfDc8OT157R20vye+GMc3SU7XlRE/NHTldxfa1G1OJf3fk5hte
PBgaSOfdEX9Rr+tzPuUHhTvswoPmm1Ux8e+B5gtemw3mM/Q9YN2z9XP3IYz/
eeCwpYfTZhtGfx5Q1T2vSPJn6oknclsu9t76di2d90Tj1F43AufYEH1PHGIl
FOxe6UrnPVGgVuD0uoxD/K/BN4PUKZZrKN9jDfz3ZMV/jKI1fw3MXNmBlfuo
/inWYFLZyTfWaol0noP7F9cdK+9H/sbiILb2+O9L50lf4KD/mz65/tZkPw4H
RT/bwtd0J33xOci1vifsnbD6376MA7bBTPVbGb7ELwfLj7j+GXmU8puSg9/9
160d7bOR6Hvhk4f/hpr3u4m+F4RDptTnL2bygRceTV+x7f3ayn/7HC/cHCd8
rbhbTPJ5of9g4+rAPxSfMi88nDe+z528EpLXCw16uwva9mwn+l4YV/3Ma823
WNK/N9q1nnf/7JFO9L3R126o06nmAKLvjegfY9YtGUL1kOMN1nm9pEvsSKLv
jVzd39dZv63+7cu8MSX8v0YBh/CJwhtjDs5Zanya/EPpjbtPBN2vMfVAzQe3
Z4bdOzo249+a5QPBhZOHsvuRf8EH58rXF0c37SP9d66HpS6qal9H9H3gsqTi
u7PUlej74KjSchh7bwHp3wcaK9dPufZrw799pQ+eLvl57o6emOT3RWNV9zsh
qgVE3xc3eXttD83PJvl9MbbFM+LQ4a1E3xetg9Pqk9OXEH1fGLcZ6PnrU/zL
fMGLVYm4ZrlE3xen07lbt20neyh98W1mV49HX8i+an4Il/4ee/0P+SvLDxtS
esubum4k+f0ws8P86kEX8keOH16++hjfpkoi+n74tqPJ83s08Svzw7GW0Qbj
75K8Cj+s0wn63Gcd8a/0Q+TeZ79mBVK+VPPvrL/rWg9NkpD9/VE8+otXoDOT
j/wxf/i6nhNvMPL7Izcxp1+FiTP5vz/eTK+d8FhO9UfmD3nRSeHNt5S/FP7A
75hh4U2eJL8/ljlFH7/fRPVVLQBPs55f3bGd8B8rAMYig8zzVYQXEYArDoev
3w2l+skJgCx9kOMKdweSPwB3326M0NlH+pAFgD+qJX7wG6r3igDonxb9tNWk
fKkMQGWJ/bFh04QkfyAMJ2q+mzWT3s8KhNHiHRP1ZhK+RSDMuz78fqfBh+QP
xK6NG7dt2iwi+QOxv+T6yB45hJdlgagPtB3nt4DiRRGIF7eaeBvVKb6UgdBe
fOhdH9EBoh8EmVsXrY4qytesIBj/MI+/akT1CZ37gQ5Krx+E/zhBOLlQY2fL
UMI3/CB8urNF2nsHySsLwsSvTwzHTiD9KoIQalS5usiE8q8yCDeGvGh9ZcL4
/1q0v3X8tcfMn+ivxZiP6wcax4mJ/lpUnujdoMch/jhrIR9xruz3ddIffy2y
f8xcf3ifgOy/FhtXBBTPd1xF9Nfi7KD710rV6LxyLRqTBVZ3HRn8HgybrIc/
wqyJH1Ywvsz+M6KkF2P/YPTZ9nHihrZtZP9gLMuvv8kalkf0g+EmMp+t3kD4
QxaM1xrWosZqxv+DMSBFfcb2XCb/BHdW+DKn6rnkj2ohqPfLqh4cQ3iQFYLj
F27ZrXhMeBMhuF03oaO6hvIzJwSBt2aemtdA/RM/BGZDelzs2MLYPwRhP4f3
vhdJ+UARgl3LvNL/WFK9U4bgP4/osrPZ64l+KLIq5m5qLqV8yArF+hG5OiMP
MPk/FI1/3Wx3Cpn4D8WBDe9UT7tTfuOHwuzjiCNLC8geslAMRKZ791LCZ4pQ
FJ3UUgw3JzynDIVmvAX/yycGP4XBUGw68+dKRv4wvBWsCu7WTv0FwrDJYZeN
6wiixwnDqp0DMu0bGHwWhnWlri/69yd9ycJQWO2479gPpv6EweXXJtMYDvGj
DIPCbvOp/okUD2rh0HZVKuWGVC9Y4XCJeKcht/Ei+uG4wO79cF096Y8TDtsv
2d+Hvi8l+cOxyvi5axdzigdZOErTvilW9CP/UoTjZ7Hxmy1llJ+U4fiy7Pir
eBeqx2pcCGpzutzZ7v5vX5sL/sI3i47VUn/I4oLn2TjrYErCvzWbC8vdBU3a
sxn7cKHkmSw4toPquR0XDg05enktlI85XBw+cSPy3giaH3C5eD0v32ZlNuFt
PhexGg1vskso/+dy8fhtgbPNR/J/GReO9RaZ3HVkfzkXkStdbQf8OULycbEn
ouLNTwd6Xz0Xn1YNCy7IpP5fycWI+cbTzSdQvVdxMXZIDr/pLTMviMBvneOS
Wgn1i9oR6L1pf/dJGyh+WBHQM3CYvf8G1Qd2BB79epzxOY7wFCKgv2/u13k/
qT7YRQDucTsGrllC9opAnXTulYb95N/cCLSfnNxamepB8kfAbkqOwxhlwL91
bgQ2bi+T+ukx/hSBvRWs+cWvKB/JI+AozXzy0IuJrwgM6G1ttMKY/LU+Akmn
DpVUJhNeVUbAkD/7bvdnlF9UEfhSN1HnzzcGv0biUssDubsw4d/z2pHgxY23
3Xk/k+SPRNmT8Zoh14h/diSslg/4uD2b8BQiYTLLuzzvGOff83aRkCv3zhvt
QvQ4kdharGnAzqf5ADcS/K3vx15PY/qrSJR3f6Z+0Zj6m9xI6LY73T0Eqr+y
SGzfEpb/fg3lP3kkfGO9hzwKofmTIhIG/cP8dswme9RHIkftrih+60GyfySk
YtODra/JH1WRaBJPPTrjJoM/o2DxMiQnZBvFl3YUNodM1ly/dS3JHwVZgF3N
mGTCy+wolNlbrPPQJvyHzv2wWW4lVyxJ/ig8d/9mqDOQ4pETBT+WdTfT2kNk
/yiotw29Wq3KJvtHYdDMqxUNR6g+5UZhguZpLUNt0p8sCstDbOZrelP+lkd1
1hP58zPGVA8VUai4XHo6eR69rz4Kby5r+97/SfMFZRQ0rFteFHSn/k/VSb/m
46M1Dgz+iIZ6ZHXOflUc2T8aTUGPR9j5elI+jEY2l7vz3AWSlx0NzLR9PmIE
9XeIxov1N3weiwhf2EWDf3L6tH6yqSR/NPTWmGq9+kv8cKMR2e3KwYlS8i9+
NAxNRyW3bqT4zI3GGG35GrvT8SR/NHTuP+h3W5/6Y3k0hG/qnJInkD8oorEg
9/bW0GTCz/XROGaosVnMo3yjjEZWo47+6pcRJH80FC8GrPeJI39Vi8GP3ml5
M2wJb2rH4PHEaX+6/qX5DSsG4q/OC3RGEV5kx2DuVf1B/rrkf4iB7lC9hp/6
JI9dDJozjJP2riJ7cGLAaii+WeBD8cmNQVLjmF3tbjRv5Mdg6rLcife+E/3c
GBwfeH7sTQm9XxYD8/eK7Fd9KL/IY1DKOqlZn0zyKGKwddmDidMsqH+sj4GB
xa1jupPiSf4YtBZsOXjBmuZrqhjItxSrogcy/XMs+B+ivjYm8Uj+WNT6J8Ll
tj3JHwu9y+43eAFU39mxuOCRe+DuecKLiMXYkU9tZ/wm/7WLxYNfgz9UZjB4
NRbHPvSu11pL8zxuLBpelzq7hxF9fiyS5NebU1sp3+XGQqLn31XDmuJNFgvr
pT3HZJUQHpXHQv3LSaejmpSvFZ3nLx6tlnContXH4mHC4ryeH6g+K2OBWote
zn9DKf5jITBJ7fYsg/xZLQ4H7o6uTzxK+EE7DpU9Ft3aAeKHFYfW4YP5X0v8
SP44hKYsLbr/lOo54qCOMk/1ZqoXdnHQ8D4T1mcK4VFOHNqaC8PfzSV/5cZh
9NTo3Zs/MPPQOERnHPD8/of0lRuHY818cbH2VvL/ODx2dv36IpjwiTwOclXW
xmsjLSj+O/mLK3rMa6d8Wh8HS5+LA9v1KX8o49DH91DdU1vSjyoO7kMiputJ
mfkzD/qSqnu/JpH/avNwqMOpdd8FwgssHuqGFL1OkRE/bB4WO+w2b7lGeBc8
HHjwd43tbfJ3Ox5Mfumovw+i+SWHh/z0fRVuhqUkPw/HnvpdfJ1sRfLz4GYp
PXjgHeGrXB6OZm+/7tSN5JHxMCw4+v2OBRR/ch7azn3kqd8hfKDgQR57rfvv
h4R36nmY3O248Vkrmrcpebib62Dp3I3ql4qHp9k9Vww4RfVILR6+XXh6w/OJ
nnY8erza+OnaIeKfFY/8iY4zJgWSvOx4RK878+SlI9ULxMPuea6ZVYUtyR+P
lOjpL0WjqZ5y4lF+uuD5uAEUf9x4zBvZLbhuCDPPjcdKLcGjnC/UL+fG4+Gm
qt07jzP4Jx65ZybKfn2kea88HqsO1MUlZ1P/pYhH1K/A7QGDKZ/Xx2PW171R
7KVMvxWPsj/NSR0/iJ4qHrePH4X+TOZ+JQFaU/9zOK1H8x3tBHw92Pu31U6K
N1YCfLev++STSHiDnYDZr32iepnS/AEJKOhXtbVrnB3Jn4Cal5faljpR/HES
sNT69SlWCj3PTUB5CFtse46ZXyTg0rQYbQ8/yt+5CZgY1T85P5XsLUtA6bwr
DnWfyH/lCZAVfeu3upHyqSIB/BtmIx4uIfvUJ2CEif20xJVU75UJyOQ9Lcod
Q/2KKgHSyT0bgoenkf0TIe8rMDt+eDn5fyJStCaplwkIb7EScfo/D89zuwkP
sxMh3vjBf/kXml8isdOfevl7rdtP+S8RR8eWFJUWU37gJMKuxmj9HiOqJ9xE
dI+s0ls2lO4/+Il4f1V/z0ATkic3EVP6dQt5sZnWss7zWR0vftpQfpYn4sLY
oV7LPzPzlUQEiiwnV7QTP/Wd75vUPN/tNvm3MhG/fj82bagmvKZKxNRie6tx
tcz8NwmypScd/rwjPKydBJ5w+nD5DAfy/yQ8m377UeAfim92Elp0Tj9z2crM
G5MwY1HDTFXRMbJ/EiYfCmu7nEj4k5ME7mo7qx1X6D6Fm4T9hQMi4y8x+C8J
peVzFq/dcYTkT8IcvlHyzi0UL7IkeO3Ptuh2luwpT0JUg1fZq6clJH8SurG4
FXpHD5D8SbA/8HTcxJ5Mv5mEoOYRQV/ukz5VSWg80tLDYhgz/0yGhrFwbo0p
vV87GZGb2/S6rqf6wkpGYZ9a3fKLVK/YyThUujRM7TL5K5Kxa1LYEKPHJI9d
MlzndCQN7kX+y0lG33281aIkep6bDFbjzu77hFSf+ckQSB/M+hZLeCc3GX9d
vlxbFUbzIFkyZDcU2yx2skn+ZCxUSyz4PYver0jGCq1dG7YEEZ6tTwance3+
sE3kH8pkoPHSqBcfCE+okqF9b9aVY9bM/WkKEpQrRqRappL8KbBMXMbznET9
JysFi5LL9IcHUTyzU1B/bU6BUzeabyEFalsrSr5xqN+1S8GlBwsnnfJm6l8K
Mlv+Nq0vI//lpuDcr5MDD9xg5tMpUIq4jvbrib/cFJxetHnO+DNM/UuB4XLH
3jvLmfhPgSnUt7oeJn0pUhBdZn+en8vEfyd96XIt43iip0yBtt6YhdYalB9V
KWgyMBjp00H9oloqrK2la8fmE17XTkVswPIZmgmEt1mpYK14v/DTJsL37FRs
Dxuf7TZLTvKn4nf7UlF0M/Uvdqmw2r76w/Dd4WT/zn2P4eXJY8je3FQ09t4y
b/hwqi/8VMSkuf1o51N9zE2Fa4hpYeBvmrfIOtdLZl8LsiT8JU/Fl08LhFOS
w0j+VFx8Uy5ycKF4qE9FiVvprsXf6Lyyc50linpzkfxDlQqXd2+u6FQy97t8
CKJ6zbrSi/xFg49L67+O9L+cQv7Ax6PIqMvXh5F+dfkoWVjn1OUb3W+w+NiF
+sINSwjfG/HRp1fxQPU5RI/d+fyIHG3dLYRvzfiYuOem4nQ10z/w0fflSt4K
dcKP1nwUmg8P0nImvGPHByut7uPrCHqfCx/N9UlbD0dTPePwYZE/JGZTOOkz
kI+v9m2eWgVMv8nH+LHd/j6cRP0Djw+5mcP8hTLmPpuPWxczf005QvlTwseA
HKNF5Su8yR58FNxMtFRUUT0v4CMneI/mXC5Tn/iwbb2O02vIX0r5kA7zS10z
lOqznA9FfJtVBIfmbZV8GMzNe9gnkuqfgo/brK7Zf4MpHmv40L0xY8++IzTf
q+fD6M/Rq8M0KX808iFLORqj3+RP9uXj8s8qqVEh+WMrH2Ucedk2G4ofFR/W
Ortci1ZQP9vOx6KOeo2tCooftTSceH89KZZP+E8jDab7zxZVNZM+tNMgdz3W
yh0Z8W+tm4Y1PKujQp39ZP80XBi/2/xlNf7tG3We77nla3ce5S92GlqmPUrx
GU310CwNqnMpN2d3Z+ZHadDWCM9zOkTPW6ehSefOfaX4MNk/DUEdcaN5LWRP
lzRM9Sj29PhG+uGkYSfr3pQq9fJ/zwemoWvbouwqXdrnpqE1YtjwOfcJv/PS
UK1fm2zsTPzz0/A1UZCzUo/qlSQNkzX2PBhxn/BObhoK7uUPUE6ieWFBGhT+
K3OdZ1G/LEuDa/zhLn2eUD0vTQPriUHReXPCn/I0vInmjTnbi95XmYYxLwub
HW5R/CjSMKOfo9CilOZLNZ3yr3O7evU13ffUp+HhgklDtk5l7J+Gy0O/OXx5
QvGk7Hz/+NrXQ8WEF1vT8H5EkfrR9SS/Kg31OwvvNK5fTfZPQ8iN2eMuZJK9
1QQIqzAqNNSieZmGAGds+H313MvI/gLcPWt/uaKD4ltXAMfNBsYzC6m+sgRY
ZlIX+MyQ6qeRADNu+CV7Hk4i+wvA13B2fhtE8y4zAVQLDN5U3JxE9hcgt6rc
9G8HzTOtBVgej6Z9FhQfdgIcW167u88Tmue4CJA3Wm/qb6af4QhgcGPufyvM
6f4jUIBY3VC9917Uv3A76W+7EtBRTP0nT4DXlQWs82bM/FiA+am7Ai4cJXkk
AoxwNPToYkjzxlwBxriMmlctpXpSIMDxHF897+mUb2UCsA3MzU8mEL4qFcDl
df+KoTpUP+UCtE+dzl6SSPmkUgBZib6Wg4C+b1B08uPZcnZBFNGrEUDtds5J
q+dTKP4F8DzHc1/eg+pDowAPe6hNmLmQuU8VIKerLcq70HynVYA9W6oMGl2p
3qgEiM/38h90k/BduwC+1l0vnrtJ+UJNiGExI82XhFE+0xDC8HKizpSVlG+1
hTinal9hl0/61RWiKadB2MWPvl9gCbHZsN3dvDvFr5EQmu2XDV48IHzJFmKG
yrHHoSd0f2QmxJ4uecPOM/NuCHFk7ne99zVM/Auh2mhpG76X/MFOCOUk/WRO
AenPRYi88+HCqQ/pexeOEKd2pAYuVSP/DhSi+dA3n6gbkWR/IS5drat1l1D8
8ISorch7ZriR+hu+EC8fnH75qD/xKxGiX9fQ7TamyWR/IZ4KCkfZ+pO9CoSw
aDh3/aUVU5+FqBlUv1xnOJP/hahrujc61Ibyp7xz//pnxal15F+VQky9ere1
rY38USEEO772mIYO4c0aIa54zT/T1sTgeSF4k8JfN3lRP98oxNhFR0b7NTD3
eUJIG1cs/G8gzT9bhTANnjB4RzTlM5UQKZ5bhi84RvO1diHGte+bdusRM/9M
h3KT3ur2KoovjXQ8HGIjnDaf8IB2OqKNUwSDW+j+SjcdBwM/1w6+RfpipcPo
lFLNTulE8Z8O9jUT13Enyd/Y6TDsyvLgdUST/dPBOTLu9KWjzP1uOiwVQUYl
uyhfWadjesOKmdfyuP/WdumIuLK7eOhXwu8u6dB3Hrk7qIrmNZx0FBhMWaxp
RfkiMB3fm3u/XyAg/+amgzvz+6tX05n4T4f/9SDxT6ae8dPx84qf6cP7hK8k
6bigNmlG5UGK59x0PJ142XvkUDpfkI6zvVet7j3hBNk/HbmrZwvuw4nyf+f7
/+jWle+i/CNPR2Tj9+Yzl8lelekIexZ46ZaA6p8iHatPx7WPH0r9Tk06dEPG
zLl6nplnpMNtUY8Ov5fUrzamQ3ShQlUQQvenynRsGB1tMLeR8ndrOrSbkfdz
GuEhVTpe343/cIRF9bS9k9/MudevWJC+1UQIjK37a59E8aQhwot5+vk+IRSf
2iJ0cDRdWG6Ez3VFkC5QNZscofrGEiFx8YufN8SEd4xEyPqyNiYileoBWwS5
52FRcX/Sh5kIRZPOerbwKD4hQuv9c6P1OfQ9gbUI1m69Y+9UEv92Iuzoejwi
/gzhFxcRWM2fxrnLqN5xROBMK7g63prwZKAIcXvnpVpWE97ginAl8KI4qiv5
K0+EG66nouak0v0CXwT+uQ291HOo/5eIoHDbMe7AcbqfzO3c17w23XXsMop/
Eaab+PsNGUz1USbCaI0YdsVoquelIizVSZ98sudRin8R3sW8WncgkeSvFKGp
++YXqaWU7xQiKI2Oj9W6R/FaI0L5LnsTZz3mPkeEqGsrq0wmkn80ilCRFHLO
/MpBiv9OfT13WXF58iGyf6d+jl3znmJC8wuVCAvXbrIxCCH83i5CaJjNqCuH
mO8DxZji9qNb4WuiryHGQz2jGkOLCop/MRp+DUt1eEf4SlcMq8SahY4rqJ9i
ibE90fDN8m5ysr8YOzccGva3iPIdWwyzjFTLsvdhFP9ilO550fz4LM1DIUZx
jePuq1+JnrUYgX12PBN2oXpnJ8bbYZc2hD0l/OUixmn79XVnDSl/cMT4tn3p
8MZf5L+BYhx76P5lSA8fyv9i5Nk2fJuuIH/iiXH4567bcS7M/FmMz7us3kV+
IH+SiLEhwn996mrSZ64Yass2aS7/SvFSIMbTJ44DG1uZ+4lOfc1d+ePAUPL3
UjEaox7sHJFC3z/JxTDddt08QUXxWSmGbtj5kLEL91L8i7Gk9NSlJyuo/taI
wbcITVliQXigXozoKv8B1TWUPxvFeP+pzrQtlPCkslN/i/tq6Qlo/tAqxvIO
g93BTH+pEmPM+31mwRF0f9suRm2hyjPHlb6fUsvArDWTlp7zJLymkQGLxfEG
hUw/qJ0Bfz3bAT55NE/UzQDHrWPJnr0uZP8MDHr0wbreg+YDRhloHNJcs2ov
5Td2Btq/lvYQGFD+MctAh3jkiZFpdP+CDBTdFZu+GhhM+T8Dn679bZtyhvK7
XQYqxn7TVJ9I8eySAdXIpu4JYooPTuc6xdnv43Sq54EZqCr/z/LpUaLPzcAM
/Za5aY+Y/J8BX4cfLp4HCb/wM2Bptaf4Qgjhb0kGBv68buS7neb5uRn4YPZI
86OQ/KUgA3y3TW7TJ1N/L8vA2r7m/OSrFG+lGVB/2meDKfP9qbxzzfta0PUd
1ZPKDHwNta2Ltaf+Q5EBuWmJo4kP+V9NBgLdqgZnlVD9qs+AorBPv9GRpK/G
DMQO33p67xuqr8oMJEyafetZVQjZPwPaxuGD9b/S97KqDNSLusQZG1L9aM9A
6Nu4M8/6kXxqElzO86tdMpbepyGBZclRvkUK3Z9pS8D6cfLxzbV0/6QrQdpC
0SrZL5ofsyTIOju6ZLUn6c9Igj7jng/sMpPily3BmSsbHwwfQfnATAKNxVN1
ZyXS85DAPv7DJmfmvsxaAqseOZWeweRPdhKYXb+enedK8woXCT7WbT3mH0b1
kSPBPtZK+S5DsmegBMZXAu12KZzJ/hIUNarXGX8nffAkOBXr7SG/QPMGvgRt
VypdnHcRHpJIsM7w/lmtOMb+nfIndTl0sIz4L5BglNuExndswhsyCbynWN+5
IafvsUolEGnpb/JsJv7kEkx8O8FFw4Liu1KCN9fmTr2aRHhDIUF9wH7sriX8
VtO575X83+izFJ/1nfq1mbWhaxT1v40SyExv70ztoHm9UoK/ru8ezOMSv60S
JP2OKH8SR3hVJYFkZX5D/m76XqJdguaa/J1nlTTfUctENsv569U7dF4jE77D
8x7096P8pZ2JXT++fj58kfxVNxN3Fiwp185g5qOZSLyw7udpkD6MMiHf0qQ5
5ikz/8nEqknxm18qKX+YZaLs/dRXxfY0D0cmMtfanCgzofpi3fk80lwT8sn/
7DKh4/XlROw66rdcMvHFabdqgDPN7ziZOBSdf1tzJs07AjMR+eiaC28q5QNu
JvjzlBGfR1E/zctEYetVdv+hFG/8TLyLmJ35YBSD/zIxL2/kZaNpZO/cTNT9
F+J52J7ioyATHIea59cukz1kmRjaun7Ck0yqz6WZUEXkFduU0DxQngnFhCit
ttUeFP+ZuDvCYV9eHtUnRSbEpxU7z04i/dZ0yv/DqULsQPOE+kw03X7znveH
8EJjJkb0GzTysiXzPVMmRnf3xXjm+8XWTCR8tFp2vITiU5WJZWO3DTE/TPHV
nolzPTZ1lFRQv6ImRV3MyKUfmfm4hhSlsb8b/Vh0n6wtxfOgpXFLyul7EV0p
aifzZoUy+JYlxbN+B1KubqPvV4ykqKhsKD+6g8F/UmQvmm5dXW1N+V+Kb0P2
8pceZebnUtxdZNztEof82VoKmx/2W763ED6zk8L6xPsLqzPJHi7/33/Voc+m
39twpGiI1lX8saJ+OFAKla3JiUFTKV9xpTB/HXmq0JTiiSdFzMV13a38mf6/
k/+4IlbsTfr+TyLF0z/f3x3eSP1+rhTyhP73f5Z4k/2luNDnAvvAOMK7MimS
EpfFpjdQviuVwneABTugg34PIZdCuerEYlfm+/HKTn17aD8wWE94TCHFgjXP
iptmULzUSDH5wanoS3eZ+i9Fzz/hy76conl5oxQ8dnrEMm/G/lI0iqo9PnqS
/7VK4VPmJb85nvSlkiJ6+taLh8sJv7dLkbZ35uQNjoRP1bJgXPy9p3Eb4UmN
LMjifDju8sP/zmtnYfaLMav3xxAe1s3C0xmfvpzUIvzIyoLvr8B3C5n5vFEW
THdFrDncRvHHzsLp4m/OeicI75hlQbz+3rL7+czvRbLQd1vUdCsN8kfrLIzv
eq7LktsUz3ad/FikVFcoM879D70PqZQ=
           "]]}}, {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{False, False},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{None, None}, {
          FormBox["\"Semanas\"", TraditionalForm], 
          FormBox[
          "\"S\[EAcute]rie final \\!\\(\\*SubscriptBox[\\(s\\), \
\\(3\\)]\\)\"", TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 874.}, {-0.09538165370687272, 0.07550914194839288}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.05], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {967.5, -119.58957682310464}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}]}, {InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           NCache[
            Rational[1, 90], 0.011111111111111112`]], AbsoluteThickness[1.6], 
          LineBox[CompressedData["
1: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

           "]]}}, {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{True, True},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{
          FormBox["\"Pot\[EHat]ncia (u.a.)\"", TraditionalForm], None}, {
          FormBox["\"Frequ\[EHat]ncia (u.a.)\"", TraditionalForm], 
          FormBox[
          "\"Espectro - \\!\\(\\*SubscriptBox[\\(s\\), \\(1\\)]\\)\"", 
           TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 0.4988558352402746}, {0, 0.01868853636732172}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.02], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {193.5, -358.76873046931394}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}], InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           NCache[
            Rational[1, 90], 0.011111111111111112`]], AbsoluteThickness[1.6], 
          LineBox[CompressedData["
1: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
           
           "]]}}, {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{True, True},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{
          FormBox["\"Pot\[EHat]ncia (u.a.)\"", TraditionalForm], None}, {
          FormBox["\"Frequ\[EHat]ncia (u.a.)\"", TraditionalForm], 
          FormBox[
          "\"Espectro - \\!\\(\\*SubscriptBox[\\(s\\), \\(2\\)]\\)\"", 
           TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 0.4988558352402746}, {0, 0.009949392763306747}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.02], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {580.5, -358.76873046931394}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}], InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           NCache[
            Rational[1, 90], 0.011111111111111112`]], AbsoluteThickness[1.6], 
          LineBox[CompressedData["
1:eJw1mHcglW0YxpWGUqGSliRakozCi85lZCTZe4Q0lHbpq76UNEglojRVpAhl
FJnZ2RzjODhIkVKSr9Due99znvxjnHc8z/1c93X9brIbd1tvHi0kJPR0lJAQ
8/3v196YnqsDDemUhIZzyLc8a0w9Zx4Wx/mPJfh9Iy7/szpy+YypuG4daHdw
3g5UlCxhex6bCMHn+yDHqoo8FCaKpuJPgxm7/sGFkF0nS8MaWILrj+JZAutI
eN5MrPgU4jp7qz82NT1IfKj49/kBiI8f/OPmMAaf/Rbmc2ecRuMZO12x+u8s
wfMCMb4vvPP7rY+sDNEcucjSs9Dan/clKZlDnn8etSHZAyVt03D0GvOHENj7
bDuzbd8IS/C+UGwb+nlkT5gy7oQfGJoQHobybJ0P9xw1yPovIcXKLPvsKWcE
tGLxu75wuGzuLRilco4SrOcy8t9sCuXdMMEmWVGnMv0rUHijMKfpoBjZbySk
Y+UvSOlMhJE3J/jB9avYe8b/9t705RCs9xqid7YEsfxGWEse38058991FKc9
+PrLezqp500s+Oq8Id5UDaLDOz5uNr0FpeCICHeXXyzBfqLAE21m3xhZgH4d
zfmG0bdRkpW4LLZ7KannHcwPfbT8rehs0KteOvXXHXzqOLA84uIwS7Dfu2DX
r/9XQnsZHJl9LY2GwWW/XLVvMmT/0YiOOJfwdY8OKkSqnQdtY2BnPq/brnsj
qUcMHrM8VfXTvCjtxNTPL/3v4d9Fvhw1LXVyXrHo1al65LNZAYkWV8/XJcbi
8Ik5h2fLi5N63cePhR4aUQqANP+G+4gatXbG/eippH4P8GdvYNvnATGEXPHK
ezwmDl/UT5cq/FpA6hmHA3WzplTki+MPtdbhtnI8goI/5XziqZD6xqPnwIsz
19XlsKddia7IQxyw//DLfoYWBPV+CKvR67Py5Wahy3/62WNBCYg55bTb9Koo
qX8icgenh/ZpzIO1/HfZXU8SIeq6g5onvJqcRxL83m75emStLYpedGa5vUzC
N6eUXR2bXYneHmF4sHtLVtRMrPQpsVk/6TFairINVv9YRc7rMZo35o7jVRnC
hnnd3GRULTo/Pn/5WnJ+yZB0UOIWvFwBplozUpMht3f25LsBEuQ8k7En4H3L
zBYxFCtoi00xSYFxnt0O1dSJRM8pcOjRkrgesgBHfya1je1IQaWuRXT6R21y
3qngPFOXUoxYjFU18+N+7U/Fymc//e5NnELOPxVLw1Pfbpuuiv7bzAPToE5J
6n2t0Cd6SENIaqbVN9k5uL93nF7/7TQEV10/PcnMlugjDT6GUsWcgNXYYHB4
cs+qJ0g81S/0oGoBBHp5gmXufQ+iuZaQkvzQwqt8AuE3t3gmGoZEP0/xZU/5
FGspGdS+2XC/0fMpPqQdM4t11SV6eoqBq5932VIsBD1j76saeYoLG9wl66zm
EX2l41VF0v17gUMs3eA1KL6QjvX5P+uytGcSvaVjYtDNLh8/eXxzYRSTgYJK
90cjypJEfxkY/8T5hdFYJ6QuV+CmZWbgeSZLejDPgujxGeZdFI+fdd8A2//c
vJdg8Qy5pqxFx9bqEX0+QzkrrC1LwgNybDHaSp8hYIkxCq/qEb1m4uDrogIz
bWO0RQesvvFvJo6HX9QYPvNXv5n4LnS7LvDoFEQwxymRhZ6zx48ldDsSPWfh
hdSfrvheQ5jxX5iF5iWVY89NsSP6zoLlhOUNlv/ZYuxM5g3Z+FSpKLLRSI3o
PRtTliV/nh61BLnv1u8+0pCN41rKTQFVMkT/OahxUfop5euJg9n52vu25WD+
8fcHT/ypogT9kIOAL06b44b0oXRBTWT7nxzcr3FuPW38tz9ysevcxOEdjo5U
L3N8l3NREUsLZaiNEvRLLiZK2HtNrjfCbeVZd52W5aEWwZ87dn4m/paHn1cj
nu6o14fj6PM7rQryYNjXH3RD3ob003P0L9DSfvBNFeKNv+mKPsdmU2n7wzWD
lKC/nqP7zmM3jqYJypn39j/Ht5assCvBf/stHyFPTJfcfa2HAnp3N/XyMenp
2DHdA1qk//KxMlf4yrPzyrhFn+7V8/m4d0e8IinUg/RjPm5OsDieeA1g1B3R
nA/f1FEG77frkP7Mx9HeP5s8lFfBnn5b6IICLKLL9iWtlBL0awGUd58SHd1p
AtVOB3qHBZANvXIkwUuF9G8BOi6ZTq/mamGKSdjbwGcFaDi0v2XAwZL0cwFu
GHF63xvboC+5ouakcCEmFKmtKDewJ/1diNOm1r+fmbrixawxT4+bFyLePGYs
J12e9Hshnrz8rahsYIAYRn7XCtG6ch1b8rEr6f9CZJvEXnKQXA/m2P/pLsTv
Sfdtj+UZET8oQtDM9SsiDRThYpu8df+KIpjLmH49JEIRfyhCRkjLxX8uOECT
L7Ai7O15uWPXp+XEL4qgR7vENMtsavoiOfpIizDXtbvWdb4u8Y8ilAgXB0bP
Ugf/OMSLERo9oTy50J74STGmXl1pWjVdDlUjl4W8XIox7aZ5lEugNfGXYvgM
zZRfrWqKeA/GQYqxLeWgvaO7HPGbYvTtj2jI6rXG6XJmwcU4JuZ6KSDIk/hP
CUK9O/0ufFYDk3L2OiXATcuIiar2xI9KcMD7S3BujRFYdPWsA0vQP0P4yLu5
+sSfSrBtz4QpknJKmM2Uv74EnicCAkK17IlflSDGaVnUdu1ait8u0qXw3EE3
jM5ZSuBfpTg8vjJu/kY11Dctplu8FFFbtFk6u3Qh8LNSKLytZJ1230ByuBQv
1QPa79R5EX8rxaB8n8lX2WHWuQfXZ7J+l+J44aZTWyTLKIHfvUCUgvONiIsa
2MpvoBfgPW6+F1roSfzvBeTd/ArPh9VR/HJHvAC1su3mvgxl4ocvEDRbxN9q
oRfmvzKqVOl8Ae/9K2z6nsZQAn8sw1N371QRCQ7rp6l/ynKFMhgW5J+Vz9Mg
flkGq23Z0zUT5EE/LHKpbxmGJc+woqNdiH+W4Q8j83MV1JO5zIbK4BlwUIM1
TZv4aRl+mhfOa60wR9hpRbpk5bhrfuVk13WK+Gs5rtUnn5v9eSF2MuW1L0d6
+K0TEuZSxG/LEb7u9aQ+9Wz+1bPuliPJg1XubzqN+G85xlSOGtqZ/IO1iFaD
5IdybPbiGUp0uhA/rkBMb+DzyQ2TMZrudnGNCnyX01c2t7cn/lyByh4tb+lM
TXSE0S8KqEDKnETqqo8d8esKfJHozkhKs0DW91O0AisgHDPk7S4+jfh3BfqZ
tsupoCKZcs6sRMIH2tjePKIEfl6Jj5djzyRct8Z+fgNUIndZdKs8zRcCf6+E
vNAP+38d/mNZrFKhLaMSVRqrvVqK9YjfV8LSfMnCC/pOoFW48evXSkRm38q5
vkGP+H8VSh5ZhiycZgaR8fdMvhhUIfBET877mWtIHlThRIl8/J8TnujezWy4
CjYtlZYdFywIL1XBlhvUu0Wkk8UvX0sVKs4Ep3XaOJK8qELyV7/BxwtscVPP
8kevfDWatGt7qzWcSX5U44m8991jTS44/PBs1+vd1RBjfDCnhuRJNS65HBmW
VVaC3TQmUapRe6Nfv1pEjfBYNfhCXnaOUuEbZg3GrX+lGcbTI3lTgze930T6
S43Bt2/LGkx+yTXcOdeW8FsNhLIdBoJHW6KPKdcN+vNDmou7ThqTPKqBr37t
meFHKihNj6MdpgaKY4I9Jh/UJvlUi6Fgr3uT5sojWoZpkFr4yq5dueLCQpJX
tZgbuEKZF+eE40Fzlr84Wgs27Su2LDbJr1q8HWFvPjuoBpdBW3qHtdj/6Wde
7llrkme1YLrGMTaemkvf7T6hDs5GFZkFgwtIvtXBequ/nNYxNQTT1WtXqsNH
BzPu2lxJknd1uGJgaWqdPhpfGfu0rcM9buv4ObcMSP7VIT+zqzIvxQNb6O5p
OVyHtN7Ek54FuiQP62DRs6LkePU68Ldzuw57Zt82TOleQPKxDv0TRCq8KvTA
uGdTcR38F3WuUZHYwhLkZR28jIaFR+b1sJj0sOmrg2VC5pTNKrYkP+tw+JTG
htxaSzDpyRZjw29t+0SZUiuSp2yI1b3iTvDRxYW6REmLVWzQTdY6/vQQyVc2
+Ks0iqR+MO3lzMaMdLc2iwAvkrdsbA87cGOhryO2UW9+mPqzIcky1H+pYETy
lw0V+jrFSZ+o5v7RA2WxbPheDk9d18EieczGNWlhkYR/zGDIP2A2lrYrtoxK
dif5zMZUOke7clsp/vY/sVEYm3Q3oNyZ5HU9voUf1FYOtQLf7mfUY3Ktjc/u
jTYkv+shuepVnAnPFKHPfemOq8dWkZH2yWekSZ7XI+FAN3en13T83n/pEcuz
HowKlNOvUIJ8r4c2fSqrRQqpHXxDqYcf83H/XUqQ9/VY5La3dTjYEa28ygit
xHqkBVxWW3TeiOR/PQZ85CxXJNlDsN16vo5Fo8dpCXigHuI9gWee9moi3XDs
v+oj9bBq5lwL2zqb8EED5tqUVI17rQG+HcxtQM74sDlXgq0JLzQg/JB/lc7W
BWBWr6rfgH0fpm19qW5J+KGBzyUxLkPUKC/mjgbMCqa48ydvIDzRgEjFshOy
/e7YLXXIWOlCAz7rd01Z1W5D+KIBv3rl3di/XlLtzPZSGwTnLJJBeKMBS1Vm
GtWoLsY6Jp64DRCixP17tugQ/mjAiR1K8/oKTZG5kiko/fwQhwinHlvCI42o
dWYa04diMGaRXCOUByLvSEpaET5phJi1j4m+tyIu3xpPOyh9vVvP1jdPWIRX
GnH3QaK82CoFjOEbZiOYVV24lknm6UYwu0iyraf2MT+EN+L7cLVN2REHwjON
aPjo30bVGOMl7XbSmY24cGVOQwZrDeGbRjiolGiHbjCDOWNfHY0wplPaYWIe
JeCdRqQypyBURzFpN2tMEy4777FLfreW8E8TaBOSmXHtFaXAD+gmVIXtdDGb
oE94qAmv96c4y9zXA0M7khZNmDPazqzuyt95rQn93nLn74lO5e8j/EATAiUs
BtUe/OWlJhSrioukltjBl4nT601YWJ+78Oo2dcJPTRCmbfbswgzqdfyiMxef
N4HVVLzngGYmJeCpJnzVbdff0WcLK37Bm2ARX6Rw7koZJeCrJnQt4OrXSC/G
86keNFlx8EmlOtjLaSsEvMXh+7ZMwxuKb5/KHGRkRv6adnuA8BcHCVcUzm4y
0wV/uXYcSHWtMWgaZ0p4jAPN9nkuadvXg+4qugM4MGGCLauUEvAZBwopkR7i
Sq441F2vefIOBxdjVHWGYnQIr3HgeeugQ7jSH9abqwPLRpVy0HV3/v19E90I
v3Ew8uGPsEKJLmzXT5I5/p4DpVjpNbs1lCHgOQ4mO9kLObhbopCxS/FmrHUz
u/66cRWZZ5sRsmpmvkGZKvjLU2/GdNXn3Tsm8VgC3mtGGy1zLf1XFD/+XZpR
/GH1ZLdL5oT/mrFdTP61ITUNzNsPnmjGj6rm2Bfbf7IEPNiMHINNu137jcGo
68v9ZtgPb+9952dM+LAZWZ8Ne40HvfAukDmQZgh9eytdftSV8GIzljxqHbVt
uQYcGHscbIZhv0vs9CeOZL7molHbcHXLQ0uUMMuR4mLouZBjqqQxBDzJxQkv
1pEtFs5Qi51CoxEXc+hUj8oupAR8ycW+dXWX7IJcwfx5+0YupuueLufFrCC8
yYXxgGnU79GaEOMbOhfVjOFLf6EE/MmFharHfN/nnvBjuDmJC7mUVTVzMjwh
4FEu2K6ioj/+c8AHvh1yIdznbvRypSPhUy6O0arakM2hnPmAxcUqq8++lneW
EV5twea7cqtljrijjMEV6RZ+zr/XaaIE/NoCf4lF37nz9KBO08kGgxZ4/Roy
3LjOhPBsC9KNqlXffDEGQ2c87xa+LrYIDVICvm3BklltXZ1Ki8HQqXMIfb3f
LlE3780Q8G4LbGjb4bCfUPxqprXg22/H5l01awj/tkDnltEEufVuELyuBcwu
NU1SKAEPtyD1RGw8T8gKbowb/m7BJLqxerybKAEft0LT+bu2VpsDKum0s5Zv
RXZp+pbvHfaEl1vhM0334ND25aBO3hmuXduKIzXekklfvAg/t0Im+UbIIbYX
Hmgwht8K5/hxN9ec/ckS8HQrcpxWTxrOnA++3UW04sCkI93jbVQIX7fCkOdN
vXHMEzw+qxXtbssOV83RJLzdikulz6xeLHEAH686W+E5wbl2daY94e9W/Ihw
arMpsIQHv8HbUP7fucxEcT0IeLwNrtZH1T0WKaAm14x2njZ0S58X/+UD8v+W
NiR4teZitx10GNyybAM/dzanUAJeb0OQzyMl4TwPPGTszbcNcmtCZ5VaWBN+
b4PURe55d1878B93ow1URr6CpIsdBDzfhuN7536US10E5u7s/DaEn/dMi7tv
Rfi+DYYuhxr1da3AqIN60waZeOl+Dys3wvtt+L5FQtKT9jOm+zNEedgVMSVz
7XJLwv88jP6ZkHj13BawGbxS4cFUJf3a2J+eZB7gge/LnWxKEAg8vIt90h9V
607mAx5SHyqKOXZYI4m5/SgPqqL1clHX55N5gYfjTMyYd1NzKnzokvOwZIyd
7CWpJWR+4OHtoE5Hif1a0MWgAZmHMNmqOSZzZ0EgPx4mfLrhHn/ZCCOqjAHw
UCJzf9zcZisyX/CwrcAnXpyjDT5OTW1HJEw37OK4k3mjHRerTm1kh7qCb18a
7ZB7HXn1i7YdmT/aMbRClvPvYwXoM5e7tePI0gXrlALVyTzSjg906q/MLqGS
xzAn1I5zezMfbW02g2A+acek4qA7o/dYYR4fINrBdKW2eRMlmFfa4ZfqbcLR
kgUzTURVt8Osx887/o4xmV/aserzo3+exnmAj0+f26ETc/NZzEs3COaZDhzv
jHtVGs1h8e1qZgfyLzXrfvJVJPNNB7a5bQoKOqcG/sesDlhqaYodWSFN5p0O
JHUEDBSVbIUhnVZXvDrgmWfyxy7cicw/HVBkjLKhk0qjaWT62Q50+ewtkrhh
Q+ahDtxba3ZPd4M9ZGnavPSoA7fPivTsCfQg81EHnodPm+/O9cBFPi51IFN8
8g5o2ZJ5qQM/B47NtNy6GHx7+taBqrcD63nf//5/rxOypoHKDQ5G4P8q04nz
I18vHSimyDzVCZNKFfdj1d+plsN76MjtxIR8xdmxUlZkvupEIdfRoF9oLIz5
guiEYVydYtw0KzJvdeIYXcbTiiNU+iu+kPFMNCdGTKKdzF+dMPDvPj1yzBHy
DB497cS1J8Kc3bNNyTzWifjF1dcixs7FJb4ddSLqlXAX+40nmc86EUD7apzK
W+p/LTH+iw==
           "]]}}, {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{True, True},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{
          FormBox["\"Pot\[EHat]ncia (u.a.)\"", TraditionalForm], None}, {
          FormBox["\"Frequ\[EHat]ncia (u.a.)\"", TraditionalForm], 
          FormBox[
          "\"Espectro - \\!\\(\\*SubscriptBox[\\(s\\), \\(3\\)]\\)\"", 
           TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 0.4988558352402746}, {0, 0.0029019190661435297`}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.02], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {967.5, -358.76873046931394}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}]}, {InsetBox[
      GraphicsBox[{{}, GraphicsComplexBox[CompressedData["
1:eJzt1flL03Ecx/EVlmmhEaMWWWqYiZWpbTnz2GvN+1imJVl2KJ0Y9UO5PCpn
WaakqZXZZZFmtrRDLaNb6U4zoptqiZ1IFh2CZNI3fH+D7/s/CByM8djz8/nu
u+/25uuYuDp6SX+ZTFYnPP++9j6+ap55Bd7Lirpxld7A7Cdpr5XPi8mDYLmm
Jqf9xQXyUFzeZKHcPK+aLIej2fe9LC9L02sFfkSX3NqvN1G3g/uk0MIE+4PU
HVDa3vyx6VMceSzyPGJ3po3eR+udAOvUUnm/TLIz6sfXBMTW5tJ6F5TrOy86
5YjrXbH3TYS/Y88u6hOxQl2lODVOR3ZDkn9rirGynNa749yr79/Wdhwke6A4
WJ4/9+dGsifetex5Fzm5iPZPwbpGQ9uM+kKyEnPK7v6+uryC1qtQ1/KgdZai
nPpUHC6IcZk8YTnZC/bdbts2J1WQ1ShbMWZhl2Mt7ffG8KCH2U+zxPOZhmu6
3VbJn/PJPmhoNr666Swezxe61stLDikOUfeDz5XMzhF+Jur+qI5cVdZqkU3W
wPq4Oj/xuvh7Ak8XtqUss6XvZwSGFSaVqN4fpa7Fo4C349ea8qhrobe1Tk9W
rac+HZcM9vNjryX22jgdBU0DvzQEGejzdLDssUqN8j5CXYcGWU5Laa2RegDM
im7t+dO76fgBWLx/gd/jH+LvE4g3Gd9fDklJp/2BuKO9PqDjwxbqQci1mRmd
ve8w7Q9CKmK6Ti4Sr2cwEjxX3jdkbKcejPSuvWbzhxPUQ2B3X+2VZjxGPQQ2
8y62VZgq6fxC0bBVrjEbTlMPRWN12ovnq8T/Vxie/HwQ4lG0mM4vDIkbzt47
4Cpe73AsaEyoSvol7g9HZfNgyzibHdQjoF26SGlqWkc9AtEj21QPfQ9Qj8SW
bWdyP92m62GMxKgi01y9QyZ1PZKj4h/1xNfQ9/lK7/97QMpBzEOZ5cwKZjtm
B+axzE7MzswuzK7ME5ndmN2ZPZg9macwK5lVzFOZvZjVzN7M05h9mH2Z/Zj9
mTXMkNrILMyvtDML8yvtzML8SjuzML/SzizMr7QzC/Mr7czC/Eo7szC/0s4s
zK+0MwvzK+3MwvxKO7Mwv9LOLMyvtDML8yt13/237/7bd//9H++/fwCXSV2F

         "], {{{}, {}, {}, 
           {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
            LineBox[{61, 1}], LineBox[{62, 2}], LineBox[{63, 3}], 
            LineBox[{64, 4}], LineBox[{66, 6}], LineBox[{69, 9}], 
            LineBox[{70, 10}], LineBox[{72, 12}], LineBox[{75, 15}], 
            LineBox[{76, 16}], LineBox[{77, 17}], LineBox[{80, 20}], 
            LineBox[{84, 24}], LineBox[{85, 25}], LineBox[{86, 26}], 
            LineBox[{88, 28}], LineBox[{91, 31}], LineBox[{93, 33}], 
            LineBox[{95, 35}], LineBox[{96, 36}], LineBox[{98, 38}], 
            LineBox[{101, 41}], LineBox[{102, 42}], LineBox[{103, 43}], 
            LineBox[{105, 45}], LineBox[{107, 47}], LineBox[{112, 52}], 
            LineBox[{118, 58}], LineBox[{120, 60}]}, 
           {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
            LineBox[{65, 5}], LineBox[{67, 7}], LineBox[{68, 8}], 
            LineBox[{71, 11}], LineBox[{73, 13}], LineBox[{74, 14}], 
            LineBox[{78, 18}], LineBox[{79, 19}], LineBox[{81, 21}], 
            LineBox[{82, 22}], LineBox[{83, 23}], LineBox[{87, 27}], 
            LineBox[{89, 29}], LineBox[{90, 30}], LineBox[{92, 32}], 
            LineBox[{94, 34}], LineBox[{97, 37}], LineBox[{99, 39}], 
            LineBox[{100, 40}], LineBox[{104, 44}], LineBox[{106, 46}], 
            LineBox[{108, 48}], LineBox[{109, 49}], LineBox[{110, 50}], 
            LineBox[{111, 51}], LineBox[{113, 53}], LineBox[{114, 54}], 
            LineBox[{115, 55}], LineBox[{116, 56}], LineBox[{117, 57}], 
            LineBox[{119, 59}]}}, {{}, 
           {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
            0.011000000000000001`], AbsoluteThickness[1.6], 
            PointBox[{121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 
             132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 
             145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 
             158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 
             171, 172, 173, 174, 175, 176, 177, 178, 179, 
             180}]}, {}}}], {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{False, False},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{
          FormBox["\"Correla\[CCedilla]\[ATilde]o\"", TraditionalForm], 
          None}, {
          FormBox["\"Semanas\"", TraditionalForm], 
          FormBox[
          "\"\\!\\(\\*SubscriptBox[\\(s\\), \\(3\\)]\\)\"", TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 60.}, {-0.1665197365313691, 0.06633637388746069}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.05], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {193.5, -597.9478841155233}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499622}], InsetBox[
      GraphicsBox[{{{}, GraphicsComplexBox[CompressedData["
1:eJzt1Y9PzHEcx/FYdNamRiiSSj9OpXVXXT91r35dnUoJI2kTZdaOYrFm4SgK
UX7VbKUIJTFt1EoJ69fE0EjNxlzG/Eqywyh8rffZvu//wNZ3u90e3+e+n933
+733Pnbr0uNTJxoZGV0TPn+/x44hZZ9PeHduXHsrnUBJcuvS+atryBJgxwaF
6ehNsjlsAoaTFFFNZAsMNmSN1s6oIFtC1hYxuafnGtka12MbNRmDR8m2+OLy
eqtV1yGyPX5E7/OdalxNdkBxk0mh8UPDek54mZ24sicJZCn0HR++2q06T3ZB
ik9G6UZ5HNkN5p6yLarqFLI73k9Z3nlEUkv2QJ287+MTf4NlWPFdtzP7VTlZ
ju034jY75R0he0K5pkxyvzuN7IX8jhpb6dQrZG9YPO5PHRjaoxyzAvWKpC1p
lalkH7SrvvWOpFeSfbHtuT71dH4dXe+HAsmA1K33Etkfc+Xq6KtWhvsLgOu5
8sR+u1JyIJaVzxtZUGK4fhHuqdrrjeMP0/pB6Mx59vW5JpO6EhW6BAd9rGE9
4NZyVf8k07Vj1gLTvOfNzrUxPP9g/Oya8HGOpoR6MHSuu9/FuR+nHoIDnTMf
ZG6m96MNQUtbz6sWj2LqoVC/3/W2JaWKeigSR3SjrvvLqIfh4VDWaWdNAfUw
DBaNTLsdarifcKydPN0+ax29H2047O/WH1xQResZqaBJeH1VF0nvR6tCgUlw
vMP5ZuoRsHRO6p8VdJF6BN4NX8zLazL8XyPht+R64IPCC9QjUXRQemzfJnPq
atQ0F/dJNpWPPU+tGrIdv5+GmWXQ812M3jth2SfuOVJfjMZfbxbml+2lHoUc
acSL9OQG6lE45fhZXWdzmXo0MrsVyY6/q6hHI3cwUm9WXUc9BiEvTAIededS
j0FjrD5kffMZ6ktw8tMHu8Las/R7h+j8vwNiSpjNmS2YLZmtmW2Z7ZkdmJ2Y
pcwuzG7M7swezDJmObMnsxezN7OC2YfZl9mP2Z85gDmQeRFzELOSGWJrmYX5
FXdmYX7FnVmYX3FnFuZX3JmF+RV3ZmF+xZ1ZmF9xZxbmV9yZhfkVd2ZhfsWd
WZhfcWcW5lfcmYX5FXdmYX7FHt9/x/ff8f33f9x//wCgo2xL
          "], {{{}, {}, {}, 
            {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
             LineBox[{61, 1}], LineBox[{62, 2}], LineBox[{63, 3}], 
             LineBox[{64, 4}], LineBox[{65, 5}], LineBox[{66, 6}], 
             LineBox[{67, 7}], LineBox[{68, 8}], LineBox[{69, 9}], 
             LineBox[{70, 10}], LineBox[{71, 11}], LineBox[{72, 12}], 
             LineBox[{73, 13}], LineBox[{74, 14}], LineBox[{75, 15}], 
             LineBox[{76, 16}], LineBox[{77, 17}], LineBox[{78, 18}], 
             LineBox[{79, 19}], LineBox[{80, 20}], LineBox[{84, 24}], 
             LineBox[{85, 25}], LineBox[{86, 26}], LineBox[{87, 27}], 
             LineBox[{88, 28}], LineBox[{90, 30}], LineBox[{91, 31}], 
             LineBox[{92, 32}], LineBox[{93, 33}], LineBox[{94, 34}], 
             LineBox[{95, 35}], LineBox[{96, 36}], LineBox[{97, 37}], 
             LineBox[{98, 38}], LineBox[{99, 39}], LineBox[{100, 40}], 
             LineBox[{101, 41}], LineBox[{102, 42}], LineBox[{103, 43}], 
             LineBox[{104, 44}], LineBox[{105, 45}], LineBox[{106, 46}], 
             LineBox[{107, 47}], LineBox[{108, 48}], LineBox[{109, 49}], 
             LineBox[{120, 60}]}, 
            {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
             LineBox[{81, 21}], LineBox[{82, 22}], LineBox[{83, 23}], 
             LineBox[{89, 29}], LineBox[{110, 50}], LineBox[{111, 51}], 
             LineBox[{112, 52}], LineBox[{113, 53}], LineBox[{114, 54}], 
             LineBox[{115, 55}], LineBox[{116, 56}], LineBox[{117, 57}], 
             LineBox[{118, 58}], LineBox[{119, 59}]}}, {{}, 
            {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
             0.011000000000000001`], AbsoluteThickness[1.6], 
             PointBox[{121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 
              132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144,
               145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 
              157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169,
               170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 
              180}]}, {}}}], {}, {}, {}, {}}, {{{}, {}, 
          TagBox[
           {RGBColor[1, 0.5, 0], AbsoluteThickness[1.6], Opacity[1.], 
            LineBox[CompressedData["
1:eJxTTMoPSmViYGAwAWIQXXpLQ5h5yyc7UZ9r0ycHbrT/Vr9o9xl1RQcY/7Bf
0oTT6oZw/iGz52/rHzjC+QZfSl6E93vB+c4Z/tu8OgPh/J3Xvn10Vg+D881k
uCRiyqLgfIZH67efU4yH8+ffFuTbdTsRzj+4sdFU5n8ynM95YtfM1QFpcP7V
k5rFp6oy4Pyoy//XMc3KgvPZZOerZzzPgfNNg0pEY3nz4fyjyZwL9m8ogPN9
lHrSYq8WwvlTr6187vSsCM7/qKXDbs9XAufzlXo+bFIqhfPt4k9H3vUtg/O9
zzY0Hykuh/OlDC+mf26tgPP/mLS9slhfCecv0LumfuxIFZyvsCZS7MGVajh/
y0nHxQJ/ahDhcffIqw7+Oji/cMKaC+JW9XD+7cePN8/Ub4Dz43/ti/HegeC/
STgT0uHTiAg/J3Wtl9cQ/O1PpSMmxDXB+bI3na4e+ojgp7hv15esbobzt7LG
3fzF3wLnP7MLSmCYjeCzWT2w91FuhfP1WxfkKW9H8C2911XJObbB+b6J764u
uYbg+1ue6CzMbIfzjXreSyV9QvDl9T1/323rQPjP58OOWsFOOH+FjuH55JkI
fm7MEpOrOl1wvjB7annWNgT/SBOruSlzN5xf9m/pt//+CD4AwvB9xQ==
             "]]},
           Annotation[#, "Charting`Private`Tag$227139#1"]& ], 
          TagBox[
           {RGBColor[1, 0.5, 0], AbsoluteThickness[1.6], Opacity[1.], 
            LineBox[CompressedData["
1:eJxTTMoPSmViYGAwAWIQXXpLQ5h5yyc7UZ9r0ycHbtz/rX7R7jPqig4w/mG/
pAmn1Q3h/ENmz9/WP3CE8w2+lLwI7/eC850z/Ld5dQbC+TuvffvorB4G55vJ
cEnElEXB+QyP1m8/pxgP58+/Lci363YinH9wY6OpzP9kOJ/zxK6ZqwPS4Pyr
JzWLT1VlwPlRl/+vY5qVBeezyc5Xz3ieA+ebBpWIxvLmw/lHkzkX7N9QAOf7
KPWkxV4thPOnXlv53OlZEZz/UUuH3Z6vBM7nK/V82KRUCufbxZ+OvOtbBud7
n21oPlJcDudLGV5M/9xaAef/MWl7ZbG+Es5foHdN/diRKjhfYU2k2IMr1XD+
lpOOiwX+1CDC4+6RVx38dXB+4YQ1F8St6uH8248fb56p3wDnx//aF+O9A8F/
k3AmpMOnERF+TupaL68h+NufSkdMiGuC82VvOl099BHBT3Hfri9Z3Qznb2WN
u/mLvwXOf2YXlMAwG8Fns3pg76PcCufrty7IU96O4Ft6r6uSc2yD830T311d
cg3B97c80VmY2Q7nG/W8l0r6hODL63v+vtvWgfCfz4cdtYKdcP4KHcPzyTMR
/NyYJSZXdbrgfGH21PKsbQj+kSZWc1Pmbji/7N/Sb//9EXwAT2aXxQ==
             "]]},
           Annotation[#, "Charting`Private`Tag$227139#2"]& ]}, {}, {}}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{False, False},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{
          FormBox[
          "\"Correla\[CCedilla]\[ATilde]o Parcial\"", TraditionalForm], 
          None}, {
          FormBox["\"Semanas\"", TraditionalForm], 
          FormBox[
          "\"\\!\\(\\*SubscriptBox[\\(s\\), \\(3\\)]\\)\"", TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 60.}, {-0.1665197365313691, 0.09133052064058415}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.05], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {580.5, -597.9478841155233}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499622}], InsetBox[
      GraphicsBox[{{}, GraphicsComplexBox[CompressedData["
1:eJzt3WdUU1kbL/CjomKPY8PyauxY0DhYUCx/sWGP2LAgUaSKEjpS5NBjG2MF
68SOPaMojKhz7Kg4xo6KGuuggsQCgvVyF0/uWjzf7zf8Mus3Oyf77PbsEtba
bef5OblXFQRBVUsQ/u9/y/+Zhiy6eSHpfn7Lf+h/oPmIec2cCgvOlNMS6Xfq
CuuSG1K6DHcn9dvY174auTEyR9ko9PkPB5fbCo+7vnq7z74KpbeCtuauHbca
faJ0OdZHtk/QlerJ7RAcvCY/vOUHyq8D/t4+vbj7qHvkTvD0PVy8O+oZfd4a
Y1u07Vp1nvnzXfGp14zo1+I7Su+OFn2iHAqabCT3wJ5gJ1m67Bt9XoFPm159
D9v8idwLw9y/ROpH3SH/jkb385q1u/0fPW+LtKhh3/P7mN0bV6I3L/w+6wd9
vg9uuCf+dWfyV0rvC9vTXau12f8PuR96zq/vvdn1B9kOy7yqf5M1rEX10x8u
5/ZGjZ5mfp8BOPv1weB4h5dkezRokJLlvMv8fQNx5H6fOtfmfKb0QVggb6lX
KKoMKfdg/DjVdPky6yf0+SE43f9KSu075vYEcuY7Gafto/KIgOgyzqdI/53S
hyJkw6WP+YteUPpQuG/O6rwh/BalO+Bx0oicjqszyi06YFbVosDAntcpv2Ho
XO+h/xDjF0ofhn3rnH7pn92l9OGYHNqi7TOffPr+4Xj5PnN6RpC5fUZgzNqM
5bE/b9LzI/BLl6DueyyX0kci9GYvx5tSET0/EnWPBKzq72auz1FI/y/llOzA
c0ofhU5Xdk8/P6oqpTvC86DtzLCrPyndEdkb/tSvshao/kbjfd0xXVqsqV5u
cTSeHJnRoufFt/T+Y9DL4LE68tNJer8xSGp0Irh0hrm+x+LNMdX2c0Nq0PNj
8V05sqiB80tKH4dxn9oHjO5xg/Ifh+Dt5696RX+k9PEYsP2dv4091Yc4Hh8j
Rr1vor5H6RMwLGv9tZ/1LcvLI05Ak9BZrZ+eMfeXifgtvDT1wD1z+SbC6Bgb
MWXnTXpeiWpVoq0WHyVDie5XmvTWR76g/JSIP78uoYXs73JLSuSOxMAhR+h9
hUno1NVJ7mR7i56fhDsrBhRbRhfR85Og7J/c8GzH8/T8JJh+O7P34ehEej8n
DBvn2nusN41fOKHhoNUhtUqp/kUnnC8Y8Ll+h+rl5ZOccHRdZsMDZy2ofSaj
VrNatocdqT1R5rZOrVbY/kvlnYzLp3tPGvDuabmlyZh1xuPOx8/m9puCzP6/
j7yR/5ryn4LJ1edetKlC9SdOQd/5LqUND9H4kqZg3MAlfZZNfUzPT0VY3mZV
9PtrVP6p2OCombbf+Qw9PxUd9h1+1bEd9R9pKk41bW373cccD6fB5shW0cGG
3gfTUDSyRe6J0v/o+WnoNyD/8MGsh5T/NJy+tuR7jwY16PnpqL17/8ABVw30
/HRkd9mwMbT1Nyr/dCQtOnF0YIvaVH/TcdNuRxP31I9U/86w/OFjcbMfxVM4
o3O/U0L4d7LoDM8++8YHHjRR/TnjVHOXLZPO0ngUZiB+7zrxWtp5en4GxI13
Pb217+j9Z0A3BHV7WpjLPwP2g/O+RdQ2x+eZKE5MbLpNR/EOMzG90bNDMUcp
fokzkZ3fybXXhDeU/0zYf7+0slP/Enp+Fpq90T/22EjxCLNgZcj8OuGHuf/M
QvP6k0a1zaH4Is2CJr5lt6T71J+E2cipK3dueKuYnp+NeJ9pTaIsqD+Is9FJ
Pzqu4096H2k2uh7r9O3zBEoXXBAy3HTR8l9z/3HB7adHMv9nNMcjF3SbuuzD
2g9UH5ILApzPDFt90tz/5iBX9759ng3FW8xBz6e/NtWJpvlRnIOcPYl/fep6
h95/DryPfwp5d8Ucn12hs9kzfJOaygdXtHudty6yGX2/6IrsZrl7M2aXUP6u
GDvwQPPTLc3xRYVsQ5M+9ZebytPlKozPqzdp051c+j4VTrRWbn//jNJVKow4
udRi4IsC+n4V0jof2G8RSuk6FWo80fmOW0PjWVJhdbRNz62DqH6MKlzc7Oo0
uOMvyn8u5kX2n/ulCdWXfC5+C2nl0+ENfT/m4qCbrMOx32l8q+aiXWynVptj
S6l95iJ1+4V5Kee/l39eNxczdjyfOWvrU8p/LnI7f2yX1J/a1zgXLXY9bxO4
hsaHMA8B06qe6Fv7LZV/HvInxu0r3ZhD+c/DlRczHv+o9oDKPw93hx5emduU
6lOch9zMb+P+jKT+oSv7PsuX1f3z6tF4m4cLXYK6b00Qym2ch48Nr267l/KI
8nfD6jB1Y+dQag+5G2b9XXP5g17U3+GGu2jetUpL+n6VG4q/+0+YonxF+bsh
+8GbI9seU3l0bog8tcB0eJO5v7khzOmz6cSjeuXPG93grqpxYnuty9R/5uON
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
FswsOVaLxqO0uCweHuz0XyC1h2Ex2gaFnY31o/o3LkadvWkFhz+Y238x/rXP
Hhxva/69JByl7RMKDr6g82FZOE77ryiSdaT9sTwc9yz+sDnTmuYXRTi8itW3
frei+kU4whtXe1DvEa1PlOG4XFJ6KWAorY9V4VjwuG3vF33ofdThmPdvR33/
fPP5RTj6rnN+bmxF86s2HO+/jrVedIz2d7pwNJNuHJ6y5zCVPxxHc892CxSu
UvnD4bl108sDD83tHw6/1iMjD6037zfDsf/jsoF75anU/uG4731gsWszc/+P
gHrvlsTjPal+ZRGwq3vEde0iOv+QR6D3t7ujPPZTfFNEoMVDJ+uPnhSvEIF7
BwZuf3rJSO0fgZfZK65HfTTvVyKgPN8wp30jijfqCIS7bbU7vZfO08UI9LR9
+r/GV2g9oI1AwXWnpr1TaP2qi0CDhU0LZ4+g+KGPwG2PPR7xIbR+lCIwKLu0
2549l6n8EWi+td2EN3I6TzJGoIP9RbsbKbTfNEXAdK3YNlKg/itEIrvgxaAL
o2j8ySIxpSDjQszcVdT+kfiWFNrBaQbVpyIS0REnIxO/0/k6IuHcb0fxjke0
nlBGYvk/dT7OyXlC5Y/E1rr9e/7lQOf/6kgMvdv8lettml/Fsu/7kn4o0ME8
/iMR/isz+d4hOu/RRSLXtO32nvrUH/SR+LIxQdFoE32/FIlDOYkPPCZS/zJE
QhbZZI9bsjn+RcI3fPOyZdOovkyRuCwqW5cGHKP2j8IVm4E2j1pSe8qiMGXl
B7+2vWg8yqPg7aLp27CA+rMiCodWxbYItzPvT6OgKk7LtJTTeYAyCvFD7m0o
Hm2e/6Pg66ktPNSW4rU6CvW1kc+fiuup/FFolvp0190zNJ9qo2C9b0vwrSrm
87QoLO38fcmwKFpv6KOwxeNiC83NExT/opD/OmdBu2AaT4Yo5Ay6t3JbbfN5
QxQKtd1HNx1E8cEUheUf1rx85kT9TViCu7VTXRUj6XxEtgQNv007t7aI1pvy
JYj/Vtq0vd4c/5dg6eXl//wMMJ93L0F66KlX6+1oP6hcgg/yW8mja5jH/xKc
qKpb5m9N86d6CUJcf4wbtCaT+v8SLOsydVzxeYpn2iVQ/Hawmo8r7S90S6Ba
WXzV1f8wtf8S2Iz4VWJh3p9LS9DH6bL/6wDafxvKPh88cvQKa/N58xJM/3yo
WkfRHP+X4P6V9F4zvM3nj9G49jLd+uNG2o/LotGrsdv434rN8180PBwDRo+a
SONFEQ3XMcdCExaa9z/RGPkhdnCLDvR9ymgsyI85/+XIX1T+aLTJ/N+DjI50
fqaOxreC0jbtzc+LZc/Psz0WqKHzHW00ikbP7+rSgNYHumg4nUPOM39z/I/G
jfjgm9Pq0n5fioaqakHCp9c03g3RmJJUJSp7Ob2/MRobs2uOeLKC0k3RePPe
vYVmn/n3GxEHv47VHYyh8WcpInTjk4mDSqj/y0Tser/D9Y+ZFC+tRIyWFf+1
plUO1Y+I1teGlPxcTePTWkTYx53tj1aj/q4QIS0IuX4lgOZ7OxETMjv9NDSn
+oCIXnHtqupm0/mko4jA7MjQ3Zdo/6oUMe1jHZ2+D7Wfs4gxE5/HbmxP+3OV
iNqNmiy6H0TnBV4iui3qe3dHF2oPtQjZzKWr7/xD4ytMxPXGc7SN839S/yt7
/6u7Lukv03pCI6Lp1JHvjb/T+lEr4tSfVTb89hvtF1JE7NnaxslVSZ/XiTh6
SLMxc8KU8vTUMp89v6fvBS31VxGTh6ULp57SeMsQUePWw+sjMql9JBHNj4/a
30xBv59lifhzcYjb/j9pPjGImHt4qbxRY9oP5oho8XHNN0UTms+NIpbN+VHD
YyytR/NEXFkYm2vwot8/TCIK0nsX9Eig7ysR8fnlpinVu9Pv1UIMllr9LXtc
j8anZQyqJPY9JttD6y1ZDFAjLt/vHsVXqxi0y4+Lv3D8ArV/DMKrLwl47kn1
ax2Dn2Nf3rihMZ8XxaDtrxIrnQ+V1y4GmzPWyxsrze0fgzXfdj1wdKD9uGMM
lrUrqebXmeKHMgbjnuz/N2A01bdzDN5W+8+1S33ar6pi8P6Ns03NQzQ/ecVg
ucL37D+Nab2ijkHvqa3Wrf1O+82wGKRc6dylSsR2Gn8xcJvx94JrJfT7mSYG
3gc19mljaL2mjYGsfkba9vm0nk+Jweg1cePsfaj/62KwK37Y0U3R9D6pMdj7
R98tiYepvfQx2KCOTV/sS89nxOB/59uplypofEkxcCxc+OOnJ+13smLQqCR2
55c5NN4MMXBIvuLR4hHFp5yy7y8KmThOQednxhisPv3u58gGtP/Oi8H5C8Zx
wfdoPWaKwbErvu8NjvR+JTFYUJQxwr8n1b8Qi3o33k2K7EDplrFQT/pj34AF
1J9ksfhYcLP2yjR6f6tYrIwvPFmnIIvmh1hY2Pi8v76O1gPWsUj+789PYeb1
kSIWj16efrHNif4eyC4WR75tnXIo0vz3BmX5pTzZWmsDzU+OsWj+yuQWfco8
n8aivsWNqX99pfWqcyx+De42oG+u+feAWOxeuqt3owHU3l6xaO3w7vwm4zFq
/7L3v52kaDWP5oOwWOiePpSt60zrWzEWDonLD715ROsTTSxqPDakDphA/UEb
i23a7Q9aZNN6MCUWXhYrQg/bms/7Y4GJp5x7eNB6LzUWbf7Z9nLRado/62Px
1+DcXX270fo0Ixa2BbXsxp6l34+kWLyyWX4j7Sidv2WV1Z9bk22yarReM8RC
c3ih/YV+FD9zYrEzZtzh6O5Un8ay+gy9cPfRPZpP8mLR7Wf0gcbzaHyaYtEq
e59pha+5/cvaY36PrdPr0XpSiEPnrbY/T7jT+LGMg7ZRy4JZx2k8yuKwutap
9lNn0/xgFYd6a/fUumdH7yePwz2/6p3emujz1nGQr766NKOU1q+KOHS7ZmGB
07Ret4uDYJ32qutKWr8hDpnWePmiNfV/xzj8pn+ZJY03r6fjsP/VjhH3n5jb
Pw7RDi/c/+tA/V8Vh8fdI31jQPl5xeFt26x65x7SeYk6Dp6tmv+9qQ/93hEW
h7DfZl/3sjD/fhsHy/QehYtS6HxIE4d2D1vUKmxH/V0bhzGP60idAyh+p8Rh
ur3ikv0A8/lsHObsa9W4ej71n9Q4PK0bYpttpP6gj8PnL02btGlL8ScjDm2m
NqlVrYZ5/RIHxbaZK7tNpP6fFYcTS6aMaXKX1huGOIxr5fRg2bx0av841F3f
dffrheb1XRyG32nn+ry/uf3j8Gl3Z3eXVfT3RaY4ZLt99Csyn/eUxCFjcKBF
0W/mvz+Kx57hQyOsWtL6yzIejrc7XEm6Seetsnh0it800fIata9VPJo4Nx4X
fuwGxf943G766ND7IKo/63g8/m90wcUO5vPyeFzdpGjcvD21p108rI5d6fAr
iL4f8WhlNfjL5GG033aMR/8ak/fVOUjlV8ajwZjwyzNB849zPGZ1/keb0onW
A6p4RM9x23yoFq2fvOLx76UARe4tah91PHq8qnNsZhGtX8PKyrNUcXzZenof
MR6eSR01lk+PU/vH45t4pPnoXMpPG499wxuFGi/R8ynx+NpP1V6joed18Zg3
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
tcwpzDrmVGY9cwazxJzFbGDOYTYy5zGbmEuYhbiKtmSWMVsxy5mtmRXMdsxg
dmRWMjszq5i9mNXMYcwis4ZZy5zCrGNOZdYzZzBLzFnMBuYcZiNzHrOJuYRZ
iK9oS2YZsxWznNmaWcFsxwxmR2YlszOzitmLWc0cxiwya5i1zCnMOuZUZj1z
BrPEnMVsYM5hNjLnMZuYS5iFhIq2ZJYxWzHLma2ZFcx2zGB2ZFYyOzOrmL2Y
1cxhzCKzhlnLnMKsY05l1jNnMEvMWcwG5hxmI3Mes4m5hFlIrGhLZhmzFbOc
2ZpZwWzHDGZHZiWzM7OK2YtZzRzGLDJrmLXMKcw65lRmPXMGs8ScxWxgzmE2
Mucxm5hLmIWkirZkljFbMcuZrZkVzHbMYHZkVjI7M6uYvZjVzGHMIrOGWcuc
wqxjTmXWM2cwS8xZzAbmHGYjcx6zibmEWdBUtCWzjNmKWc5szaxgtmMGsyOz
ktmZWcXsxaxmDmMWmTXMWuYUZh1zKrOeOYNZYs5iNjDnMBuZ85hNzCXMwlLm
yvs/Ku//qLz/o/L+j8r7P8qfr7z/o/L+j8r7Pyrv/6i8/6M8/8r7Pyrv/6i8
/6Py/o/K+z/K86+8/6Py/o/K+z8q7/+ovP+jvPyV939U3v9Ref9H5f0flfd/
lJe/8v6Pyvs/Ku//qLz/o/L+j/LyV97/UXn/R+X9H5X3f1Te/1He/pX3f1Te
/1F5/0fl/R+V93+Ut3/l/R+V939U3v9Ref9H5f0f5e1fef9H5f0flfd/VN7/
8f///o//A6yWXzg=
         "], {{{}, {}, {}, 
           {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
            LineBox[{801, 1}], LineBox[{802, 2}], LineBox[{803, 3}], 
            LineBox[{804, 4}], LineBox[{806, 6}], LineBox[{809, 9}], 
            LineBox[{810, 10}], LineBox[{812, 12}], LineBox[{815, 15}], 
            LineBox[{816, 16}], LineBox[{817, 17}], LineBox[{820, 20}], 
            LineBox[{824, 24}], LineBox[{825, 25}], LineBox[{826, 26}], 
            LineBox[{828, 28}], LineBox[{831, 31}], LineBox[{833, 33}], 
            LineBox[{835, 35}], LineBox[{836, 36}], LineBox[{838, 38}], 
            LineBox[{841, 41}], LineBox[{842, 42}], LineBox[{843, 43}], 
            LineBox[{845, 45}], LineBox[{847, 47}], LineBox[{852, 52}], 
            LineBox[{858, 58}], LineBox[{860, 60}], LineBox[{861, 61}], 
            LineBox[{865, 65}], LineBox[{866, 66}], LineBox[{869, 69}], 
            LineBox[{870, 70}], LineBox[{871, 71}], LineBox[{872, 72}], 
            LineBox[{874, 74}], LineBox[{876, 76}], LineBox[{880, 80}], 
            LineBox[{881, 81}], LineBox[{882, 82}], LineBox[{885, 85}], 
            LineBox[{887, 87}], LineBox[{889, 89}], LineBox[{890, 90}], 
            LineBox[{891, 91}], LineBox[{894, 94}], LineBox[{895, 95}], 
            LineBox[{899, 99}], LineBox[{901, 101}], LineBox[{904, 104}], 
            LineBox[{908, 108}], LineBox[{911, 111}], LineBox[{912, 112}], 
            LineBox[{913, 113}], LineBox[{915, 115}], LineBox[{916, 116}], 
            LineBox[{918, 118}], LineBox[{920, 120}], LineBox[{923, 123}], 
            LineBox[{926, 126}], LineBox[{928, 128}], LineBox[{930, 130}], 
            LineBox[{932, 132}], LineBox[{933, 133}], LineBox[{934, 134}], 
            LineBox[{938, 138}], LineBox[{939, 139}], LineBox[{941, 141}], 
            LineBox[{942, 142}], LineBox[{944, 144}], LineBox[{946, 146}], 
            LineBox[{947, 147}], LineBox[{949, 149}], LineBox[{950, 150}], 
            LineBox[{955, 155}], LineBox[{957, 157}], LineBox[{959, 159}], 
            LineBox[{960, 160}], LineBox[{961, 161}], LineBox[{962, 162}], 
            LineBox[{966, 166}], LineBox[{967, 167}], LineBox[{968, 168}], 
            LineBox[{970, 170}], LineBox[{972, 172}], LineBox[{974, 174}], 
            LineBox[{976, 176}], LineBox[{978, 178}], LineBox[{979, 179}], 
            LineBox[{981, 181}], LineBox[{982, 182}], LineBox[{983, 183}], 
            LineBox[{985, 185}], LineBox[{987, 187}], LineBox[{989, 189}], 
            LineBox[{990, 190}], LineBox[{991, 191}], LineBox[{995, 195}], 
            LineBox[{996, 196}], LineBox[{997, 197}], LineBox[{999, 199}], 
            LineBox[{1001, 201}], LineBox[{1003, 203}], LineBox[{1004, 204}], 
            LineBox[{1006, 206}], LineBox[{1008, 208}], LineBox[{1012, 212}], 
            LineBox[{1013, 213}], LineBox[{1016, 216}], LineBox[{1018, 218}], 
            LineBox[{1019, 219}], LineBox[{1020, 220}], LineBox[{1022, 222}], 
            LineBox[{1024, 224}], LineBox[{1025, 225}], LineBox[{1028, 228}], 
            LineBox[{1029, 229}], LineBox[{1030, 230}], LineBox[{1033, 233}], 
            LineBox[{1034, 234}], LineBox[{1035, 235}], LineBox[{1037, 237}], 
            LineBox[{1040, 240}], LineBox[{1042, 242}], LineBox[{1043, 243}], 
            LineBox[{1044, 244}], LineBox[{1045, 245}], LineBox[{1047, 247}], 
            LineBox[{1048, 248}], LineBox[{1049, 249}], LineBox[{1051, 251}], 
            LineBox[{1052, 252}], LineBox[{1054, 254}], LineBox[{1056, 256}], 
            LineBox[{1060, 260}], LineBox[{1063, 263}], LineBox[{1066, 266}], 
            LineBox[{1067, 267}], LineBox[{1069, 269}], LineBox[{1071, 271}], 
            LineBox[{1072, 272}], LineBox[{1074, 274}], LineBox[{1076, 276}], 
            LineBox[{1078, 278}], LineBox[{1079, 279}], LineBox[{1080, 280}], 
            LineBox[{1085, 285}], LineBox[{1086, 286}], LineBox[{1087, 287}], 
            LineBox[{1088, 288}], LineBox[{1090, 290}], LineBox[{1092, 292}], 
            LineBox[{1095, 295}], LineBox[{1097, 297}], LineBox[{1100, 300}], 
            LineBox[{1103, 303}], LineBox[{1104, 304}], LineBox[{1105, 305}], 
            LineBox[{1106, 306}], LineBox[{1108, 308}], LineBox[{1109, 309}], 
            LineBox[{1115, 315}], LineBox[{1120, 320}], LineBox[{1121, 321}], 
            LineBox[{1122, 322}], LineBox[{1127, 327}], LineBox[{1129, 329}], 
            LineBox[{1130, 330}], LineBox[{1133, 333}], LineBox[{1135, 335}], 
            LineBox[{1136, 336}], LineBox[{1141, 341}], LineBox[{1142, 342}], 
            LineBox[{1143, 343}], LineBox[{1144, 344}], LineBox[{1147, 347}], 
            LineBox[{1149, 349}], LineBox[{1151, 351}], LineBox[{1153, 353}], 
            LineBox[{1154, 354}], LineBox[{1157, 357}], LineBox[{1158, 358}], 
            LineBox[{1159, 359}], LineBox[{1162, 362}], LineBox[{1164, 364}], 
            LineBox[{1165, 365}], LineBox[{1168, 368}], LineBox[{1169, 369}], 
            LineBox[{1170, 370}], LineBox[{1173, 373}], LineBox[{1175, 375}], 
            LineBox[{1176, 376}], LineBox[{1177, 377}], LineBox[{1180, 380}], 
            LineBox[{1183, 383}], LineBox[{1184, 384}], LineBox[{1185, 385}], 
            LineBox[{1187, 387}], LineBox[{1189, 389}], LineBox[{1193, 393}], 
            LineBox[{1197, 397}], LineBox[{1198, 398}], LineBox[{1201, 401}], 
            LineBox[{1202, 402}], LineBox[{1204, 404}], LineBox[{1206, 406}], 
            LineBox[{1207, 407}], LineBox[{1208, 408}], LineBox[{1211, 411}], 
            LineBox[{1212, 412}], LineBox[{1213, 413}], LineBox[{1215, 415}], 
            LineBox[{1219, 419}], LineBox[{1221, 421}], LineBox[{1222, 422}], 
            LineBox[{1223, 423}], LineBox[{1224, 424}], LineBox[{1225, 425}], 
            LineBox[{1227, 427}], LineBox[{1230, 430}], LineBox[{1231, 431}], 
            LineBox[{1233, 433}], LineBox[{1236, 436}], LineBox[{1237, 437}], 
            LineBox[{1239, 439}], LineBox[{1241, 441}], LineBox[{1243, 443}], 
            LineBox[{1253, 453}], LineBox[{1254, 454}], LineBox[{1257, 457}], 
            LineBox[{1258, 458}], LineBox[{1259, 459}], LineBox[{1260, 460}], 
            LineBox[{1262, 462}], LineBox[{1263, 463}], LineBox[{1265, 465}], 
            LineBox[{1266, 466}], LineBox[{1267, 467}], LineBox[{1269, 469}], 
            LineBox[{1276, 476}], LineBox[{1278, 478}], LineBox[{1280, 480}], 
            LineBox[{1283, 483}], LineBox[{1285, 485}], LineBox[{1286, 486}], 
            LineBox[{1287, 487}], LineBox[{1288, 488}], LineBox[{1290, 490}], 
            LineBox[{1292, 492}], LineBox[{1293, 493}], LineBox[{1294, 494}], 
            LineBox[{1295, 495}], LineBox[{1296, 496}], LineBox[{1297, 497}], 
            LineBox[{1300, 500}], LineBox[{1301, 501}], LineBox[{1304, 504}], 
            LineBox[{1305, 505}], LineBox[{1307, 507}], LineBox[{1309, 509}], 
            LineBox[{1311, 511}], LineBox[{1313, 513}], LineBox[{1314, 514}], 
            LineBox[{1315, 515}], LineBox[{1316, 516}], LineBox[{1320, 520}], 
            LineBox[{1321, 521}], LineBox[{1322, 522}], LineBox[{1325, 525}], 
            LineBox[{1327, 527}], LineBox[{1329, 529}], LineBox[{1330, 530}], 
            LineBox[{1332, 532}], LineBox[{1333, 533}], LineBox[{1335, 535}], 
            LineBox[{1337, 537}], LineBox[{1341, 541}], LineBox[{1342, 542}], 
            LineBox[{1343, 543}], LineBox[{1344, 544}], LineBox[{1346, 546}], 
            LineBox[{1347, 547}], LineBox[{1350, 550}], LineBox[{1352, 552}], 
            LineBox[{1353, 553}], LineBox[{1355, 555}], LineBox[{1358, 558}], 
            LineBox[{1361, 561}], LineBox[{1362, 562}], LineBox[{1363, 563}], 
            LineBox[{1364, 564}], LineBox[{1366, 566}], LineBox[{1367, 567}], 
            LineBox[{1369, 569}], LineBox[{1370, 570}], LineBox[{1371, 571}], 
            LineBox[{1374, 574}], LineBox[{1376, 576}], LineBox[{1378, 578}], 
            LineBox[{1384, 584}], LineBox[{1386, 586}], LineBox[{1390, 590}], 
            LineBox[{1392, 592}], LineBox[{1394, 594}], LineBox[{1395, 595}], 
            LineBox[{1396, 596}], LineBox[{1397, 597}], LineBox[{1399, 599}], 
            LineBox[{1400, 600}], LineBox[{1405, 605}], LineBox[{1406, 606}], 
            LineBox[{1409, 609}], LineBox[{1412, 612}], LineBox[{1413, 613}], 
            LineBox[{1414, 614}], LineBox[{1415, 615}], LineBox[{1417, 617}], 
            LineBox[{1418, 618}], LineBox[{1419, 619}], LineBox[{1420, 620}], 
            LineBox[{1423, 623}], LineBox[{1425, 625}], LineBox[{1428, 628}], 
            LineBox[{1429, 629}], LineBox[{1430, 630}], LineBox[{1432, 632}], 
            LineBox[{1438, 638}], LineBox[{1440, 640}], LineBox[{1442, 642}], 
            LineBox[{1443, 643}], LineBox[{1445, 645}], LineBox[{1446, 646}], 
            LineBox[{1448, 648}], LineBox[{1450, 650}], LineBox[{1451, 651}], 
            LineBox[{1452, 652}], LineBox[{1455, 655}], LineBox[{1457, 657}], 
            LineBox[{1459, 659}], LineBox[{1460, 660}], LineBox[{1461, 661}], 
            LineBox[{1463, 663}], LineBox[{1465, 665}], LineBox[{1467, 667}], 
            LineBox[{1469, 669}], LineBox[{1470, 670}], LineBox[{1472, 672}], 
            LineBox[{1473, 673}], LineBox[{1474, 674}], LineBox[{1476, 676}], 
            LineBox[{1478, 678}], LineBox[{1480, 680}], LineBox[{1481, 681}], 
            LineBox[{1488, 688}], LineBox[{1489, 689}], LineBox[{1491, 691}], 
            LineBox[{1492, 692}], LineBox[{1495, 695}], LineBox[{1499, 699}], 
            LineBox[{1501, 701}], LineBox[{1506, 706}], LineBox[{1509, 709}], 
            LineBox[{1514, 714}], LineBox[{1517, 717}], LineBox[{1518, 718}], 
            LineBox[{1521, 721}], LineBox[{1522, 722}], LineBox[{1523, 723}], 
            LineBox[{1524, 724}], LineBox[{1525, 725}], LineBox[{1526, 726}], 
            LineBox[{1528, 728}], LineBox[{1530, 730}], LineBox[{1531, 731}], 
            LineBox[{1532, 732}], LineBox[{1534, 734}], LineBox[{1538, 738}], 
            LineBox[{1539, 739}], LineBox[{1540, 740}], LineBox[{1544, 744}], 
            LineBox[{1545, 745}], LineBox[{1547, 747}], LineBox[{1551, 751}], 
            LineBox[{1553, 753}], LineBox[{1554, 754}], LineBox[{1558, 758}], 
            LineBox[{1559, 759}], LineBox[{1561, 761}], LineBox[{1563, 763}], 
            LineBox[{1564, 764}], LineBox[{1567, 767}], LineBox[{1568, 768}], 
            LineBox[{1569, 769}], LineBox[{1570, 770}], LineBox[{1571, 771}], 
            LineBox[{1572, 772}], LineBox[{1574, 774}], LineBox[{1576, 776}], 
            LineBox[{1577, 777}], LineBox[{1578, 778}], LineBox[{1580, 780}], 
            LineBox[{1582, 782}], LineBox[{1583, 783}], LineBox[{1584, 784}], 
            LineBox[{1586, 786}], LineBox[{1587, 787}], LineBox[{1588, 788}], 
            LineBox[{1590, 790}], LineBox[{1593, 793}], LineBox[{1594, 794}], 
            LineBox[{1595, 795}], LineBox[{1597, 797}], LineBox[{1599, 799}]}, 
           {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
            LineBox[{805, 5}], LineBox[{807, 7}], LineBox[{808, 8}], 
            LineBox[{811, 11}], LineBox[{813, 13}], LineBox[{814, 14}], 
            LineBox[{818, 18}], LineBox[{819, 19}], LineBox[{821, 21}], 
            LineBox[{822, 22}], LineBox[{823, 23}], LineBox[{827, 27}], 
            LineBox[{829, 29}], LineBox[{830, 30}], LineBox[{832, 32}], 
            LineBox[{834, 34}], LineBox[{837, 37}], LineBox[{839, 39}], 
            LineBox[{840, 40}], LineBox[{844, 44}], LineBox[{846, 46}], 
            LineBox[{848, 48}], LineBox[{849, 49}], LineBox[{850, 50}], 
            LineBox[{851, 51}], LineBox[{853, 53}], LineBox[{854, 54}], 
            LineBox[{855, 55}], LineBox[{856, 56}], LineBox[{857, 57}], 
            LineBox[{859, 59}], LineBox[{862, 62}], LineBox[{863, 63}], 
            LineBox[{864, 64}], LineBox[{867, 67}], LineBox[{868, 68}], 
            LineBox[{873, 73}], LineBox[{875, 75}], LineBox[{877, 77}], 
            LineBox[{878, 78}], LineBox[{879, 79}], LineBox[{883, 83}], 
            LineBox[{884, 84}], LineBox[{886, 86}], LineBox[{888, 88}], 
            LineBox[{892, 92}], LineBox[{893, 93}], LineBox[{896, 96}], 
            LineBox[{897, 97}], LineBox[{898, 98}], LineBox[{900, 100}], 
            LineBox[{902, 102}], LineBox[{903, 103}], LineBox[{905, 105}], 
            LineBox[{906, 106}], LineBox[{907, 107}], LineBox[{909, 109}], 
            LineBox[{910, 110}], LineBox[{914, 114}], LineBox[{917, 117}], 
            LineBox[{919, 119}], LineBox[{921, 121}], LineBox[{922, 122}], 
            LineBox[{924, 124}], LineBox[{925, 125}], LineBox[{927, 127}], 
            LineBox[{929, 129}], LineBox[{931, 131}], LineBox[{935, 135}], 
            LineBox[{936, 136}], LineBox[{937, 137}], LineBox[{940, 140}], 
            LineBox[{943, 143}], LineBox[{945, 145}], LineBox[{948, 148}], 
            LineBox[{951, 151}], LineBox[{952, 152}], LineBox[{953, 153}], 
            LineBox[{954, 154}], LineBox[{956, 156}], LineBox[{958, 158}], 
            LineBox[{963, 163}], LineBox[{964, 164}], LineBox[{965, 165}], 
            LineBox[{969, 169}], LineBox[{971, 171}], LineBox[{973, 173}], 
            LineBox[{975, 175}], LineBox[{977, 177}], LineBox[{980, 180}], 
            LineBox[{984, 184}], LineBox[{986, 186}], LineBox[{988, 188}], 
            LineBox[{992, 192}], LineBox[{993, 193}], LineBox[{994, 194}], 
            LineBox[{998, 198}], LineBox[{1000, 200}], LineBox[{1002, 202}], 
            LineBox[{1005, 205}], LineBox[{1007, 207}], LineBox[{1009, 209}], 
            LineBox[{1010, 210}], LineBox[{1011, 211}], LineBox[{1014, 214}], 
            LineBox[{1015, 215}], LineBox[{1017, 217}], LineBox[{1021, 221}], 
            LineBox[{1023, 223}], LineBox[{1026, 226}], LineBox[{1027, 227}], 
            LineBox[{1031, 231}], LineBox[{1032, 232}], LineBox[{1036, 236}], 
            LineBox[{1038, 238}], LineBox[{1039, 239}], LineBox[{1041, 241}], 
            LineBox[{1046, 246}], LineBox[{1050, 250}], LineBox[{1053, 253}], 
            LineBox[{1055, 255}], LineBox[{1057, 257}], LineBox[{1058, 258}], 
            LineBox[{1059, 259}], LineBox[{1061, 261}], LineBox[{1062, 262}], 
            LineBox[{1064, 264}], LineBox[{1065, 265}], LineBox[{1068, 268}], 
            LineBox[{1070, 270}], LineBox[{1073, 273}], LineBox[{1075, 275}], 
            LineBox[{1077, 277}], LineBox[{1081, 281}], LineBox[{1082, 282}], 
            LineBox[{1083, 283}], LineBox[{1084, 284}], LineBox[{1089, 289}], 
            LineBox[{1091, 291}], LineBox[{1093, 293}], LineBox[{1094, 294}], 
            LineBox[{1096, 296}], LineBox[{1098, 298}], LineBox[{1099, 299}], 
            LineBox[{1101, 301}], LineBox[{1102, 302}], LineBox[{1107, 307}], 
            LineBox[{1110, 310}], LineBox[{1111, 311}], LineBox[{1112, 312}], 
            LineBox[{1113, 313}], LineBox[{1114, 314}], LineBox[{1116, 316}], 
            LineBox[{1117, 317}], LineBox[{1118, 318}], LineBox[{1119, 319}], 
            LineBox[{1123, 323}], LineBox[{1124, 324}], LineBox[{1125, 325}], 
            LineBox[{1126, 326}], LineBox[{1128, 328}], LineBox[{1131, 331}], 
            LineBox[{1132, 332}], LineBox[{1134, 334}], LineBox[{1137, 337}], 
            LineBox[{1138, 338}], LineBox[{1139, 339}], LineBox[{1140, 340}], 
            LineBox[{1145, 345}], LineBox[{1146, 346}], LineBox[{1148, 348}], 
            LineBox[{1150, 350}], LineBox[{1152, 352}], LineBox[{1155, 355}], 
            LineBox[{1156, 356}], LineBox[{1160, 360}], LineBox[{1161, 361}], 
            LineBox[{1163, 363}], LineBox[{1166, 366}], LineBox[{1167, 367}], 
            LineBox[{1171, 371}], LineBox[{1172, 372}], LineBox[{1174, 374}], 
            LineBox[{1178, 378}], LineBox[{1179, 379}], LineBox[{1181, 381}], 
            LineBox[{1182, 382}], LineBox[{1186, 386}], LineBox[{1188, 388}], 
            LineBox[{1190, 390}], LineBox[{1191, 391}], LineBox[{1192, 392}], 
            LineBox[{1194, 394}], LineBox[{1195, 395}], LineBox[{1196, 396}], 
            LineBox[{1199, 399}], LineBox[{1200, 400}], LineBox[{1203, 403}], 
            LineBox[{1205, 405}], LineBox[{1209, 409}], LineBox[{1210, 410}], 
            LineBox[{1214, 414}], LineBox[{1216, 416}], LineBox[{1217, 417}], 
            LineBox[{1218, 418}], LineBox[{1220, 420}], LineBox[{1226, 426}], 
            LineBox[{1228, 428}], LineBox[{1229, 429}], LineBox[{1232, 432}], 
            LineBox[{1234, 434}], LineBox[{1235, 435}], LineBox[{1238, 438}], 
            LineBox[{1240, 440}], LineBox[{1242, 442}], LineBox[{1244, 444}], 
            LineBox[{1245, 445}], LineBox[{1246, 446}], LineBox[{1247, 447}], 
            LineBox[{1248, 448}], LineBox[{1249, 449}], LineBox[{1250, 450}], 
            LineBox[{1251, 451}], LineBox[{1252, 452}], LineBox[{1255, 455}], 
            LineBox[{1256, 456}], LineBox[{1261, 461}], LineBox[{1264, 464}], 
            LineBox[{1268, 468}], LineBox[{1270, 470}], LineBox[{1271, 471}], 
            LineBox[{1272, 472}], LineBox[{1273, 473}], LineBox[{1274, 474}], 
            LineBox[{1275, 475}], LineBox[{1277, 477}], LineBox[{1279, 479}], 
            LineBox[{1281, 481}], LineBox[{1282, 482}], LineBox[{1284, 484}], 
            LineBox[{1289, 489}], LineBox[{1291, 491}], LineBox[{1298, 498}], 
            LineBox[{1299, 499}], LineBox[{1302, 502}], LineBox[{1303, 503}], 
            LineBox[{1306, 506}], LineBox[{1308, 508}], LineBox[{1310, 510}], 
            LineBox[{1312, 512}], LineBox[{1317, 517}], LineBox[{1318, 518}], 
            LineBox[{1319, 519}], LineBox[{1323, 523}], LineBox[{1324, 524}], 
            LineBox[{1326, 526}], LineBox[{1328, 528}], LineBox[{1331, 531}], 
            LineBox[{1334, 534}], LineBox[{1336, 536}], LineBox[{1338, 538}], 
            LineBox[{1339, 539}], LineBox[{1340, 540}], LineBox[{1345, 545}], 
            LineBox[{1348, 548}], LineBox[{1349, 549}], LineBox[{1351, 551}], 
            LineBox[{1354, 554}], LineBox[{1356, 556}], LineBox[{1357, 557}], 
            LineBox[{1359, 559}], LineBox[{1360, 560}], LineBox[{1365, 565}], 
            LineBox[{1368, 568}], LineBox[{1372, 572}], LineBox[{1373, 573}], 
            LineBox[{1375, 575}], LineBox[{1377, 577}], LineBox[{1379, 579}], 
            LineBox[{1380, 580}], LineBox[{1381, 581}], LineBox[{1382, 582}], 
            LineBox[{1383, 583}], LineBox[{1385, 585}], LineBox[{1387, 587}], 
            LineBox[{1388, 588}], LineBox[{1389, 589}], LineBox[{1391, 591}], 
            LineBox[{1393, 593}], LineBox[{1398, 598}], LineBox[{1401, 601}], 
            LineBox[{1402, 602}], LineBox[{1403, 603}], LineBox[{1404, 604}], 
            LineBox[{1407, 607}], LineBox[{1408, 608}], LineBox[{1410, 610}], 
            LineBox[{1411, 611}], LineBox[{1416, 616}], LineBox[{1421, 621}], 
            LineBox[{1422, 622}], LineBox[{1424, 624}], LineBox[{1426, 626}], 
            LineBox[{1427, 627}], LineBox[{1431, 631}], LineBox[{1433, 633}], 
            LineBox[{1434, 634}], LineBox[{1435, 635}], LineBox[{1436, 636}], 
            LineBox[{1437, 637}], LineBox[{1439, 639}], LineBox[{1441, 641}], 
            LineBox[{1444, 644}], LineBox[{1447, 647}], LineBox[{1449, 649}], 
            LineBox[{1453, 653}], LineBox[{1454, 654}], LineBox[{1456, 656}], 
            LineBox[{1458, 658}], LineBox[{1462, 662}], LineBox[{1464, 664}], 
            LineBox[{1466, 666}], LineBox[{1468, 668}], LineBox[{1471, 671}], 
            LineBox[{1475, 675}], LineBox[{1477, 677}], LineBox[{1479, 679}], 
            LineBox[{1482, 682}], LineBox[{1483, 683}], LineBox[{1484, 684}], 
            LineBox[{1485, 685}], LineBox[{1486, 686}], LineBox[{1487, 687}], 
            LineBox[{1490, 690}], LineBox[{1493, 693}], LineBox[{1494, 694}], 
            LineBox[{1496, 696}], LineBox[{1497, 697}], LineBox[{1498, 698}], 
            LineBox[{1500, 700}], LineBox[{1502, 702}], LineBox[{1503, 703}], 
            LineBox[{1504, 704}], LineBox[{1505, 705}], LineBox[{1507, 707}], 
            LineBox[{1508, 708}], LineBox[{1510, 710}], LineBox[{1511, 711}], 
            LineBox[{1512, 712}], LineBox[{1513, 713}], LineBox[{1515, 715}], 
            LineBox[{1516, 716}], LineBox[{1519, 719}], LineBox[{1520, 720}], 
            LineBox[{1527, 727}], LineBox[{1529, 729}], LineBox[{1533, 733}], 
            LineBox[{1535, 735}], LineBox[{1536, 736}], LineBox[{1537, 737}], 
            LineBox[{1541, 741}], LineBox[{1542, 742}], LineBox[{1543, 743}], 
            LineBox[{1546, 746}], LineBox[{1548, 748}], LineBox[{1549, 749}], 
            LineBox[{1550, 750}], LineBox[{1552, 752}], LineBox[{1555, 755}], 
            LineBox[{1556, 756}], LineBox[{1557, 757}], LineBox[{1560, 760}], 
            LineBox[{1562, 762}], LineBox[{1565, 765}], LineBox[{1566, 766}], 
            LineBox[{1573, 773}], LineBox[{1575, 775}], LineBox[{1579, 779}], 
            LineBox[{1581, 781}], LineBox[{1585, 785}], LineBox[{1589, 789}], 
            LineBox[{1591, 791}], LineBox[{1592, 792}], LineBox[{1596, 796}], 
            LineBox[{1598, 798}], LineBox[{1600, 800}]}}, {{}, 
           {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
            0.0055000000000000005`], AbsoluteThickness[1.6], 
            PointBox[CompressedData["
1:eJwN00OCIAYAALDp2rZt27Zt27bZrm3btm3btm02hzwhCRu1r9Tun4CAgASB
AwIKBgsIKERhilCUYhSnBCUpRWnKUJZylKcCFalEZapQlWpUpwY1qUVt6lCX
etSnAQ1pRGOa0JRmNKcFLWlFa9rQlna0pwMd6URnutCVbnSnBz3pRW/60Jd+
9GcAAxnEYIYwlH/5j2EMZwQjGcVoxjCWcYxnAhOZxGSmMJVpTGcGM5nFbOYw
l3nMZwELWcRilrCUZSxnBStZxWrWsJZ1rGcDG9nEZrawlW1sZwc72cVu9rCX
feznAAc5xGGOcJRjHOcEJznFac5wlnOc5wIXucRlrnCVa1znBje5xW3ucJd7
3OcBD3nEY57wlGc85wUvecVr3vCWd7znAx/5xGe+8JVvfOcHP/nFb/7wl4Dg
AQH/EIjABCEowQhOCEISitCEISzhCE8EIhKJyEQhKtGITgxiEovYxCEu8YhP
AhKSiMQkISnJSE4KUpKK1KQhLelITwYykonMZCEr2chODnKSi9zkIS/5yE8B
ClKIwhShKMUoTglKUorSlKEs5ShPBSpSicpUoSrVqE4NalKL2tShLvWoTwMa
0ojGNKEpzWhOC1rSita0oS3taE8HOtKJznShK93oTg960ove9KEv/ejPAAYy
iMEMYSj/8h/DGM4IRjKK0YxhLOMYzwQmMonJTGEq05jODGYyi9nMYS7zmM8C
FrKIxSxhKctYzgpWsorVrGEt61jPBjayic1sYSvb2M4OdrKL3exhL/vYzwEO
cojDHOEoxzjOCU5yitOc4SznOM8FLnKJy1zhKte4zg1ucovb3OEu97jPAx7y
iMc84SnPeM4LXvKK17zhLe94zwc+8onPfOEr3/jOD37yi9/84S8BIfwnEIEJ
QlCCEZwQhCQUoQlDWMIRnghEJBKRiUJUohGdGMQkFrGJQ1ziEZ8EJCQRiUlC
UpKRnBSkJBWpSUNa0pGeDGQkE5nJQlaykZ0c5CQXuclDXvKRnwIUpBCFKUJR
ilGcEpSkFKUpQ1nKUZ4KVKQSlalCVapRnRrUpBa1qUNd6lGfBjSkEY1pQlOa
0ZwWtKQVrWlDW9rRng50pBOd6UJXutGdHvSkF73pQ1/60Z8BDGQQgxnCUP7l
P4YxnBGMZBSjGcNYxjGeCUxkEpOZwlSmMZ0ZzGQWs5nDXOYxnwUsZBGLWcJS
lrGcFaxkFatZw1rWsZ4NbGQTm9nCVraxnR3sZBe72cNe9rGfAxzkEIc5wlGO
cZwTnOQUpznDWc5xngtc5BKXucJVrnGdG9zkFre5w13ucZ8HPOQRj3nCU57x
nBe85BWvecNb3vGeD3zkE5/5wle+8Z0f/OQXv/nDXwJC+k8gAhOEoAQjOCEI
SShCE4awhCM8EYhIJCIThahEIzoxiEksYhOHuMQjPglISCISk4SkJCM5KUhJ
KlKThrSkIz0ZyEgmMpOFrGQjOznISS5yk4e85CM/BShIIQpThKIUozglKEkp
SlOGspSjPBWoSCUqU4WqVKM6NahJLWpTh7rUoz4N+B8EWKFZ
             
             "]]}, {}}}], {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{False, False},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{
          FormBox["\"Covari\[AHat]ncia\"", TraditionalForm], None}, {
          FormBox["\"Semanas\"", TraditionalForm], 
          FormBox[
          "\"\\!\\(\\*SubscriptBox[\\(s\\), \\(3\\)]\\)\"", TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 800.}, {-0.0001065260457309752, 
         0.000056950111792773825`}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.05], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {967.5, -597.9478841155233}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499622}]}}, {}},
  ContentSelectable->True,
  ImageSize->{1420., Automatic},
  PlotRangePadding->{6, 5}]], "Output",ExpressionUUID->"e39acac3-ccfe-40f3-\
b13c-bd5845deadfe"]
}, Open  ]],

Cell["\<\
Aqui de novo cheguei a esses par\[AHat]metros atrav\[EAcute]s de tentativa e \
erro. Um passo futuro seria verificar exatamente o espa\[CCedilla]o de par\
\[AHat]metros atrav\[EAcute]s de an\[AAcute]lise do erro quadr\[AAcute]tico m\
\[EAcute]dio em fun\[CCedilla]\[ATilde]o de cada par\[AHat]metro.\
\>", "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"1dc9167c-ebd9-47b4-bb81-b8104c9b4043"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"energiaNeurons", "=", "5"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"energiaInputNumber", "=", "27"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"energiaOutputNumber", "=", "1"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"energiaTrain", ",", "energiaTest"}], "}"}], "=", 
   RowBox[{"sampleSplit", "[", 
    RowBox[{"energiaS3", ",", "energiaInputNumber"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"energiaBatchSize", "=", "1"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"energiaNetModel", "=", 
   RowBox[{"neuralNetwork", "[", 
    RowBox[{
    "energiaS3", ",", "energiaNeurons", ",", "energiaInputNumber", ",", 
     "energiaOutputNumber", ",", "energiaTrain", ",", "energiaTest", ",", 
     "energiaBatchSize"}], "]"}]}], ";"}]}], "Input",ExpressionUUID->\
"e84887c5-2179-437c-9bc5-2bd771e36d6b"],

Cell[TextData[{
 "Aqui mostro gr\[AAcute]fico da predi\[CCedilla]\[ATilde]o para tantos \
pontos futuros quanto inputs. Vemos que n\[ATilde]o h\[AAcute] perda de \
amplitude. Ainda assim a previs\[ATilde]o para Semanas \[Rule] \[Infinity] n\
\[ATilde]o \[EAcute] confi\[AAcute]vel pois, para pontos muito distantes, \
rede perde capacidade de predizer ru\[IAcute]dos e a caracter\[IAcute]stica \
oscilat\[OAcute]ria da predi\[CCedilla]\[ATilde]o se torna muito dominante, \
escondendo outros ",
 StyleBox["features",
  FontSlant->"Italic"],
 "."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"5963fdba-9359-4eb3-8a22-e5c5c2ceaa9d"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"energiaFuturePoints", "=", "energiaInputNumber"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"energiaTrained", " ", "=", " ", 
   RowBox[{"Flatten", "[", 
    RowBox[{
     RowBox[{"NestList", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"Rest", "[", 
         RowBox[{"Append", "[", 
          RowBox[{"#", ",", 
           RowBox[{
            RowBox[{"energiaNetModel", "[", "\"\<TrainedNet\>\"", "]"}], "[", 
            "#", "]"}]}], "]"}], "]"}], "&"}], ",", 
       RowBox[{"energiaTest", "[", 
        RowBox[{"[", 
         RowBox[{
          RowBox[{"-", "1"}], ",", "1"}], "]"}], "]"}], ",", 
       "energiaFuturePoints"}], "]"}], "[", 
     RowBox[{"[", 
      RowBox[{"-", "2"}], "]"}], "]"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"energiaPlot", "=", 
   RowBox[{"Thread", "[", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"Range", "[", 
       RowBox[{
        RowBox[{
         RowBox[{"Length", "@", "energiaS3"}], "-", 
         RowBox[{"Mod", "[", 
          RowBox[{
           RowBox[{"Length", "@", "energiaS3"}], ",", 
           RowBox[{"energiaInputNumber", "+", "1"}]}], "]"}], "-", "1"}], ",", 
        RowBox[{
         RowBox[{"Length", "@", "energiaS3"}], "-", 
         RowBox[{"Mod", "[", 
          RowBox[{
           RowBox[{"Length", "@", "energiaS3"}], ",", 
           RowBox[{"energiaInputNumber", "+", "1"}]}], "]"}], "+", 
         RowBox[{"Length", "@", "energiaTrained"}], "-", "2"}]}], "]"}], ",", 
      "energiaTrained"}], "}"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{"ListLinePlot", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"energiaS3", ",", "energiaPlot"}], "}"}], ",", 
   RowBox[{"Joined", "\[Rule]", "True"}], ",", 
   RowBox[{"PlotLegends", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"\"\<Original\>\"", ",", "\"\<Predicted\>\""}], "}"}]}], ",", 
   RowBox[{"PlotRange", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"energiaPlot", "[", 
         RowBox[{"[", 
          RowBox[{"1", ",", "1"}], "]"}], "]"}], ",", 
        RowBox[{"energiaPlot", "[", 
         RowBox[{"[", 
          RowBox[{
           RowBox[{"-", "1"}], ",", "1"}], "]"}], "]"}]}], "}"}], ",", 
      "All"}], "}"}]}], ",", 
   RowBox[{"PlotStyle", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"Blue", ",", "Red"}], "}"}]}], ",", 
   RowBox[{"Axes", "\[Rule]", "False"}], ",", "\[IndentingNewLine]", 
   RowBox[{"Frame", "\[Rule]", "True"}], ",", 
   RowBox[{"FrameStyle", "\[Rule]", 
    RowBox[{"Directive", "[", 
     RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
   RowBox[{"FrameLabel", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"\"\<Res\[IAcute]duos\>\"", ",", "None"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"\"\<Semanas\>\"", ",", "\"\<S\[EAcute]rie Residual\>\""}], 
       "}"}]}], "}"}]}]}], "\[IndentingNewLine]", "]"}]}], "Input",ExpressionU\
UID->"0dd5814d-f098-4514-9c2e-ce21d5e73947"],

Cell[BoxData[
 TemplateBox[{GraphicsBox[{{}, {{{}, {}, {
        Hue[0.67, 0.6, 0.6], 
        Directive[
         PointSize[
          NCache[
           Rational[1, 120], 0.008333333333333333]], 
         AbsoluteThickness[1.6], 
         RGBColor[0, 0, 1]], 
        LineBox[CompressedData["
1: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
eq7LktsUz3ad/FikVFcoM879D70PqZQ=
         "]]}, {
        Hue[0.9060679774997897, 0.6, 0.6], 
        Directive[
         PointSize[
          NCache[
           Rational[1, 120], 0.008333333333333333]], 
         AbsoluteThickness[1.6], 
         RGBColor[1, 0, 0]], 
        LineBox[CompressedData["
1:eJxTTMoPSmViYGCQBmIQDQYS3Q73zD592c43fT+Yr9DtACQTEsTm2YP5GmA+
w2rZJRC+AZi/YB/PIoh6CzDfIelQKUTeAcJfEt0JkfcA8x88+5MJ4QdAzN8W
uxiiPgLMP+C8ZyNEPgEiL5Y/HSKfAeYr7ImdC+EXQOyfkDYBwq+A2HeqMAbC
b4C41z15C8S8DjC/wfT8Koj8BIh8+8NFEP4MiPtk5iyGqF8AsY/t93yI/AqI
+0J/rYXIb4DYJxG5EiK/A8KvPNMK4R+AqL8QsgCi/gTEvPlToPZfgNhvVbgN
In8D4t/zDDMg8g8g5qUKQdW/gLj/X8DS/QAPfGfo
         "]]}}}, {}, {}, {}, {}}, {
    DisplayFunction -> Identity, PlotRangePadding -> {{0, 0}, {
        Scaled[0.05], 
        Scaled[0.05]}}, AxesOrigin -> {867.13, 0}, 
     PlotRange -> {{867, 893}, {-0.09538165370687272, 0.07550914194839288}}, 
     PlotRangeClipping -> True, ImagePadding -> All, DisplayFunction -> 
     Identity, AspectRatio -> NCache[GoldenRatio^(-1), 0.6180339887498948], 
     Axes -> {False, False}, AxesLabel -> {None, None}, 
     AxesOrigin -> {867.13, 0}, DisplayFunction :> Identity, 
     Frame -> {{True, True}, {True, True}}, FrameLabel -> {{
        FormBox["\"Res\[IAcute]duos\"", TraditionalForm], None}, {
        FormBox["\"Semanas\"", TraditionalForm], 
        FormBox["\"S\[EAcute]rie Residual\"", TraditionalForm]}}, FrameStyle -> 
     Directive[18, 
       Thickness[Large]], 
     FrameTicks -> {{Automatic, Automatic}, {Automatic, Automatic}}, 
     GridLines -> {None, None}, GridLinesStyle -> Directive[
       GrayLevel[0.5, 0.4]], 
     Method -> {"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
           (Identity[#]& )[
            Part[#, 1]], 
           (Identity[#]& )[
            Part[#, 2]]}& ), "CopiedValueFunction" -> ({
           (Identity[#]& )[
            Part[#, 1]], 
           (Identity[#]& )[
            Part[#, 2]]}& )}}, 
     PlotRange -> {{867, 893}, {-0.09538165370687272, 0.07550914194839288}}, 
     PlotRangeClipping -> True, PlotRangePadding -> {{0, 0}, {
        Scaled[0.05], 
        Scaled[0.05]}}, Ticks -> {Automatic, Automatic}}],FormBox[
    FormBox[
     TemplateBox[{"\"Original\"", "\"Predicted\""}, "LineLegend", 
      DisplayFunction -> (FormBox[
        StyleBox[
         StyleBox[
          PaneBox[
           TagBox[
            GridBox[{{
               TagBox[
                GridBox[{{
                   GraphicsBox[{{
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[3, 20], 0.15]], 
                    AbsoluteThickness[1.6], 
                    RGBColor[0, 0, 1]], {
                    LineBox[{{0, 10}, {20, 10}}]}}, {
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[3, 20], 0.15]], 
                    AbsoluteThickness[1.6], 
                    RGBColor[0, 0, 1]], {}}}, AspectRatio -> Full, 
                    ImageSize -> {20, 10}, PlotRangePadding -> None, 
                    ImagePadding -> Automatic, 
                    BaselinePosition -> (Scaled[0.1] -> Baseline)], #}, {
                   GraphicsBox[{{
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[3, 20], 0.15]], 
                    AbsoluteThickness[1.6], 
                    RGBColor[1, 0, 0]], {
                    LineBox[{{0, 10}, {20, 10}}]}}, {
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[3, 20], 0.15]], 
                    AbsoluteThickness[1.6], 
                    RGBColor[1, 0, 0]], {}}}, AspectRatio -> Full, 
                    ImageSize -> {20, 10}, PlotRangePadding -> None, 
                    ImagePadding -> Automatic, 
                    BaselinePosition -> (Scaled[0.1] -> Baseline)], #2}}, 
                 GridBoxAlignment -> {
                  "Columns" -> {Center, Left}, "Rows" -> {{Baseline}}}, 
                 AutoDelete -> False, 
                 GridBoxDividers -> {
                  "Columns" -> {{False}}, "Rows" -> {{False}}}, 
                 GridBoxItemSize -> {"Columns" -> {{All}}, "Rows" -> {{All}}},
                  GridBoxSpacings -> {
                  "Columns" -> {{0.5}}, "Rows" -> {{0.8}}}], "Grid"]}}, 
             GridBoxAlignment -> {"Columns" -> {{Left}}, "Rows" -> {{Top}}}, 
             AutoDelete -> False, 
             GridBoxItemSize -> {
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}, 
             GridBoxSpacings -> {"Columns" -> {{1}}, "Rows" -> {{0}}}], 
            "Grid"], Alignment -> Left, AppearanceElements -> None, 
           ImageMargins -> {{5, 5}, {5, 5}}, ImageSizeAction -> 
           "ResizeToFit"], LineIndent -> 0, StripOnInput -> False], {
         FontFamily -> "Arial"}, Background -> Automatic, StripOnInput -> 
         False], TraditionalForm]& ), 
      InterpretationFunction :> (RowBox[{"LineLegend", "[", 
         RowBox[{
           RowBox[{"{", 
             RowBox[{
               RowBox[{"Directive", "[", 
                 RowBox[{
                   RowBox[{"PointSize", "[", 
                    FractionBox["1", "120"], "]"}], ",", 
                   RowBox[{"AbsoluteThickness", "[", "1.6`", "]"}], ",", 
                   InterpretationBox[
                    ButtonBox[
                    TooltipBox[
                    GraphicsBox[{{
                    GrayLevel[0], 
                    RectangleBox[{0, 0}]}, {
                    GrayLevel[0], 
                    RectangleBox[{1, -1}]}, {
                    RGBColor[0, 0, 1], 
                    RectangleBox[{0, -1}, {2, 1}]}}, DefaultBaseStyle -> 
                    "ColorSwatchGraphics", AspectRatio -> 1, Frame -> True, 
                    FrameStyle -> RGBColor[0., 0., 0.6666666666666666], 
                    FrameTicks -> None, PlotRangePadding -> None, ImageSize -> 
                    Dynamic[{
                    Automatic, 
                    1.35 (CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[
                    Magnification])}]], 
                    StyleBox[
                    RowBox[{"RGBColor", "[", 
                    RowBox[{"0", ",", "0", ",", "1"}], "]"}], NumberMarks -> 
                    False]], Appearance -> None, BaseStyle -> {}, 
                    BaselinePosition -> Baseline, DefaultBaseStyle -> {}, 
                    ButtonFunction :> With[{Typeset`box$ = EvaluationBox[]}, 
                    If[
                    Not[
                    AbsoluteCurrentValue["Deployed"]], 
                    SelectionMove[Typeset`box$, All, Expression]; 
                    FrontEnd`Private`$ColorSelectorInitialAlpha = 1; 
                    FrontEnd`Private`$ColorSelectorInitialColor = 
                    RGBColor[0, 0, 1]; 
                    FrontEnd`Private`$ColorSelectorUseMakeBoxes = True; 
                    MathLink`CallFrontEnd[
                    FrontEnd`AttachCell[Typeset`box$, 
                    FrontEndResource["RGBColorValueSelector"], {
                    0, {Left, Bottom}}, {Left, Top}, 
                    "ClosingActions" -> {
                    "SelectionDeparture", "ParentChanged", 
                    "EvaluatorQuit"}]]]], BaseStyle -> Inherited, Evaluator -> 
                    Automatic, Method -> "Preemptive"], 
                    RGBColor[0, 0, 1], Editable -> False, Selectable -> 
                    False]}], "]"}], ",", 
               RowBox[{"Directive", "[", 
                 RowBox[{
                   RowBox[{"PointSize", "[", 
                    FractionBox["1", "120"], "]"}], ",", 
                   RowBox[{"AbsoluteThickness", "[", "1.6`", "]"}], ",", 
                   InterpretationBox[
                    ButtonBox[
                    TooltipBox[
                    GraphicsBox[{{
                    GrayLevel[0], 
                    RectangleBox[{0, 0}]}, {
                    GrayLevel[0], 
                    RectangleBox[{1, -1}]}, {
                    RGBColor[1, 0, 0], 
                    RectangleBox[{0, -1}, {2, 1}]}}, DefaultBaseStyle -> 
                    "ColorSwatchGraphics", AspectRatio -> 1, Frame -> True, 
                    FrameStyle -> RGBColor[0.6666666666666666, 0., 0.], 
                    FrameTicks -> None, PlotRangePadding -> None, ImageSize -> 
                    Dynamic[{
                    Automatic, 
                    1.35 (CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[
                    Magnification])}]], 
                    StyleBox[
                    RowBox[{"RGBColor", "[", 
                    RowBox[{"1", ",", "0", ",", "0"}], "]"}], NumberMarks -> 
                    False]], Appearance -> None, BaseStyle -> {}, 
                    BaselinePosition -> Baseline, DefaultBaseStyle -> {}, 
                    ButtonFunction :> With[{Typeset`box$ = EvaluationBox[]}, 
                    If[
                    Not[
                    AbsoluteCurrentValue["Deployed"]], 
                    SelectionMove[Typeset`box$, All, Expression]; 
                    FrontEnd`Private`$ColorSelectorInitialAlpha = 1; 
                    FrontEnd`Private`$ColorSelectorInitialColor = 
                    RGBColor[1, 0, 0]; 
                    FrontEnd`Private`$ColorSelectorUseMakeBoxes = True; 
                    MathLink`CallFrontEnd[
                    FrontEnd`AttachCell[Typeset`box$, 
                    FrontEndResource["RGBColorValueSelector"], {
                    0, {Left, Bottom}}, {Left, Top}, 
                    "ClosingActions" -> {
                    "SelectionDeparture", "ParentChanged", 
                    "EvaluatorQuit"}]]]], BaseStyle -> Inherited, Evaluator -> 
                    Automatic, Method -> "Preemptive"], 
                    RGBColor[1, 0, 0], Editable -> False, Selectable -> 
                    False]}], "]"}]}], "}"}], ",", 
           RowBox[{"{", 
             RowBox[{#, ",", #2}], "}"}], ",", 
           RowBox[{"LegendMarkers", "\[Rule]", 
             RowBox[{"{", 
               RowBox[{
                 RowBox[{"{", 
                   RowBox[{"False", ",", "Automatic"}], "}"}], ",", 
                 RowBox[{"{", 
                   RowBox[{"False", ",", "Automatic"}], "}"}]}], "}"}]}], ",", 
           RowBox[{"Joined", "\[Rule]", 
             RowBox[{"{", 
               RowBox[{"True", ",", "True"}], "}"}]}], ",", 
           RowBox[{"LabelStyle", "\[Rule]", 
             RowBox[{"{", "}"}]}], ",", 
           RowBox[{"LegendLayout", "\[Rule]", "\"Column\""}]}], "]"}]& ), 
      Editable -> True], TraditionalForm], TraditionalForm]},
  "Legended",
  DisplayFunction->(GridBox[{{
      TagBox[
       ItemBox[
        PaneBox[
         TagBox[#, "SkipImageSizeLevel"], Alignment -> {Center, Baseline}, 
         BaselinePosition -> Baseline], DefaultBaseStyle -> "Labeled"], 
       "SkipImageSizeLevel"], 
      ItemBox[#2, DefaultBaseStyle -> "LabeledLabel"]}}, 
    GridBoxAlignment -> {"Columns" -> {{Center}}, "Rows" -> {{Center}}}, 
    AutoDelete -> False, GridBoxItemSize -> Automatic, 
    BaselinePosition -> {1, 1}]& ),
  Editable->True,
  InterpretationFunction->(RowBox[{"Legended", "[", 
     RowBox[{#, ",", 
       RowBox[{"Placed", "[", 
         RowBox[{#2, ",", "After"}], "]"}]}], "]"}]& )]], "Output",ExpressionU\
UID->"256da71f-da41-47e7-a6d0-3f77b5429eaf"]
}, Open  ]],

Cell[TextData[{
 "Podemos somar \[AGrave] predi\[CCedilla]\[ATilde]o acima todas as \
componentes extra\[IAcute]das da s\[EAcute]rie de diferen\[CCedilla]as ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["s", "1"], TraditionalForm]],ExpressionUUID->
  "70387b7d-ebf2-4edf-8b66-a6e1da5b2ff7"],
 " . Basta pegarmos os modelos lineares e senoidais ajustados anteriormente e \
calcularmos suas contribui\[CCedilla]\[OTilde]es para cada instante de tempo. \
Assm, gr\[AAcute]fico abaixo mostra o comportamento da previs\[ATilde]o das \
diferen\[CCedilla]as semanais de carga de energia."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"d212609d-4439-4008-af01-355914ddf708"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"energiaTrend", "=", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"energiaLinearTrend", "[", "i", "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", 
       RowBox[{"energiaPlot", "[", 
        RowBox[{"[", 
         RowBox[{"1", ",", "1"}], "]"}], "]"}], ",", 
       RowBox[{"energiaPlot", "[", 
        RowBox[{"[", 
         RowBox[{
          RowBox[{"-", "1"}], ",", "1"}], "]"}], "]"}]}], "}"}]}], "]"}]}], 
  " ", ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"energiaCS1", "=", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"Sum", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"energiaSinusoidalComponents1", "[", 
         RowBox[{"[", "k", "]"}], "]"}], "[", "i", "]"}], ",", 
       RowBox[{"{", 
        RowBox[{"k", ",", "1", ",", 
         RowBox[{"Length", "@", "energiaSinusoidalComponents1"}]}], "}"}]}], 
      "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", 
       RowBox[{"energiaPlot", "[", 
        RowBox[{"[", 
         RowBox[{"1", ",", "1"}], "]"}], "]"}], ",", 
       RowBox[{"energiaPlot", "[", 
        RowBox[{"[", 
         RowBox[{
          RowBox[{"-", "1"}], ",", "1"}], "]"}], "]"}]}], "}"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"energiaCS2", "=", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"Sum", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"energiaSinusoidalComponents2", "[", 
         RowBox[{"[", "k", "]"}], "]"}], "[", "i", "]"}], ",", 
       RowBox[{"{", 
        RowBox[{"k", ",", "1", ",", 
         RowBox[{"Length", "@", "energiaSinusoidalComponents2"}]}], "}"}]}], 
      "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", 
       RowBox[{"energiaPlot", "[", 
        RowBox[{"[", 
         RowBox[{"1", ",", "1"}], "]"}], "]"}], ",", 
       RowBox[{"energiaPlot", "[", 
        RowBox[{"[", 
         RowBox[{
          RowBox[{"-", "1"}], ",", "1"}], "]"}], "]"}]}], "}"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"energiaFinalPrediction", "=", 
   RowBox[{"Thread", "[", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"energiaPlot", "[", 
       RowBox[{"[", 
        RowBox[{"All", ",", "1"}], "]"}], "]"}], ",", 
      RowBox[{
       RowBox[{"energiaPlot", "[", 
        RowBox[{"[", 
         RowBox[{"All", ",", "2"}], "]"}], "]"}], "+", "energiaTrend", "+", 
       "energiaCS1", "+", "energiaCS2"}]}], "}"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"ListLinePlot", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"energiaS1", ",", "energiaFinalPrediction"}], "}"}], ",", 
   RowBox[{"PlotRange", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"energiaFinalPrediction", "[", 
         RowBox[{"[", 
          RowBox[{"1", ",", "1"}], "]"}], "]"}], ",", 
        RowBox[{
         RowBox[{"energiaFinalPrediction", "[", 
          RowBox[{"[", 
           RowBox[{"1", ",", "1"}], "]"}], "]"}], "+", 
         "energiaFuturePoints"}]}], "}"}], ",", "All"}], "}"}]}], ",", 
   RowBox[{"PlotLegends", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"\"\<Original\>\"", ",", "\"\<Predicted\>\""}], "}"}]}], ",", 
   RowBox[{"Frame", "\[Rule]", "True"}], ",", 
   RowBox[{"FrameStyle", "\[Rule]", 
    RowBox[{"Directive", "[", 
     RowBox[{"18", ",", "Thick"}], "]"}]}]}], "]"}]}], "Input",ExpressionUUID-\
>"8dceed8a-3127-4657-851f-821b6a23aeaa"],

Cell[BoxData[
 TemplateBox[{GraphicsBox[{{}, {{{}, {}, {
        Hue[0.67, 0.6, 0.6], 
        Directive[
         PointSize[
          NCache[
           Rational[1, 120], 0.008333333333333333]], 
         RGBColor[0.368417, 0.506779, 0.709798], 
         AbsoluteThickness[1.6]], 
        LineBox[CompressedData["
1:eJw1Wndczf/3v7KyI5Gsa+drZaSQetpldVXa47aHxm3vut19byIJIckoRTSM
IuPigxCuivogrlHKSD4Z2b9+D+ftH49Xr/t6nX3O85zXe5xHiJW3BovFCujO
Yv3//3//tZt1yxjxPKtAfIn+AJPCIf1eJvLN/i41UbHE3PmKlzuttfA8a8qz
fiu20O+H4mr8J+uXZgra10X+lA2/D3Sa0/4oePb4qNy3gLmPjfMeeVfWvYym
9XiYly4oTHtkR7+fCFn4oSeiswm0Pxm/yuuWzdFJp319JE95v7l4Zibt/w97
oiqXvdMU0v50lB3b++Ris4zWM7F5ekXqOHEU/d4Ap/DEY4+MR+vZuFU6fpbL
gBhaz8E7V8/6rNRwOj8Xtcv42/ul+tP+PPiw3YuGPRfT2hDbK77XXXiXTev5
cNAc9HvkwTQ6b4Q7hz9+Kz/K8GsMjTssN3nZDtpfgJ4/xi6+e/AMrRfi84Qh
wXNWpdHvF0HjrGBFQUE5rU3AajzSrTpHQb9fjM6LjbdzbzL8m2Kym9EkT7cj
tDbD6M1ucfJ1OfR7YJRlU/fKNbTmA2aSGXfVw47S75dgosZi014yko+/BMOm
V02IfbuP9peiTAe39e6SPPylOJCzor7EQEr3L8PIdy3WNy4cpvuXwVu4feWD
Vbl0fjnOLB1bdMIwkvaXwzAnf+wpFuM/K8AxqRvZesKP7l+B+W8WFBlH5NL9
K1GlEXr94Bg57a9EZN2yG+YmG2h/FbTPPerbe3sm3b8K0B1s9Yrhh2WO42a7
FnO8D9F5c5z9b6DwQVY60bfA+3mRQXk6m+m8BWq0393J2UX3sVYjbo2J9whu
EJ1fje45SbX1XMaea+CysL10dLcQ2l+DMaO31fneEtH9a7E0xbe5zN6D7l+L
E1qp7Qunb6H9dVhZMiptr5B+z1+HUf+TavuPj6T99dix2WxZTlAAnV8Pjcql
622/ZhN9S/y0ce53dFUqnbeERmBAnfbRvXSegw85HayBRqRPcDBUt36Ix7yD
9HsOzILez23UprWSg8dT3YdX2XvQ+Q2YXvVwSq4X2Q8boHg4O+pwuYD42YCt
P06VvcjL/7tWboCT8crRtWD82QpD2pZfCzba83cNK/w+laMfMF5C9K2Q9/LA
8VdNtFZa4YpuTawR/yDJZ4264bYV2nESom+N1RUTDCePOUn0rbHSJl9vnc92
om+NhKanplrdThF9Gwzs0Wh1cs9GOm8Dv4DoqLM7SP98G/gX1a9PGkn2VNrg
UuMy3thJeXR+I0YYKnMyTXcR/xsheRtalrGB8beNyBhYtLQghPaVG2EZv3f5
E8EJ4t8WI6Xr7k36RfEAW1xpfu0wsIPk4dtC2jHw0uXLZE+lLX6X5Gpa5G4n
+naYXCwfMMRRTvzbIcN6xRq+BRNvdmCZnpcu86HfK+3gsk7vQSV/B523R0JO
S5b9NLIP7NGck3vr1UAhyW+POqOT999mkz6U9tD7rpEVFsf4lwNqR/d3vPOG
7AkHjJkebht7g+KX74AaV62L+vsOEP8O0HsW2FI3gcnnjvCu5gzOuRdP9B1h
kBZT9kpF/sV3hPPgs0s1HpE/KR2RUrOxU6eAiQ8nPPF8NezppFCi74T+SyVv
GvOkdN4J7zuuVvUbRPVC6YSHJQuTspfEEf/OmGZ04NohNdUjOOP6ZI1xZSXJ
pD9nFOh61w25t5Pkd8bbfvvFOweTvlkusDF+Uro94wCddwEvWzH2+Tiqh3wX
1F+TxR94zejfBTvztzqkOuTReVccOsQd+YrH+L8rfJIbWXu2MvK7wmqhi/q/
wYeIf1e83Kz9TNnI+J8b7B5WhkbNZPzfDUHGMavj7Yge3w2KHhFiycpNRN8N
btp6z6v3JRF9LvId91jNGrj17z6bixV7zY+NbCun+7gIf7pmkPZ1os/lIidA
8dbi6TG6n4uLkWu2G+4nfnK56J7YmtDPifCDkos3o2uWXuxD+UbNxYshy3bt
7J1B/Lujd9+t9bWPyP/Y7qhL69+wqed+0oc7jox8/nF9YCnRd4e/09apFu5F
RN8d27dPK2I1bSP67rieECSbJ6R6qHTHcO3yZctzdv5dq93h1fsP56cpQ98D
p6evcx6XnUr0PaAYme8yXJZE9D1wvsckjTpLWnM9MLD/5IFNlnQf3wNnhR8P
uVaQfnM98N20Y/SFAeTPSg8s7kjtc1lG+EPtAeXGZu2a4s8X/9L3xPVDTZHn
99mS/j3BOym6v9SA6jE8oVl+fG/KbaqvXE/oqnpuidzBxKcn4i6XRk56T/Uh
1xNFq4rej1wXQ/Q9wd11adYn50Si7wmDhr7nfPcxeMQLhw1be3/X8iL5vdAv
YqheQDDpB17Qymd5r8+NJf17ITD83tk/CQwe8MIgzTm/brB3E30vXFeMMJ85
fBPR90LIeTd+65CtRN8LZo7DYvTfUDyxvJGWObXxuy2t2d7Y7/ymTvUgluh7
4x+XhTlXdx0l+t6Y+OZm5dXDC4m+N658fVT2opah740X8xqDXy2i+FV6Y/kq
9Y+yKtKH2hv7DKW29eeY+uODvprHVmQOJn2zfTDYOGJ5RhHlR/jgLmeeKG+l
PdH3QavDq6lbx9M+3wcHp60v/PYP+UOuD5YdvO7S++x+ou+DC2/cpiXtJf7V
Phhw/IWvjyGDf3wRVp0cvL+e8BbbF2VX/jgIrJl85Ive9j43Ls6jesL1xacJ
1nVhj8if+F1rH7eAlR+OEX1fnO7nF3143WmKd1+MXvsyZf5qoqf2xSVVzv7J
uhlkfz/sPKe1Te4eSPT9kLX69pUVv0mf8EN27TebSQ8KiL4fBl66unC1lMlP
flCFPJ0b8LCA9O+Habdtv+6ZlEL0/XCy2f28V80Rkt8P/e91PvH6Rfph+cM+
U89U/J7wB9sfKxyGp3VqER6DPzxdrz4zP0/65vqj4FTZwq01xSS/P7YYJ90b
sZSJP380/nSUD91P+UDpD0V3vxEJRckkvz/iTaf2Mk9n8FkAYgfw7m41cif6
AaiqPpz/o2gJxV8AziSJMl1LCT9wA/BYfw57rQvj/wFoWpUT7LvPmvQfgP7B
HkklNyg+lQE4ybk94nx+PNEPgPvN88OXKBl8uQle396qZxwjfbI34ZJruf63
fMb/NmHSCR5r+FdG/5uw6d2EtznPCE/wNyHg/nSuciHVs9xN2L85nC1g8Kdy
Eyztj9jfqc4h+pvQVj1vWpFMQPQDkTmAo7U1n/AVOxA6vW2cLwtpjUBI17wa
qsEiPMUNhGn3hCrbb0x9CcRd031jFCUioh8Im6FL7nw/R/2GMhBjflzUv2VN
9VIdiI+mWmnykaRPVhB4a7bsvxwTR/SDILsz90jYQcLLCMKU/dfOZ7PKiH4Q
0iI2jr27hOKXH4Q8302+GWUlZP8gHBntocF9Rf6uDILNgT7iXl7ErzoIs2uP
mdkfpnrGCsZhL6tbp5KofrGDUde+Y0LUEsKXCEYgW24+cQD1c9xgnDo6dEZx
IOE3fjDylRdUkxqpHuUGgz2rPND+5TbSfzByQqurGmWUT9XBmKndd/G4t5Qv
WCE4fWySq2EB2Ysdghr39f5awYR3EIJHhyRPZvIJz3FD4Oqi6219kPIFPwS5
DTni+oWUX3JDYB+05vLGF6RPZQj0HrgsOVVM9VgdAql0VLatM9mXxcOF94al
n+aSP2jx8LJ4vPLMhCjihwd/wY6779N3/10b8LD/y3C3Q3NIn+AhcOIP244f
lB85PMieHP28ah/VEy4P2x4Wtx5XUn7n8dD+qVWUF0X1h89DrY3VXLMkwnPp
PHztc+6QwQKqx7k8RHsFFJiwCR+V8GDzOKqo72oGj/EQGfpoQ2U04UsVDz3H
Hb2x77wbycvD3R7vvkWUk37aeUjrVzC45g75CysUV/rr/fn0wo3kD0XiV61H
CY6Eb9mhmJndETTEkPzNIBQcZ4eB0WvIXgjFpHuhA6O3kD44oZj+ZsMao1uU
n7mhmF+vOpbxS0byhyJgcPmcyzo8kj8UXkvaHuZ8IP2mh6KSXbvOoF8h+VMo
Lnz2eTZsPNX/klCY8PVeX79D+lOGoueftApHMc0nVKHoiFw67cF8xt9Dods2
vjOtP+G59lBcqh+d9r/1TP8chqHXXzkmtNM8QSsMuutmNMUsZfJRGO6OX1ZV
LCb/MAjD2LI25Vd/yq8Iw5na4obZT2newAmDuPPIsxsd5P/cMEzKsQj9h0P1
lReGggGDZondS8l/w7Dh/uXtDzwoH6aHgb8jq/Z6PuGt3DAcbz36usiL7FES
hkUbD2gHGdH8QRkGq/jfzmMCSH+qMFzp6dznmx75gzoMAaevwD2B9NceBnyu
8vvdxMyjwpEXEtZ7vTHpRyscIU/YtycLCH+yw5Gws/3OHxfG/uFY1LvbtQFr
ST6E44518tjEur3k/+HIHDdmasRcim9uONR7HuaM33KY7B+OqWG9diskVI/4
4WC31u67phtI9u86bxkV0vsL4fnccFyv6969alUoyR+OD68vfuH5MfUlHONn
3Xp0Mibs71oVjrm77ON+FWWR/OEI0/umMrlD8rSHo+jG3Qm7V3mR/0eg+xGX
kl5MP68Vgdc6URNfH6F4ZEdAc7e366cSyt8GEXjjYT9y8i/qrxCBuZofzq4K
ovs5Ecgr3Sat8aP5GzcC51mlbYfzKP/wIvDiw7LXFfZMfxYBjsv8BSvbqD6m
R2DUmNvDX9aQf+dGwCXKpDzJhvytJAIa6cGdqmqSTxkBV/P3ce2XCc+oIrri
feukq5b+JH8E0k/5SK6tzCL5I9BsPCdZZzkz/4jEkHvnMu1vM/kvEra7Nq8e
tov8hx2JiqQfBYGFNI8ziMTd29ciWYFMvxeJx3rLbwRGUv7nRMLmvycbjfdQ
/eJGou19WsDa5VRPeJEQmAWuu7ue+OVH4lPjsIMFFdT/pEfixjfPPPmiSvL/
SNzOHpAhsqZ8XhKJzJk1ei43mPiPxJ/mls8XfhI/qkiUh1/p6fKUT/JHwkkn
bKb22uMU/5FQTL9Vp1PDzO+ikKj1X25ohyH5fxTws+lDSMFIsn8U6usCZgeb
0fzIIAoZCTqmy68x84Io8Hr7ij/udST/j8LV6FAj+W7Kj9wotNwzjXNRMfkv
CgdgueTxmBSSPwpJ7mfyfzlTPk+PwiePuhkL83aR/aOQuc7/k3cE+VdJFEoj
bAcuGUv5VRmFk6/HRj5zjyb7R2EIO1k8sXEj5b8obPxw91LDMbqvPQqrTDxe
TvIjfMqKxk/2laC4ZsJbWtH4pupjXbvNiuSPRvOwPwbDKxj5o3FxqGO2qDiC
7B+N8ilFJqWelF840Viw5vDxZYOo/+RG48Icc3XCT5of8qKR96foZeu/5I/8
aEze1pFwMIr8LT0aKkxZwRETPsqNxijdmws+OJH+SqKxr3C54RY3wuvKaPR3
eTz0ih7hb1U0lNtKB6Zvo3yojoZ45cTu7xcw8d+1rt5a2aOAmX/GwK61x83O
w2QvrRhYTnQ/UVtLeJ0dg0TvV37TbtN83iAGbbaewZ7rqb4jBo7N1f/+KdxM
8scgtduJBufDhI+4MYjbMn2ClwvhR14MikatCW91ZObNMTjrrchjfaB5XHoM
thredJmacYb8PwaFT76O/e9f+n1JDKZV+4ycY+xC9u/if0FNyslJ+SR/DNQD
9h923Ev4Rh2DqUaL/oSup3zUHgMLdmmLllsRyR+LoZEmvaPNL5D9Y3FG/9X7
pPMUn+xY6P3uWP42i+xjEIsTfUpDbWdSfkcsZCabVnjWEj+cWFjJyjJaffaQ
/LEo/hIkaZRRPPJi8emJ4eGH4wh/8mPR8q1n+WlLBv/E4nlSc8SJBZTvc2Nh
X1p93ktA9aMkFrqpDTpe2lS/lbGYtle/zZRL/qSKBSvKyNJTRv2COhZDfAN2
x+kx8sfCVOlQ9sOa8iMrDl+KR9RMuUb4SisO5fZapsdVVH/ZcfhVqN83ZzLx
bxAHt/bGCWxROPl/HNb2+DRlaivNHzhxSDl8Q6rZTPmUG4eFlofiRyVQvPHi
wLupzzvKW0fyx+FJQcfX5EnUb6bHQSh+qpsiJvly4zDf7t3EhTzC5yVxyHZ7
sHnMBQZfx2FKg2jQwHuUz1Rx8FZo/O9nP9pXx6FzX2Dl5K1zyf/jcLRG26Kh
inlfiIdOZqNaz5nys1Y8hhdfCxnhRP0DOx4brv1bXaNN/BvE44Btv8+J/ame
IR7/suvzNt6j+Tin676ox1LuWMJf3HjIi9ePut1M9/HiISrRdr5XxeS/eCz6
drL17E6Kl/R4HDySZ3HImOp7bjxsOT/cTFfR/KskHivTrEalpzPz9Hj8OWCz
oqm1guSPx8sEz/JUS5rPqeMRXM19FavikP3jEV6pvO/iSP0FKwGXRPd4fDPC
m1oJcPod7/pI6E3yJyDX8FpbdTvRN0iAR/3bhyNml5H9ExBz03DC/95RfeQk
QPglvGr0bupPuAkYOr80NbKDsX8C3mR9GRm0kvInPwFnCu5XBM+ifJOegBXV
e1e9aqX+PreLfufL/ZVD6XxJAi6fqYlNCaR4UCagWbsjaZwV9VeqBFyz6/Hj
kILymzoBbp+shw1vpPzRnoD7+ROm3blO70WsRPQ8fCm/uYH8WSsRGh8vVa4x
ovPsRJgsK2zuIWbsn4ge1iEzejQy8+ZEsKPmslLPU3/ISUTfNb1m6Q+ifM9N
RLboq8OPa4TveIm47qS41XaB8Aw/EfM8R2+cMpvwVXoiRsx57WMtoPl4biIi
jGrHt0yZQPZPBL/ldPQMycO/80NlIip/hd7a1ofsqUrEzbZP1dWdpB91InwP
ZBj170n+2J6IWT5rbBIUTP5Lgrcqcenic+QvWklIT+n18LY+yctOwrOVIfmX
lVRfDZLAXjLoW3EV4S8kIXJwTuU/K2n+xEkCf8+9/Tu+M/ZPgsO6V4verqH+
gJeEf6fObrIso/k3PwlCEyfz77o070lPwie98zMu9yP+cpMwqkJ6NqPvSbJ/
Eg5Uvgm6F0N4R5mEPLsX1w81Uf1RJaGO55K6wYzeH9Vd/KUKYs5sJXu2JyE4
q9ebno/Pk/zJKPTbOyRQRflFKxkmFae9fWdTPLGToZ59t6R/OdP/JCPvuWvy
pHjKN0jG7ZCTv57OY+p/MrzPfuwI2kX+xU1G4CFW35MbqJ/lJeNPfN0P7zbG
/5OR9dZgwcTR5O/pybjyvL7udQ+Kp9xkjOheXRfHonpYkoyKaTKLcfoknzIZ
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
UjFz22yD1n3xl/4PSN+vPA==
         "]]}, {
        Hue[0.9060679774997897, 0.6, 0.6], 
        Directive[
         PointSize[
          NCache[
           Rational[1, 120], 0.008333333333333333]], 
         RGBColor[0.880722, 0.611041, 0.142051], 
         AbsoluteThickness[1.6]], 
        LineBox[CompressedData["
1:eJxTTMoPSmViYGCQBmIQDQYS3Q6GWWkHVszp2w/mK3Q7XPjhttKgbbk9mK/R
7bAqYFJZ+9QpEL5Bt8OK/P83LSSWQNRbdDvo5L7N7jjVApF36Hbg2XI/K8l5
KUTeo9sh8CmjuLvuIgg/oNthYniF8ru3SyHqI7odLt3KnrjRawNEPqHb4Txv
YBd3yzSIfEa3A0PUhoS6QmeIfEG3A0fjur35Bk0Q+YpuB5u577PsiudD+A3d
DlXCcxPX1u+CqO/odthilzl1rfUGiPyEbofthRP7O39NhvBndDtYV/QoHyte
AVG/oNshWGnXh+nZqyDyK4D+zQiasXD1Moj8BmB4rCv69lRtBUR+R7eD04G9
uYkVsyH8A90Odya2eGVOmwtRfwLoHvZVVlYRqyHyF7odRAxONn3T3QaRvwH0
z4zbp2/bZ0LkH3Q7TPULMnhgtwXCf9HtYHJOslH52Yr9ADOJkQg=
         
         "]]}}}, {}, {}, {}, {}}, {
    DisplayFunction -> Identity, PlotRangePadding -> {{0, 0}, {
        Scaled[0.05], 
        Scaled[0.05]}}, AxesOrigin -> {867.135, 0}, 
     PlotRange -> {{867, 894}, {-0.12999457543129558`, 0.15013714760119207`}},
      PlotRangeClipping -> True, ImagePadding -> All, DisplayFunction -> 
     Identity, AspectRatio -> NCache[GoldenRatio^(-1), 0.6180339887498948], 
     Axes -> {True, True}, AxesLabel -> {None, None}, 
     AxesOrigin -> {867.135, 0}, DisplayFunction :> Identity, 
     Frame -> {{True, True}, {True, True}}, 
     FrameLabel -> {{None, None}, {None, None}}, FrameStyle -> Directive[18, 
       Thickness[Large]], 
     FrameTicks -> {{Automatic, Automatic}, {Automatic, Automatic}}, 
     GridLines -> {None, None}, GridLinesStyle -> Directive[
       GrayLevel[0.5, 0.4]], 
     Method -> {"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
           (Identity[#]& )[
            Part[#, 1]], 
           (Identity[#]& )[
            Part[#, 2]]}& ), "CopiedValueFunction" -> ({
           (Identity[#]& )[
            Part[#, 1]], 
           (Identity[#]& )[
            Part[#, 2]]}& )}}, 
     PlotRange -> {{867, 894}, {-0.12999457543129558`, 0.15013714760119207`}},
      PlotRangeClipping -> True, PlotRangePadding -> {{0, 0}, {
        Scaled[0.05], 
        Scaled[0.05]}}, Ticks -> {Automatic, Automatic}}],FormBox[
    FormBox[
     TemplateBox[{"\"Original\"", "\"Predicted\""}, "LineLegend", 
      DisplayFunction -> (FormBox[
        StyleBox[
         StyleBox[
          PaneBox[
           TagBox[
            GridBox[{{
               TagBox[
                GridBox[{{
                   GraphicsBox[{{
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[3, 20], 0.15]], 
                    RGBColor[0.368417, 0.506779, 0.709798], 
                    AbsoluteThickness[1.6]], {
                    LineBox[{{0, 10}, {20, 10}}]}}, {
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[3, 20], 0.15]], 
                    RGBColor[0.368417, 0.506779, 0.709798], 
                    AbsoluteThickness[1.6]], {}}}, AspectRatio -> Full, 
                    ImageSize -> {20, 10}, PlotRangePadding -> None, 
                    ImagePadding -> Automatic, 
                    BaselinePosition -> (Scaled[0.1] -> Baseline)], #}, {
                   GraphicsBox[{{
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[3, 20], 0.15]], 
                    RGBColor[0.880722, 0.611041, 0.142051], 
                    AbsoluteThickness[1.6]], {
                    LineBox[{{0, 10}, {20, 10}}]}}, {
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[3, 20], 0.15]], 
                    RGBColor[0.880722, 0.611041, 0.142051], 
                    AbsoluteThickness[1.6]], {}}}, AspectRatio -> Full, 
                    ImageSize -> {20, 10}, PlotRangePadding -> None, 
                    ImagePadding -> Automatic, 
                    BaselinePosition -> (Scaled[0.1] -> Baseline)], #2}}, 
                 GridBoxAlignment -> {
                  "Columns" -> {Center, Left}, "Rows" -> {{Baseline}}}, 
                 AutoDelete -> False, 
                 GridBoxDividers -> {
                  "Columns" -> {{False}}, "Rows" -> {{False}}}, 
                 GridBoxItemSize -> {"Columns" -> {{All}}, "Rows" -> {{All}}},
                  GridBoxSpacings -> {
                  "Columns" -> {{0.5}}, "Rows" -> {{0.8}}}], "Grid"]}}, 
             GridBoxAlignment -> {"Columns" -> {{Left}}, "Rows" -> {{Top}}}, 
             AutoDelete -> False, 
             GridBoxItemSize -> {
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}, 
             GridBoxSpacings -> {"Columns" -> {{1}}, "Rows" -> {{0}}}], 
            "Grid"], Alignment -> Left, AppearanceElements -> None, 
           ImageMargins -> {{5, 5}, {5, 5}}, ImageSizeAction -> 
           "ResizeToFit"], LineIndent -> 0, StripOnInput -> False], {
         FontFamily -> "Arial"}, Background -> Automatic, StripOnInput -> 
         False], TraditionalForm]& ), 
      InterpretationFunction :> (RowBox[{"LineLegend", "[", 
         RowBox[{
           RowBox[{"{", 
             RowBox[{
               RowBox[{"Directive", "[", 
                 RowBox[{
                   RowBox[{"PointSize", "[", 
                    FractionBox["1", "120"], "]"}], ",", 
                   InterpretationBox[
                    ButtonBox[
                    TooltipBox[
                    GraphicsBox[{{
                    GrayLevel[0], 
                    RectangleBox[{0, 0}]}, {
                    GrayLevel[0], 
                    RectangleBox[{1, -1}]}, {
                    RGBColor[0.368417, 0.506779, 0.709798], 
                    RectangleBox[{0, -1}, {2, 1}]}}, DefaultBaseStyle -> 
                    "ColorSwatchGraphics", AspectRatio -> 1, Frame -> True, 
                    FrameStyle -> 
                    RGBColor[
                    0.24561133333333335`, 0.3378526666666667, 
                    0.4731986666666667], FrameTicks -> None, PlotRangePadding -> 
                    None, ImageSize -> 
                    Dynamic[{
                    Automatic, 
                    1.35 (CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[
                    Magnification])}]], 
                    StyleBox[
                    RowBox[{"RGBColor", "[", 
                    RowBox[{"0.368417`", ",", "0.506779`", ",", "0.709798`"}],
                     "]"}], NumberMarks -> False]], Appearance -> None, 
                    BaseStyle -> {}, BaselinePosition -> Baseline, 
                    DefaultBaseStyle -> {}, ButtonFunction :> 
                    With[{Typeset`box$ = EvaluationBox[]}, 
                    If[
                    Not[
                    AbsoluteCurrentValue["Deployed"]], 
                    SelectionMove[Typeset`box$, All, Expression]; 
                    FrontEnd`Private`$ColorSelectorInitialAlpha = 1; 
                    FrontEnd`Private`$ColorSelectorInitialColor = 
                    RGBColor[0.368417, 0.506779, 0.709798]; 
                    FrontEnd`Private`$ColorSelectorUseMakeBoxes = True; 
                    MathLink`CallFrontEnd[
                    FrontEnd`AttachCell[Typeset`box$, 
                    FrontEndResource["RGBColorValueSelector"], {
                    0, {Left, Bottom}}, {Left, Top}, 
                    "ClosingActions" -> {
                    "SelectionDeparture", "ParentChanged", 
                    "EvaluatorQuit"}]]]], BaseStyle -> Inherited, Evaluator -> 
                    Automatic, Method -> "Preemptive"], 
                    RGBColor[0.368417, 0.506779, 0.709798], Editable -> False,
                     Selectable -> False], ",", 
                   RowBox[{"AbsoluteThickness", "[", "1.6`", "]"}]}], "]"}], 
               ",", 
               RowBox[{"Directive", "[", 
                 RowBox[{
                   RowBox[{"PointSize", "[", 
                    FractionBox["1", "120"], "]"}], ",", 
                   InterpretationBox[
                    ButtonBox[
                    TooltipBox[
                    GraphicsBox[{{
                    GrayLevel[0], 
                    RectangleBox[{0, 0}]}, {
                    GrayLevel[0], 
                    RectangleBox[{1, -1}]}, {
                    RGBColor[0.880722, 0.611041, 0.142051], 
                    RectangleBox[{0, -1}, {2, 1}]}}, DefaultBaseStyle -> 
                    "ColorSwatchGraphics", AspectRatio -> 1, Frame -> True, 
                    FrameStyle -> 
                    RGBColor[
                    0.587148, 0.40736066666666665`, 0.09470066666666668], 
                    FrameTicks -> None, PlotRangePadding -> None, ImageSize -> 
                    Dynamic[{
                    Automatic, 
                    1.35 (CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[
                    Magnification])}]], 
                    StyleBox[
                    RowBox[{"RGBColor", "[", 
                    RowBox[{"0.880722`", ",", "0.611041`", ",", "0.142051`"}],
                     "]"}], NumberMarks -> False]], Appearance -> None, 
                    BaseStyle -> {}, BaselinePosition -> Baseline, 
                    DefaultBaseStyle -> {}, ButtonFunction :> 
                    With[{Typeset`box$ = EvaluationBox[]}, 
                    If[
                    Not[
                    AbsoluteCurrentValue["Deployed"]], 
                    SelectionMove[Typeset`box$, All, Expression]; 
                    FrontEnd`Private`$ColorSelectorInitialAlpha = 1; 
                    FrontEnd`Private`$ColorSelectorInitialColor = 
                    RGBColor[0.880722, 0.611041, 0.142051]; 
                    FrontEnd`Private`$ColorSelectorUseMakeBoxes = True; 
                    MathLink`CallFrontEnd[
                    FrontEnd`AttachCell[Typeset`box$, 
                    FrontEndResource["RGBColorValueSelector"], {
                    0, {Left, Bottom}}, {Left, Top}, 
                    "ClosingActions" -> {
                    "SelectionDeparture", "ParentChanged", 
                    "EvaluatorQuit"}]]]], BaseStyle -> Inherited, Evaluator -> 
                    Automatic, Method -> "Preemptive"], 
                    RGBColor[0.880722, 0.611041, 0.142051], Editable -> False,
                     Selectable -> False], ",", 
                   RowBox[{"AbsoluteThickness", "[", "1.6`", "]"}]}], "]"}]}],
              "}"}], ",", 
           RowBox[{"{", 
             RowBox[{#, ",", #2}], "}"}], ",", 
           RowBox[{"LegendMarkers", "\[Rule]", 
             RowBox[{"{", 
               RowBox[{
                 RowBox[{"{", 
                   RowBox[{"False", ",", "Automatic"}], "}"}], ",", 
                 RowBox[{"{", 
                   RowBox[{"False", ",", "Automatic"}], "}"}]}], "}"}]}], ",", 
           RowBox[{"Joined", "\[Rule]", 
             RowBox[{"{", 
               RowBox[{"True", ",", "True"}], "}"}]}], ",", 
           RowBox[{"LabelStyle", "\[Rule]", 
             RowBox[{"{", "}"}]}], ",", 
           RowBox[{"LegendLayout", "\[Rule]", "\"Column\""}]}], "]"}]& ), 
      Editable -> True], TraditionalForm], TraditionalForm]},
  "Legended",
  DisplayFunction->(GridBox[{{
      TagBox[
       ItemBox[
        PaneBox[
         TagBox[#, "SkipImageSizeLevel"], Alignment -> {Center, Baseline}, 
         BaselinePosition -> Baseline], DefaultBaseStyle -> "Labeled"], 
       "SkipImageSizeLevel"], 
      ItemBox[#2, DefaultBaseStyle -> "LabeledLabel"]}}, 
    GridBoxAlignment -> {"Columns" -> {{Center}}, "Rows" -> {{Center}}}, 
    AutoDelete -> False, GridBoxItemSize -> Automatic, 
    BaselinePosition -> {1, 1}]& ),
  Editable->True,
  InterpretationFunction->(RowBox[{"Legended", "[", 
     RowBox[{#, ",", 
       RowBox[{"Placed", "[", 
         RowBox[{#2, ",", "After"}], "]"}]}], "]"}]& )]], "Output",ExpressionU\
UID->"6c53fd32-7825-4dcd-ab2b-9e5c8a226d70"]
}, Open  ]],

Cell["\<\
Modelo se comporta significativamente bem para uma quantidade \
razo\[AAcute]vel de pontos futuros, o que \[EAcute] o objetivo final. Ainda \
falta fazer uma an\[AAcute]lise mais profunda de erros m\[EAcute]dios.\
\>", "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"e4af45b8-8ee0-4852-a04f-1ba1476b7d94"]
}, Closed]],

Cell[CellGroupData[{

Cell["\<\
Pre\[CCedilla]o de Liquida\[CCedilla]\[ATilde]o de Diferen\[CCedilla]as (PLD) \
- Submercado Sudeste / Centro-Oeste\
\>", "Subsection",ExpressionUUID->"5c0a65e1-819b-4a70-b852-b4bd4193db6d"],

Cell[TextData[{
 "Tamb\[EAcute]m oriunda do ONS, podemos analisar a s\[EAcute]rie temporal \
para o Pre\[CCedilla]o de Liquida\[CCedilla]\[OTilde]es de \
Diferen\[CCedilla]as (PLD), ",
 StyleBox["i.e.",
  FontSlant->"Italic"],
 " o valor de mercado para comercializa\[CCedilla]\[ATilde]o de energia no \
mercado livre. Apesar de depender de outras s\[EAcute]ries temporais \
fortemente regulares (vaz\[ATilde]o de hidroel\[EAcute]tricas da \
regi\[ATilde]o, carga de energia semanal, etc...), esta s\[EAcute]rie \
\[EAcute] interessante pois possui uma alta presen\[CCedilla]a de \
irregularidades, ",
 StyleBox["e.g. ",
  FontSlant->"Italic"],
 "mudan\[CCedilla]as legislativas, decis\[OTilde]es executivas, teto e piso \
anuais, etc. S\[EAcute]rie obtida entre 06/07/2001 e 08/06/2018."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"5366c595-f729-4eae-baa1-4838c37514b6"],

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", 
   RowBox[{
    RowBox[{"SetDirectory", "[", 
     RowBox[{"NotebookDirectory", "[", "]"}], "]"}], ";", 
    "\[IndentingNewLine]", 
    RowBox[{"precosRaw", " ", "=", " ", 
     RowBox[{"Import", "[", "\"\<precos.csv\>\"", "]"}]}], ";", 
    "\[IndentingNewLine]", 
    RowBox[{"precos", "=", 
     RowBox[{"Drop", "[", 
      RowBox[{
       RowBox[{"Drop", "[", 
        RowBox[{
         RowBox[{"precosRaw", "[", 
          RowBox[{"[", 
           RowBox[{"All", ",", "8"}], "]"}], "]"}], ",", "188"}], "]"}], ",", 
       
       RowBox[{"-", "2"}]}], "]"}]}]}], "*)"}], "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"precos", "=", 
    RowBox[{"{", 
     RowBox[{
     "18.33`", ",", "18.33`", ",", "18.33`", ",", "18.33`", ",", "18.33`", 
      ",", "18.33`", ",", "18.33`", ",", "18.33`", ",", "18.33`", ",", 
      "18.33`", ",", "18.33`", ",", "18.33`", ",", "18.33`", ",", "18.33`", 
      ",", "19.74`", ",", "25.03`", ",", "33.31`", ",", "47.99`", ",", 
      "42.25`", ",", "49.38`", ",", "45.01`", ",", "28.09`", ",", "18.33`", 
      ",", "31.39`", ",", "29.72`", ",", "24.37`", ",", "26.15`", ",", 
      "32.72`", ",", "35.26`", ",", "34.13`", ",", "28.46`", ",", "27.13`", 
      ",", "37.36`", ",", "32.94`", ",", "47.1`", ",", "38.93`", ",", 
      "31.76`", ",", "27.42`", ",", "23.09`", ",", "35.56`", ",", "39.44`", 
      ",", "41.24`", ",", "47.98`", ",", "47.48`", ",", "31", ",", "32.06`", 
      ",", "35.5`", ",", "31.8`", ",", "18.33`", ",", "18.33`", ",", "18.33`",
       ",", "18.33`", ",", "16.92`", ",", "16.92`", ",", "16.92`", ",", 
      "38.35`", ",", "66.75`", ",", "57.13`", ",", "82.97`", ",", "33.04`", 
      ",", "36.78`", ",", "37.85`", ",", "16.92`", ",", "16.92`", ",", 
      "34.37`", ",", "22.46`", ",", "20.78`", ",", "17.06`", ",", "16.92`", 
      ",", "35.76`", ",", "48.9`", ",", "55.75`", ",", "55.29`", ",", "59.6`",
       ",", "61.31`", ",", "64.5`", ",", "73.91`", ",", "71.6`", ",", 
      "90.66`", ",", "86.34`", ",", "85.07`", ",", "90.49`", ",", "103.63`", 
      ",", "98.44`", ",", "96.45`", ",", "94.53`", ",", "125.24`", ",", 
      "123.42`", ",", "115.5`", ",", "123.32`", ",", "127.89`", ",", 
      "105.57`", ",", "112.73`", ",", "81.51`", ",", "80.71`", ",", "69.65`", 
      ",", "94.81`", ",", "68.65`", ",", "79.27`", ",", "85.75`", ",", 
      "79.07`", ",", "69.47`", ",", "50.36`", ",", "35.89`", ",", "34.04`", 
      ",", "23.55`", ",", "17.59`", ",", "17.59`", ",", "17.59`", ",", 
      "17.59`", ",", "17.59`", ",", "17.59`", ",", "17.59`", ",", "17.59`", 
      ",", "17.59`", ",", "17.59`", ",", "17.59`", ",", "17.59`", ",", 
      "62.58`", ",", "53.76`", ",", "55.25`", ",", "54.7`", ",", "35.79`", 
      ",", "43.12`", ",", "48.63`", ",", "118.08`", ",", "101.85`", ",", 
      "114.6`", ",", "74.73`", ",", "81.49`", ",", "138.89`", ",", "141.55`", 
      ",", "130.1`", ",", "116.3`", ",", "57.95`", ",", "28.31`", ",", 
      "27.21`", ",", "33.88`", ",", "56.58`", ",", "128.1`", ",", "130.81`", 
      ",", "147.26`", ",", "186.16`", ",", "165.13`", ",", "172.08`", ",", 
      "205.54`", ",", "209.7`", ",", "237.66`", ",", "223.89`", ",", "181.3`",
       ",", "150.54`", ",", "169.19`", ",", "189.25`", ",", "212.2`", ",", 
      "200.48`", ",", "199.76`", ",", "247.01`", ",", "472.21`", ",", 
      "569.59`", ",", "569.59`", ",", "550.28`", ",", "253.32`", ",", 
      "122.33`", ",", "155.84`", ",", "207.36`", ",", "137.23`", ",", 
      "129.66`", ",", "173.39`", ",", "63.99`", ",", "82.27`", ",", "115.62`",
       ",", "68.18`", ",", "15.47`", ",", "39.19`", ",", "28.48`", ",", 
      "15.47`", ",", "33.45`", ",", "49.34`", ",", "76.12`", ",", "76.03`", 
      ",", "69.88`", ",", "76.72`", ",", "88.11`", ",", "91.32`", ",", 
      "102.53`", ",", "110.12`", ",", "145.35`", ",", "138.25`", ",", 
      "117.49`", ",", "77.05`", ",", "69.38`", ",", "93.25`", ",", "105.62`", 
      ",", "118.04`", ",", "120.97`", ",", "100.23`", ",", "97.53`", ",", 
      "74.28`", ",", "93.2`", ",", "98.71`", ",", "103.73`", ",", "115.28`", 
      ",", "109.17`", ",", "91.04`", ",", "95.35`", ",", "103.42`", ",", 
      "113.15`", ",", "91.34`", ",", "74.1`", ",", "28.13`", ",", "62.27`", 
      ",", "137.52`", ",", "108.4`", ",", "65.15`", ",", "61.44`", ",", 
      "43.08`", ",", "16.31`", ",", "59.91`", ",", "80.7`", ",", "106.95`", 
      ",", "94.06`", ",", "105.13`", ",", "16.31`", ",", "49.12`", ",", 
      "37.93`", ",", "45.12`", ",", "45.76`", ",", "36.21`", ",", "36.1`", 
      ",", "36.99`", ",", "37.59`", ",", "34.97`", ",", "40.8`", ",", 
      "42.68`", ",", "51.6`", ",", "38.84`", ",", "31.28`", ",", "20.73`", 
      ",", "21.45`", ",", "16.31`", ",", "16.31`", ",", "16.31`", ",", 
      "16.31`", ",", "16.31`", ",", "16.31`", ",", "16.31`", ",", "16.31`", 
      ",", "16.31`", ",", "16.31`", ",", "16.31`", ",", "16.31`", ",", 
      "16.31`", ",", "16.31`", ",", "16.31`", ",", "16.31`", ",", "16.31`", 
      ",", "16.31`", ",", "16.31`", ",", "16.31`", ",", "16.31`", ",", 
      "16.31`", ",", "12.8`", ",", "12.8`", ",", "12.8`", ",", "12.8`", ",", 
      "12.8`", ",", "12.8`", ",", "12.8`", ",", "12.8`", ",", "23.28`", ",", 
      "12.8`", ",", "12.8`", ",", "35.05`", ",", "37.15`", ",", "12.8`", ",", 
      "12.8`", ",", "23.26`", ",", "22.09`", ",", "22.35`", ",", "22.87`", 
      ",", "32.43`", ",", "34.49`", ",", "56.07`", ",", "59.9`", ",", 
      "59.49`", ",", "65.43`", ",", "99.67`", ",", "102.29`", ",", "95", ",", 
      "78.15`", ",", "71.36`", ",", "104.64`", ",", "124.16`", ",", "114.95`",
       ",", "122.27`", ",", "104.53`", ",", "124.43`", ",", "115.68`", ",", 
      "130.72`", ",", "167.47`", ",", "135.97`", ",", "112.7`", ",", 
      "140.34`", ",", "140.62`", ",", "147.15`", ",", "117.68`", ",", 
      "125.45`", ",", "98.34`", ",", "77.56`", ",", "84.74`", ",", "72", ",", 
      "61.98`", ",", "52.44`", ",", "67.24`", ",", "12.08`", ",", "14.97`", 
      ",", "21.29`", ",", "12.08`", ",", "36.79`", ",", "52.67`", ",", 
      "60.88`", ",", "77.47`", ",", "12.08`", ",", "18.77`", ",", "12.08`", 
      ",", "12.08`", ",", "12.08`", ",", "12.08`", ",", "12.08`", ",", 
      "12.08`", ",", "15.31`", ",", "13.54`", ",", "15.11`", ",", "16.9`", 
      ",", "29.96`", ",", "32.73`", ",", "34.63`", ",", "29.23`", ",", 
      "29.7`", ",", "27.48`", ",", "22.96`", ",", "20.79`", ",", "18.8`", ",",
       "22.98`", ",", "15.68`", ",", "17.34`", ",", "23.41`", ",", "15.9`", 
      ",", "16.73`", ",", "20.25`", ",", "22.83`", ",", "23.61`", ",", 
      "41.99`", ",", "42.75`", ",", "37.48`", ",", "22.95`", ",", "37.73`", 
      ",", "42.94`", ",", "39.01`", ",", "43.94`", ",", "61.97`", ",", 
      "49.68`", ",", "34.08`", ",", "44.38`", ",", "39.71`", ",", "45.31`", 
      ",", "28.57`", ",", "12.2`", ",", "12.2`", ",", "12.2`", ",", "35.45`", 
      ",", "53.86`", ",", "62.2`", ",", "65.99`", ",", "94.84`", ",", 
      "133.72`", ",", "139.53`", ",", "130.51`", ",", "185.44`", ",", 
      "186.15`", ",", "196.83`", ",", "189.19`", ",", "188.82`", ",", 
      "179.28`", ",", "168.5`", ",", "188.99`", ",", "176.42`", ",", 
      "146.19`", ",", "146.14`", ",", "101.16`", ",", "74.33`", ",", "54.83`",
       ",", "94.11`", ",", "106.01`", ",", "103.37`", ",", "87.12`", ",", 
      "105.35`", ",", "115.67`", ",", "128.01`", ",", "137.01`", ",", 
      "173.5`", ",", "180.47`", ",", "188.6`", ",", "185.8`", ",", "173.98`", 
      ",", "240.08`", ",", "319.75`", ",", "284.61`", ",", "360.38`", ",", 
      "427.54`", ",", "449.61`", ",", "314.35`", ",", "307.41`", ",", 
      "198.54`", ",", "264.94`", ",", "179.69`", ",", "341.57`", ",", 
      "338.63`", ",", "554.82`", ",", "336.55`", ",", "478.43`", ",", 
      "298.14`", ",", "171.72`", ",", "153.88`", ",", "209.35`", ",", 
      "306.3`", ",", "368.69`", ",", "337.57`", ",", "336.68`", ",", 
      "316.99`", ",", "298.76`", ",", "186.05`", ",", "147.86`", ",", 
      "126.38`", ",", "275.05`", ",", "339.57`", ",", "354.26`", ",", 
      "348.98`", ",", "353.44`", ",", "320.57`", ",", "179.63`", ",", 
      "188.14`", ",", "162.16`", ",", "94.3`", ",", "102.84`", ",", "120.51`",
       ",", "125.7`", ",", "151.57`", ",", "164.62`", ",", "143.77`", ",", 
      "169.16`", ",", "153.23`", ",", "255.16`", ",", "264.93`", ",", 
      "271.58`", ",", "250.1`", ",", "260.29`", ",", "227.93`", ",", 
      "237.72`", ",", "242.2`", ",", "305.29`", ",", "308.11`", ",", 
      "316.09`", ",", "329.82`", ",", "353.79`", ",", "302.28`", ",", 
      "270.33`", ",", "303.81`", ",", "293.94`", ",", "249.92`", ",", 
      "280.22`", ",", "384.02`", ",", "409.38`", ",", "480.64`", ",", 
      "822.83`", ",", "822.83`", ",", "822.83`", ",", "822.83`", ",", 
      "822.83`", ",", "822.83`", ",", "822.83`", ",", "822.83`", ",", 
      "822.83`", ",", "822.83`", ",", "822.83`", ",", "822.83`", ",", 
      "822.83`", ",", "777.23`", ",", "822.83`", ",", "822.83`", ",", 
      "806.9`", ",", "551.09`", ",", "237.76`", ",", "335.59`", ",", 
      "314.63`", ",", "314.63`", ",", "535.31`", ",", "613.57`", ",", 
      "686.2`", ",", "576.78`", ",", "797.56`", ",", "643.96`", ",", 
      "688.35`", ",", "684.99`", ",", "717.91`", ",", "688.25`", ",", 
      "757.1`", ",", "735.21`", ",", "650.71`", ",", "680.48`", ",", 
      "790.39`", ",", "822.83`", ",", "822.83`", ",", "822.83`", ",", 
      "822.83`", ",", "822.83`", ",", "822.83`", ",", "547.99`", ",", 
      "673.67`", ",", "644.18`", ",", "658.73`", ",", "388.48`", ",", 
      "388.48`", ",", "388.48`", ",", "388.48`", ",", "388.48`", ",", 
      "388.48`", ",", "388.48`", ",", "388.48`", ",", "388.48`", ",", 
      "388.48`", ",", "388.48`", ",", "388.48`", ",", "388.48`", ",", 
      "388.48`", ",", "388.48`", ",", "388.48`", ",", "388.48`", ",", 
      "388.48`", ",", "388.48`", ",", "388.48`", ",", "388.48`", ",", 
      "388.48`", ",", "364.49`", ",", "369.33`", ",", "375.73`", ",", 
      "352.18`", ",", "357.6`", ",", "368.82`", ",", "309.5`", ",", "222.38`",
       ",", "98.33`", ",", "112.52`", ",", "115.36`", ",", "127.05`", ",", 
      "133.16`", ",", "136.11`", ",", "267.9`", ",", "240.36`", ",", 
      "193.63`", ",", "218.15`", ",", "198.83`", ",", "205.88`", ",", 
      "197.57`", ",", "194.1`", ",", "204.74`", ",", "219.09`", ",", 
      "195.18`", ",", "179.31`", ",", "174.05`", ",", "141.86`", ",", 
      "123.83`", ",", "101.63`", ",", "132.45`", ",", "48.15`", ",", "42.5`", 
      ",", "32.46`", ",", "30.25`", ",", "30.25`", ",", "30.25`", ",", 
      "30.25`", ",", "30.25`", ",", "30.25`", ",", "30.25`", ",", "47.76`", 
      ",", "30.25`", ",", "30.25`", ",", "40.26`", ",", "41.71`", ",", 
      "46.5`", ",", "50.42`", ",", "49.38`", ",", "84.7`", ",", "77.73`", ",",
       "70.19`", ",", "70.62`", ",", "56.79`", ",", "55.57`", ",", "53.75`", 
      ",", "54.1`", ",", "70.35`", ",", "79.62`", ",", "83.87`", ",", 
      "77.64`", ",", "74.45`", ",", "114.5`", ",", "114.78`", ",", "112.47`", 
      ",", "90.36`", ",", "126.11`", ",", "129.51`", ",", "133.94`", ",", 
      "136.9`", ",", "139.47`", ",", "148.67`", ",", "207.74`", ",", 
      "210.48`", ",", "189.23`", ",", "160.74`", ",", "229.16`", ",", 
      "174.71`", ",", "180.54`", ",", "167.7`", ",", "150.08`", ",", 
      "140.71`", ",", "100.4`", ",", "119.78`", ",", "141.27`", ",", 
      "113.03`", ",", "138.99`", ",", "98.62`", ",", "126.7`", ",", "127.5`", 
      ",", "99.46`", ",", "110.5`", ",", "118.69`", ",", "129.74`", ",", 
      "183", ",", "182.02`", ",", "233.55`", ",", "215.21`", ",", "230.14`", 
      ",", "415.78`", ",", "349.73`", ",", "344", ",", "326.72`", ",", 
      "437.61`", ",", "445.46`", ",", "458.7`", ",", "463.56`", ",", "33.68`",
       ",", "33.68`", ",", "33.68`", ",", "83.87`", ",", "89.66`", ",", 
      "231.5`", ",", "249.75`", ",", "261.75`", ",", "264.53`", ",", 
      "506.77`", ",", "533.82`", ",", "508.64`", ",", "493.79`", ",", 
      "442.35`", ",", "488.05`", ",", "533.82`", ",", "533.82`", ",", 
      "533.82`", ",", "533.82`", ",", "533.82`", ",", "533.82`", ",", 
      "533.82`", ",", "533.82`", ",", "464.57`", ",", "476.7`", ",", 
      "443.38`", ",", "206.09`", ",", "218.1`", ",", "212.08`", ",", 
      "271.76`", ",", "245.49`", ",", "193.6`", ",", "173.51`", ",", 
      "158.66`", ",", "184.6`", ",", "166.66`", ",", "172.33`", ",", 
      "167.11`", ",", "205.39`", ",", "196.86`", ",", "219.06`", ",", 
      "230.72`", ",", "215.34`", ",", "223.03`", ",", "40.16`", ",", "79.96`",
       ",", "118.17`", ",", "131.04`", ",", "209.5`", ",", "293.92`", ",", 
      "313.62`", ",", "327.41`"}], "}"}]}], ";"}]}]], "Input",ExpressionUUID->\
"19122dd2-2cee-4cd2-98c1-f5d8e2bb63eb"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"ListLinePlot", "[", 
  RowBox[{"precos", ",", 
   RowBox[{"PlotRange", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"All", ",", "All"}], "}"}]}], ",", 
   RowBox[{"Frame", "\[Rule]", "True"}], ",", 
   RowBox[{"FrameStyle", "\[Rule]", 
    RowBox[{"Directive", "[", 
     RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
   RowBox[{"FrameLabel", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"\"\<PLD (R$)\>\"", ",", "None"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{
       "\"\<Semanas\>\"", ",", "\"\<Submercado Sudeste / Centro-Oeste\>\""}], 
       "}"}]}], "}"}]}]}], "]"}]], "Input",ExpressionUUID->"2daa116e-d11c-\
4828-9247-7590b4c741ae"],

Cell[BoxData[
 GraphicsBox[{{}, {{}, {}, 
    {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
      NCache[
       Rational[1, 120], 0.008333333333333333]], AbsoluteThickness[1.6], 
     LineBox[CompressedData["
1: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
      
      "]]}}, {}, {}, {}, {}},
  AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
  Axes->{True, True},
  AxesLabel->{None, None},
  AxesOrigin->{0, 0},
  DisplayFunction->Identity,
  Frame->{{True, True}, {True, True}},
  FrameLabel->{{
     FormBox["\"PLD (R$)\"", TraditionalForm], None}, {
     FormBox["\"Semanas\"", TraditionalForm], 
     FormBox["\"Submercado Sudeste / Centro-Oeste\"", TraditionalForm]}},
  FrameStyle->Directive[18, 
    Thickness[Large]],
  FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
  GridLines->{None, None},
  GridLinesStyle->Directive[
    GrayLevel[0.5, 0.4]],
  ImagePadding->All,
  ImageSize->{881., Automatic},
  Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& ), "CopiedValueFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& )}},
  PlotRange->{{0, 702.}, {0, 822.83}},
  PlotRangeClipping->True,
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {
     Scaled[0.02], 
     Scaled[0.05]}},
  Ticks->{Automatic, Automatic}]], "Output",ExpressionUUID->"90b9febe-0b54-\
4818-9654-b1d0110ac64a"]
}, Open  ]],

Cell[TextData[{
 "Podemos fazer as mesmas exclus\[OTilde]es de tend\[EHat]ncias lineares e \
senoidais, por\[EAcute]m n\[ATilde]o \[EAcute] poss\[IAcute]vel levar em \
conta as irregularidades de uma forma que n\[ATilde]o seja ",
 StyleBox["ad-hoc.",
  FontSlant->"Italic"],
 " Isto n\[ATilde]o foi feito aqui pois necessitaria de um hist\[OAcute]rico \
completo das mudan\[CCedilla]as legislativas ocorridas no per\[IAcute]odo."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"e9aebbdb-6b25-4edc-ba12-81dcf540cb9f"],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"precosLinearTrend", ",", "precosS1"}], "}"}], "=", 
   RowBox[{"detrending", "[", 
    RowBox[{"differencing", "[", "precos", "]"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"precosSinusoidalComponents1", ",", "precosS2"}], "}"}], "=", 
   RowBox[{"removingSinusoidalComponents", "[", 
    RowBox[{"precosS1", ",", "0.3", ",", "1"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"precosSinusoidalComponents2", ",", "precosS3"}], "}"}], "=", 
   RowBox[{"removingSinusoidalComponents", "[", 
    RowBox[{"precosS2", ",", "0.18", ",", "1"}], "]"}]}], ";"}]}], "Input",Exp\
ressionUUID->"34a3686b-63dd-43ca-a47e-d7b51c40221e"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"{", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"ListLinePlot", "[", 
       RowBox[{"precosS1", ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Axes", "\[Rule]", "False"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "->", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"None", ",", "None"}], "}"}], ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Semanas\>\"", ",", 
             "\"\<S\[EAcute]rie \!\(\*SubscriptBox[\(s\), \(1\)]\) sem tend\
\[EHat]ncia linear\>\""}], "}"}]}], "}"}]}]}], "]"}], ",", 
      RowBox[{"ListLinePlot", "[", 
       RowBox[{"precosS2", ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Axes", "\[Rule]", "False"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "->", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"None", ",", "None"}], "}"}], ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Semanas\>\"", ",", 
             "\"\<S\[EAcute]rie \!\(\*SubscriptBox[\(s\), \(2\)]\) sem \
primeiras componentes senoidais\>\""}], "}"}]}], "}"}]}]}], "]"}], ",", 
      RowBox[{"ListLinePlot", "[", 
       RowBox[{"precosS3", ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Axes", "\[Rule]", "False"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "->", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"None", ",", "None"}], "}"}], ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Semanas\>\"", ",", 
             "\"\<S\[EAcute]rie final \!\(\*SubscriptBox[\(s\), \
\(3\)]\)\>\""}], "}"}]}], "}"}]}]}], "]"}]}], "}"}], ",", 
    "\[IndentingNewLine]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"ListLinePlot", "[", 
       RowBox[{
        RowBox[{"periodogramFrequency", "[", 
         RowBox[{"precosS1", ",", "1"}], "]"}], ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "\[Rule]", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"\"\<Pot\[EHat]ncia (u.a.)\>\"", ",", " ", "None"}], 
            "}"}], ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Frequ\[EHat]ncia (u.a.)\>\"", ",", 
             "\"\<Espectro - \!\(\*SubscriptBox[\(s\), \(1\)]\)\>\""}], 
            "}"}]}], "}"}]}]}], "]"}], ",", "\[IndentingNewLine]", 
      RowBox[{"ListLinePlot", "[", 
       RowBox[{
        RowBox[{"periodogramFrequency", "[", 
         RowBox[{"precosS2", ",", "1"}], "]"}], ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "\[Rule]", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"\"\<Pot\[EHat]ncia (u.a.)\>\"", ",", " ", "None"}], 
            "}"}], ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Frequ\[EHat]ncia (u.a.)\>\"", ",", 
             "\"\<Espectro - \!\(\*SubscriptBox[\(s\), \(2\)]\)\>\""}], 
            "}"}]}], "}"}]}]}], "]"}], ",", "\[IndentingNewLine]", 
      RowBox[{"ListLinePlot", "[", 
       RowBox[{
        RowBox[{"periodogramFrequency", "[", 
         RowBox[{"precosS3", ",", "1"}], "]"}], ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "\[Rule]", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"\"\<Pot\[EHat]ncia (u.a.)\>\"", ",", " ", "None"}], 
            "}"}], ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Frequ\[EHat]ncia (u.a.)\>\"", ",", 
             "\"\<Espectro - \!\(\*SubscriptBox[\(s\), \(3\)]\)\>\""}], 
            "}"}]}], "}"}]}]}], "]"}]}], "}"}], ",", "\[IndentingNewLine]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"ListPlot", "[", 
       RowBox[{
        RowBox[{"CorrelationFunction", "[", 
         RowBox[{"precosS3", ",", 
          RowBox[{"{", 
           RowBox[{"1", ",", 
            RowBox[{
             RowBox[{"Length", "@", "precosS3"}], "-", "1"}]}], "}"}]}], 
         "]"}], ",", 
        RowBox[{"Filling", "\[Rule]", "Axis"}], ",", 
        RowBox[{"Axes", "\[Rule]", "False"}], ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "\[Rule]", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
            "\"\<Correla\[CCedilla]\[ATilde]o\>\"", ",", " ", "None"}], "}"}],
            ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Semanas\>\"", ",", 
             "\"\<\!\(\*SubscriptBox[\(s\), \(3\)]\)\>\""}], "}"}]}], 
          "}"}]}]}], "]"}], ",", "\[IndentingNewLine]", 
      RowBox[{"Show", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"ListPlot", "[", 
          RowBox[{
           RowBox[{"PartialCorrelationFunction", "[", 
            RowBox[{"precosS3", ",", 
             RowBox[{"{", 
              RowBox[{"1", ",", 
               RowBox[{
                RowBox[{"Length", "@", "precosS3"}], "-", "1"}]}], "}"}]}], 
            "]"}], ",", 
           RowBox[{"Filling", "\[Rule]", "Axis"}], ",", 
           RowBox[{"Axes", "\[Rule]", "False"}], ",", 
           RowBox[{"PlotRange", "\[Rule]", 
            RowBox[{"{", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{"0", ",", "60"}], "}"}], ",", "All"}], "}"}]}], ",", 
           RowBox[{"Frame", "\[Rule]", "True"}], ",", 
           RowBox[{"FrameStyle", "\[Rule]", 
            RowBox[{"Directive", "[", 
             RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
           RowBox[{"FrameLabel", "\[Rule]", 
            RowBox[{"{", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{
               "\"\<Correla\[CCedilla]\[ATilde]o Parcial\>\"", ",", " ", 
                "None"}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{
               "\"\<Semanas\>\"", ",", 
                "\"\<\!\(\*SubscriptBox[\(s\), \(3\)]\)\>\""}], "}"}]}], 
             "}"}]}]}], "]"}], ",", 
         RowBox[{"Plot", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"y", "=", 
              RowBox[{"2.", "/", 
               RowBox[{"\[Sqrt]", 
                RowBox[{"Length", "[", "precosS3", "]"}]}]}]}], ",", 
             RowBox[{"y", "=", 
              RowBox[{
               RowBox[{"-", "2."}], "/", 
               RowBox[{"\[Sqrt]", 
                RowBox[{"Length", "[", "precosS3", "]"}]}]}]}]}], "}"}], ",", 
           
           RowBox[{"{", 
            RowBox[{"x", ",", "0", ",", 
             RowBox[{"Length", "@", "precosS3"}]}], "}"}], ",", 
           RowBox[{"PlotStyle", "\[Rule]", "Orange"}]}], "]"}]}], "}"}], 
       "]"}], ",", "\[IndentingNewLine]", 
      RowBox[{"ListPlot", "[", 
       RowBox[{
        RowBox[{"CovarianceFunction", "[", 
         RowBox[{"precosS3", ",", 
          RowBox[{"{", 
           RowBox[{"1", ",", 
            RowBox[{
             RowBox[{"Length", "@", "precosS3"}], "-", "1"}]}], "}"}]}], 
         "]"}], ",", 
        RowBox[{"Axes", "\[Rule]", "False"}], ",", 
        RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
        RowBox[{"Filling", "\[Rule]", "Axis"}], ",", 
        RowBox[{"Frame", "\[Rule]", "True"}], ",", 
        RowBox[{"FrameStyle", "\[Rule]", 
         RowBox[{"Directive", "[", 
          RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
        RowBox[{"FrameLabel", "\[Rule]", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"\"\<Covari\[AHat]ncia\>\"", ",", " ", "None"}], "}"}], 
           ",", 
           RowBox[{"{", 
            RowBox[{
            "\"\<Semanas\>\"", ",", 
             "\"\<\!\(\*SubscriptBox[\(s\), \(3\)]\)\>\""}], "}"}]}], 
          "}"}]}]}], "]"}]}], "}"}]}], "}"}], "//", "GraphicsGrid"}]], "Input",\
ExpressionUUID->"bd09cfec-43a8-4c34-b00b-6b2b9420c0f2"],

Cell[BoxData[
 GraphicsBox[{{}, {{InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           NCache[
            Rational[1, 120], 0.008333333333333333]], AbsoluteThickness[1.6], 
          LineBox[CompressedData["
1:eJw9Wndcze37PynKLJGicIyG8RDfBxnlbVNKykjCae+c9qnTOJOiKKFFHSGV
kCKRyHyyklEaRjQkK4/CY/76vVw3f/B6uz/357rf13Xd1/qcUU6bbVx7cDic
su6//v/f33865ho171ZoablepP9A7LBRHk2DGVZDu/WxySf/YA2Yb535OeoP
HoyjZdcuLP+DddCvc+WWYX+wHnzHP7VsG8QwF5U8L63iP3g0Jid/eiz9g8ci
4Y7k0Mo/2AAdyuo+I/9gI6yclf6/t5oMj0ch3/DbuT94IhTXhT6HLoTM/Y0n
4el3tTmtu/cRNsbnxBspj/SOEJ6CIr/O2T6/ThGeCvvgl+tTkEXv+x/0unK9
F5UcpPW/8XlgRele7320Pg2lEXrNoRlnCU/HIh+f3S16xwnPwIFC1zU56YW0
3wSzLm3XzPwvhtZnYtb5idyOoQcIz4KRqsPybcJoen429tkNGuU6MIvwHAS9
19ujXBxD2BR6ooUhL1MltN8M/8UXy5L6svPPxZz9kQMHfJIRBnQLXLktT/J/
7xcB28y/DrlTzPjMw4zEN+76s0kfonm4cnVdx03vXFqfj+prEkOBIPs3Fs3H
OtfczfWmbP8CDO9n8rlkEmHRAlye9Jd9x/mTdN6FsPf58SVmwW56/0I0bH4U
9biL8V2EHmsq1n1LJL6iRVj+offVPNsQev9iWB5clm/0pYTevxiH2x/lZf7w
of1LsO3SaoMeRxNp/xLYZ/Os74ak0P6lyKhs57psPUX7l2LlkGd9jvZl/rMM
hcu97wsYFi3DIOnn1MV/1s3hVmoRfbZVTuvmePhefdyLPmzdAtMM9nWcYFhk
gc7hr/Mfdl6g8y3H+KfDreIyrtL5luNFj9mbzhYeo/2W+BYuLzIsvUzrlmh5
t8By3O77tG6FOweL78fyk2jdCg2yCWX7wnzp/SswYFN51v6YiyR/Bfarb+t8
rcbOZ40+aU+G3dM6+/t5WOPkuCdvxs4qpOetsfB84tjrWrG/cbk1PN+pGMTs
Zvpbie1jY4NrDnr/xlgJw/SGlzdGl9J5VqJeohVhdI78vXwlzimfe+/dwvzX
Bho9LYUjNwXTfhsMPh7i++rOXtpvgwYfN+PFdZG03wYL0lfyNKYm0H5bZJtU
2gwOzKPz26L21s8JK+Yn0Pltwf2+PvltMJ2n3BZFl6Uu+0Yw/1yFN8XW8Twz
ug9Yhdp9N9Rb7feT/FUIeYeVs/+cfxW+cgJieAoF7V+Nio/heuFlcbR/Ne6V
d9V3vNpO8ldDeXx6n2qb67R/NT7b92g6U7qN9q+B9dJe+dbHc2j/GlwrCTW3
uHyY5K/BVWHoOO21KbR/Db7lP48tuFlO+9diWLzV2gd3KR5hLapfr56E9f+Q
/LWodKw393SOJPutRb5U+PPjlwLabwfLm/Mcn84i/4Idlj/kal/LvEL77ZDH
s4hb3PM4ybdDceCz8uWVB0j/62A6qazvnp6H6fzrsLEkVXPwQfJf0Tq8rtLb
07vuPMlfhznHtmed5hSTfHuESNzT5VqkL9ijp8OQO4pRdD6RPT4gb+GJFopf
5faY73EQ5hzmv+txMGOymg7DWA+V6tK7Lb9caP96uPZdmlzEcPl6XJ/3cKOY
YY4DDAU8gxUMwwFbj795q/dnvwPamgWn23+y/Q5YptszsoRhzgbkrUxcuIVh
bEDfmOH9VjEs2oD4MWP6FvpWkf424JKtav8zq4/S/o3Q21K1lJ8vIP1vRNu5
kb3GhofS/o04ptk6yyme6W8jhq4KrUi3PkT63wRO3cnStibyV2xCnrJ+28DA
OvKfTdj06VMvs1SKj+WbEHt25F0TQ5Z/eNgdvu6j6Pyd3+tcHhwquRmGWXQ/
wUM/zsdWZ6Xq35jHQ65A1WW//jZ6f/f60bMDlONO/t6v4IH/2U0zWvk0yeNh
quuYlz1OVP/GjTykG7wad934OvF3RMS7upcqsyhfcR3x6/Jwh8UbmXxHGG84
Zij0Kif5jrBpxLSt0+tJviN2XGizHlFG51E4oueaftysfWdI3937H7Q3iDbc
/o0bHXFPYBP94hjFQ44T2o6aqNVNofvDdUJI2XIdc/sKku+EscNv39J9u4fk
OyG14LLBBQsWr53wKqZ19KAvlD8UTvhu2qXa/8Jd4u8E5YVDdGao0H1sdEL6
kXe+sQ3nSP/OiM3cGde74zzJd8aeCNOXpanEF84oFizSqv1A+uU5Y1t9oYtq
uJD8wxka3PD+oxbcI/7OsDw5fmHPs53E3xkvHB819Gt8Tvyd8T5wxI0hn5j/
uqDS9qx8+tgy0r8LOo2dHK56fyN/dsGgooHlKXPaSL4LTIb1nXHDmfQjckGb
Nuflspr7JN8FN3tvvWekWk/8XZAo2vnl16EjxN8F5w/lzs14e5f4u2IGp6TV
ZV4zyXdFovGTse0rSD9wxWSVAJuURSSP54pLzywmtObcI/6uKD4q9Q9Oe0D6
d0Vfu5mrpky4RPxdsUX8XdM8iOJJoytapr3Taa4tIv5uWNtZNSn3KeU/rhtm
2Bm82XCjmOS7IWlDjmNP3ysk3w0qZ54vqJriSfLd0NrvwqplQQdJvhsa9o9N
n/GM/LfcDaKvKon/6heQ/t0wM3Jq2Rsblr/cURWfkf/pygmS7w6Ok2nLRS2K
/3BH7tbRrw7m3CD57qj/1NTz4jxWb7nj25zdNoeWkD8r3HEhzbv6X8NK0r87
3KZWpc3pYPp3x6PlRfxdS0g/HA9kp2VG6KVQPcb1gNK9Ef04RwnDA8ucelTw
7eJJvgdqBLFlfcHqCQ/E7F2VFxO3i+R7IMk2Ovy/sEsk3wN9uH9fuDmP8m+j
B/TWv4+72ELxiuOJCf9q8BKV0km+J1xmaRlFOpG+4Ikd2uua76wm/fI84fH6
S621WynJ98S2oqc3Rt6jekHhCaORgyy3i7JJ/55I+ZUTuMntKMn3hKnwrJGa
F8ufXmipt+qaMOQc+Z8XwrTu+PQfQf4FL2Rf9zJtrmf+54V7arYud/Y2kP97
odTw23e7ymvE3wtOewVJpsOriL8X0oJtDO+LqV5q9IKm2vVNw8ro/BxvXAku
HZCseZXke2OSn9RiZjXdD3hjdpu52ygVqhd53vCNOug2sDf5o8gbsy47tVgc
JX9WeKNgckhwvj35U7k3TuflhFQHN5J8b1RH1ay/+ewf0r8P+ml7vZ43juIL
1wd66w7vHd7G6gkffK96Kn+eZkPyfRB1alfaVSHL7z7Q5rZubx3qRfJ9kFUZ
q7RY15Xk+2Di9G3PLY9akv59MFhlgccDTfIXji9WfTd60Xkjk+zvi6gtK173
/SQi+b6Im7SiV3uPXJLvi4Qx3l91w4mvyBfCqKacvfvIvxW+cO9n6Rc+g+57
uS/yy8ZJJv9lT/J9od6U2FooYPWbH3bnCN9MbaV4yPVD11PVUxyG4YfVWruF
lS2EeX4otuAu2MewyA/akvw+Xgwr/CAoMbk/g+FyP9S9u5rak+FGP8zSX+n4
oJnF381IX//E6ADD3M34lujZ4ccwNsOhouvMHIZ5m1H2Uxzdh2HRZoyYNmBJ
bROTvxnR3mkDshku34zGAwY1gQw3bsa82sL98xjm8HFgwFxXdYY1+Oix6NbE
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
WMP3pu8nbXJs9P7niKioaO7/AT8EcI8=
           "]]}}, {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{False, False},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{None, None}, {
          FormBox["\"Semanas\"", TraditionalForm], 
          FormBox[
          "\"S\[EAcute]rie \\!\\(\\*SubscriptBox[\\(s\\), \\(1\\)]\\) sem \
tend\[EHat]ncia linear\"", TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 701.}, {-2.479724907763655, 1.969363345829414}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.05], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {193.5, -119.58957682310464}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}], InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           NCache[
            Rational[1, 120], 0.008333333333333333]], AbsoluteThickness[1.6], 
          LineBox[CompressedData["
1:eJw1WnlcjVsXPuaMZS5jEkK6h5uKK55kKFQnDRp1GlQaT/Nc75mUTAmVMpSK
zCmRhINKQkIqISclSch0b+av79d6/cFvWe/ea6+91nrWsM80F//1m/pyOJwr
PX/9/9/eP13L1u6ZtLoy79oy+g886iqWmWUkEa2A684GB53Va4hWQly6RJB+
qJDoMQgZPKximOGBa720Mpxb9hjuf3yC+JOwx/JZRJP8FtGqWPihPkzqeYS+
V8O1sBrLMeVFxFdH3yd/QtdOKyN6JhJ+Pbyk2S4gWgOu6bZx/l8v0Po5WDLB
f5DjXTHxNTHQPnGNdWMR8bXwZKxeqUpjFtFc5AyR/dbK2k70fMgkeTfWatym
9QvgdOyQ0N6zlPh/40mebkb25Uria+PVl8EFLYdlxF+IEdkGG4v3s+fRQVJ3
tbhtYjnRusjUmj3B3/8g0XrQGSky6FheQfQipCy+/tgh4TrRi6HW9LjNbWwG
yfsHnovfzlphwn6/BDcO47/kmcXE10e7/ska/QwJ0UvByV3RrF+8iL5fhkkT
Una8V95KfMDqV+JAyZW7vTQDrDg+3rBPylXiG0D5d7T3zSt0n4wBnHw3DjzZ
dJ34y7HEtjFqcdrF3v2Z5TDk5acuP5xO8gwxXjdU/xz/BvEN0b8hzGvh1nJa
vwKc7wH9LVLMib8Cn89wNI+4sP6yErXulbf9990g+Stht2pUeb+rZ4i/CqIQ
c8XZvudp/SoEzp+67cfbsyR/NcY6HNk/3eIk8VejO3/s3VnseTlGuDQomNfe
n+6TMQJX8+/07pD9xDeG8YugsoSGIyTfGFtTfFwez2Dvew2MTgSPVjEhf2LW
YNWEZ/6bHoUSfy3Wzfa1GWrL8tdCo6Og7eWZ/cRfB+6ck1Xft+8m/jokr5ms
7XcvleSbwEcpILzh3UWSb4JA93s7p4puEd8UCVvmSjX/20zrTVEw37F+1vb7
tL8ZFgsrOh+o3SW+GZ4mZjTHV5wjPg8K1c+e7d5J9gIPp9p0hlzLy6TveVi/
lLcr60VxLy3jweCQ1eu/eaz/muMdzujd5dL5YI401+v9bKIoXhlznJjbFTyx
6kovLTPHgYrbua8a40j+eoyY+OKfRcdSaP16lF4zOKqzaS/JX49z0s/xo/aS
fWTr8bnP7LQL/5TSegvYmai5W1zJofNbQO2FXMGz6wLJtwBTHxDR7edA6y3A
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
aZdieZLl3qD4qmX/A/oYkzg=
           "]]}}, {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{False, False},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{None, None}, {
          FormBox["\"Semanas\"", TraditionalForm], 
          FormBox[
          "\"S\[EAcute]rie \\!\\(\\*SubscriptBox[\\(s\\), \\(2\\)]\\) sem \
primeiras componentes senoidais\"", TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 701.}, {-2.0229601444921244`, 1.6923492997196392`}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.05], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {580.5, -119.58957682310464}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}], InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           NCache[
            Rational[1, 120], 0.008333333333333333]], AbsoluteThickness[1.6], 
          LineBox[CompressedData["
1:eJw9WnlczN33H3uWKGv2kSj7SJG1dyFFmFK0m/ZNNe1TTfWZjSwxthQesidb
kkq2kZCEIUsII6GeUCGyPPr2e3U+v/7Q67ife8892/sst1FeYfa+HTkczuW2
f/7vd/tPo/nAkyZ/3TpeMKf/wPE9xQezHj4kWguzjvw6KlfcJ1oHERmXHxuZ
XiK6P2xvaf23wffc1XZaDzn+E8yqO2XR+jBUnv/D7TFeRTQXzK9DA7r1Pk+0
PvjKUfqT1GeJNgCz1+FnuOYE0WPRf6rFu4Sfl+h8I1zBsKZNF7OIHg+zfKeo
lqPs9xPxfumBxrrkvbQ+GdyQxec7ZKqI5qFpycaUkttniJ4Kn78+2jsUubTf
GIvLbXQ7/7hD69Pwfv202pW5l2ndBB+fjNmeP4nVlylu/t1ZdH5ZMX0/HbVP
+EGvnXcTPQONx4LurrrOrpuhp5379xBdVl8zkdVt1rfnHdj7zIKbvrqv354S
On82xBV5c179zKf1OShcHqslGsnqay6Ghbn1ddlyheh52Ju6757c7AR9b45r
kS9irFIOEQ0oZ+hy1u0ubv+eAeKfHc8wrzxP6xZwWa36djrnEK1b4Mtel8H5
/x2l8y1hXTHh46ZIOp+xxPiRVwsWhLP6nw+nPn93TxpUROvz8T5NN3/7ADWt
L0Bx77eXP7nk0/kLcOWCIcf5/XbivxBMc8A4XcVG2r8QHGHqgG2eEbRuBVdZ
2LAP9w7SuhV2/xrr21T1kNYX4WjB2ys5uldpfREKS2O0JNyNxN8az//kzplr
cJHWrcHdOdYqw+MWrdvgj+GAxOpb5J+MDew9e5ge2Ub35SzG07gfhy3X7qD9
izFv5NGCZX3oPM4SNN143qR35AbtX4K9+pePmZbtpHVbWI2P058fQ/ZlbDG+
fPnUqStv0/pSvCzq4uH+L8ULsxR/v67puSuElW8ZNP0b4tu+I/7LAGyu/Dvo
Md1vOabzt3eL6XqZ1pdjarTxLkPJBdrPx92hEbbbVp9tp8HH+gd6U4/mP6Dv
+eAcXj9w9qm89vNUfAgHNK96Oy2P9ttBVGd/5/omefs67FA6fOKN5ivpdF87
jP+6s2zw8hzab4e+nW11So3ZeLFHdnS1m8X2Atpvj0utjGa+iPCFscejcsk8
XtqVdn4qe/QyejQqdNk12r8CTg9bCs2qUmn/Clh3DQod92UP3X8FZA9WrTY/
T/KqViDCZ090sH857XdAvHGUXc2QGyS/Ax5wTsa5XrhO/B2Q9abU43AT6V/l
gJXiGKvA/8cHRxQ43M1f2JXW4Yh3+r8/WQ49RfsdMaT21LWpx4mfyhHdPE3N
smdVkP5W4k3xhYtVhqRPrMTWfvtL1z1n7bUSmb9eXyzmsPdfiZyRazyrNouI
/yp09TpX2O8v6Qer8LPWfE0XLXb/Khxy/BG4KIniU7UKnBgH377FHrTfCZ5r
76VNyyY8hRPU/YI3F9fcpP1OuHVu08dlP27S/Z2w/FQMd0gRnc9xxuTQS99s
3hGewhm8A1X/aS4eJvmdkakcqWWwhdWfM7x7vnDq7n2L9rugemnX436rWP25
4N67SqcYs5PE3wVp+h7GqhHX6P4uSJrs5VJxluKZ44q/jo+D3nd+RftdwZnn
qOEdI/xjXOF6+F4vg2yWvyv0eolT4i1Z/3GD+l3L7eUXz9B+N8T1+9b6x5Ts
w7jhTNqs/MHzS4m/G1ZUvGu8vZCNb3dYxmnrVEhLSH53vDsRPHWlO+s/7ih6
8Sg5v4TwROUOG1HYnUO2p2m/B8bPGZv9y6mI+HsgIrvXrM29Smm/B1q1Op5O
4JG+VB74pV2R8OPNcdq/GtZOJicCdh6g/auh0p7+z59q1v9XY2OJ9ox1vHLa
vxoBubFapS4baL8Avd9Jpurokz65AgweUteQp83igQAdsg6nysKet58vEEDg
rOuzJEVJ9xNgkd3z3N265L+ZAlzXUZ9WN1F+UwmQNaTu5X+PM9q/1whQMiCu
rnc4m/89IfccXzP6PsnL9YTJ/BFm1RVHiL8nOAMuH4jtWkH8PXFydFNDk/kT
4u+JBb4Ly355kD9meuLthaFdzXdSPaDyxFLd4rzvSZRvNJ5wne73M6iexVcv
mLSunxc/iOoXrhfS/DO+PWskvIMXpi27pN24gvxZ4AXmwcTZQ4UJpF8vpH7y
nvYQx9vXM72QncRk5OrmEv+279NXMfN1E9tpjRdqkh2WPCth6wFvuPVJar57
g/CQ642TXplzav8WkvzeYOSDsrd8p3wr8Ea/t9w9hx2oHmG8UX0tfIT9pTLi
7419UZZzH86tI3/zRkbD/omP3z0j+b1xtu7A93JPtv7xwfrQ6TLjGIovrg9W
hizwdq/6SPx9cCgzy82138t2WuCDGV7TMgZ9IXswPvAJvblX+xvpK9MH2R26
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
/x9HZoMq
           "]]}}, {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{False, False},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{None, None}, {
          FormBox["\"Semanas\"", TraditionalForm], 
          FormBox[
          "\"S\[EAcute]rie final \\!\\(\\*SubscriptBox[\\(s\\), \
\\(3\\)]\\)\"", TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 701.}, {-1.430873482617145, 1.4190977470601627`}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.05], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {967.5, -119.58957682310464}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}]}, {InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           NCache[
            Rational[1, 90], 0.011111111111111112`]], AbsoluteThickness[1.6], 
          LineBox[CompressedData["
1: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
P3y71FY=
           "]]}}, {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{True, True},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{
          FormBox["\"Pot\[EHat]ncia (u.a.)\"", TraditionalForm], None}, {
          FormBox["\"Frequ\[EHat]ncia (u.a.)\"", TraditionalForm], 
          FormBox[
          "\"Espectro - \\!\\(\\*SubscriptBox[\\(s\\), \\(1\\)]\\)\"", 
           TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 0.4978601997146933}, {0, 0.8146885774007356}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.02], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {193.5, -358.76873046931394}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}], InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           NCache[
            Rational[1, 90], 0.011111111111111112`]], AbsoluteThickness[1.6], 
          LineBox[CompressedData["
1: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
Si2V/T9AqbIe
           "]]}}, {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{True, True},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{
          FormBox["\"Pot\[EHat]ncia (u.a.)\"", TraditionalForm], None}, {
          FormBox["\"Frequ\[EHat]ncia (u.a.)\"", TraditionalForm], 
          FormBox[
          "\"Espectro - \\!\\(\\*SubscriptBox[\\(s\\), \\(2\\)]\\)\"", 
           TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 0.4978601997146933}, {0, 0.3231631161680858}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.02], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {580.5, -358.76873046931394}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}], InsetBox[
      GraphicsBox[{{}, {{}, {}, 
         {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
           NCache[
            Rational[1, 90], 0.011111111111111112`]], AbsoluteThickness[1.6], 
          LineBox[CompressedData["
1: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
xK6l/A9N8KV7
           "]]}}, {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{True, True},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{
          FormBox["\"Pot\[EHat]ncia (u.a.)\"", TraditionalForm], None}, {
          FormBox["\"Frequ\[EHat]ncia (u.a.)\"", TraditionalForm], 
          FormBox[
          "\"Espectro - \\!\\(\\*SubscriptBox[\\(s\\), \\(3\\)]\\)\"", 
           TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 0.4978601997146933}, {0, 0.26924749720324165`}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.02], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {967.5, -358.76873046931394}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499621}]}, {InsetBox[
      GraphicsBox[{{}, GraphicsComplexBox[CompressedData["
1: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
UX+bYtDIvWnHPF+6vjkGYszJJ3YuNL4tMdgrNF/xKnMg1T8W0RsXPNkRTuuX
LBaX/6m6YfMOir/yWFQ51+dtDZHWW0UsduxOlvcV6fkDsXD8LWHYksE0vpWx
SJdS75+NV1H9Y5Hm/XV23JFhNP5j8XBLS2XiP7TeiLE4VP3Aa6kpxXN9LHSf
mte+Fk/7SSkWm51m5c4fQvUzxKJunv78+umUbvx1vcZJrvuvUrwzxeJRfu0+
K6z7U3MstlwZUKxJo/luiYXUa19W53LW98dxsHltOh1Wi+aTLA7JyvGnu/Sj
8SOPQ0qnjuNlWfS+SRGHmXU6nyisSeMHcZiz+9lwz4qUXxmHLrvazsitRvFC
FYf7+Xbfnt6jeKWOw8u4IzfPtaH4Icbh3IPk7poP1H76ONxMv163nIbuV4rD
LPm+NW/KUXmGOCzX5X694k/Pi8Y45K17XWPfTUo3xcG86O6Iumr6XmWOw5Zj
gfsKJtN8scTh3ZIGv+XOt34vi0dwwOiojqD2lMXjwP2XM6cW0/tDeTzKr0hU
qWbReq2Ixx3N85C1Wdbn83is7iyO612Fnt+U8Vh36VnN8Y2t+994SF+OLYnr
QOunOh79RkYcXnXJneofj6y7TQyy5hTv9fEYt26P/ZmZNL6lePy0EQvimlJ8
MMSjhVCYGRVF+Y3xOPezefXPW+l9vSkezscHK2TzrPufeETax55JmU/5LfEo
vlDVxWYJvW8QEjBdb3uicIK1/gloav9Z5XKU4ok8Aecj37Q9v4L2W4oEqG5f
vKQLpvUFCSi3PLqiZ13avyoT0Ndt3BX1PXq+USWg54pTry/Mof5QJ+CVvE6j
4grW70EJMG9eNulgT1oP9AlYeGjlkQpPaT2REnDnQITx4VLajxoSMNbhy5Zl
SbQeGBNQ/Uz3m2Oa0fs5UwJG9jlu6Hienq/NCbi5/J8rdq60n7ckYLetS8BL
s3X9T8StM0njmp2l95myRLxJT9uTOoTmkzwRCw8ENNjgRPevSERq/oWhnkk0
fpCIeHuPwQ/nWONfIhYXr9+VlUb9p0rEP6vMnV4Pt+5/EjH4ervdb2omUP8n
ovmHf5ddy6PnMX0ibrZpccH5b7qelIgjdv+e1tSg9y2GRNxT7No6e651/U/E
vnqPM/vuDKf6J6KlU99hHd7R+xdzIpLXuX8+uIe+L1gS4Xd51qG6TWg/IySh
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
zwxmFbPILDEbmc3MQjArnxnMKmaRWWI2MpuZhRBWPjOYVcwis8RsZDYzC+rS
ljHLmRXMYFYyq5jVzCKznlliNjAbmU3MZmYLsxBa2jJmObOCGcxKZhWzmllk
1jNLzAZmI7OJ2cxsYRbCSlvGLGdWMINZyaxiVjOLzHpmidnAbGQ2MZuZLcxC
eGnLmOXMCmYwK5lVzGpmkVnPLDEbmI3MJmYzs4VZiChtGbOcWcEMZiWzilnN
LDLrmSVmA7OR2cRsZrYwC5GlLWOWMyuYwaxkVjGrmUVmPbPEbGA2MpuYzcwW
ZiGqtGXMcmYFM5iVzCpmNbPIrGeWmA3MRmYTs5nZwixEl7aMWc6sYAazklnF
rGYWmfXMErOB2chsYjYzW5gFTWnLmOXMCmYwK5lVzGpmkVnPLDEbmI3MJmYz
s4VZiCltGbOcWcEMZiWzilnNLDLrmSVmA7OR2cRsZrYwC7GlLWOWMyuYwaxk
VjGrmUVmPbPEbGA2MpuYzcwWZiGutGXMcmYFM5iVzCpmNbPIrGeWmA3MRmYT
s5nZwizEl7aMWc6sYAazklnFrGYWmfXMErOB2chsYjYzW5iFhNKWMcuZFcxg
VjKrmNXMIrOeWWI2MBuZTcxmZguzkFjaMmY5s4IZzEpmFbOaWWTWM0vMBmYj
s4nZzGxhFpJKW8YsZ1Ywg1nJrGJWM4vMemaJ2cBsZDYxm5ktzIJY2jbMMmZb
ZjmzPbOC2YEZzI7MSmY3ZhWzH7OaWcMsMs9n1jNnMkvM2cwG5gPMRuZ8ZhNz
AbOZuZDZwlzELCSXtg2zjNmWWc5sz6xgdmAGsyOzktmNWcXsx6xm1jCLzPOZ
9cyZzBJzNrOB+QCzkTmf2cRcwGxmLmS2MBcxC9rStmGWMdsyy5ntmRXMDsxg
dmRWMrsxq5j9mNXMGmaReT6znjmTWWLOZjYwH2A2Muczm5gLmM3MhcwW5iJm
IaW0bZhlzLbMcmZ7ZgWzAzOYHZmVzG7MKmY/ZjWzhllkns+sZ85klpizmQ3M
B5iNzPnMJuYCZjNzIbOFuYhZ0JW2DbOM2ZZZzmzPrGB2YAazI7OS2Y1ZxezH
rGbWMIvM85n1zJnMEnM2s4H5ALOROZ/ZxFzAbGYuZLYwFzELqaVtwyxjtmWW
M9szK5gdmMHsyKxkdmNWMfsxq5k1zCLzfGY9cyazxJzNbGA+wGxkzmc2MRcw
m5nLzt8tO3+37PzdsvN3y87fpfLLzt8tO3+37PzdsvN3y87fLSm/7PzdsvN3
y87fLTt/t+z83ZLyy87fLTt/t+z83bLzd8vO3y2pf9n5u2Xn75adv1t2/m7Z
+bsl9S87f7fs/N2y83fLzt8tO3+3pP5l5++Wnb9bdv5u2fm7ZefvlvR/2fm7
Zefvlp2/W3b+btn5uyX9X3b+btn5u2Xn7/5/zt/9H/cePz8=
         "], {{{}, {}, {}, 
           {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
            LineBox[{703, 3}], LineBox[{704, 4}], LineBox[{705, 5}], 
            LineBox[{706, 6}], LineBox[{711, 11}], LineBox[{712, 12}], 
            LineBox[{714, 14}], LineBox[{715, 15}], LineBox[{717, 17}], 
            LineBox[{719, 19}], LineBox[{720, 20}], LineBox[{722, 22}], 
            LineBox[{724, 24}], LineBox[{727, 27}], LineBox[{728, 28}], 
            LineBox[{731, 31}], LineBox[{732, 32}], LineBox[{733, 33}], 
            LineBox[{734, 34}], LineBox[{735, 35}], LineBox[{740, 40}], 
            LineBox[{741, 41}], LineBox[{742, 42}], LineBox[{743, 43}], 
            LineBox[{747, 47}], LineBox[{749, 49}], LineBox[{750, 50}], 
            LineBox[{751, 51}], LineBox[{753, 53}], LineBox[{755, 55}], 
            LineBox[{757, 57}], LineBox[{758, 58}], LineBox[{761, 61}], 
            LineBox[{763, 63}], LineBox[{765, 65}], LineBox[{767, 67}], 
            LineBox[{768, 68}], LineBox[{771, 71}], LineBox[{774, 74}], 
            LineBox[{775, 75}], LineBox[{777, 77}], LineBox[{779, 79}], 
            LineBox[{783, 83}], LineBox[{787, 87}], LineBox[{788, 88}], 
            LineBox[{789, 89}], LineBox[{791, 91}], LineBox[{793, 93}], 
            LineBox[{795, 95}], LineBox[{797, 97}], LineBox[{798, 98}], 
            LineBox[{800, 100}], LineBox[{801, 101}], LineBox[{805, 105}], 
            LineBox[{807, 107}], LineBox[{809, 109}], LineBox[{811, 111}], 
            LineBox[{812, 112}], LineBox[{813, 113}], LineBox[{817, 117}], 
            LineBox[{820, 120}], LineBox[{823, 123}], LineBox[{824, 124}], 
            LineBox[{826, 126}], LineBox[{827, 127}], LineBox[{830, 130}], 
            LineBox[{833, 133}], LineBox[{834, 134}], LineBox[{835, 135}], 
            LineBox[{837, 137}], LineBox[{841, 141}], LineBox[{843, 143}], 
            LineBox[{845, 145}], LineBox[{847, 147}], LineBox[{849, 149}], 
            LineBox[{851, 151}], LineBox[{852, 152}], LineBox[{855, 155}], 
            LineBox[{857, 157}], LineBox[{859, 159}], LineBox[{860, 160}], 
            LineBox[{861, 161}], LineBox[{862, 162}], LineBox[{863, 163}], 
            LineBox[{867, 167}], LineBox[{868, 168}], LineBox[{869, 169}], 
            LineBox[{870, 170}], LineBox[{871, 171}], LineBox[{873, 173}], 
            LineBox[{875, 175}], LineBox[{877, 177}], LineBox[{879, 179}], 
            LineBox[{881, 181}], LineBox[{887, 187}], LineBox[{888, 188}], 
            LineBox[{889, 189}], LineBox[{893, 193}], LineBox[{895, 195}], 
            LineBox[{896, 196}], LineBox[{897, 197}], LineBox[{900, 200}], 
            LineBox[{901, 201}], LineBox[{902, 202}], LineBox[{904, 204}], 
            LineBox[{907, 207}], LineBox[{909, 209}], LineBox[{911, 211}], 
            LineBox[{912, 212}], LineBox[{913, 213}], LineBox[{915, 215}], 
            LineBox[{916, 216}], LineBox[{917, 217}], LineBox[{919, 219}], 
            LineBox[{920, 220}], LineBox[{921, 221}], LineBox[{923, 223}], 
            LineBox[{927, 227}], LineBox[{929, 229}], LineBox[{930, 230}], 
            LineBox[{931, 231}], LineBox[{932, 232}], LineBox[{935, 235}], 
            LineBox[{938, 238}], LineBox[{940, 240}], LineBox[{941, 241}], 
            LineBox[{945, 245}], LineBox[{947, 247}], LineBox[{948, 248}], 
            LineBox[{949, 249}], LineBox[{955, 255}], LineBox[{956, 256}], 
            LineBox[{957, 257}], LineBox[{958, 258}], LineBox[{959, 259}], 
            LineBox[{961, 261}], LineBox[{965, 265}], LineBox[{966, 266}], 
            LineBox[{967, 267}], LineBox[{968, 268}], LineBox[{969, 269}], 
            LineBox[{971, 271}], LineBox[{973, 273}], LineBox[{975, 275}], 
            LineBox[{977, 277}], LineBox[{981, 281}], LineBox[{983, 283}], 
            LineBox[{985, 285}], LineBox[{987, 287}], LineBox[{988, 288}], 
            LineBox[{989, 289}], LineBox[{991, 291}], LineBox[{992, 292}], 
            LineBox[{993, 293}], LineBox[{994, 294}], LineBox[{998, 298}], 
            LineBox[{1001, 301}], LineBox[{1002, 302}], LineBox[{1003, 303}], 
            LineBox[{1009, 309}], LineBox[{1010, 310}], LineBox[{1011, 311}], 
            LineBox[{1012, 312}], LineBox[{1013, 313}], LineBox[{1014, 314}], 
            LineBox[{1015, 315}], LineBox[{1019, 319}], LineBox[{1021, 321}], 
            LineBox[{1027, 327}], LineBox[{1028, 328}], LineBox[{1029, 329}], 
            LineBox[{1034, 334}], LineBox[{1035, 335}], LineBox[{1040, 340}], 
            LineBox[{1041, 341}], LineBox[{1042, 342}], LineBox[{1044, 344}], 
            LineBox[{1045, 345}], LineBox[{1047, 347}], LineBox[{1048, 348}], 
            LineBox[{1050, 350}], LineBox[{1053, 353}], LineBox[{1054, 354}], 
            LineBox[{1055, 355}], LineBox[{1057, 357}], LineBox[{1059, 359}], 
            LineBox[{1060, 360}], LineBox[{1061, 361}], LineBox[{1063, 363}], 
            LineBox[{1067, 367}], LineBox[{1071, 371}], LineBox[{1072, 372}], 
            LineBox[{1073, 373}], LineBox[{1074, 374}], LineBox[{1077, 377}], 
            LineBox[{1078, 378}], LineBox[{1080, 380}], LineBox[{1081, 381}], 
            LineBox[{1082, 382}], LineBox[{1083, 383}], LineBox[{1084, 384}], 
            LineBox[{1087, 387}], LineBox[{1091, 391}], LineBox[{1093, 393}], 
            LineBox[{1094, 394}], LineBox[{1096, 396}], LineBox[{1097, 397}], 
            LineBox[{1100, 400}], LineBox[{1101, 401}], LineBox[{1103, 403}], 
            LineBox[{1107, 407}], LineBox[{1109, 409}], LineBox[{1110, 410}], 
            LineBox[{1111, 411}], LineBox[{1112, 412}], LineBox[{1113, 413}], 
            LineBox[{1117, 417}], LineBox[{1119, 419}], LineBox[{1120, 420}], 
            LineBox[{1122, 422}], LineBox[{1126, 426}], LineBox[{1129, 429}], 
            LineBox[{1130, 430}], LineBox[{1131, 431}], LineBox[{1133, 433}], 
            LineBox[{1138, 438}], LineBox[{1139, 439}], LineBox[{1140, 440}], 
            LineBox[{1141, 441}], LineBox[{1143, 443}], LineBox[{1147, 447}], 
            LineBox[{1150, 450}], LineBox[{1151, 451}], LineBox[{1152, 452}], 
            LineBox[{1153, 453}], LineBox[{1155, 455}], LineBox[{1156, 456}], 
            LineBox[{1157, 457}], LineBox[{1159, 459}], LineBox[{1163, 463}], 
            LineBox[{1165, 465}], LineBox[{1166, 466}], LineBox[{1173, 473}], 
            LineBox[{1175, 475}], LineBox[{1176, 476}], LineBox[{1177, 477}], 
            LineBox[{1178, 478}], LineBox[{1180, 480}], LineBox[{1183, 483}], 
            LineBox[{1185, 485}], LineBox[{1186, 486}], LineBox[{1187, 487}], 
            LineBox[{1188, 488}], LineBox[{1190, 490}], LineBox[{1191, 491}], 
            LineBox[{1192, 492}], LineBox[{1193, 493}], LineBox[{1195, 495}], 
            LineBox[{1198, 498}], LineBox[{1199, 499}], LineBox[{1200, 500}], 
            LineBox[{1209, 509}], LineBox[{1211, 511}], LineBox[{1212, 512}], 
            LineBox[{1213, 513}], LineBox[{1214, 514}], LineBox[{1216, 516}], 
            LineBox[{1218, 518}], LineBox[{1219, 519}], LineBox[{1225, 525}], 
            LineBox[{1227, 527}], LineBox[{1229, 529}], LineBox[{1230, 530}], 
            LineBox[{1232, 532}], LineBox[{1234, 534}], LineBox[{1237, 537}], 
            LineBox[{1239, 539}], LineBox[{1245, 545}], LineBox[{1246, 546}], 
            LineBox[{1247, 547}], LineBox[{1248, 548}], LineBox[{1249, 549}], 
            LineBox[{1252, 552}], LineBox[{1255, 555}], LineBox[{1256, 556}], 
            LineBox[{1259, 559}], LineBox[{1264, 564}], LineBox[{1265, 565}], 
            LineBox[{1266, 566}], LineBox[{1267, 567}], LineBox[{1268, 568}], 
            LineBox[{1269, 569}], LineBox[{1272, 572}], LineBox[{1274, 574}], 
            LineBox[{1275, 575}], LineBox[{1277, 577}], LineBox[{1279, 579}], 
            LineBox[{1283, 583}], LineBox[{1285, 585}], LineBox[{1289, 589}], 
            LineBox[{1292, 592}], LineBox[{1294, 594}], LineBox[{1295, 595}], 
            LineBox[{1296, 596}], LineBox[{1300, 600}], LineBox[{1301, 601}], 
            LineBox[{1303, 603}], LineBox[{1310, 610}], LineBox[{1311, 611}], 
            LineBox[{1313, 613}], LineBox[{1315, 615}], LineBox[{1318, 618}], 
            LineBox[{1321, 621}], LineBox[{1322, 622}], LineBox[{1324, 624}], 
            LineBox[{1331, 631}], LineBox[{1333, 633}], LineBox[{1334, 634}], 
            LineBox[{1336, 636}], LineBox[{1337, 637}], LineBox[{1341, 641}], 
            LineBox[{1342, 642}], LineBox[{1343, 643}], LineBox[{1344, 644}], 
            LineBox[{1346, 646}], LineBox[{1347, 647}], LineBox[{1348, 648}], 
            LineBox[{1354, 654}], LineBox[{1355, 655}], LineBox[{1362, 662}], 
            LineBox[{1365, 665}], LineBox[{1366, 666}], LineBox[{1367, 667}], 
            LineBox[{1368, 668}], LineBox[{1369, 669}], LineBox[{1372, 672}], 
            LineBox[{1373, 673}], LineBox[{1374, 674}], LineBox[{1375, 675}], 
            LineBox[{1377, 677}], LineBox[{1378, 678}], LineBox[{1380, 680}], 
            LineBox[{1381, 681}], LineBox[{1382, 682}], LineBox[{1383, 683}], 
            LineBox[{1384, 684}], LineBox[{1385, 685}], LineBox[{1386, 686}], 
            LineBox[{1387, 687}], LineBox[{1388, 688}], LineBox[{1390, 690}], 
            LineBox[{1391, 691}], LineBox[{1392, 692}], LineBox[{1393, 693}]}, 
           {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
            LineBox[{701, 1}], LineBox[{702, 2}], LineBox[{707, 7}], 
            LineBox[{708, 8}], LineBox[{709, 9}], LineBox[{710, 10}], 
            LineBox[{713, 13}], LineBox[{716, 16}], LineBox[{718, 18}], 
            LineBox[{721, 21}], LineBox[{723, 23}], LineBox[{725, 25}], 
            LineBox[{726, 26}], LineBox[{729, 29}], LineBox[{730, 30}], 
            LineBox[{736, 36}], LineBox[{737, 37}], LineBox[{738, 38}], 
            LineBox[{739, 39}], LineBox[{744, 44}], LineBox[{745, 45}], 
            LineBox[{746, 46}], LineBox[{748, 48}], LineBox[{752, 52}], 
            LineBox[{754, 54}], LineBox[{756, 56}], LineBox[{759, 59}], 
            LineBox[{760, 60}], LineBox[{762, 62}], LineBox[{764, 64}], 
            LineBox[{766, 66}], LineBox[{769, 69}], LineBox[{770, 70}], 
            LineBox[{772, 72}], LineBox[{773, 73}], LineBox[{776, 76}], 
            LineBox[{778, 78}], LineBox[{780, 80}], LineBox[{781, 81}], 
            LineBox[{782, 82}], LineBox[{784, 84}], LineBox[{785, 85}], 
            LineBox[{786, 86}], LineBox[{790, 90}], LineBox[{792, 92}], 
            LineBox[{794, 94}], LineBox[{796, 96}], LineBox[{799, 99}], 
            LineBox[{802, 102}], LineBox[{803, 103}], LineBox[{804, 104}], 
            LineBox[{806, 106}], LineBox[{808, 108}], LineBox[{810, 110}], 
            LineBox[{814, 114}], LineBox[{815, 115}], LineBox[{816, 116}], 
            LineBox[{818, 118}], LineBox[{819, 119}], LineBox[{821, 121}], 
            LineBox[{822, 122}], LineBox[{825, 125}], LineBox[{828, 128}], 
            LineBox[{829, 129}], LineBox[{831, 131}], LineBox[{832, 132}], 
            LineBox[{836, 136}], LineBox[{838, 138}], LineBox[{839, 139}], 
            LineBox[{840, 140}], LineBox[{842, 142}], LineBox[{844, 144}], 
            LineBox[{846, 146}], LineBox[{848, 148}], LineBox[{850, 150}], 
            LineBox[{853, 153}], LineBox[{854, 154}], LineBox[{856, 156}], 
            LineBox[{858, 158}], LineBox[{864, 164}], LineBox[{865, 165}], 
            LineBox[{866, 166}], LineBox[{872, 172}], LineBox[{874, 174}], 
            LineBox[{876, 176}], LineBox[{878, 178}], LineBox[{880, 180}], 
            LineBox[{882, 182}], LineBox[{883, 183}], LineBox[{884, 184}], 
            LineBox[{885, 185}], LineBox[{886, 186}], LineBox[{890, 190}], 
            LineBox[{891, 191}], LineBox[{892, 192}], LineBox[{894, 194}], 
            LineBox[{898, 198}], LineBox[{899, 199}], LineBox[{903, 203}], 
            LineBox[{905, 205}], LineBox[{906, 206}], LineBox[{908, 208}], 
            LineBox[{910, 210}], LineBox[{914, 214}], LineBox[{918, 218}], 
            LineBox[{922, 222}], LineBox[{924, 224}], LineBox[{925, 225}], 
            LineBox[{926, 226}], LineBox[{928, 228}], LineBox[{933, 233}], 
            LineBox[{934, 234}], LineBox[{936, 236}], LineBox[{937, 237}], 
            LineBox[{939, 239}], LineBox[{942, 242}], LineBox[{943, 243}], 
            LineBox[{944, 244}], LineBox[{946, 246}], LineBox[{950, 250}], 
            LineBox[{951, 251}], LineBox[{952, 252}], LineBox[{953, 253}], 
            LineBox[{954, 254}], LineBox[{960, 260}], LineBox[{962, 262}], 
            LineBox[{963, 263}], LineBox[{964, 264}], LineBox[{970, 270}], 
            LineBox[{972, 272}], LineBox[{974, 274}], LineBox[{976, 276}], 
            LineBox[{978, 278}], LineBox[{979, 279}], LineBox[{980, 280}], 
            LineBox[{982, 282}], LineBox[{984, 284}], LineBox[{986, 286}], 
            LineBox[{990, 290}], LineBox[{995, 295}], LineBox[{996, 296}], 
            LineBox[{997, 297}], LineBox[{999, 299}], LineBox[{1000, 300}], 
            LineBox[{1004, 304}], LineBox[{1005, 305}], LineBox[{1006, 306}], 
            LineBox[{1007, 307}], LineBox[{1008, 308}], LineBox[{1016, 316}], 
            LineBox[{1017, 317}], LineBox[{1018, 318}], LineBox[{1020, 320}], 
            LineBox[{1022, 322}], LineBox[{1023, 323}], LineBox[{1024, 324}], 
            LineBox[{1025, 325}], LineBox[{1026, 326}], LineBox[{1030, 330}], 
            LineBox[{1031, 331}], LineBox[{1032, 332}], LineBox[{1033, 333}], 
            LineBox[{1036, 336}], LineBox[{1037, 337}], LineBox[{1038, 338}], 
            LineBox[{1039, 339}], LineBox[{1043, 343}], LineBox[{1046, 346}], 
            LineBox[{1049, 349}], LineBox[{1051, 351}], LineBox[{1052, 352}], 
            LineBox[{1056, 356}], LineBox[{1058, 358}], LineBox[{1062, 362}], 
            LineBox[{1064, 364}], LineBox[{1065, 365}], LineBox[{1066, 366}], 
            LineBox[{1068, 368}], LineBox[{1069, 369}], LineBox[{1070, 370}], 
            LineBox[{1075, 375}], LineBox[{1076, 376}], LineBox[{1079, 379}], 
            LineBox[{1085, 385}], LineBox[{1086, 386}], LineBox[{1088, 388}], 
            LineBox[{1089, 389}], LineBox[{1090, 390}], LineBox[{1092, 392}], 
            LineBox[{1095, 395}], LineBox[{1098, 398}], LineBox[{1099, 399}], 
            LineBox[{1102, 402}], LineBox[{1104, 404}], LineBox[{1105, 405}], 
            LineBox[{1106, 406}], LineBox[{1108, 408}], LineBox[{1114, 414}], 
            LineBox[{1115, 415}], LineBox[{1116, 416}], LineBox[{1118, 418}], 
            LineBox[{1121, 421}], LineBox[{1123, 423}], LineBox[{1124, 424}], 
            LineBox[{1125, 425}], LineBox[{1127, 427}], LineBox[{1128, 428}], 
            LineBox[{1132, 432}], LineBox[{1134, 434}], LineBox[{1135, 435}], 
            LineBox[{1136, 436}], LineBox[{1137, 437}], LineBox[{1142, 442}], 
            LineBox[{1144, 444}], LineBox[{1145, 445}], LineBox[{1146, 446}], 
            LineBox[{1148, 448}], LineBox[{1149, 449}], LineBox[{1154, 454}], 
            LineBox[{1158, 458}], LineBox[{1160, 460}], LineBox[{1161, 461}], 
            LineBox[{1162, 462}], LineBox[{1164, 464}], LineBox[{1167, 467}], 
            LineBox[{1168, 468}], LineBox[{1169, 469}], LineBox[{1170, 470}], 
            LineBox[{1171, 471}], LineBox[{1172, 472}], LineBox[{1174, 474}], 
            LineBox[{1179, 479}], LineBox[{1181, 481}], LineBox[{1182, 482}], 
            LineBox[{1184, 484}], LineBox[{1189, 489}], LineBox[{1194, 494}], 
            LineBox[{1196, 496}], LineBox[{1197, 497}], LineBox[{1201, 501}], 
            LineBox[{1202, 502}], LineBox[{1203, 503}], LineBox[{1204, 504}], 
            LineBox[{1205, 505}], LineBox[{1206, 506}], LineBox[{1207, 507}], 
            LineBox[{1208, 508}], LineBox[{1210, 510}], LineBox[{1215, 515}], 
            LineBox[{1217, 517}], LineBox[{1220, 520}], LineBox[{1221, 521}], 
            LineBox[{1222, 522}], LineBox[{1223, 523}], LineBox[{1224, 524}], 
            LineBox[{1226, 526}], LineBox[{1228, 528}], LineBox[{1231, 531}], 
            LineBox[{1233, 533}], LineBox[{1235, 535}], LineBox[{1236, 536}], 
            LineBox[{1238, 538}], LineBox[{1240, 540}], LineBox[{1241, 541}], 
            LineBox[{1242, 542}], LineBox[{1243, 543}], LineBox[{1244, 544}], 
            LineBox[{1250, 550}], LineBox[{1251, 551}], LineBox[{1253, 553}], 
            LineBox[{1254, 554}], LineBox[{1257, 557}], LineBox[{1258, 558}], 
            LineBox[{1260, 560}], LineBox[{1261, 561}], LineBox[{1262, 562}], 
            LineBox[{1263, 563}], LineBox[{1270, 570}], LineBox[{1271, 571}], 
            LineBox[{1273, 573}], LineBox[{1276, 576}], LineBox[{1278, 578}], 
            LineBox[{1280, 580}], LineBox[{1281, 581}], LineBox[{1282, 582}], 
            LineBox[{1284, 584}], LineBox[{1286, 586}], LineBox[{1287, 587}], 
            LineBox[{1288, 588}], LineBox[{1290, 590}], LineBox[{1291, 591}], 
            LineBox[{1293, 593}], LineBox[{1297, 597}], LineBox[{1298, 598}], 
            LineBox[{1299, 599}], LineBox[{1302, 602}], LineBox[{1304, 604}], 
            LineBox[{1305, 605}], LineBox[{1306, 606}], LineBox[{1307, 607}], 
            LineBox[{1308, 608}], LineBox[{1309, 609}], LineBox[{1312, 612}], 
            LineBox[{1314, 614}], LineBox[{1316, 616}], LineBox[{1317, 617}], 
            LineBox[{1319, 619}], LineBox[{1320, 620}], LineBox[{1323, 623}], 
            LineBox[{1325, 625}], LineBox[{1326, 626}], LineBox[{1327, 627}], 
            LineBox[{1328, 628}], LineBox[{1329, 629}], LineBox[{1330, 630}], 
            LineBox[{1332, 632}], LineBox[{1335, 635}], LineBox[{1338, 638}], 
            LineBox[{1339, 639}], LineBox[{1340, 640}], LineBox[{1345, 645}], 
            LineBox[{1349, 649}], LineBox[{1350, 650}], LineBox[{1351, 651}], 
            LineBox[{1352, 652}], LineBox[{1353, 653}], LineBox[{1356, 656}], 
            LineBox[{1357, 657}], LineBox[{1358, 658}], LineBox[{1359, 659}], 
            LineBox[{1360, 660}], LineBox[{1361, 661}], LineBox[{1363, 663}], 
            LineBox[{1364, 664}], LineBox[{1370, 670}], LineBox[{1371, 671}], 
            LineBox[{1376, 676}], LineBox[{1379, 679}], LineBox[{1389, 689}], 
            LineBox[{1394, 694}], LineBox[{1395, 695}], LineBox[{1396, 696}], 
            LineBox[{1397, 697}], LineBox[{1398, 698}], LineBox[{1399, 699}], 
            LineBox[{1400, 700}]}}, {{}, 
           {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
            0.0055000000000000005`], AbsoluteThickness[1.6], 
            PointBox[CompressedData["
1:eJwN02PDFgYAAMAnvtm27drysm1subawZdu2bdu2bdu23e7D/YRL2rBV5ZbB
AoHA9uCBQJdQgUBXutGdHvSkF73pQ1/60Z8BDGQQgxnCUIYxnBGMZBSjGcNY
xjGeCUxkEpOZwlSmMZ0ZzGQWs5nDXOYxnwUsZBGLWcJSlrGcFaxkFatZw1rW
sZ4NbGQTm9nCVraxnR3sZBe72cNe9rGfAxzkEIc5wlGOcZwTnOQUpznDWc5x
ngtc5BKXucJVrnGdG9zkFre5w13ucZ8HPOQRj3nCU57xnBe85BWvecNb3vGe
D3zkE5/5wle+8Z0f/OQXgdCBQDCCE4KQhCI0QYQhLOEITwQiEonIRCEq0YhO
DGISi9jEIS7xiE8CEpKIxCQhKclITgpSkorUpCEt6UhPBjKSicxkISvZyE4O
fuN3cpKL3OQhL/nIzx8UoCCFKEwRilKM4pSgJKUoTRnKUo7yVKAilahMFapS
jerUoCa1qM2f/EUd6lKP+jSgIY1oTBP+5h+a0ozmtOBf/qMlrWhNG9rSjvZ0
oCOd6EwXutKN7vSgJ73oTR/60o/+DGAggxjMEIYyjOGMYCSjGM0YxjKO8Uxg
IpOYzBSmMo3pzGAms5jNHOYyj/ksYCGLWMwSlrKM5axgJatYzRrWso71bGAj
m9jMFrayje3sYCe72M0e9rKP/RzgIIc4zBGOcozjnOAkpzjNGc5yjvNc4CKX
uMwVrnKN69zgJre4zR3uco/7POAhj3jME57yjOe84CWveM0b3vKO93zgI5/4
zBe+8o3v/OAnvwgE+U9wQhCSUIQmiDCEJRzhiUBEIhGZKEQlGtGJQUxiEZs4
xCUe8UlAQhKRmCQkJRnJSUFKUpGaNKQlHenJQEYykZksZCUb2cnBb/xOTnKR
mzzkJR/5+YMCFKQQhSlCUYpRnBKUpBSlKUNZylGeClSkEpWpQlWqUZ0a1KQW
tfmTv6hDXepRnwY0pBGNacLf/ENTmtGcFvzLf7SkFa1pQ1va0Z4OdKQTnelC
V7rRnR70pBe96UNf+tGfAQxkEIMZwlCGMZwRjGQUoxnDWMYxnglMZBKTmcJU
pjGdGcxkFrOZw1zmMZ8FLGQRi1nCUpaxnBWsZBWrWcNa1rGeDWxkE5vZwla2
sZ0d7GQXu9nDXvaxnwMc5BCHOcJRjnGcE5zkFKc5w1nOcZ4LXOQSl7nCVa5x
nRvc5Ba3ucNd7nGfBzzkEY95wlOe8ZwXvOQVr3nDW97xng985BOf+cJXvvGd
H/zkF4Ew/hOcEIQkFKEJIgxhCUd4IhCRSEQmClGJRnRiEJNYxCYOcYlHfBKQ
kEQkJglJSUZyUpCSVKQmDWlJR3oykJFMZCYLWclGdnLwP/W2e1I=
             
             "]]}, {}}}], {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{False, False},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{
          FormBox["\"Correla\[CCedilla]\[ATilde]o\"", TraditionalForm], 
          None}, {
          FormBox["\"Semanas\"", TraditionalForm], 
          FormBox[
          "\"\\!\\(\\*SubscriptBox[\\(s\\), \\(3\\)]\\)\"", TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 700.}, {-0.11689288751574474`, 0.12827897452397488`}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.05], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {193.5, -597.9478841155233}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499622}], InsetBox[
      GraphicsBox[{{{}, GraphicsComplexBox[CompressedData["
1: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
FtboVsW8uJZB9c/Cq+KmWV+86PxCnoUx9/yH7us6n+qfhei/tOkZ218M/l7/
b/n3rz98NzmJ6p+F9GVND5cZ6HnELEztNuaoVyJZlYW2voMet+5D74uUhV/d
9vb5TdGX6p+F5c0abelzksaLLgs7bo1ynvmB5mN9FsKOVzi+GELzqyELz3eO
iHoko/2LMQtzFz2/6HSb9gemLOhv+tTZPJ3mD3MW5oesGuefa/n9UkLwmR6X
W2tofFlLGJu7r+61FvS8MgkdZo4yNLCn9reVEDLs14RZS+n9kUv4xeuEd/ZJ
ml/sJdQ7+dcPl4soPigktL92+fVYB5pfnCR83vv78LBc+jwkuO991Sl4PcV/
FwkNL/m77SuzxBMJ+Rn9bZ9E0njzlLC+TXCDz/EU70UJFamD9VZbaL8T8u35
G2aEFben9axKwsqfnNc8mUf7xWQJRy7p55w4Yfk9W8IPMTcHOzrT+iZfgmNF
wjrH89R+Wgl/XJz8eqNnxvf8hRKcD7peSr1D5eskHPvqciQ/j9YfRRL8rLba
YCs9r15CUEzLtCsRlL9Uwurmtab+mUvrD4OEBfmZL4q2Uvwok3B6e71ppXFR
NJ4lPGxQY8/uHb7fP18uYeT6Hv+cuTmR3m8JCc/8UnxP0vxbISGr/rOBB3xo
v2qWEC1cVjZdRfurSgkF0YsCdw+1nP+qse9093sO6yneWKvxsemHzb0tv//L
1CjzD3Fbm0frf1s1dk0J+PvjIXp/5Go0MtQ+3vYj2V6NiJ0L2+Z8pfGhUGPQ
ZV/h/Nz23+2kxqixWWlrull+b1WjlsM/Q9otpvHhosaNtkeKr2TQ701KNS6K
6WO1ByjeeqpxvlPoSKOS5jtRjUua9HqxdnSeGaL+NiN3fyB7SfFXpUYb5e6y
y7E0HySr4Rea/epcn+kUf9Qomj/9sctW6r98Nf45tG986miKX1o17NI6dXt/
i963QjXqPD/a+NMsGm86NY7F97DqISZ8d5EaGc4Ltj7vTe2nV6OmnxjSMDeS
+l8Nl2fN9cNq0PmKQY3N+j1rmn6k/WKZGuO7vwqfmGZZz6oxQLmuc6gT7RfK
1dg4LguKZMv5lho/R9qtGviVyqtQw6ZH5AHHHy3rXTWu9g5y2qWj9UKlGpXj
l/c770vnm4IGE6928JH1pfa01mD7q9Caby9bzgM1mPLl2LG0KQ2p/zWoHZCS
6lvfsj7W4EGLkTfrW+YPew3K571sO+UgnecoNDjj0my200dabzhpcP3zX64L
PtH5EzT4HOo07+tP/tT/GiQN7Xzin93UP0oNdkdOG/jGl+ZHTw3aPnja7kQv
Oo8SNTC/wvN3A+i8JkSDn3e8/HKtVyjNtxqUJI4Z33MdrY+TNRg6J/RnmbXl
/FYDcfzWDYqCPOp/DUbKOttO20z9q9XgWsEK739zaDwXarBMeiGOmWPZn2hQ
32lAu7oqOv8p0mD1EvFwh3XUP3oN7Pac7TdMTfUt1eDS9VX7XZtOov7X4Ny7
sRs3KGi9XaaB7nb4Rf9ntH4yamAjBR2o8S+Nx3INtAdsHlnJ6P0wabBgzIsH
MdNo/q/Q4LUuyqru5BDqfw36jm7ZotcftB6v/NZeb2L3Xc6y/P6SjaU2e1yH
BFK8t87GbWT0tw+h/YgsG0Elvsq8n2l82GZj8b8IK7Kh8x95NrJub9ht9T+K
p/bZaNWo5e9zu1E8UGQjsE+L5t2b0vvhlI0wj/LwknB6fmRDWPw1d0sU7d9d
spE7IW/LLMvvs8psNHNK3LsynuKxZzYaxU25aNM8hvo/Gxd916zYa0Xrj5Bs
1Cg+ZPqnKZ33qLKxxscb+1rQ+EjOxrYdS+btv2Q5P8/GvtyrQfnvKX7mZwOD
7m9Y/6vlPDYbbgsON8sB1bcwG7PVdY+nPKf8umwkRR1q/O4g/T5YlI3+S2vG
jhUpnumzYXPX51wfGf2eVPqtPNw8FLuZ1vuGbJgaHU7/x/L7Z1k2xhefi9Eu
ov42fqtfz7Nt/KZRf5Zno8tPz3EgidrTlI1as5q2+nSVxldFNq4/ss3w30Pr
VXM2ljcS7x7tQPNVZTbq3T1sO6wWPZ+QgzXXvYfNv0p/P2SdA/f5A/U21hSP
ZDlIt9rTqH/+MJr/c/DP8rAVHsfpeeQ56ND+1CnRqjf1fw481hXfab+ezlsU
OSje/Ofq7TVp/DnloLPq7sw6cZa/d8nBIecJESMG0nhxycGoPT+/CrWjv69T
5uDkhkF/hO+jvzfwzMFxw5wBO9Q0v4o5iDOPU2Qep/ETkoNzdkWu6zZa+j8H
tyctu3j2n1B6/3PQ5u2u8QU+tB+QcvDz7eaPegym/Uh+DjKSbBtdu2XZj+Zg
sLTrcfp02q8X5mDx/0KOGE9Z1uc5sL7o/b5OvyDq/xy88/3Sq805Op/R50A9
+T9NydXU7+WV5uD52+ktLmXReabhW/t0LQzcUkn7l7IcbHSt/WjRDFofGHPg
kGdzwb0mrV/Lc9C9VcuIhyH0e78pBzKfH2c17D2B+j8Hq38osX7dkfrTnIOt
qRc8nxym9XXlt5E8bFOvr11pvSHkwj7iWOiQOPr7IOtcBJTIhEGdab0ky4Xz
WO/1PUpoPrDNxZqjtTZGdaP2k+fiyfllKbsX0HrPPhf/7ux+5reO1F6KXBwv
qSec3E7x1SkXe1d387qVS/2NXDg4d6tcNpnijUsupjTvl2HnZjlPzMWCM3Nl
k8LpvNYzFyXNHk8obUrxS8yFyXFmxKr5ND+G5CLC23lS8Vtar6pyMfgXG5vd
NWl8JOfiTc2vJ1Ov0HwjfUuPWZvzsAvFo/xc2MR7vXmxkOYXbS6i7Ua4TfxC
811hLr66FPxWOpzmE10utnT7OvJ8Txo/RbkIHx7dcth9Wk/qcxFV44mDexjl
L81F/dMThFy7WOr/XJxWIGBS0XDq/1wcW6SamvA3pRtzMf/BySG9LPuR8m/P
dzR4WUlPWj+ZchFvb3uq6EIz6k8z/fv//kNVWjPLmH9itmVuxSxnbsfcgbkj
sz1zZ2ZH5q7MCubuzD2YezL3Yu7N3Ie5L7MTcz/m/swDmAcyD2IezOzMjKqW
mIUhLJ1ZGMrSmYVhLJ1ZGM7SmYURLJ1ZGMnSmYVRLJ1ZcGHpzMJols4sjGHp
zMJYls4suLJ0ZsGNpTML41g6szCepTMLyqoGs8RsYBYmsPzMErOBWZjI8jNL
zAZmYRLLzywxG5gFd5afWWI2MAseLD+zxGxgFiaz/MwSs4FZmMLyM0vMBmbB
k+VnlpgNzMJUlp9ZYjYwC9NYfmaJ2cAsTGf5mSVmA7PgxfIzS8wGZsGb5WeW
mA3Mgg/LzywxG5gFX5afWWI2MAtiVcuZwSwyS8w6ZgOziVnwY+Uzg1lklph1
zAZmE7Pgz8pnBrPILDHrmA3MJmYhgJXPDGaRWWLWMRuYTcxCICufGcwis8Ss
YzYwm5iFIFY+M5hFZolZx2xgNjELM1j5zGAWmSVmHbOB2cQsBLPymcEsMkvM
OmYDs4lZCGHlM4NZZJaYdcwGZhOzEMrKZwazyCwx65gNzCZmIYyVzwxmkVli
1jEbmE3MQjgrnxnMIrPErGM2MJuYhQhWPjOYRWaJWcdsYDYxC5GsfGYwi8wS
s47ZwGxiFqJY+cxgFpklZh2zgdnELESz8pnBLDJLzDpmA7OJWVBVtYxZzqxg
BrOSWWRWMUvMWmYds57ZwGxkNjGbmYWYqpYxy5kVzGBWMovMKmaJWcusY9Yz
G5iNzCZmM7MQW9UyZjmzghnMSmaRWcUsMWuZdcx6ZgOzkdnEbGYW4qpaxixn
VjCDWcksMquYJWYts45Zz2xgNjKbmM3MQnxVy5jlzApmMCuZRWYVs8SsZdYx
65kNzEZmE7OZWUioahmznFnBDGYls8isYpaYtcw6Zj2zgdnIbGI2MwuJVS1j
ljMrmMGsZBaZVcwSs5ZZx6xnNjAbmU3MZmYhqaplzHJmBTOYlcwis4pZYtYy
65j1zAZmI7OJ2cwsJFe1jFnOrGAGs5JZZFYxS8xaZh2zntnAbGQ2MZuZhZSq
ljHLmRXMYFYyi8wqZolZy6xj1jMbmI3MJmYzs5Ba1TJmObOCGcxKZpFZxSwx
a5l1zHpmA7OR2cRsZhbSqlrGLGdWMINZySwyq5glZi2zjlnPbGA2MpuYzcxC
elXLmOXMCmYwK5lFZhWzxKxl1jHrmQ3MRmYTs5lZyKhqGbOcWcEMZiWzyKxi
lpi1zDpmPbOB2chsYjYzC5lVLWOWMyuYwaxkFplVzBKzllnHrGc2MBuZTcxm
ZiGrqmXMcmYFM5iVzCKzilli1jLrmPXMBmYjs4nZzCxIVW3NLGO2ZZYz2zMr
mJ2YwezCrGT2ZBaZQ5hVzMnMEnM+s5a5kFnHXMSsZy5lNjCXMRuZy5lNzBXM
ZuZKZkFd1dbMMmZbZjmzPbOC2YkZzC7MSmZPZpE5hFnFnMwsMecza5kLmXXM
Rcx65lJmA3MZs5G5nNnEXMFsZq5kFjRVbc0sY7ZlljPbMyuYnZjB7MKsZPZk
FplDmFXMycwScz6zlrmQWcdcxKxnLmU2MJcxG5nLmU3MFcxm5kpmIbuqrZll
zLbMcmZ7ZgWzEzOYXZiVzJ7MInMIs4o5mVlizmfWMhcy65iLmPXMpcwG5jJm
I3M5s4m5gtnMXMks5FS1NbOM2ZZZzmzPrGB2YgazC7OS2ZNZZA5hVjEnM0vM
+cxa5kJmHXMRs565lNnAXMZsZC5nNjFXMJuZK5mF3Kq2ZpYx2zLLme2ZFcxO
zGB2YVYyezKLzCHMKuZkZok5n1nLXMisYy5i1jOXMhuYy5iNzOXMJubq+3er
79+tvn+3+v7d6vt3qfzq+3er79+tvn+3+v7d6vt3v5dfff9u9f271ffvVt+/
W33/7vfyq+/frb5/t/r+3er7d6vv3/1e/+r7d6vv362+f7f6/t3q+3e/17/6
/t3q+3er79+tvn+3+v7d7/Wvvn+3+v7d6vt3q+/frb5/93v/V9+/W33/bvX9
u9X371bfv/u9/6vv362+f7f6/t3/n/t3/w9yHSuX
          "], {{{}, {}, {}, 
            {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
             LineBox[{703, 3}], LineBox[{704, 4}], LineBox[{705, 5}], 
             LineBox[{706, 6}], LineBox[{711, 11}], LineBox[{712, 12}], 
             LineBox[{714, 14}], LineBox[{715, 15}], LineBox[{717, 17}], 
             LineBox[{720, 20}], LineBox[{722, 22}], LineBox[{723, 23}], 
             LineBox[{724, 24}], LineBox[{727, 27}], LineBox[{728, 28}], 
             LineBox[{731, 31}], LineBox[{732, 32}], LineBox[{733, 33}], 
             LineBox[{734, 34}], LineBox[{735, 35}], LineBox[{738, 38}], 
             LineBox[{742, 42}], LineBox[{743, 43}], LineBox[{747, 47}], 
             LineBox[{749, 49}], LineBox[{750, 50}], LineBox[{751, 51}], 
             LineBox[{753, 53}], LineBox[{755, 55}], LineBox[{757, 57}], 
             LineBox[{758, 58}], LineBox[{761, 61}], LineBox[{763, 63}], 
             LineBox[{765, 65}], LineBox[{766, 66}], LineBox[{767, 67}], 
             LineBox[{771, 71}], LineBox[{774, 74}], LineBox[{775, 75}], 
             LineBox[{777, 77}], LineBox[{779, 79}], LineBox[{782, 82}], 
             LineBox[{783, 83}], LineBox[{787, 87}], LineBox[{788, 88}], 
             LineBox[{789, 89}], LineBox[{791, 91}], LineBox[{793, 93}], 
             LineBox[{795, 95}], LineBox[{797, 97}], LineBox[{798, 98}], 
             LineBox[{800, 100}], LineBox[{801, 101}], LineBox[{805, 105}], 
             LineBox[{807, 107}], LineBox[{809, 109}], LineBox[{811, 111}], 
             LineBox[{812, 112}], LineBox[{815, 115}], LineBox[{817, 117}], 
             LineBox[{820, 120}], LineBox[{824, 124}], LineBox[{826, 126}], 
             LineBox[{827, 127}], LineBox[{829, 129}], LineBox[{830, 130}], 
             LineBox[{831, 131}], LineBox[{833, 133}], LineBox[{834, 134}], 
             LineBox[{835, 135}], LineBox[{836, 136}], LineBox[{837, 137}], 
             LineBox[{838, 138}], LineBox[{841, 141}], LineBox[{842, 142}], 
             LineBox[{848, 148}], LineBox[{849, 149}], LineBox[{851, 151}], 
             LineBox[{852, 152}], LineBox[{855, 155}], LineBox[{857, 157}], 
             LineBox[{858, 158}], LineBox[{859, 159}], LineBox[{860, 160}], 
             LineBox[{861, 161}], LineBox[{862, 162}], LineBox[{865, 165}], 
             LineBox[{866, 166}], LineBox[{867, 167}], LineBox[{868, 168}], 
             LineBox[{869, 169}], LineBox[{870, 170}], LineBox[{871, 171}], 
             LineBox[{873, 173}], LineBox[{874, 174}], LineBox[{875, 175}], 
             LineBox[{877, 177}], LineBox[{879, 179}], LineBox[{881, 181}], 
             LineBox[{887, 187}], LineBox[{888, 188}], LineBox[{891, 191}], 
             LineBox[{892, 192}], LineBox[{893, 193}], LineBox[{895, 195}], 
             LineBox[{898, 198}], LineBox[{900, 200}], LineBox[{901, 201}], 
             LineBox[{902, 202}], LineBox[{904, 204}], LineBox[{910, 210}], 
             LineBox[{912, 212}], LineBox[{913, 213}], LineBox[{915, 215}], 
             LineBox[{916, 216}], LineBox[{917, 217}], LineBox[{918, 218}], 
             LineBox[{919, 219}], LineBox[{920, 220}], LineBox[{921, 221}], 
             LineBox[{924, 224}], LineBox[{927, 227}], LineBox[{928, 228}], 
             LineBox[{931, 231}], LineBox[{932, 232}], LineBox[{934, 234}], 
             LineBox[{935, 235}], LineBox[{936, 236}], LineBox[{938, 238}], 
             LineBox[{940, 240}], LineBox[{942, 242}], LineBox[{944, 244}], 
             LineBox[{945, 245}], LineBox[{946, 246}], LineBox[{948, 248}], 
             LineBox[{949, 249}], LineBox[{950, 250}], LineBox[{952, 252}], 
             LineBox[{955, 255}], LineBox[{956, 256}], LineBox[{958, 258}], 
             LineBox[{960, 260}], LineBox[{962, 262}], LineBox[{964, 264}], 
             LineBox[{965, 265}], LineBox[{966, 266}], LineBox[{967, 267}], 
             LineBox[{968, 268}], LineBox[{972, 272}], LineBox[{973, 273}], 
             LineBox[{975, 275}], LineBox[{976, 276}], LineBox[{979, 279}], 
             LineBox[{982, 282}], LineBox[{983, 283}], LineBox[{986, 286}], 
             LineBox[{988, 288}], LineBox[{989, 289}], LineBox[{990, 290}], 
             LineBox[{991, 291}], LineBox[{992, 292}], LineBox[{993, 293}], 
             LineBox[{994, 294}], LineBox[{995, 295}], LineBox[{997, 297}], 
             LineBox[{998, 298}], LineBox[{1000, 300}], LineBox[{1001, 301}], 
             LineBox[{1002, 302}], LineBox[{1004, 304}], LineBox[{1005, 305}],
              LineBox[{1007, 307}], LineBox[{1008, 308}], 
             LineBox[{1010, 310}], LineBox[{1011, 311}], LineBox[{1012, 312}],
              LineBox[{1013, 313}], LineBox[{1014, 314}], 
             LineBox[{1015, 315}], LineBox[{1020, 320}], LineBox[{1021, 321}],
              LineBox[{1027, 327}], LineBox[{1028, 328}], 
             LineBox[{1029, 329}], LineBox[{1033, 333}], LineBox[{1034, 334}],
              LineBox[{1035, 335}], LineBox[{1038, 338}], 
             LineBox[{1040, 340}], LineBox[{1041, 341}], LineBox[{1044, 344}],
              LineBox[{1046, 346}], LineBox[{1047, 347}], 
             LineBox[{1048, 348}], LineBox[{1049, 349}], LineBox[{1050, 350}],
              LineBox[{1053, 353}], LineBox[{1054, 354}], 
             LineBox[{1059, 359}], LineBox[{1061, 361}], LineBox[{1068, 368}],
              LineBox[{1070, 370}], LineBox[{1071, 371}], 
             LineBox[{1072, 372}], LineBox[{1073, 373}], LineBox[{1074, 374}],
              LineBox[{1075, 375}], LineBox[{1078, 378}], 
             LineBox[{1080, 380}], LineBox[{1081, 381}], LineBox[{1082, 382}],
              LineBox[{1083, 383}], LineBox[{1084, 384}], 
             LineBox[{1085, 385}], LineBox[{1086, 386}], LineBox[{1087, 387}],
              LineBox[{1088, 388}], LineBox[{1090, 390}], 
             LineBox[{1091, 391}], LineBox[{1096, 396}], LineBox[{1097, 397}],
              LineBox[{1099, 399}], LineBox[{1101, 401}], 
             LineBox[{1102, 402}], LineBox[{1103, 403}], LineBox[{1106, 406}],
              LineBox[{1111, 411}], LineBox[{1113, 413}], 
             LineBox[{1115, 415}], LineBox[{1117, 417}], LineBox[{1118, 418}],
              LineBox[{1119, 419}], LineBox[{1120, 420}], 
             LineBox[{1121, 421}], LineBox[{1128, 428}], LineBox[{1130, 430}],
              LineBox[{1131, 431}], LineBox[{1133, 433}], 
             LineBox[{1134, 434}], LineBox[{1135, 435}], LineBox[{1138, 438}],
              LineBox[{1140, 440}], LineBox[{1142, 442}], 
             LineBox[{1143, 443}], LineBox[{1144, 444}], LineBox[{1145, 445}],
              LineBox[{1146, 446}], LineBox[{1147, 447}], 
             LineBox[{1150, 450}], LineBox[{1151, 451}], LineBox[{1152, 452}],
              LineBox[{1153, 453}], LineBox[{1157, 457}], 
             LineBox[{1159, 459}], LineBox[{1160, 460}], LineBox[{1161, 461}],
              LineBox[{1162, 462}], LineBox[{1163, 463}], 
             LineBox[{1165, 465}], LineBox[{1170, 470}], LineBox[{1175, 475}],
              LineBox[{1178, 478}], LineBox[{1179, 479}], 
             LineBox[{1180, 480}], LineBox[{1181, 481}], LineBox[{1183, 483}],
              LineBox[{1185, 485}], LineBox[{1189, 489}], 
             LineBox[{1191, 491}], LineBox[{1193, 493}], LineBox[{1194, 494}],
              LineBox[{1195, 495}], LineBox[{1196, 496}], 
             LineBox[{1203, 503}], LineBox[{1205, 505}], LineBox[{1206, 506}],
              LineBox[{1208, 508}], LineBox[{1209, 509}], 
             LineBox[{1211, 511}], LineBox[{1215, 515}], LineBox[{1217, 517}],
              LineBox[{1221, 521}], LineBox[{1222, 522}], 
             LineBox[{1223, 523}], LineBox[{1227, 527}], LineBox[{1228, 528}],
              LineBox[{1229, 529}], LineBox[{1231, 531}], 
             LineBox[{1232, 532}], LineBox[{1233, 533}], LineBox[{1235, 535}],
              LineBox[{1238, 538}], LineBox[{1240, 540}], 
             LineBox[{1242, 542}], LineBox[{1243, 543}], LineBox[{1245, 545}],
              LineBox[{1246, 546}], LineBox[{1247, 547}], 
             LineBox[{1248, 548}], LineBox[{1249, 549}], LineBox[{1250, 550}],
              LineBox[{1253, 553}], LineBox[{1255, 555}], 
             LineBox[{1258, 558}], LineBox[{1260, 560}], LineBox[{1261, 561}],
              LineBox[{1265, 565}], LineBox[{1267, 567}], 
             LineBox[{1268, 568}], LineBox[{1269, 569}], LineBox[{1270, 570}],
              LineBox[{1272, 572}], LineBox[{1274, 574}], 
             LineBox[{1276, 576}], LineBox[{1277, 577}], LineBox[{1278, 578}],
              LineBox[{1279, 579}], LineBox[{1280, 580}], 
             LineBox[{1282, 582}], LineBox[{1287, 587}], LineBox[{1288, 588}],
              LineBox[{1289, 589}], LineBox[{1292, 592}], 
             LineBox[{1294, 594}], LineBox[{1296, 596}], LineBox[{1299, 599}],
              LineBox[{1300, 600}], LineBox[{1301, 601}], 
             LineBox[{1302, 602}], LineBox[{1303, 603}], LineBox[{1306, 606}],
              LineBox[{1310, 610}], LineBox[{1312, 612}], 
             LineBox[{1313, 613}], LineBox[{1315, 615}], LineBox[{1318, 618}],
              LineBox[{1319, 619}], LineBox[{1321, 621}], 
             LineBox[{1322, 622}], LineBox[{1324, 624}], LineBox[{1331, 631}],
              LineBox[{1332, 632}], LineBox[{1333, 633}], 
             LineBox[{1338, 638}], LineBox[{1341, 641}], LineBox[{1344, 644}],
              LineBox[{1346, 646}], LineBox[{1347, 647}], 
             LineBox[{1348, 648}], LineBox[{1350, 650}], LineBox[{1351, 651}],
              LineBox[{1353, 653}], LineBox[{1355, 655}], 
             LineBox[{1362, 662}], LineBox[{1364, 664}], LineBox[{1365, 665}],
              LineBox[{1366, 666}], LineBox[{1374, 674}], 
             LineBox[{1375, 675}], LineBox[{1376, 676}], LineBox[{1378, 678}],
              LineBox[{1379, 679}], LineBox[{1382, 682}], 
             LineBox[{1384, 684}], LineBox[{1388, 688}], LineBox[{1389, 689}],
              LineBox[{1390, 690}], LineBox[{1393, 693}], 
             LineBox[{1394, 694}], LineBox[{1396, 696}]}, 
            {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
             LineBox[{701, 1}], LineBox[{702, 2}], LineBox[{707, 7}], 
             LineBox[{708, 8}], LineBox[{709, 9}], LineBox[{710, 10}], 
             LineBox[{713, 13}], LineBox[{716, 16}], LineBox[{718, 18}], 
             LineBox[{719, 19}], LineBox[{721, 21}], LineBox[{725, 25}], 
             LineBox[{726, 26}], LineBox[{729, 29}], LineBox[{730, 30}], 
             LineBox[{736, 36}], LineBox[{737, 37}], LineBox[{739, 39}], 
             LineBox[{740, 40}], LineBox[{741, 41}], LineBox[{744, 44}], 
             LineBox[{745, 45}], LineBox[{746, 46}], LineBox[{748, 48}], 
             LineBox[{752, 52}], LineBox[{754, 54}], LineBox[{756, 56}], 
             LineBox[{759, 59}], LineBox[{760, 60}], LineBox[{762, 62}], 
             LineBox[{764, 64}], LineBox[{768, 68}], LineBox[{769, 69}], 
             LineBox[{770, 70}], LineBox[{772, 72}], LineBox[{773, 73}], 
             LineBox[{776, 76}], LineBox[{778, 78}], LineBox[{780, 80}], 
             LineBox[{781, 81}], LineBox[{784, 84}], LineBox[{785, 85}], 
             LineBox[{786, 86}], LineBox[{790, 90}], LineBox[{792, 92}], 
             LineBox[{794, 94}], LineBox[{796, 96}], LineBox[{799, 99}], 
             LineBox[{802, 102}], LineBox[{803, 103}], LineBox[{804, 104}], 
             LineBox[{806, 106}], LineBox[{808, 108}], LineBox[{810, 110}], 
             LineBox[{813, 113}], LineBox[{814, 114}], LineBox[{816, 116}], 
             LineBox[{818, 118}], LineBox[{819, 119}], LineBox[{821, 121}], 
             LineBox[{822, 122}], LineBox[{823, 123}], LineBox[{825, 125}], 
             LineBox[{828, 128}], LineBox[{832, 132}], LineBox[{839, 139}], 
             LineBox[{840, 140}], LineBox[{843, 143}], LineBox[{844, 144}], 
             LineBox[{845, 145}], LineBox[{846, 146}], LineBox[{847, 147}], 
             LineBox[{850, 150}], LineBox[{853, 153}], LineBox[{854, 154}], 
             LineBox[{856, 156}], LineBox[{863, 163}], LineBox[{864, 164}], 
             LineBox[{872, 172}], LineBox[{876, 176}], LineBox[{878, 178}], 
             LineBox[{880, 180}], LineBox[{882, 182}], LineBox[{883, 183}], 
             LineBox[{884, 184}], LineBox[{885, 185}], LineBox[{886, 186}], 
             LineBox[{889, 189}], LineBox[{890, 190}], LineBox[{894, 194}], 
             LineBox[{896, 196}], LineBox[{897, 197}], LineBox[{899, 199}], 
             LineBox[{903, 203}], LineBox[{905, 205}], LineBox[{906, 206}], 
             LineBox[{907, 207}], LineBox[{908, 208}], LineBox[{909, 209}], 
             LineBox[{911, 211}], LineBox[{914, 214}], LineBox[{922, 222}], 
             LineBox[{923, 223}], LineBox[{925, 225}], LineBox[{926, 226}], 
             LineBox[{929, 229}], LineBox[{930, 230}], LineBox[{933, 233}], 
             LineBox[{937, 237}], LineBox[{939, 239}], LineBox[{941, 241}], 
             LineBox[{943, 243}], LineBox[{947, 247}], LineBox[{951, 251}], 
             LineBox[{953, 253}], LineBox[{954, 254}], LineBox[{957, 257}], 
             LineBox[{959, 259}], LineBox[{961, 261}], LineBox[{963, 263}], 
             LineBox[{969, 269}], LineBox[{970, 270}], LineBox[{971, 271}], 
             LineBox[{974, 274}], LineBox[{977, 277}], LineBox[{978, 278}], 
             LineBox[{980, 280}], LineBox[{981, 281}], LineBox[{984, 284}], 
             LineBox[{985, 285}], LineBox[{987, 287}], LineBox[{996, 296}], 
             LineBox[{999, 299}], LineBox[{1003, 303}], LineBox[{1006, 306}], 
             LineBox[{1009, 309}], LineBox[{1016, 316}], LineBox[{1017, 317}],
              LineBox[{1018, 318}], LineBox[{1019, 319}], 
             LineBox[{1022, 322}], LineBox[{1023, 323}], LineBox[{1024, 324}],
              LineBox[{1025, 325}], LineBox[{1026, 326}], 
             LineBox[{1030, 330}], LineBox[{1031, 331}], LineBox[{1032, 332}],
              LineBox[{1036, 336}], LineBox[{1037, 337}], 
             LineBox[{1039, 339}], LineBox[{1042, 342}], LineBox[{1043, 343}],
              LineBox[{1045, 345}], LineBox[{1051, 351}], 
             LineBox[{1052, 352}], LineBox[{1055, 355}], LineBox[{1056, 356}],
              LineBox[{1057, 357}], LineBox[{1058, 358}], 
             LineBox[{1060, 360}], LineBox[{1062, 362}], LineBox[{1063, 363}],
              LineBox[{1064, 364}], LineBox[{1065, 365}], 
             LineBox[{1066, 366}], LineBox[{1067, 367}], LineBox[{1069, 369}],
              LineBox[{1076, 376}], LineBox[{1077, 377}], 
             LineBox[{1079, 379}], LineBox[{1089, 389}], LineBox[{1092, 392}],
              LineBox[{1093, 393}], LineBox[{1094, 394}], 
             LineBox[{1095, 395}], LineBox[{1098, 398}], LineBox[{1100, 400}],
              LineBox[{1104, 404}], LineBox[{1105, 405}], 
             LineBox[{1107, 407}], LineBox[{1108, 408}], LineBox[{1109, 409}],
              LineBox[{1110, 410}], LineBox[{1112, 412}], 
             LineBox[{1114, 414}], LineBox[{1116, 416}], LineBox[{1122, 422}],
              LineBox[{1123, 423}], LineBox[{1124, 424}], 
             LineBox[{1125, 425}], LineBox[{1126, 426}], LineBox[{1127, 427}],
              LineBox[{1129, 429}], LineBox[{1132, 432}], 
             LineBox[{1136, 436}], LineBox[{1137, 437}], LineBox[{1139, 439}],
              LineBox[{1141, 441}], LineBox[{1148, 448}], 
             LineBox[{1149, 449}], LineBox[{1154, 454}], LineBox[{1155, 455}],
              LineBox[{1156, 456}], LineBox[{1158, 458}], 
             LineBox[{1164, 464}], LineBox[{1166, 466}], LineBox[{1167, 467}],
              LineBox[{1168, 468}], LineBox[{1169, 469}], 
             LineBox[{1171, 471}], LineBox[{1172, 472}], LineBox[{1173, 473}],
              LineBox[{1174, 474}], LineBox[{1176, 476}], 
             LineBox[{1177, 477}], LineBox[{1182, 482}], LineBox[{1184, 484}],
              LineBox[{1186, 486}], LineBox[{1187, 487}], 
             LineBox[{1188, 488}], LineBox[{1190, 490}], LineBox[{1192, 492}],
              LineBox[{1197, 497}], LineBox[{1198, 498}], 
             LineBox[{1199, 499}], LineBox[{1200, 500}], LineBox[{1201, 501}],
              LineBox[{1202, 502}], LineBox[{1204, 504}], 
             LineBox[{1207, 507}], LineBox[{1210, 510}], LineBox[{1212, 512}],
              LineBox[{1213, 513}], LineBox[{1214, 514}], 
             LineBox[{1216, 516}], LineBox[{1218, 518}], LineBox[{1219, 519}],
              LineBox[{1220, 520}], LineBox[{1224, 524}], 
             LineBox[{1225, 525}], LineBox[{1226, 526}], LineBox[{1230, 530}],
              LineBox[{1234, 534}], LineBox[{1236, 536}], 
             LineBox[{1237, 537}], LineBox[{1239, 539}], LineBox[{1241, 541}],
              LineBox[{1244, 544}], LineBox[{1251, 551}], 
             LineBox[{1252, 552}], LineBox[{1254, 554}], LineBox[{1256, 556}],
              LineBox[{1257, 557}], LineBox[{1259, 559}], 
             LineBox[{1262, 562}], LineBox[{1263, 563}], LineBox[{1264, 564}],
              LineBox[{1266, 566}], LineBox[{1271, 571}], 
             LineBox[{1273, 573}], LineBox[{1275, 575}], LineBox[{1281, 581}],
              LineBox[{1283, 583}], LineBox[{1284, 584}], 
             LineBox[{1285, 585}], LineBox[{1286, 586}], LineBox[{1290, 590}],
              LineBox[{1291, 591}], LineBox[{1293, 593}], 
             LineBox[{1295, 595}], LineBox[{1297, 597}], LineBox[{1298, 598}],
              LineBox[{1304, 604}], LineBox[{1305, 605}], 
             LineBox[{1307, 607}], LineBox[{1308, 608}], LineBox[{1309, 609}],
              LineBox[{1311, 611}], LineBox[{1314, 614}], 
             LineBox[{1316, 616}], LineBox[{1317, 617}], LineBox[{1320, 620}],
              LineBox[{1323, 623}], LineBox[{1325, 625}], 
             LineBox[{1326, 626}], LineBox[{1327, 627}], LineBox[{1328, 628}],
              LineBox[{1329, 629}], LineBox[{1330, 630}], 
             LineBox[{1334, 634}], LineBox[{1335, 635}], LineBox[{1336, 636}],
              LineBox[{1337, 637}], LineBox[{1339, 639}], 
             LineBox[{1340, 640}], LineBox[{1342, 642}], LineBox[{1343, 643}],
              LineBox[{1345, 645}], LineBox[{1349, 649}], 
             LineBox[{1352, 652}], LineBox[{1354, 654}], LineBox[{1356, 656}],
              LineBox[{1357, 657}], LineBox[{1358, 658}], 
             LineBox[{1359, 659}], LineBox[{1360, 660}], LineBox[{1361, 661}],
              LineBox[{1363, 663}], LineBox[{1367, 667}], 
             LineBox[{1368, 668}], LineBox[{1369, 669}], LineBox[{1370, 670}],
              LineBox[{1371, 671}], LineBox[{1372, 672}], 
             LineBox[{1373, 673}], LineBox[{1377, 677}], LineBox[{1380, 680}],
              LineBox[{1381, 681}], LineBox[{1383, 683}], 
             LineBox[{1385, 685}], LineBox[{1386, 686}], LineBox[{1387, 687}],
              LineBox[{1391, 691}], LineBox[{1392, 692}], 
             LineBox[{1395, 695}], LineBox[{1397, 697}], LineBox[{1398, 698}],
              LineBox[{1399, 699}], LineBox[{1400, 700}]}}, {{}, 
            {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
             0.0055000000000000005`], AbsoluteThickness[1.6], 
             PointBox[CompressedData["
1:eJwN02PDFgYAAMAnvtm27drysm1subawZdu2bdu2bdu23e7D/YRL2rBV5ZbB
AoHA9uCBQJdQgUBXutGdHvSkF73pQ1/60Z8BDGQQgxnCUIYxnBGMZBSjGcNY
xjGeCUxkEpOZwlSmMZ0ZzGQWs5nDXOYxnwUsZBGLWcJSlrGcFaxkFatZw1rW
sZ4NbGQTm9nCVraxnR3sZBe72cNe9rGfAxzkEIc5wlGOcZwTnOQUpznDWc5x
ngtc5BKXucJVrnGdG9zkFre5w13ucZ8HPOQRj3nCU57xnBe85BWvecNb3vGe
D3zkE5/5wle+8Z0f/OQXgdCBQDCCE4KQhCI0QYQhLOEITwQiEonIRCEq0YhO
DGISi9jEIS7xiE8CEpKIxCQhKclITgpSkorUpCEt6UhPBjKSicxkISvZyE4O
fuN3cpKL3OQhL/nIzx8UoCCFKEwRilKM4pSgJKUoTRnKUo7yVKAilahMFapS
jerUoCa1qM2f/EUd6lKP+jSgIY1oTBP+5h+a0ozmtOBf/qMlrWhNG9rSjvZ0
oCOd6EwXutKN7vSgJ73oTR/60o/+DGAggxjMEIYyjOGMYCSjGM0YxjKO8Uxg
IpOYzBSmMo3pzGAms5jNHOYyj/ksYCGLWMwSlrKM5axgJatYzRrWso71bGAj
m9jMFrayje3sYCe72M0e9rKP/RzgIIc4zBGOcozjnOAkpzjNGc5yjvNc4CKX
uMwVrnKN69zgJre4zR3uco/7POAhj3jME57yjOe84CWveM0b3vKO93zgI5/4
zBe+8o3v/OAnvwgE+U9wQhCSUIQmiDCEJRzhiUBEIhGZKEQlGtGJQUxiEZs4
xCUe8UlAQhKRmCQkJRnJSUFKUpGaNKQlHenJQEYykZksZCUb2cnBb/xOTnKR
mzzkJR/5+YMCFKQQhSlCUYpRnBKUpBSlKUNZylGeClSkEpWpQlWqUZ0a1KQW
tfmTv6hDXepRnwY0pBGNacLf/ENTmtGcFvzLf7SkFa1pQ1va0Z4OdKQTnelC
V7rRnR70pBe96UNf+tGfAQxkEIMZwlCGMZwRjGQUoxnDWMYxnglMZBKTmcJU
pjGdGcxkFrOZw1zmMZ8FLGQRi1nCUpaxnBWsZBWrWcNa1rGeDWxkE5vZwla2
sZ0d7GQXu9nDXvaxnwMc5BCHOcJRjnGcE5zkFKc5w1nOcZ4LXOQSl7nCVa5x
nRvc5Ba3ucNd7nGfBzzkEY95wlOe8ZwXvOQVr3nDW97xng985BOf+cJXvvGd
H/zkF4Ew/hOcEIQkFKEJIgxhCUd4IhCRSEQmClGJRnRiEJNYxCYOcYlHfBKQ
kEQkJglJSUZyUpCSVKQmDWlJR3oykJFMZCYLWclGdnLwP/W2e1I=
              
              "]]}, {}}}], {}, {}, {}, {}}, {{{}, {}, 
          TagBox[
           {RGBColor[1, 0.5, 0], AbsoluteThickness[1.6], Opacity[1.], 
            LineBox[CompressedData["
1:eJxTTMoPSmViYGAwAWIQvW5dSn0Xwzu7A2l301vDNttLuT/W+NEi7QDjq8y/
5fGtRRvOv5xRxuGw1gbOv/FXOKrK1xXOl/DK2hWt6APnTw/ysNx4JBDO75zn
2l5gGQrnP/uo1ej0IwLOX83mzzBjaQyc/2bOuh1XOBPgfPNdmsefPU2E87c9
m3kubFEynP+yeOUMjrBUOP8iy9odh/XS4fy3S5ZevPM8A87f5zHJ4f/RLDjf
2VeuKHl2Dpz/J2H+HNXAPDjf1Kar74doAZzf5m/v3fsZwd+U8m7TsseFcL6F
1tvfCeeL4PyI8jRHr9XFcH7QsZuGO2aWIMJjznG50IpSOP+KMuvbSUFlcP7c
NTZpofblcD7D3ne33WQq4Hzb87P+7OGuROifOO3f5W8IPusdnr+Sl6rgfEGN
2mVP9lfD+dt/p/vcm1uD4NcvulxRXgvnT2S9zjojuQ5hnnCbyTP7ejhfa6J4
e4x4A5w/P0az6G4bgu/I8Pis3hcE/8ISyfpDWY1wvk5v77rcmwh+aVmdcXRg
EyI9mItrSh5H8PVt3855Z9IM5yc4O6SxrUHw43ovrDWVbkGkv/UcaaYdCP7C
S3uLy/8h+G2WG/5fyGmF84u5JWoyViH4CXfrf/x/juADAGE4oEo=
             "]]},
           Annotation[#, "Charting`Private`Tag$1105462#1"]& ], 
          TagBox[
           {RGBColor[1, 0.5, 0], AbsoluteThickness[1.6], Opacity[1.], 
            LineBox[CompressedData["
1:eJxTTMoPSmViYGAwAWIQvW5dSn0Xwzu7A2l301vDNu+Xcn+s8aNF2gHGV5l/
y+NbizacfzmjjMNhrQ2cf+OvcFSVryucL+GVtSta0QfOnx7kYbnxSCCc3znP
tb3AMhTOf/ZRq9HpRwScv5rNn2HG0hg4/82cdTuucCbA+ea7NI8/e5oI5297
NvNc2KJkOP9l8coZHGGpcP5FlrU7Duulw/lvlyy9eOd5Bpy/z2OSw/+jWXC+
s69cUfLsHDj/T8L8OaqBeXC+qU1X3w/RAji/zd/eu/czgr8p5d2mZY8L4XwL
rbe/E84XwfkR5WmOXquL4fygYzcNd8wsQYTHnONyoRWlcP4VZda3k4LK4Py5
a2zSQu3L4XyGve9uu8lUwPm252f92cNdidA/cdq/y98QfNY7PH8lL1XB+YIa
tcue7K+G87f/Tve5N7cGwa9fdLmivBbOn8h6nXVGch3CPOE2k2f29XC+1kTx
9hjxBjh/foxm0d02BN+R4fFZvS8I/oUlkvWHshrhfJ3e3nW5NxH80rI64+jA
JkR6MBfXlDyO4Ovbvp3zzqQZzk9wdkhjW4Pgx/VeWGsq3YJIf+s50kw7EPyF
l/YWl/9D8NssN/y/kNMK5xdzS9RkrELwE+7W//j/HMEHAO2fuko=
             "]]},
           Annotation[#, "Charting`Private`Tag$1105462#2"]& ]}, {}, {}}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{False, False},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{
          FormBox[
          "\"Correla\[CCedilla]\[ATilde]o Parcial\"", TraditionalForm], 
          None}, {
          FormBox["\"Semanas\"", TraditionalForm], 
          FormBox[
          "\"\\!\\(\\*SubscriptBox[\\(s\\), \\(3\\)]\\)\"", TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 60}, {-0.1116050352750857, 0.11871954499323317`}},
       PlotRangeClipping->True,
       PlotRangePadding->{{0, 0}, {
          Scaled[0.05], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {580.5, -597.9478841155233}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499622}], InsetBox[
      GraphicsBox[{{}, GraphicsComplexBox[CompressedData["
1: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
5uOo/sl4kqluNsSO1gNDMszzdl0/+ie9LxqT8fftzNyuITR/pGQ8872zJusF
xRdTMs6NvPLItSa9D5uTMfuyR4c+LhTvLMlwbNMhdkQT6/lFCn6p/zi52RWK
r7IU/D789qJlBqqfPAWN4xq08PpG41ORgqx5u08Fx1nPC1LgXZDsGLx3CI3/
FJxZtj5sWSs6n1ClIGydU6OXNk7U/yko7PT73vabKZ6IKXBYrz97oXpXqn8K
PIO6X8hYQuulIQUTpjV+GVFI+z9jCtbGDFjVYDTNVykFu0/0X3renepjSkHv
Xzr28htF53/mFEQ7enWr9Y3WF0sKQnPa5/59lL5PSEVJqcP8el2of2WpuH60
54eGHWh+yFPxzk63f8J9iq+KVExb7Hd39wDreU8qckKTllZX0f5EmYrq5+30
pd36U/1TcePHb/9kOlB91eXff3OoZ/B9et8RU7Gj7dgPj7tQvNOnovjCb1um
+ND7hSEV6i7NjldzoPY2pgJ2vV0m+VrPI1Ix2XI0PsCP3v9NqWjS2sn51PWO
VP9UOKQ9Lh14gvJbUpH1y729rgtovAlpGLV18l8ee6k9ZGlY3ODY3hsvmtD8
TwP+3Nb9zKnW1P9psBt7JFqlpPNDpEG/uPeVfndofVSm4ZZTrWu6kbR+qtJw
6qmd6fBcWq/Uabi/MLD1ueF9qP/TYN/tpO6oDY1ffRqSe9k97rOnC9U/DWl1
rvdPuk77EWMaAvo6Pd1bRu0ppeH30dvrtV3Xmfo/DZ33NT+QO4/isTkN/ld8
8kqa0HpkScOP9b7Uui2j8Sqk427/DhFn1PS+KktHc/HsPwlfaT8jT8fT+z/M
8epA67UiHZ2qH1rl+JbOr5AOodm1tKN9aP4o0zF+1YPBl67SfkyVjk877z04
cJjOw9TpaLyw85ngetbz1HRUezfZNuhHiuf6dMx8598xqDq9vxnSsa7XUp/F
02i8GNPxp/2DWuos6m8pHY2i35z8Mp/iqykda93q7vGNd6H6p6Pno6IvMwpp
fFrScdghLFj/ZACN/wyM7dhg9K+bG1H9M7Bkyqzvf1e9rzhPl2fgSqJpekkR
/V6hyMDiy7YnX/gNoPpnQCq8eCLyN+v6nwHL7oypd5/Q+qHKgKub5pcdMXQ+
pM7AvY1n7vU5Svt9MQNHrzZYdbYe7Vf1Gah1+pjF+RDNZ0MG3HscGqW6S+UZ
MxAszPZJ6UjxQspAs+Ne0Yo/qL9NGViZcaRtrq0X1T8DSW3+qb4hlsa3JQNT
HF5PTDjxsSK+CZm49qntwAmjaP2SZcLpXN/onf9Y93+ZWBR7wln4nvpHUe7z
T8u6J9D7BzJx4vcRHr1b0fhWZsLTVrgw4nJLqn+5w/5YtepmNRr/mQjO+r3b
sNu03oiZWOCjerOpK8VzfSY+fkvrP/ky7ScNmZjt+ir9WTDVz1j+vLc7eo9d
ROlSJlp+uLb4+QuKd6ZM9Prp6WdHfxrv5kxsTbjebY43zXdLJootX9eNvGA9
/8qC7/Wzo26Ppfkky8KjwjfnpP40fuRZGHV+z8roX+i8SZGFxqGTbp+xofGD
LDz+t2Zu0XDKr8xCXWO/06WXW1H9s5CqeTZEW0LxSp0F/6U/e76LpPghZqG9
oeHui0XUfvosrM4bnnzMnZ7XkIXry049bfmG2stYXl587b2XXWj8SFnQpT/K
lyfS/tWUhXl7x3xunkW/V5mz8NlU4vbDbNqvWLIw+tXsM0Hzrb+XzcDb7yeO
2x5K7SmbgaimW+vvdKX2lJc7LDXD8w3NV8UMxKb+tPf8Kuv7+QycnzVs1Q4P
Wq+VMxDh+fSdW2vr/ncG5G00o5qm0/qpnoHb7jvDFtVvRvWfgU+NJ9+/0Y/i
vX4G/vBpP6PadBrfhhnYOXLQxuQVNP6MM/BifRvLucMOVP8ZmN9D9XphMzqv
N83AuGTPwX9L1v3PDLTb83a+41fKb5mBFJvgOk3W0HmDkA1dYh//9qK1/tko
unDxQOgtiifybNxFv/buxbTfUmQjoyTHvOJ3Wl+QjdzD6xIvZdJ5qTIb4r+x
Uxpm0Xm9KhtBiwIS4lOoP9TZOBA+IPv2O4qPYjam76ovlCyl59dnQ+j56OB9
Ja23hmxYvPc5n69J8cSYjTrps2etUNN6IGUjzv7so44xdD5nysa7i21a1faj
9cicDXnWnl8ajqT9vCUbLUZWz7exnmcLOWivHB7l/4DOM2U5MN11nTwrytr/
OQj4Iuy9M5GeX5GDJcvd1v9XQOMHOdids8JcY641/uWgadM/Fv20j/pPlYNm
GbYHCm7S7xnqHFgMl6YeH9qX+j8HR2tETdjVgN7H9Dm4OOqk+MVC32fIwQRB
2zlhCJ23GHNg/rTBZtQ86/pfnj9JPuzgeTeqfw7E1988Dhyj+W3OwbfuM4f6
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
WYhh5TODWcUsMhuYJWYzsxDLymcGs4pZZDYwS8xmZiGOlc8MZhWzyGxglpjN
zEI8K58ZzCpmkdnALDGbmQV1ZcuY5cwKZjArmVXMamaRWc9sYDYyS8wmZjOz
hVlIqGwZs5xZwQxmJbOKWc0sMuuZDcxGZonZxGxmtjALiZUtY5YzK5jBrGRW
MauZRWY9s4HZyCwxm5jNzBZmIamyZcxyZgUzmJXMKmY1s8isZzYwG5klZhOz
mdnCLCRXtoxZzqxgBrOSWcWsZhaZ9cwGZiOzxGxiNjNbmIWUypYxy5kVzGBW
MquY1cwis57ZwGxklphNzGZmC7OQWtkyZjmzghnMSmYVs5pZZNYzG5iNzBKz
idnMbGEW0ipbxixnVjCDWcmsYlYzi8x6ZgOzkVliNjGbmS3MQnply5jlzApm
MCuZVcxqZpFZz2xgNjJLzCZmM7OFWciobBmznFnBDGYls4pZzSwy65kNzEZm
idnEbGa2MAuZlS1jljMrmMGsZFYxq5lFZj2zgdnILDGbmM3MFmYhq7JlzHJm
BTOYlcwqZjWzyKxnNjAbmSVmE7OZ2cIszKhsGbOcWcEMZiWzilnNLDLrmQ3M
RmaJ2cRsZrYwC9mVLWOWMyuYwaxkVjGrmUVmPbOB2cgsMZuYzcwWZiGnsmXM
cmYFM5iVzCpmNbPIrGc2MBuZJWYTs5nZwizkVraMWc6sYAazklnFrGYWmfXM
BmYjs8RsYjYzW5gFsbJtmGXM9sxyZmdmBbM7M5i9mZXMgcwq5khmNXM6s8hc
wKxnLmQ2MG9mNjLvZ5aYzzCbmIuZzcylzBbmMmYhr7JtmGXM9sxyZmdmBbM7
M5i9mZXMgcwq5khmNXM6s8hcwKxnLmQ2MG9mNjLvZ5aYzzCbmIuZzcylzBbm
MmZBU9k2zDJme2Y5szOzgtmdGczezErmQGYVcySzmjmdWWQuYNYzFzIbmDcz
G5n3M0vMZ5hNzMXMZuZSZgtzGbOgrWwbZhmzPbOc2ZlZwezODGZvZiVzILOK
OZJZzZzOLDIXMOuZC5kNzJuZjcz7mSXmM8wm5mJmM3Mps4W5jFnQVbYNs4zZ
nlnO7MysYHZnBrM3s5I5kFnFHMmsZk5nFpkLmPXMhcwG5s3MRub9zBLzGWYT
czGzmbmU2cJcxizkV7YNs4zZnlnO7MysYHZnBrM3s5I5kFnFHMmsZk5nFpkL
mPXMhcwG5s3MRub9zBLzGWYTczGzmbnq/t2q+3er7t+tun+36v5dKr/q/t2q
+3er7t+tun+36v7divKr7t+tun+36v7dqvt3q+7frSi/6v7dqvt3q+7frbp/
t+r+3Yr6V92/W3X/btX9u1X371bdv1tR/6r7d6vu3626f7fq/t2q+3cr6l91
/27V/btV9+9W3b9bdf9uRf9X3b9bdf9u1f27VffvVt2/W9H/VffvVt2/W3X/
7v/n/t3/AZTIh2U=
         "], {{{}, {}, {}, 
           {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
            LineBox[{703, 3}], LineBox[{704, 4}], LineBox[{705, 5}], 
            LineBox[{706, 6}], LineBox[{711, 11}], LineBox[{712, 12}], 
            LineBox[{714, 14}], LineBox[{715, 15}], LineBox[{717, 17}], 
            LineBox[{719, 19}], LineBox[{720, 20}], LineBox[{722, 22}], 
            LineBox[{724, 24}], LineBox[{727, 27}], LineBox[{728, 28}], 
            LineBox[{731, 31}], LineBox[{732, 32}], LineBox[{733, 33}], 
            LineBox[{734, 34}], LineBox[{735, 35}], LineBox[{740, 40}], 
            LineBox[{741, 41}], LineBox[{742, 42}], LineBox[{743, 43}], 
            LineBox[{747, 47}], LineBox[{749, 49}], LineBox[{750, 50}], 
            LineBox[{751, 51}], LineBox[{753, 53}], LineBox[{755, 55}], 
            LineBox[{757, 57}], LineBox[{758, 58}], LineBox[{761, 61}], 
            LineBox[{763, 63}], LineBox[{765, 65}], LineBox[{767, 67}], 
            LineBox[{768, 68}], LineBox[{771, 71}], LineBox[{774, 74}], 
            LineBox[{775, 75}], LineBox[{777, 77}], LineBox[{779, 79}], 
            LineBox[{783, 83}], LineBox[{787, 87}], LineBox[{788, 88}], 
            LineBox[{789, 89}], LineBox[{791, 91}], LineBox[{793, 93}], 
            LineBox[{795, 95}], LineBox[{797, 97}], LineBox[{798, 98}], 
            LineBox[{800, 100}], LineBox[{801, 101}], LineBox[{805, 105}], 
            LineBox[{807, 107}], LineBox[{809, 109}], LineBox[{811, 111}], 
            LineBox[{812, 112}], LineBox[{813, 113}], LineBox[{817, 117}], 
            LineBox[{820, 120}], LineBox[{823, 123}], LineBox[{824, 124}], 
            LineBox[{826, 126}], LineBox[{827, 127}], LineBox[{830, 130}], 
            LineBox[{833, 133}], LineBox[{834, 134}], LineBox[{835, 135}], 
            LineBox[{837, 137}], LineBox[{841, 141}], LineBox[{843, 143}], 
            LineBox[{845, 145}], LineBox[{847, 147}], LineBox[{849, 149}], 
            LineBox[{851, 151}], LineBox[{852, 152}], LineBox[{855, 155}], 
            LineBox[{857, 157}], LineBox[{859, 159}], LineBox[{860, 160}], 
            LineBox[{861, 161}], LineBox[{862, 162}], LineBox[{863, 163}], 
            LineBox[{867, 167}], LineBox[{868, 168}], LineBox[{869, 169}], 
            LineBox[{870, 170}], LineBox[{871, 171}], LineBox[{873, 173}], 
            LineBox[{875, 175}], LineBox[{877, 177}], LineBox[{879, 179}], 
            LineBox[{881, 181}], LineBox[{887, 187}], LineBox[{888, 188}], 
            LineBox[{889, 189}], LineBox[{893, 193}], LineBox[{895, 195}], 
            LineBox[{896, 196}], LineBox[{897, 197}], LineBox[{900, 200}], 
            LineBox[{901, 201}], LineBox[{902, 202}], LineBox[{904, 204}], 
            LineBox[{907, 207}], LineBox[{909, 209}], LineBox[{911, 211}], 
            LineBox[{912, 212}], LineBox[{913, 213}], LineBox[{915, 215}], 
            LineBox[{916, 216}], LineBox[{917, 217}], LineBox[{919, 219}], 
            LineBox[{920, 220}], LineBox[{921, 221}], LineBox[{923, 223}], 
            LineBox[{927, 227}], LineBox[{929, 229}], LineBox[{930, 230}], 
            LineBox[{931, 231}], LineBox[{932, 232}], LineBox[{935, 235}], 
            LineBox[{938, 238}], LineBox[{940, 240}], LineBox[{941, 241}], 
            LineBox[{945, 245}], LineBox[{947, 247}], LineBox[{948, 248}], 
            LineBox[{949, 249}], LineBox[{955, 255}], LineBox[{956, 256}], 
            LineBox[{957, 257}], LineBox[{958, 258}], LineBox[{959, 259}], 
            LineBox[{961, 261}], LineBox[{965, 265}], LineBox[{966, 266}], 
            LineBox[{967, 267}], LineBox[{968, 268}], LineBox[{969, 269}], 
            LineBox[{971, 271}], LineBox[{973, 273}], LineBox[{975, 275}], 
            LineBox[{977, 277}], LineBox[{981, 281}], LineBox[{983, 283}], 
            LineBox[{985, 285}], LineBox[{987, 287}], LineBox[{988, 288}], 
            LineBox[{989, 289}], LineBox[{991, 291}], LineBox[{992, 292}], 
            LineBox[{993, 293}], LineBox[{994, 294}], LineBox[{998, 298}], 
            LineBox[{1001, 301}], LineBox[{1002, 302}], LineBox[{1003, 303}], 
            LineBox[{1009, 309}], LineBox[{1010, 310}], LineBox[{1011, 311}], 
            LineBox[{1012, 312}], LineBox[{1013, 313}], LineBox[{1014, 314}], 
            LineBox[{1015, 315}], LineBox[{1019, 319}], LineBox[{1021, 321}], 
            LineBox[{1027, 327}], LineBox[{1028, 328}], LineBox[{1029, 329}], 
            LineBox[{1034, 334}], LineBox[{1035, 335}], LineBox[{1040, 340}], 
            LineBox[{1041, 341}], LineBox[{1042, 342}], LineBox[{1044, 344}], 
            LineBox[{1045, 345}], LineBox[{1047, 347}], LineBox[{1048, 348}], 
            LineBox[{1050, 350}], LineBox[{1053, 353}], LineBox[{1054, 354}], 
            LineBox[{1055, 355}], LineBox[{1057, 357}], LineBox[{1059, 359}], 
            LineBox[{1060, 360}], LineBox[{1061, 361}], LineBox[{1063, 363}], 
            LineBox[{1067, 367}], LineBox[{1071, 371}], LineBox[{1072, 372}], 
            LineBox[{1073, 373}], LineBox[{1074, 374}], LineBox[{1077, 377}], 
            LineBox[{1078, 378}], LineBox[{1080, 380}], LineBox[{1081, 381}], 
            LineBox[{1082, 382}], LineBox[{1083, 383}], LineBox[{1084, 384}], 
            LineBox[{1087, 387}], LineBox[{1091, 391}], LineBox[{1093, 393}], 
            LineBox[{1094, 394}], LineBox[{1096, 396}], LineBox[{1097, 397}], 
            LineBox[{1100, 400}], LineBox[{1101, 401}], LineBox[{1103, 403}], 
            LineBox[{1107, 407}], LineBox[{1109, 409}], LineBox[{1110, 410}], 
            LineBox[{1111, 411}], LineBox[{1112, 412}], LineBox[{1113, 413}], 
            LineBox[{1117, 417}], LineBox[{1119, 419}], LineBox[{1120, 420}], 
            LineBox[{1122, 422}], LineBox[{1126, 426}], LineBox[{1129, 429}], 
            LineBox[{1130, 430}], LineBox[{1131, 431}], LineBox[{1133, 433}], 
            LineBox[{1138, 438}], LineBox[{1139, 439}], LineBox[{1140, 440}], 
            LineBox[{1141, 441}], LineBox[{1143, 443}], LineBox[{1147, 447}], 
            LineBox[{1150, 450}], LineBox[{1151, 451}], LineBox[{1152, 452}], 
            LineBox[{1153, 453}], LineBox[{1155, 455}], LineBox[{1156, 456}], 
            LineBox[{1157, 457}], LineBox[{1159, 459}], LineBox[{1163, 463}], 
            LineBox[{1165, 465}], LineBox[{1166, 466}], LineBox[{1173, 473}], 
            LineBox[{1175, 475}], LineBox[{1176, 476}], LineBox[{1177, 477}], 
            LineBox[{1178, 478}], LineBox[{1180, 480}], LineBox[{1183, 483}], 
            LineBox[{1185, 485}], LineBox[{1186, 486}], LineBox[{1187, 487}], 
            LineBox[{1188, 488}], LineBox[{1190, 490}], LineBox[{1191, 491}], 
            LineBox[{1192, 492}], LineBox[{1193, 493}], LineBox[{1195, 495}], 
            LineBox[{1198, 498}], LineBox[{1199, 499}], LineBox[{1200, 500}], 
            LineBox[{1209, 509}], LineBox[{1211, 511}], LineBox[{1212, 512}], 
            LineBox[{1213, 513}], LineBox[{1214, 514}], LineBox[{1216, 516}], 
            LineBox[{1218, 518}], LineBox[{1219, 519}], LineBox[{1225, 525}], 
            LineBox[{1227, 527}], LineBox[{1229, 529}], LineBox[{1230, 530}], 
            LineBox[{1232, 532}], LineBox[{1234, 534}], LineBox[{1237, 537}], 
            LineBox[{1239, 539}], LineBox[{1245, 545}], LineBox[{1246, 546}], 
            LineBox[{1247, 547}], LineBox[{1248, 548}], LineBox[{1249, 549}], 
            LineBox[{1252, 552}], LineBox[{1255, 555}], LineBox[{1256, 556}], 
            LineBox[{1259, 559}], LineBox[{1264, 564}], LineBox[{1265, 565}], 
            LineBox[{1266, 566}], LineBox[{1267, 567}], LineBox[{1268, 568}], 
            LineBox[{1269, 569}], LineBox[{1272, 572}], LineBox[{1274, 574}], 
            LineBox[{1275, 575}], LineBox[{1277, 577}], LineBox[{1279, 579}], 
            LineBox[{1283, 583}], LineBox[{1285, 585}], LineBox[{1289, 589}], 
            LineBox[{1292, 592}], LineBox[{1294, 594}], LineBox[{1295, 595}], 
            LineBox[{1296, 596}], LineBox[{1300, 600}], LineBox[{1301, 601}], 
            LineBox[{1303, 603}], LineBox[{1310, 610}], LineBox[{1311, 611}], 
            LineBox[{1313, 613}], LineBox[{1315, 615}], LineBox[{1318, 618}], 
            LineBox[{1321, 621}], LineBox[{1322, 622}], LineBox[{1324, 624}], 
            LineBox[{1331, 631}], LineBox[{1333, 633}], LineBox[{1334, 634}], 
            LineBox[{1336, 636}], LineBox[{1337, 637}], LineBox[{1341, 641}], 
            LineBox[{1342, 642}], LineBox[{1343, 643}], LineBox[{1344, 644}], 
            LineBox[{1346, 646}], LineBox[{1347, 647}], LineBox[{1348, 648}], 
            LineBox[{1354, 654}], LineBox[{1355, 655}], LineBox[{1362, 662}], 
            LineBox[{1365, 665}], LineBox[{1366, 666}], LineBox[{1367, 667}], 
            LineBox[{1368, 668}], LineBox[{1369, 669}], LineBox[{1372, 672}], 
            LineBox[{1373, 673}], LineBox[{1374, 674}], LineBox[{1375, 675}], 
            LineBox[{1377, 677}], LineBox[{1378, 678}], LineBox[{1380, 680}], 
            LineBox[{1381, 681}], LineBox[{1382, 682}], LineBox[{1383, 683}], 
            LineBox[{1384, 684}], LineBox[{1385, 685}], LineBox[{1386, 686}], 
            LineBox[{1387, 687}], LineBox[{1388, 688}], LineBox[{1390, 690}], 
            LineBox[{1391, 691}], LineBox[{1392, 692}], LineBox[{1393, 693}]}, 
           {RGBColor[0.368417, 0.506779, 0.709798], Opacity[0.3], 
            LineBox[{701, 1}], LineBox[{702, 2}], LineBox[{707, 7}], 
            LineBox[{708, 8}], LineBox[{709, 9}], LineBox[{710, 10}], 
            LineBox[{713, 13}], LineBox[{716, 16}], LineBox[{718, 18}], 
            LineBox[{721, 21}], LineBox[{723, 23}], LineBox[{725, 25}], 
            LineBox[{726, 26}], LineBox[{729, 29}], LineBox[{730, 30}], 
            LineBox[{736, 36}], LineBox[{737, 37}], LineBox[{738, 38}], 
            LineBox[{739, 39}], LineBox[{744, 44}], LineBox[{745, 45}], 
            LineBox[{746, 46}], LineBox[{748, 48}], LineBox[{752, 52}], 
            LineBox[{754, 54}], LineBox[{756, 56}], LineBox[{759, 59}], 
            LineBox[{760, 60}], LineBox[{762, 62}], LineBox[{764, 64}], 
            LineBox[{766, 66}], LineBox[{769, 69}], LineBox[{770, 70}], 
            LineBox[{772, 72}], LineBox[{773, 73}], LineBox[{776, 76}], 
            LineBox[{778, 78}], LineBox[{780, 80}], LineBox[{781, 81}], 
            LineBox[{782, 82}], LineBox[{784, 84}], LineBox[{785, 85}], 
            LineBox[{786, 86}], LineBox[{790, 90}], LineBox[{792, 92}], 
            LineBox[{794, 94}], LineBox[{796, 96}], LineBox[{799, 99}], 
            LineBox[{802, 102}], LineBox[{803, 103}], LineBox[{804, 104}], 
            LineBox[{806, 106}], LineBox[{808, 108}], LineBox[{810, 110}], 
            LineBox[{814, 114}], LineBox[{815, 115}], LineBox[{816, 116}], 
            LineBox[{818, 118}], LineBox[{819, 119}], LineBox[{821, 121}], 
            LineBox[{822, 122}], LineBox[{825, 125}], LineBox[{828, 128}], 
            LineBox[{829, 129}], LineBox[{831, 131}], LineBox[{832, 132}], 
            LineBox[{836, 136}], LineBox[{838, 138}], LineBox[{839, 139}], 
            LineBox[{840, 140}], LineBox[{842, 142}], LineBox[{844, 144}], 
            LineBox[{846, 146}], LineBox[{848, 148}], LineBox[{850, 150}], 
            LineBox[{853, 153}], LineBox[{854, 154}], LineBox[{856, 156}], 
            LineBox[{858, 158}], LineBox[{864, 164}], LineBox[{865, 165}], 
            LineBox[{866, 166}], LineBox[{872, 172}], LineBox[{874, 174}], 
            LineBox[{876, 176}], LineBox[{878, 178}], LineBox[{880, 180}], 
            LineBox[{882, 182}], LineBox[{883, 183}], LineBox[{884, 184}], 
            LineBox[{885, 185}], LineBox[{886, 186}], LineBox[{890, 190}], 
            LineBox[{891, 191}], LineBox[{892, 192}], LineBox[{894, 194}], 
            LineBox[{898, 198}], LineBox[{899, 199}], LineBox[{903, 203}], 
            LineBox[{905, 205}], LineBox[{906, 206}], LineBox[{908, 208}], 
            LineBox[{910, 210}], LineBox[{914, 214}], LineBox[{918, 218}], 
            LineBox[{922, 222}], LineBox[{924, 224}], LineBox[{925, 225}], 
            LineBox[{926, 226}], LineBox[{928, 228}], LineBox[{933, 233}], 
            LineBox[{934, 234}], LineBox[{936, 236}], LineBox[{937, 237}], 
            LineBox[{939, 239}], LineBox[{942, 242}], LineBox[{943, 243}], 
            LineBox[{944, 244}], LineBox[{946, 246}], LineBox[{950, 250}], 
            LineBox[{951, 251}], LineBox[{952, 252}], LineBox[{953, 253}], 
            LineBox[{954, 254}], LineBox[{960, 260}], LineBox[{962, 262}], 
            LineBox[{963, 263}], LineBox[{964, 264}], LineBox[{970, 270}], 
            LineBox[{972, 272}], LineBox[{974, 274}], LineBox[{976, 276}], 
            LineBox[{978, 278}], LineBox[{979, 279}], LineBox[{980, 280}], 
            LineBox[{982, 282}], LineBox[{984, 284}], LineBox[{986, 286}], 
            LineBox[{990, 290}], LineBox[{995, 295}], LineBox[{996, 296}], 
            LineBox[{997, 297}], LineBox[{999, 299}], LineBox[{1000, 300}], 
            LineBox[{1004, 304}], LineBox[{1005, 305}], LineBox[{1006, 306}], 
            LineBox[{1007, 307}], LineBox[{1008, 308}], LineBox[{1016, 316}], 
            LineBox[{1017, 317}], LineBox[{1018, 318}], LineBox[{1020, 320}], 
            LineBox[{1022, 322}], LineBox[{1023, 323}], LineBox[{1024, 324}], 
            LineBox[{1025, 325}], LineBox[{1026, 326}], LineBox[{1030, 330}], 
            LineBox[{1031, 331}], LineBox[{1032, 332}], LineBox[{1033, 333}], 
            LineBox[{1036, 336}], LineBox[{1037, 337}], LineBox[{1038, 338}], 
            LineBox[{1039, 339}], LineBox[{1043, 343}], LineBox[{1046, 346}], 
            LineBox[{1049, 349}], LineBox[{1051, 351}], LineBox[{1052, 352}], 
            LineBox[{1056, 356}], LineBox[{1058, 358}], LineBox[{1062, 362}], 
            LineBox[{1064, 364}], LineBox[{1065, 365}], LineBox[{1066, 366}], 
            LineBox[{1068, 368}], LineBox[{1069, 369}], LineBox[{1070, 370}], 
            LineBox[{1075, 375}], LineBox[{1076, 376}], LineBox[{1079, 379}], 
            LineBox[{1085, 385}], LineBox[{1086, 386}], LineBox[{1088, 388}], 
            LineBox[{1089, 389}], LineBox[{1090, 390}], LineBox[{1092, 392}], 
            LineBox[{1095, 395}], LineBox[{1098, 398}], LineBox[{1099, 399}], 
            LineBox[{1102, 402}], LineBox[{1104, 404}], LineBox[{1105, 405}], 
            LineBox[{1106, 406}], LineBox[{1108, 408}], LineBox[{1114, 414}], 
            LineBox[{1115, 415}], LineBox[{1116, 416}], LineBox[{1118, 418}], 
            LineBox[{1121, 421}], LineBox[{1123, 423}], LineBox[{1124, 424}], 
            LineBox[{1125, 425}], LineBox[{1127, 427}], LineBox[{1128, 428}], 
            LineBox[{1132, 432}], LineBox[{1134, 434}], LineBox[{1135, 435}], 
            LineBox[{1136, 436}], LineBox[{1137, 437}], LineBox[{1142, 442}], 
            LineBox[{1144, 444}], LineBox[{1145, 445}], LineBox[{1146, 446}], 
            LineBox[{1148, 448}], LineBox[{1149, 449}], LineBox[{1154, 454}], 
            LineBox[{1158, 458}], LineBox[{1160, 460}], LineBox[{1161, 461}], 
            LineBox[{1162, 462}], LineBox[{1164, 464}], LineBox[{1167, 467}], 
            LineBox[{1168, 468}], LineBox[{1169, 469}], LineBox[{1170, 470}], 
            LineBox[{1171, 471}], LineBox[{1172, 472}], LineBox[{1174, 474}], 
            LineBox[{1179, 479}], LineBox[{1181, 481}], LineBox[{1182, 482}], 
            LineBox[{1184, 484}], LineBox[{1189, 489}], LineBox[{1194, 494}], 
            LineBox[{1196, 496}], LineBox[{1197, 497}], LineBox[{1201, 501}], 
            LineBox[{1202, 502}], LineBox[{1203, 503}], LineBox[{1204, 504}], 
            LineBox[{1205, 505}], LineBox[{1206, 506}], LineBox[{1207, 507}], 
            LineBox[{1208, 508}], LineBox[{1210, 510}], LineBox[{1215, 515}], 
            LineBox[{1217, 517}], LineBox[{1220, 520}], LineBox[{1221, 521}], 
            LineBox[{1222, 522}], LineBox[{1223, 523}], LineBox[{1224, 524}], 
            LineBox[{1226, 526}], LineBox[{1228, 528}], LineBox[{1231, 531}], 
            LineBox[{1233, 533}], LineBox[{1235, 535}], LineBox[{1236, 536}], 
            LineBox[{1238, 538}], LineBox[{1240, 540}], LineBox[{1241, 541}], 
            LineBox[{1242, 542}], LineBox[{1243, 543}], LineBox[{1244, 544}], 
            LineBox[{1250, 550}], LineBox[{1251, 551}], LineBox[{1253, 553}], 
            LineBox[{1254, 554}], LineBox[{1257, 557}], LineBox[{1258, 558}], 
            LineBox[{1260, 560}], LineBox[{1261, 561}], LineBox[{1262, 562}], 
            LineBox[{1263, 563}], LineBox[{1270, 570}], LineBox[{1271, 571}], 
            LineBox[{1273, 573}], LineBox[{1276, 576}], LineBox[{1278, 578}], 
            LineBox[{1280, 580}], LineBox[{1281, 581}], LineBox[{1282, 582}], 
            LineBox[{1284, 584}], LineBox[{1286, 586}], LineBox[{1287, 587}], 
            LineBox[{1288, 588}], LineBox[{1290, 590}], LineBox[{1291, 591}], 
            LineBox[{1293, 593}], LineBox[{1297, 597}], LineBox[{1298, 598}], 
            LineBox[{1299, 599}], LineBox[{1302, 602}], LineBox[{1304, 604}], 
            LineBox[{1305, 605}], LineBox[{1306, 606}], LineBox[{1307, 607}], 
            LineBox[{1308, 608}], LineBox[{1309, 609}], LineBox[{1312, 612}], 
            LineBox[{1314, 614}], LineBox[{1316, 616}], LineBox[{1317, 617}], 
            LineBox[{1319, 619}], LineBox[{1320, 620}], LineBox[{1323, 623}], 
            LineBox[{1325, 625}], LineBox[{1326, 626}], LineBox[{1327, 627}], 
            LineBox[{1328, 628}], LineBox[{1329, 629}], LineBox[{1330, 630}], 
            LineBox[{1332, 632}], LineBox[{1335, 635}], LineBox[{1338, 638}], 
            LineBox[{1339, 639}], LineBox[{1340, 640}], LineBox[{1345, 645}], 
            LineBox[{1349, 649}], LineBox[{1350, 650}], LineBox[{1351, 651}], 
            LineBox[{1352, 652}], LineBox[{1353, 653}], LineBox[{1356, 656}], 
            LineBox[{1357, 657}], LineBox[{1358, 658}], LineBox[{1359, 659}], 
            LineBox[{1360, 660}], LineBox[{1361, 661}], LineBox[{1363, 663}], 
            LineBox[{1364, 664}], LineBox[{1370, 670}], LineBox[{1371, 671}], 
            LineBox[{1376, 676}], LineBox[{1379, 679}], LineBox[{1389, 689}], 
            LineBox[{1394, 694}], LineBox[{1395, 695}], LineBox[{1396, 696}], 
            LineBox[{1397, 697}], LineBox[{1398, 698}], LineBox[{1399, 699}], 
            LineBox[{1400, 700}]}}, {{}, 
           {RGBColor[0.368417, 0.506779, 0.709798], PointSize[
            0.0055000000000000005`], AbsoluteThickness[1.6], 
            PointBox[CompressedData["
1:eJwN02PDFgYAAMAnvtm27drysm1subawZdu2bdu2bdu23e7D/YRL2rBV5ZbB
AoHA9uCBQJdQgUBXutGdHvSkF73pQ1/60Z8BDGQQgxnCUIYxnBGMZBSjGcNY
xjGeCUxkEpOZwlSmMZ0ZzGQWs5nDXOYxnwUsZBGLWcJSlrGcFaxkFatZw1rW
sZ4NbGQTm9nCVraxnR3sZBe72cNe9rGfAxzkEIc5wlGOcZwTnOQUpznDWc5x
ngtc5BKXucJVrnGdG9zkFre5w13ucZ8HPOQRj3nCU57xnBe85BWvecNb3vGe
D3zkE5/5wle+8Z0f/OQXgdCBQDCCE4KQhCI0QYQhLOEITwQiEonIRCEq0YhO
DGISi9jEIS7xiE8CEpKIxCQhKclITgpSkorUpCEt6UhPBjKSicxkISvZyE4O
fuN3cpKL3OQhL/nIzx8UoCCFKEwRilKM4pSgJKUoTRnKUo7yVKAilahMFapS
jerUoCa1qM2f/EUd6lKP+jSgIY1oTBP+5h+a0ozmtOBf/qMlrWhNG9rSjvZ0
oCOd6EwXutKN7vSgJ73oTR/60o/+DGAggxjMEIYyjOGMYCSjGM0YxjKO8Uxg
IpOYzBSmMo3pzGAms5jNHOYyj/ksYCGLWMwSlrKM5axgJatYzRrWso71bGAj
m9jMFrayje3sYCe72M0e9rKP/RzgIIc4zBGOcozjnOAkpzjNGc5yjvNc4CKX
uMwVrnKN69zgJre4zR3uco/7POAhj3jME57yjOe84CWveM0b3vKO93zgI5/4
zBe+8o3v/OAnvwgE+U9wQhCSUIQmiDCEJRzhiUBEIhGZKEQlGtGJQUxiEZs4
xCUe8UlAQhKRmCQkJRnJSUFKUpGaNKQlHenJQEYykZksZCUb2cnBb/xOTnKR
mzzkJR/5+YMCFKQQhSlCUYpRnBKUpBSlKUNZylGeClSkEpWpQlWqUZ0a1KQW
tfmTv6hDXepRnwY0pBGNacLf/ENTmtGcFvzLf7SkFa1pQ1va0Z4OdKQTnelC
V7rRnR70pBe96UNf+tGfAQxkEIMZwlCGMZwRjGQUoxnDWMYxnglMZBKTmcJU
pjGdGcxkFrOZw1zmMZ8FLGQRi1nCUpaxnBWsZBWrWcNa1rGeDWxkE5vZwla2
sZ0d7GQXu9nDXvaxnwMc5BCHOcJRjnGcE5zkFKc5w1nOcZ4LXOQSl7nCVa5x
nRvc5Ba3ucNd7nGfBzzkEY95wlOe8ZwXvOQVr3nDW97xng985BOf+cJXvvGd
H/zkF4Ew/hOcEIQkFKEJIgxhCUd4IhCRSEQmClGJRnRiEJNYxCYOcYlHfBKQ
kEQkJglJSUZyUpCSVKQmDWlJR3oykJFMZCYLWclGdnLwP/W2e1I=
             
             "]]}, {}}}], {}, {}, {}, {}},
       AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
       Axes->{False, False},
       AxesLabel->{None, None},
       AxesOrigin->{0, 0},
       DisplayFunction->Identity,
       Frame->{{True, True}, {True, True}},
       FrameLabel->{{
          FormBox["\"Covari\[AHat]ncia\"", TraditionalForm], None}, {
          FormBox["\"Semanas\"", TraditionalForm], 
          FormBox[
          "\"\\!\\(\\*SubscriptBox[\\(s\\), \\(3\\)]\\)\"", TraditionalForm]}},
       FrameStyle->Directive[18, 
         Thickness[Large]],
       FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
       GridLines->{None, None},
       GridLinesStyle->Directive[
         GrayLevel[0.5, 0.4]],
       ImagePadding->All,
       Method->{"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& ), "CopiedValueFunction" -> ({
             (Identity[#]& )[
              Part[#, 1]], 
             (Identity[#]& )[
              Part[#, 2]]}& )}},
       PlotRange->{{0, 700.}, {-0.006606286848813032, 0.007249779865886292}},
       PlotRangeClipping->True,
       PlotRangePadding->{{
          Scaled[0.02], 
          Scaled[0.02]}, {
          Scaled[0.05], 
          Scaled[0.05]}},
       Ticks->{Automatic, Automatic}], {967.5, -597.9478841155233}, 
      ImageScaled[{0.5, 0.5}], {360., 222.4922359499622}]}}, {}},
  ContentSelectable->True,
  ImageSize->{1649., Automatic},
  PlotRangePadding->{6, 5}]], "Output",ExpressionUUID->"14d70f2e-8c0d-44b2-\
9498-96a5ba7d8e6d"]
}, Open  ]],

Cell[TextData[{
 "Treinamento da s\[EAcute]rie residual ",
 Cell[BoxData[
  FormBox[
   SubscriptBox["s", "3"], TraditionalForm]],ExpressionUUID->
  "dce488c3-8b3f-479b-bbda-578081728402"]
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"582542d5-3d09-4f09-a8f9-10631686b2cd"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"precosNeurons", "=", "5"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"precosInputNumber", "=", "31"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"precosOutputNumber", "=", "1"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"precosTrain", ",", "precosTest"}], "}"}], "=", 
   RowBox[{"sampleSplit", "[", 
    RowBox[{"precosS3", ",", "precosInputNumber"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"precosBatchSize", "=", "1"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"precosNetModel", "=", 
   RowBox[{"neuralNetwork", "[", 
    RowBox[{
    "precosS3", ",", "precosNeurons", ",", "precosInputNumber", ",", 
     "precosOutputNumber", ",", "precosTrain", ",", "precosTest", ",", 
     "precosBatchSize"}], "]"}]}], ";"}]}], "Input",ExpressionUUID->"c449863c-\
d0ce-4fa8-b200-4c35e63dd961"],

Cell[TextData[{
 "Como no caso de Temperaturas M\[EAcute]dias, previs\[ATilde]o obtida pela \
rede neural \[EAcute] altamente n\[ATilde]o confi\[AAcute]vel. Aqui, al\
\[EAcute]m de a s\[EAcute]rie n\[ATilde]o estar exatamente em estado estacion\
\[AAcute]rio fraco ( covari\[AHat]ncias ",
 Cell[BoxData[
  FormBox[
   RowBox[{"\[Tilde]", 
    SuperscriptBox["10", 
     RowBox[{"-", "3"}]]}], TraditionalForm]],ExpressionUUID->
  "f632f20a-8b70-490e-8796-f67068aa63af"],
 "), as irreegularidades previnem qualquer tentativa de predi\[CCedilla]\
\[ATilde]o dos res\[IAcute]duos n\[ATilde]o-lineares de forma \
estatisticamente confi\[AAcute]vel."
}], "Text",
 Background->RGBColor[
  0.94, 0.91, 0.88],ExpressionUUID->"50108667-9876-44d9-870d-e1cc3f9b83d3"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"precosFuturePoints", "=", "precosInputNumber"}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"precosTrained", " ", "=", " ", 
   RowBox[{"Flatten", "[", 
    RowBox[{
     RowBox[{"NestList", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"Rest", "[", 
         RowBox[{"Append", "[", 
          RowBox[{"#", ",", 
           RowBox[{
            RowBox[{"precosNetModel", "[", "\"\<TrainedNet\>\"", "]"}], "[", 
            "#", "]"}]}], "]"}], "]"}], "&"}], ",", 
       RowBox[{"precosTest", "[", 
        RowBox[{"[", 
         RowBox[{
          RowBox[{"-", "1"}], ",", "1"}], "]"}], "]"}], ",", 
       "precosFuturePoints"}], "]"}], "[", 
     RowBox[{"[", 
      RowBox[{"-", "2"}], "]"}], "]"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"precosPlot", "=", 
   RowBox[{"Thread", "[", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"Range", "[", 
       RowBox[{
        RowBox[{
         RowBox[{"Length", "@", "precosS3"}], "-", 
         RowBox[{"Mod", "[", 
          RowBox[{
           RowBox[{"Length", "@", "precosS3"}], ",", 
           RowBox[{"precosInputNumber", "+", "1"}]}], "]"}], "-", "1"}], ",", 
        
        RowBox[{
         RowBox[{"Length", "@", "precosS3"}], "-", 
         RowBox[{"Mod", "[", 
          RowBox[{
           RowBox[{"Length", "@", "precosS3"}], ",", 
           RowBox[{"precosInputNumber", "+", "1"}]}], "]"}], "+", 
         RowBox[{"Length", "@", "precosTrained"}], "-", "2"}]}], "]"}], ",", 
      "precosTrained"}], "}"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{"ListLinePlot", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"precosS3", ",", "precosPlot"}], "}"}], ",", 
   RowBox[{"Joined", "\[Rule]", "True"}], ",", 
   RowBox[{"PlotLegends", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"\"\<Original\>\"", ",", "\"\<Predicted\>\""}], "}"}]}], ",", 
   RowBox[{"PlotRange", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"precosPlot", "[", 
         RowBox[{"[", 
          RowBox[{"1", ",", "1"}], "]"}], "]"}], ",", 
        RowBox[{"precosPlot", "[", 
         RowBox[{"[", 
          RowBox[{
           RowBox[{"-", "1"}], ",", "1"}], "]"}], "]"}]}], "}"}], ",", 
      "All"}], "}"}]}], ",", 
   RowBox[{"PlotStyle", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"Blue", ",", "Red"}], "}"}]}], ",", 
   RowBox[{"Axes", "\[Rule]", "False"}], ",", "\[IndentingNewLine]", 
   RowBox[{"Frame", "\[Rule]", "True"}], ",", 
   RowBox[{"FrameStyle", "\[Rule]", 
    RowBox[{"Directive", "[", 
     RowBox[{"18", ",", "Thick"}], "]"}]}], ",", 
   RowBox[{"FrameLabel", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"\"\<Res\[IAcute]duos\>\"", ",", "None"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"\"\<Semanas\>\"", ",", "\"\<S\[EAcute]rie Residual\>\""}], 
       "}"}]}], "}"}]}]}], "\[IndentingNewLine]", "]"}]}], "Input",ExpressionU\
UID->"bc735e57-d721-4689-87b8-77fa1c537069"],

Cell[BoxData[
 TemplateBox[{GraphicsBox[{{}, {{{}, {}, {
        Hue[0.67, 0.6, 0.6], 
        Directive[
         PointSize[
          NCache[
           Rational[1, 90], 0.011111111111111112`]], 
         AbsoluteThickness[1.6], 
         RGBColor[0, 0, 1]], 
        LineBox[CompressedData["
1:eJw9WnlczN33H3uWKGv2kSj7SJG1dyFFmFK0m/ZNNe1TTfWZjSwxthQesidb
kkq2kZCEIUsII6GeUCGyPPr2e3U+v/7Q67ife8892/sst1FeYfa+HTkczuW2
f/7vd/tPo/nAkyZ/3TpeMKf/wPE9xQezHj4kWguzjvw6KlfcJ1oHERmXHxuZ
XiK6P2xvaf23wffc1XZaDzn+E8yqO2XR+jBUnv/D7TFeRTQXzK9DA7r1Pk+0
PvjKUfqT1GeJNgCz1+FnuOYE0WPRf6rFu4Sfl+h8I1zBsKZNF7OIHg+zfKeo
lqPs9xPxfumBxrrkvbQ+GdyQxec7ZKqI5qFpycaUkttniJ4Kn78+2jsUubTf
GIvLbXQ7/7hD69Pwfv202pW5l2ndBB+fjNmeP4nVlylu/t1ZdH5ZMX0/HbVP
+EGvnXcTPQONx4LurrrOrpuhp5379xBdVl8zkdVt1rfnHdj7zIKbvrqv354S
On82xBV5c179zKf1OShcHqslGsnqay6Ghbn1ddlyheh52Ju6757c7AR9b45r
kS9irFIOEQ0oZ+hy1u0ubv+eAeKfHc8wrzxP6xZwWa36djrnEK1b4Mtel8H5
/x2l8y1hXTHh46ZIOp+xxPiRVwsWhLP6nw+nPn93TxpUROvz8T5NN3/7ADWt
L0Bx77eXP7nk0/kLcOWCIcf5/XbivxBMc8A4XcVG2r8QHGHqgG2eEbRuBVdZ
2LAP9w7SuhV2/xrr21T1kNYX4WjB2ys5uldpfREKS2O0JNyNxN8az//kzplr
cJHWrcHdOdYqw+MWrdvgj+GAxOpb5J+MDew9e5ge2Ub35SzG07gfhy3X7qD9
izFv5NGCZX3oPM4SNN143qR35AbtX4K9+pePmZbtpHVbWI2P058fQ/ZlbDG+
fPnUqStv0/pSvCzq4uH+L8ULsxR/v67puSuElW8ZNP0b4tu+I/7LAGyu/Dvo
Md1vOabzt3eL6XqZ1pdjarTxLkPJBdrPx92hEbbbVp9tp8HH+gd6U4/mP6Dv
+eAcXj9w9qm89vNUfAgHNK96Oy2P9ttBVGd/5/omefs67FA6fOKN5ivpdF87
jP+6s2zw8hzab4e+nW11So3ZeLFHdnS1m8X2Atpvj0utjGa+iPCFscejcsk8
XtqVdn4qe/QyejQqdNk12r8CTg9bCs2qUmn/Clh3DQod92UP3X8FZA9WrTY/
T/KqViDCZ090sH857XdAvHGUXc2QGyS/Ax5wTsa5XrhO/B2Q9abU43AT6V/l
gJXiGKvA/8cHRxQ43M1f2JXW4Yh3+r8/WQ49RfsdMaT21LWpx4mfyhHdPE3N
smdVkP5W4k3xhYtVhqRPrMTWfvtL1z1n7bUSmb9eXyzmsPdfiZyRazyrNouI
/yp09TpX2O8v6Qer8LPWfE0XLXb/Khxy/BG4KIniU7UKnBgH377FHrTfCZ5r
76VNyyY8hRPU/YI3F9fcpP1OuHVu08dlP27S/Z2w/FQMd0gRnc9xxuTQS99s
3hGewhm8A1X/aS4eJvmdkakcqWWwhdWfM7x7vnDq7n2L9rugemnX436rWP25
4N67SqcYs5PE3wVp+h7GqhHX6P4uSJrs5VJxluKZ44q/jo+D3nd+RftdwZnn
qOEdI/xjXOF6+F4vg2yWvyv0eolT4i1Z/3GD+l3L7eUXz9B+N8T1+9b6x5Ts
w7jhTNqs/MHzS4m/G1ZUvGu8vZCNb3dYxmnrVEhLSH53vDsRPHWlO+s/7ih6
8Sg5v4TwROUOG1HYnUO2p2m/B8bPGZv9y6mI+HsgIrvXrM29Smm/B1q1Op5O
4JG+VB74pV2R8OPNcdq/GtZOJicCdh6g/auh0p7+z59q1v9XY2OJ9ox1vHLa
vxoBubFapS4baL8Avd9Jpurokz65AgweUteQp83igQAdsg6nysKet58vEEDg
rOuzJEVJ9xNgkd3z3N265L+ZAlzXUZ9WN1F+UwmQNaTu5X+PM9q/1whQMiCu
rnc4m/89IfccXzP6PsnL9YTJ/BFm1RVHiL8nOAMuH4jtWkH8PXFydFNDk/kT
4u+JBb4Ly355kD9meuLthaFdzXdSPaDyxFLd4rzvSZRvNJ5wne73M6iexVcv
mLSunxc/iOoXrhfS/DO+PWskvIMXpi27pN24gvxZ4AXmwcTZQ4UJpF8vpH7y
nvYQx9vXM72QncRk5OrmEv+279NXMfN1E9tpjRdqkh2WPCth6wFvuPVJar57
g/CQ642TXplzav8WkvzeYOSDsrd8p3wr8Ea/t9w9hx2oHmG8UX0tfIT9pTLi
7419UZZzH86tI3/zRkbD/omP3z0j+b1xtu7A93JPtv7xwfrQ6TLjGIovrg9W
hizwdq/6SPx9cCgzy82138t2WuCDGV7TMgZ9IXswPvAJvblX+xvpK9MH2R26
Dzi17R7J7wOTf/tdKaokPNH4YJ6ND7NlOeEJxxcNHeoqtw2pIv6+KDp5JNxM
TPEGX7TYf3ixqyCT5PfFsKc/OnR4S3jH+EIqdxGHuBWQ/X3ByK4PfNKf/Enl
iyFL/xkiyiJ/1viCq/6gskhk6yc/JL4xjX87jPI71w+rfv5zY/lZqu/gh4Gv
pt/Uz7hD/P1gdbJA8DSSzmP8UDpsl/GGagnx98PC01aueUbniL8fxurkfLAo
JP/U+MF6xZ4u0zux9Zg/yrfLC90TaD/XH09qP+2uDaDv4Y+DPxa5NWxKIf7+
yIzTiJP1goi/P/77/TN0lCXFU6Y/bMNTrtqMf0L690duaiXzfTfx0/jDbGSM
ySk9Vv8B8KirzLHjkz64AUDs7QOz4wgfEYCkTa0Lj4+7TfwDwLnRSTeUOUr8
AzBwtt+9xWHXSf4ApMx5cC3mA91fFYBRcV55N/jkL5oAlBxz7answ9aPgeju
9MI8Vpvuzw1E0fP6DK2FVH8iEBN2xf7+/pzwRRCIkTZ9/Q7ksPVYIAb5uGs/
mXaA+AdiYlVN6v53bL0RCOt0T53UDIbkD8Qd9c+an7Ws/wdhxLYvJX5fieYG
odZu7eCvLoSvCIJr/W/BzOxHJH8QCpdmOFcZE80E4U6/UXGfDe8T/yB09Bj+
usPgRyR/EDgI/5TwgPX/IJT2vd9t3R3CB04w+vt5Xs6zoHjhBoPT6bjaZgHV
lwiGiTl3RUUG5QtBMMp9vk/WTaN8xQRjh+3MB8FCqh8zg2En9rEfocvmm2Cs
mflm2YEOVM9pgiEOu2hTcoX1/zWoW5+3+esj6je4azDn17eQjIdsPluDAN2q
V+bn75H8a+DvHrix9CvZm1mD8gk3U57aZRP/NRh426H+sjv1F6o1cOGYNsRr
yJ80axC+7d9APR/CC04IuGYJkkFOLP6HwOxdUtyMNWw+C0FSv64rrh1k8TcE
fvvn9981ivCKCcHQPC/vVYG7iH8I3vxysqpNpfpYFYLsS7PN/k2m/kbTxm9g
yiELO7afC0X3zpqOM/1Z/A+FS913+1YZ1R8IhZ9rJ+t0f8JXQSieVI7eYVhN
9mBCMS1wBXd4LBt/oWjA93Gv+NTvqEKxuovLzf8+U32pCUWm3pJyqxNs/xeG
7487hed6U77mhmH6dfFWbRVbj4VB5V/x9tOhdLJ/GKrWPAqJPMLiTxh+BSgS
TgRT/5cZhqHWBm+X7yB9q8Kw+c7Sye9GUf+hCcOcTmLTkaGErxwhalOnT72n
pO91hEirOaZ9OoTszxWCk37QM7RubTvNE6LSaH2mIoL8B0I8mp/nFO9C+uUL
oRr3vugT34XuK0TvPSOGyKddbF8XCtGjYmMZdhL+MG3fp7hY9J1H+K0U4ujK
vaOXGLB4IkSMhfM1vg3haY4Qv/YPcf50mO0HhMhacXzFl4nk72ohuo0JLk3s
Sf6hEaLMKM+/WYvwu1GIG0emrijfyPbb4biu4sReXfWA5A9HeczRYukqik9u
OPzs0oIP/KH45oWj/9Y4vTN2bL8Qjq7+mUc23ThJ8oeDP753vd65KJI/HM6u
+Xe00wtJ/nCkdajV1rm5k+QPx8b0NeH2Z2m+ogxH/qXO+TIN6T8zHI+GtX5I
n054lhMO5ep/SoVO28i+4fAakzyiuoL6A3U4OGlmeWVvY0j+cJT6jJowaMQx
kj8cmq6a/c0+bP0ZgbP8sFGmGaR/nQgIIx6MS98cT/EQgV8Gx/3mq8i/eRF4
8jd37eNV1M8gAkY1/EMjPlL88SNQem1Q9OyJdH9BBAo7T5pp+pfyqTACE5LD
xBcVbD8bAbu03Svq1pF+lBGwtlUHuf4kfWZG4LKT7UvjYtqfE4FLRlVz1idT
faiKwOr5FlWOPaheV0egM7NrbrClmuSPQAXPafl/KVT/NUZAlRCwS/2LzX+R
2JS3+Uz+BYpvnUiYTOzrYnmf4oPbtm6vKsu1ovjiRYIzab/uS7kuyR+Jv0sX
/+jSgfyNHwn5o+zFJyypnhNEQrDIf9ayl4RvwkiYC+8YLtpYSfEbid+13Euz
3AmflZEwiJ3buNr7CMkfiYv3n72u2vKsfT0nEsUPlz7aYE3yqiJhVmq9soCz
n+SPhNhJMuf7cOq/NZEISLvOWRtCeNcYiXRBvPaqZhZ/otr8Z1nZMd9qkj8K
Oq5XWmRmlWT/KFiPu/uuoYLmMbwoCF1H6WeL15P/R2GE87Hsr17U7/CjUHOh
MLRGXU32j8KfP8Hdp5RQ/yKMgvjHjkEfl+WQ/FGYmH1aE3yb9KeMwmflc/v6
92w9HYXZ+WOir++k83Oi4H7M5mKdDdlTFYUOSzaJXj2jfk8dhb17ph7au6GK
5I+C8UWz/kv7Ur3QGIVlvzTjzl9g+79oLPbg33T5QPbRiYbA9pZDDtufc6PR
N8cqaYCU8jMvGpzWK05xsVS/IBpHD/12LE9h8S8ae/oP3Kzn/obkj8b0sdu5
J6V0P2E0PlwbcEr9D+EPEw3JNOOiwcMIX5TR+Ovfuq5kMPHPjMZLswmT7Wso
/+ZEo+b00/f6d1n8i8b7Z/YvX2ZRP6GORtGbc6M/21E9oImGeiz/VFo9xVtj
NAL/LOY7FbD9TwyYpS2FFSuCSP4YqBpD8mbKNpD92+iHrcGjNtE8jxcDk/ta
M5wOsPkpBmYuHX3m3iZ85cfgwe6srTszKF4EMSiKnWQ1ehPpXxiDlRaBLtYr
2PwVg9J5yW7/5FJ9qYxBr6bhkopPaWT/GAzmBjfV15G9c2IQdb550L1nu8n+
MeB8Uq9rXhRL8segmPfMNjxpB8kfAyFPJDphvY/kj8GC/26YFeex+S8Wtq2u
p0V36P46seA0K5tvzyf9cGNhrDPh61tHihdeLPTmHbLvdzCN5I+FycXUsbIe
JC8/FgH8H47lPdh8HYvxn4tjvvUhfxfGQhT5r0HYH5rPMbHQGhZ5sOUu4YGy
7fwh22p0Ddh6Jhb2e/KTH8++S/LHwm1Mml2fXKoPVbH4KF44c/tRotWx0G9N
3/KpiO6jiQXfppanGSUh+WPReB4vL3aRkvwiDEyNPmcmo/yiI8KNwzM+NW0j
f+aK4PhydX1Ff9b/RXgy/bph0DvKzxChd53deMd+5H98EZaNm3Cj0xbCI4EI
h8c8zf47huJNKELVOLnqdhnlK0YEyyGpNldbKP6UIoySHBBEPmX7SRFKPR6Y
nBhBeJAjgkoWIxarIsn/ReiTveNJ12/Ub6hFcC90VFyNu0ryi9BxZvNcXy/C
10YRbJcVHPW7RHjCiYPBk7Uh/SVE68RB681Rl5WnyR+4cejikHtetZ+1fxw+
f9Z+1pHtpxAH3B3mfDeG+gV+HE7tcuku3EDzS0EcDp/OunxCQfYTxoG7RbXc
7hblRyYOzvu7PymoeEryxyHdYlLkViH5R2YcFqQv3JpUT/GRE4fzz4YkHTMh
fFXFwcmlk9mhKfvJ/nHY07DnyffxhD+aOFiFJHw83Jf6r8Y4bDo33ODDSTb+
41H546HM4v4Hkj8evwcd9/zcxNbj8fA7fHj5VQ+aJ/Di0WJs/PbaiUaSPx5W
Brse96rUkP/Hw2Ewjoz+VUP2j8cateGkaYM15P/xKLJ/zassIX0y8VB+f+S8
Op7N//Fw8Rq59McUmjdltt3P8JBDgZLyUU48hkVZnb+3gZ0HxsM78WbwjOE0
v1LHwzp61r8FJ6h/1MRDrw+TYZxN/VhjPHKFqybpm1I+5SQgaN36MwnhVC/o
JOD0ow69D+Ww/p8A4disQYUHSD+8BEz+mbj0twP5BxIwPqz/2SEfaF7DT8AF
94vH6kNIHkECqn1vVWux/itMAGfelCPjrgeT/AmoeVUi9x5VS/GfgAX6K7WE
qdQ/ZSag/E9qvOgD3S8nAV9MEkZ02kC0KgFDiybZ9GHfF9QJcBp59ODaejb/
JyDNfvJNXgH1I40JyPwqesSJU5D/i/Fl/pJuhkp6n9MRQ++/lx6nR5I/ccX4
vPfbgHhrqt95YlSkmirvV7DzCTEUPavtfn+heRxfjLUFEZt7xbD9mhjKSU9W
dVSGkf3FMO6/pGFTFvveI0ZQ1hATo740T1CKMS52M/NPOOWHTDFqLV119/H2
kfxiGHQZ2JrVleRViTEny4Zz7DXhnVqMml+Vd17mkf41YrhF1+aHLqV82ChG
y5QlY7tsonjgJMJHKLTfU0d4oZMIjt2i7Ud3xJL8iYiatGxb1TjCY14i/pR9
69EQqCT5E7H2/btvvOVs/ZcIvOn7aMqeDPL/RFR+09ngqk/zSGEiyhiHfuc9
yL+ZRJjn7Uo2VrH5LxG2i05VyeMIDzIT8dv06ZP9ed/J/xMRanTrb+MkwhNV
IpzcTzQsvkbzWHUiSl3e3PKooP5VkwjB8G+u1+ZQP9yYiIGCV12sQtn6NwnL
W4odB7rRfEUnCeMXywtXT6H6npuE6stlG656k/54STDb2nR1rJSdjyTh8Nb9
P0c5U/zxk+DM7dstiK0vBUnwCNlm0OfuC5I/Ca9NU3b0nP+c/D8JJesL7v0V
kz6USaioNJzNDyD+mUlwtRQuPvSC7puTBPePLbtGvqsn/0+C5avSXS9qvlP8
J0G+6+Zyp2N0niYJtVP3f274h/rXxiRotVzJe3GC9MtJRt+5+c/nRv1L9k/G
2k73eyhbqB/jJqPTzubc7JPkb7xkWD7RTzjIo3klkuGkemUdsIDqTX4yJi/Y
8qfUkZ2XttGVlx4sdqL6RZgM5dV9686aU3/GJKNz+p0N9ZcJP5TJ8NaLKvi7
g+jM5DZ/6/BKLmblT8aJ8o7B+/ez7xHJSE38U2SuTflNnYzrok2+ey2oXtQk
4+Mmiy/+3QifG5Oh03zz38gbNI/nMLjnbliQOZX2azFYq66fqdi6lfTBIDOA
v7HOjOJLj8GCPyXj196kepbLQMvzdMP4uMz2/UYMjGKiqxr3Un7gMSjdJ+q1
XEPvM2YMgsfM/B5SSPUgGMgbjApuetL51m3nD2y26ne+gfyJwfELeQYtN8k/
nRiIZ08zqUolfxQwGDtw35Xt1YSvAQwM+hxp2juc9CNkwJlwdW6/lZbt6yIG
8acVOfopbP3BtMXrbDOHt7J2OoXBwXKPKPEbyhdKBqM0ejbRCwhv0xnYH07Z
2SCg/jmTwT53cfGrM9Q/ZzFIOdPX4qNkO9mLwdWI+n3Np6meKWTQ4vfVxmIb
9U8qBhku44pyy6gfKGUw/PHJKQO1qT5QMxg/wWtxJxXRlW36qddLE52nfljD
QBrAlc77RPqpZcBL3mef0YPqmUYGA7hn1971pHlFCwMf7w5veyVQv8uRoKTj
2KlSZTbZXwLvmuokAcP2wxKsetC7ufEO3U9PAo9Rrc96hlM+4UpgNDejqCiO
+BlJUGzzw+f0VNIHTwID/517WleQf5lJMKJ1it2jznUUPxI0n/1kNHEQzV+s
JVj9U/JkdhLlP74ElrFBoiWjj5H9JVB9DtTcMN1G8SVB2aW93NduNC8IkGBl
2CmjtOnk70IJTt4SJPVZQ/YTSSC3TcJG08dkfwnGtT4+PlNM85EUCaZYXshd
uo7wSylB71u1l+2q6b03XQKu+NX7sjgvwicJXj+f6tnnBn2fJcHxu7NTx06k
fjtHgsXLRnAMLWm+WCjB6e93vnEsad6skmBAaGKLupzioVSCNXtWXJh/kq1n
JGg1tjLYbUjzr0oJvFZNPT+qAztPlKBRtGd7QzLl61oJ7CcXBY5WUnw2SmD6
9KBD71uE/y0SuDoUO/8dSPU7R4qAmfw+idnU72lJkZ+zNOmXNtX7OlLkmX54
mJFD99eToqPexJ36Iyn/c6XYtn7f2y+DKJ8bSRG3ruKpyJb8gSeFSmNyrDSD
6n8zKYweuli/yGbft6QoNCjO3hJH/ZK1FEgp2R1dEUr2l+LRhwdDDW2oXnWS
Yv2Fx7v3zaZ8K5Bi3hXT/mO60HtsgBQ6HlbBteakL6EU6cc3L9q+i+4jksKt
58Nd54Xs+7IUQh+PedP2Ub5IkULvUIKh3XbSj1KKkqjdg+zTyD7pUnReuHJw
Ry7pP7ON30Hf6d/1qb/OksLl6MVOmoO0niNFxP1bc3qbk38UStFBaBadOpx9
n5Kitd5Odsqd7FUqxWizK75b11I9oJbie0/zj5Fdt5D9pbDfHPoxYjIb/238
1+08abiB/Km2jY7Y9MtWQu8DjVJcKnO9fzCT6rEWKQ7O2ary4tB7MEcGkWl1
sfcUel/TkiFv34EefrNovqAjw/t+HQuj91F86Mnwdfsi3azXFN9cGXrvCck0
u0/yG8nA2zCUn7Wf/Jcnw7pFt002HqT4NpOBa5AhCnem+gUyTNxY9OlrAfX7
1jJkaVtMmh1F/PgytEzwst1pL22nnWSoX5TWf0wZzXsFMvQaUdjd9dRrsr8M
s/9U79mpJn5CGYaO7Z6yMJLwXiSD5u7DDkf86H2BkSHjatOiu3LK7yky3Mzd
Yvb2A+lTKYOJznzZhCCyT7oMi+rfyRwnsf2pDG6eP0P6GZJ+s2SYcdyx9uQd
8s8cGaKbPJ3Dt1J/XyhDx+VjxjsIaD6oatP/g7Xpv7I8Cf9lWJu1JdFyJpvP
ZRhzceEh9RHqRyplcBy9pGysF+GxRgahafjG0d3o76NqZXieeO9lvSM772mT
L6enw+3eNE9skUHtd6XhajH5F0eOMpf7TtP/pb/v0pIjy+X39AXF6wn/5XCr
nXHALuQd2V8O7lvfzduf0zyDK8eJ0qcbxpWx+N+2n1kTfzCb5lc8Oax4Vumj
QXhsJkdl+eeiI4UpFP9yNKafWucjI3yxlkOw18/3/h2ab/Pl+GK+90L0xGaK
fzkm8zpPvx1I/ARyWG/raCOxoHlPgByFTJ5LR12q54VyfFp6/vCWEKq/RHJ0
mz9r2qtxbP0th8GiR+nxoYRfKXLULh/7re9dym/KNv2UuDTkxFB+TZfj/ZCh
XU/UfiT7y+H4/vTnLeOoX89qk39QUCfbZVTv58jhvlHPteIT1SuFbfpabbJg
jB77PihH3BWTE5OPEz6WyqGu6bP1XQHNY9RySJON52gVEb5VttkjaPjbwAD2
PVuOgQ9ej7h6hebhtXLIIkNqOrLvuY1ylFdczvp2m/TTIseZ7JHJE6zofZij
gG3/c/m1f6hf0lIg4qB+f+v+VN/qKLAiO8q8pIT8VU+Bvbz3r/pyKZ9wFUgx
H/2nIZH6fSMFjkcO3jQtl+oHngI+6boTZ06h+DJToPrwySZuZ5qPQIE7lSOa
5LNp3VqBsOpKQeYF6g/4CvR6HZoQOo/yr5MCqj9Pz2nzgsn+CswqyS4ziqb6
M0CBjrvfm3WPudtOCxUINtTTHZdM8SRSoNHw4bkJhdS/MQpc2NZ99tkLZJ8U
BUpfKXoWNdO8WqlAnfaLpsDupJ90BSamBX3YJDxF+K+AaGuRwNWF1rPa7hN9
Y2Esh/JVThttKdr/04PmMYUKPBePeNbFch3FvwKLF/R38NpG/U6pArIFeekZ
Rwgv1Aq0Kjknq0QvKf7b9DOhr8eC+dQPaBRt+aBZZbmB4r1WAeP1KzPLvl40
/x9HZoMq
         "]]}, {
        Hue[0.9060679774997897, 0.6, 0.6], 
        Directive[
         PointSize[
          NCache[
           Rational[1, 90], 0.011111111111111112`]], 
         AbsoluteThickness[1.6], 
         RGBColor[1, 0, 0]], 
        LineBox[CompressedData["
1:eJxTTMoPSmViYGCQB2IQDQY/WhzWr5Kv13a7th8i0OoAJBTOqW61B3M5wPyE
3+dPQ+QFwPwD77igfAkwf8H1wp0Q9QpgfkOPZS+ErwGRzzh5HsI3APMdqpwO
QPRbQMx7dXc7hO8A5jOsLDsKUe8BkV/ivwfCD4DoF52wCcKPgMjf+noZwk+A
yB/ihspnQOSld8+E8Asg7tu7pQHCr4Coz1y5HcJvgNhfELMXwu+AqF/mfhDi
vgkQ/kVrqPtmQMzPcOuC8BdAzLO/vgeifgVEfcKRRRD5DZDwCLuzACK/AxK+
QQ+PQ/gHIOobn2+G8E9A3LPffRuEfwHC3xwOjZ8bEP1vPddC5B9A+KkG6yH8
FxD37AveYg8A2Ph7vQ==
         "]]}}}, {}, {}, {}, {}}, {
    DisplayFunction -> Identity, PlotRangePadding -> {{0, 0}, {
        Scaled[0.05], 
        Scaled[0.05]}}, AxesOrigin -> {671.15, 0}, 
     PlotRange -> {{671, 701}, {-1.430873482617145, 1.4190977470601627`}}, 
     PlotRangeClipping -> True, ImagePadding -> All, DisplayFunction -> 
     Identity, AspectRatio -> NCache[GoldenRatio^(-1), 0.6180339887498948], 
     Axes -> {False, False}, AxesLabel -> {None, None}, 
     AxesOrigin -> {671.15, 0}, DisplayFunction :> Identity, 
     Frame -> {{True, True}, {True, True}}, FrameLabel -> {{
        FormBox["\"Res\[IAcute]duos\"", TraditionalForm], None}, {
        FormBox["\"Semanas\"", TraditionalForm], 
        FormBox["\"S\[EAcute]rie Residual\"", TraditionalForm]}}, FrameStyle -> 
     Directive[18, 
       Thickness[Large]], 
     FrameTicks -> {{Automatic, Automatic}, {Automatic, Automatic}}, 
     GridLines -> {None, None}, GridLinesStyle -> Directive[
       GrayLevel[0.5, 0.4]], 
     Method -> {"CoordinatesToolOptions" -> {"DisplayFunction" -> ({
           (Identity[#]& )[
            Part[#, 1]], 
           (Identity[#]& )[
            Part[#, 2]]}& ), "CopiedValueFunction" -> ({
           (Identity[#]& )[
            Part[#, 1]], 
           (Identity[#]& )[
            Part[#, 2]]}& )}}, 
     PlotRange -> {{671, 701}, {-1.430873482617145, 1.4190977470601627`}}, 
     PlotRangeClipping -> True, PlotRangePadding -> {{0, 0}, {
        Scaled[0.05], 
        Scaled[0.05]}}, Ticks -> {Automatic, Automatic}}],FormBox[
    FormBox[
     TemplateBox[{"\"Original\"", "\"Predicted\""}, "LineLegend", 
      DisplayFunction -> (FormBox[
        StyleBox[
         StyleBox[
          PaneBox[
           TagBox[
            GridBox[{{
               TagBox[
                GridBox[{{
                   GraphicsBox[{{
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[1, 5], 0.2]], 
                    AbsoluteThickness[1.6], 
                    RGBColor[0, 0, 1]], {
                    LineBox[{{0, 10}, {20, 10}}]}}, {
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[1, 5], 0.2]], 
                    AbsoluteThickness[1.6], 
                    RGBColor[0, 0, 1]], {}}}, AspectRatio -> Full, 
                    ImageSize -> {20, 10}, PlotRangePadding -> None, 
                    ImagePadding -> Automatic, 
                    BaselinePosition -> (Scaled[0.1] -> Baseline)], #}, {
                   GraphicsBox[{{
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[1, 5], 0.2]], 
                    AbsoluteThickness[1.6], 
                    RGBColor[1, 0, 0]], {
                    LineBox[{{0, 10}, {20, 10}}]}}, {
                    Directive[
                    EdgeForm[
                    Directive[
                    Opacity[0.3], 
                    GrayLevel[0]]], 
                    PointSize[
                    NCache[
                    Rational[1, 5], 0.2]], 
                    AbsoluteThickness[1.6], 
                    RGBColor[1, 0, 0]], {}}}, AspectRatio -> Full, 
                    ImageSize -> {20, 10}, PlotRangePadding -> None, 
                    ImagePadding -> Automatic, 
                    BaselinePosition -> (Scaled[0.1] -> Baseline)], #2}}, 
                 GridBoxAlignment -> {
                  "Columns" -> {Center, Left}, "Rows" -> {{Baseline}}}, 
                 AutoDelete -> False, 
                 GridBoxDividers -> {
                  "Columns" -> {{False}}, "Rows" -> {{False}}}, 
                 GridBoxItemSize -> {"Columns" -> {{All}}, "Rows" -> {{All}}},
                  GridBoxSpacings -> {
                  "Columns" -> {{0.5}}, "Rows" -> {{0.8}}}], "Grid"]}}, 
             GridBoxAlignment -> {"Columns" -> {{Left}}, "Rows" -> {{Top}}}, 
             AutoDelete -> False, 
             GridBoxItemSize -> {
              "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}, 
             GridBoxSpacings -> {"Columns" -> {{1}}, "Rows" -> {{0}}}], 
            "Grid"], Alignment -> Left, AppearanceElements -> None, 
           ImageMargins -> {{5, 5}, {5, 5}}, ImageSizeAction -> 
           "ResizeToFit"], LineIndent -> 0, StripOnInput -> False], {
         FontFamily -> "Arial"}, Background -> Automatic, StripOnInput -> 
         False], TraditionalForm]& ), 
      InterpretationFunction :> (RowBox[{"LineLegend", "[", 
         RowBox[{
           RowBox[{"{", 
             RowBox[{
               RowBox[{"Directive", "[", 
                 RowBox[{
                   RowBox[{"PointSize", "[", 
                    FractionBox["1", "90"], "]"}], ",", 
                   RowBox[{"AbsoluteThickness", "[", "1.6`", "]"}], ",", 
                   InterpretationBox[
                    ButtonBox[
                    TooltipBox[
                    GraphicsBox[{{
                    GrayLevel[0], 
                    RectangleBox[{0, 0}]}, {
                    GrayLevel[0], 
                    RectangleBox[{1, -1}]}, {
                    RGBColor[0, 0, 1], 
                    RectangleBox[{0, -1}, {2, 1}]}}, DefaultBaseStyle -> 
                    "ColorSwatchGraphics", AspectRatio -> 1, Frame -> True, 
                    FrameStyle -> RGBColor[0., 0., 0.6666666666666666], 
                    FrameTicks -> None, PlotRangePadding -> None, ImageSize -> 
                    Dynamic[{
                    Automatic, 
                    1.35 (CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[
                    Magnification])}]], 
                    StyleBox[
                    RowBox[{"RGBColor", "[", 
                    RowBox[{"0", ",", "0", ",", "1"}], "]"}], NumberMarks -> 
                    False]], Appearance -> None, BaseStyle -> {}, 
                    BaselinePosition -> Baseline, DefaultBaseStyle -> {}, 
                    ButtonFunction :> With[{Typeset`box$ = EvaluationBox[]}, 
                    If[
                    Not[
                    AbsoluteCurrentValue["Deployed"]], 
                    SelectionMove[Typeset`box$, All, Expression]; 
                    FrontEnd`Private`$ColorSelectorInitialAlpha = 1; 
                    FrontEnd`Private`$ColorSelectorInitialColor = 
                    RGBColor[0, 0, 1]; 
                    FrontEnd`Private`$ColorSelectorUseMakeBoxes = True; 
                    MathLink`CallFrontEnd[
                    FrontEnd`AttachCell[Typeset`box$, 
                    FrontEndResource["RGBColorValueSelector"], {
                    0, {Left, Bottom}}, {Left, Top}, 
                    "ClosingActions" -> {
                    "SelectionDeparture", "ParentChanged", 
                    "EvaluatorQuit"}]]]], BaseStyle -> Inherited, Evaluator -> 
                    Automatic, Method -> "Preemptive"], 
                    RGBColor[0, 0, 1], Editable -> False, Selectable -> 
                    False]}], "]"}], ",", 
               RowBox[{"Directive", "[", 
                 RowBox[{
                   RowBox[{"PointSize", "[", 
                    FractionBox["1", "90"], "]"}], ",", 
                   RowBox[{"AbsoluteThickness", "[", "1.6`", "]"}], ",", 
                   InterpretationBox[
                    ButtonBox[
                    TooltipBox[
                    GraphicsBox[{{
                    GrayLevel[0], 
                    RectangleBox[{0, 0}]}, {
                    GrayLevel[0], 
                    RectangleBox[{1, -1}]}, {
                    RGBColor[1, 0, 0], 
                    RectangleBox[{0, -1}, {2, 1}]}}, DefaultBaseStyle -> 
                    "ColorSwatchGraphics", AspectRatio -> 1, Frame -> True, 
                    FrameStyle -> RGBColor[0.6666666666666666, 0., 0.], 
                    FrameTicks -> None, PlotRangePadding -> None, ImageSize -> 
                    Dynamic[{
                    Automatic, 
                    1.35 (CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[
                    Magnification])}]], 
                    StyleBox[
                    RowBox[{"RGBColor", "[", 
                    RowBox[{"1", ",", "0", ",", "0"}], "]"}], NumberMarks -> 
                    False]], Appearance -> None, BaseStyle -> {}, 
                    BaselinePosition -> Baseline, DefaultBaseStyle -> {}, 
                    ButtonFunction :> With[{Typeset`box$ = EvaluationBox[]}, 
                    If[
                    Not[
                    AbsoluteCurrentValue["Deployed"]], 
                    SelectionMove[Typeset`box$, All, Expression]; 
                    FrontEnd`Private`$ColorSelectorInitialAlpha = 1; 
                    FrontEnd`Private`$ColorSelectorInitialColor = 
                    RGBColor[1, 0, 0]; 
                    FrontEnd`Private`$ColorSelectorUseMakeBoxes = True; 
                    MathLink`CallFrontEnd[
                    FrontEnd`AttachCell[Typeset`box$, 
                    FrontEndResource["RGBColorValueSelector"], {
                    0, {Left, Bottom}}, {Left, Top}, 
                    "ClosingActions" -> {
                    "SelectionDeparture", "ParentChanged", 
                    "EvaluatorQuit"}]]]], BaseStyle -> Inherited, Evaluator -> 
                    Automatic, Method -> "Preemptive"], 
                    RGBColor[1, 0, 0], Editable -> False, Selectable -> 
                    False]}], "]"}]}], "}"}], ",", 
           RowBox[{"{", 
             RowBox[{#, ",", #2}], "}"}], ",", 
           RowBox[{"LegendMarkers", "\[Rule]", 
             RowBox[{"{", 
               RowBox[{
                 RowBox[{"{", 
                   RowBox[{"False", ",", "Automatic"}], "}"}], ",", 
                 RowBox[{"{", 
                   RowBox[{"False", ",", "Automatic"}], "}"}]}], "}"}]}], ",", 
           RowBox[{"Joined", "\[Rule]", 
             RowBox[{"{", 
               RowBox[{"True", ",", "True"}], "}"}]}], ",", 
           RowBox[{"LabelStyle", "\[Rule]", 
             RowBox[{"{", "}"}]}], ",", 
           RowBox[{"LegendLayout", "\[Rule]", "\"Column\""}]}], "]"}]& ), 
      Editable -> True], TraditionalForm], TraditionalForm]},
  "Legended",
  DisplayFunction->(GridBox[{{
      TagBox[
       ItemBox[
        PaneBox[
         TagBox[#, "SkipImageSizeLevel"], Alignment -> {Center, Baseline}, 
         BaselinePosition -> Baseline], DefaultBaseStyle -> "Labeled"], 
       "SkipImageSizeLevel"], 
      ItemBox[#2, DefaultBaseStyle -> "LabeledLabel"]}}, 
    GridBoxAlignment -> {"Columns" -> {{Center}}, "Rows" -> {{Center}}}, 
    AutoDelete -> False, GridBoxItemSize -> Automatic, 
    BaselinePosition -> {1, 1}]& ),
  Editable->True,
  InterpretationFunction->(RowBox[{"Legended", "[", 
     RowBox[{#, ",", 
       RowBox[{"Placed", "[", 
         RowBox[{#2, ",", "After"}], "]"}]}], "]"}]& )]], "Output",ExpressionU\
UID->"d2641795-8d45-4268-8c83-c09c6af05dad"]
}, Open  ]],

Cell[BoxData[""], "Input",ExpressionUUID->"8db0945a-d9c4-4b68-b089-e46109499f64"]
}, Closed]]
}, Closed]]
}, Open  ]]
},
WindowSize->{1920, 1025},
Visible->True,
ScrollingOptions->{"VerticalScrollRange"->Fit},
ShowCellBracket->Automatic,
Deployed->True,
CellContext->Notebook,
TrackCellChangeTimes->False,
FrontEndVersion->"11.3 for Linux x86 (64-bit) (March 6, 2018)",
StyleDefinitions->"Default.nb"
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[1510, 35, 167, 2, 98, "Title",ExpressionUUID->"3d0bbfab-9b4c-45d3-9b6d-ecd1f5bb6e15"],
Cell[CellGroupData[{
Cell[1702, 41, 143, 2, 72, "Section",ExpressionUUID->"5465f75d-6859-4757-8cd9-a6c12a53561f"],
Cell[1848, 45, 1557, 25, 116, "Text",ExpressionUUID->"9bbaa863-e044-456f-ae44-367c6bf25996"]
}, Closed]],
Cell[CellGroupData[{
Cell[3442, 75, 164, 2, 58, "Section",ExpressionUUID->"180044bb-9101-4fe5-a835-4bd4baa50b7e"],
Cell[CellGroupData[{
Cell[3631, 81, 89, 0, 39, "Subsection",ExpressionUUID->"325d1f03-4999-4eaa-a391-9394f4072b8a"],
Cell[3723, 83, 261, 5, 47, "Text",ExpressionUUID->"17c13414-bf97-415f-a334-fe96993f09a9"],
Cell[3987, 90, 248, 6, 60, "Input",ExpressionUUID->"c4246e9c-bcae-434c-839e-ddc6f775d247"]
}, Closed]],
Cell[CellGroupData[{
Cell[4272, 101, 87, 0, 39, "Subsection",ExpressionUUID->"1051fd06-7d92-4403-b620-f16751f0044d"],
Cell[4362, 103, 261, 5, 47, "Text",ExpressionUUID->"6b0c4719-ca3e-46b1-832a-d5affabb96d3"],
Cell[4626, 110, 994, 27, 147, "Input",ExpressionUUID->"c5856905-1b3d-49d1-bdfc-6be2965f5346"]
}, Closed]],
Cell[CellGroupData[{
Cell[5657, 142, 94, 0, 39, "Subsection",ExpressionUUID->"1b84ed5d-528e-4bac-819c-c26596717725"],
Cell[5754, 144, 177, 2, 47, "Text",ExpressionUUID->"f422922a-8e06-4e17-8e01-b699bdda1b44"],
Cell[5934, 148, 1021, 30, 59, "Input",ExpressionUUID->"dd012333-a602-4421-b142-3896ee7c88c2"]
}, Closed]],
Cell[CellGroupData[{
Cell[6992, 183, 91, 0, 39, "Subsection",ExpressionUUID->"ce0950f7-0389-4063-8690-5ff1c816b13e"],
Cell[7086, 185, 603, 16, 59, "Text",ExpressionUUID->"59addbe1-5e0b-46f1-8927-a01b5e926704"],
Cell[7692, 203, 2160, 55, 274, "Input",ExpressionUUID->"737c7efc-81b5-4340-933b-d8c25ebe5064"]
}, Closed]],
Cell[CellGroupData[{
Cell[9889, 263, 102, 0, 39, "Subsection",ExpressionUUID->"20998a47-f8bd-4d12-9fd5-9cf8ee4164d5"],
Cell[9994, 265, 508, 11, 47, "Text",ExpressionUUID->"098976a9-0d9d-47de-ac72-17412acaa9b2"],
Cell[10505, 278, 1756, 48, 221, "Input",ExpressionUUID->"95aec2da-a36a-4935-b504-d435fb0b383a"]
}, Closed]],
Cell[CellGroupData[{
Cell[12298, 331, 99, 0, 39, "Subsection",ExpressionUUID->"d81e8cbd-4ef8-4fcb-8517-16593285dd09"],
Cell[12400, 333, 2876, 77, 228, "Input",ExpressionUUID->"447ffb96-78c7-4d4b-84ab-f908bcbd347c"]
}, Closed]],
Cell[CellGroupData[{
Cell[15313, 415, 107, 0, 39, "Subsection",ExpressionUUID->"676fdf79-ea05-4fe4-9418-bd61f663c916"],
Cell[15423, 417, 328, 8, 47, "Text",ExpressionUUID->"c27b8df4-4977-4e70-a85b-63e2d858f03d"],
Cell[15754, 427, 3847, 101, 308, "Input",ExpressionUUID->"3946e6eb-015f-421a-a698-840374316c12"]
}, Closed]],
Cell[CellGroupData[{
Cell[19638, 533, 107, 0, 39, "Subsection",ExpressionUUID->"ae46bf8e-020d-4b93-a109-595955df62b7"],
Cell[19748, 535, 974, 35, 70, "Text",ExpressionUUID->"20fbbdbd-aca3-4b74-ae9e-fb09bcc05989"],
Cell[20725, 572, 1626, 43, 124, "Input",ExpressionUUID->"4b935518-970e-41b1-a921-7dec8f056a79"]
}, Closed]],
Cell[CellGroupData[{
Cell[22388, 620, 92, 0, 39, "Subsection",ExpressionUUID->"07afeece-4831-4b83-ba23-2a09056b35f2"],
Cell[22483, 622, 614, 13, 74, "Text",ExpressionUUID->"88185e0f-bd11-411f-8523-26df63409540"],
Cell[23100, 637, 2457, 56, 216, "Input",ExpressionUUID->"78d5c017-ccb4-4af0-add8-05c578036e35"]
}, Open  ]]
}, Closed]],
Cell[CellGroupData[{
Cell[25606, 699, 143, 2, 58, "Section",ExpressionUUID->"45b8bd69-cfe6-47db-8554-8ec24e031287"],
Cell[CellGroupData[{
Cell[25774, 705, 124, 0, 39, "Subsection",ExpressionUUID->"007d137f-9a78-40d5-ade9-586848744b14"],
Cell[25901, 707, 419, 7, 47, "Text",ExpressionUUID->"8929fa79-dc4c-405f-b029-34c2ee5b4f57"],
Cell[26323, 716, 892, 24, 55, "Input",ExpressionUUID->"e865170a-bb77-4acf-addd-084cf53eb056"],
Cell[27218, 742, 1077, 17, 97, "Text",ExpressionUUID->"f05e6667-a491-4735-a931-7eba453c69ea"],
Cell[CellGroupData[{
Cell[28320, 763, 2040, 52, 146, "Input",ExpressionUUID->"12084e41-e485-4332-b98f-23be4f7ad43b"],
Cell[30363, 817, 26284, 467, 411, "Output",ExpressionUUID->"383a2972-ba69-4d74-acb7-81aaeaea14a7"]
}, Open  ]],
Cell[56662, 1287, 654, 10, 74, "Text",ExpressionUUID->"49ef5300-1835-4895-8cd6-63144ae473cc"],
Cell[CellGroupData[{
Cell[57341, 1301, 2560, 66, 124, "Input",ExpressionUUID->"c07090bb-0d33-4d68-8300-5a5d6af17869"],
Cell[59904, 1369, 35302, 626, 384, "Output",ExpressionUUID->"1b5c5a26-3d2a-480c-8406-87f77017781a"]
}, Open  ]],
Cell[95221, 1998, 441, 8, 51, "Text",ExpressionUUID->"ffd907e4-60df-400d-a319-22c984ef1902"],
Cell[CellGroupData[{
Cell[95687, 2010, 3502, 91, 193, "Input",ExpressionUUID->"6cb81fc6-82e5-48d5-878b-5455ee7f6f31"],
Cell[99192, 2103, 25457, 450, 403, "Output",ExpressionUUID->"48b2c333-d5ad-43c4-8fa3-a2cb8f45575e"],
Cell[124652, 2555, 25468, 450, 403, "Output",ExpressionUUID->"6dd5d7f1-a7e1-49a6-a17e-4492c1c54279"]
}, Open  ]],
Cell[150135, 3008, 768, 12, 74, "Text",ExpressionUUID->"35627877-54fd-467a-9150-8a2b2615e118"],
Cell[CellGroupData[{
Cell[150928, 3024, 4024, 109, 155, "Input",ExpressionUUID->"bacece00-d67d-4581-ae1b-c96b7cf3d853"],
Cell[154955, 3135, 138035, 2050, 368, "Output",ExpressionUUID->"e7faeb6d-947a-4981-9f75-6fac7af0cc3c"]
}, Open  ]],
Cell[293005, 5188, 1413, 24, 132, "Text",ExpressionUUID->"c1857bb8-1253-4a2d-b5ef-bad1d4c013bb"],
Cell[294421, 5214, 885, 23, 147, "Input",ExpressionUUID->"66f15b18-6691-4ef3-badd-812b85c27364"],
Cell[295309, 5239, 641, 21, 51, "Text",ExpressionUUID->"f3787f1d-64e7-4287-92dc-0fe2f5b2dc5b"],
Cell[CellGroupData[{
Cell[295975, 5264, 146, 2, 31, "Input",ExpressionUUID->"9455a642-ef74-4aae-8a75-6ea089b8a2a5"],
Cell[296124, 5268, 29203, 515, 220, "Output",ExpressionUUID->"75cfb6e1-c67f-4923-9213-6554c7a75cf2"]
}, Open  ]],
Cell[325342, 5786, 976, 22, 97, "Text",ExpressionUUID->"226f6c5b-3b0c-48da-8e24-0c96330dc8de"],
Cell[CellGroupData[{
Cell[326343, 5812, 2954, 83, 147, "Input",ExpressionUUID->"318c9a37-d3b5-4216-a5ac-e97bc832d4ab"],
Cell[329300, 5897, 26052, 490, 315, "Output",ExpressionUUID->"b11e024a-387b-49ff-8710-148c2abf770a"]
}, Open  ]],
Cell[355367, 6390, 482, 8, 74, "Text",ExpressionUUID->"48efee99-2695-4a3f-ba37-1019fcfe4449"]
}, Closed]],
Cell[CellGroupData[{
Cell[355886, 6403, 129, 0, 39, "Subsection",ExpressionUUID->"82e3e2ff-848c-4b62-bbdc-b28753b12867"],
Cell[356018, 6405, 683, 13, 70, "Text",ExpressionUUID->"8f4eb3c9-0137-42e9-9217-7ad3ae66b84f"],
Cell[356704, 6420, 23604, 313, 1918, "Input",ExpressionUUID->"9f33aafe-db7c-4cee-8578-4273bae26b81"],
Cell[CellGroupData[{
Cell[380333, 6737, 796, 22, 31, "Input",ExpressionUUID->"a1ab81cd-62a0-4f55-9fc2-04a1a59f4fb2"],
Cell[381132, 6761, 12811, 227, 511, "Output",ExpressionUUID->"74f1c397-f37e-4950-af30-00693442515e"]
}, Open  ]],
Cell[393958, 6991, 278, 6, 51, "Text",ExpressionUUID->"2e4157f5-2327-43c4-a224-b44d3da95701"],
Cell[394239, 6999, 306, 7, 31, "Input",ExpressionUUID->"319be279-e644-4bdf-8d12-20aec74ecc37"],
Cell[394548, 7008, 807, 21, 78, "Input",ExpressionUUID->"feec0665-5635-4c56-899a-b961a8d5db36"],
Cell[CellGroupData[{
Cell[395380, 7033, 8837, 220, 272, "Input",ExpressionUUID->"9a0cff71-a904-429f-8c54-2220d751c5df"],
Cell[404220, 7255, 120500, 2034, 895, "Output",ExpressionUUID->"e39acac3-ccfe-40f3-b13c-bd5845deadfe"]
}, Open  ]],
Cell[524735, 9292, 422, 7, 51, "Text",ExpressionUUID->"1dc9167c-ebd9-47b4-bb81-b8104c9b4043"],
Cell[525160, 9301, 931, 23, 147, "Input",ExpressionUUID->"e84887c5-2179-437c-9bc5-2bd771e36d6b"],
Cell[526094, 9326, 656, 13, 74, "Text",ExpressionUUID->"5963fdba-9359-4eb3-8a22-e5c5c2ceaa9d"],
Cell[CellGroupData[{
Cell[526775, 9343, 3015, 82, 147, "Input",ExpressionUUID->"0dd5814d-f098-4514-9c2e-ce21d5e73947"],
Cell[529793, 9427, 24893, 470, 280, "Output",ExpressionUUID->"256da71f-da41-47e7-a6d0-3f77b5429eaf"]
}, Open  ]],
Cell[554701, 9900, 691, 13, 74, "Text",ExpressionUUID->"d212609d-4439-4008-af01-355914ddf708"],
Cell[CellGroupData[{
Cell[555417, 9917, 3414, 100, 147, "Input",ExpressionUUID->"8dceed8a-3127-4657-851f-821b6a23aeaa"],
Cell[558834, 10019, 25413, 479, 240, "Output",ExpressionUUID->"6c53fd32-7825-4dcd-ab2b-9e5c8a226d70"]
}, Open  ]],
Cell[584262, 10501, 335, 6, 51, "Text",ExpressionUUID->"e4af45b8-8ee0-4852-a04f-1ba1476b7d94"]
}, Closed]],
Cell[CellGroupData[{
Cell[584634, 10512, 200, 3, 39, "Subsection",ExpressionUUID->"5c0a65e1-819b-4a70-b852-b4bd4193db6d"],
Cell[584837, 10517, 899, 18, 70, "Text",ExpressionUUID->"5366c595-f729-4eae-baa1-4838c37514b6"],
Cell[585739, 10537, 12717, 186, 791, "Input",ExpressionUUID->"19122dd2-2cee-4cd2-98c1-f5d8e2bb63eb"],
Cell[CellGroupData[{
Cell[598481, 10727, 706, 19, 31, "Input",ExpressionUUID->"2daa116e-d11c-4828-9247-7590b4c741ae"],
Cell[599190, 10748, 6585, 127, 610, "Output",ExpressionUUID->"90b9febe-0b54-4818-9654-b1d0110ac64a"]
}, Open  ]],
Cell[605790, 10878, 540, 10, 74, "Text",ExpressionUUID->"e9aebbdb-6b25-4edc-ba12-81dcf540cb9f"],
Cell[606333, 10890, 789, 21, 78, "Input",ExpressionUUID->"34a3686b-63dd-43ca-a47e-d7b51c40221e"],
Cell[CellGroupData[{
Cell[607147, 10915, 9249, 234, 272, "Input",ExpressionUUID->"bd09cfec-43a8-4c34-b00b-6b2b9420c0f2"],
Cell[616399, 11151, 162422, 2633, 1037, "Output",ExpressionUUID->"14d70f2e-8c0d-44b2-9498-96a5ba7d8e6d"]
}, Open  ]],
Cell[778836, 13787, 299, 8, 51, "Text",ExpressionUUID->"582542d5-3d09-4f09-a8f9-10631686b2cd"],
Cell[779138, 13797, 915, 23, 147, "Input",ExpressionUUID->"c449863c-d0ce-4fa8-b200-4c35e63dd961"],
Cell[780056, 13822, 756, 16, 74, "Text",ExpressionUUID->"50108667-9876-44d9-870d-e1cc3f9b83d3"],
Cell[CellGroupData[{
Cell[780837, 13842, 3005, 83, 147, "Input",ExpressionUUID->"bc735e57-d721-4689-87b8-77fa1c537069"],
Cell[783845, 13927, 22395, 430, 283, "Output",ExpressionUUID->"d2641795-8d45-4268-8c83-c09c6af05dad"]
}, Open  ]],
Cell[806255, 14360, 81, 0, 31, "Input",ExpressionUUID->"8db0945a-d9c4-4b68-b089-e46109499f64"]
}, Closed]]
}, Closed]]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature wu0gRA@yK9DRLDgyx@9mRWkS *)

# Mathematica_Time_Series_Prediction

Previsão do Custo Marginal de Operação (CMO) da comercialização de energia elétrica no mercado livre brasileiro.

Modelo de previsão do CMO é feito com combinação de análise "clássica" se séries temporais (i.e. decomposição da série histórica em soma de série linear e séries senoidais) com previsão de não linearidades e resíduos através de aprendizado de máquina. 

Além disso, modelo usa diversas outras séries históricas como séries de apoio, e.g. níveis de dezenas de reservatórios de usinas hidrelétricas, geração total de energia termoelétrica no país, demanda de consumo por subsistema de energia, etc. Todas essas séries passam pela mesmo pré-processamento e previsão que a série principal.

São executados 8 modelos de redes neurais para cada série temporal. Resultado final de previsão é feito através de médias ponderadas com pesos adaptativos para cada uma das 8 redes neurais da série principal, CMO.

Resultado final de previsão é estatisticamente superior aos modelos computacionais NEWAVE / DECOMP, usados pelo ONS para determinar o Preço de Liquidações Diárias (PLD) cada semana.

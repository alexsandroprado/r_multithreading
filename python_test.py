import matplotlib.pyplot as plt
ano     = ['2020' ,'2021', '2022','2023']
lucro   = [45000 ,42000, 52000, 49000]
cores   = ['green' ,'blue', 'purple','teal']



plt.bar(ano, lucro, color = cores)
plt.title('Lucro Líquido Petrobras')
plt.xlabel('Ano')
plt.ylabel ('Lucro')
plt.show()

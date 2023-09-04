import pandas
import iris
import matplotlib.pyplot as plt

def build_dataframe() -> pandas.DataFrame:
    conn = iris.connect(hostname='localhost', port=1972, namespace='UKI-PYTHON-DEV', username='_SYSTEM', password='sys')

    cursor = conn.cursor()
    cursor.execute("""
                    SELECT DescriptionD->DescriptionD, AVG(AVGValueM), YearD 
                    FROM Demo_Cube_Observations.Fact
                    GROUP BY DescriptionD->DescriptionD, YearD
                    """)
    
    df = pandas.DataFrame(cursor.fetchall())
    cursor.close()
    conn.commit()

    df = df.rename(columns = {0:'Description', 1:'Average', 2:'Year'})
    return df

def plot_dataframe(df: pandas.DataFrame):
    fig, ax = plt.subplots()

    for key, group in df.groupby(['Description']):
        ax = group.plot(ax=ax, kind='line', x='Year', y='Average', label=key)

    plt.legend(loc='best')
    plt.show()
    
if __name__ == "__main__":
    df = build_dataframe()
    plot_dataframe(df)
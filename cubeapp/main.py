import pandas
import iris
import matplotlib.pyplot as plt

def build_dataframe() -> pandas.DataFrame:
    conn = iris.connect(hostname='localhost', port=1972, namespace='UKI-PYTHON-DEV', username='_SYSTEM', password='SYS')

    cursor = conn.cursor()
    cursor.execute("""
                    SELECT DescriptionD->DescriptionD, AVG(AVGValueM), YearD, UnitsD->UnitsD
                    FROM Demo_Cube_Observations.Fact
                    GROUP BY DescriptionD->DescriptionD, YearD
                    """)
    
    df = pandas.DataFrame(cursor.fetchall())
    cursor.close()
    conn.commit()

    df = df.rename(columns = {0:'Description', 1:'Average', 2:'Year', 3:'Units'})
    return df

def plot_dataframe(df: pandas.DataFrame):
    key_list = [
                'Body Mass Index', 
                'Body Mass Index Bmi [Percentile] Per Age And Gender',
                'Body Weight',
                'Body Height'
                ]

    fig, ax = plt.subplots()

    for key, group in df.groupby(['Description']):
        key = clean_tuple(key)
        if key in key_list:
            ax = group.plot(ax=ax, kind='line', x='Year', y='Average', label=key)
        else:
            pass

    plt.legend()
    plt.show()

def clean_tuple(key: tuple) -> str:
    return str(key).replace("(","").replace(")","").replace(",","").replace("'","").title()

if __name__ == "__main__":
    df = build_dataframe()
    plot_dataframe(df)
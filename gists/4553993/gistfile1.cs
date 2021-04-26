[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1002:DoNotExposeGenericLists")]
public static void RemoveAll<T>(this List<T> list, Func<T, bool> filter)
{
    if (list == null) throw new ArgumentNullException("list");
    if (filter == null) throw new ArgumentNullException("filter");
    for (int i = 0; i < list.Count; i++)
    {
        if (filter(list[i]))
        {
            list.Remove(list[i]);
        }
    }
}
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;

namespace GenerateVBARedirects
{
    class Program
    {
        static void Main(string[] args)
        {
            string sourceRepoLocation = @"D:\repos\VBA-content";
            string targetRepoLocation = @"D:\repos\VBA-Docs";

            FileStream ostrm;
            StreamWriter writer;
            TextWriter oldOut = Console.Out;
            try
            {
                ostrm = new FileStream(@"D:\report.txt", FileMode.OpenOrCreate, FileAccess.Write);
                writer = new StreamWriter(ostrm);
            }
            catch (Exception e)
            {
                Console.WriteLine("Cannot open Redirect.txt for writing");
                Console.WriteLine(e.Message);
                return;
            }
            Console.SetOut(writer);

            Console.WriteLine("Creating legacy mapping...");
            var legacyMap = GetFileMap(sourceRepoLocation);
            Console.WriteLine("Creating new mapping...");
            var newMap = GetFileMap(targetRepoLocation);

            var mapString = GenerateRedirects(legacyMap, newMap);
            File.WriteAllText(@"D:\redirection.json", mapString);

            Console.SetOut(oldOut);
            writer.Close();
            ostrm.Close();
            Console.WriteLine("Done");

            Console.ReadKey();
        }

        private static string GenerateRedirects(Dictionary<string, string> legacyMap, Dictionary<string, string> newMap)
        {
            var unmapped = legacyMap.Keys.Except(newMap.Keys).Concat(newMap.Keys.Except(legacyMap.Keys));

            foreach(var key in unmapped)
            {
                Console.WriteLine("Could not match asset ID from old to new repo: " + key);
            }

            var redirectionString = "{\"redirections\": [";

            var matchingKeys = legacyMap.Keys.Intersect(newMap.Keys);
            foreach(var matchingKey in matchingKeys)
            {
                var redirectionEntity = "{\"redirect_url\":\"" + "https://docs.microsoft.com/en-us/office/vba" + newMap[matchingKey].Replace("\\", "/").Replace(".md", string.Empty) + "\", \"source_path\": \"" + legacyMap[matchingKey].Replace("\\", "/") + "\"},";

                redirectionString += redirectionEntity;
            }

            redirectionString += "]}";

            return redirectionString;
        }

        static Dictionary<string,string> GetFileMap(string location)
        {
            var map = new Dictionary<string, string>();
            var markdownFiles = Directory.GetFiles(location, "*.md", SearchOption.AllDirectories);
            foreach (var markdownFile in markdownFiles)
            {
                var content = File.ReadAllText(markdownFile);
                Regex regex = new Regex("ms.assetid: [a-zA-Z0-9-]+");
                var matches = regex.Matches(content);

                if (matches.Count > 0)
                {
                    var match = Guid.Parse(matches[0].Value.ToLower().Replace("ms.assetid:", string.Empty));

                    try
                    {
                        map.Add(match.ToString(), markdownFile.Replace(location, string.Empty));

                        Console.WriteLine("Mapped asset ID: " + match.ToString());
                    }
                    catch (ArgumentException e)
                    {
                        Console.WriteLine("Duplicate asset ID: " + match);
                    }
                }
                else
                {
                    Console.WriteLine("No asset ID for: " + markdownFile);
                }
            }

            return map;
        }
    }
}

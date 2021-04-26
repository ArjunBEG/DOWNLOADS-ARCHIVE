public class Program
{
    static void Main(string[] args)
    {
        Task.Run(async () => { await ExecuteRunner(); }).GetAwaiter().GetResult();
    }

    public static async Task<bool> ExecuteRunner()
    {
        for (int i = 0; i < 583; i++)
        {
            var guidString = Guid.NewGuid().ToString();

            var signupValues = new Dictionary<string, string>
            {
               { "signup[email]", guidString },
               { "signup[share_hash]", "SOME_HASH_DUH" },
               { "subscribe", "" }
            };

            using (var client = new HttpClient())
            {

                var content = new FormUrlEncodedContent(signupValues);

                var response = await client.PostAsync("https://apply.getfinal.com/signups", content);

                var responseString = await response.Content.ReadAsStringAsync();

                Console.WriteLine($"Executed request {i} - {responseString}");
            }
        }

        return false;
    }
}
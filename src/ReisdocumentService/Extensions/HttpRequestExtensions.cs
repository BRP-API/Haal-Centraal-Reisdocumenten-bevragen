using System.IO.Compression;

namespace HaalCentraal.ReisdocumentService.Extensions;

public static class HttpRequestExtensions
{
    public static async Task<string> ReadBodyAsync(this HttpRequest request)
    {
        if (!request.Body.CanSeek)
        {
            request.EnableBuffering();
        }

        try
        {
            if (request.Headers.ContentEncoding.Contains("gzip"))
            {
                return await ReadCompressedBodyAsync(request);
            }
            else
            {
                return await ReadUncompressedBodyAsync(request);
            }
        }
        catch (InvalidDataException)
        {
            return await ReadUncompressedBodyAsync(request);
        }
    }

    private static async Task<string> ReadCompressedBodyAsync(this HttpRequest request)
    {

        try
        {
            request.Body.Seek(0, SeekOrigin.Begin);

            var gzipStream = new GZipStream(request.Body, CompressionMode.Decompress);
            StreamReader streamReader = new(gzipStream, leaveOpen: true);

            return await streamReader.ReadToEndAsync();
        }
        finally
        {
            request.Body.Seek(0, SeekOrigin.Begin);
        }

    }

    private static async Task<string> ReadUncompressedBodyAsync(this HttpRequest request)
    {
        try
        {
            request.Body.Seek(0, SeekOrigin.Begin);

            StreamReader streamReader = new(request.Body, leaveOpen: true);

            return await streamReader.ReadToEndAsync();
        }
        finally
        {
            request.Body.Seek(0, SeekOrigin.Begin);
        }
    }
}

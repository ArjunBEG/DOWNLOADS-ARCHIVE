
namespace config {
    const run: boolean
    const system: {
        cwd: string;
    };
    const required: boolean
    const dirs: string[];
    const timeout: number;
    const options: {[key: string]: any};
    const command: {
        raw: { executable: string, args: string[] };
        string: string;
    } | undefined;

    function load(settings: Settings, ready: (config: typeof nodemon.config) => void): void;

    function reset(): void;
}
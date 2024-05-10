import process from "node:process";
import type { Config } from "drizzle-kit";

export default {
    dialect: "postgresql",
    schema: "./node_modules/@nezuchan/schema/dist/index.js",
    out: "./drizzle",
    dbCredentials: {
        url: process.env.DATABASE_URL!
    }
} satisfies Config;

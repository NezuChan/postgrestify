DO $$ BEGIN
 CREATE TYPE "TierType" AS ENUM('FREE', 'SUPPORTER', 'TIER_1', 'TIER_2', 'TIER_3');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "activation_key" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tier" "TierType" DEFAULT 'FREE',
	"provider" text,
	"guild_id" uuid,
	"client_id" text,
	"start_at" timestamp,
	"ends_at" timestamp,
	"key" text,
	"user_id" uuid,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "crossfade" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"guild_id" uuid,
	"client_id" text,
	"activated_by" text,
	"state" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "default_volume" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"guild_id" uuid,
	"client_id" text,
	"activated_by" text,
	"state" integer DEFAULT 100,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "guild" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"guild_id" text,
	"client_id" text,
	"key_id" text,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "stay_in_vc" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"guild_id" uuid,
	"client_id" text,
	"activated_by" text,
	"state" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"email" text,
	"discord_id" text,
	"patreon_id" text,
	"premium_provider" text DEFAULT 'UNKNOWN',
	"premium_tier" "TierType" DEFAULT 'FREE',
	"premium_start_at" timestamp DEFAULT now(),
	"premium_ends_at" timestamp,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp NOT NULL,
	"voted_at" timestamp,
	CONSTRAINT "user_discord_id_unique" UNIQUE("discord_id"),
	CONSTRAINT "user_patreon_id_unique" UNIQUE("patreon_id")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "activation_key" ADD CONSTRAINT "activation_key_guild_id_guild_id_fk" FOREIGN KEY ("guild_id") REFERENCES "guild"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "activation_key" ADD CONSTRAINT "activation_key_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "crossfade" ADD CONSTRAINT "crossfade_guild_id_guild_id_fk" FOREIGN KEY ("guild_id") REFERENCES "guild"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "default_volume" ADD CONSTRAINT "default_volume_guild_id_guild_id_fk" FOREIGN KEY ("guild_id") REFERENCES "guild"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "stay_in_vc" ADD CONSTRAINT "stay_in_vc_guild_id_guild_id_fk" FOREIGN KEY ("guild_id") REFERENCES "guild"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

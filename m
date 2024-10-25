Return-Path: <linux-arch+bounces-8557-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED599B0E4C
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881191F25A1D
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 19:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ECE214435;
	Fri, 25 Oct 2024 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewf3k1fN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EBB214424;
	Fri, 25 Oct 2024 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883746; cv=none; b=F9ijFvDhO0yqykLLk5UUZjT4OlUj3D5BSTx/Bl1EIZjqgn0VRqOpMh+kIaV02ELUzM+Hev4to8xcAqeaGu1Z59n9G51q6ezQp1KV51qs9tzMZHXv2ta0swLT/E7f/jpWIMy8JaUE37M0i5SeHJiCd977JS+wOnhj8i/TgA+b0lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883746; c=relaxed/simple;
	bh=3ki30lOxrwcmmFT8r/BxBSIWiIgjCokra374LPFdTjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VE8dOybd1MQqzZHZZf7JnxGClcsqO2WHfdLrU/GI//dyfT2XruZ3cZS8VRt81WG+SweF3f0dwtGbSot5zvIPHy6kILAY3tRk4oqJ8pKsuTSdIIkq50/HJVRKFJ8WXZ1/lONMaOwyrvAkKmHaEg436GRP7BX688nzB3ApInxQSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewf3k1fN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CA0C4CEF7;
	Fri, 25 Oct 2024 19:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729883746;
	bh=3ki30lOxrwcmmFT8r/BxBSIWiIgjCokra374LPFdTjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ewf3k1fN8FI5lfS/6w9IFwZ4u6hVpP/Fl0POKQECBxh2jBWAZpuVIzIUxSZROAKf6
	 BUjn6UW1aFHZHkDdHUd8K46PyIbTrfUHoQVAnyt5ocYS8KAIh7w0dqiIdNyUqxzRXs
	 zyainnf7I542RMLlffmEuRba9rENa8Z7OkVP+DX2ya/xa1MGrdlZVjVq8FQzNJyl/h
	 Mm4tHBFwbQvF4SL1U7JRODcZQsniEHUJfOY3PW1AS/6iECR/HXamD+XEIRJ5Ey1leg
	 3njI7/DQzTwoOyYlyv6Cw/CUe395fJjoiHorj8UnmtJB+th3baQAp1wmJhGKSKDPWV
	 wa1UzKFgR/x5g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 04/18] crypto: crc32 - don't unnecessarily register arch algorithms
Date: Fri, 25 Oct 2024 12:14:40 -0700
Message-ID: <20241025191454.72616-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025191454.72616-1-ebiggers@kernel.org>
References: <20241025191454.72616-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Instead of registering the crc32-$arch and crc32c-$arch algorithms if
the arch-specific code was built, only register them when that code was
built *and* is not falling back to the base implementation at runtime.

This avoids confusing users like btrfs which checks the shash driver
name to determine whether it is crc32c-generic.

(It would also make sense to change btrfs to test the crc32_optimization
flags itself, so that it doesn't have to use the weird hack of parsing
the driver name.  This change still makes sense either way though.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/crc32_generic.c  | 8 ++++++--
 crypto/crc32c_generic.c | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/crypto/crc32_generic.c b/crypto/crc32_generic.c
index cc064ea8240e..cecd01e4d6e6 100644
--- a/crypto/crc32_generic.c
+++ b/crypto/crc32_generic.c
@@ -155,19 +155,23 @@ static struct shash_alg algs[] = {{
 	.base.cra_ctxsize	= sizeof(u32),
 	.base.cra_module	= THIS_MODULE,
 	.base.cra_init		= crc32_cra_init,
 }};
 
+static int num_algs;
+
 static int __init crc32_mod_init(void)
 {
 	/* register the arch flavor only if it differs from the generic one */
-	return crypto_register_shashes(algs, 1 + IS_ENABLED(CONFIG_CRC32_ARCH));
+	num_algs = 1 + ((crc32_optimizations & CRC32_LE_OPTIMIZATION) != 0);
+
+	return crypto_register_shashes(algs, num_algs);
 }
 
 static void __exit crc32_mod_fini(void)
 {
-	crypto_unregister_shashes(algs, 1 + IS_ENABLED(CONFIG_CRC32_ARCH));
+	crypto_unregister_shashes(algs, num_algs);
 }
 
 subsys_initcall(crc32_mod_init);
 module_exit(crc32_mod_fini);
 
diff --git a/crypto/crc32c_generic.c b/crypto/crc32c_generic.c
index 04b03d825cf4..47d694da9d4a 100644
--- a/crypto/crc32c_generic.c
+++ b/crypto/crc32c_generic.c
@@ -195,19 +195,23 @@ static struct shash_alg algs[] = {{
 	.base.cra_ctxsize	= sizeof(struct chksum_ctx),
 	.base.cra_module	= THIS_MODULE,
 	.base.cra_init		= crc32c_cra_init,
 }};
 
+static int num_algs;
+
 static int __init crc32c_mod_init(void)
 {
 	/* register the arch flavor only if it differs from the generic one */
-	return crypto_register_shashes(algs, 1 + IS_ENABLED(CONFIG_CRC32_ARCH));
+	num_algs = 1 + ((crc32_optimizations & CRC32C_OPTIMIZATION) != 0);
+
+	return crypto_register_shashes(algs, num_algs);
 }
 
 static void __exit crc32c_mod_fini(void)
 {
-	crypto_unregister_shashes(algs, 1 + IS_ENABLED(CONFIG_CRC32_ARCH));
+	crypto_unregister_shashes(algs, num_algs);
 }
 
 subsys_initcall(crc32c_mod_init);
 module_exit(crc32c_mod_fini);
 
-- 
2.47.0



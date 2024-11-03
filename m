Return-Path: <linux-arch+bounces-8812-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC89BA8BD
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 23:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03381C20D9C
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 22:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51ED19069B;
	Sun,  3 Nov 2024 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLEXF5On"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2718E055;
	Sun,  3 Nov 2024 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730673146; cv=none; b=WKlnxRrnG1+XulUDgmtOAP9iJv+/BcRKwvAm80PSmzwNiN/Yfr+UGMhx5sxa/aKUc+yGTuN8naUAOGIihKiN5Ebdocp46pmQOjZCKJe6Zog1Y3t+9jb1JVCsCGjm/zbWfK+al58kjP6bK5FurIkVhPhq+rrSCLKigSIlQXDGCak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730673146; c=relaxed/simple;
	bh=tFO0F6yNPt11cX0x9fLuUHzrKqGkpHig/cPtPasc7Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lheSrq4TaYfcmJvCF3Yi7+AgndXiRu60TpsD1Oelzkb9l84i57mBwZ13oQf7n+iqVQqgretF8uoE/8CNMiS2H2TEN3ZATxMVSuX1gt9AX7P4r2nbAqCt8rYDAOaWRNYGMY1q0ktDv3WdJMZnQuTbQuu3/u+NWV5gQtCQAKnfTPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLEXF5On; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3C1C4CED6;
	Sun,  3 Nov 2024 22:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730673146;
	bh=tFO0F6yNPt11cX0x9fLuUHzrKqGkpHig/cPtPasc7Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FLEXF5OnjtoHBLz2W1SudB1KfgQeNbVamfWQca0Lr3ls4Ajd6zui8pPZphDG8wGHi
	 LMeOxQgpUfQZBOrr9Xxbh82UmIw4KF07FJGWQHV31qEzfhzAW4QITRvihj6T8dNJwD
	 7VM4SISyDF+9nWY8v1TcdePZO8vlrUSxuR0C2sAycL5JfMzno08WrlDBIWB428LYwV
	 H74oQ1WRR+qGqF2fzD79IPcenVru6oQPFG/aiSVpU1viylHUP1PVVW0SlpHWBah85+
	 GLRmjZ4czJdS+k2WUI0O0AY7XjAnn6mserV11No6DhCIo1gKixC/7dgNgepAp/Vyod
	 VKf8STCElVs0g==
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
Subject: [PATCH v3 04/18] crypto: crc32 - don't unnecessarily register arch algorithms
Date: Sun,  3 Nov 2024 14:31:40 -0800
Message-ID: <20241103223154.136127-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103223154.136127-1-ebiggers@kernel.org>
References: <20241103223154.136127-1-ebiggers@kernel.org>
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
index cc064ea8240e..783a30b27398 100644
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
+	num_algs = 1 + ((crc32_optimizations() & CRC32_LE_OPTIMIZATION) != 0);
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
index 04b03d825cf4..985da981d6e2 100644
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
+	num_algs = 1 + ((crc32_optimizations() & CRC32C_OPTIMIZATION) != 0);
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



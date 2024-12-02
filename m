Return-Path: <linux-arch+bounces-9202-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F0B9DF7C6
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 02:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC03B21A74
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 01:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB89539FF3;
	Mon,  2 Dec 2024 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGM9dNbD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABC12B9A2;
	Mon,  2 Dec 2024 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101771; cv=none; b=qsYH5NTpvDoj0sEmAxNKF3vZ4HqzNb+5aNELfdRV//zLSExqga7HwjDkg938xZ5niGLcckublJ65/gqBhaCozn444D+efX0bUp8F62CkpHfdklOOkyQTg9uVUAc1yIqBRnXixmwqvYgAC8sbIZjWX9M71uwpMZdm598QGYnQSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101771; c=relaxed/simple;
	bh=DVqvOO2dJ7B48PDR0q3vBCSu5cpkFSQ2aUVnhv21TuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jykKcNxYSqwNmTvFLU+6r4t525jhnsIXFa1qAK5ZXK4VIOn+JUk5lOvH5/NaDjbQHkUqQey1jDMGZeJSPpLr2IOyKIOBY30GV7poHL0MWA1Oj5sFrlBBjz4DLF7lh9wXKoB7PY5vigvK+ciagCsdLtC7lINFpGhhUrU7iSgK3xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGM9dNbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15699C4CECF;
	Mon,  2 Dec 2024 01:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733101771;
	bh=DVqvOO2dJ7B48PDR0q3vBCSu5cpkFSQ2aUVnhv21TuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGM9dNbDkh4kjxMlwvZZjcvmXWpivnf2zwumF4df0QwxFTWShfeo1b1l4dM+4cMC0
	 0O4fJ09RULF4/7nmCnxfh2b/ZGewuvBOcKYIM5WPwmv5/gXQswd1kfZkisK7vbq3rW
	 7qbZkRhEISePyJuoNrM4aAQp8ldMOUF4B9CBktrLsShhKV9/k+kgzzRmNUJv/cAeTz
	 7j3jVn9pZEbDxLj1PXTuXJodfecl7S6TkuMuWc4zXFPFXTET+zaWRzMa1xEnOAvrjv
	 mLJOJYbwEio7E3J8J0Aj1rk9I4xquqen8dZa2LAnP6fynOpUK9ooR7gX7coIDkXlKy
	 ziqjQEXHR/6Bw==
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
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 04/19] crypto: crc32 - don't unnecessarily register arch algorithms
Date: Sun,  1 Dec 2024 17:08:29 -0800
Message-ID: <20241202010844.144356-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241202010844.144356-1-ebiggers@kernel.org>
References: <20241202010844.144356-1-ebiggers@kernel.org>
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

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
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
2.47.1



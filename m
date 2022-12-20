Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC820651A51
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 06:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiLTFmD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 00:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiLTFmC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 00:42:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701AA10B56;
        Mon, 19 Dec 2022 21:42:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 099F561284;
        Tue, 20 Dec 2022 05:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3059AC433A0;
        Tue, 20 Dec 2022 05:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671514920;
        bh=dsBT80rMbHb7evBtDRzv5PT3ZA7g7MTpg/OO26ExzF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jYOojsuBCSLHGr8TW6ECUwgWw+LEvw+PHi3nql2vBWzBzEq7MyKtVOLJ/b2Kiu4gS
         oMG/dlg3OnMmVJmrdSv2oL97DF/CUUglF7nDPoQjrR1EUjWMzPIKMXZdHUPv8l8Sjd
         UXS+WUfMJ0NGEcylNFSYCWZt2yo1UQq4aV3vPbfVoQuD+Qp8TbeWtUxBsxReFPOxlA
         zfs32JevZlz+K+Uv5duClJslwi2mYsu29ttlLiM4znIDXOp4GXmEIq6usK1oiCT/rX
         LwdwbARx6KolYJUmb/r6mqXzDaBmbWq87tBtJKhhILBQJc9wo5CJtT/46YobC23TXN
         w7YoOtqqwQbVA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        will@kernel.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [PATCH 3/3] crypto: x86/ghash - add comment and fix broken link
Date:   Mon, 19 Dec 2022 21:40:42 -0800
Message-Id: <20221220054042.188537-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221220054042.188537-1-ebiggers@kernel.org>
References: <20221220054042.188537-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add a comment that explains what ghash_setkey() is doing, as it's hard
to understand otherwise.  Also fix a broken hyperlink.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/ghash-clmulni-intel_asm.S  |  2 +-
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 27 ++++++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_asm.S b/arch/x86/crypto/ghash-clmulni-intel_asm.S
index 9dfeb4d31b92..257ed9446f3e 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -4,7 +4,7 @@
  * instructions. This file contains accelerated part of ghash
  * implementation. More information about PCLMULQDQ can be found at:
  *
- * http://software.intel.com/en-us/articles/carry-less-multiplication-and-its-usage-for-computing-the-gcm-mode/
+ * https://www.intel.com/content/dam/develop/external/us/en/documents/clmul-wp-rev-2-02-2014-04-20.pdf
  *
  * Copyright (c) 2009 Intel Corp.
  *   Author: Huang Ying <ying.huang@intel.com>
diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index 9453b094bb3b..700ecaee9a08 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -60,16 +60,35 @@ static int ghash_setkey(struct crypto_shash *tfm,
 	if (keylen != GHASH_BLOCK_SIZE)
 		return -EINVAL;
 
-	/* perform multiplication by 'x' in GF(2^128) */
+	/*
+	 * GHASH maps bits to polynomial coefficients backwards, which makes it
+	 * hard to implement.  But it can be shown that the GHASH multiplication
+	 *
+	 *	D * K (mod x^128 + x^7 + x^2 + x + 1)
+	 *
+	 * (where D is a data block and K is the key) is equivalent to:
+	 *
+	 *	bitreflect(D) * bitreflect(K) * x^(-127)
+	 *		(mod x^128 + x^127 + x^126 + x^121 + 1)
+	 *
+	 * So, the code below precomputes:
+	 *
+	 *	bitreflect(K) * x^(-127) (mod x^128 + x^127 + x^126 + x^121 + 1)
+	 *
+	 * ... but in Montgomery form (so that Montgomery multiplication can be
+	 * used), i.e. with an extra x^128 factor, which means actually:
+	 *
+	 *	bitreflect(K) * x (mod x^128 + x^127 + x^126 + x^121 + 1)
+	 *
+	 * The within-a-byte part of bitreflect() cancels out GHASH's built-in
+	 * reflection, and thus bitreflect() is actually a byteswap.
+	 */
 	a = get_unaligned_be64(key);
 	b = get_unaligned_be64(key + 8);
-
 	ctx->shash.a = cpu_to_le64((a << 1) | (b >> 63));
 	ctx->shash.b = cpu_to_le64((b << 1) | (a >> 63));
-
 	if (a >> 63)
 		ctx->shash.a ^= cpu_to_le64((u64)0xc2 << 56);
-
 	return 0;
 }
 
-- 
2.39.0


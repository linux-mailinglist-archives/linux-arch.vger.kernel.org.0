Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8F3651A55
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 06:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiLTFmE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 00:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiLTFmC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 00:42:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3592595BC;
        Mon, 19 Dec 2022 21:42:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A14FB811AB;
        Tue, 20 Dec 2022 05:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8630C433D2;
        Tue, 20 Dec 2022 05:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671514919;
        bh=r7CcLqy65ywV0RdmBdnF4gvrkE0V7pqcwnuVzqA286k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4QPIeBDySeIw45tMI1nPwu6/LnNHxYWm2KdE0KmbJJA+QQ5NSMnGSgSTskJe068B
         a4O19R9sThYWaWHTRdN875o8NAIGdCht29RqD8fd3R9QJl5M5nPP2k0Qz/J13j+q9R
         szrJdxF/p54c3WPQPSOPRTgNaRp3zI0yGR3/pWPy5cZrzPmvfYUoTj8vlTrc+KfrLo
         r90Npm4NnbnGF2uk5qR5byeWzPI4ZzJhJp+zuPusgSYrt/dkFyuwP14LiGBH1ZF6YB
         FY0+pzVMYYmqqbGAPXLoFNY7XaYJRvV9podM+CJY4nTz7ktpEaNJDoh1F1ookspoH4
         H6ZBz8YDu0PEw==
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
Subject: [PATCH 2/3] crypto: x86/ghash - use le128 instead of u128
Date:   Mon, 19 Dec 2022 21:40:41 -0800
Message-Id: <20221220054042.188537-3-ebiggers@kernel.org>
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

The u128 struct type is going away, so make ghash-clmulni-intel use
le128 instead.  Note that the field names a and b swapped, as they were
backwards with u128.  (a is meant to be high-order and b low-order.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/ghash-clmulni-intel_asm.S  |  4 ++--
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_asm.S b/arch/x86/crypto/ghash-clmulni-intel_asm.S
index 2bf871899920..9dfeb4d31b92 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -88,7 +88,7 @@ SYM_FUNC_START_LOCAL(__clmul_gf128mul_ble)
 	RET
 SYM_FUNC_END(__clmul_gf128mul_ble)
 
-/* void clmul_ghash_mul(char *dst, const u128 *shash) */
+/* void clmul_ghash_mul(char *dst, const le128 *shash) */
 SYM_FUNC_START(clmul_ghash_mul)
 	FRAME_BEGIN
 	movups (%rdi), DATA
@@ -104,7 +104,7 @@ SYM_FUNC_END(clmul_ghash_mul)
 
 /*
  * void clmul_ghash_update(char *dst, const char *src, unsigned int srclen,
- *			   const u128 *shash);
+ *			   const le128 *shash);
  */
 SYM_FUNC_START(clmul_ghash_update)
 	FRAME_BEGIN
diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index c0ab0ff4af65..9453b094bb3b 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -24,17 +24,17 @@
 #define GHASH_BLOCK_SIZE	16
 #define GHASH_DIGEST_SIZE	16
 
-void clmul_ghash_mul(char *dst, const u128 *shash);
+void clmul_ghash_mul(char *dst, const le128 *shash);
 
 void clmul_ghash_update(char *dst, const char *src, unsigned int srclen,
-			const u128 *shash);
+			const le128 *shash);
 
 struct ghash_async_ctx {
 	struct cryptd_ahash *cryptd_tfm;
 };
 
 struct ghash_ctx {
-	u128 shash;
+	le128 shash;
 };
 
 struct ghash_desc_ctx {
@@ -64,11 +64,11 @@ static int ghash_setkey(struct crypto_shash *tfm,
 	a = get_unaligned_be64(key);
 	b = get_unaligned_be64(key + 8);
 
-	ctx->shash.a = (b << 1) | (a >> 63);
-	ctx->shash.b = (a << 1) | (b >> 63);
+	ctx->shash.a = cpu_to_le64((a << 1) | (b >> 63));
+	ctx->shash.b = cpu_to_le64((b << 1) | (a >> 63));
 
 	if (a >> 63)
-		ctx->shash.b ^= ((u64)0xc2) << 56;
+		ctx->shash.a ^= cpu_to_le64((u64)0xc2 << 56);
 
 	return 0;
 }
-- 
2.39.0


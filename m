Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A2B651A4D
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 06:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiLTFmC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 00:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLTFmB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 00:42:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E5AA188;
        Mon, 19 Dec 2022 21:42:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1E7BB811A3;
        Tue, 20 Dec 2022 05:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4F8C43398;
        Tue, 20 Dec 2022 05:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671514917;
        bh=3n9ADRO4nwA4vng1EWokN1HkHn+cKE/ZleCXkk6FZuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvUk8ADqzbVfp/roQjX87ypPf+5oAlzPl/WmfbZwTC7hJGifzKIvrISekXo1QbPwj
         77veN4ECatl/Cp4R0djvSgbZtgQ55keX8ZIkZI6jwUwT7Rr+rlabmPl5waJUVMEYj6
         XyAo0xmS282IUjrk6asDmm9DdzzAFQgTRU4HxJjUaPmxA1hb+Iu5q+ddQU8JBD6mm3
         pmfhJ238h55NLqoCVkky8COjAQAbUY+kKd3+uo5qVrJratiTxIXlJhqeLW1lo+OA7M
         9buDvhj1+x2uw3hIpNFy1RbrfxJv0tFYb3c95M8thLEx4T6NY9TZm8pqO+xvypQF+X
         XOzOZKCnjxGzQ==
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
Subject: [PATCH 1/3] crypto: x86/ghash - fix unaligned access in ghash_setkey()
Date:   Mon, 19 Dec 2022 21:40:40 -0800
Message-Id: <20221220054042.188537-2-ebiggers@kernel.org>
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

The key can be unaligned, so use the unaligned memory access helpers.

Fixes: 8ceee72808d1 ("crypto: ghash-clmulni-intel - use C implementation for setkey()")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index 1f1a95f3dd0c..c0ab0ff4af65 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -19,6 +19,7 @@
 #include <crypto/internal/simd.h>
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
+#include <asm/unaligned.h>
 
 #define GHASH_BLOCK_SIZE	16
 #define GHASH_DIGEST_SIZE	16
@@ -54,15 +55,14 @@ static int ghash_setkey(struct crypto_shash *tfm,
 			const u8 *key, unsigned int keylen)
 {
 	struct ghash_ctx *ctx = crypto_shash_ctx(tfm);
-	be128 *x = (be128 *)key;
 	u64 a, b;
 
 	if (keylen != GHASH_BLOCK_SIZE)
 		return -EINVAL;
 
 	/* perform multiplication by 'x' in GF(2^128) */
-	a = be64_to_cpu(x->a);
-	b = be64_to_cpu(x->b);
+	a = get_unaligned_be64(key);
+	b = get_unaligned_be64(key + 8);
 
 	ctx->shash.a = (b << 1) | (a >> 63);
 	ctx->shash.b = (a << 1) | (b >> 63);
-- 
2.39.0


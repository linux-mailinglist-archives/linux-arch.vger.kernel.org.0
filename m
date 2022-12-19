Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BCA650F20
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 16:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiLSPqK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 10:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiLSPpc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 10:45:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85C513F40;
        Mon, 19 Dec 2022 07:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ezxvAyohFkyD0fBAJIL+qTrFeT/MhmgYOqNL8/CaLLo=; b=EpCbp6SSB82FBRpRL3WLFqa1er
        fuzx4lpjiwMDgI2wDkjoqisa1rFP2utGhxIaOhxTrHCo7GVehas62q8lOrxKyUExkTPgH5qrJlgmD
        mdLMP53s/UdjA6xFdacYlLwfmWKVGgN3FDnUJc+YE6QaSFx2faUMB9M6ycuS9i+QXaYo1GZ45IuFJ
        MLKh2Lk5mUsf7UiRdYtCL6rq+w1NEEnIXm7NyWF8oPWx10GLQhHJOxBvnuKwjkt4yuS47GJYU3R22
        p58A2Hq1aQJaVBZxqTlizmhlk3cfNJT7v4y+MhwyWx8cFLoCzjcwo0zOIMO0tcf6r9L03dJVuMEwy
        eDeSbfPQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7IIS-000qwb-OL; Mon, 19 Dec 2022 15:43:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FE0F300642;
        Mon, 19 Dec 2022 16:43:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 64DEF20B0F898; Mon, 19 Dec 2022 16:43:06 +0100 (CET)
Message-ID: <20221219154118.889543494@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 19 Dec 2022 16:35:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     corbet@lwn.net, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
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
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: [RFC][PATCH 01/12] crypto: Remove u128 usage
References: <20221219153525.632521981@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As seems to be the common (majority) usage in crypto, use __uint128_t
instead of u128.

This frees up u128 for definition in linux/types.h.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/crypto/curve25519-hacl64.c |  142 ++++++++++++++++++++---------------------
 lib/crypto/poly1305-donna64.c  |   22 ++----
 2 files changed, 80 insertions(+), 84 deletions(-)

--- a/lib/crypto/curve25519-hacl64.c
+++ b/lib/crypto/curve25519-hacl64.c
@@ -14,8 +14,6 @@
 #include <crypto/curve25519.h>
 #include <linux/string.h>
 
-typedef __uint128_t u128;
-
 static __always_inline u64 u64_eq_mask(u64 a, u64 b)
 {
 	u64 x = a ^ b;
@@ -50,77 +48,77 @@ static __always_inline void modulo_carry
 	b[0] = b0_;
 }
 
-static __always_inline void fproduct_copy_from_wide_(u64 *output, u128 *input)
+static __always_inline void fproduct_copy_from_wide_(u64 *output, __uint128_t *input)
 {
 	{
-		u128 xi = input[0];
+		__uint128_t xi = input[0];
 		output[0] = ((u64)(xi));
 	}
 	{
-		u128 xi = input[1];
+		__uint128_t xi = input[1];
 		output[1] = ((u64)(xi));
 	}
 	{
-		u128 xi = input[2];
+		__uint128_t xi = input[2];
 		output[2] = ((u64)(xi));
 	}
 	{
-		u128 xi = input[3];
+		__uint128_t xi = input[3];
 		output[3] = ((u64)(xi));
 	}
 	{
-		u128 xi = input[4];
+		__uint128_t xi = input[4];
 		output[4] = ((u64)(xi));
 	}
 }
 
 static __always_inline void
-fproduct_sum_scalar_multiplication_(u128 *output, u64 *input, u64 s)
+fproduct_sum_scalar_multiplication_(__uint128_t *output, u64 *input, u64 s)
 {
-	output[0] += (u128)input[0] * s;
-	output[1] += (u128)input[1] * s;
-	output[2] += (u128)input[2] * s;
-	output[3] += (u128)input[3] * s;
-	output[4] += (u128)input[4] * s;
+	output[0] += (__uint128_t)input[0] * s;
+	output[1] += (__uint128_t)input[1] * s;
+	output[2] += (__uint128_t)input[2] * s;
+	output[3] += (__uint128_t)input[3] * s;
+	output[4] += (__uint128_t)input[4] * s;
 }
 
-static __always_inline void fproduct_carry_wide_(u128 *tmp)
+static __always_inline void fproduct_carry_wide_(__uint128_t *tmp)
 {
 	{
 		u32 ctr = 0;
-		u128 tctr = tmp[ctr];
-		u128 tctrp1 = tmp[ctr + 1];
+		__uint128_t tctr = tmp[ctr];
+		__uint128_t tctrp1 = tmp[ctr + 1];
 		u64 r0 = ((u64)(tctr)) & 0x7ffffffffffffLLU;
-		u128 c = ((tctr) >> (51));
-		tmp[ctr] = ((u128)(r0));
+		__uint128_t c = ((tctr) >> (51));
+		tmp[ctr] = ((__uint128_t)(r0));
 		tmp[ctr + 1] = ((tctrp1) + (c));
 	}
 	{
 		u32 ctr = 1;
-		u128 tctr = tmp[ctr];
-		u128 tctrp1 = tmp[ctr + 1];
+		__uint128_t tctr = tmp[ctr];
+		__uint128_t tctrp1 = tmp[ctr + 1];
 		u64 r0 = ((u64)(tctr)) & 0x7ffffffffffffLLU;
-		u128 c = ((tctr) >> (51));
-		tmp[ctr] = ((u128)(r0));
+		__uint128_t c = ((tctr) >> (51));
+		tmp[ctr] = ((__uint128_t)(r0));
 		tmp[ctr + 1] = ((tctrp1) + (c));
 	}
 
 	{
 		u32 ctr = 2;
-		u128 tctr = tmp[ctr];
-		u128 tctrp1 = tmp[ctr + 1];
+		__uint128_t tctr = tmp[ctr];
+		__uint128_t tctrp1 = tmp[ctr + 1];
 		u64 r0 = ((u64)(tctr)) & 0x7ffffffffffffLLU;
-		u128 c = ((tctr) >> (51));
-		tmp[ctr] = ((u128)(r0));
+		__uint128_t c = ((tctr) >> (51));
+		tmp[ctr] = ((__uint128_t)(r0));
 		tmp[ctr + 1] = ((tctrp1) + (c));
 	}
 	{
 		u32 ctr = 3;
-		u128 tctr = tmp[ctr];
-		u128 tctrp1 = tmp[ctr + 1];
+		__uint128_t tctr = tmp[ctr];
+		__uint128_t tctrp1 = tmp[ctr + 1];
 		u64 r0 = ((u64)(tctr)) & 0x7ffffffffffffLLU;
-		u128 c = ((tctr) >> (51));
-		tmp[ctr] = ((u128)(r0));
+		__uint128_t c = ((tctr) >> (51));
+		tmp[ctr] = ((__uint128_t)(r0));
 		tmp[ctr + 1] = ((tctrp1) + (c));
 	}
 }
@@ -154,7 +152,7 @@ static __always_inline void fmul_shift_r
 	output[0] = 19 * b0;
 }
 
-static __always_inline void fmul_mul_shift_reduce_(u128 *output, u64 *input,
+static __always_inline void fmul_mul_shift_reduce_(__uint128_t *output, u64 *input,
 						   u64 *input21)
 {
 	u32 i;
@@ -188,21 +186,21 @@ static __always_inline void fmul_fmul(u6
 {
 	u64 tmp[5] = { input[0], input[1], input[2], input[3], input[4] };
 	{
-		u128 b4;
-		u128 b0;
-		u128 b4_;
-		u128 b0_;
+		__uint128_t b4;
+		__uint128_t b0;
+		__uint128_t b4_;
+		__uint128_t b0_;
 		u64 i0;
 		u64 i1;
 		u64 i0_;
 		u64 i1_;
-		u128 t[5] = { 0 };
+		__uint128_t t[5] = { 0 };
 		fmul_mul_shift_reduce_(t, tmp, input21);
 		fproduct_carry_wide_(t);
 		b4 = t[4];
 		b0 = t[0];
-		b4_ = ((b4) & (((u128)(0x7ffffffffffffLLU))));
-		b0_ = ((b0) + (((u128)(19) * (((u64)(((b4) >> (51))))))));
+		b4_ = ((b4) & (((__uint128_t)(0x7ffffffffffffLLU))));
+		b0_ = ((b0) + (((__uint128_t)(19) * (((u64)(((b4) >> (51))))))));
 		t[4] = b4_;
 		t[0] = b0_;
 		fproduct_copy_from_wide_(output, t);
@@ -215,7 +213,7 @@ static __always_inline void fmul_fmul(u6
 	}
 }
 
-static __always_inline void fsquare_fsquare__(u128 *tmp, u64 *output)
+static __always_inline void fsquare_fsquare__(__uint128_t *tmp, u64 *output)
 {
 	u64 r0 = output[0];
 	u64 r1 = output[1];
@@ -227,16 +225,16 @@ static __always_inline void fsquare_fsqu
 	u64 d2 = r2 * 2 * 19;
 	u64 d419 = r4 * 19;
 	u64 d4 = d419 * 2;
-	u128 s0 = ((((((u128)(r0) * (r0))) + (((u128)(d4) * (r1))))) +
-		   (((u128)(d2) * (r3))));
-	u128 s1 = ((((((u128)(d0) * (r1))) + (((u128)(d4) * (r2))))) +
-		   (((u128)(r3 * 19) * (r3))));
-	u128 s2 = ((((((u128)(d0) * (r2))) + (((u128)(r1) * (r1))))) +
-		   (((u128)(d4) * (r3))));
-	u128 s3 = ((((((u128)(d0) * (r3))) + (((u128)(d1) * (r2))))) +
-		   (((u128)(r4) * (d419))));
-	u128 s4 = ((((((u128)(d0) * (r4))) + (((u128)(d1) * (r3))))) +
-		   (((u128)(r2) * (r2))));
+	__uint128_t s0 = ((((((__uint128_t)(r0) * (r0))) + (((__uint128_t)(d4) * (r1))))) +
+		   (((__uint128_t)(d2) * (r3))));
+	__uint128_t s1 = ((((((__uint128_t)(d0) * (r1))) + (((__uint128_t)(d4) * (r2))))) +
+		   (((__uint128_t)(r3 * 19) * (r3))));
+	__uint128_t s2 = ((((((__uint128_t)(d0) * (r2))) + (((__uint128_t)(r1) * (r1))))) +
+		   (((__uint128_t)(d4) * (r3))));
+	__uint128_t s3 = ((((((__uint128_t)(d0) * (r3))) + (((__uint128_t)(d1) * (r2))))) +
+		   (((__uint128_t)(r4) * (d419))));
+	__uint128_t s4 = ((((((__uint128_t)(d0) * (r4))) + (((__uint128_t)(d1) * (r3))))) +
+		   (((__uint128_t)(r2) * (r2))));
 	tmp[0] = s0;
 	tmp[1] = s1;
 	tmp[2] = s2;
@@ -244,12 +242,12 @@ static __always_inline void fsquare_fsqu
 	tmp[4] = s4;
 }
 
-static __always_inline void fsquare_fsquare_(u128 *tmp, u64 *output)
+static __always_inline void fsquare_fsquare_(__uint128_t *tmp, u64 *output)
 {
-	u128 b4;
-	u128 b0;
-	u128 b4_;
-	u128 b0_;
+	__uint128_t b4;
+	__uint128_t b0;
+	__uint128_t b4_;
+	__uint128_t b0_;
 	u64 i0;
 	u64 i1;
 	u64 i0_;
@@ -258,8 +256,8 @@ static __always_inline void fsquare_fsqu
 	fproduct_carry_wide_(tmp);
 	b4 = tmp[4];
 	b0 = tmp[0];
-	b4_ = ((b4) & (((u128)(0x7ffffffffffffLLU))));
-	b0_ = ((b0) + (((u128)(19) * (((u64)(((b4) >> (51))))))));
+	b4_ = ((b4) & (((__uint128_t)(0x7ffffffffffffLLU))));
+	b0_ = ((b0) + (((__uint128_t)(19) * (((u64)(((b4) >> (51))))))));
 	tmp[4] = b4_;
 	tmp[0] = b0_;
 	fproduct_copy_from_wide_(output, tmp);
@@ -271,7 +269,7 @@ static __always_inline void fsquare_fsqu
 	output[1] = i1_;
 }
 
-static __always_inline void fsquare_fsquare_times_(u64 *output, u128 *tmp,
+static __always_inline void fsquare_fsquare_times_(u64 *output, __uint128_t *tmp,
 						   u32 count1)
 {
 	u32 i;
@@ -283,7 +281,7 @@ static __always_inline void fsquare_fsqu
 static __always_inline void fsquare_fsquare_times(u64 *output, u64 *input,
 						  u32 count1)
 {
-	u128 t[5];
+	__uint128_t t[5];
 	memcpy(output, input, 5 * sizeof(*input));
 	fsquare_fsquare_times_(output, t, count1);
 }
@@ -291,7 +289,7 @@ static __always_inline void fsquare_fsqu
 static __always_inline void fsquare_fsquare_times_inplace(u64 *output,
 							  u32 count1)
 {
-	u128 t[5];
+	__uint128_t t[5];
 	fsquare_fsquare_times_(output, t, count1);
 }
 
@@ -396,36 +394,36 @@ static __always_inline void fdifference(
 
 static __always_inline void fscalar(u64 *output, u64 *b, u64 s)
 {
-	u128 tmp[5];
-	u128 b4;
-	u128 b0;
-	u128 b4_;
-	u128 b0_;
+	__uint128_t tmp[5];
+	__uint128_t b4;
+	__uint128_t b0;
+	__uint128_t b4_;
+	__uint128_t b0_;
 	{
 		u64 xi = b[0];
-		tmp[0] = ((u128)(xi) * (s));
+		tmp[0] = ((__uint128_t)(xi) * (s));
 	}
 	{
 		u64 xi = b[1];
-		tmp[1] = ((u128)(xi) * (s));
+		tmp[1] = ((__uint128_t)(xi) * (s));
 	}
 	{
 		u64 xi = b[2];
-		tmp[2] = ((u128)(xi) * (s));
+		tmp[2] = ((__uint128_t)(xi) * (s));
 	}
 	{
 		u64 xi = b[3];
-		tmp[3] = ((u128)(xi) * (s));
+		tmp[3] = ((__uint128_t)(xi) * (s));
 	}
 	{
 		u64 xi = b[4];
-		tmp[4] = ((u128)(xi) * (s));
+		tmp[4] = ((__uint128_t)(xi) * (s));
 	}
 	fproduct_carry_wide_(tmp);
 	b4 = tmp[4];
 	b0 = tmp[0];
-	b4_ = ((b4) & (((u128)(0x7ffffffffffffLLU))));
-	b0_ = ((b0) + (((u128)(19) * (((u64)(((b4) >> (51))))))));
+	b4_ = ((b4) & (((__uint128_t)(0x7ffffffffffffLLU))));
+	b0_ = ((b0) + (((__uint128_t)(19) * (((u64)(((b4) >> (51))))))));
 	tmp[4] = b4_;
 	tmp[0] = b0_;
 	fproduct_copy_from_wide_(output, tmp);
--- a/lib/crypto/poly1305-donna64.c
+++ b/lib/crypto/poly1305-donna64.c
@@ -10,8 +10,6 @@
 #include <asm/unaligned.h>
 #include <crypto/internal/poly1305.h>
 
-typedef __uint128_t u128;
-
 void poly1305_core_setkey(struct poly1305_core_key *key,
 			  const u8 raw_key[POLY1305_BLOCK_SIZE])
 {
@@ -41,7 +39,7 @@ void poly1305_core_blocks(struct poly130
 	u64 s1, s2;
 	u64 h0, h1, h2;
 	u64 c;
-	u128 d0, d1, d2, d;
+	__uint128_t d0, d1, d2, d;
 
 	if (!nblocks)
 		return;
@@ -71,20 +69,20 @@ void poly1305_core_blocks(struct poly130
 		h2 += (((t1 >> 24)) & 0x3ffffffffffULL) | hibit64;
 
 		/* h *= r */
-		d0 = (u128)h0 * r0;
-		d = (u128)h1 * s2;
+		d0 = (__uint128_t)h0 * r0;
+		d = (__uint128_t)h1 * s2;
 		d0 += d;
-		d = (u128)h2 * s1;
+		d = (__uint128_t)h2 * s1;
 		d0 += d;
-		d1 = (u128)h0 * r1;
-		d = (u128)h1 * r0;
+		d1 = (__uint128_t)h0 * r1;
+		d = (__uint128_t)h1 * r0;
 		d1 += d;
-		d = (u128)h2 * s2;
+		d = (__uint128_t)h2 * s2;
 		d1 += d;
-		d2 = (u128)h0 * r2;
-		d = (u128)h1 * r1;
+		d2 = (__uint128_t)h0 * r2;
+		d = (__uint128_t)h1 * r1;
 		d2 += d;
-		d = (u128)h2 * r0;
+		d = (__uint128_t)h2 * r0;
 		d2 += d;
 
 		/* (partial) h %= p */



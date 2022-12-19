Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EE0650F03
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 16:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiLSPqB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 10:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiLSPpa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 10:45:30 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7460813D3A;
        Mon, 19 Dec 2022 07:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ltmheXPbH9IMNFHZ4P8NvOysWa92wKwMkpxaGeG832Q=; b=BNNdcWplbia7Tdo9e9JhzPu744
        gXUhVeJe6clEEF36/xkbfr3un7XfcOJP5RsPH/+K3YTh4jfl8/W0cviflURH82EDqZNU17198QH36
        WtXvDaQ8shWg9Et9rZ0rynw5UAUIMvXqis8/K09oIZJGjXakQ2lD7xEJXx8DLdeYSyAUKUsAqn+gq
        wbwi6dU6OmKxe5dkQmHBEh1gsn+cqhS4KPU/uyspZ1uxqYCK58Od/ZX2TDOHMHLuybHLL61GBnq+1
        2JKJPz5M+mHygNluwA1CvVZiz5OnHN0oZnOivqqc8Z5SwIEE2uc3zf2UtwWj74ZvPOIqz2jboZeLx
        U+GXIYdA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p7III-00CeDn-27;
        Mon, 19 Dec 2022 15:43:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A44BA302E0D;
        Mon, 19 Dec 2022 16:43:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6839D20114B73; Mon, 19 Dec 2022 16:43:06 +0100 (CET)
Message-ID: <20221219154118.955831880@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 19 Dec 2022 16:35:27 +0100
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
Subject: [RFC][PATCH 02/12] crypto/ghash-clmulni: Use (struct) be128
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

Even though x86 is firmly little endian, use be128 because le128 is in
fact the wrong way around :/ The actual code is already using be128 in
ghash_setkey() so this shouldn't be more confusing.

This frees up the u128 name for a real u128 type.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/ghash-clmulni-intel_asm.S  |    4 ++--
 arch/x86/crypto/ghash-clmulni-intel_glue.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -88,7 +88,7 @@ SYM_FUNC_START_LOCAL(__clmul_gf128mul_bl
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
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -23,17 +23,17 @@
 #define GHASH_BLOCK_SIZE	16
 #define GHASH_DIGEST_SIZE	16
 
-void clmul_ghash_mul(char *dst, const u128 *shash);
+void clmul_ghash_mul(char *dst, const be128 *shash);
 
 void clmul_ghash_update(char *dst, const char *src, unsigned int srclen,
-			const u128 *shash);
+			const be128 *shash);
 
 struct ghash_async_ctx {
 	struct cryptd_ahash *cryptd_tfm;
 };
 
 struct ghash_ctx {
-	u128 shash;
+	be128 shash;
 };
 
 struct ghash_desc_ctx {



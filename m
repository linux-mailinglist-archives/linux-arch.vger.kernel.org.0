Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F384D718197
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 15:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjEaN2U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 09:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjEaN2T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 09:28:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0145C0;
        Wed, 31 May 2023 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YmtjcG8l219y7/fwmL50Z5SyZj2N/Dfw7Oi4KDcDI7Q=; b=EJ3ZB+xFh9CWEpg5yrG6OprVJc
        4KY9jm91TcbrWOishlejJY5DbVF4mvlHugJmUDSsE/LkTcn4aim13LF+VunBmsPU6byCiTEoAXFtd
        PMY9zcKVyFfala+gu6tRVAh8pqQ01ufwI6rMYp7FCuX9C5mYnmZzPRiAM2anoIyZGo4A+qMj6+whs
        fEmcz0eNH94T1AESxYBFQUp4+DmILfWmyLz1Mx+MZvVIgDEzwKNwADbrfOqw3qVGm86SmNMGYmkIt
        gygTW9IHI214IRvW/eG2FY8W+9D4Iq6PvRg/jFdhrZleggC2VWlbR3HPvZmIIrMcseVeHlANgsyCs
        01q0OpaA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4LrG-007IIk-36; Wed, 31 May 2023 13:27:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F357830068D;
        Wed, 31 May 2023 15:27:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7D554243B69D8; Wed, 31 May 2023 15:27:16 +0200 (CEST)
Message-ID: <20230531132323.314826687@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 15:08:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     corbet@lwn.net, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org, sfr@canb.auug.org.au,
        mpe@ellerman.id.au, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, linux-parisc@vger.kernel.org
Subject: [PATCH 01/12] cyrpto/b128ops: Remove struct u128
References: <20230531130833.635651916@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Per git-grep u128_xor() and its related struct u128 are unused except
to implement {be,le}128_xor(). Remove them to free up the namespace.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/crypto/b128ops.h |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- a/include/crypto/b128ops.h
+++ b/include/crypto/b128ops.h
@@ -50,10 +50,6 @@
 #include <linux/types.h>
 
 typedef struct {
-	u64 a, b;
-} u128;
-
-typedef struct {
 	__be64 a, b;
 } be128;
 
@@ -61,20 +57,16 @@ typedef struct {
 	__le64 b, a;
 } le128;
 
-static inline void u128_xor(u128 *r, const u128 *p, const u128 *q)
+static inline void be128_xor(be128 *r, const be128 *p, const be128 *q)
 {
 	r->a = p->a ^ q->a;
 	r->b = p->b ^ q->b;
 }
 
-static inline void be128_xor(be128 *r, const be128 *p, const be128 *q)
-{
-	u128_xor((u128 *)r, (u128 *)p, (u128 *)q);
-}
-
 static inline void le128_xor(le128 *r, const le128 *p, const le128 *q)
 {
-	u128_xor((u128 *)r, (u128 *)p, (u128 *)q);
+	r->a = p->a ^ q->a;
+	r->b = p->b ^ q->b;
 }
 
 #endif /* _CRYPTO_B128OPS_H */



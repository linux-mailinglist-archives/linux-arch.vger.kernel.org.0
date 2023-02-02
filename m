Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C030688268
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 16:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjBBPb3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 10:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjBBPbY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 10:31:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD21977D;
        Thu,  2 Feb 2023 07:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HwKpSq8Syzt9wYk5/qyQZy9JqJElqdY1XVTNG2HpXaA=; b=f3v2Mpvql11MUtfS2akSYxDAG8
        Ac5da3MJnPyezReQuN4422epSgtiTYlOzqFuLziYo5jZeTrm9iZPT5QJe+fFKqJwYW56ZUpGr6HnN
        Jw/4Md5ktVKhlOKxTGSjiWtdNcPeZvnsfgFEC8IsK3XWjhnC1R0p3zqW529oo6T1L+wdRSNvX9STe
        449/8ucwS1cVcvCHuhBOmCM9ldEQcPLoS3Q5cA6/BR6V5oNZGr2xuoUNuwbYsv6IopHfJEcW0eLuT
        rgfknVDH6HJm2BPg+cXG0OAiLn51lYPVxMn5CAgHbJsHd7GF1ZtruDek7QZeeDh5qqO1xYt7zWrEI
        /6jtD8KQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNbVT-005CFh-1o;
        Thu, 02 Feb 2023 15:28:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 077F13010E0;
        Thu,  2 Feb 2023 16:28:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8330A23F31FB5; Thu,  2 Feb 2023 16:28:40 +0100 (CET)
Message-ID: <20230202152655.250913242@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Feb 2023 15:50:31 +0100
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
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 01/10] cyrpto/b128ops: Remove struct u128
References: <20230202145030.223740842@infradead.org>
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

Per git-grep u128_xor() and its related struct u128 are unused except
to implement {be,le}128_xor(). Remove them to free up the namespace.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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



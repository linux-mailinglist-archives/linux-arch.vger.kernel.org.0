Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEDD7026AA
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 10:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjEOIH0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 04:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjEOIHZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 04:07:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682DB1706;
        Mon, 15 May 2023 01:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4kaqfhENJznU2Mt7hBhEZrEbaoSBpAbVRLS0RsxQHdk=; b=XLXPvYSK56u1FQB+k+bhon/4pv
        zSD0YSZlWXiZHPUqIUl6Yyjf5NB4UWFAN3n7Oyp5hyeiOUtKZ9mBZT9y0+I9Onvas22ORYZ6Y3maD
        /QyoXUY4K27SRULt1VqM5bU6j/J3FLtlzDzZjEbqJpQgQUxuBK0FWXTF3USAeGyIQx0wTYpj+p7lO
        J/i/ZJRbdXbF8MlsCfnRwwzoTdOCq+IXrVCfsrCDR2uvOke13V5Dr4oE/McXFo/bEOt60OgXbLqEc
        XeXVrkZaRUSBBo2VPSQDMRDARGlBnk/FVOdYNtIj6j7ZjCFKOzNR7PzQQ9P/94djJbRTqJ9LyTCal
        lulzxa5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pyTDl-00BQN5-1u;
        Mon, 15 May 2023 08:06:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 870D5302DA8;
        Mon, 15 May 2023 10:06:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CF2C4202FCEAA; Mon, 15 May 2023 10:06:10 +0200 (CEST)
Message-ID: <20230515080554.520976397@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 15 May 2023 09:57:08 +0200
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
Subject: [PATCH v3 09/11] mm/slub: Fold slab_update_freelist()
References: <20230515075659.118447996@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The two functions slab_update_freelist() and __slab_update_freelist()
are nearly identical, fold and add a boolean argument and rely on
constant propagation.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/slub.c |   80 +++++++++++++++++++++-----------------------------------------
 1 file changed, 28 insertions(+), 52 deletions(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -559,53 +559,29 @@ __update_freelist_slow(struct slab *slab
  * allocation/ free operation in hardirq context. Therefore nothing can
  * interrupt the operation.
  */
-static inline bool __slab_update_freelist(struct kmem_cache *s, struct slab *slab,
-		void *freelist_old, unsigned long counters_old,
-		void *freelist_new, unsigned long counters_new,
-		const char *n)
+static __always_inline
+bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
+			  void *freelist_old, unsigned long counters_old,
+			  void *freelist_new, unsigned long counters_new,
+			  bool irq_save, const char *n)
 {
 	bool ret;
 
-	if (USE_LOCKLESS_FAST_PATH())
+	if (!irq_save && USE_LOCKLESS_FAST_PATH())
 		lockdep_assert_irqs_disabled();
 
 	if (s->flags & __CMPXCHG_DOUBLE) {
 		ret = __update_freelist_fast(slab, freelist_old, counters_old,
 				            freelist_new, counters_new);
 	} else {
-		ret = __update_freelist_slow(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
-	}
-	if (likely(ret))
-		return true;
-
-	cpu_relax();
-	stat(s, CMPXCHG_DOUBLE_FAIL);
-
-#ifdef SLUB_DEBUG_CMPXCHG
-	pr_info("%s %s: cmpxchg double redo ", n, s->name);
-#endif
-
-	return false;
-}
-
-static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
-		void *freelist_old, unsigned long counters_old,
-		void *freelist_new, unsigned long counters_new,
-		const char *n)
-{
-	bool ret;
-
-	if (s->flags & __CMPXCHG_DOUBLE) {
-		ret = __update_freelist_fast(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
-	} else {
 		unsigned long flags;
 
-		local_irq_save(flags);
+		if (irq_save)
+			local_irq_save(flags);
 		ret = __update_freelist_slow(slab, freelist_old, counters_old,
 				            freelist_new, counters_new);
-		local_irq_restore(flags);
+		if (irq_save)
+			local_irq_restore(flags);
 	}
 	if (likely(ret))
 		return true;
@@ -2250,10 +2226,10 @@ static inline void *acquire_slab(struct
 	VM_BUG_ON(new.frozen);
 	new.frozen = 1;
 
-	if (!__slab_update_freelist(s, slab,
-			freelist, counters,
-			new.freelist, new.counters,
-			"acquire_slab"))
+	if (!slab_update_freelist(s, slab,
+				  freelist, counters,
+				  new.freelist, new.counters,
+				  false, "acquire_slab"))
 		return NULL;
 
 	remove_partial(n, slab);
@@ -2577,9 +2553,9 @@ static void deactivate_slab(struct kmem_
 
 
 	if (!slab_update_freelist(s, slab,
-				old.freelist, old.counters,
-				new.freelist, new.counters,
-				"unfreezing slab")) {
+				  old.freelist, old.counters,
+				  new.freelist, new.counters,
+				  true, "unfreezing slab")) {
 		if (mode == M_PARTIAL)
 			spin_unlock_irqrestore(&n->list_lock, flags);
 		goto redo;
@@ -2633,10 +2609,10 @@ static void __unfreeze_partials(struct k
 
 			new.frozen = 0;
 
-		} while (!__slab_update_freelist(s, slab,
-				old.freelist, old.counters,
-				new.freelist, new.counters,
-				"unfreezing slab"));
+		} while (!slab_update_freelist(s, slab,
+					       old.freelist, old.counters,
+					       new.freelist, new.counters,
+					       false, "unfreezing slab"));
 
 		if (unlikely(!new.inuse && n->nr_partial >= s->min_partial)) {
 			slab->next = slab_to_discard;
@@ -3072,10 +3048,10 @@ static inline void *get_freelist(struct
 		new.inuse = slab->objects;
 		new.frozen = freelist != NULL;
 
-	} while (!__slab_update_freelist(s, slab,
-		freelist, counters,
-		NULL, new.counters,
-		"get_freelist"));
+	} while (!slab_update_freelist(s, slab,
+				       freelist, counters,
+				       NULL, new.counters,
+				       false, "get_freelist"));
 
 	return freelist;
 }
@@ -3666,9 +3642,9 @@ static void __slab_free(struct kmem_cach
 		}
 
 	} while (!slab_update_freelist(s, slab,
-		prior, counters,
-		head, new.counters,
-		"__slab_free"));
+				       prior, counters,
+				       head, new.counters,
+				       true, "__slab_free"));
 
 	if (likely(!n)) {
 



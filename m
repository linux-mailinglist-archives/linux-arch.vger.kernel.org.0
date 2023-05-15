Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8797026B2
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 10:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbjEOIHd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 04:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbjEOIH0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 04:07:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB854170B;
        Mon, 15 May 2023 01:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=rgZ7hZWkHDtTpF84Xw00Ifyh/7yejqO/hjYHP4KrVyk=; b=VA/C0CmchcfXpbAczSsPgonOyt
        2aUt/agGqPFIFpZ6l2I6Qg5nqdJuz9IoNMj9V/ozfrCxRR6fb5YEf1Ga0kiJRyftM4e6pWjqWSKkc
        dIb0BRa5UE1aFif3qoM2MZ9k3ki3NvKxYPbB/R6/S547Pj10WkYXT/Q4uPhD0UtHAZXSrtLCyzGlN
        kb1o1hAHxW8lgC6PteRUH9iYuSUB3Gmflm7Y6x74H7yhLbWGQ2MymwpDc7/LOZXgNN8aLC7xVvmQ7
        r4CZEX4BQYELzBYNeKfUDIJMu3CGkBsiIghUyTmTjEZk9+BAmwahfI7LbKKQJ31UK8rF4TV1yz3Wq
        y8BpnERg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pyTDl-003HUW-Ez; Mon, 15 May 2023 08:06:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 872123033CC;
        Mon, 15 May 2023 10:06:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C2169202FCEA4; Mon, 15 May 2023 10:06:10 +0200 (CEST)
Message-ID: <20230515080554.315901115@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 15 May 2023 09:57:05 +0200
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
        linux-crypto@vger.kernel.org, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 06/11] x86,amd_iommu: Replace cmpxchg_double()
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


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |    9 +++++++--
 drivers/iommu/amd/iommu.c           |   10 ++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -986,8 +986,13 @@ union irte_ga_hi {
 };
 
 struct irte_ga {
-	union irte_ga_lo lo;
-	union irte_ga_hi hi;
+	union {
+		struct {
+			union irte_ga_lo lo;
+			union irte_ga_hi hi;
+		};
+		u128 irte;
+	};
 };
 
 struct irq_2_irte {
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3003,10 +3003,10 @@ static int alloc_irq_index(struct amd_io
 static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 			  struct irte_ga *irte, struct amd_ir_data *data)
 {
-	bool ret;
 	struct irq_remap_table *table;
-	unsigned long flags;
 	struct irte_ga *entry;
+	unsigned long flags;
+	u128 old;
 
 	table = get_irq_table(iommu, devid);
 	if (!table)
@@ -3017,16 +3017,14 @@ static int modify_irte_ga(struct amd_iom
 	entry = (struct irte_ga *)table->table;
 	entry = &entry[index];
 
-	ret = cmpxchg_double(&entry->lo.val, &entry->hi.val,
-			     entry->lo.val, entry->hi.val,
-			     irte->lo.val, irte->hi.val);
 	/*
 	 * We use cmpxchg16 to atomically update the 128-bit IRTE,
 	 * and it cannot be updated by the hardware or other processors
 	 * behind us, so the return value of cmpxchg16 should be the
 	 * same as the old value.
 	 */
-	WARN_ON(!ret);
+	old = entry->irte;
+	WARN_ON(!try_cmpxchg128(&entry->irte, &old, irte->irte));
 
 	if (data)
 		data->ref = entry;



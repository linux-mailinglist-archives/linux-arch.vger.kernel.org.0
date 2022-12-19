Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85574650F09
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 16:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiLSPqC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 10:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiLSPpa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 10:45:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B644712AA1;
        Mon, 19 Dec 2022 07:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TPf252rpqr9tSwRpNAavICICeFc5ydD0TdU6p9uBQtA=; b=hikgFxO9sKFM24xM6AvNTdx5rx
        4bK/y8q/B0VCEnW01d/jdOIOOgxIQq4NAI6Euj1jUMXfyP+rrDOK4e4zF1MxY9SDmw3712EXyfs0e
        zZyVyHpAFwBjGr/vHvoeSRNRrKno451ZKvcGDinbA8BYM5e9DbPj/bZgs6iT29aBwXdpHXM81ydbA
        BuU2h9UTrqr7sYcUkI12tkRLSEh3whv/yts2oyMWWf/AtwiO7CtycmUfUgvK9Yfqfb/hCNyOAszam
        f/zQg3GR+4JQj5VUE26N5UTKvtWgZjr6FBo4UI3eE2tZNipWqM42J/lcxj2ocKWrQLjmoRPH/MazT
        iU0/RFQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7IIT-000qwq-PH; Mon, 19 Dec 2022 15:43:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DCAD3031AE;
        Mon, 19 Dec 2022 16:43:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 96CCA20B0F89E; Mon, 19 Dec 2022 16:43:06 +0100 (CET)
Message-ID: <20221219154119.419176389@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 19 Dec 2022 16:35:34 +0100
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
Subject: [RFC][PATCH 09/12] x86,amd_iommu: Replace cmpxchg_double()
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


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/iommu/amd/amd_iommu_types.h |    9 +++++++--
 drivers/iommu/amd/iommu.c           |   10 ++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -979,8 +979,13 @@ union irte_ga_hi {
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
@@ -2992,10 +2992,10 @@ static int alloc_irq_index(struct amd_io
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
@@ -3006,16 +3006,14 @@ static int modify_irte_ga(struct amd_iom
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



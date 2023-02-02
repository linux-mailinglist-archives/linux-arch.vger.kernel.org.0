Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B6368827C
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 16:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjBBPbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 10:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjBBPbY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 10:31:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BF4CDE1;
        Thu,  2 Feb 2023 07:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3ubHXmjMHuO7YFbxrF9R90Y+YVnse9xBuEbHAitlUas=; b=Huq1BblpHoH+3Obm8iACci5gq3
        megzhmNOz8SY2lHByGtJBiuzwCZGxcMReZzqMQ4nIME6rS6KZPdBpp1dHuZ00OwNftd1HbhvcySE3
        68GXZUzOIxjxl/PwuKG0UW9kglxjDzk22ad/LD6UJv9zU4ZgdkrBGLgtw+Cz/xSyQt3S1hhz17MSd
        2NH8seRyMtxOnwvDrB2Z74x1Ewfp5FBvRH95zDsTzpjJKo5MKphmgIskhBW4cEQnuCCQ7WcDOGGtJ
        goq/K07AkOWFmKlEHfneue1iwLtuIO6jiCeUIAifHqjRKGFxknHNxxnuLwpxLHmhgTgElUSqJXVoQ
        hqTg8AmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNbVU-005CFw-21;
        Thu, 02 Feb 2023 15:28:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AE0D3007C5;
        Thu,  2 Feb 2023 16:28:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9AAE923F31FBD; Thu,  2 Feb 2023 16:28:40 +0100 (CET)
Message-ID: <20230202152655.624998774@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Feb 2023 15:50:37 +0100
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
Subject: [PATCH v2 07/10] x86,intel_iommu: Replace cmpxchg_double()
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


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/iommu/intel/irq_remapping.c |    8 --
 include/linux/dmar.h                |  125 +++++++++++++++++++-----------------
 2 files changed, 68 insertions(+), 65 deletions(-)

--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -174,18 +174,14 @@ static int modify_irte(struct irq_2_iomm
 	irte = &iommu->ir_table->base[index];
 
 	if ((irte->pst == 1) || (irte_modified->pst == 1)) {
-		bool ret;
-
-		ret = cmpxchg_double(&irte->low, &irte->high,
-				     irte->low, irte->high,
-				     irte_modified->low, irte_modified->high);
 		/*
 		 * We use cmpxchg16 to atomically update the 128-bit IRTE,
 		 * and it cannot be updated by the hardware or other processors
 		 * behind us, so the return value of cmpxchg16 should be the
 		 * same as the old value.
 		 */
-		WARN_ON(!ret);
+		u128 old = irte->irte;
+		WARN_ON(!try_cmpxchg128(&irte->irte, &old, irte_modified->irte));
 	} else {
 		WRITE_ONCE(irte->low, irte_modified->low);
 		WRITE_ONCE(irte->high, irte_modified->high);
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -201,67 +201,74 @@ static inline void detect_intel_iommu(vo
 
 struct irte {
 	union {
-		/* Shared between remapped and posted mode*/
 		struct {
-			__u64	present		: 1,  /*  0      */
-				fpd		: 1,  /*  1      */
-				__res0		: 6,  /*  2 -  6 */
-				avail		: 4,  /*  8 - 11 */
-				__res1		: 3,  /* 12 - 14 */
-				pst		: 1,  /* 15      */
-				vector		: 8,  /* 16 - 23 */
-				__res2		: 40; /* 24 - 63 */
+			union {
+				/* Shared between remapped and posted mode*/
+				struct {
+					__u64	present		: 1,  /*  0      */
+						fpd		: 1,  /*  1      */
+						__res0		: 6,  /*  2 -  6 */
+						avail		: 4,  /*  8 - 11 */
+						__res1		: 3,  /* 12 - 14 */
+						pst		: 1,  /* 15      */
+						vector		: 8,  /* 16 - 23 */
+						__res2		: 40; /* 24 - 63 */
+				};
+
+				/* Remapped mode */
+				struct {
+					__u64	r_present	: 1,  /*  0      */
+						r_fpd		: 1,  /*  1      */
+						dst_mode	: 1,  /*  2      */
+						redir_hint	: 1,  /*  3      */
+						trigger_mode	: 1,  /*  4      */
+						dlvry_mode	: 3,  /*  5 -  7 */
+						r_avail		: 4,  /*  8 - 11 */
+						r_res0		: 4,  /* 12 - 15 */
+						r_vector	: 8,  /* 16 - 23 */
+						r_res1		: 8,  /* 24 - 31 */
+						dest_id		: 32; /* 32 - 63 */
+				};
+
+				/* Posted mode */
+				struct {
+					__u64	p_present	: 1,  /*  0      */
+						p_fpd		: 1,  /*  1      */
+						p_res0		: 6,  /*  2 -  7 */
+						p_avail		: 4,  /*  8 - 11 */
+						p_res1		: 2,  /* 12 - 13 */
+						p_urgent	: 1,  /* 14      */
+						p_pst		: 1,  /* 15      */
+						p_vector	: 8,  /* 16 - 23 */
+						p_res2		: 14, /* 24 - 37 */
+						pda_l		: 26; /* 38 - 63 */
+				};
+				__u64 low;
+			};
+
+			union {
+				/* Shared between remapped and posted mode*/
+				struct {
+					__u64	sid		: 16,  /* 64 - 79  */
+						sq		: 2,   /* 80 - 81  */
+						svt		: 2,   /* 82 - 83  */
+						__res3		: 44;  /* 84 - 127 */
+				};
+
+				/* Posted mode*/
+				struct {
+					__u64	p_sid		: 16,  /* 64 - 79  */
+						p_sq		: 2,   /* 80 - 81  */
+						p_svt		: 2,   /* 82 - 83  */
+						p_res3		: 12,  /* 84 - 95  */
+						pda_h		: 32;  /* 96 - 127 */
+				};
+				__u64 high;
+			};
 		};
-
-		/* Remapped mode */
-		struct {
-			__u64	r_present	: 1,  /*  0      */
-				r_fpd		: 1,  /*  1      */
-				dst_mode	: 1,  /*  2      */
-				redir_hint	: 1,  /*  3      */
-				trigger_mode	: 1,  /*  4      */
-				dlvry_mode	: 3,  /*  5 -  7 */
-				r_avail		: 4,  /*  8 - 11 */
-				r_res0		: 4,  /* 12 - 15 */
-				r_vector	: 8,  /* 16 - 23 */
-				r_res1		: 8,  /* 24 - 31 */
-				dest_id		: 32; /* 32 - 63 */
-		};
-
-		/* Posted mode */
-		struct {
-			__u64	p_present	: 1,  /*  0      */
-				p_fpd		: 1,  /*  1      */
-				p_res0		: 6,  /*  2 -  7 */
-				p_avail		: 4,  /*  8 - 11 */
-				p_res1		: 2,  /* 12 - 13 */
-				p_urgent	: 1,  /* 14      */
-				p_pst		: 1,  /* 15      */
-				p_vector	: 8,  /* 16 - 23 */
-				p_res2		: 14, /* 24 - 37 */
-				pda_l		: 26; /* 38 - 63 */
-		};
-		__u64 low;
-	};
-
-	union {
-		/* Shared between remapped and posted mode*/
-		struct {
-			__u64	sid		: 16,  /* 64 - 79  */
-				sq		: 2,   /* 80 - 81  */
-				svt		: 2,   /* 82 - 83  */
-				__res3		: 44;  /* 84 - 127 */
-		};
-
-		/* Posted mode*/
-		struct {
-			__u64	p_sid		: 16,  /* 64 - 79  */
-				p_sq		: 2,   /* 80 - 81  */
-				p_svt		: 2,   /* 82 - 83  */
-				p_res3		: 12,  /* 84 - 95  */
-				pda_h		: 32;  /* 96 - 127 */
-		};
-		__u64 high;
+#ifdef CONFIG_IRQ_REMAP
+		__u128 irte;
+#endif
 	};
 };
 



Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D79688257
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 16:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjBBPbZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 10:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjBBPbR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 10:31:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396E03ABB;
        Thu,  2 Feb 2023 07:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LNTskqo5roGsovH+JFQKAebOFNRW3Kky7MgwbIWmzaM=; b=SutQsn5HCDPd7RqYYJOqaRBAAw
        ghza+gVMb7VvZ8S5mXEBYv9fP8q8Y9wXALUK5q0pzocuZuyXrPepuT1+wCOd/OzB+ntZth6DaMT6B
        S8zOdGU0FmbWx9fMkVMCos7RUSpLps4sna/LO0IsKeshnyabCK7cNceYm4e+4Fmn11Z+jL+MTpNzN
        I6xv1Uhkv4ss9oJhXYo64MzEkqJxVqSn1hWToVBJlsAr9MjKCkQ2hdLEGzmvnX+l4DLFC6cT1hP4d
        2/1/3QPc9YolaFPwoZcHS+Sn+GoiEBzfYylecr9r98dtv7EMTfckM+5a0Ow5UAFEBYeCLaBAG2mQU
        PcOP0H6w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNbW4-00DV2e-2G; Thu, 02 Feb 2023 15:28:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4121B302E1F;
        Thu,  2 Feb 2023 16:28:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AB09623F326C1; Thu,  2 Feb 2023 16:28:40 +0100 (CET)
Message-ID: <20230202152655.805747571@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Feb 2023 15:50:40 +0100
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
Subject: [PATCH v2 10/10] s390/cpum_sf: Convert to cmpxchg128()
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

Now that there is a cross arch u128 and cmpxchg128(), use those
instead of the custom CDSG helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/s390/include/asm/cpu_mf.h  |    2 +-
 arch/s390/kernel/perf_cpum_sf.c |   22 ++++++----------------
 2 files changed, 7 insertions(+), 17 deletions(-)

--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -141,7 +141,7 @@ union hws_trailer_header {
 		unsigned int dsdes:16;	/* 48-63: size of diagnostic SDE */
 		unsigned long long overflow; /* 64 - Overflow Count   */
 	};
-	__uint128_t val;
+	u128 val;
 };
 
 struct hws_trailer_entry {
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1228,16 +1228,6 @@ static void hw_collect_samples(struct pe
 	}
 }
 
-static inline __uint128_t __cdsg(__uint128_t *ptr, __uint128_t old, __uint128_t new)
-{
-	asm volatile(
-		"	cdsg	%[old],%[new],%[ptr]\n"
-		: [old] "+d" (old), [ptr] "+QS" (*ptr)
-		: [new] "d" (new)
-		: "memory", "cc");
-	return old;
-}
-
 /* hw_perf_event_update() - Process sampling buffer
  * @event:	The perf event
  * @flush_all:	Flag to also flush partially filled sample-data-blocks
@@ -1307,14 +1297,14 @@ static void hw_perf_event_update(struct
 
 		/* Reset trailer (using compare-double-and-swap) */
 		/* READ_ONCE() 16 byte header */
-		prev.val = __cdsg(&te->header.val, 0, 0);
+		prev.val = cmpxchg128(&te->header.val, 0, 0);
 		do {
 			old.val = prev.val;
 			new.val = prev.val;
 			new.f = 0;
 			new.a = 1;
 			new.overflow = 0;
-			prev.val = __cdsg(&te->header.val, old.val, new.val);
+			prev.val = cmpxchg128(&te->header.val, old.val, new.val);
 		} while (prev.val != old.val);
 
 		/* Advance to next sample-data-block */
@@ -1496,7 +1486,7 @@ static bool aux_set_alert(struct aux_buf
 
 	te = aux_sdb_trailer(aux, alert_index);
 	/* READ_ONCE() 16 byte header */
-	prev.val = __cdsg(&te->header.val, 0, 0);
+	prev.val = cmpxchg128(&te->header.val, 0, 0);
 	do {
 		old.val = prev.val;
 		new.val = prev.val;
@@ -1511,7 +1501,7 @@ static bool aux_set_alert(struct aux_buf
 		}
 		new.a = 1;
 		new.overflow = 0;
-		prev.val = __cdsg(&te->header.val, old.val, new.val);
+		prev.val = cmpxchg128(&te->header.val, old.val, new.val);
 	} while (prev.val != old.val);
 	return true;
 }
@@ -1575,7 +1565,7 @@ static bool aux_reset_buffer(struct aux_
 	for (i = 0; i < range_scan; i++, idx++) {
 		te = aux_sdb_trailer(aux, idx);
 		/* READ_ONCE() 16 byte header */
-		prev.val = __cdsg(&te->header.val, 0, 0);
+		prev.val = cmpxchg128(&te->header.val, 0, 0);
 		do {
 			old.val = prev.val;
 			new.val = prev.val;
@@ -1586,7 +1576,7 @@ static bool aux_reset_buffer(struct aux_
 				new.a = 1;
 			else
 				new.a = 0;
-			prev.val = __cdsg(&te->header.val, old.val, new.val);
+			prev.val = cmpxchg128(&te->header.val, old.val, new.val);
 		} while (prev.val != old.val);
 		*overflow += orig_overflow;
 	}



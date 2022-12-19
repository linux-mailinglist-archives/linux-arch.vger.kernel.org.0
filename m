Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35DE650F18
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 16:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiLSPqD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 10:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiLSPpa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 10:45:30 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E5D13F2B;
        Mon, 19 Dec 2022 07:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=gkcjStIUQsvZMzBnRMKIS/S8C1S2HdQdTZCEH219uhc=; b=H4AjUmHwWCRzxq87XM6dpIVmhp
        a6K9WMWqe+zvKBxZT3MnWCIIOoYI+xLcYdnMcJtUyBQ537agojcGqjlVwUHqfZ8U+DwCSlb/u9KU1
        a9t3thKS+ZDlG1xqzGNzzZa48TCVaH1NcBD5Az/De/G46fj5MSt/nmPBonJHKh8hNu9qACt/gtfvp
        STxqJIgeYtBhW19qvGf/EppiN+gRv9z++90g+9r9t5rp2CxhjZeNcDiUYzRO10sDir1IBJqPb3ok/
        xDzrfmrgdazGWSgN0dy03Y8gM38cdg75QYDKcSDFiiZOXRZBaXpEIx9k4lY2E1hX7XWVYP22eha5G
        9ZUUr+Fg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p7III-00CeDp-35;
        Mon, 19 Dec 2022 15:43:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DD4F30330E;
        Mon, 19 Dec 2022 16:43:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8F28420B0F89B; Mon, 19 Dec 2022 16:43:06 +0100 (CET)
Message-ID: <20221219154119.352918965@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 19 Dec 2022 16:35:33 +0100
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
Subject: [RFC][PATCH 08/12] s390: Replace cmpxchg_double() with cmpxchg128()
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

In order to depricate cmpxchg_double(), replace all its usage with
cmpxchg128().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/s390/include/asm/cpu_mf.h  |   29 ++++++++++++-----
 arch/s390/kernel/perf_cpum_sf.c |   65 +++++++++++++++++++++++++---------------
 2 files changed, 63 insertions(+), 31 deletions(-)

--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -131,19 +131,32 @@ struct hws_combined_entry {
 	struct hws_diag_entry	diag;	/* Diagnostic-sampling data entry */
 } __packed;
 
+union hws_flags_and_overflow {
+	struct {
+		unsigned long flags;
+		unsigned long overflow;
+	};
+	u128	full;
+};
+
 struct hws_trailer_entry {
 	union {
 		struct {
-			unsigned int f:1;	/* 0 - Block Full Indicator   */
-			unsigned int a:1;	/* 1 - Alert request control  */
-			unsigned int t:1;	/* 2 - Timestamp format	      */
-			unsigned int :29;	/* 3 - 31: Reserved	      */
-			unsigned int bsdes:16;	/* 32-47: size of basic SDE   */
-			unsigned int dsdes:16;	/* 48-63: size of diagnostic SDE */
+			union {
+				struct {
+					unsigned int f:1;	/* 0 - Block Full Indicator   */
+					unsigned int a:1;	/* 1 - Alert request control  */
+					unsigned int t:1;	/* 2 - Timestamp format	      */
+					unsigned int :29;	/* 3 - 31: Reserved	      */
+					unsigned int bsdes:16;	/* 32-47: size of basic SDE   */
+					unsigned int dsdes:16;	/* 48-63: size of diagnostic SDE */
+				};
+				unsigned long long flags;	/* 0 - 63: All indicators     */
+			};
+			unsigned long long overflow;	 /* 64 - sample Overflow count	      */
 		};
-		unsigned long long flags;	/* 0 - 63: All indicators     */
+		union hws_flags_and_overflow flags_and_overflow;
 	};
-	unsigned long long overflow;	 /* 64 - sample Overflow count	      */
 	unsigned char timestamp[16];	 /* 16 - 31 timestamp		      */
 	unsigned long long reserved1;	 /* 32 -Reserved		      */
 	unsigned long long reserved2;	 /*				      */
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1227,6 +1227,8 @@ static void hw_collect_samples(struct pe
 	}
 }
 
+typedef union hws_flags_and_overflow fao_t;
+
 /* hw_perf_event_update() - Process sampling buffer
  * @event:	The perf event
  * @flush_all:	Flag to also flush partially filled sample-data-blocks
@@ -1243,10 +1245,11 @@ static void hw_collect_samples(struct pe
  */
 static void hw_perf_event_update(struct perf_event *event, int flush_all)
 {
+	unsigned long long event_overflow, sampl_overflow, num_sdb;
 	struct hw_perf_event *hwc = &event->hw;
 	struct hws_trailer_entry *te;
+	fao_t old_fao, new_fao;
 	unsigned long *sdbt;
-	unsigned long long event_overflow, sampl_overflow, num_sdb, te_flags;
 	int done;
 
 	/*
@@ -1294,12 +1297,16 @@ static void hw_perf_event_update(struct
 		num_sdb++;
 
 		/* Reset trailer (using compare-double-and-swap) */
+		old_fao = te->flags_and_overflow;
 		do {
-			te_flags = te->flags & ~SDB_TE_BUFFER_FULL_MASK;
-			te_flags |= SDB_TE_ALERT_REQ_MASK;
-		} while (!cmpxchg_double(&te->flags, &te->overflow,
-					 te->flags, te->overflow,
-					 te_flags, 0ULL));
+			new_fao = (fao_t){
+				.flags = old_fao.flags,
+				.overflow = 0,
+			};
+			new_fao.flags &= ~SDB_TE_BUFFER_FULL_MASK;
+			new_fao.flags |= SDB_TE_ALERT_REQ_MASK;
+		} while (!try_cmpxchg128(&te->flags_and_overflow.full,
+					 &old_fao.full, new_fao.full));
 
 		/* Advance to next sample-data-block */
 		sdbt++;
@@ -1475,14 +1482,19 @@ static int aux_output_begin(struct perf_
 static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 			  unsigned long long *overflow)
 {
-	unsigned long long orig_overflow, orig_flags, new_flags;
 	struct hws_trailer_entry *te;
+	fao_t old_fao, new_fao;
 
 	te = aux_sdb_trailer(aux, alert_index);
+
+	old_fao = te->flags_and_overflow;
 	do {
-		orig_flags = te->flags;
-		*overflow = orig_overflow = te->overflow;
-		if (orig_flags & SDB_TE_BUFFER_FULL_MASK) {
+		new_fao = (fao_t){
+			.flags = old_fao.flags,
+			.overflow = 0,
+		};
+		*overflow = old_fao.overflow;
+		if (new_fao.flags & SDB_TE_BUFFER_FULL_MASK) {
 			/*
 			 * SDB is already set by hardware.
 			 * Abort and try to set somewhere
@@ -1490,10 +1502,11 @@ static bool aux_set_alert(struct aux_buf
 			 */
 			return false;
 		}
-		new_flags = orig_flags | SDB_TE_ALERT_REQ_MASK;
-	} while (!cmpxchg_double(&te->flags, &te->overflow,
-				 orig_flags, orig_overflow,
-				 new_flags, 0ULL));
+		new_fao.flags |= SDB_TE_ALERT_REQ_MASK;
+
+	} while (!try_cmpxchg128(&te->flags_and_overflow.full,
+				 &old_fao.full, new_fao.full));
+
 	return true;
 }
 
@@ -1522,9 +1535,10 @@ static bool aux_set_alert(struct aux_buf
 static bool aux_reset_buffer(struct aux_buffer *aux, unsigned long range,
 			     unsigned long long *overflow)
 {
-	unsigned long long orig_overflow, orig_flags, new_flags;
 	unsigned long i, range_scan, idx, idx_old;
+	unsigned long long orig_overflow;
 	struct hws_trailer_entry *te;
+	fao_t old_fao, new_fao;
 
 	debug_sprintf_event(sfdbg, 6, "%s: range %ld head %ld alert %ld "
 			    "empty %ld\n", __func__, range, aux->head,
@@ -1554,17 +1568,22 @@ static bool aux_reset_buffer(struct aux_
 	idx_old = idx = aux->empty_mark + 1;
 	for (i = 0; i < range_scan; i++, idx++) {
 		te = aux_sdb_trailer(aux, idx);
+
+		old_fao = te->flags_and_overflow;
 		do {
-			orig_flags = te->flags;
-			orig_overflow = te->overflow;
-			new_flags = orig_flags & ~SDB_TE_BUFFER_FULL_MASK;
+			new_fao = (fao_t){
+				.flags = old_fao.flags,
+				.overflow = 0,
+			};
+			orig_overflow = old_fao.overflow;
+			new_fao.flags &= ~SDB_TE_BUFFER_FULL_MASK;
 			if (idx == aux->alert_mark)
-				new_flags |= SDB_TE_ALERT_REQ_MASK;
+				new_fao.flags |= SDB_TE_ALERT_REQ_MASK;
 			else
-				new_flags &= ~SDB_TE_ALERT_REQ_MASK;
-		} while (!cmpxchg_double(&te->flags, &te->overflow,
-					 orig_flags, orig_overflow,
-					 new_flags, 0ULL));
+				new_fao.flags &= ~SDB_TE_ALERT_REQ_MASK;
+		} while (!try_cmpxchg128(&te->flags_and_overflow.full,
+					 &old_fao.full, new_fao.full));
+
 		*overflow += orig_overflow;
 	}
 



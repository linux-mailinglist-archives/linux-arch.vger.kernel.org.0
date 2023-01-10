Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2066639DD
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 08:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjAJHYj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Jan 2023 02:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjAJHYh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2023 02:24:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98C416599;
        Mon,  9 Jan 2023 23:24:22 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A66mZ0030413;
        Tue, 10 Jan 2023 07:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NfSJKtmJ/N//lw1SnvX9BZU/tgOxxYMY8GXVjTj3oDE=;
 b=kLuCFnnnPB8rxjoULEisozdv5tJ7JOV4xgcld0SfaxGeBynIQ+oe+rfpTq7CaifmPkSB
 E8AjFEHzXSPrVkAHMO9taaa03/cIJpasRswmn3b4U76kBow8oTSaitwUkwAh9oUqp+Hy
 V4ZAjUBoWmsDNfFMBDzl5P7qMRghwqto8t7IgeBEO5hUqEIHh1HFmlB/pC/Vj8TsYxGT
 orAbR36f8nozMwkfgizBGjg//QbxyZ6/ceWKZksHZyh4EDN2rD2ybHojGp5vtxvFeKKh
 Mk6lIMejPRqSaD58ir4alCRKFKp1hsGPJz+wD2lNpQYEzJYOQLhHzYKzvIRJfvb8ve/F ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n12fd9mxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 07:23:17 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30A68uLc007590;
        Tue, 10 Jan 2023 07:23:16 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n12fd9mwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 07:23:16 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 309MdohC029885;
        Tue, 10 Jan 2023 07:23:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3my00fk4nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 07:23:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30A7N9Pf20579062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 07:23:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A50820043;
        Tue, 10 Jan 2023 07:23:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D1F220040;
        Tue, 10 Jan 2023 07:23:07 +0000 (GMT)
Received: from osiris (unknown [9.171.82.113])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 10 Jan 2023 07:23:07 +0000 (GMT)
Date:   Tue, 10 Jan 2023 08:23:05 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 08/12] s390: Replace cmpxchg_double() with
 cmpxchg128()
Message-ID: <Y70SWXHDmOc3RhMd@osiris>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.352918965@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219154119.352918965@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iyy8uYrJaamIEdMg0S5w71K9ZUmpLv48
X-Proofpoint-ORIG-GUID: fT3s9TmjDYKNI3QqB4jYLEfG_nFXVVJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_02,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301100046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022 at 04:35:33PM +0100, Peter Zijlstra wrote:
> In order to depricate cmpxchg_double(), replace all its usage with
> cmpxchg128().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/s390/include/asm/cpu_mf.h  |   29 ++++++++++++-----
>  arch/s390/kernel/perf_cpum_sf.c |   65 +++++++++++++++++++++++++---------------
>  2 files changed, 63 insertions(+), 31 deletions(-)

So, Alexander Gordeev reported that this code was already prior to your
changes potentially broken with respect to missing READ_ONCE() within the
cmpxchg_double() loops.

In order to fix that and have a patch that can be backported I would go
with something like the patch below, which I would also plan to send for
-rc4, unless there are objections.

This can then easily be converted to the new cmpxchg128() later.


From 7b271f42946b306620a748c0da5f07f8c786888d Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Thu, 5 Jan 2023 15:44:20 +0100
Subject: [PATCH] s390/cpum_sf: add READ_ONCE() semantics to compare and swap
 loops

The current cmpxchg_double() loops within the perf hw sampling code do not
have READ_ONCE() semantics to read the old value from memory. This allows
the compiler to generate code which reads the "old" value several times
from memory, which again allows for inconsistencies.

For example:

        /* Reset trailer (using compare-double-and-swap) */
        do {
                te_flags = te->flags & ~SDB_TE_BUFFER_FULL_MASK;
                te_flags |= SDB_TE_ALERT_REQ_MASK;
        } while (!cmpxchg_double(&te->flags, &te->overflow,
                 te->flags, te->overflow,
                 te_flags, 0ULL));

The compiler could generate code where te->flags used within the
cmpxchg_double() call may be refetched from memory and which is not
necessarily identical to the previous read version which was used to
generate te_flags. Which in turn means that an incorrect update could
happen.

Fix this by adding READ_ONCE() semantics to all cmpxchg_double()
loops. Given that READ_ONCE() cannot generate code on s390 which atomically
reads 16 bytes, use a private compare-and-swap-double implementation to
achieve that.

Also replace cmpxchg_double() with the private implementation to be able to
re-use the old value within the loops.

As a side effect this converts the whole code to only use bit fields
to read and modify bits within the hws trailer header.

Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/cpu_mf.h  |  31 +++++-----
 arch/s390/kernel/perf_cpum_sf.c | 101 ++++++++++++++++++++------------
 2 files changed, 77 insertions(+), 55 deletions(-)

diff --git a/arch/s390/include/asm/cpu_mf.h b/arch/s390/include/asm/cpu_mf.h
index feaba12dbecb..efa103b52a1a 100644
--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -131,19 +131,21 @@ struct hws_combined_entry {
 	struct hws_diag_entry	diag;	/* Diagnostic-sampling data entry */
 } __packed;
 
-struct hws_trailer_entry {
-	union {
-		struct {
-			unsigned int f:1;	/* 0 - Block Full Indicator   */
-			unsigned int a:1;	/* 1 - Alert request control  */
-			unsigned int t:1;	/* 2 - Timestamp format	      */
-			unsigned int :29;	/* 3 - 31: Reserved	      */
-			unsigned int bsdes:16;	/* 32-47: size of basic SDE   */
-			unsigned int dsdes:16;	/* 48-63: size of diagnostic SDE */
-		};
-		unsigned long long flags;	/* 0 - 63: All indicators     */
+union hws_trailer_header {
+	struct {
+		unsigned int f:1;	/* 0 - Block Full Indicator   */
+		unsigned int a:1;	/* 1 - Alert request control  */
+		unsigned int t:1;	/* 2 - Timestamp format	      */
+		unsigned int :29;	/* 3 - 31: Reserved	      */
+		unsigned int bsdes:16;	/* 32-47: size of basic SDE   */
+		unsigned int dsdes:16;	/* 48-63: size of diagnostic SDE */
+		unsigned long long overflow; /* 64 - Overflow Count   */
 	};
-	unsigned long long overflow;	 /* 64 - sample Overflow count	      */
+	__uint128_t val;
+};
+
+struct hws_trailer_entry {
+	union hws_trailer_header header; /* 0 - 15 Flags + Overflow Count     */
 	unsigned char timestamp[16];	 /* 16 - 31 timestamp		      */
 	unsigned long long reserved1;	 /* 32 -Reserved		      */
 	unsigned long long reserved2;	 /*				      */
@@ -290,14 +292,11 @@ static inline unsigned long sample_rate_to_freq(struct hws_qsi_info_block *qsi,
 	return USEC_PER_SEC * qsi->cpu_speed / rate;
 }
 
-#define SDB_TE_ALERT_REQ_MASK	0x4000000000000000UL
-#define SDB_TE_BUFFER_FULL_MASK 0x8000000000000000UL
-
 /* Return TOD timestamp contained in an trailer entry */
 static inline unsigned long long trailer_timestamp(struct hws_trailer_entry *te)
 {
 	/* TOD in STCKE format */
-	if (te->t)
+	if (te->header.t)
 		return *((unsigned long long *) &te->timestamp[1]);
 
 	/* TOD in STCK format */
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 332a49965130..ce886a03545a 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -163,14 +163,15 @@ static void free_sampling_buffer(struct sf_buffer *sfb)
 
 static int alloc_sample_data_block(unsigned long *sdbt, gfp_t gfp_flags)
 {
-	unsigned long sdb, *trailer;
+	struct hws_trailer_entry *te;
+	unsigned long sdb;
 
 	/* Allocate and initialize sample-data-block */
 	sdb = get_zeroed_page(gfp_flags);
 	if (!sdb)
 		return -ENOMEM;
-	trailer = trailer_entry_ptr(sdb);
-	*trailer = SDB_TE_ALERT_REQ_MASK;
+	te = (struct hws_trailer_entry *)trailer_entry_ptr(sdb);
+	te->header.a = 1;
 
 	/* Link SDB into the sample-data-block-table */
 	*sdbt = sdb;
@@ -1206,7 +1207,7 @@ static void hw_collect_samples(struct perf_event *event, unsigned long *sdbt,
 					    "%s: Found unknown"
 					    " sampling data entry: te->f %i"
 					    " basic.def %#4x (%p)\n", __func__,
-					    te->f, sample->def, sample);
+					    te->header.f, sample->def, sample);
 			/* Sample slot is not yet written or other record.
 			 *
 			 * This condition can occur if the buffer was reused
@@ -1217,7 +1218,7 @@ static void hw_collect_samples(struct perf_event *event, unsigned long *sdbt,
 			 * that are not full.  Stop processing if the first
 			 * invalid format was detected.
 			 */
-			if (!te->f)
+			if (!te->header.f)
 				break;
 		}
 
@@ -1227,6 +1228,16 @@ static void hw_collect_samples(struct perf_event *event, unsigned long *sdbt,
 	}
 }
 
+static inline __uint128_t __cdsg(__uint128_t *ptr, __uint128_t old, __uint128_t new)
+{
+	asm volatile(
+		"	cdsg	%[old],%[new],%[ptr]\n"
+		: [old] "+d" (old), [ptr] "+QS" (*ptr)
+		: [new] "d" (new)
+		: "memory", "cc");
+	return old;
+}
+
 /* hw_perf_event_update() - Process sampling buffer
  * @event:	The perf event
  * @flush_all:	Flag to also flush partially filled sample-data-blocks
@@ -1243,10 +1254,11 @@ static void hw_collect_samples(struct perf_event *event, unsigned long *sdbt,
  */
 static void hw_perf_event_update(struct perf_event *event, int flush_all)
 {
+	unsigned long long event_overflow, sampl_overflow, num_sdb;
+	union hws_trailer_header old, prev, new;
 	struct hw_perf_event *hwc = &event->hw;
 	struct hws_trailer_entry *te;
 	unsigned long *sdbt;
-	unsigned long long event_overflow, sampl_overflow, num_sdb, te_flags;
 	int done;
 
 	/*
@@ -1266,25 +1278,25 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
 		te = (struct hws_trailer_entry *) trailer_entry_ptr(*sdbt);
 
 		/* Leave loop if no more work to do (block full indicator) */
-		if (!te->f) {
+		if (!te->header.f) {
 			done = 1;
 			if (!flush_all)
 				break;
 		}
 
 		/* Check the sample overflow count */
-		if (te->overflow)
+		if (te->header.overflow)
 			/* Account sample overflows and, if a particular limit
 			 * is reached, extend the sampling buffer.
 			 * For details, see sfb_account_overflows().
 			 */
-			sampl_overflow += te->overflow;
+			sampl_overflow += te->header.overflow;
 
 		/* Timestamps are valid for full sample-data-blocks only */
 		debug_sprintf_event(sfdbg, 6, "%s: sdbt %#lx "
 				    "overflow %llu timestamp %#llx\n",
-				    __func__, (unsigned long)sdbt, te->overflow,
-				    (te->f) ? trailer_timestamp(te) : 0ULL);
+				    __func__, (unsigned long)sdbt, te->header.overflow,
+				    (te->header.f) ? trailer_timestamp(te) : 0ULL);
 
 		/* Collect all samples from a single sample-data-block and
 		 * flag if an (perf) event overflow happened.  If so, the PMU
@@ -1294,12 +1306,16 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
 		num_sdb++;
 
 		/* Reset trailer (using compare-double-and-swap) */
+		/* READ_ONCE() 16 byte header */
+		prev.val = __cdsg(&te->header.val, 0, 0);
 		do {
-			te_flags = te->flags & ~SDB_TE_BUFFER_FULL_MASK;
-			te_flags |= SDB_TE_ALERT_REQ_MASK;
-		} while (!cmpxchg_double(&te->flags, &te->overflow,
-					 te->flags, te->overflow,
-					 te_flags, 0ULL));
+			old.val = prev.val;
+			new.val = prev.val;
+			new.f = 0;
+			new.a = 1;
+			new.overflow = 0;
+			prev.val = __cdsg(&te->header.val, old.val, new.val);
+		} while (prev.val != old.val);
 
 		/* Advance to next sample-data-block */
 		sdbt++;
@@ -1384,7 +1400,7 @@ static void aux_output_end(struct perf_output_handle *handle)
 	range_scan = AUX_SDB_NUM_ALERT(aux);
 	for (i = 0, idx = aux->head; i < range_scan; i++, idx++) {
 		te = aux_sdb_trailer(aux, idx);
-		if (!(te->flags & SDB_TE_BUFFER_FULL_MASK))
+		if (!te->header.f)
 			break;
 	}
 	/* i is num of SDBs which are full */
@@ -1392,7 +1408,7 @@ static void aux_output_end(struct perf_output_handle *handle)
 
 	/* Remove alert indicators in the buffer */
 	te = aux_sdb_trailer(aux, aux->alert_mark);
-	te->flags &= ~SDB_TE_ALERT_REQ_MASK;
+	te->header.a = 0;
 
 	debug_sprintf_event(sfdbg, 6, "%s: SDBs %ld range %ld head %ld\n",
 			    __func__, i, range_scan, aux->head);
@@ -1437,9 +1453,9 @@ static int aux_output_begin(struct perf_output_handle *handle,
 		idx = aux->empty_mark + 1;
 		for (i = 0; i < range_scan; i++, idx++) {
 			te = aux_sdb_trailer(aux, idx);
-			te->flags &= ~(SDB_TE_BUFFER_FULL_MASK |
-				       SDB_TE_ALERT_REQ_MASK);
-			te->overflow = 0;
+			te->header.f = 0;
+			te->header.a = 0;
+			te->header.overflow = 0;
 		}
 		/* Save the position of empty SDBs */
 		aux->empty_mark = aux->head + range - 1;
@@ -1448,7 +1464,7 @@ static int aux_output_begin(struct perf_output_handle *handle,
 	/* Set alert indicator */
 	aux->alert_mark = aux->head + range/2 - 1;
 	te = aux_sdb_trailer(aux, aux->alert_mark);
-	te->flags = te->flags | SDB_TE_ALERT_REQ_MASK;
+	te->header.a = 1;
 
 	/* Reset hardware buffer head */
 	head = AUX_SDB_INDEX(aux, aux->head);
@@ -1475,14 +1491,17 @@ static int aux_output_begin(struct perf_output_handle *handle,
 static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 			  unsigned long long *overflow)
 {
-	unsigned long long orig_overflow, orig_flags, new_flags;
+	union hws_trailer_header old, prev, new;
 	struct hws_trailer_entry *te;
 
 	te = aux_sdb_trailer(aux, alert_index);
+	/* READ_ONCE() 16 byte header */
+	prev.val = __cdsg(&te->header.val, 0, 0);
 	do {
-		orig_flags = te->flags;
-		*overflow = orig_overflow = te->overflow;
-		if (orig_flags & SDB_TE_BUFFER_FULL_MASK) {
+		old.val = prev.val;
+		new.val = prev.val;
+		*overflow = old.overflow;
+		if (old.f) {
 			/*
 			 * SDB is already set by hardware.
 			 * Abort and try to set somewhere
@@ -1490,10 +1509,10 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 			 */
 			return false;
 		}
-		new_flags = orig_flags | SDB_TE_ALERT_REQ_MASK;
-	} while (!cmpxchg_double(&te->flags, &te->overflow,
-				 orig_flags, orig_overflow,
-				 new_flags, 0ULL));
+		new.a = 1;
+		new.overflow = 0;
+		prev.val = __cdsg(&te->header.val, old.val, new.val);
+	} while (prev.val != old.val);
 	return true;
 }
 
@@ -1522,8 +1541,9 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 static bool aux_reset_buffer(struct aux_buffer *aux, unsigned long range,
 			     unsigned long long *overflow)
 {
-	unsigned long long orig_overflow, orig_flags, new_flags;
 	unsigned long i, range_scan, idx, idx_old;
+	union hws_trailer_header old, prev, new;
+	unsigned long long orig_overflow;
 	struct hws_trailer_entry *te;
 
 	debug_sprintf_event(sfdbg, 6, "%s: range %ld head %ld alert %ld "
@@ -1554,17 +1574,20 @@ static bool aux_reset_buffer(struct aux_buffer *aux, unsigned long range,
 	idx_old = idx = aux->empty_mark + 1;
 	for (i = 0; i < range_scan; i++, idx++) {
 		te = aux_sdb_trailer(aux, idx);
+		/* READ_ONCE() 16 byte header */
+		prev.val = __cdsg(&te->header.val, 0, 0);
 		do {
-			orig_flags = te->flags;
-			orig_overflow = te->overflow;
-			new_flags = orig_flags & ~SDB_TE_BUFFER_FULL_MASK;
+			old.val = prev.val;
+			new.val = prev.val;
+			orig_overflow = old.overflow;
+			new.f = 0;
+			new.overflow = 0;
 			if (idx == aux->alert_mark)
-				new_flags |= SDB_TE_ALERT_REQ_MASK;
+				new.a = 1;
 			else
-				new_flags &= ~SDB_TE_ALERT_REQ_MASK;
-		} while (!cmpxchg_double(&te->flags, &te->overflow,
-					 orig_flags, orig_overflow,
-					 new_flags, 0ULL));
+				new.a = 0;
+			prev.val = __cdsg(&te->header.val, old.val, new.val);
+		} while (prev.val != old.val);
 		*overflow += orig_overflow;
 	}
 
-- 
2.34.1


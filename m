Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC0E762B00
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jul 2023 07:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjGZF5E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jul 2023 01:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjGZF5B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jul 2023 01:57:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F0A26BD;
        Tue, 25 Jul 2023 22:56:59 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q5aTEO019229;
        Wed, 26 Jul 2023 05:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=GQTVWco32osMbk2/cDgsRNNHJ/PAdXnt/uP/dxBWZmo=;
 b=dINCYmzI1PSck87dnwSmRIA1EBFeKhmFi0EZ80bxFVj/bfxQFqPK/ECsKrGLlmdFMba5
 8f7FRRuoUXx6a5LmIirgth3Nn1P0mbVoSTogvlVTL+Kgq3n9dCJdsRTbg7i04LoUa5az
 bFlmosbrsvaKQEU4SQNIndmOOL5iJwuWzl7TtkHs+wB+HLC5gS1WQee8x40Lr4TWvQt5
 /EZKRy+bRYPqYqZNH0roNuiSEZ5nDIAbbgRWGhVn7DMW8Q5kj4tgTNjRLDQM7sePgWh4
 9/aX+pZ01vUUsvC50GNljxdu92wf1b0y4zPlF+19ekLYMQCkZIwMtvC+cuNvkqcayZnQ gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2vps1etd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 05:56:52 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36Q5avMk021098;
        Wed, 26 Jul 2023 05:56:51 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2vps1et5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 05:56:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q4bioJ026206;
        Wed, 26 Jul 2023 05:56:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0ses2sus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 05:56:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36Q5unpc19595972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 05:56:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 140072004B;
        Wed, 26 Jul 2023 05:56:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8789820040;
        Wed, 26 Jul 2023 05:56:48 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jul 2023 05:56:48 +0000 (GMT)
Received: from civic.. (unknown [9.177.6.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 95C02603C2;
        Wed, 26 Jul 2023 15:56:39 +1000 (AEST)
From:   Rohan McLure <rmclure@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rohan McLure <rmclure@linux.ibm.com>, linux-arch@vger.kernel.org,
        will.deacon@arm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        arnd@arndb.de, gautam@linux.ibm.com
Subject: [PATCH] asm-generic/mmiowb: Mark accesses to fix KCSAN warnings
Date:   Wed, 26 Jul 2023 15:56:32 +1000
Message-Id: <20230726055632.132151-1-rmclure@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XllLALy0oUtSgrkRkmMFhLCvdF2GpxRh
X-Proofpoint-ORIG-GUID: 9KNc4MrWoraArjRz5nnl3gnv0DoRzjTg
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=687 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Prior to this patch, data races are detectable by KCSAN of the following
forms:

[1] Asynchronous calls to mmiowb_set_pending() from an interrupt context
    or otherwise outside of a critical section
[2] Interrupted critical sections, where the interrupt will itself
    acquire a lock

In case [1], calling context does not need an mmiowb() call to be
issued, otherwise it would do so itself. Such calls to
mmiowb_set_pending() are either idempotent or no-ops.

In case [2], irrespective of when the interrupt occurs, the interrupt
will acquire and release its locks prior to its return, nesting_count
will continue balanced. In the worst case, the interrupted critical
section during a mmiowb_spin_unlock() call observes an mmiowb to be
pending and afterward is interrupted, leading to an extraneous call to
mmiowb(). This data race is clearly innocuous.

Resolve KCSAN warnings of type [1] by means of READ_ONCE, WRITE_ONCE.
As increments and decrements to nesting_count are balanced by interrupt
contexts, resolve type [2] warnings by simply revoking instrumentation,
with data_race() rather than READ_ONCE() and WRITE_ONCE(), the memory
consistency semantics of plain-accesses will still lead to correct
behaviour.

Signed-off-by: Rohan McLure <rmclure@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Moving from linuxppc-dev to broader LKML as it affects all
architectures.
https://lore.kernel.org/all/20230510033117.1395895-4-rmclure@linux.ibm.com/
---
 include/asm-generic/mmiowb.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
index 5698fca3bf56..f8c7c8a84e9e 100644
--- a/include/asm-generic/mmiowb.h
+++ b/include/asm-generic/mmiowb.h
@@ -37,25 +37,28 @@ static inline void mmiowb_set_pending(void)
 	struct mmiowb_state *ms = __mmiowb_state();
 
 	if (likely(ms->nesting_count))
-		ms->mmiowb_pending = ms->nesting_count;
+		WRITE_ONCE(ms->mmiowb_pending, ms->nesting_count);
 }
 
 static inline void mmiowb_spin_lock(void)
 {
 	struct mmiowb_state *ms = __mmiowb_state();
-	ms->nesting_count++;
+
+	/* Increment need not be atomic. Nestedness is balanced over interrupts. */
+	data_race(ms->nesting_count++);
 }
 
 static inline void mmiowb_spin_unlock(void)
 {
 	struct mmiowb_state *ms = __mmiowb_state();
+	u16 pending = READ_ONCE(ms->mmiowb_pending);
 
-	if (unlikely(ms->mmiowb_pending)) {
-		ms->mmiowb_pending = 0;
+	WRITE_ONCE(ms->mmiowb_pending, 0);
+	if (unlikely(pending))
 		mmiowb();
-	}
 
-	ms->nesting_count--;
+	/* Decrement need not be atomic. Nestedness is balanced over interrupts. */
+	data_race(ms->nesting_count--);
 }
 #else
 #define mmiowb_set_pending()		do { } while (0)
-- 
2.37.2


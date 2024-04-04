Return-Path: <linux-arch+bounces-3436-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9494897E3A
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 06:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65524284E7D
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 04:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985351AAC4;
	Thu,  4 Apr 2024 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DP9mSBmn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A350F18AF4;
	Thu,  4 Apr 2024 04:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712205604; cv=none; b=uktONWpaiBYBP9ByuYnqDYfwpRHIzuUc4rglIVoToVDYH/uei2DhOvDmaZVKx97cZhJRwRlEz2m9NGxMRZHoT+93rHF5Qkc7WxKNTHm/Y6AtKQXLop+7IpLB6kccEZvDfoVaAwDw06ZHp8Uri3gvhMHM8AO6+jkhH5RhStkrk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712205604; c=relaxed/simple;
	bh=yW5zh/WIH8R/yRb5Gwi6AMngO1LlznnvHlFhpdnXQ68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lvxC88c96Yy0vL/yjOEIWPnuoR5NPZcp9eLWrl6a05WtixEMiHJXN+JARqlnCj4GW2SBGIfcesbNDXxC7Tn3BO73EibZR+3M9xbzVGxPBeY/PpRaA2X1NspegZkIpwxln7XqQuK94rFDxntmKyD2JtpX51pVqbMTZxyBBHtsxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DP9mSBmn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4344QOaP009131;
	Thu, 4 Apr 2024 04:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=fGMDDAqpuyHFT8CKRZIXuj4gzQ7iSrp2EictdMfn1CE=;
 b=DP9mSBmnzD94+0HDDDTwpCcl/NqzDVUzytUGtkoc9JAg3mGiVEmhdsVbp9aRpiZil3q2
 hRXuYYZKxSRKAsvJiM+Tvc1rcGrdOuFvUXnROg5EGKJcH6kFbLugbRPrcEiOd7USIj57
 CMb+4NT6qbOuiXG7G1961fhMeJBCl+RjyY4B45GEoIrSzr4E38Eg5vhEtSsgFONdAcJu
 0gDSxYWo+xwcMWpfEbiDDI+l9QVnNVvbsaK1c53YfOraHh8a4D/nYJCExNRHYd/VQlI4
 6XEu6ShvG0vKCjiaR2KtsGH3tRS3BLm9YmbRwDnwzXcFceWNd+Wtvv88LSEV6XpiHIju 4A== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9mw902et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 04:39:42 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43441Bep008629;
	Thu, 4 Apr 2024 04:39:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epw1ysu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 04:39:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4344dbUS48103904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 04:39:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 025652004D;
	Thu,  4 Apr 2024 04:39:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88B222004B;
	Thu,  4 Apr 2024 04:39:36 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 04:39:36 +0000 (GMT)
Received: from socotra.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 706A36005D;
	Thu,  4 Apr 2024 15:39:31 +1100 (AEDT)
From: Rohan McLure <rmclure@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Rohan McLure <rmclure@linux.ibm.com>, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        will@kernel.org, arnd@arndb.de, gautam@linux.ibm.com
Subject: [PATCH] asm-generic/mmiowb: Mark accesses to fix KCSAN warnings
Date: Thu,  4 Apr 2024 15:38:53 +1100
Message-ID: <20240404043855.640578-2-rmclure@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KhBNUZPSy1wpOqZ_MTFza7poyGKrUl6y
X-Proofpoint-ORIG-GUID: KhBNUZPSy1wpOqZ_MTFza7poyGKrUl6y
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_26,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 phishscore=0 mlxlogscore=634 spamscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040028

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
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Previously discussed here:
https://lore.kernel.org/linuxppc-dev/20230510033117.1395895-4-rmclure@linux.ibm.com/
But pushed back due to affecting other architectures. Reissuing, to
linuxppc-dev, as it does not enact a functional change.
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
2.44.0



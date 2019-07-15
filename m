Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4101F69B62
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2019 21:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbfGOT2t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jul 2019 15:28:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40592 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfGOT2t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jul 2019 15:28:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FJO7Di018305;
        Mon, 15 Jul 2019 19:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=UpYz68J9SXKjrbYmMLBu27WLSWRHESOgO2cA0Dv9rEc=;
 b=PqyiOrfciKLM+Eu7h/+ffnZYAhF0Jhb8559fZ1toCjPSk5Sbs+46wJVoDd3qN3VcUBfq
 hiZYqojPjKGHAohKUfotJQ+r8QmWiYS6CbDYCLmmI+nDQsMeIw0AqmixDHaE0Bcl8EcT
 zIdxC9+W57ciXJu3otB3CwHrr+aZUPaWsUQrZUfu2pxEo+44QRkeouQZh+p3ONS4qU+t
 8r55ubLMvQaKaNSzJtlFWGJVeL3ZyognjQvaS3tXo+488S568jlFOT6dLAoCHX2nbmT1
 PTjgfrLwFVYbfl5Ww7SX2VMenDxZ348U2xU/ksCC9S1ZnPER4nGHJWnd3jRffwMnR8Sh hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tq6qtgj73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 19:28:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FJMe6T056368;
        Mon, 15 Jul 2019 19:26:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tq742prtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 19:26:00 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6FJPwo6031353;
        Mon, 15 Jul 2019 19:25:58 GMT
Received: from ol-bur-x5-4.us.oracle.com (/10.152.128.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 12:25:58 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: [PATCH v3 5/5] locking/qspinlock: Introduce the shuffle reduction optimization into CNA
Date:   Mon, 15 Jul 2019 15:25:36 -0400
Message-Id: <20190715192536.104548-6-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715192536.104548-1-alex.kogan@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150221
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150222
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This optimization reduces the probability threads will be shuffled between
the main and secondary queues when the secondary queue is empty.
It is helpful when the lock is only lightly contended.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock_cna.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 3de5be813a46..9e6bd9e6d82b 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -50,6 +50,15 @@ static DEFINE_PER_CPU(u32, seed);
 #define INTRA_NODE_HANDOFF_PROB_ARG 0x10000
 
 /*
+ * Controls the probability for enabling the scan of the main queue when
+ * the secondary queue is empty. The chosen value reduces the amount of
+ * unnecessary shuffling of threads between the two waiting queues when
+ * the contention is low, while responding fast enough and enabling
+ * the shuffling when the contention is high.
+ */
+#define SHUFFLE_REDUCTION_PROB_ARG  0x80
+
+/*
  * Return false with probability 1 / @range.
  * @range must be a power of 2.
  */
@@ -169,6 +178,16 @@ static inline void cna_pass_mcs_lock(struct mcs_spinlock *node,
 	u64 val = 1;
 
 	/*
+	 * Limit thread shuffling when the secondary queue is empty.
+	 * This copes with the overhead the shuffling creates when the
+	 * lock is only lightly contended, and threads do not stay
+	 * in the secondary queue long enough to reap the benefit of moving
+	 * them there.
+	 */
+	if (node->locked <= 1 && probably(SHUFFLE_REDUCTION_PROB_ARG))
+		goto pass_lock;
+
+	/*
 	 * Try to pass the lock to a thread running on the same node.
 	 * For long-term fairness, search for such a thread with high
 	 * probability rather than always.
@@ -194,5 +213,6 @@ static inline void cna_pass_mcs_lock(struct mcs_spinlock *node,
 		 * in the main queue.
 		 */
 
+pass_lock:
 	arch_mcs_spin_unlock_contended(var, val);
 }
-- 
2.11.0 (Apple Git-81)


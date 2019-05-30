Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 802242FE59
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfE3Ood (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:44:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726973AbfE3Omd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:33 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEe0UJ091383
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:32 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgm11rta-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:31 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:30 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:42:26 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEgPhN31391904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:42:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5D60B2072;
        Thu, 30 May 2019 14:42:24 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD2DEB206C;
        Thu, 30 May 2019 14:42:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:42:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9192C16C5D85; Thu, 30 May 2019 07:42:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Jonathan Corbet <corbet@lwn.net>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 05/33] Documentation: atomic_t.txt: Explain ordering provided by smp_mb__{before,after}_atomic()
Date:   Thu, 30 May 2019 07:41:57 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0072-0000-0000-000004354C31
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210779; UDB=6.00636154; IPR=6.00991814;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:42:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0073-0000-0000-00004C6B56B3
Message-Id: <20190530144225.27624-5-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=666 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300105
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

The description of smp_mb__before_atomic() and smp_mb__after_atomic()
in Documentation/atomic_t.txt is slightly terse and misleading.  It
does not clearly state which other instructions are ordered by these
barriers.

This improves the text to make the actual ordering implications clear,
and also to explain how these barriers differ from a RELEASE or
ACQUIRE ordering.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/atomic_t.txt | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index dca3fb0554db..b3afe69d03a1 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -187,8 +187,14 @@ The barriers:
 
   smp_mb__{before,after}_atomic()
 
-only apply to the RMW ops and can be used to augment/upgrade the ordering
-inherent to the used atomic op. These barriers provide a full smp_mb().
+only apply to the RMW atomic ops and can be used to augment/upgrade the
+ordering inherent to the op. These barriers act almost like a full smp_mb():
+smp_mb__before_atomic() orders all earlier accesses against the RMW op
+itself and all accesses following it, and smp_mb__after_atomic() orders all
+later accesses against the RMW op and all accesses preceding it. However,
+accesses between the smp_mb__{before,after}_atomic() and the RMW op are not
+ordered, so it is advisable to place the barrier right next to the RMW atomic
+op whenever possible.
 
 These helper barriers exist because architectures have varying implicit
 ordering on their SMP atomic primitives. For example our TSO architectures
@@ -212,7 +218,9 @@ Further, while something like:
   atomic_dec(&X);
 
 is a 'typical' RELEASE pattern, the barrier is strictly stronger than
-a RELEASE. Similarly for something like:
+a RELEASE because it orders preceding instructions against both the read
+and write parts of the atomic_dec(), and against all following instructions
+as well. Similarly, something like:
 
   atomic_inc(&X);
   smp_mb__after_atomic();
@@ -244,7 +252,8 @@ strictly stronger than ACQUIRE. As illustrated:
 
 This should not happen; but a hypothetical atomic_inc_acquire() --
 (void)atomic_fetch_inc_acquire() for instance -- would allow the outcome,
-since then:
+because it would not order the W part of the RMW against the following
+WRITE_ONCE.  Thus:
 
   P1			P2
 
-- 
2.17.1


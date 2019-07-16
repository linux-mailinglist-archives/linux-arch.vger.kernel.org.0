Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D74216ACDB
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfGPQdf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 12:33:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40912 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPQdf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 12:33:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GGSrPT022215;
        Tue, 16 Jul 2019 16:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=DjgqWqMR/0L7+yTOWg47+RG4y5Wc7SVUF1gML+2WuCE=;
 b=ngcD639Q89hovprhRfWyJ24KTIfCG58fXJKbXhci9SoWgMk/O/DjKMB3ieHqSVNDeHiU
 7amod2NsYNIFasielCNsqRFnuXODQeKRf2Br0bBcj7C1DEHbGuONcU9sX3wiJV5IzzU7
 aChX04mIbrNwzkkcUHKJ0Ne0C8rPoidnWNm3yABogs7YIweHM9BJJ2hRpDoyJ8vqXKmI
 eWtwn6G3YFh6ExuT3G5kf7DILQ6OXLaVuZ7IDQaAjVeBAwtLkZ70QMQTuhHj8iFI4TC0
 cbuSLvionZEI2USsh+3tyJO6vfQMF3gi2NyVwMB445MXV5gwSRzXB0TQYEYWjIRpajr4 Ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tq6qtnr7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 16:33:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GGSSVx068352;
        Tue, 16 Jul 2019 16:33:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tq6mn057m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 16:33:08 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GGWxbD026732;
        Tue, 16 Jul 2019 16:33:05 GMT
Received: from localhost.localdomain (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 16:32:59 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] padata: use smp_mb in padata_reorder to avoid orphaned padata jobs
Date:   Tue, 16 Jul 2019 12:32:53 -0400
Message-Id: <20190716163253.24377-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160203
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160203
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Testing padata with the tcrypt module on a 5.2 kernel...

    # modprobe tcrypt alg="pcrypt(rfc4106(gcm(aes)))" type=3
    # modprobe tcrypt mode=211 sec=1

...produces this splat:

    INFO: task modprobe:10075 blocked for more than 120 seconds.
          Not tainted 5.2.0-base+ #16
    modprobe        D    0 10075  10064 0x80004080
    Call Trace:
     ? __schedule+0x4dd/0x610
     ? ring_buffer_unlock_commit+0x23/0x100
     schedule+0x6c/0x90
     schedule_timeout+0x3b/0x320
     ? trace_buffer_unlock_commit_regs+0x4f/0x1f0
     wait_for_common+0x160/0x1a0
     ? wake_up_q+0x80/0x80
     { crypto_wait_req }             # entries in braces added by hand
     { do_one_aead_op }
     { test_aead_jiffies }
     test_aead_speed.constprop.17+0x681/0xf30 [tcrypt]
     do_test+0x4053/0x6a2b [tcrypt]
     ? 0xffffffffa00f4000
     tcrypt_mod_init+0x50/0x1000 [tcrypt]
     ...

The second modprobe command never finishes because in padata_reorder,
CPU0's load of reorder_objects is executed before the unlocking store in
spin_unlock_bh(pd->lock), causing CPU0 to miss CPU1's increment:

CPU0                                 CPU1

padata_reorder                       padata_do_serial
  LOAD reorder_objects  // 0
                                       INC reorder_objects  // 1
                                       padata_reorder
                                         TRYLOCK pd->lock   // failed
  UNLOCK pd->lock

CPU0 deletes the timer before returning from padata_reorder and since no
other job is submitted to padata, modprobe waits indefinitely.

Add a pair of full barriers to guarantee proper ordering:

CPU0                                 CPU1

padata_reorder                       padata_do_serial
  UNLOCK pd->lock
  smp_mb()
  LOAD reorder_objects
                                       INC reorder_objects
                                       smp_mb__after_atomic()
                                       padata_reorder
                                         TRYLOCK pd->lock

smp_mb__after_atomic is needed so the read part of the trylock operation
comes after the INC, as Andrea points out.   Thanks also to Andrea for
help with writing a litmus test.

Fixes: 16295bec6398 ("padata: Generic parallelization/serialization interface")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/padata.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/padata.c b/kernel/padata.c
index 2d2fddbb7a4c..15a8ad63f4ff 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -267,7 +267,12 @@ static void padata_reorder(struct parallel_data *pd)
 	 * The next object that needs serialization might have arrived to
 	 * the reorder queues in the meantime, we will be called again
 	 * from the timer function if no one else cares for it.
+	 *
+	 * Ensure reorder_objects is read after pd->lock is dropped so we see
+	 * an increment from another task in padata_do_serial.  Pairs with
+	 * smp_mb__after_atomic in padata_do_serial.
 	 */
+	smp_mb();
 	if (atomic_read(&pd->reorder_objects)
 			&& !(pinst->flags & PADATA_RESET))
 		mod_timer(&pd->timer, jiffies + HZ);
@@ -387,6 +392,13 @@ void padata_do_serial(struct padata_priv *padata)
 	list_add_tail(&padata->list, &pqueue->reorder.list);
 	spin_unlock(&pqueue->reorder.lock);
 
+	/*
+	 * Ensure the atomic_inc of reorder_objects above is ordered correctly
+	 * with the trylock of pd->lock in padata_reorder.  Pairs with smp_mb
+	 * in padata_reorder.
+	 */
+	smp_mb__after_atomic();
+
 	put_cpu();
 
 	/* If we're running on the wrong CPU, call padata_reorder() via a

base-commit: 0ecfebd2b52404ae0c54a878c872bb93363ada36
-- 
2.22.0


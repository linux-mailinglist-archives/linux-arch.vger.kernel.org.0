Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72F76617F
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2019 00:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfGKWMp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Jul 2019 18:12:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58080 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfGKWMp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jul 2019 18:12:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6BMB0Ng001209;
        Thu, 11 Jul 2019 22:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=bOgrwnSqTKvZ0m8xs//Fl1mVCaIRm5aAiMx4uhbuBow=;
 b=ro078IW5pmlFRK7tDFAxnz0r3X2PAFMeYPrJO/2awwvy8fZufdTD8ZU33+NAZywBd6mG
 393dxEDmH2GU4uBw4DVh62KKNiHMKSD34Np0fPeph1KZl6UC4U+5jjueLWtZE0RYWyQD
 XcI5AS2XjKGnf3jCfa1WOviES8KhJItzVpKQ2SHinjKUMdu4RCaieCy/wMs6EVkOe+22
 bJsQxntl4b7r1gIt1FQTTkeyF2W90sRBneFYlswK+r9PAc4ETc6uKUMbnGcsQ0nUYlr8
 t3T+XVdMhGdFHD7LTn/tw++swivApyTaS6vxD4KMpx8YDPmwCTcbxwQaldvKtL+8mEfG 0A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tjm9r2hn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jul 2019 22:12:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6BM7vmS099217;
        Thu, 11 Jul 2019 22:12:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tmwgyctc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jul 2019 22:12:14 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6BMCBBX002058;
        Thu, 11 Jul 2019 22:12:11 GMT
Received: from localhost.localdomain (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 15:12:11 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     steffen.klassert@secunet.com
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned padata jobs
Date:   Thu, 11 Jul 2019 18:12:05 -0400
Message-Id: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907110242
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907110242
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

Add a full barrier to prevent this scenario.  The hang was happening
about once every three runs, but now the test has finished successfully
fifty times in a row.

Fixes: 16295bec6398 ("padata: Generic parallelization/serialization interface")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

memory-barriers.txt says that a full barrier pairs with a release barrier, but
I'd appreciate a look from someone more familiar with barriers.  Thanks.

 kernel/padata.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/padata.c b/kernel/padata.c
index 2d2fddbb7a4c..9cffd4c303cb 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -267,7 +267,12 @@ static void padata_reorder(struct parallel_data *pd)
 	 * The next object that needs serialization might have arrived to
 	 * the reorder queues in the meantime, we will be called again
 	 * from the timer function if no one else cares for it.
+	 *
+	 * Ensure reorder_objects is read after pd->lock is dropped so we see
+	 * an increment from another task in padata_do_serial.  Pairs with
+	 * spin_unlock(&pqueue->reorder.lock) in padata_do_serial.
 	 */
+	smp_mb();
 	if (atomic_read(&pd->reorder_objects)
 			&& !(pinst->flags & PADATA_RESET))
 		mod_timer(&pd->timer, jiffies + HZ);

base-commit: 0ecfebd2b52404ae0c54a878c872bb93363ada36
-- 
2.22.0


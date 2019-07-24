Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC06D73CAD
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2019 22:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392188AbfGXT6N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jul 2019 15:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392179AbfGXT6N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jul 2019 15:58:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63ED7206BA;
        Wed, 24 Jul 2019 19:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998292;
        bh=l2GgUcWotZtTGa/g0fbn9MHmnXq6w1je5UVn5OXKTA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1bCBFOqhXbVyyZE+nPDC8AyWnRsgGgpsKa9mgf8GVmPZwY3IzgIMKFew6FI7IyjC
         qeRS5YkdIJSWCpypQVuGn/tZkJE8zuAVSGjsRvNgqttCl1BpBbhBqchxJt/gy6ytbk
         zLye3kJqxtd1HZYzvR1oa7FWUDLz+V1xbh6JAX+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH 5.1 315/371] padata: use smp_mb in padata_reorder to avoid orphaned padata jobs
Date:   Wed, 24 Jul 2019 21:21:07 +0200
Message-Id: <20190724191747.745523249@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Daniel Jordan <daniel.m.jordan@oracle.com>

commit cf144f81a99d1a3928f90b0936accfd3f45c9a0a upstream.

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
Cc: <stable@vger.kernel.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/padata.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -267,7 +267,12 @@ static void padata_reorder(struct parall
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
@@ -387,6 +392,13 @@ void padata_do_serial(struct padata_priv
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



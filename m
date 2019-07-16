Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 722646A994
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 15:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfGPNX5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 09:23:57 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59550 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfGPNX4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jul 2019 09:23:56 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hnNQq-0005hc-J5; Tue, 16 Jul 2019 21:23:48 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hnNQn-0000NI-G7; Tue, 16 Jul 2019 21:23:45 +0800
Date:   Tue, 16 Jul 2019 21:23:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        paulmck@linux.ibm.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH] padata: Use RCU when fetching pd from do_serial
Message-ID: <20190716132345.ujj2v3kqra2lbi75@gondor.apana.org.au>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
 <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
 <20190716111410.GN17989@gauss3.secunet.de>
 <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
 <20190716130928.ga4acvxipsdzyzlp@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716130928.ga4acvxipsdzyzlp@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 16, 2019 at 09:09:28PM +0800, Herbert Xu wrote:
>
> Hmm, it doesn't work because the refcnt is attached to the old
> pd.  That shouldn't be a problem though as we could simply ignore
> the refcnt in padata_flush_queue.

This should fix it:

---8<---
The function padata_do_serial uses parallel_data without obeying
the RCU rules around its life-cycle.  This means that a concurrent
padata_replace call can result in a crash.

This patch fixes it by using RCU just as we do in padata_do_parallel.

As the refcnt may now span two parallel_data structures, this patch
moves it to padata_instance instead.  FWIW the refcnt is used to
limit the number of outstanding requests (albeit a soft limit as
we don't do a proper atomic inc and test).

Fixes: 16295bec6398 ("padata: Generic parallelization/...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/padata.h b/include/linux/padata.h
index 5d13d25da2c8..ce51555cb86c 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -35,7 +35,7 @@
  * struct padata_priv -  Embedded to the users data structure.
  *
  * @list: List entry, to attach to the padata lists.
- * @pd: Pointer to the internal control structure.
+ * @inst: Pointer to the overall control structure.
  * @cb_cpu: Callback cpu for serializatioon.
  * @cpu: Cpu for parallelization.
  * @seq_nr: Sequence number of the parallelized data object.
@@ -45,7 +45,7 @@
  */
 struct padata_priv {
 	struct list_head	list;
-	struct parallel_data	*pd;
+	struct padata_instance	*inst;
 	int			cb_cpu;
 	int			cpu;
 	int			info;
@@ -120,7 +120,6 @@ struct padata_cpumask {
  * @pqueue: percpu padata queues used for parallelization.
  * @squeue: percpu padata queues used for serialuzation.
  * @reorder_objects: Number of objects waiting in the reorder queues.
- * @refcnt: Number of objects holding a reference on this parallel_data.
  * @max_seq_nr:  Maximal used sequence number.
  * @cpumask: The cpumasks in use for parallel and serial workers.
  * @lock: Reorder lock.
@@ -132,7 +131,6 @@ struct parallel_data {
 	struct padata_parallel_queue	__percpu *pqueue;
 	struct padata_serial_queue	__percpu *squeue;
 	atomic_t			reorder_objects;
-	atomic_t			refcnt;
 	atomic_t			seq_nr;
 	struct padata_cpumask		cpumask;
 	spinlock_t                      lock ____cacheline_aligned;
@@ -152,6 +150,7 @@ struct parallel_data {
  *            or both cpumasks change.
  * @kobj: padata instance kernel object.
  * @lock: padata instance lock.
+ * @refcnt: Number of objects holding a reference on this padata_instance.
  * @flags: padata flags.
  */
 struct padata_instance {
@@ -162,6 +161,7 @@ struct padata_instance {
 	struct blocking_notifier_head	 cpumask_change_notifier;
 	struct kobject                   kobj;
 	struct mutex			 lock;
+	atomic_t			refcnt;
 	u8				 flags;
 #define	PADATA_INIT	1
 #define	PADATA_RESET	2
diff --git a/kernel/padata.c b/kernel/padata.c
index 2d2fddbb7a4c..c86333fa3cec 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -123,12 +123,12 @@ int padata_do_parallel(struct padata_instance *pinst,
 	if ((pinst->flags & PADATA_RESET))
 		goto out;
 
-	if (atomic_read(&pd->refcnt) >= MAX_OBJ_NUM)
+	if (atomic_read(&pinst->refcnt) >= MAX_OBJ_NUM)
 		goto out;
 
 	err = 0;
-	atomic_inc(&pd->refcnt);
-	padata->pd = pd;
+	atomic_inc(&pinst->refcnt);
+	padata->inst = pinst;
 	padata->cb_cpu = cb_cpu;
 
 	target_cpu = padata_cpu_hash(pd);
@@ -347,7 +347,7 @@ static void padata_serial_worker(struct work_struct *serial_work)
 		list_del_init(&padata->list);
 
 		padata->serial(padata);
-		atomic_dec(&pd->refcnt);
+		atomic_dec(&pd->pinst->refcnt);
 	}
 	local_bh_enable();
 }
@@ -367,7 +367,7 @@ void padata_do_serial(struct padata_priv *padata)
 	struct parallel_data *pd;
 	int reorder_via_wq = 0;
 
-	pd = padata->pd;
+	pd = rcu_dereference_bh(padata->inst->pd);
 
 	cpu = get_cpu();
 
@@ -489,7 +489,6 @@ static struct parallel_data *padata_alloc_pd(struct padata_instance *pinst,
 	timer_setup(&pd->timer, padata_reorder_timer, 0);
 	atomic_set(&pd->seq_nr, -1);
 	atomic_set(&pd->reorder_objects, 0);
-	atomic_set(&pd->refcnt, 0);
 	pd->pinst = pinst;
 	spin_lock_init(&pd->lock);
 
@@ -535,8 +534,6 @@ static void padata_flush_queues(struct parallel_data *pd)
 		squeue = per_cpu_ptr(pd->squeue, cpu);
 		flush_work(&squeue->work);
 	}
-
-	BUG_ON(atomic_read(&pd->refcnt) != 0);
 }
 
 static void __padata_start(struct padata_instance *pinst)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

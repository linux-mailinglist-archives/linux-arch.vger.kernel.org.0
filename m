Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF9C6BB2C
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 13:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfGQLMH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 07:12:07 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59544 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQLMH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 07:12:07 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hnhqk-0004F7-83; Wed, 17 Jul 2019 19:11:54 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hnhqd-0003q3-Bn; Wed, 17 Jul 2019 19:11:47 +0800
Date:   Wed, 17 Jul 2019 19:11:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathias Krause <minipli@googlemail.com>
Subject: [PATCH] padata: Replace delayed timer with immediate workqueue in
 padata_reorder
Message-ID: <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716163253.24377-1-daniel.m.jordan@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 16, 2019 at 12:32:53PM -0400, Daniel Jordan wrote:
> Testing padata with the tcrypt module on a 5.2 kernel...

Thanks for the patch!

And here is an incremental patch to get rid of the timer that
appears to be an attempt at fixing a problem related to this.

---8<---
The function padata_reorder will use a timer when it cannot progress
while completed jobs are outstanding (pd->reorder_objects > 0).  This
is suboptimal as if we do end up using the timer then it would have
introduced a gratuitous delay of one second.

In fact we can easily distinguish between whether completed jobs
are outstanding and whether we can make progress.  All we have to
do is look at the next pqueue list.

This patch does that by replacing pd->processed with pd->cpu so
that the next pqueue is more accessible.

A work queue is used instead of the original try_again to avoid
hogging the CPU.

Note that we don't bother removing the work queue in
padata_flush_queues because the whole premise is broken.  You
cannot flush async crypto requests so it makes no sense to even
try.  A subsequent patch will fix it by replacing it with a ref
counting scheme.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/padata.h b/include/linux/padata.h
index 5d13d25da2c8..d803397a28f7 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -24,7 +24,6 @@
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
-#include <linux/timer.h>
 #include <linux/notifier.h>
 #include <linux/kobject.h>
 
@@ -85,18 +84,14 @@ struct padata_serial_queue {
  * @serial: List to wait for serialization after reordering.
  * @pwork: work struct for parallelization.
  * @swork: work struct for serialization.
- * @pd: Backpointer to the internal control structure.
  * @work: work struct for parallelization.
- * @reorder_work: work struct for reordering.
  * @num_obj: Number of objects that are processed by this cpu.
  * @cpu_index: Index of the cpu.
  */
 struct padata_parallel_queue {
        struct padata_list    parallel;
        struct padata_list    reorder;
-       struct parallel_data *pd;
        struct work_struct    work;
-       struct work_struct    reorder_work;
        atomic_t              num_obj;
        int                   cpu_index;
 };
@@ -122,10 +117,10 @@ struct padata_cpumask {
  * @reorder_objects: Number of objects waiting in the reorder queues.
  * @refcnt: Number of objects holding a reference on this parallel_data.
  * @max_seq_nr:  Maximal used sequence number.
+ * @cpu: Next CPU to be processed.
  * @cpumask: The cpumasks in use for parallel and serial workers.
+ * @reorder_work: work struct for reordering.
  * @lock: Reorder lock.
- * @processed: Number of already processed objects.
- * @timer: Reorder timer.
  */
 struct parallel_data {
 	struct padata_instance		*pinst;
@@ -134,10 +129,10 @@ struct parallel_data {
 	atomic_t			reorder_objects;
 	atomic_t			refcnt;
 	atomic_t			seq_nr;
+	int				cpu;
 	struct padata_cpumask		cpumask;
+	struct work_struct		reorder_work;
 	spinlock_t                      lock ____cacheline_aligned;
-	unsigned int			processed;
-	struct timer_list		timer;
 };
 
 /**
diff --git a/kernel/padata.c b/kernel/padata.c
index 15a8ad63f4ff..b5dfc21e976f 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -165,23 +165,12 @@ EXPORT_SYMBOL(padata_do_parallel);
  */
 static struct padata_priv *padata_get_next(struct parallel_data *pd)
 {
-	int cpu, num_cpus;
-	unsigned int next_nr, next_index;
 	struct padata_parallel_queue *next_queue;
 	struct padata_priv *padata;
 	struct padata_list *reorder;
+	int cpu = pd->cpu;
 
-	num_cpus = cpumask_weight(pd->cpumask.pcpu);
-
-	/*
-	 * Calculate the percpu reorder queue and the sequence
-	 * number of the next object.
-	 */
-	next_nr = pd->processed;
-	next_index = next_nr % num_cpus;
-	cpu = padata_index_to_cpu(pd, next_index);
 	next_queue = per_cpu_ptr(pd->pqueue, cpu);
-
 	reorder = &next_queue->reorder;
 
 	spin_lock(&reorder->lock);
@@ -192,7 +181,8 @@ static struct padata_priv *padata_get_next(struct parallel_data *pd)
 		list_del_init(&padata->list);
 		atomic_dec(&pd->reorder_objects);
 
-		pd->processed++;
+		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, 0,
+					    false);
 
 		spin_unlock(&reorder->lock);
 		goto out;
@@ -215,6 +205,7 @@ static void padata_reorder(struct parallel_data *pd)
 	struct padata_priv *padata;
 	struct padata_serial_queue *squeue;
 	struct padata_instance *pinst = pd->pinst;
+	struct padata_parallel_queue *next_queue;
 
 	/*
 	 * We need to ensure that only one cpu can work on dequeueing of
@@ -246,7 +237,6 @@ static void padata_reorder(struct parallel_data *pd)
 		 * so exit immediately.
 		 */
 		if (PTR_ERR(padata) == -ENODATA) {
-			del_timer(&pd->timer);
 			spin_unlock_bh(&pd->lock);
 			return;
 		}
@@ -265,70 +255,29 @@ static void padata_reorder(struct parallel_data *pd)
 
 	/*
 	 * The next object that needs serialization might have arrived to
-	 * the reorder queues in the meantime, we will be called again
-	 * from the timer function if no one else cares for it.
+	 * the reorder queues in the meantime.
 	 *
-	 * Ensure reorder_objects is read after pd->lock is dropped so we see
-	 * an increment from another task in padata_do_serial.  Pairs with
+	 * Ensure reorder queue is read after pd->lock is dropped so we see
+	 * new objects from another task in padata_do_serial.  Pairs with
 	 * smp_mb__after_atomic in padata_do_serial.
 	 */
 	smp_mb();
-	if (atomic_read(&pd->reorder_objects)
-			&& !(pinst->flags & PADATA_RESET))
-		mod_timer(&pd->timer, jiffies + HZ);
-	else
-		del_timer(&pd->timer);
 
-	return;
+	next_queue = per_cpu_ptr(pd->pqueue, pd->cpu);
+	if (!list_empty(&next_queue->reorder.list))
+		queue_work(pinst->wq, &pd->reorder_work);
 }
 
 static void invoke_padata_reorder(struct work_struct *work)
 {
-	struct padata_parallel_queue *pqueue;
 	struct parallel_data *pd;
 
 	local_bh_disable();
-	pqueue = container_of(work, struct padata_parallel_queue, reorder_work);
-	pd = pqueue->pd;
+	pd = container_of(work, struct parallel_data, reorder_work);
 	padata_reorder(pd);
 	local_bh_enable();
 }
 
-static void padata_reorder_timer(struct timer_list *t)
-{
-	struct parallel_data *pd = from_timer(pd, t, timer);
-	unsigned int weight;
-	int target_cpu, cpu;
-
-	cpu = get_cpu();
-
-	/* We don't lock pd here to not interfere with parallel processing
-	 * padata_reorder() calls on other CPUs. We just need any CPU out of
-	 * the cpumask.pcpu set. It would be nice if it's the right one but
-	 * it doesn't matter if we're off to the next one by using an outdated
-	 * pd->processed value.
-	 */
-	weight = cpumask_weight(pd->cpumask.pcpu);
-	target_cpu = padata_index_to_cpu(pd, pd->processed % weight);
-
-	/* ensure to call the reorder callback on the correct CPU */
-	if (cpu != target_cpu) {
-		struct padata_parallel_queue *pqueue;
-		struct padata_instance *pinst;
-
-		/* The timer function is serialized wrt itself -- no locking
-		 * needed.
-		 */
-		pinst = pd->pinst;
-		pqueue = per_cpu_ptr(pd->pqueue, target_cpu);
-		queue_work_on(target_cpu, pinst->wq, &pqueue->reorder_work);
-	} else {
-		padata_reorder(pd);
-	}
-
-	put_cpu();
-}
-
 static void padata_serial_worker(struct work_struct *serial_work)
 {
 	struct padata_serial_queue *squeue;
@@ -376,9 +325,8 @@ void padata_do_serial(struct padata_priv *padata)
 
 	cpu = get_cpu();
 
-	/* We need to run on the same CPU padata_do_parallel(.., padata, ..)
-	 * was called on -- or, at least, enqueue the padata object into the
-	 * correct per-cpu queue.
+	/* We need to enqueue the padata object into the correct
+	 * per-cpu queue.
 	 */
 	if (cpu != padata->cpu) {
 		reorder_via_wq = 1;
@@ -388,12 +336,12 @@ void padata_do_serial(struct padata_priv *padata)
 	pqueue = per_cpu_ptr(pd->pqueue, cpu);
 
 	spin_lock(&pqueue->reorder.lock);
-	atomic_inc(&pd->reorder_objects);
 	list_add_tail(&padata->list, &pqueue->reorder.list);
+	atomic_inc(&pd->reorder_objects);
 	spin_unlock(&pqueue->reorder.lock);
 
 	/*
-	 * Ensure the atomic_inc of reorder_objects above is ordered correctly
+	 * Ensure the addition to the reorder list is ordered correctly
 	 * with the trylock of pd->lock in padata_reorder.  Pairs with smp_mb
 	 * in padata_reorder.
 	 */
@@ -401,13 +349,7 @@ void padata_do_serial(struct padata_priv *padata)
 
 	put_cpu();
 
-	/* If we're running on the wrong CPU, call padata_reorder() via a
-	 * kernel worker.
-	 */
-	if (reorder_via_wq)
-		queue_work_on(cpu, pd->pinst->wq, &pqueue->reorder_work);
-	else
-		padata_reorder(pd);
+	padata_reorder(pd);
 }
 EXPORT_SYMBOL(padata_do_serial);
 
@@ -463,14 +405,12 @@ static void padata_init_pqueues(struct parallel_data *pd)
 			continue;
 		}
 
-		pqueue->pd = pd;
 		pqueue->cpu_index = cpu_index;
 		cpu_index++;
 
 		__padata_list_init(&pqueue->reorder);
 		__padata_list_init(&pqueue->parallel);
 		INIT_WORK(&pqueue->work, padata_parallel_worker);
-		INIT_WORK(&pqueue->reorder_work, invoke_padata_reorder);
 		atomic_set(&pqueue->num_obj, 0);
 	}
 }
@@ -498,12 +438,13 @@ static struct parallel_data *padata_alloc_pd(struct padata_instance *pinst,
 
 	padata_init_pqueues(pd);
 	padata_init_squeues(pd);
-	timer_setup(&pd->timer, padata_reorder_timer, 0);
 	atomic_set(&pd->seq_nr, -1);
 	atomic_set(&pd->reorder_objects, 0);
 	atomic_set(&pd->refcnt, 0);
 	pd->pinst = pinst;
 	spin_lock_init(&pd->lock);
+	pd->cpu = cpumask_first(pcpumask);
+	INIT_WORK(&pd->reorder_work, invoke_padata_reorder);
 
 	return pd;
 
@@ -538,8 +479,6 @@ static void padata_flush_queues(struct parallel_data *pd)
 		flush_work(&pqueue->work);
 	}
 
-	del_timer_sync(&pd->timer);
-
 	if (atomic_read(&pd->reorder_objects))
 		padata_reorder(pd);
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-arch+bounces-6342-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B46957753
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 00:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C9528224A
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 22:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20713196C7C;
	Mon, 19 Aug 2024 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRZb7jR0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74B21CF83;
	Mon, 19 Aug 2024 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724105883; cv=none; b=b1oKWWoTlhIQv//zfHG1kcuN5rjQ5b1ouzbwwUGqqjNRvuGQDPZN+SeYepFd0diNEdlYJcVPK3SPtBoUqLgrCjnfcDqqKjBtZ+dWvwCxKq5fJn24F50Ghpc3OkfFno+464DNARpXcRSQXbS0zyWXua0vGTajGPTDr/ugcA1/3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724105883; c=relaxed/simple;
	bh=10MGQHnzphKEk9Esk60iGVdwalyjCjuqsFu8E3ykbb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Er/jbp9Jje1I38C2qkBgJT+axgEbdQoDenyca3OMVHwKdWi50iGDe7UQXud1DFvjB2WEd7iCOVO5dKldkPHdcWqsQO6AY8dnDKNLrOCxLg15RbsqeBQVGVtc5uYGM4cGck0+WxPdvxZFeArZ5J8mSmwKDYL0ECa4WfDi3Pn6hcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRZb7jR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6F8C32782;
	Mon, 19 Aug 2024 22:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724105882;
	bh=10MGQHnzphKEk9Esk60iGVdwalyjCjuqsFu8E3ykbb4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rRZb7jR0I3j7bua1tIpvT7HeZ1aG/tQsENSGOwgP7apeczk661FS+DA2XGi3MSoHK
	 Ip324JnjwujNsUTP6K6ZneAELu7QjAGJLHAZc6Mtxdtw6g/p7CJZ1iHpza+7SMNQVP
	 zpOQVW7NZuy+BaWVCSwhvM5kwypE4XxJo8xglaH9I6RJFLj6WOY48M1sc5WQzECw5C
	 fSdJE+R1K1E8gyiwpbLrjfl70ZT510TSV4V+m5wc7ncB5AWmum1ushehkjeTSUPjL6
	 W5lJ4jr7nlsVeV/teYeVOiv2GZetyutvoIcMKZ34Mg+mF0f0gOH+hMzLw6j52Hqcgx
	 fiUQaYMY0H93A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0BC4BCE0A01; Mon, 19 Aug 2024 15:18:02 -0700 (PDT)
Date: Mon, 19 Aug 2024 15:18:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 9/9] rcu: Switch kvfree_rcu() to new rcu_pending
Message-ID: <b2f7b98f-0fcf-4fdf-82df-eb15f5a040e7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
 <20240819165939.745801-10-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819165939.745801-10-kent.overstreet@linux.dev>

On Mon, Aug 19, 2024 at 12:59:35PM -0400, Kent Overstreet wrote:
> This nets us a slight performance increase, and converts to common
> code.

How did you measure the performance, and what was the actual amount
of the increase?

Either way, the performance increase needs to be verified by the people
for whom the current code works well.  As noted a couple months ago,
I am having a hard time imagining a tree beating a linked list of pages
of pointers in terms of cache locality.  I added linux-arch on CC in
case I am out of date on how computer systems work.

In the meantime, I need you to hold off on this one.

							Thanx, Paul

> Todo - re-add the shrinker, so that memory reclaim can free expired
> objects and expedite a grace period when necessary.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  include/linux/rcu_pending.h |   2 +
>  init/main.c                 |   2 +
>  kernel/rcu/pending.c        |  20 +
>  kernel/rcu/tree.c           | 746 ------------------------------------
>  kernel/rcu/update.c         |   1 -
>  5 files changed, 24 insertions(+), 747 deletions(-)
> 
> diff --git a/include/linux/rcu_pending.h b/include/linux/rcu_pending.h
> index a875c640da8d..5ef6392ce180 100644
> --- a/include/linux/rcu_pending.h
> +++ b/include/linux/rcu_pending.h
> @@ -22,4 +22,6 @@ int rcu_pending_init(struct rcu_pending *pending,
>  		     struct srcu_struct *srcu,
>  		     rcu_pending_process_fn process);
>  
> +void __init kvfree_rcu_pending_init(void);
> +
>  #endif /* _LINUX_RCU_PENDING_H */
> diff --git a/init/main.c b/init/main.c
> index 206acdde51f5..a3f0fd6ec3da 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -43,6 +43,7 @@
>  #include <linux/profile.h>
>  #include <linux/kfence.h>
>  #include <linux/rcupdate.h>
> +#include <linux/rcu_pending.h>
>  #include <linux/srcu.h>
>  #include <linux/moduleparam.h>
>  #include <linux/kallsyms.h>
> @@ -993,6 +994,7 @@ void start_kernel(void)
>  	workqueue_init_early();
>  
>  	rcu_init();
> +	kvfree_rcu_pending_init();
>  
>  	/* Trace events are available after this */
>  	trace_init();
> diff --git a/kernel/rcu/pending.c b/kernel/rcu/pending.c
> index c0e2351ba198..9c57f373d494 100644
> --- a/kernel/rcu/pending.c
> +++ b/kernel/rcu/pending.c
> @@ -601,3 +601,23 @@ int rcu_pending_init(struct rcu_pending *pending,
>  
>  	return 0;
>  }
> +
> +#ifndef CONFIG_TINY_RCU
> +/* kvfree_rcu */
> +
> +static struct rcu_pending kvfree_rcu_pending;
> +
> +void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> +{
> +	BUG_ON(!ptr);
> +
> +	__rcu_pending_enqueue(&kvfree_rcu_pending, head, ptr, head == NULL);
> +}
> +EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> +
> +void __init kvfree_rcu_pending_init(void)
> +{
> +	if (rcu_pending_init(&kvfree_rcu_pending, NULL, RCU_PENDING_KVFREE_FN))
> +		panic("%s failed\n", __func__);
> +}
> +#endif
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 52f9f0bf1b8e..3bb6c81e2d30 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3216,702 +3216,6 @@ EXPORT_SYMBOL_GPL(call_rcu);
>  #define KFREE_N_BATCHES 2
>  #define FREE_N_CHANNELS 2
>  
> -/**
> - * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
> - * @list: List node. All blocks are linked between each other
> - * @gp_snap: Snapshot of RCU state for objects placed to this bulk
> - * @nr_records: Number of active pointers in the array
> - * @records: Array of the kvfree_rcu() pointers
> - */
> -struct kvfree_rcu_bulk_data {
> -	struct list_head list;
> -	struct rcu_gp_oldstate gp_snap;
> -	unsigned long nr_records;
> -	void *records[];
> -};
> -
> -/*
> - * This macro defines how many entries the "records" array
> - * will contain. It is based on the fact that the size of
> - * kvfree_rcu_bulk_data structure becomes exactly one page.
> - */
> -#define KVFREE_BULK_MAX_ENTR \
> -	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
> -
> -/**
> - * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
> - * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
> - * @head_free: List of kfree_rcu() objects waiting for a grace period
> - * @head_free_gp_snap: Grace-period snapshot to check for attempted premature frees.
> - * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
> - * @krcp: Pointer to @kfree_rcu_cpu structure
> - */
> -
> -struct kfree_rcu_cpu_work {
> -	struct rcu_work rcu_work;
> -	struct rcu_head *head_free;
> -	struct rcu_gp_oldstate head_free_gp_snap;
> -	struct list_head bulk_head_free[FREE_N_CHANNELS];
> -	struct kfree_rcu_cpu *krcp;
> -};
> -
> -/**
> - * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
> - * @head: List of kfree_rcu() objects not yet waiting for a grace period
> - * @head_gp_snap: Snapshot of RCU state for objects placed to "@head"
> - * @bulk_head: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
> - * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> - * @lock: Synchronize access to this structure
> - * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> - * @initialized: The @rcu_work fields have been initialized
> - * @head_count: Number of objects in rcu_head singular list
> - * @bulk_count: Number of objects in bulk-list
> - * @bkvcache:
> - *	A simple cache list that contains objects for reuse purpose.
> - *	In order to save some per-cpu space the list is singular.
> - *	Even though it is lockless an access has to be protected by the
> - *	per-cpu lock.
> - * @page_cache_work: A work to refill the cache when it is empty
> - * @backoff_page_cache_fill: Delay cache refills
> - * @work_in_progress: Indicates that page_cache_work is running
> - * @hrtimer: A hrtimer for scheduling a page_cache_work
> - * @nr_bkv_objs: number of allocated objects at @bkvcache.
> - *
> - * This is a per-CPU structure.  The reason that it is not included in
> - * the rcu_data structure is to permit this code to be extracted from
> - * the RCU files.  Such extraction could allow further optimization of
> - * the interactions with the slab allocators.
> - */
> -struct kfree_rcu_cpu {
> -	// Objects queued on a linked list
> -	// through their rcu_head structures.
> -	struct rcu_head *head;
> -	unsigned long head_gp_snap;
> -	atomic_t head_count;
> -
> -	// Objects queued on a bulk-list.
> -	struct list_head bulk_head[FREE_N_CHANNELS];
> -	atomic_t bulk_count[FREE_N_CHANNELS];
> -
> -	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> -	raw_spinlock_t lock;
> -	struct delayed_work monitor_work;
> -	bool initialized;
> -
> -	struct delayed_work page_cache_work;
> -	atomic_t backoff_page_cache_fill;
> -	atomic_t work_in_progress;
> -	struct hrtimer hrtimer;
> -
> -	struct llist_head bkvcache;
> -	int nr_bkv_objs;
> -};
> -
> -static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> -	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
> -};
> -
> -static __always_inline void
> -debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
> -{
> -#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> -	int i;
> -
> -	for (i = 0; i < bhead->nr_records; i++)
> -		debug_rcu_head_unqueue((struct rcu_head *)(bhead->records[i]));
> -#endif
> -}
> -
> -static inline struct kfree_rcu_cpu *
> -krc_this_cpu_lock(unsigned long *flags)
> -{
> -	struct kfree_rcu_cpu *krcp;
> -
> -	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
> -	krcp = this_cpu_ptr(&krc);
> -	raw_spin_lock(&krcp->lock);
> -
> -	return krcp;
> -}
> -
> -static inline void
> -krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
> -{
> -	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> -}
> -
> -static inline struct kvfree_rcu_bulk_data *
> -get_cached_bnode(struct kfree_rcu_cpu *krcp)
> -{
> -	if (!krcp->nr_bkv_objs)
> -		return NULL;
> -
> -	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs - 1);
> -	return (struct kvfree_rcu_bulk_data *)
> -		llist_del_first(&krcp->bkvcache);
> -}
> -
> -static inline bool
> -put_cached_bnode(struct kfree_rcu_cpu *krcp,
> -	struct kvfree_rcu_bulk_data *bnode)
> -{
> -	// Check the limit.
> -	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> -		return false;
> -
> -	llist_add((struct llist_node *) bnode, &krcp->bkvcache);
> -	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs + 1);
> -	return true;
> -}
> -
> -static int
> -drain_page_cache(struct kfree_rcu_cpu *krcp)
> -{
> -	unsigned long flags;
> -	struct llist_node *page_list, *pos, *n;
> -	int freed = 0;
> -
> -	if (!rcu_min_cached_objs)
> -		return 0;
> -
> -	raw_spin_lock_irqsave(&krcp->lock, flags);
> -	page_list = llist_del_all(&krcp->bkvcache);
> -	WRITE_ONCE(krcp->nr_bkv_objs, 0);
> -	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> -
> -	llist_for_each_safe(pos, n, page_list) {
> -		free_page((unsigned long)pos);
> -		freed++;
> -	}
> -
> -	return freed;
> -}
> -
> -static void
> -kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
> -	struct kvfree_rcu_bulk_data *bnode, int idx)
> -{
> -	unsigned long flags;
> -	int i;
> -
> -	if (!WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&bnode->gp_snap))) {
> -		debug_rcu_bhead_unqueue(bnode);
> -		rcu_lock_acquire(&rcu_callback_map);
> -		if (idx == 0) { // kmalloc() / kfree().
> -			trace_rcu_invoke_kfree_bulk_callback(
> -				rcu_state.name, bnode->nr_records,
> -				bnode->records);
> -
> -			kfree_bulk(bnode->nr_records, bnode->records);
> -		} else { // vmalloc() / vfree().
> -			for (i = 0; i < bnode->nr_records; i++) {
> -				trace_rcu_invoke_kvfree_callback(
> -					rcu_state.name, bnode->records[i], 0);
> -
> -				vfree(bnode->records[i]);
> -			}
> -		}
> -		rcu_lock_release(&rcu_callback_map);
> -	}
> -
> -	raw_spin_lock_irqsave(&krcp->lock, flags);
> -	if (put_cached_bnode(krcp, bnode))
> -		bnode = NULL;
> -	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> -
> -	if (bnode)
> -		free_page((unsigned long) bnode);
> -
> -	cond_resched_tasks_rcu_qs();
> -}
> -
> -static void
> -kvfree_rcu_list(struct rcu_head *head)
> -{
> -	struct rcu_head *next;
> -
> -	for (; head; head = next) {
> -		void *ptr = (void *) head->func;
> -		unsigned long offset = (void *) head - ptr;
> -
> -		next = head->next;
> -		debug_rcu_head_unqueue((struct rcu_head *)ptr);
> -		rcu_lock_acquire(&rcu_callback_map);
> -		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
> -
> -		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
> -			kvfree(ptr);
> -
> -		rcu_lock_release(&rcu_callback_map);
> -		cond_resched_tasks_rcu_qs();
> -	}
> -}
> -
> -/*
> - * This function is invoked in workqueue context after a grace period.
> - * It frees all the objects queued on ->bulk_head_free or ->head_free.
> - */
> -static void kfree_rcu_work(struct work_struct *work)
> -{
> -	unsigned long flags;
> -	struct kvfree_rcu_bulk_data *bnode, *n;
> -	struct list_head bulk_head[FREE_N_CHANNELS];
> -	struct rcu_head *head;
> -	struct kfree_rcu_cpu *krcp;
> -	struct kfree_rcu_cpu_work *krwp;
> -	struct rcu_gp_oldstate head_gp_snap;
> -	int i;
> -
> -	krwp = container_of(to_rcu_work(work),
> -		struct kfree_rcu_cpu_work, rcu_work);
> -	krcp = krwp->krcp;
> -
> -	raw_spin_lock_irqsave(&krcp->lock, flags);
> -	// Channels 1 and 2.
> -	for (i = 0; i < FREE_N_CHANNELS; i++)
> -		list_replace_init(&krwp->bulk_head_free[i], &bulk_head[i]);
> -
> -	// Channel 3.
> -	head = krwp->head_free;
> -	krwp->head_free = NULL;
> -	head_gp_snap = krwp->head_free_gp_snap;
> -	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> -
> -	// Handle the first two channels.
> -	for (i = 0; i < FREE_N_CHANNELS; i++) {
> -		// Start from the tail page, so a GP is likely passed for it.
> -		list_for_each_entry_safe(bnode, n, &bulk_head[i], list)
> -			kvfree_rcu_bulk(krcp, bnode, i);
> -	}
> -
> -	/*
> -	 * This is used when the "bulk" path can not be used for the
> -	 * double-argument of kvfree_rcu().  This happens when the
> -	 * page-cache is empty, which means that objects are instead
> -	 * queued on a linked list through their rcu_head structures.
> -	 * This list is named "Channel 3".
> -	 */
> -	if (head && !WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&head_gp_snap)))
> -		kvfree_rcu_list(head);
> -}
> -
> -static bool
> -need_offload_krc(struct kfree_rcu_cpu *krcp)
> -{
> -	int i;
> -
> -	for (i = 0; i < FREE_N_CHANNELS; i++)
> -		if (!list_empty(&krcp->bulk_head[i]))
> -			return true;
> -
> -	return !!READ_ONCE(krcp->head);
> -}
> -
> -static bool
> -need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp)
> -{
> -	int i;
> -
> -	for (i = 0; i < FREE_N_CHANNELS; i++)
> -		if (!list_empty(&krwp->bulk_head_free[i]))
> -			return true;
> -
> -	return !!krwp->head_free;
> -}
> -
> -static int krc_count(struct kfree_rcu_cpu *krcp)
> -{
> -	int sum = atomic_read(&krcp->head_count);
> -	int i;
> -
> -	for (i = 0; i < FREE_N_CHANNELS; i++)
> -		sum += atomic_read(&krcp->bulk_count[i]);
> -
> -	return sum;
> -}
> -
> -static void
> -schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> -{
> -	long delay, delay_left;
> -
> -	delay = krc_count(krcp) >= KVFREE_BULK_MAX_ENTR ? 1:KFREE_DRAIN_JIFFIES;
> -	if (delayed_work_pending(&krcp->monitor_work)) {
> -		delay_left = krcp->monitor_work.timer.expires - jiffies;
> -		if (delay < delay_left)
> -			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
> -		return;
> -	}
> -	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> -}
> -
> -static void
> -kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
> -{
> -	struct list_head bulk_ready[FREE_N_CHANNELS];
> -	struct kvfree_rcu_bulk_data *bnode, *n;
> -	struct rcu_head *head_ready = NULL;
> -	unsigned long flags;
> -	int i;
> -
> -	raw_spin_lock_irqsave(&krcp->lock, flags);
> -	for (i = 0; i < FREE_N_CHANNELS; i++) {
> -		INIT_LIST_HEAD(&bulk_ready[i]);
> -
> -		list_for_each_entry_safe_reverse(bnode, n, &krcp->bulk_head[i], list) {
> -			if (!poll_state_synchronize_rcu_full(&bnode->gp_snap))
> -				break;
> -
> -			atomic_sub(bnode->nr_records, &krcp->bulk_count[i]);
> -			list_move(&bnode->list, &bulk_ready[i]);
> -		}
> -	}
> -
> -	if (krcp->head && poll_state_synchronize_rcu(krcp->head_gp_snap)) {
> -		head_ready = krcp->head;
> -		atomic_set(&krcp->head_count, 0);
> -		WRITE_ONCE(krcp->head, NULL);
> -	}
> -	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> -
> -	for (i = 0; i < FREE_N_CHANNELS; i++) {
> -		list_for_each_entry_safe(bnode, n, &bulk_ready[i], list)
> -			kvfree_rcu_bulk(krcp, bnode, i);
> -	}
> -
> -	if (head_ready)
> -		kvfree_rcu_list(head_ready);
> -}
> -
> -/*
> - * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
> - */
> -static void kfree_rcu_monitor(struct work_struct *work)
> -{
> -	struct kfree_rcu_cpu *krcp = container_of(work,
> -		struct kfree_rcu_cpu, monitor_work.work);
> -	unsigned long flags;
> -	int i, j;
> -
> -	// Drain ready for reclaim.
> -	kvfree_rcu_drain_ready(krcp);
> -
> -	raw_spin_lock_irqsave(&krcp->lock, flags);
> -
> -	// Attempt to start a new batch.
> -	for (i = 0; i < KFREE_N_BATCHES; i++) {
> -		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
> -
> -		// Try to detach bulk_head or head and attach it, only when
> -		// all channels are free.  Any channel is not free means at krwp
> -		// there is on-going rcu work to handle krwp's free business.
> -		if (need_wait_for_krwp_work(krwp))
> -			continue;
> -
> -		// kvfree_rcu_drain_ready() might handle this krcp, if so give up.
> -		if (need_offload_krc(krcp)) {
> -			// Channel 1 corresponds to the SLAB-pointer bulk path.
> -			// Channel 2 corresponds to vmalloc-pointer bulk path.
> -			for (j = 0; j < FREE_N_CHANNELS; j++) {
> -				if (list_empty(&krwp->bulk_head_free[j])) {
> -					atomic_set(&krcp->bulk_count[j], 0);
> -					list_replace_init(&krcp->bulk_head[j],
> -						&krwp->bulk_head_free[j]);
> -				}
> -			}
> -
> -			// Channel 3 corresponds to both SLAB and vmalloc
> -			// objects queued on the linked list.
> -			if (!krwp->head_free) {
> -				krwp->head_free = krcp->head;
> -				get_state_synchronize_rcu_full(&krwp->head_free_gp_snap);
> -				atomic_set(&krcp->head_count, 0);
> -				WRITE_ONCE(krcp->head, NULL);
> -			}
> -
> -			// One work is per one batch, so there are three
> -			// "free channels", the batch can handle. It can
> -			// be that the work is in the pending state when
> -			// channels have been detached following by each
> -			// other.
> -			queue_rcu_work(system_wq, &krwp->rcu_work);
> -		}
> -	}
> -
> -	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> -
> -	// If there is nothing to detach, it means that our job is
> -	// successfully done here. In case of having at least one
> -	// of the channels that is still busy we should rearm the
> -	// work to repeat an attempt. Because previous batches are
> -	// still in progress.
> -	if (need_offload_krc(krcp))
> -		schedule_delayed_monitor_work(krcp);
> -}
> -
> -static enum hrtimer_restart
> -schedule_page_work_fn(struct hrtimer *t)
> -{
> -	struct kfree_rcu_cpu *krcp =
> -		container_of(t, struct kfree_rcu_cpu, hrtimer);
> -
> -	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
> -	return HRTIMER_NORESTART;
> -}
> -
> -static void fill_page_cache_func(struct work_struct *work)
> -{
> -	struct kvfree_rcu_bulk_data *bnode;
> -	struct kfree_rcu_cpu *krcp =
> -		container_of(work, struct kfree_rcu_cpu,
> -			page_cache_work.work);
> -	unsigned long flags;
> -	int nr_pages;
> -	bool pushed;
> -	int i;
> -
> -	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
> -		1 : rcu_min_cached_objs;
> -
> -	for (i = READ_ONCE(krcp->nr_bkv_objs); i < nr_pages; i++) {
> -		bnode = (struct kvfree_rcu_bulk_data *)
> -			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
> -
> -		if (!bnode)
> -			break;
> -
> -		raw_spin_lock_irqsave(&krcp->lock, flags);
> -		pushed = put_cached_bnode(krcp, bnode);
> -		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> -
> -		if (!pushed) {
> -			free_page((unsigned long) bnode);
> -			break;
> -		}
> -	}
> -
> -	atomic_set(&krcp->work_in_progress, 0);
> -	atomic_set(&krcp->backoff_page_cache_fill, 0);
> -}
> -
> -static void
> -run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> -{
> -	// If cache disabled, bail out.
> -	if (!rcu_min_cached_objs)
> -		return;
> -
> -	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> -			!atomic_xchg(&krcp->work_in_progress, 1)) {
> -		if (atomic_read(&krcp->backoff_page_cache_fill)) {
> -			queue_delayed_work(system_wq,
> -				&krcp->page_cache_work,
> -					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
> -		} else {
> -			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -			krcp->hrtimer.function = schedule_page_work_fn;
> -			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> -		}
> -	}
> -}
> -
> -// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
> -// state specified by flags.  If can_alloc is true, the caller must
> -// be schedulable and not be holding any locks or mutexes that might be
> -// acquired by the memory allocator or anything that it might invoke.
> -// Returns true if ptr was successfully recorded, else the caller must
> -// use a fallback.
> -static inline bool
> -add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> -	unsigned long *flags, void *ptr, bool can_alloc)
> -{
> -	struct kvfree_rcu_bulk_data *bnode;
> -	int idx;
> -
> -	*krcp = krc_this_cpu_lock(flags);
> -	if (unlikely(!(*krcp)->initialized))
> -		return false;
> -
> -	idx = !!is_vmalloc_addr(ptr);
> -	bnode = list_first_entry_or_null(&(*krcp)->bulk_head[idx],
> -		struct kvfree_rcu_bulk_data, list);
> -
> -	/* Check if a new block is required. */
> -	if (!bnode || bnode->nr_records == KVFREE_BULK_MAX_ENTR) {
> -		bnode = get_cached_bnode(*krcp);
> -		if (!bnode && can_alloc) {
> -			krc_this_cpu_unlock(*krcp, *flags);
> -
> -			// __GFP_NORETRY - allows a light-weight direct reclaim
> -			// what is OK from minimizing of fallback hitting point of
> -			// view. Apart of that it forbids any OOM invoking what is
> -			// also beneficial since we are about to release memory soon.
> -			//
> -			// __GFP_NOMEMALLOC - prevents from consuming of all the
> -			// memory reserves. Please note we have a fallback path.
> -			//
> -			// __GFP_NOWARN - it is supposed that an allocation can
> -			// be failed under low memory or high memory pressure
> -			// scenarios.
> -			bnode = (struct kvfree_rcu_bulk_data *)
> -				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
> -			raw_spin_lock_irqsave(&(*krcp)->lock, *flags);
> -		}
> -
> -		if (!bnode)
> -			return false;
> -
> -		// Initialize the new block and attach it.
> -		bnode->nr_records = 0;
> -		list_add(&bnode->list, &(*krcp)->bulk_head[idx]);
> -	}
> -
> -	// Finally insert and update the GP for this page.
> -	bnode->records[bnode->nr_records++] = ptr;
> -	get_state_synchronize_rcu_full(&bnode->gp_snap);
> -	atomic_inc(&(*krcp)->bulk_count[idx]);
> -
> -	return true;
> -}
> -
> -/*
> - * Queue a request for lazy invocation of the appropriate free routine
> - * after a grace period.  Please note that three paths are maintained,
> - * two for the common case using arrays of pointers and a third one that
> - * is used only when the main paths cannot be used, for example, due to
> - * memory pressure.
> - *
> - * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
> - * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
> - * be free'd in workqueue context. This allows us to: batch requests together to
> - * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
> - */
> -void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> -{
> -	unsigned long flags;
> -	struct kfree_rcu_cpu *krcp;
> -	bool success;
> -
> -	/*
> -	 * Please note there is a limitation for the head-less
> -	 * variant, that is why there is a clear rule for such
> -	 * objects: it can be used from might_sleep() context
> -	 * only. For other places please embed an rcu_head to
> -	 * your data.
> -	 */
> -	if (!head)
> -		might_sleep();
> -
> -	// Queue the object but don't yet schedule the batch.
> -	if (debug_rcu_head_queue(ptr)) {
> -		// Probable double kfree_rcu(), just leak.
> -		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> -			  __func__, head);
> -
> -		// Mark as success and leave.
> -		return;
> -	}
> -
> -	kasan_record_aux_stack_noalloc(ptr);
> -	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
> -	if (!success) {
> -		run_page_cache_worker(krcp);
> -
> -		if (head == NULL)
> -			// Inline if kvfree_rcu(one_arg) call.
> -			goto unlock_return;
> -
> -		head->func = ptr;
> -		head->next = krcp->head;
> -		WRITE_ONCE(krcp->head, head);
> -		atomic_inc(&krcp->head_count);
> -
> -		// Take a snapshot for this krcp.
> -		krcp->head_gp_snap = get_state_synchronize_rcu();
> -		success = true;
> -	}
> -
> -	/*
> -	 * The kvfree_rcu() caller considers the pointer freed at this point
> -	 * and likely removes any references to it. Since the actual slab
> -	 * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignore
> -	 * this object (no scanning or false positives reporting).
> -	 */
> -	kmemleak_ignore(ptr);
> -
> -	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> -	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
> -		schedule_delayed_monitor_work(krcp);
> -
> -unlock_return:
> -	krc_this_cpu_unlock(krcp, flags);
> -
> -	/*
> -	 * Inline kvfree() after synchronize_rcu(). We can do
> -	 * it from might_sleep() context only, so the current
> -	 * CPU can pass the QS state.
> -	 */
> -	if (!success) {
> -		debug_rcu_head_unqueue((struct rcu_head *) ptr);
> -		synchronize_rcu();
> -		kvfree(ptr);
> -	}
> -}
> -EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> -
> -static unsigned long
> -kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> -{
> -	int cpu;
> -	unsigned long count = 0;
> -
> -	/* Snapshot count of all CPUs */
> -	for_each_possible_cpu(cpu) {
> -		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> -
> -		count += krc_count(krcp);
> -		count += READ_ONCE(krcp->nr_bkv_objs);
> -		atomic_set(&krcp->backoff_page_cache_fill, 1);
> -	}
> -
> -	return count == 0 ? SHRINK_EMPTY : count;
> -}
> -
> -static unsigned long
> -kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> -{
> -	int cpu, freed = 0;
> -
> -	for_each_possible_cpu(cpu) {
> -		int count;
> -		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> -
> -		count = krc_count(krcp);
> -		count += drain_page_cache(krcp);
> -		kfree_rcu_monitor(&krcp->monitor_work.work);
> -
> -		sc->nr_to_scan -= count;
> -		freed += count;
> -
> -		if (sc->nr_to_scan <= 0)
> -			break;
> -	}
> -
> -	return freed == 0 ? SHRINK_STOP : freed;
> -}
> -
> -void __init kfree_rcu_scheduler_running(void)
> -{
> -	int cpu;
> -
> -	for_each_possible_cpu(cpu) {
> -		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> -
> -		if (need_offload_krc(krcp))
> -			schedule_delayed_monitor_work(krcp);
> -	}
> -}
> -
>  /*
>   * During early boot, any blocking grace-period wait automatically
>   * implies a grace period.
> @@ -5567,62 +4871,12 @@ static void __init rcu_dump_rcu_node_tree(void)
>  
>  struct workqueue_struct *rcu_gp_wq;
>  
> -static void __init kfree_rcu_batch_init(void)
> -{
> -	int cpu;
> -	int i, j;
> -	struct shrinker *kfree_rcu_shrinker;
> -
> -	/* Clamp it to [0:100] seconds interval. */
> -	if (rcu_delay_page_cache_fill_msec < 0 ||
> -		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
> -
> -		rcu_delay_page_cache_fill_msec =
> -			clamp(rcu_delay_page_cache_fill_msec, 0,
> -				(int) (100 * MSEC_PER_SEC));
> -
> -		pr_info("Adjusting rcutree.rcu_delay_page_cache_fill_msec to %d ms.\n",
> -			rcu_delay_page_cache_fill_msec);
> -	}
> -
> -	for_each_possible_cpu(cpu) {
> -		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> -
> -		for (i = 0; i < KFREE_N_BATCHES; i++) {
> -			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
> -			krcp->krw_arr[i].krcp = krcp;
> -
> -			for (j = 0; j < FREE_N_CHANNELS; j++)
> -				INIT_LIST_HEAD(&krcp->krw_arr[i].bulk_head_free[j]);
> -		}
> -
> -		for (i = 0; i < FREE_N_CHANNELS; i++)
> -			INIT_LIST_HEAD(&krcp->bulk_head[i]);
> -
> -		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> -		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
> -		krcp->initialized = true;
> -	}
> -
> -	kfree_rcu_shrinker = shrinker_alloc(0, "rcu-kfree");
> -	if (!kfree_rcu_shrinker) {
> -		pr_err("Failed to allocate kfree_rcu() shrinker!\n");
> -		return;
> -	}
> -
> -	kfree_rcu_shrinker->count_objects = kfree_rcu_shrink_count;
> -	kfree_rcu_shrinker->scan_objects = kfree_rcu_shrink_scan;
> -
> -	shrinker_register(kfree_rcu_shrinker);
> -}
> -
>  void __init rcu_init(void)
>  {
>  	int cpu = smp_processor_id();
>  
>  	rcu_early_boot_tests();
>  
> -	kfree_rcu_batch_init();
>  	rcu_bootup_announce();
>  	sanitize_kthread_prio();
>  	rcu_init_geometry();
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index f8436969e0c8..82ca9f490d7c 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -273,7 +273,6 @@ static int __init rcu_set_runtime_mode(void)
>  {
>  	rcu_test_sync_prims();
>  	rcu_scheduler_active = RCU_SCHEDULER_RUNNING;
> -	kfree_rcu_scheduler_running();
>  	rcu_test_sync_prims();
>  	return 0;
>  }
> -- 
> 2.45.2
> 


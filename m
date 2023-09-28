Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2417B136D
	for <lists+linux-arch@lfdr.de>; Thu, 28 Sep 2023 08:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjI1G6e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Sep 2023 02:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjI1G6d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2023 02:58:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323FAA3;
        Wed, 27 Sep 2023 23:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695884311; x=1727420311;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=JofXpw1bOW3v38Hb+V5kbppVqmDvDlTdh249KZrz0MU=;
  b=JNt4nCELeq5/4flyw0Q5l1lTlg1UKhMOEE/S/xXsJFF8iQSV/ATKh6ea
   bEmpqLh+pHIVY8kIovIq5Ard1ZHWjHs3Rw5DDW4j7rZkhzsSOSsyFuRYH
   qjV6WkdVhGugsilVMIhILUhZdWLA89Ou3N+NtC+F8kWa4uv8otWSQHVo/
   oIHSzEJvFZkJk3x6ZeIj3CF0GuG+5MsZe+5kbUsVYm/hu7Tq89vKGehDJ
   QLKJJLxqa9zdO2PsRfmduA28rQQwze1m3e6skTwvbBQgO8Oy9T5cxJ2jk
   f99ucVptzlzmk9taGnahi6mKA5sSQTCUqlnQ+ma6pdS9VVqMqtddOnbWw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="468282348"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="468282348"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 23:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784592396"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="784592396"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 23:58:24 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ravi Jonnalagadda <ravis.opensrc@micron.com>
Cc:     <linux-mm@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dietmar.eggemann@arm.com>, <vincent.guittot@linaro.org>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        <aneesh.kumar@linux.ibm.com>, <gregory.price@memverge.com>,
        <jgroves@micron.com>, <sthanneeru@micron.com>,
        <emirakhur@micron.com>, <vtanna@micron.com>
Subject: Re: [PATCH 2/2] mm: mempolicy: Interleave policy for tiered memory
 nodes
References: <20230927095002.10245-1-ravis.opensrc@micron.com>
        <20230927095002.10245-3-ravis.opensrc@micron.com>
Date:   Thu, 28 Sep 2023 14:56:18 +0800
In-Reply-To: <20230927095002.10245-3-ravis.opensrc@micron.com> (Ravi
        Jonnalagadda's message of "Wed, 27 Sep 2023 15:20:02 +0530")
Message-ID: <87pm22rdkd.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ravi Jonnalagadda <ravis.opensrc@micron.com> writes:

> From: Srinivasulu Thanneeru <sthanneeru@micron.com>
>
> Existing interleave policy spreads out pages evenly across a set of
> specified nodes, i.e. 1:1 interleave. Upcoming tiered memory systems
> have CPU-less memory nodes with different peak bandwidth and
> latency-bandwidth characteristics. In such systems, we will want to
> use the additional bandwidth provided by lowtier memory for
> bandwidth-intensive applications. However, the default 1:1 interleave
> can lead to suboptimal bandwidth distribution.
>
> Introduce an interleave policy for multi-tiers that is based on
> interleave weights, where pages are assigned from nodes of the tier
> based on the tier weight.
>
> For instance, 50:30:20 are the weights of tiers 0, 1, and 3, which

Does this mean we will allocate 50 pages from node 0 before allocating from
node 1?  If so, do we need to divide GCD (greatest common divisor)
before using the weight?  That is, use 5:3:2?

> leads to a 50%/30%/20% traffic breakdown across the three tiers.
>
> Signed-off-by: Srinivasulu Thanneeru <sthanneeru@micron.com>
> Co-authored-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
> ---
>  include/linux/memory-tiers.h |  25 +++++++-
>  include/linux/sched.h        |   2 +
>  mm/memory-tiers.c            |  31 ++--------
>  mm/mempolicy.c               | 107 +++++++++++++++++++++++++++++++++--
>  4 files changed, 132 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index c62d286749d0..74be39cb56c4 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_MEMORY_TIERS_H
>  #define _LINUX_MEMORY_TIERS_H
>  
> +#include <linux/device.h>
>  #include <linux/types.h>
>  #include <linux/nodemask.h>
>  #include <linux/kref.h>
> @@ -21,7 +22,27 @@
>  
>  #define MAX_TIER_INTERLEAVE_WEIGHT 100
>  
> -struct memory_tier;
> +struct memory_tier {
> +	/* hierarchy of memory tiers */
> +	struct list_head list;
> +	/* list of all memory types part of this tier */
> +	struct list_head memory_types;
> +	/*
> +	 * By default all tiers will have weight as 1, which means they
> +	 * follow default standard allocation.
> +	 */
> +	unsigned short interleave_weight;
> +	/*
> +	 * start value of abstract distance. memory tier maps
> +	 * an abstract distance  range,
> +	 * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
> +	 */
> +	int adistance_start;
> +	struct device dev;
> +	/* All the nodes that are part of all the lower memory tiers. */
> +	nodemask_t lower_tier_mask;
> +};
> +
>  struct memory_dev_type {
>  	/* list of memory types that are part of same tier as this type */
>  	struct list_head tier_sibiling;
> @@ -38,6 +59,8 @@ struct memory_dev_type *alloc_memory_type(int adistance);
>  void put_memory_type(struct memory_dev_type *memtype);
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
>  void clear_node_memory_type(int node, struct memory_dev_type *memtype);
> +struct memory_tier *node_get_memory_tier(int node);
> +nodemask_t get_memtier_nodemask(struct memory_tier *memtier);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 77f01ac385f7..07ea837c3afb 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1252,7 +1252,9 @@ struct task_struct {
>  	/* Protected by alloc_lock: */
>  	struct mempolicy		*mempolicy;
>  	short				il_prev;
> +	unsigned short			il_count;
>  	short				pref_node_fork;
> +	unsigned int			current_node;

current_node is only used for interleave?  If so, how about follow the
same naming convention, that is, il_XXX?

>  #endif
>  #ifdef CONFIG_NUMA_BALANCING
>  	int				numa_scan_seq;
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 7e06c9e0fa41..5e2ddc9f994a 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -8,27 +8,6 @@
>  
>  #include "internal.h"
>  
> -struct memory_tier {
> -	/* hierarchy of memory tiers */
> -	struct list_head list;
> -	/* list of all memory types part of this tier */
> -	struct list_head memory_types;
> -	/*
> -	 * By default all tiers will have weight as 1, which means they
> -	 * follow default standard allocation.
> -	 */
> -	unsigned short interleave_weight;
> -	/*
> -	 * start value of abstract distance. memory tier maps
> -	 * an abstract distance  range,
> -	 * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
> -	 */
> -	int adistance_start;
> -	struct device dev;
> -	/* All the nodes that are part of all the lower memory tiers. */
> -	nodemask_t lower_tier_mask;
> -};
> -
>  struct demotion_nodes {
>  	nodemask_t preferred;
>  };
> @@ -115,7 +94,7 @@ static inline struct memory_tier *to_memory_tier(struct device *device)
>  	return container_of(device, struct memory_tier, dev);
>  }
>  
> -static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
> +nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
>  {
>  	nodemask_t nodes = NODE_MASK_NONE;
>  	struct memory_dev_type *memtype;
> @@ -264,7 +243,7 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>  	return memtier;
>  }
>  
> -static struct memory_tier *__node_get_memory_tier(int node)
> +struct memory_tier *node_get_memory_tier(int node)
>  {
>  	pg_data_t *pgdat;
>  
> @@ -380,7 +359,7 @@ static void disable_all_demotion_targets(void)
>  		 * We are holding memory_tier_lock, it is safe
>  		 * to access pgda->memtier.
>  		 */
> -		memtier = __node_get_memory_tier(node);
> +		memtier = node_get_memory_tier(node);
>  		if (memtier)
>  			memtier->lower_tier_mask = NODE_MASK_NONE;
>  	}
> @@ -417,7 +396,7 @@ static void establish_demotion_targets(void)
>  		best_distance = -1;
>  		nd = &node_demotion[node];
>  
> -		memtier = __node_get_memory_tier(node);
> +		memtier = node_get_memory_tier(node);
>  		if (!memtier || list_is_last(&memtier->list, &memory_tiers))
>  			continue;
>  		/*
> @@ -562,7 +541,7 @@ static bool clear_node_memory_tier(int node)
>  	 * This also enables us to free the destroyed memory tier
>  	 * with kfree instead of kfree_rcu
>  	 */
> -	memtier = __node_get_memory_tier(node);
> +	memtier = node_get_memory_tier(node);
>  	if (memtier) {
>  		struct memory_dev_type *memtype;
>  
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 42b5567e3773..4f80c6ee1176 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -100,6 +100,8 @@
>  #include <linux/ctype.h>
>  #include <linux/mm_inline.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/memory-tiers.h>
> +#include <linux/nodemask.h>
>  #include <linux/printk.h>
>  #include <linux/swapops.h>
>  
> @@ -882,8 +884,11 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
>  
>  	old = current->mempolicy;
>  	current->mempolicy = new;
> -	if (new && new->mode == MPOL_INTERLEAVE)
> +	if (new && new->mode == MPOL_INTERLEAVE) {
>  		current->il_prev = MAX_NUMNODES-1;
> +		current->il_count = 0;
> +		current->current_node = MAX_NUMNODES;
> +	}
>  	task_unlock(current);
>  	mpol_put(old);
>  	ret = 0;
> @@ -1899,13 +1904,76 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
>  	return nd;
>  }
>  
> +/* Return interleave weight of node from tier's weight */
> +static unsigned short node_interleave_weight(int nid, nodemask_t pol_nodemask)
> +{
> +	struct memory_tier *memtier;
> +	nodemask_t tier_nodes, tier_and_pol;
> +	unsigned short avrg_weight = 0;
> +	int node, nnodes, reminder;
> +
> +	memtier = node_get_memory_tier(nid);

node_get_memory_tier() must be called with memory_tier_lock held.  Or
some other locking mechanism needs to be provided.  For example, RCU
read lock.

> +
> +	if (!memtier)
> +		return 0;
> +
> +	tier_nodes = get_memtier_nodemask(memtier);

get_memtier_nodemask() must be called with memory_tier_lock held too.

> +	nodes_and(tier_and_pol, tier_nodes, pol_nodemask);
> +	nnodes = nodes_weight(tier_and_pol);
> +	if (!nnodes)
> +		return 0;
> +
> +	avrg_weight = memtier->interleave_weight / nnodes;
> +	/* Set minimum weight of node as 1 so that at least one page
> +	 * is allocated.
> +	 */
> +	if (!avrg_weight)
> +		return 1;
> +
> +	reminder = memtier->interleave_weight % nnodes;
> +	if (reminder) {
> +		for_each_node_mask(node, tier_and_pol) {
> +			/* Increment target node's weight by 1, if it falls
> +			 * within remaining weightage 'reminder'.
> +			 */
> +			if (node == nid) {
> +				if (reminder > 0)
> +					avrg_weight = avrg_weight + 1;
> +				break;
> +			}
> +			reminder--;
> +		}
> +	}
> +	return avrg_weight;
> +}
> +
>  /* Do dynamic interleaving for a process */
>  static unsigned interleave_nodes(struct mempolicy *policy)
>  {
>  	unsigned next;
>  	struct task_struct *me = current;
> +	unsigned short node_weight = 0;
>  
> -	next = next_node_in(me->il_prev, policy->nodes);
> +	/* select current node or next node from nodelist based on
> +	 * available tier interleave weight.
> +	 */
> +	if (me->current_node == MAX_NUMNODES)
> +		next = next_node_in(me->il_prev, policy->nodes);
> +	else
> +		next = me->current_node;
> +	node_weight = node_interleave_weight(next, policy->nodes);
> +	if (!node_weight)
> +		goto set_il_prev;
> +	if (me->il_count < node_weight) {
> +		me->il_count++;
> +		me->current_node = next;
> +		if (me->il_count == node_weight) {
> +			me->current_node = MAX_NUMNODES;
> +			me->il_count = 0;
> +		}
> +	}
> +
> +set_il_prev:
>  	if (next < MAX_NUMNODES)
>  		me->il_prev = next;

I felt that we can implement the algorithm without introducing
current->current_node (use current->il_prev for it).  But I haven't
written the code.  So, I may be wrong here.

>  	return next;
> @@ -1966,9 +2034,10 @@ unsigned int mempolicy_slab_node(void)
>  static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
>  {
>  	nodemask_t nodemask = pol->nodes;
> -	unsigned int target, nnodes;
> -	int i;
> -	int nid;
> +	unsigned int target, nnodes, vnnodes = 0;
> +	unsigned short node_weight = 0;
> +	int nid, vtarget, i;
> +
>  	/*
>  	 * The barrier will stabilize the nodemask in a register or on
>  	 * the stack so that it will stop changing under the code.
> @@ -1981,7 +2050,33 @@ static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
>  	nnodes = nodes_weight(nodemask);
>  	if (!nnodes)
>  		return numa_node_id();
> -	target = (unsigned int)n % nnodes;
> +
> +	/*
> +	 * Calculate the virtual target for @n in a nodelist that is scaled
> +	 * with interleave weights....
> +	 */
> +	for_each_node_mask(nid, nodemask) {
> +		node_weight = node_interleave_weight(nid, nodemask);
> +		if (!node_weight)
> +			continue;
> +		vnnodes += node_weight;
> +	}
> +	if (!vnnodes)
> +		return numa_node_id();
> +	vtarget = (int)((unsigned int)n % vnnodes);
> +
> +	/* ...then map it back to the physical nodelist */
> +	target = 0;
> +	for_each_node_mask(nid, nodemask) {
> +		node_weight = node_interleave_weight(nid, nodemask);
> +		if (!node_weight)
> +			continue;
> +		vtarget -= node_weight;
> +		if (vtarget < 0)
> +			break;
> +		target++;
> +	}
> +
>  	nid = first_node(nodemask);
>  	for (i = 0; i < target; i++)
>  		nid = next_node(nid, nodemask);

--
Best Regards,
Huang, Ying

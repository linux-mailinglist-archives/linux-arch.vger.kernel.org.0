Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F67B5098
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 12:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbjJBKs2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 06:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjJBKs2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 06:48:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB1BAB;
        Mon,  2 Oct 2023 03:48:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rzd315QqLz68409;
        Mon,  2 Oct 2023 18:48:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 11:48:20 +0100
Date:   Mon, 2 Oct 2023 11:48:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ravi Jonnalagadda <ravis.opensrc@micron.com>
CC:     <linux-mm@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dietmar.eggemann@arm.com>, <vincent.guittot@linaro.org>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        <aneesh.kumar@linux.ibm.com>, <gregory.price@memverge.com>,
        <ying.huang@intel.com>, <jgroves@micron.com>,
        <sthanneeru@micron.com>, <emirakhur@micron.com>,
        <vtanna@micron.com>
Subject: Re: [PATCH 2/2] mm: mempolicy: Interleave policy for tiered memory
 nodes
Message-ID: <20231002114819.00000d95@Huawei.com>
In-Reply-To: <20230927095002.10245-3-ravis.opensrc@micron.com>
References: <20230927095002.10245-1-ravis.opensrc@micron.com>
        <20230927095002.10245-3-ravis.opensrc@micron.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 27 Sep 2023 15:20:02 +0530
Ravi Jonnalagadda <ravis.opensrc@micron.com> wrote:

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
> leads to a 50%/30%/20% traffic breakdown across the three tiers.
> 
> Signed-off-by: Srinivasulu Thanneeru <sthanneeru@micron.com>
> Co-authored-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>

Generally I'd expect to see a sign off from the co-author as well
as the Co-authored-by tag.

A few comments inline.  I'm far from an expert in this corner
of the kernels, so somewhat of a drive by review as I was curious.

Jonathan

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

As Gregory pointed out - these moves in a precursor patch would make this one
easier to follow.


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
>  #endif
>  #ifdef CONFIG_NUMA_BALANCING
>  	int				numa_scan_seq;



> @@ -115,7 +94,7 @@ static inline struct memory_tier *to_memory_tier(struct device *device)
>  	return container_of(device, struct memory_tier, dev);
>  }
>  
> -static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
> +nodemask_t get_memtier_nodemask(struct memory_tier *memtier)

Should remain static...

>  {
>  	nodemask_t nodes = NODE_MASK_NONE;
>  	struct memory_dev_type *memtype;
> @@ -264,7 +243,7 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>  	return memtier;
>  }
>  
> -static struct memory_tier *__node_get_memory_tier(int node)
> +struct memory_tier *node_get_memory_tier(int node)

There is a bunch of renaming in here.  I would pull that out as separate patch
(as with the structure move etc) so that we can see clear reasoning for
why the renaming.  I'm not sure in this case what the __ was conveying
so good to see an explanation of why it is being dropped.

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
> +
Trivial: Generally I'd keep error checks right next to what they are checking.
So no blank line here.
> +	if (!memtier)
> +		return 0;
> +
> +	tier_nodes = get_memtier_nodemask(memtier);
> +	nodes_and(tier_and_pol, tier_nodes, pol_nodemask);
> +	nnodes = nodes_weight(tier_and_pol);
> +	if (!nnodes)
> +		return 0;
> +
> +	avrg_weight = memtier->interleave_weight / nnodes;
> +	/* Set minimum weight of node as 1 so that at least one page

Comment syntax as below.

> +	 * is allocated.
> +	 */
> +	if (!avrg_weight)
> +		return 1;
> +
> +	reminder = memtier->interleave_weight % nnodes;
> +	if (reminder) {

remainder?

> +		for_each_node_mask(node, tier_and_pol) {
> +			/* Increment target node's weight by 1, if it falls
Comment syntax
> +			 * within remaining weightage 'reminder'.
> +			 */
> +			if (node == nid) {
> +				if (reminder > 0)
> +					avrg_weight = avrg_weight + 1;

					avrg_weight++;

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
Comment syntax should match surrounding code. Looks to use
/*
 * select...


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

Does this save enough to bother rather than just running the check below?
I'm not quite sure what we have to have opted in on to get to this point.
IF it is a useful optimization as it's common for !nnodes then add a comment
perhaps?

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
Adding 0 cheaper than checking for 0 so drop this check.

> +		vnnodes += node_weight;
> +	}
> +	if (!vnnodes)
> +		return numa_node_id();
> +	vtarget = (int)((unsigned int)n % vnnodes);

What sort of number of nodes do we ultimately expect? Is it worth
a more sophisticated structure in here?

I guess likely to be small though so maybe not.

> +
> +	/* ...then map it back to the physical nodelist */
> +	target = 0;
> +	for_each_node_mask(nid, nodemask) {
> +		node_weight = node_interleave_weight(nid, nodemask);
> +		if (!node_weight)
> +			continue;
Why allow nodes weight of 0?
Probably cheaper not to check this though that depends on what
the compiler gets up to.  You'd hope CPU will predict following
branch not taken if it wasn't previous time, so that's probably free.

> +		vtarget -= node_weight;
> +		if (vtarget < 0)
> +			break;
> +		target++;

If node_weight was 0, the code below still needs to go past the node.
So I think target == nnodes


> +	}
> +
>  	nid = first_node(nodemask);
>  	for (i = 0; i < target; i++)
>  		nid = next_node(nid, nodemask);


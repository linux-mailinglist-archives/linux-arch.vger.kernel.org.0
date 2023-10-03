Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C832E7B5E1F
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 02:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbjJCAWU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 20:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbjJCAWL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 20:22:11 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3998CE;
        Mon,  2 Oct 2023 17:22:07 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-1e10ba12fd3so208593fac.1;
        Mon, 02 Oct 2023 17:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696292527; x=1696897327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+oV1ZgyPCblrOh65x12ZqFYHoDSqMkCfYV5/Np3CLc=;
        b=iGSn5mlZ9uN3glRU+nqG/iL5dxscvtmbjxqGcGlkJ5bpoEhj6J7YK32DjiU+YDpTHF
         JwHBR3hWl4rX4aziRVgpcehOK2oBbbZ5Yft9lCQpVAVZYOQvdQrxUn3CI7Nrcwmzb8C/
         q2bPwfQqpUVUCgR1znVzdHePViE+1Ok3aozUy6dFrP1IP1Hz/W/N+8yCdhjeERleHGQn
         2irrnvlotJ2EK1840pqfQD79wXfqaklLX/T0ynZSGxz4cHIv3DsBygbSmcHeTh9ZiUAU
         79EsEowoUXCWnslb4s9G8B2w9a2jQvZqaf9tC9jbcjkkGdzGAsktOn1GKnjQhOC9Amq0
         a20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696292527; x=1696897327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+oV1ZgyPCblrOh65x12ZqFYHoDSqMkCfYV5/Np3CLc=;
        b=RvYEGYAgZEYi3657MYi9uZeCQSu1sRemAIP50AE7ntoPxwd6nIhrS8lwyoSddRkdoF
         kWndQ+R9Rn8YxIDnYXPX3DhwfkmQDlSYRem3x/GoJcHSIg/gYzfJPY/g1wPLP4GTSl1u
         Cqpx67RxTowisjmwCEgpPRqkRjL2Ma5yw6PD5KzFM1YsKx3yBMblLErSQ98wFx2tjuJv
         uZ4j7l9kINpwS3iS9vKkQMW7teZDdqg4MeMzfPGZRI0b+UdJTbT6/sm3BrNrt42wmCPe
         CbBD3mJJxxYm0WkEsc/sINaFpHwrW7jaqpGRCr3/+hqcKUMD93+lrA63QXg2KUgLS7Zz
         qlOA==
X-Gm-Message-State: AOJu0YxWqjMzgs0u3I8XLr9wexQTWzHy3jDGNWQU32/w/BFpIf32SsDX
        aEyLVn+Iy8xJ/IprUtQnHg==
X-Google-Smtp-Source: AGHT+IF3H7cFXE9uqnzYRiSwmCzVCT00Oy06v4WEmrurh9FJPLnPgHbJ2bdP2Q5gVA4VPLuva4WPHg==
X-Received: by 2002:a05:6870:3282:b0:1d6:439d:d04e with SMTP id q2-20020a056870328200b001d6439dd04emr14842596oac.53.1696292526913;
        Mon, 02 Oct 2023 17:22:06 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id a2-20020a056870618200b001e135f4f849sm24725oah.9.2023.10.02.17.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:22:06 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v2 3/4] mm/mempolicy: implement a preferred-interleave
Date:   Mon,  2 Oct 2023 20:21:55 -0400
Message-Id: <20231003002156.740595-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231003002156.740595-1-gregory.price@memverge.com>
References: <20231003002156.740595-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The preferred-interleave mempolicy implements single-weight
interleave mechanism where the preferred node is the local node.

If the local node is not set in nodemask, the first node in the
node mask is the preferred node.

When set, N (weight) pages will be allocated on the preferred node
beforce an interleave pass occurs.

For example:
  nodes=0,1,2
  interval=3
  cpunode=0

Over 10 consecutive allocations, the following nodes will be selected:
[0,0,0,1,2,0,0,0,1,2]

In this example, there is a 60%/20%/20% distribution of memory.

Using this mechanism, it becomes possible to define an approximate
distribution percentage of memory across a set of nodes:

local_node% : interval/((nr_nodes-1)+interval-1)
other_node% : (1-local_node%)/(nr_nodes-1)

The behavior can be preferred over a fully-weighted interleave (where
each node has a separate weight) when migrations or multiple sockets
may be in use. If a task migrates, the weight applies to the new
local node without a need for the task to "rebalance" its weights.

Similarly, if nodes are removed from the nodemask, no weights need
to be recalculated.  The exception to this is when the local node is
removed from the nodemask, which is a rare situation.

Similarly, consider a task executing on a 2-socket system which creates
a new thread.  If the first thread is scheduled to execute on socket 0
and the second thread is scheduled to execute on socket 1, weightings
set by thread 1 (which are inherited by thread 2) would very likely
be a poor interleave strategy for the new thread.

In this scheme, thread 2 would inherit the same weight, but it would
apply to the local node of thread 2, leading to more predictable
behavior for new allocations.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/mempolicy.h      |   8 ++
 include/uapi/linux/mempolicy.h |   6 +
 mm/mempolicy.c                 | 203 ++++++++++++++++++++++++++++++++-
 3 files changed, 212 insertions(+), 5 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index d232de7cdc56..8f918488c61c 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -48,6 +48,14 @@ struct mempolicy {
 	nodemask_t nodes;	/* interleave/bind/perfer */
 	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 
+	union {
+		/* Preferred Interleave: Weight local, then interleave */
+		struct {
+			int weight;
+			int count;
+		} pil;
+	};
+
 	union {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index ea386872094b..41c35f404c5e 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -24,6 +24,7 @@ enum {
 	MPOL_LOCAL,
 	MPOL_PREFERRED_MANY,
 	MPOL_LEGACY,	/* set_mempolicy limited to above modes */
+	MPOL_PREFERRED_INTERLEAVE,
 	MPOL_MAX,	/* always last member of enum */
 };
 
@@ -52,6 +53,11 @@ struct mempolicy_args {
 		struct {
 			unsigned long next_node; /* get only */
 		} interleave;
+		/* Partial interleave */
+		struct {
+			unsigned long weight;  /* get and set */
+			unsigned long next_node; /* get only */
+		} pil;
 	};
 };
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 936c641f554e..6374312cef5f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -399,6 +399,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.create = mpol_new_nodemask,
 		.rebind = mpol_rebind_nodemask,
 	},
+	[MPOL_PREFERRED_INTERLEAVE] = {
+		.create = mpol_new_nodemask,
+		.rebind = mpol_rebind_nodemask,
+	},
 	[MPOL_PREFERRED] = {
 		.create = mpol_new_preferred,
 		.rebind = mpol_rebind_preferred,
@@ -873,7 +877,8 @@ static long replace_mempolicy(struct mempolicy *new, nodemask_t *nodes)
 
 	old = current->mempolicy;
 	current->mempolicy = new;
-	if (new && new->mode == MPOL_INTERLEAVE)
+	if (new && (new->mode == MPOL_INTERLEAVE ||
+		    new->mode == MPOL_PREFERRED_INTERLEAVE))
 		current->il_prev = MAX_NUMNODES-1;
 out:
 	task_unlock(current);
@@ -915,6 +920,7 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	switch (p->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PREFERRED_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
 		*nodes = p->nodes;
@@ -1609,6 +1615,23 @@ SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
 	return kernel_set_mempolicy(mode, nmask, maxnode);
 }
 
+static long do_set_preferred_interleave(struct mempolicy_args *args,
+					struct mempolicy *new,
+					nodemask_t *nodes)
+{
+	/* Preferred interleave cannot be done with no nodemask */
+	if (nodes_empty(*nodes))
+		return -EINVAL;
+
+	/* Preferred interleave weight cannot be <= 0 */
+	if (args->pil.weight <= 0)
+		return -EINVAL;
+
+	new->pil.weight = args->pil.weight;
+	new->pil.count = 0;
+	return 0;
+}
+
 static long do_set_mempolicy2(struct mempolicy_args *args)
 {
 	struct mempolicy *new = NULL;
@@ -1630,6 +1653,9 @@ static long do_set_mempolicy2(struct mempolicy_args *args)
 		return PTR_ERR(new);
 
 	switch (args->mode) {
+	case MPOL_PREFERRED_INTERLEAVE:
+		err = do_set_preferred_interleave(args, new, &nodes);
+		break;
 	default:
 		BUG();
 	}
@@ -1767,6 +1793,12 @@ static long do_get_mempolicy2(struct mempolicy_args *kargs)
 							   pol->nodes);
 		rc = 0;
 		break;
+	case MPOL_PREFERRED_INTERLEAVE:
+		kargs->pil.next_node = next_node_in(current->il_prev,
+						    pol->nodes);
+		kargs->pil.weight = pol->pil.weight;
+		rc = 0;
+		break;
 	default:
 		BUG();
 	}
@@ -2102,12 +2134,41 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 	return nd;
 }
 
+static unsigned int preferred_interleave_nodes(struct mempolicy *policy)
+{
+	int mynode = numa_node_id();
+	struct task_struct *me = current;
+	int next;
+
+	/*
+	 * If the local node is not in the node mask, we treat the
+	 * lowest node as the preferred node. This can happen if the
+	 * cpu is bound to a node that is not present in the mempolicy
+	 */
+	if (!node_isset(mynode, policy->nodes))
+		mynode = first_node(policy->nodes);
+
+	next = next_node_in(me->il_prev, policy->nodes);
+	if (next == mynode) {
+		if (++policy->pil.count >= policy->pil.weight) {
+			policy->pil.count = 0;
+			me->il_prev = next;
+		}
+	} else if (next < MAX_NUMNODES) {
+		me->il_prev = next;
+	}
+	return next;
+}
+
 /* Do dynamic interleaving for a process */
 static unsigned interleave_nodes(struct mempolicy *policy)
 {
 	unsigned next;
 	struct task_struct *me = current;
 
+	if (policy->mode == MPOL_PREFERRED_INTERLEAVE)
+		return preferred_interleave_nodes(policy);
+
 	next = next_node_in(me->il_prev, policy->nodes);
 	if (next < MAX_NUMNODES)
 		me->il_prev = next;
@@ -2135,6 +2196,7 @@ unsigned int mempolicy_slab_node(void)
 		return first_node(policy->nodes);
 
 	case MPOL_INTERLEAVE:
+	case MPOL_PREFERRED_INTERLEAVE:
 		return interleave_nodes(policy);
 
 	case MPOL_BIND:
@@ -2161,6 +2223,56 @@ unsigned int mempolicy_slab_node(void)
 	}
 }
 
+static unsigned int offset_pil_node(struct mempolicy *pol, unsigned long n)
+{
+	nodemask_t nodemask = pol->nodes;
+	unsigned int target, nnodes;
+	int i;
+	int nid = MAX_NUMNODES;
+	int weight = pol->pil.weight;
+
+	/*
+	 * The barrier will stabilize the nodemask in a register or on
+	 * the stack so that it will stop changing under the code.
+	 *
+	 * Between first_node() and next_node(), pol->nodes could be changed
+	 * by other threads. So we put pol->nodes in a local stack.
+	 */
+	barrier();
+
+	nnodes = nodes_weight(nodemask);
+
+	/*
+	 * If the local node ID is not set (cpu is bound to a node
+	 * but that node is not set in the memory nodemask), interleave
+	 * based on the lowest set node.
+	 */
+	nid = numa_node_id();
+	if (!node_isset(nid, nodemask))
+		nid = first_node(nodemask);
+	/*
+	 * Mode or weight can change so default to basic interleave
+	 * if the weight has become invalid.  Basic interleave is
+	 * equivalent to weight=1. Don't double-count the base node
+	 */
+	if (weight == 0)
+		weight = 1;
+	weight -= 1;
+
+	/* If target <= the weight, no need to call next_node */
+	target = ((unsigned int)n % (nnodes + weight));
+	target -= (target > weight) ? weight : target;
+	target %= MAX_NUMNODES;
+
+	/* Target may not be the first node, so use next_node_in to wrap */
+	for (i = 0; i < target; i++) {
+		nid = next_node_in(nid, nodemask);
+		if (nid == MAX_NUMNODES)
+			nid = first_node(nodemask);
+	}
+	return nid;
+}
+
 /*
  * Do static interleaving for a VMA with known offset @n.  Returns the n'th
  * node in pol->nodes (starting from n=0), wrapping around if n exceeds the
@@ -2168,10 +2280,16 @@ unsigned int mempolicy_slab_node(void)
  */
 static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 {
-	nodemask_t nodemask = pol->nodes;
+	nodemask_t nodemask;
 	unsigned int target, nnodes;
 	int i;
 	int nid;
+
+	if (pol->mode == MPOL_PREFERRED_INTERLEAVE)
+		return offset_pil_node(pol, n);
+
+	nodemask = pol->nodes;
+
 	/*
 	 * The barrier will stabilize the nodemask in a register or on
 	 * the stack so that it will stop changing under the code.
@@ -2239,7 +2357,8 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
 	*nodemask = NULL;
 	mode = (*mpol)->mode;
 
-	if (unlikely(mode == MPOL_INTERLEAVE)) {
+	if (unlikely(mode == MPOL_INTERLEAVE) ||
+	    unlikely(mode == MPOL_PREFERRED_INTERLEAVE)) {
 		nid = interleave_nid(*mpol, vma, addr,
 					huge_page_shift(hstate_vma(vma)));
 	} else {
@@ -2280,6 +2399,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PREFERRED_INTERLEAVE:
 		*mask = mempolicy->nodes;
 		break;
 
@@ -2390,7 +2510,8 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 
 	pol = get_vma_policy(vma, addr);
 
-	if (pol->mode == MPOL_INTERLEAVE) {
+	if (pol->mode == MPOL_INTERLEAVE ||
+	    pol->mode == MPOL_PREFERRED_INTERLEAVE) {
 		struct page *page;
 		unsigned nid;
 
@@ -2492,7 +2613,8 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 	 * No reference counting needed for current->mempolicy
 	 * nor system default_policy
 	 */
-	if (pol->mode == MPOL_INTERLEAVE)
+	if (pol->mode == MPOL_INTERLEAVE ||
+	    pol->mode == MPOL_PREFERRED_INTERLEAVE)
 		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
 	else if (pol->mode == MPOL_PREFERRED_MANY)
 		page = alloc_pages_preferred_many(gfp, order,
@@ -2552,6 +2674,69 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
 	return total_allocated;
 }
 
+static unsigned long alloc_pages_bulk_array_pil(gfp_t gfp,
+						struct mempolicy *pol,
+						unsigned long nr_pages,
+						struct page **page_array)
+{
+	nodemask_t nodemask = pol->nodes;
+	unsigned long nr_pages_main;
+	unsigned long nr_pages_other;
+	unsigned long total_cycle;
+	unsigned long delta;
+	unsigned long weight;
+	int allocated = 0;
+	int start_nid;
+	int nnodes;
+	int prev, next;
+	int i;
+
+	/* This stabilizes nodes on the stack incase pol->nodes changes */
+	barrier();
+
+	nnodes = nodes_weight(nodemask);
+	start_nid = numa_node_id();
+
+	if (!node_isset(start_nid, nodemask))
+		start_nid = first_node(nodemask);
+
+	if (nnodes == 1) {
+		allocated = __alloc_pages_bulk(gfp, start_nid,
+					       NULL, nr_pages_main,
+					       NULL, page_array);
+		return allocated;
+	}
+	/* We don't want to double-count the main node in calculations */
+	nnodes--;
+
+	weight = pol->pil.weight;
+	total_cycle = (weight + nnodes);
+	/* Number of pages on main node: (cycles*weight + up to weight) */
+	nr_pages_main = ((nr_pages / total_cycle) * weight);
+	nr_pages_main += (nr_pages % total_cycle % (weight + 1));
+	/* Number of pages on others: (remaining/nodes) + 1 page if delta  */
+	nr_pages_other = (nr_pages - nr_pages_main) / nnodes;
+	nr_pages_other /= nnodes;
+	/* Delta is number of pages beyond weight up to full cycle */
+	delta = nr_pages - (nr_pages_main + (nr_pages_other * nnodes));
+
+	/* start by allocating for the main node, then interleave rest */
+	prev = start_nid;
+	allocated = __alloc_pages_bulk(gfp, start_nid, NULL, nr_pages_main,
+				       NULL, page_array);
+	for (i = 0; i < nnodes; i++) {
+		int pages = nr_pages_other + (delta-- ? 1 : 0);
+
+		next = next_node_in(prev, nodemask);
+		if (next < MAX_NUMNODES)
+			prev = next;
+		allocated += __alloc_pages_bulk(gfp, next, NULL, pages,
+						NULL, page_array);
+	}
+
+	return allocated;
+}
+
 static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
@@ -2590,6 +2775,10 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 		return alloc_pages_bulk_array_interleave(gfp, pol,
 							 nr_pages, page_array);
 
+	if (pol->mode == MPOL_PREFERRED_INTERLEAVE)
+		return alloc_pages_bulk_array_pil(gfp, pol, nr_pages,
+						  page_array);
+
 	if (pol->mode == MPOL_PREFERRED_MANY)
 		return alloc_pages_bulk_array_preferred_many(gfp,
 				numa_node_id(), pol, nr_pages, page_array);
@@ -2662,6 +2851,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	switch (a->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PREFERRED_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
 		return !!nodes_equal(a->nodes, b->nodes);
@@ -2798,6 +2988,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 
 	switch (pol->mode) {
 	case MPOL_INTERLEAVE:
+	case MPOL_PREFERRED_INTERLEAVE:
 		pgoff = vma->vm_pgoff;
 		pgoff += (addr - vma->vm_start) >> PAGE_SHIFT;
 		polnid = offset_il_node(pol, pgoff);
@@ -3185,6 +3376,7 @@ static const char * const policy_modes[] =
 	[MPOL_PREFERRED]  = "prefer",
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
+	[MPOL_PREFERRED_INTERLEAVE] = "preferred interleave",
 	[MPOL_LOCAL]      = "local",
 	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
@@ -3355,6 +3547,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PREFERRED_INTERLEAVE:
 		nodes = pol->nodes;
 		break;
 	default:
-- 
2.39.1


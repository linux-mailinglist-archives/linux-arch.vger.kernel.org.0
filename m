Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62E57A1210
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 01:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjINXzO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 19:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjINXzN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 19:55:13 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FEF270C;
        Thu, 14 Sep 2023 16:55:06 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-59bbed7353aso22487827b3.0;
        Thu, 14 Sep 2023 16:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694735705; x=1695340505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yc7YsJNEj8lnUE8O45Qp2UuWgYtrB9vsot4v2UqiCoQ=;
        b=F31bP+GjakMtFWq2BACovzx7TvR7cMXfKQkCQeBx0VpzhhO0ozso8JoUC7ZyVZuUt2
         kg4DtV4qa7wasP7T1eK6JfYjPw8deieqF0+DmaK0SpQI4AUhrMT0jnh+QgTYH9Alo1cB
         gXLOYCNvejaLBZ7KuOOst7LCb0RPSvUXSAgImDS8az9rHmkW/Q9b4tGCPX9+DT/S5hwr
         CDda++p0xJLW1zehCi/Teg2j5J/O1rqW51pS0wapkVGMrPgnmwSWEEiP9BFFNIQneFn6
         4sXLg7vrOCQNKirKIbq3P72/ljOt877XcOMohBUIgd39sU5cPWj3QBCQxLUapEBuvnuU
         gJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694735705; x=1695340505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yc7YsJNEj8lnUE8O45Qp2UuWgYtrB9vsot4v2UqiCoQ=;
        b=rxMfimeYbVEz27dJPWaZ5yRy44kVbrHPCWg72n54tZoYLNCDBMxMCfhz6Zum6UIRtc
         feBpNO7lAI7IrkHrPRkfabNNJ5g/IE4d35/XehSdUl0zWVQxn5HZfLB1qQOBAIMTo221
         MWwBVH+YFOgh+mv7C89WXVDIZ5EWZhSs8rGNLJj05QClLPqg2EvDQK1c5806JUXTs5wm
         4fONmL25tkdbvzUbX3XDDgCh6/EpbtC0PGVxvPFv4cSGODz+Rg3ucqmAyet0zeBZrz5p
         LtDTQbNz1SuvoPrs6uji56gdfC07UhzrdRBuFl82qanteyYnKRWZ0ovTn0h4d0BmUDN7
         6iHQ==
X-Gm-Message-State: AOJu0Yx2UWoO2vWw/e17+QqoMHo2GhtsH8RrMTE0g1lnWe55xjR5+kZR
        bC405DYUJ/bznDoZu+7/OKB8OsgzwgtJ
X-Google-Smtp-Source: AGHT+IFdMv8Q/eXzwgnb7IHOM/TKa73O1tI4dEJDglBAcOc/L7FuI+67g+VHE6Ok6t5WlTHlSv0Bmw==
X-Received: by 2002:a81:7344:0:b0:589:a400:a046 with SMTP id o65-20020a817344000000b00589a400a046mr157875ywc.14.1694735705659;
        Thu, 14 Sep 2023 16:55:05 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id p188-20020a0dcdc5000000b005777a2c356asm586300ywd.65.2023.09.14.16.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 16:55:05 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 3/3] mm/mempolicy: implement a partial-interleave mempolicy
Date:   Thu, 14 Sep 2023 19:54:57 -0400
Message-Id: <20230914235457.482710-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914235457.482710-1-gregory.price@memverge.com>
References: <20230914235457.482710-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The partial-interleave mempolicy implements interleave on an
allocation interval. The default node is the local node, for
which N pages will be allocated before an interleave pass occurs.

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

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/mempolicy.h      |   8 ++
 include/uapi/linux/mempolicy.h |   5 +
 mm/mempolicy.c                 | 161 +++++++++++++++++++++++++++++++--
 3 files changed, 166 insertions(+), 8 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index d232de7cdc56..41a6de9ff556 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -48,6 +48,14 @@ struct mempolicy {
 	nodemask_t nodes;	/* interleave/bind/perfer */
 	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 
+	union {
+		/* Partial Interleave: Allocate local count, then interleave */
+		struct {
+			int interval;
+			int count;
+		} part_int;
+	};
+
 	union {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 53650f69db2b..1af344344459 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -24,6 +24,7 @@ enum {
 	MPOL_LOCAL,
 	MPOL_PREFERRED_MANY,
 	MPOL_LEGACY,	/* set_mempolicy limited to above modes */
+	MPOL_PARTIAL_INTERLEAVE,
 	MPOL_MAX,	/* always last member of enum */
 };
 
@@ -55,6 +56,10 @@ struct mempolicy_args {
 		struct {
 			unsigned long next_node; /* get only */
 		} interleave;
+		struct {
+			unsigned long interval;  /* get and set */
+			unsigned long next_node; /* get only */
+		} part_int;
 	};
 };
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1cf7709400f1..a2ee45ac2ab6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -399,6 +399,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.create = mpol_new_nodemask,
 		.rebind = mpol_rebind_nodemask,
 	},
+	[MPOL_PARTIAL_INTERLEAVE] = {
+		.create = mpol_new_nodemask,
+		.rebind = mpol_rebind_nodemask,
+	},
 	[MPOL_PREFERRED] = {
 		.create = mpol_new_preferred,
 		.rebind = mpol_rebind_preferred,
@@ -875,7 +879,8 @@ static long swap_mempolicy(struct mempolicy *new,
 
 	old = current->mempolicy;
 	current->mempolicy = new;
-	if (new && new->mode == MPOL_INTERLEAVE)
+	if (new && (new->mode == MPOL_INTERLEAVE ||
+		    new->mode == MPOL_PARTIAL_INTERLEAVE))
 		current->il_prev = MAX_NUMNODES-1;
 out:
 	task_unlock(current);
@@ -920,6 +925,7 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	switch (p->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PARTIAL_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
 		*nodes = p->nodes;
@@ -1614,6 +1620,23 @@ SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
 	return kernel_set_mempolicy(mode, nmask, maxnode);
 }
 
+static long do_set_partial_interleave(struct mempolicy_args *args,
+				      struct mempolicy *new,
+				      nodemask_t *nodes)
+{
+	/* Preferred interleave cannot be done with no nodemask */
+	if (nodes_empty(*nodes))
+		return -EINVAL;
+
+	/* Preferred interleave interval cannot be <= 0 */
+	if (args->part_int.interval <= 0)
+		return -EINVAL;
+
+	new->part_int.interval = args->part_int.interval;
+	new->part_int.count = 0;
+	return 0;
+}
+
 static long do_set_mempolicy2(struct mempolicy_args *args)
 {
 	struct mempolicy *new = NULL;
@@ -1637,6 +1660,9 @@ static long do_set_mempolicy2(struct mempolicy_args *args)
 	}
 
 	switch (args->mode) {
+	case MPOL_PARTIAL_INTERLEAVE:
+		err = do_set_partial_interleave(args, new, &nodes);
+		break;
 	default:
 		BUG();
 	}
@@ -1791,6 +1817,11 @@ static long do_get_mempolicy2(struct mempolicy_args *kargs)
 		kargs->interleave.next_node = next_node_in(current->il_prev,
 							   pol->nodes);
 		break;
+	case MPOL_PARTIAL_INTERLEAVE:
+		kargs->part_int.next_node = next_node_in(current->il_prev,
+							 pol->nodes);
+		kargs->part_int.interval = pol->part_int.interval;
+		break;
 	default:
 		break;
 	}
@@ -2133,8 +2164,19 @@ static unsigned interleave_nodes(struct mempolicy *policy)
 	struct task_struct *me = current;
 
 	next = next_node_in(me->il_prev, policy->nodes);
-	if (next < MAX_NUMNODES)
+
+	if (policy->mode == MPOL_PARTIAL_INTERLEAVE) {
+		if (next == numa_node_id()) {
+			if (++policy->part_int.count >= policy->part_int.interval) {
+				policy->part_int.count = 0;
+				me->il_prev = next;
+			}
+		} else if (next < MAX_NUMNODES) {
+			me->il_prev = next;
+		}
+	} else if (next < MAX_NUMNODES)
 		me->il_prev = next;
+
 	return next;
 }
 
@@ -2159,6 +2201,7 @@ unsigned int mempolicy_slab_node(void)
 		return first_node(policy->nodes);
 
 	case MPOL_INTERLEAVE:
+	case MPOL_PARTIAL_INTERLEAVE:
 		return interleave_nodes(policy);
 
 	case MPOL_BIND:
@@ -2195,7 +2238,7 @@ static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 	nodemask_t nodemask = pol->nodes;
 	unsigned int target, nnodes;
 	int i;
-	int nid;
+	int nid = MAX_NUMNODES;
 	/*
 	 * The barrier will stabilize the nodemask in a register or on
 	 * the stack so that it will stop changing under the code.
@@ -2208,8 +2251,35 @@ static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 	nnodes = nodes_weight(nodemask);
 	if (!nnodes)
 		return numa_node_id();
-	target = (unsigned int)n % nnodes;
-	nid = first_node(nodemask);
+
+	if (pol->mode == MPOL_PARTIAL_INTERLEAVE) {
+		int interval = pol->part_int.interval;
+		/*
+		 * Mode or interval can change so default to basic interleave
+		 * if the interval has become invalid.  Basic interleave is
+		 * equivalent to interval=1. Don't double-count the base node
+		 */
+		if (interval == 0)
+			interval = 1;
+		interval -= 1;
+
+		/* If target <= the interval, no need to call next_node */
+		target = ((unsigned int)n % (nnodes + interval));
+		target -= (target > interval) ? interval : target;
+		target %= MAX_NUMNODES;
+
+		/* If the local node ID is no longer set, do interleave */
+		nid = numa_node_id();
+		if (!node_isset(nid, nodemask))
+			nid = MAX_NUMNODES;
+	}
+
+	/* If partial interleave generated an invalid nid, do interleave */
+	if (nid == MAX_NUMNODES) {
+		target = (unsigned int)n % nnodes;
+		nid = first_node(nodemask);
+	}
+
 	for (i = 0; i < target; i++)
 		nid = next_node(nid, nodemask);
 	return nid;
@@ -2263,7 +2333,8 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
 	*nodemask = NULL;
 	mode = (*mpol)->mode;
 
-	if (unlikely(mode == MPOL_INTERLEAVE)) {
+	if (unlikely(mode == MPOL_INTERLEAVE) ||
+	    unlikely(mode == MPOL_PARTIAL_INTERLEAVE)) {
 		nid = interleave_nid(*mpol, vma, addr,
 					huge_page_shift(hstate_vma(vma)));
 	} else {
@@ -2304,6 +2375,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PARTIAL_INTERLEAVE:
 		*mask = mempolicy->nodes;
 		break;
 
@@ -2414,7 +2486,8 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 
 	pol = get_vma_policy(vma, addr);
 
-	if (pol->mode == MPOL_INTERLEAVE) {
+	if (pol->mode == MPOL_INTERLEAVE ||
+	    pol->mode == MPOL_PARTIAL_INTERLEAVE) {
 		struct page *page;
 		unsigned nid;
 
@@ -2516,7 +2589,8 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 	 * No reference counting needed for current->mempolicy
 	 * nor system default_policy
 	 */
-	if (pol->mode == MPOL_INTERLEAVE)
+	if (pol->mode == MPOL_INTERLEAVE ||
+	    pol->mode == MPOL_PARTIAL_INTERLEAVE)
 		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
 	else if (pol->mode == MPOL_PREFERRED_MANY)
 		page = alloc_pages_preferred_many(gfp, order,
@@ -2576,6 +2650,68 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
 	return total_allocated;
 }
 
+static unsigned long alloc_pages_bulk_array_partial_interleave(gfp_t gfp,
+		struct mempolicy *pol, unsigned long nr_pages,
+		struct page **page_array)
+{
+	nodemask_t nodemask = pol->nodes;
+	unsigned long nr_pages_main;
+	unsigned long nr_pages_other;
+	unsigned long total_cycle;
+	unsigned long delta;
+	unsigned long interval;
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
+	interval = pol->part_int.interval;
+	total_cycle = (interval + nnodes);
+	/* Number of pages on main node: (cycles*interval + up to interval) */
+	nr_pages_main = ((nr_pages / total_cycle) * interval);
+	nr_pages_main += (nr_pages % total_cycle % (interval + 1));
+	/* Number of pages on others: (remaining/nodes) + 1 page if delta  */
+	nr_pages_other = (nr_pages - nr_pages_main) / nnodes;
+	nr_pages_other /= nnodes;
+	/* Delta is number of pages beyond interval up to full cycle */
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
@@ -2614,6 +2750,11 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 		return alloc_pages_bulk_array_interleave(gfp, pol,
 							 nr_pages, page_array);
 
+	if (pol->mode == MPOL_PARTIAL_INTERLEAVE)
+		return alloc_pages_bulk_array_partial_interleave(gfp, pol,
+								 nr_pages,
+								 page_array);
+
 	if (pol->mode == MPOL_PREFERRED_MANY)
 		return alloc_pages_bulk_array_preferred_many(gfp,
 				numa_node_id(), pol, nr_pages, page_array);
@@ -2686,6 +2827,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	switch (a->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PARTIAL_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
 		return !!nodes_equal(a->nodes, b->nodes);
@@ -2822,6 +2964,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 
 	switch (pol->mode) {
 	case MPOL_INTERLEAVE:
+	case MPOL_PARTIAL_INTERLEAVE:
 		pgoff = vma->vm_pgoff;
 		pgoff += (addr - vma->vm_start) >> PAGE_SHIFT;
 		polnid = offset_il_node(pol, pgoff);
@@ -3209,6 +3352,7 @@ static const char * const policy_modes[] =
 	[MPOL_PREFERRED]  = "prefer",
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
+	[MPOL_PARTIAL_INTERLEAVE] = "partial interleave",
 	[MPOL_LOCAL]      = "local",
 	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
@@ -3379,6 +3523,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PARTIAL_INTERLEAVE:
 		nodes = pol->nodes;
 		break;
 	default:
-- 
2.39.1


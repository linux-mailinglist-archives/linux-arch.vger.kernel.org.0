Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2EA7B5E23
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 02:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbjJCAWW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 20:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbjJCAWT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 20:22:19 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0112BE1;
        Mon,  2 Oct 2023 17:22:09 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-1e10ba12fd3so208605fac.1;
        Mon, 02 Oct 2023 17:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696292529; x=1696897329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMDruOuLBm4Gji0WOsN7NL1T5EMDFv1mGIaADmwpZLQ=;
        b=jgyB//XTpIumAx1eopl01dscE+Ri9QRfEYp40wGKollDMZHgb92BiKXcNJ4MxP0Xe4
         jrW3jiRhk7y5+miCCLq8PUa9eVgcDTTpsg81Y+cpzSwr6oauwTg1Udr36l7Uln9YtJtF
         reDuGwJ/73LlWe+85G4zFQo/0yx5rniGwenNv6xUryOW1KdGuuKa4yAlyliGNyCC4zQG
         BGsQIYSEEmT7OnoGn65cKPxjcq8+vGOVUW7hMqypqsEaJVq0zXUAQfliQ0/QbAzy8fSz
         kRX5TSr6ivMu9lqbaAUu3qKIQK6vcByR+gTZRGO1jdt8NGrTV9k0z2wNVpQwrDpyhcap
         3NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696292529; x=1696897329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMDruOuLBm4Gji0WOsN7NL1T5EMDFv1mGIaADmwpZLQ=;
        b=NtRsdds1XKaHkGVftSsnKrEtMZrybLc1yeWBLjRoG9PJdHpZr79tIcFHGQE81c91jt
         07WpoRdSlAP3OLPTvybAWL4lCK/sLOSsH+Onuf3yyMhzw1ld9GclqvtVI1WOkipLtrOk
         vCo1HH3hBxKIhyIiV4wxB3tyniTJLtFRIrH6CJwe/SI2laf/OGgudGjSe1ENMd7KSQd+
         h358hI+l1xTXSuVlgguXkLpfm82mURpxV+3FEhwsbMhTg6I0ekaPeJvrsg3JXU5MI5N0
         dX9mYKWyEMrbBkBXIgk3+hbSFYMpY8HGuXEIS4A9cYyF4MdDouL2jo3K1fMrnP2IkM2P
         Rr8Q==
X-Gm-Message-State: AOJu0Ywsx+dDzweG+cX8ehyXVYLpXqUK3nqONyv7xvl2sEHFewAyuCO9
        kadB1d+rynI2Pib8u0M03w==
X-Google-Smtp-Source: AGHT+IE2YAsLVNpJsdNcG2bxedQTiFrhif1A8zx9yeRwEXXF9bKT3nIRs/0OjC+MT/bG/oTToYDBxA==
X-Received: by 2002:a05:6870:9720:b0:1d5:c134:cecb with SMTP id n32-20020a056870972000b001d5c134cecbmr14980678oaq.1.1696292529153;
        Mon, 02 Oct 2023 17:22:09 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id a2-20020a056870618200b001e135f4f849sm24725oah.9.2023.10.02.17.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:22:08 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v2 4/4] mm/mempolicy: implement a weighted-interleave
Date:   Mon,  2 Oct 2023 20:21:56 -0400
Message-Id: <20231003002156.740595-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231003002156.740595-1-gregory.price@memverge.com>
References: <20231003002156.740595-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The weighted-interleave mempolicy implements weights per-node
which are used to distribute memory while interleaving.

For example:
   nodes: 0,1,2
   weights: 5,3,2

Over 10 consecutive allocations, the following nodes will be selected:
[0,0,0,0,0,1,1,1,2,2]

In this example there is a 50%/30%/20% distribution of memory across
the enabled nodes.

If a node is enabled, the minimum weight is expected to be 0. If an
enabled node ends up with a weight of 0 (as can happen if weights
are being recalculated due to a cgroup mask update), a minimum
of 1 is applied during the interleave mechanism.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/mempolicy.h      |   6 +
 include/uapi/linux/mempolicy.h |   6 +
 mm/mempolicy.c                 | 261 ++++++++++++++++++++++++++++++++-
 3 files changed, 269 insertions(+), 4 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 8f918488c61c..8763e536d4a2 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -54,6 +54,12 @@ struct mempolicy {
 			int weight;
 			int count;
 		} pil;
+		/* weighted interleave */
+		struct {
+			unsigned int il_weight;
+			unsigned char cur_weight;
+			unsigned char weights[MAX_NUMNODES];
+		} wil;
 	};
 
 	union {
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 41c35f404c5e..913ca9bf9af7 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -25,6 +25,7 @@ enum {
 	MPOL_PREFERRED_MANY,
 	MPOL_LEGACY,	/* set_mempolicy limited to above modes */
 	MPOL_PREFERRED_INTERLEAVE,
+	MPOL_WEIGHTED_INTERLEAVE,
 	MPOL_MAX,	/* always last member of enum */
 };
 
@@ -58,6 +59,11 @@ struct mempolicy_args {
 			unsigned long weight;  /* get and set */
 			unsigned long next_node; /* get only */
 		} pil;
+		/* Weighted interleave */
+		struct {
+			unsigned long next_node; /* get only */
+			unsigned char *weights; /* get and set */
+		} wil;
 	};
 };
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6374312cef5f..92be74d4c431 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -195,11 +195,43 @@ static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
 	nodes_onto(*ret, tmp, *rel);
 }
 
+static void mpol_recalculate_weights(struct mempolicy *pol)
+{
+	unsigned int il_weight = 0;
+	int node;
+
+	/* Recalculate weights to ensure minimum node weight */
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		if (!node_isset(node, pol->nodes) && pol->wil.weights[node]) {
+			/* If node is not set, weight should be 0 */
+			pol->wil.weights[node] = 0;
+		} else if (!pol->wil.weights[node]) {
+			/* If node is set, weight should be minimum of 1 */
+			pol->wil.weights[node] = 1;
+			pol->wil.il_weight += 1;
+			il_weight += 1;
+		} else {
+			/* Otherwise, keep the existing weight */
+			il_weight += pol->wil.weights[node];
+		}
+	}
+	pol->wil.il_weight = il_weight;
+	/*
+	 * It's possible an allocation has been occurring at this point
+	 * force it to go to the next node, since we just changed weights
+	 */
+	pol->wil.cur_weight = 0;
+}
+
 static int mpol_new_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 {
 	if (nodes_empty(*nodes))
 		return -EINVAL;
 	pol->nodes = *nodes;
+
+	if (pol->mode == MPOL_WEIGHTED_INTERLEAVE)
+		mpol_recalculate_weights(pol);
+
 	return 0;
 }
 
@@ -334,6 +366,10 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 		tmp = *nodes;
 
 	pol->nodes = tmp;
+
+	/* After a change to the nodemask, weights must be recalculated */
+	if (pol->mode == MPOL_WEIGHTED_INTERLEAVE)
+		mpol_recalculate_weights(pol);
 }
 
 static void mpol_rebind_preferred(struct mempolicy *pol,
@@ -403,6 +439,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.create = mpol_new_nodemask,
 		.rebind = mpol_rebind_nodemask,
 	},
+	[MPOL_WEIGHTED_INTERLEAVE] = {
+		.create = mpol_new_nodemask,
+		.rebind = mpol_rebind_nodemask,
+	},
 	[MPOL_PREFERRED] = {
 		.create = mpol_new_preferred,
 		.rebind = mpol_rebind_preferred,
@@ -878,8 +918,10 @@ static long replace_mempolicy(struct mempolicy *new, nodemask_t *nodes)
 	old = current->mempolicy;
 	current->mempolicy = new;
 	if (new && (new->mode == MPOL_INTERLEAVE ||
-		    new->mode == MPOL_PREFERRED_INTERLEAVE))
+		    new->mode == MPOL_PREFERRED_INTERLEAVE ||
+		    new->mode == MPOL_WEIGHTED_INTERLEAVE))
 		current->il_prev = MAX_NUMNODES-1;
+
 out:
 	task_unlock(current);
 	mpol_put(old);
@@ -921,6 +963,7 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
 		*nodes = p->nodes;
@@ -1632,6 +1675,56 @@ static long do_set_preferred_interleave(struct mempolicy_args *args,
 	return 0;
 }
 
+static long do_set_weighted_interleave(struct mempolicy_args *args,
+				       struct mempolicy *new,
+				       nodemask_t *nodes)
+{
+	unsigned char weight;
+	unsigned char *weights;
+	int node;
+	int ret = 0;
+
+	/* Weighted interleave cannot be done with no nodemask */
+	if (nodes_empty(*nodes))
+		return -EINVAL;
+
+	/* Weighted interleave requires a set of weights */
+	if (!args->wil.weights)
+		return -EINVAL;
+
+	weights = kmalloc(MAX_NUMNODES, GFP_KERNEL);
+	if (!weights)
+		return -ENOMEM;
+
+	ret = copy_from_user(weights, args->wil.weights, MAX_NUMNODES);
+	if (ret) {
+		ret = -EFAULT;
+		goto weights_out;
+	}
+
+	new->wil.cur_weight = 0;
+	new->wil.il_weight = 0;
+	memset(new->wil.weights, 0, sizeof(new->wil.weights));
+
+	/* Weights for set nodes cannot be 0 */
+	node = first_node(*nodes);
+	while (node != MAX_NUMNODES) {
+		weight = weights[node];
+		if (!weight) {
+			ret = -EINVAL;
+			goto weights_out;
+		}
+		/* policy creation initializes total to nr_nodes, adjust it */
+		new->wil.il_weight += weight;
+		new->wil.weights[node] = weight;
+		node = next_node(node, *nodes);
+	}
+
+weights_out:
+	kfree(weights);
+	return ret;
+}
+
 static long do_set_mempolicy2(struct mempolicy_args *args)
 {
 	struct mempolicy *new = NULL;
@@ -1656,6 +1749,9 @@ static long do_set_mempolicy2(struct mempolicy_args *args)
 	case MPOL_PREFERRED_INTERLEAVE:
 		err = do_set_preferred_interleave(args, new, &nodes);
 		break;
+	case MPOL_WEIGHTED_INTERLEAVE:
+		err = do_set_weighted_interleave(args, new, &nodes);
+		break;
 	default:
 		BUG();
 	}
@@ -1799,6 +1895,12 @@ static long do_get_mempolicy2(struct mempolicy_args *kargs)
 		kargs->pil.weight = pol->pil.weight;
 		rc = 0;
 		break;
+	case MPOL_WEIGHTED_INTERLEAVE:
+		kargs->wil.next_node = next_node_in(current->il_prev,
+						    pol->nodes);
+		rc = copy_to_user(kargs->wil.weights, pol->wil.weights,
+				  MAX_NUMNODES);
+		break;
 	default:
 		BUG();
 	}
@@ -2160,6 +2262,27 @@ static unsigned int preferred_interleave_nodes(struct mempolicy *policy)
 	return next;
 }
 
+static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
+{
+	unsigned int next;
+	unsigned char next_weight;
+	struct task_struct *me = current;
+
+	/* When weight reaches 0, we're on a new node, reset the weight */
+	next = next_node_in(me->il_prev, policy->nodes);
+	if (!policy->wil.cur_weight) {
+		/* If the node is set, at least 1 allocation is required */
+		next_weight = policy->wil.weights[next];
+		policy->wil.cur_weight = next_weight ? next_weight : 1;
+	}
+
+	policy->wil.cur_weight--;
+	if (next < MAX_NUMNODES && !policy->wil.cur_weight)
+		me->il_prev = next;
+
+	return next;
+}
+
 /* Do dynamic interleaving for a process */
 static unsigned interleave_nodes(struct mempolicy *policy)
 {
@@ -2168,6 +2291,8 @@ static unsigned interleave_nodes(struct mempolicy *policy)
 
 	if (policy->mode == MPOL_PREFERRED_INTERLEAVE)
 		return preferred_interleave_nodes(policy);
+	else if (policy->mode == MPOL_WEIGHTED_INTERLEAVE)
+		return weighted_interleave_nodes(policy);
 
 	next = next_node_in(me->il_prev, policy->nodes);
 	if (next < MAX_NUMNODES)
@@ -2197,6 +2322,7 @@ unsigned int mempolicy_slab_node(void)
 
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		return interleave_nodes(policy);
 
 	case MPOL_BIND:
@@ -2273,6 +2399,40 @@ static unsigned int offset_pil_node(struct mempolicy *pol, unsigned long n)
 	return nid;
 }
 
+static unsigned int offset_wil_node(struct mempolicy *pol, unsigned long n)
+{
+	nodemask_t nodemask = pol->nodes;
+	unsigned int target, nnodes;
+	unsigned char weight;
+	int nid;
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
+	if (!nnodes)
+		return numa_node_id();
+	target = (unsigned int)n % pol->wil.il_weight;
+	nid = first_node(nodemask);
+	while (target) {
+		weight = pol->wil.weights[nid];
+		/* If weights are being recaculated, revert to interleave */
+		if (!weight)
+			weight = 1;
+		if (target < weight)
+			break;
+		target -= weight;
+		nid = next_node_in(nid, nodemask);
+	}
+	return nid;
+}
+
 /*
  * Do static interleaving for a VMA with known offset @n.  Returns the n'th
  * node in pol->nodes (starting from n=0), wrapping around if n exceeds the
@@ -2287,6 +2447,8 @@ static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 
 	if (pol->mode == MPOL_PREFERRED_INTERLEAVE)
 		return offset_pil_node(pol, n);
+	else if (pol->mode == MPOL_WEIGHTED_INTERLEAVE)
+		return offset_wil_node(pol, n);
 
 	nodemask = pol->nodes;
 
@@ -2358,7 +2520,8 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
 	mode = (*mpol)->mode;
 
 	if (unlikely(mode == MPOL_INTERLEAVE) ||
-	    unlikely(mode == MPOL_PREFERRED_INTERLEAVE)) {
+	    unlikely(mode == MPOL_PREFERRED_INTERLEAVE) ||
+	    unlikely(mode == MPOL_WEIGHTED_INTERLEAVE)) {
 		nid = interleave_nid(*mpol, vma, addr,
 					huge_page_shift(hstate_vma(vma)));
 	} else {
@@ -2400,6 +2563,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		*mask = mempolicy->nodes;
 		break;
 
@@ -2511,7 +2675,8 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 	pol = get_vma_policy(vma, addr);
 
 	if (pol->mode == MPOL_INTERLEAVE ||
-	    pol->mode == MPOL_PREFERRED_INTERLEAVE) {
+	    pol->mode == MPOL_PREFERRED_INTERLEAVE ||
+	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
 		struct page *page;
 		unsigned nid;
 
@@ -2614,7 +2779,8 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 	 * nor system default_policy
 	 */
 	if (pol->mode == MPOL_INTERLEAVE ||
-	    pol->mode == MPOL_PREFERRED_INTERLEAVE)
+	    pol->mode == MPOL_PREFERRED_INTERLEAVE ||
+	    pol->mode == MPOL_WEIGHTED_INTERLEAVE)
 		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
 	else if (pol->mode == MPOL_PREFERRED_MANY)
 		page = alloc_pages_preferred_many(gfp, order,
@@ -2737,6 +2903,84 @@ static unsigned long alloc_pages_bulk_array_pil(gfp_t gfp,
 	return allocated;
 }
 
+static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
+	struct mempolicy *pol, unsigned long nr_pages,
+	struct page **page_array)
+{
+	struct task_struct *me = current;
+	unsigned long total_allocated = 0;
+	unsigned long nr_allocated;
+	unsigned long rounds;
+	unsigned long node_pages, delta;
+	unsigned char weight;
+	int nnodes, node, prev_node;
+	int i;
+
+	nnodes = nodes_weight(pol->nodes);
+	/* Continue allocating from most recent node and adjust the nr_pages */
+	if (pol->wil.cur_weight) {
+		node = next_node_in(me->il_prev, pol->nodes);
+		node_pages = pol->wil.cur_weight;
+		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
+						  NULL, page_array);
+		page_array += nr_allocated;
+		total_allocated += nr_allocated;
+		/* if that's all the pages, no need to interleave */
+		if (nr_pages <= pol->wil.cur_weight) {
+			pol->wil.cur_weight -= nr_pages;
+			return total_allocated;
+		}
+		/* Otherwise we adjust nr_pages down, and continue from there */
+		nr_pages -= pol->wil.cur_weight;
+		pol->wil.cur_weight = 0;
+		prev_node = node;
+	}
+
+	/* Now we can continue allocating from this point */
+	rounds = nr_pages / pol->wil.il_weight;
+	delta = nr_pages % pol->wil.il_weight;
+	for (i = 0; i < nnodes; i++) {
+		node = next_node_in(prev_node, pol->nodes);
+		weight = pol->wil.weights[node];
+		node_pages = weight * rounds;
+		if (delta) {
+			if (delta > weight) {
+				node_pages += weight;
+				delta -= weight;
+			} else {
+				node_pages += delta;
+				delta = 0;
+			}
+		}
+		/* We may not make it all the way around */
+		if (!node_pages)
+			break;
+		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
+						  NULL, page_array);
+		page_array += nr_allocated;
+		total_allocated += nr_allocated;
+		prev_node = node;
+	}
+
+	/*
+	 * Finally, we need to update me->il_prev and pol->wil.cur_weight
+	 * if there were overflow pages, but not equivalent to the node
+	 * weight, set the cur_weight to node_weight - delta and the
+	 * me->il_prev to the previous node. Otherwise if it was perfect
+	 * we can simply set il_prev to node and cur_weight to 0
+	 */
+	delta %= weight;
+	if (node_pages) {
+		me->il_prev = prev_node;
+		pol->wil.cur_weight = pol->wil.weights[node] - node_pages;
+	} else {
+		me->il_prev = node;
+		pol->wil.cur_weight = 0;
+	}
+
+	return total_allocated;
+}
+
 static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
@@ -2779,6 +3023,11 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 		return alloc_pages_bulk_array_pil(gfp, pol, nr_pages,
 						  page_array);
 
+	if (pol->mode == MPOL_WEIGHTED_INTERLEAVE)
+		return alloc_pages_bulk_array_weighted_interleave(gfp, pol,
+								  nr_pages,
+								  page_array);
+
 	if (pol->mode == MPOL_PREFERRED_MANY)
 		return alloc_pages_bulk_array_preferred_many(gfp,
 				numa_node_id(), pol, nr_pages, page_array);
@@ -2852,6 +3101,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
 		return !!nodes_equal(a->nodes, b->nodes);
@@ -2989,6 +3239,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 	switch (pol->mode) {
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		pgoff = vma->vm_pgoff;
 		pgoff += (addr - vma->vm_start) >> PAGE_SHIFT;
 		polnid = offset_il_node(pol, pgoff);
@@ -3377,6 +3628,7 @@ static const char * const policy_modes[] =
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
 	[MPOL_PREFERRED_INTERLEAVE] = "preferred interleave",
+	[MPOL_WEIGHTED_INTERLEAVE] = "weighted interleave",
 	[MPOL_LOCAL]      = "local",
 	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
@@ -3548,6 +3800,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		nodes = pol->nodes;
 		break;
 	default:
-- 
2.39.1


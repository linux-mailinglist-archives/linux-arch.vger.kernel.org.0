Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159DC7B5429
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 15:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbjJBNkn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 09:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbjJBNkm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 09:40:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292BE9D;
        Mon,  2 Oct 2023 06:40:39 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rzhpv2DC9z67j73;
        Mon,  2 Oct 2023 21:37:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 14:40:36 +0100
Date:   Mon, 2 Oct 2023 14:40:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <linux-mm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 3/3] mm/mempolicy: implement a partial-interleave
 mempolicy
Message-ID: <20231002144035.00000b36@Huawei.com>
In-Reply-To: <20230914235457.482710-4-gregory.price@memverge.com>
References: <20230914235457.482710-1-gregory.price@memverge.com>
        <20230914235457.482710-4-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Thu, 14 Sep 2023 19:54:57 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> The partial-interleave mempolicy implements interleave on an

I'm not sure 'partial' really conveys what is going on here.
Weighted, or uneven-interleave maybe?

> allocation interval. The default node is the local node, for
> which N pages will be allocated before an interleave pass occurs.
> 
> For example:
>   nodes=0,1,2
>   interval=3
>   cpunode=0
> 
> Over 10 consecutive allocations, the following nodes will be selected:
> [0,0,0,1,2,0,0,0,1,2]
> 
> In this example, there is a 60%/20%/20% distribution of memory.
> 
> Using this mechanism, it becomes possible to define an approximate
> distribution percentage of memory across a set of nodes:
> 
> local_node% : interval/((nr_nodes-1)+interval-1)
> other_node% : (1-local_node%)/(nr_nodes-1)

I'd like to see more discussion here of why you would do this...


A few trivial bits inline,

Jonathan

...

> +static unsigned long alloc_pages_bulk_array_partial_interleave(gfp_t gfp,
> +		struct mempolicy *pol, unsigned long nr_pages,
> +		struct page **page_array)
> +{
> +	nodemask_t nodemask = pol->nodes;
> +	unsigned long nr_pages_main;
> +	unsigned long nr_pages_other;
> +	unsigned long total_cycle;
> +	unsigned long delta;
> +	unsigned long interval;
> +	int allocated = 0;
> +	int start_nid;
> +	int nnodes;
> +	int prev, next;
> +	int i;
> +
> +	/* This stabilizes nodes on the stack incase pol->nodes changes */
> +	barrier();
> +
> +	nnodes = nodes_weight(nodemask);
> +	start_nid = numa_node_id();
> +
> +	if (!node_isset(start_nid, nodemask))
> +		start_nid = first_node(nodemask);
> +
> +	if (nnodes == 1) {
> +		allocated = __alloc_pages_bulk(gfp, start_nid,
> +					       NULL, nr_pages_main,
> +					       NULL, page_array);
> +		return allocated;
		return __alloc_pages_bulk(...)

> +	}
> +	/* We don't want to double-count the main node in calculations */
> +	nnodes--;
> +
> +	interval = pol->part_int.interval;
> +	total_cycle = (interval + nnodes);

excess brackets. Same in various other places.


> +	/* Number of pages on main node: (cycles*interval + up to interval) */
> +	nr_pages_main = ((nr_pages / total_cycle) * interval);
> +	nr_pages_main += (nr_pages % total_cycle % (interval + 1));


> +	/* Number of pages on others: (remaining/nodes) + 1 page if delta  */
> +	nr_pages_other = (nr_pages - nr_pages_main) / nnodes;
> +	nr_pages_other /= nnodes;
> +	/* Delta is number of pages beyond interval up to full cycle */
> +	delta = nr_pages - (nr_pages_main + (nr_pages_other * nnodes));
> +
> +	/* start by allocating for the main node, then interleave rest */
> +	prev = start_nid;
> +	allocated = __alloc_pages_bulk(gfp, start_nid, NULL, nr_pages_main,
> +				       NULL, page_array);
> +	for (i = 0; i < nnodes; i++) {
> +		int pages = nr_pages_other + (delta-- ? 1 : 0);
> +
> +		next = next_node_in(prev, nodemask);
> +		if (next < MAX_NUMNODES)
> +			prev = next;
> +		allocated += __alloc_pages_bulk(gfp, next, NULL, pages,
> +						NULL, page_array);
> +	}
> +
> +	return allocated;
> +}
> +



Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA57B5495
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbjJBOHz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 10:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbjJBOHy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 10:07:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A61A9;
        Mon,  2 Oct 2023 07:07:50 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzjT84Zbpz6K6gc;
        Mon,  2 Oct 2023 22:07:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 15:07:47 +0100
Date:   Mon, 2 Oct 2023 15:07:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <linux-mm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC v2 4/5] mm/migrate: Create move_phys_pages syscall
Message-ID: <20231002150746.00007516@Huawei.com>
In-Reply-To: <20230919230909.530174-5-gregory.price@memverge.com>
References: <20230919230909.530174-1-gregory.price@memverge.com>
        <20230919230909.530174-5-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Tue, 19 Sep 2023 19:09:07 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> Similar to the move_pages system call, instead of taking a pid and
> list of virtual addresses, this system call takes a list of physical
> addresses.
> 
> Because there is no task to validate the memory policy against, each
> page needs to be interrogated to determine whether the migration is
> valid, and all tasks that map it need to be interrogated.
> 
> This is accomplished in via a rmap_walk on the folio containing
> the page, and an interrogation of all tasks that map the page (by
> way of each task's vma).
> 
> Each page must be interrogated individually, which should be
> considered when using this to migrate shared regions.
> 
> The remaining logic is the same as the move_pages syscall. Some
> minor changes to do_pages_move are made (to check whether an
> mm_struct is passed) in order to re-use the existing migration code.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

Hi Gregory

A few comments inline.

Thanks,

Jonathan


> diff --git a/mm/migrate.c b/mm/migrate.c
> index 1123d841a7f1..2d06557c0b80 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2165,9 +2165,118 @@ static int move_pages_and_store_status(int node,
>  	return store_status(status, start, node, i - start);
>  }
>  
> +struct rmap_page_ctxt {
> +	bool found;
> +	bool migratable;
> +	bool node_allowed;
> +	int node;
> +};
> +
> +/*
> + * Walks each vma mapping a given page and determines if those
> + * vma's are both migratable, and that the target node is within
> + * the allowed cpuset of the owning task.
> + */
> +static bool phys_page_migratable(struct folio *folio,
> +				 struct vm_area_struct *vma,
> +				 unsigned long address,
> +				 void *arg)
> +{
> +	struct rmap_page_ctxt *ctxt = (struct rmap_page_ctxt *)arg;

arg is a void * so no need for explicit cast.

> +	struct task_struct *owner = vma->vm_mm->owner;
> +	/* On non-memcg systems, the allowed set is the possible set */
> +#ifdef CONFIG_MEMCG
> +	nodemask_t task_nodes = cpuset_mems_allowed(owner);
> +#else
> +	nodemask_t task_nodes = node_possible_map;
> +#endif
> +
> +	ctxt->found |= true;

Given you or it with true, you might as well just set it..
	ctxt->found = true;
ends up the same.

> +	ctxt->migratable &= vma_migratable(vma);
> +	ctxt->node_allowed &= node_isset(ctxt->node, task_nodes);
> +
> +	return ctxt->migratable && ctxt->node_allowed;
> +}
> +

> +/*
> + * Validates the physical address is online and migratable.  Walks the folio
> + * containing the page to validate the vma is migratable and the cpuset node
> + * restrictions.  Then calls add_page_for_migration to isolate it from the
> + * LRU and place it into the given pagelist.
> + * Returns:
> + *     errno - if the page is not online, migratable, or can't be isolated
> + *     0 - when it doesn't have to be migrated because it is already on the
> + *         target node
> + *     1 - when it has been queued
> + */
> +static int add_phys_page_for_migration(const void __user *p, int node,
> +				       struct list_head *pagelist,
> +				       bool migrate_all)
> +{
> +	unsigned long pfn;
> +	struct page *page;
> +	struct folio *folio;
> +	int err;
> +	struct rmap_page_ctxt rmctxt = {
> +		.found = false,
> +		.migratable = true,
> +		.node_allowed = true,
> +		.node = node
> +	};
> +	struct rmap_walk_control rwc = {
> +		.rmap_one = phys_page_migratable,
> +		.arg = &rmctxt
> +	};
> +
> +	pfn = ((unsigned long)p) >> PAGE_SHIFT;
> +	page = pfn_to_online_page(pfn);
> +	if (!page || PageTail(page))
> +		return -ENOENT;
> +
> +	folio = phys_migrate_get_folio(page);
> +	if (folio)
> +		rmap_walk(folio, &rwc);
Why not just tidy up the !folio case more directly as if
it's not we only get to the first condition as rmctxt.found == false
anyway, so this is the same as.

	if (!folio)
		return -ENOENT.

	rmap_walk(foil, &rwc);


> +
> +	if (!rmctxt.found)
> +		err = -ENOENT;
> +	else if (!rmctxt.migratable)
> +		err = -EFAULT;
> +	else if (!rmctxt.node_allowed)
> +		err = -EACCES;
> +	else
> +		err = add_page_for_migration(page, node, pagelist, migrate_all);
> +
> +	if (folio)

With above changes this condition can go.

> +		folio_put(folio);
> +
> +	return err;
> +}
> +
>  /*
>   * Migrate an array of page address onto an array of nodes and fill
>   * the corresponding array of status.
> + *
> + * When the mm argument is not NULL, task_nodes is expected to be the
> + * cpuset nodemask for the task which owns the mm_struct, and the
> + * values located in (*pages) are expected to be virtual addresses.
> + *
> + * When the mm argument is NULL, the values located at (*pages) are
> + * expected to be physical addresses, and task_nodes is expected to
> + * be empty.
>   */
>  static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  			 unsigned long nr_pages,
> @@ -2181,6 +2290,10 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  	int start, i;
>  	int err = 0, err1;
>  
> +	/* This should never occur in regular operation */
> +	if (!mm && nodes_weight(task_nodes) > 0)

You document below that task_nodes isn't used if !mm but it is used
to indicate this condition...

> +		return -EINVAL;
> +
>  	lru_cache_disable();
>  
>  	for (i = start = 0; i < nr_pages; i++) {
> @@ -2209,7 +2322,14 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  			goto out_flush;
>  
>  		err = -EACCES;
> -		if (!node_isset(node, task_nodes))
> +		/*
> +		 * if mm is NULL, then the pages are addressed via physical
> +		 * address and the task_nodes structure is empty. Validation
> +		 * of migratability is deferred to add_phys_page_for_migration
> +		 * where vma's that map the address will have their node_mask
> +		 * checked to ensure the requested node bit is set.
> +		 */
> +		if (mm && !node_isset(node, task_nodes))
>  			goto out_flush;
>  

> @@ -2317,6 +2444,37 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>  	mmap_read_unlock(mm);
>  }
>  
> +/*
> + * Determine the nodes pages pointed to by the physical addresses in the
> + * pages array, and store those node values in the status array
> + */
> +static void do_phys_pages_stat_array(unsigned long nr_pages,
> +				     const void __user **pages, int *status)
> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		unsigned long pfn = (unsigned long)(*pages) >> PAGE_SHIFT;
> +		struct page *page = pfn_to_online_page(pfn);
> +		int err = -ENOENT;
> +
> +		if (!page)
> +			goto set_status;
> +
> +		get_page(page);
> +
> +		if (!is_zone_device_page(page))
> +			err = page_to_nid(page);
> +
> +		put_page(page);
> +set_status:
> +		*status = err;

Given you update it unconditionally this seems to wipe out earlier
potential errors with the nid.

> +
> +		pages++;
> +		status++;
> +	}
> +}

>  
> +/*
> + * Move a list of physically-addressed pages to the list of target nodes
> + */
> +static int kernel_move_phys_pages(unsigned long nr_pages,
> +				  const void __user * __user *pages,
> +				  const int __user *nodes,
> +				  int __user *status, int flags)
> +{
> +	int err;
> +	nodemask_t dummy_nodes;
> +
> +	if (flags & ~(MPOL_MF_MOVE|MPOL_MF_MOVE_ALL))

Spaces around the |

> +		return -EINVAL;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	/*
> +	 * When the mm argument to do_pages_move is null, the task_nodes
> +	 * argument is ignored, so pass in an empty nodemask as a dummy.

If ignored, why bother clearing it?  Looks like you are using it as
as signal rather than ignoring it. So not sure this comment is correct.

> +	 */
> +	nodes_clear(dummy_nodes);
> +	if (nodes)
> +		err = do_pages_move(NULL, dummy_nodes, nr_pages, pages,
> +			nodes, status, flags);
> +	else
> +		err = do_pages_stat(NULL, nr_pages, pages, status);
> +
> +	return err;

If nothing to do, just return in the two branches and loose the local variable err.


> +}
> +
> +SYSCALL_DEFINE5(move_phys_pages, unsigned long, nr_pages,
> +		const void __user * __user *, pages,
> +		const int __user *, nodes,
> +		int __user *, status, int, flags)
> +{
> +	return kernel_move_phys_pages(nr_pages, pages, nodes, status, flags);
> +}
> +
Looks like 1 blank line enough to me...

> +
>  #ifdef CONFIG_NUMA_BALANCING

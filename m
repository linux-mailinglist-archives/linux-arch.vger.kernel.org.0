Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D467B547D
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 16:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbjJBNvh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 09:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbjJBNvf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 09:51:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8BFB0;
        Mon,  2 Oct 2023 06:51:31 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rzj3R2MlDz6HJTP;
        Mon,  2 Oct 2023 21:48:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 14:51:28 +0100
Date:   Mon, 2 Oct 2023 14:51:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <linux-mm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC v2 3/5] mm/migrate: refactor add_page_for_migration for
 code re-use
Message-ID: <20231002145127.0000685e@Huawei.com>
In-Reply-To: <20230919230909.530174-4-gregory.price@memverge.com>
References: <20230919230909.530174-1-gregory.price@memverge.com>
        <20230919230909.530174-4-gregory.price@memverge.com>
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

On Tue, 19 Sep 2023 19:09:06 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> add_page_for_migration presently does two actions:
>   1) validates the page is present and migratable
>   2) isolates the page from LRU and puts it into the migration list
> 
> Break add_page_for_migration into 2 functions:
>   add_page_for_migration - isolate the page from LUR and add to list
>   add_virt_page_for_migration - validate the page and call the above
> 
> add_page_for_migration does not require the mm_struct and so can be
> re-used for a physical addressing version of move_pages
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

A few things inline.

> ---
>  mm/migrate.c | 83 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 50 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index dbe436163d65..1123d841a7f1 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2042,52 +2042,33 @@ static int do_move_pages_to_node(struct list_head *pagelist, int node)
>  }
>  
>  /*
> - * Resolves the given address to a struct page, isolates it from the LRU and
> - * puts it to the given pagelist.
> + * Isolates the page from the LRU and puts it into the given pagelist
>   * Returns:
>   *     errno - if the page cannot be found/isolated

Is found still meaningful for what is in here?

>   *     0 - when it doesn't have to be migrated because it is already on the
>   *         target node
>   *     1 - when it has been queued
>   */
> -static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
> -		int node, struct list_head *pagelist, bool migrate_all)
> +static int add_page_for_migration(struct page *page, int node,
> +		struct list_head *pagelist, bool migrate_all)
>  {
> -	struct vm_area_struct *vma;
> -	unsigned long addr;
> -	struct page *page;
>  	int err;
>  	bool isolated;
>  
> -	mmap_read_lock(mm);
> -	addr = (unsigned long)untagged_addr_remote(mm, p);
> -
> -	err = -EFAULT;
> -	vma = vma_lookup(mm, addr);
> -	if (!vma || !vma_migratable(vma))
> -		goto out;
> -
> -	/* FOLL_DUMP to ignore special (like zero) pages */
> -	page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> -
> -	err = PTR_ERR(page);
> -	if (IS_ERR(page))
> -		goto out;
> -
>  	err = -ENOENT;
>  	if (!page)
>  		goto out;

As noted below - this check is now duplicated.  Might make sense
of course, but not obvious if it was intended.

>  
>  	if (is_zone_device_page(page))
> -		goto out_putpage;
> +		goto out;
>  
>  	err = 0;
>  	if (page_to_nid(page) == node)
> -		goto out_putpage;
> +		goto out;
>  
>  	err = -EACCES;
>  	if (page_mapcount(page) > 1 && !migrate_all)
> -		goto out_putpage;
> +		goto out;
>  
>  	if (PageHuge(page)) {
>  		if (PageHead(page)) {
> @@ -2101,7 +2082,7 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
>  		isolated = isolate_lru_page(head);
>  		if (!isolated) {
>  			err = -EBUSY;
> -			goto out_putpage;
> +			goto out;
>  		}
>  
>  		err = 1;
> @@ -2110,12 +2091,48 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
>  			NR_ISOLATED_ANON + page_is_file_lru(head),
>  			thp_nr_pages(head));
>  	}
> -out_putpage:
> -	/*
> -	 * Either remove the duplicate refcount from
> -	 * isolate_lru_page() or drop the page ref if it was
> -	 * not isolated.
> -	 */
> +out:
Given nothing to do here now, perhaps remove to early returns
as that may simplify some error paths.

> +	return err;
> +}
> +
> +/*
> + * Resolves the given address to a struct page, isolates it from the LRU and
> + * puts it to the given pagelist.
> + * Returns:
> + *     errno - if the page cannot be found/isolated
> + *     0 - when it doesn't have to be migrated because it is already on the
> + *         target node
> + *     1 - when it has been queued
> + */
> +static int add_virt_page_for_migration(struct mm_struct *mm,
> +		const void __user *p, int node, struct list_head *pagelist,
> +		bool migrate_all)
> +{
> +	struct vm_area_struct *vma;
> +	unsigned long addr;
> +	struct page *page;
> +	int err = -EFAULT;
> +
> +	mmap_read_lock(mm);
> +	addr = (unsigned long)untagged_addr_remote(mm, p);
> +
> +	vma = vma_lookup(mm, addr);
> +	if (!vma || !vma_migratable(vma))
> +		goto out;
> +
> +	/* FOLL_DUMP to ignore special (like zero) pages */
> +	page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> +
> +	err = PTR_ERR(page);
> +	if (IS_ERR(page))
> +		goto out;
> +
> +	err = -ENOENT;
> +	if (!page)
> +		goto out;

You do this here then again in add_page_for_migration().  Does it
need to be in both places?

> +
> +	err = add_page_for_migration(page, node, pagelist, migrate_all);
> +
>  	put_page(page);
>  out:
>  	mmap_read_unlock(mm);
> @@ -2211,7 +2228,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		 * Errors in the page lookup or isolation are not fatal and we simply
>  		 * report them via status
>  		 */
> -		err = add_page_for_migration(mm, p, current_node, &pagelist,
> +		err = add_virt_page_for_migration(mm, p, current_node, &pagelist,
>  					     flags & MPOL_MF_MOVE_ALL);
>  
>  		if (err > 0) {


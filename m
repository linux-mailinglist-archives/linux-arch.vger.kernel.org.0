Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F7D7B5434
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 15:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbjJBNoL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 09:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbjJBNoK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 09:44:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AADAAD;
        Mon,  2 Oct 2023 06:44:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rzhxn4YN0z67M1H;
        Mon,  2 Oct 2023 21:43:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 14:44:04 +0100
Date:   Mon, 2 Oct 2023 14:44:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <linux-mm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC v2 2/5] mm/migrate: remove unused mm argument from
 do_move_pages_to_node
Message-ID: <20231002144403.0000707d@Huawei.com>
In-Reply-To: <20230919230909.530174-3-gregory.price@memverge.com>
References: <20230919230909.530174-1-gregory.price@memverge.com>
        <20230919230909.530174-3-gregory.price@memverge.com>
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

On Tue, 19 Sep 2023 19:09:05 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> preparatory work to re-use do_move_pages_to_node with a physical
> address instead of virtual address.  This function does not actively
> use the mm_struct, so it can be removed.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
Indeed doesn't need to be there.
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Would be nice if these first 2 patches go upstream separately.

> ---
>  mm/migrate.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a0b0c5a7f8a5..dbe436163d65 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2026,8 +2026,7 @@ static int store_status(int __user *status, int start, int value, int nr)
>  	return 0;
>  }
>  
> -static int do_move_pages_to_node(struct mm_struct *mm,
> -		struct list_head *pagelist, int node)
> +static int do_move_pages_to_node(struct list_head *pagelist, int node)
>  {
>  	int err;
>  	struct migration_target_control mtc = {
> @@ -2123,7 +2122,7 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
>  	return err;
>  }
>  
> -static int move_pages_and_store_status(struct mm_struct *mm, int node,
> +static int move_pages_and_store_status(int node,
>  		struct list_head *pagelist, int __user *status,
>  		int start, int i, unsigned long nr_pages)
>  {
> @@ -2132,7 +2131,7 @@ static int move_pages_and_store_status(struct mm_struct *mm, int node,
>  	if (list_empty(pagelist))
>  		return 0;
>  
> -	err = do_move_pages_to_node(mm, pagelist, node);
> +	err = do_move_pages_to_node(pagelist, node);
>  	if (err) {
>  		/*
>  		 * Positive err means the number of failed
> @@ -2200,7 +2199,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  			current_node = node;
>  			start = i;
>  		} else if (node != current_node) {
> -			err = move_pages_and_store_status(mm, current_node,
> +			err = move_pages_and_store_status(current_node,
>  					&pagelist, status, start, i, nr_pages);
>  			if (err)
>  				goto out;
> @@ -2235,7 +2234,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		if (err)
>  			goto out_flush;
>  
> -		err = move_pages_and_store_status(mm, current_node, &pagelist,
> +		err = move_pages_and_store_status(current_node, &pagelist,
>  				status, start, i, nr_pages);
>  		if (err) {
>  			/* We have accounted for page i */
> @@ -2247,7 +2246,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  	}
>  out_flush:
>  	/* Make sure we do not overwrite the existing error */
> -	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
> +	err1 = move_pages_and_store_status(current_node, &pagelist,
>  				status, start, i, nr_pages);
>  	if (err >= 0)
>  		err = err1;


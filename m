Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A527B50D1
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 13:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbjJBLDZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 07:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbjJBLDY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 07:03:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8DAD3;
        Mon,  2 Oct 2023 04:03:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzdNH0cJvz6K8hv;
        Mon,  2 Oct 2023 19:03:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 12:03:17 +0100
Date:   Mon, 2 Oct 2023 12:03:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <linux-mm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 1/3] mm/mempolicy: refactor do_set_mempolicy for
 code re-use
Message-ID: <20231002120317.000058ef@Huawei.com>
In-Reply-To: <20230914235457.482710-2-gregory.price@memverge.com>
References: <20230914235457.482710-1-gregory.price@memverge.com>
        <20230914235457.482710-2-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Thu, 14 Sep 2023 19:54:55 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> Refactors do_set_mempolicy into swap_mempolicy and do_set_mempolicy
> so that swap_mempolicy can be re-used with set_mempolicy2.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

Obviously this is an RFC, so you probably didn't give it the polish
a finished patch might have.  Still I was curious and reading it and
I can't resist pointing out trivial stuff.. So....

> ---
>  mm/mempolicy.c | 44 +++++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 42b5567e3773..f49337f6f300 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -855,28 +855,21 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	return vma_replace_policy(vma, new_pol);
>  }
>  
> -/* Set the process memory policy */
> -static long do_set_mempolicy(unsigned short mode, unsigned short flags,
> -			     nodemask_t *nodes)
> +/* Swap in a new mempolicy, release the old one if successful */

Not really swapping. More replacing given we don't get the
old one back to do something else with it.

> +static long swap_mempolicy(struct mempolicy *new,
> +			   nodemask_t *nodes)

Excessive wrapping.

>  {
> -	struct mempolicy *new, *old;
> -	NODEMASK_SCRATCH(scratch);
> +	struct mempolicy *old = NULL;
>  	int ret;
> +	NODEMASK_SCRATCH(scratch);

I'd avoid the reordering as makes it look like slightly more is happening
in this change than is actually the case.

>  
>  	if (!scratch)
>  		return -ENOMEM;
>  
> -	new = mpol_new(mode, flags, nodes);
> -	if (IS_ERR(new)) {
> -		ret = PTR_ERR(new);
> -		goto out;
> -	}
> -
>  	task_lock(current);
>  	ret = mpol_set_nodemask(new, nodes, scratch);
>  	if (ret) {
>  		task_unlock(current);
> -		mpol_put(new);
>  		goto out;
>  	}
>  
> @@ -884,14 +877,35 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
>  	current->mempolicy = new;
>  	if (new && new->mode == MPOL_INTERLEAVE)
>  		current->il_prev = MAX_NUMNODES-1;
> -	task_unlock(current);
> -	mpol_put(old);
> -	ret = 0;
>  out:
> +	task_unlock(current);
> +	if (old)
> +		mpol_put(old);
It's protected against NULL parameter internally, so
	mpol_put(old);

which has advantage that a block of diff will hopefully disappear making
this patch easier to read.

> +
>  	NODEMASK_SCRATCH_FREE(scratch);
>  	return ret;
>  }
>  
> +/* Set the process memory policy */
> +static long do_set_mempolicy(unsigned short mode, unsigned short flags,
> +			     nodemask_t *nodes)
> +{
> +	struct mempolicy *new;
> +	int ret;
> +
> +	new = mpol_new(mode, flags, nodes);
> +	if (IS_ERR(new)) {
> +		ret = PTR_ERR(new);
> +		goto out;

Given nothing to do at out lable, in keeping with at least some local
style, you could do direct returns on errors.

	if (IS_ERR(new))
		return PTR_ERR(new)

	ret = swap_mempolicy(new, nodes);
	if (ret) {
		mpol_put(new);
		return ret;
	}

	return 0;

> +	}
> +
> +	ret = swap_mempolicy(new, nodes);
> +	if (ret)
> +		mpol_put(new);
> +out:
> +	return ret;
> +}
> +
>  /*
>   * Return nodemask for policy for get_mempolicy() query
>   *


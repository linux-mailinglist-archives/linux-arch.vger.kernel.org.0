Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E5B6BE443
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 09:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCQIuG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjCQIt4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 04:49:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812C7509B4;
        Fri, 17 Mar 2023 01:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B2666221F;
        Fri, 17 Mar 2023 08:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7303C433D2;
        Fri, 17 Mar 2023 08:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679042965;
        bh=ykt+2ZCz3fJnDj9RH3P/+IvPyVarY3iXaWoZy2um+KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASlDJrZelehzIwW2Z9VzYs6Yymp4sfhk+lPTy1rfj7IMYKry3XAmgaEkxvKDPNLuo
         UKP1933d6dTIUg9+GFtsFk6iiwHfK3dtxpHxb/0jUE4K/rErFB2RmpNA8ZsANeTj1u
         18FxT5XPdx30MtVkPfwqtMZeDoDeAFrXHS1qQ9ndhOtdA1yFGgtnHORVFmfSVop1F3
         s5XO3h1/KbvYLFpyFzBoSMWLGIelKa/6Lp+Lk0ydn3t1z7D2+4+qiifR8aLa91xvO5
         LZsjEcZiG1OND+JJiZFUrNqNGEI1k8c+hS7BmRP45mhj9VU5hfyOtGmH2c3+iNJ1eU
         R5ZP2HY3NSONQ==
Date:   Fri, 17 Mar 2023 10:49:11 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 02/10] um: Fix MAX_ORDER usage in linux_main()
Message-ID: <ZBQph4KXO23Hql+8@kernel.org>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315113133.11326-3-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 02:31:25PM +0300, Kirill A. Shutemov wrote:
> MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
> can deliver is MAX_ORDER-1.
> 
> Fix MAX_ORDER usage in linux_main().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/um/kernel/um_arch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index 8dcda617b8bf..5e5a9c8e0e5d 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -368,10 +368,10 @@ int __init linux_main(int argc, char **argv)
>  	max_physmem = TASK_SIZE - uml_physmem - iomem_size - MIN_VMALLOC;
>  
>  	/*
> -	 * Zones have to begin on a 1 << MAX_ORDER page boundary,
> +	 * Zones have to begin on a 1 << MAX_ORDER-1 page boundary,
>  	 * so this makes sure that's true for highmem
>  	 */
> -	max_physmem &= ~((1 << (PAGE_SHIFT + MAX_ORDER)) - 1);
> +	max_physmem &= ~((1 << (PAGE_SHIFT + MAX_ORDER - 1)) - 1);
>  	if (physmem_size + iomem_size > max_physmem) {
>  		highmem = physmem_size + iomem_size - max_physmem;
>  		physmem_size -= highmem;
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.

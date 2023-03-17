Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0245F6BE455
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 09:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCQIxS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 04:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCQIxR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 04:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6797460D4D;
        Fri, 17 Mar 2023 01:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0222E62213;
        Fri, 17 Mar 2023 08:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FFAC433EF;
        Fri, 17 Mar 2023 08:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679043195;
        bh=B3wahgcn5mCya2QfzNpjGhDRim/NPquzm6i3xLDnJT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHI3JC3cw2rpX/l/4nDWRywUopCJn3cKlLScYDDBt/1oyDV9dArx93sY9+r6VpUyl
         XUJ5xQsKry3BPZIL3rKV6jRHTv4/WLwW2vm+5lM52YiFp1TOwMI5AOHWodC9cwUmpt
         z0KIG0OJzoQ9nU8aQfvszQWSuwRFOEzpOnublDNFSzAI+FhDQ29Cn/qsfaaB3T3j2p
         k0jHqtwm+0VP0eKbAsH5nFdQWcO04sHGXTx73YWU5vZehIrCm7IL5jtzQJCSsOrEIr
         4NDXJ9bLLST47RNuXXzYlkGncP/2MUUHMVD/CJ2qv3kU3yU11pacIsp4mtawxKZyJ7
         jzJGqwRXIt21A==
Date:   Fri, 17 Mar 2023 10:53:02 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH 03/10] floppy: Fix MAX_ORDER usage
Message-ID: <ZBQqbpXP2e/+fKI0@kernel.org>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315113133.11326-4-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 02:31:26PM +0300, Kirill A. Shutemov wrote:
> MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
> can deliver is MAX_ORDER-1.
> 
> Fix MAX_ORDER usage in floppy code.
> 
> Also allocation buffer exactly PAGE_SIZE << MAX_ORDER bytes is okay. Fix
> MAX_LEN check.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Denis Efremov <efremov@linux.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  drivers/block/floppy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 487840e3564d..90d2dfb6448e 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3079,7 +3079,7 @@ static void raw_cmd_free(struct floppy_raw_cmd **ptr)
>  	}
>  }
>  
> -#define MAX_LEN (1UL << MAX_ORDER << PAGE_SHIFT)
> +#define MAX_LEN (1UL << (MAX_ORDER - 1) << PAGE_SHIFT)
>  
>  static int raw_cmd_copyin(int cmd, void __user *param,
>  				 struct floppy_raw_cmd **rcmd)
> @@ -3108,7 +3108,7 @@ static int raw_cmd_copyin(int cmd, void __user *param,
>  	ptr->resultcode = 0;
>  
>  	if (ptr->flags & (FD_RAW_READ | FD_RAW_WRITE)) {
> -		if (ptr->length <= 0 || ptr->length >= MAX_LEN)
> +		if (ptr->length <= 0 || ptr->length > MAX_LEN)
>  			return -EINVAL;
>  		ptr->kernel_data = (char *)fd_dma_mem_alloc(ptr->length);
>  		fallback_on_nodma_alloc(&ptr->kernel_data, ptr->length);
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.

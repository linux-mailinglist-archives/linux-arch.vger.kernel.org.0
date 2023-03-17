Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D909A6BE3D0
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 09:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCQIhV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 04:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjCQIg6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 04:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FD265C7D;
        Fri, 17 Mar 2023 01:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6BF462226;
        Fri, 17 Mar 2023 08:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765A3C433EF;
        Fri, 17 Mar 2023 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679042159;
        bh=0U8d1LMWaEZQgafPkPZom810OpVwizNioSkYu9Ua+ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+Oan4h2AJGsMePeKGlfKytnhkDM1qtdUfuMAeZSwnfAVazgO72kZeLCVwsg4vkH4
         NQjtcIYPbxm09chvEPyyjV8agLCk1qrZtLaBGjEF2ZnStax/I91MJ80mGg9ijXI3m9
         +bKY320hHoUFifi3bJRO0JVWMN0M2uTQVSZSe6DdHZSQ2lg1SmWRVi2YGXEm2lOYbo
         RcC5XWa2trUVyNudNZzXWg7mIPfrGFeBHkwUtwPwvpUMZRz+ND1MEZ+ruqTW9BO5KL
         pOBP3AvRts4ikjdVX5kIcsacITLSX5l27sDwuCAPXixR0Hbl7Ud4huCS5Cxi9xvrpd
         HOdKFnktWuJVw==
Date:   Fri, 17 Mar 2023 10:35:46 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 01/10] sparc/mm: Fix MAX_ORDER usage in tsb_grow()
Message-ID: <ZBQmYhCpSTLMP28Z@kernel.org>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315113133.11326-2-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 02:31:24PM +0300, Kirill A. Shutemov wrote:
> MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
> can deliver is MAX_ORDER-1.
> 
> Fix MAX_ORDER usage in tsb_grow().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: sparclinux@vger.kernel.org
> Cc: David Miller <davem@davemloft.net>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/sparc/mm/tsb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
> index 912205787161..dba8dffe2113 100644
> --- a/arch/sparc/mm/tsb.c
> +++ b/arch/sparc/mm/tsb.c
> @@ -402,8 +402,8 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
>  	unsigned long new_rss_limit;
>  	gfp_t gfp_flags;
>  
> -	if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
> -		max_tsb_size = (PAGE_SIZE << MAX_ORDER);
> +	if (max_tsb_size > (PAGE_SIZE << (MAX_ORDER - 1)))
> +		max_tsb_size = (PAGE_SIZE << (MAX_ORDER - 1));
>  
>  	new_cache_index = 0;
>  	for (new_size = 8192; new_size < max_tsb_size; new_size <<= 1UL) {
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.

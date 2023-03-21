Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B8C6C2BAB
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 08:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCUHsu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 03:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjCUHss (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 03:48:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3617118;
        Tue, 21 Mar 2023 00:48:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 02A051FD6A;
        Tue, 21 Mar 2023 07:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679384911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0T22BvyLsxTGKRp8ptWSENdQ9AmQVE5GpVIAlDWlTA=;
        b=hs4Xd6jbhFnM66NWCm2SPklmq1+37dljFeBscauEi982ADeYjhibIiWXW8keHZOvQaP7DD
        qttn2UaybcB+7d9rPZGox3kNcQdQ8JNvsUGFvbPSZK8jb5G4WQqhLEPYP7XIzzumL8HU+c
        KdBf/xwk4cjZ6NaspVKB6WBCLzytAqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679384911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0T22BvyLsxTGKRp8ptWSENdQ9AmQVE5GpVIAlDWlTA=;
        b=4I+JAgROtJSR6tNw7RBJK0pVCf0hOuyUJTV1w2guIaO2+hrG3UQUYhbjpWn3MiYha8fQeP
        6hhbjYcM3xSu42Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2BDC13440;
        Tue, 21 Mar 2023 07:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p+bHMk5hGWSfKwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Mar 2023 07:48:30 +0000
Message-ID: <498307e2-3952-801b-4847-1255214f5c76@suse.cz>
Date:   Tue, 21 Mar 2023 08:48:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/10] sparc/mm: Fix MAX_ORDER usage in tsb_grow()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        David Miller <davem@davemloft.net>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-2-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230315113133.11326-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/15/23 12:31, Kirill A. Shutemov wrote:
> MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
> can deliver is MAX_ORDER-1.
> 
> Fix MAX_ORDER usage in tsb_grow().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> Cc: sparclinux@vger.kernel.org
> Cc: David Miller <davem@davemloft.net>
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


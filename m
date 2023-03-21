Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D146C2BB8
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 08:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCUHxS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 03:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjCUHxR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 03:53:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4FD15898;
        Tue, 21 Mar 2023 00:53:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D3B4321A7C;
        Tue, 21 Mar 2023 07:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679385193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvJEMoCJ+Uw47SELOagFbF1pjz2WAesoMkcGUA9f9xo=;
        b=PqhOfbp5zIVY4iT79I18TP5hqT2nkIv7V2t8mV02DBmEa+ReCdf2nOONDJpQcSQ0rHkl58
        USx67rKWvy2qd47569aiLtvprVqGS8YkfQrZ9AIpwja2iC4Vk6oWvFPRCB0lz7ZK37x6O6
        nnbm+AVuQnYu8/3ATt6VdYb7Bg/OH50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679385193;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvJEMoCJ+Uw47SELOagFbF1pjz2WAesoMkcGUA9f9xo=;
        b=w9eJuJzlbi+4y0PIcwuRPmPZNoKOdLIgwXA8Dnu0Pcg8ln3wqVpjiPrqqkq/LxWM/Vb/GI
        H2KKMy1vvTD9ZbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AED2413440;
        Tue, 21 Mar 2023 07:53:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 293vKWliGWQtNAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Mar 2023 07:53:13 +0000
Message-ID: <9673d62f-e308-9c43-0318-e2f611f43eec@suse.cz>
Date:   Tue, 21 Mar 2023 08:53:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/10] floppy: Fix MAX_ORDER usage
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Denis Efremov <efremov@linux.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-4-kirill.shutemov@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230315113133.11326-4-kirill.shutemov@linux.intel.com>
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
> Fix MAX_ORDER usage in floppy code.
> 
> Also allocation buffer exactly PAGE_SIZE << MAX_ORDER bytes is okay. Fix
> MAX_LEN check.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> Cc: Denis Efremov <efremov@linux.com>
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


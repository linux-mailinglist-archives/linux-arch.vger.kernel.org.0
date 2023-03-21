Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC846C2BCD
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 08:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCUH7d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCUH7c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 03:59:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786C8252BF;
        Tue, 21 Mar 2023 00:59:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 316BE1FD6A;
        Tue, 21 Mar 2023 07:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679385570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoniuNoO5eexUIW/xsTozOoB3FVZQwYyoAwklqRuey4=;
        b=zjxpGIdqWELDFEDxkAHsCYlf6NUYnC4Afb9mFGLEZIU2tCkKaMHlVE1MgxiIROEBfKA4cD
        WWcDxGy9muk1ZRV5L0o+eUyfrhYoSiFeLpKUHZLKfthu7/oUKZXeJKBz55rU4ykwK/hwJB
        vd77cT5gc6NQkv0rGwnNYUb5VjrEpjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679385570;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoniuNoO5eexUIW/xsTozOoB3FVZQwYyoAwklqRuey4=;
        b=oLQr4pkw2ZENRscA4RqfFGSWD8iPFnevuyWvBmG1NsnCaylopl3HHJBa8/sgeiFUUeK2HB
        DCceznv08Fy996AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0ED8713440;
        Tue, 21 Mar 2023 07:59:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D0ncAuJjGWRoOQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Mar 2023 07:59:30 +0000
Message-ID: <44049b2c-42af-f9be-2af3-46716dd83344@suse.cz>
Date:   Tue, 21 Mar 2023 08:59:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 05/10] genwqe: Fix MAX_ORDER usage
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Frank Haverkamp <haver@linux.ibm.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-6-kirill.shutemov@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230315113133.11326-6-kirill.shutemov@linux.intel.com>
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
> Fix MAX_ORDER usage in genwqe driver.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> Cc: Frank Haverkamp <haver@linux.ibm.com>
> ---
>  drivers/misc/genwqe/card_dev.c   | 2 +-
>  drivers/misc/genwqe/card_utils.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
> index 55fc5b80e649..d0e27438a73c 100644
> --- a/drivers/misc/genwqe/card_dev.c
> +++ b/drivers/misc/genwqe/card_dev.c
> @@ -443,7 +443,7 @@ static int genwqe_mmap(struct file *filp, struct vm_area_struct *vma)
>  	if (vsize == 0)
>  		return -EINVAL;
>  
> -	if (get_order(vsize) > MAX_ORDER)
> +	if (get_order(vsize) >= MAX_ORDER)
>  		return -ENOMEM;
>  
>  	dma_map = kzalloc(sizeof(struct dma_mapping), GFP_KERNEL);
> diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_utils.c
> index f778e11237a6..ac29698d085a 100644
> --- a/drivers/misc/genwqe/card_utils.c
> +++ b/drivers/misc/genwqe/card_utils.c
> @@ -308,7 +308,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
>  	sgl->write = write;
>  	sgl->sgl_size = genwqe_sgl_size(sgl->nr_pages);
>  
> -	if (get_order(sgl->sgl_size) > MAX_ORDER) {
> +	if (get_order(sgl->sgl_size) >= MAX_ORDER) {
>  		dev_err(&pci_dev->dev,
>  			"[%s] err: too much memory requested!\n", __func__);
>  		return ret;


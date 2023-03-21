Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797B26C2BDB
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 09:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCUICH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 04:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjCUIB6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 04:01:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0383928F;
        Tue, 21 Mar 2023 01:01:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA75C21A7C;
        Tue, 21 Mar 2023 08:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679385714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctS+eKV0U5OIdHV3xnU3MmgGcrolUtwAToziodkFTXQ=;
        b=j55E7TVWuklZamsfwYqXgOHP+fWCAZ2tGRT5x7bQjlk1kBu2/SjlvPQw6E9FKUHaPudmkj
        un9PVnQw/lXKgrLiq7S2u/JanY88w5/Tk+l9hhYYU7H01VcAo5shYeRxIXLm/xZEZtRhff
        vjs2z8HcwLOtqdMVAeLA38fmOzlVGK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679385714;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctS+eKV0U5OIdHV3xnU3MmgGcrolUtwAToziodkFTXQ=;
        b=5rCAUXh9BgcbPrucB5nQUS11Y73lHAQGezjezAFYeMah7RiMKbDcGyvQU+p0l3Ue93dIBM
        2WtgWFX0ziQDQuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3D3A13440;
        Tue, 21 Mar 2023 08:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n9oqK3JkGWS6OgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Mar 2023 08:01:54 +0000
Message-ID: <3f85d13e-5faa-ca0b-5ef5-79422bbae7a5@suse.cz>
Date:   Tue, 21 Mar 2023 09:01:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 07/10] mm/page_reporting: Fix MAX_ORDER usage in
 page_reporting_register()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-8-kirill.shutemov@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230315113133.11326-8-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/15/23 12:31, Kirill A. Shutemov wrote:
> MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
> can deliver is MAX_ORDER-1.
> 
> Fix MAX_ORDER usage in page_reporting_register().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  mm/page_reporting.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index c65813a9dc78..275b466de37b 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -370,7 +370,7 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>  	 */
>  
>  	if (page_reporting_order == -1) {
> -		if (prdev->order > 0 && prdev->order <= MAX_ORDER)
> +		if (prdev->order > 0 && prdev->order < MAX_ORDER)
>  			page_reporting_order = prdev->order;
>  		else
>  			page_reporting_order = pageblock_order;


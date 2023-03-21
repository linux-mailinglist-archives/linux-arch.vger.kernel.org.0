Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61166C2BB3
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 08:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjCUHuH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 03:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjCUHtq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 03:49:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66E0E18E;
        Tue, 21 Mar 2023 00:49:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 300BF21A8F;
        Tue, 21 Mar 2023 07:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679384970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s4W7gKMmHGb0ayQx6tQE8mbg4P/fHcq+VmAkv3kTCzs=;
        b=LYSvaIkWhLLUO6caIzYaAUkE3Kc++nlEJ7zWeaaOxRfxWnMs8NAFsmGiGpTK2XGykmuzMS
        gcoFbnmp15oBSrgnUVGeanIqchMsY6qkfaEfchPFfRzaTyU4YjGtYcxUHJDuO6gJJ0GZDt
        pPVxoK/AZHjRtcldG/W5bCl5+jTy5DE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679384970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s4W7gKMmHGb0ayQx6tQE8mbg4P/fHcq+VmAkv3kTCzs=;
        b=SLLvPwEbjNhaNT64IgKgCpzxuV8WCV2lBi0VMD5Al5FCOQAWHF+HOwO8bP886Tfnofzyy/
        WjhTRoraTDDLIuCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06B8B13440;
        Tue, 21 Mar 2023 07:49:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b7vqAIphGWRzLQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Mar 2023 07:49:30 +0000
Message-ID: <5dc4dbdc-603d-0334-94a2-715032c4506b@suse.cz>
Date:   Tue, 21 Mar 2023 08:49:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/10] um: Fix MAX_ORDER usage in linux_main()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-3-kirill.shutemov@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230315113133.11326-3-kirill.shutemov@linux.intel.com>
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
> Fix MAX_ORDER usage in linux_main().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
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


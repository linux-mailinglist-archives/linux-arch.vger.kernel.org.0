Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE49704572
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 08:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjEPGsq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 02:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjEPGsp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 02:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D68F448A;
        Mon, 15 May 2023 23:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 769C36346B;
        Tue, 16 May 2023 06:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677F7C433D2;
        Tue, 16 May 2023 06:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684219720;
        bh=8lytz54EhtEUEVF10JvyKvoVdJWuXGHYr66pEwPqID4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5nWBGVpVh7eIObnI3HWT8d0qnKWC0WDTq6zvJVPgfC9L8qza8lZPGSQ4Rbb0QDyU
         z8LRiznozgmQ+IzAHmth7ZWnHGjCHRNxsRsoU/GiM+/ZSQvULmR9qvdU7FCpwiK/GL
         XCEkd4wA5mSoLqfE3KqOrMETf1k0jX0+ScqlQI6GqLQ6YL3VLQOyBvVnjrTq5cmyjA
         XlUznXBW8q1iNm93zJJnIbqE5AGFIJL1UIQQN/Vj6FHFfMFI0+9C2MRSscwWCAOYN9
         w8pwzCE50uFiCNCgyDJjzv2eBGJL8VrJWuOrr8WY0XUPphLbW8yPj55LJmd9+u1S9J
         AmXBhTOzSw2Hg==
Date:   Tue, 16 May 2023 09:48:32 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de
Subject: Re: [PATCH v5 RESEND 06/17] mm/ioremap: add slab availability
 checking in ioremap_prot
Message-ID: <ZGMnQBD6p1s/QKI0@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-7-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-7-bhe@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:37PM +0800, Baoquan He wrote:
> Several architectures has done checking if slab if available in
> ioremap_prot(). In fact it should be done in generic ioremap_prot()
> since on any architecutre, slab allocator must be available before
> get_vm_area_caller() and vunmap() are used.
> 
> Add the checking into generic_ioremap_prot().
> 
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/ioremap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 9f34a8f90b58..2fbe6b9bc50e 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -18,6 +18,10 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	phys_addr_t last_addr;
>  	struct vm_struct *area;
>  
> +	/* An early platform driver might end up here */
> +	if (!slab_is_available())
> +		return NULL;
> +
>  	/* Disallow wrap-around or zero size */
>  	last_addr = phys_addr + size - 1;
>  	if (!size || last_addr < phys_addr)
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.

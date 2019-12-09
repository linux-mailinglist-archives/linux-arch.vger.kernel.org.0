Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0A8116681
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2019 06:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLIFnX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Dec 2019 00:43:23 -0500
Received: from ozlabs.org ([203.11.71.1]:37465 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfLIFnX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Dec 2019 00:43:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47WXD73mCSz9sP6;
        Mon,  9 Dec 2019 16:43:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1575870201;
        bh=EU4lPc5IWHfktnisegd6j5Y6xKovFoBVkVjlsMX4/pE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=igRorkS97HOON5GNqt21oBCytjvq3MO/I/pbqKeA+/w/EC95/C9ComNHV83pfOIJo
         b4BGFIKg3r1DHuXk2sPf8s03P3Ccx8hYkery5YB1CDqnFS8wlBMbZBLR3vtejfl7jy
         h6x4j9eJEGkJyxOc4uI8gM+N1rH/AVk/tDaClHwM+fcgo3GK4PTf+I/L3YSt4sLzOe
         RiNCkQNfxvAXHlPpCsDKltYrZ92IGr8D/O4Hj8MjwAiYJrgDx589PIR6zviioFUxG3
         +7ISbse34yFB4L6wshgcHwRY2JHcyhf5nNMe6B1HMP9BmG6lP0V29ZZes4qk3i1bZa
         6BWY4Z7Sl5Y9Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] powerpc: ensure that swiotlb buffer is allocated from low memory
In-Reply-To: <20191204123524.22919-1-rppt@kernel.org>
References: <20191204123524.22919-1-rppt@kernel.org>
Date:   Mon, 09 Dec 2019 16:43:17 +1100
Message-ID: <87h82aqcju.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Some powerpc platforms (e.g. 85xx) limit DMA-able memory way below 4G. If a
> system has more physical memory than this limit, the swiotlb buffer is not
> addressable because it is allocated from memblock using top-down mode.
>
> Force memblock to bottom-up mode before calling swiotlb_init() to ensure
> that the swiotlb buffer is DMA-able.
>
> Link: https://lkml.kernel.org/r/F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de

This wasn't bisected, but I thought it was a regression. Do we know what
commit caused it?

Was it 25078dc1f74b ("powerpc: use mm zones more sensibly") ?

Or was that a red herring?

cheers

> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darren Stevens <darren@stevens-zone.net>
> Cc: mad skateman <madskateman@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  arch/powerpc/mm/mem.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index be941d382c8d..14c2c53e3f9e 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -260,6 +260,14 @@ void __init mem_init(void)
>  	BUILD_BUG_ON(MMU_PAGE_COUNT > 16);
>  
>  #ifdef CONFIG_SWIOTLB
> +	/*
> +	 * Some platforms (e.g. 85xx) limit DMA-able memory way below
> +	 * 4G. We force memblock to bottom-up mode to ensure that the
> +	 * memory allocated in swiotlb_init() is DMA-able.
> +	 * As it's the last memblock allocation, no need to reset it
> +	 * back to to-down.
> +	 */
> +	memblock_set_bottom_up(true);
>  	swiotlb_init(0);
>  #endif
>  
> -- 
> 2.24.0

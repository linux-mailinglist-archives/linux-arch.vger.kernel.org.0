Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A585623C418
	for <lists+linux-arch@lfdr.de>; Wed,  5 Aug 2020 05:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgHEDun (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 23:50:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47306 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726230AbgHEDum (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 23:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596599441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PBRFUAvhtw5NCrkPVOAd8K2sp2Oav4oQ9F6n5x6FCHA=;
        b=EpqpRnxlyFlrjlyw7bkaQaUpWOIT9jx/4C19hWNepyupGYYcajnOtvCObEUC2XGNdjQ9vn
        uJmxFXEE7fMaVz2lR3eQEA/RXH440BKOjEvx5OY3HbcQl4SerTeiACcz4a5Jb2qJt7TBLo
        cjEHrvRh9CTzwQnBBpQT7xNOtjNMI4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-xI0_yRdGMPGizyxDuo-nyA-1; Tue, 04 Aug 2020 23:50:36 -0400
X-MC-Unique: xI0_yRdGMPGizyxDuo-nyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CFAE102C7EC;
        Wed,  5 Aug 2020 03:50:30 +0000 (UTC)
Received: from localhost (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17E4F8AC06;
        Wed,  5 Aug 2020 03:50:27 +0000 (UTC)
Date:   Wed, 5 Aug 2020 11:50:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        clang-built-linux@googlegroups.com,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org
Subject: Re: [PATCH v2 02/17] dma-contiguous: simplify
 cma_early_percent_memory()
Message-ID: <20200805035024.GR10792@MiWiFi-R3L-srv>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802163601.8189-3-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 08/02/20 at 07:35pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The memory size calculation in cma_early_percent_memory() traverses
> memblock.memory rather than simply call memblock_phys_mem_size(). The
> comment in that function suggests that at some point there should have been
> call to memblock_analyze() before memblock_phys_mem_size() could be used.
> As of now, there is no memblock_analyze() at all and
> memblock_phys_mem_size() can be used as soon as cold-plug memory is
> registerd with memblock.
> 
> Replace loop over memblock.memory with a call to memblock_phys_mem_size().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/contiguous.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 15bc5026c485..1992afd8ca7b 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -73,16 +73,7 @@ early_param("cma", early_cma);
>  
>  static phys_addr_t __init __maybe_unused cma_early_percent_memory(void)
>  {
> -	struct memblock_region *reg;
> -	unsigned long total_pages = 0;
> -
> -	/*
> -	 * We cannot use memblock_phys_mem_size() here, because
> -	 * memblock_analyze() has not been called yet.
> -	 */
> -	for_each_memblock(memory, reg)
> -		total_pages += memblock_region_memory_end_pfn(reg) -
> -			       memblock_region_memory_base_pfn(reg);
> +	unsigned long total_pages = PHYS_PFN(memblock_phys_mem_size());

Reviewed-by: Baoquan He <bhe@redhat.com>

>  
>  	return (total_pages * CONFIG_CMA_SIZE_PERCENTAGE / 100) << PAGE_SHIFT;
>  }
> -- 
> 2.26.2
> 


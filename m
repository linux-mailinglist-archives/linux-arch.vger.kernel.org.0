Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517B847C0B3
	for <lists+linux-arch@lfdr.de>; Tue, 21 Dec 2021 14:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbhLUNVo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Dec 2021 08:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhLUNVo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Dec 2021 08:21:44 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20AAC061574;
        Tue, 21 Dec 2021 05:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B/oDToJjF+9MzhiotE5SBO6bEHgGlfnze/KNPpAHsCg=; b=SfQyc19jT/JZHSai2UnntFDszE
        dHXubqLDm2OtdY+7lByHgwHoqZv5IkGbAbEqeONpa6hu5tS8N2Fk/5x1B+aB4TlkCHoY7FQ4fKb5d
        fCmrRWtxPOcJVp2OyTmyMq5mxuavxsyrcrhutLwB0905JlF6NwGi1Eq8qOC0SQqV+23s3ezCVK8GQ
        qdAaPpEM23eAPsR/2hqZI7bJ32V+qYe5eixsRzCGEviLjVtEvoBkHH2Lp+uXWD0AZpVxY4hjl2bhR
        cqojP2dzXmKesKtM+SNwap1S7kIA7njOKiAiDTI2Aa3THkrBARxKYFudRpw4uZMgZ/3TADlJBvQo6
        TbsMRdmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzf55-002jwx-KO; Tue, 21 Dec 2021 13:21:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D41533002AE;
        Tue, 21 Dec 2021 14:21:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE30C206E66FD; Tue, 21 Dec 2021 14:21:26 +0100 (CET)
Date:   Tue, 21 Dec 2021 14:21:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, kernel@openvz.org
Subject: Re: [PATCH/RFC v2 1/3] tlb: mmu_gather: introduce
 CONFIG_MMU_GATHER_TABLE_FREE_COMMON
Message-ID: <YcHU1maQkp4VXZvS@hirez.programming.kicks-ass.net>
References: <20211218185205.1744125-1-nikita.yushchenko@virtuozzo.com>
 <20211218185205.1744125-2-nikita.yushchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218185205.1744125-2-nikita.yushchenko@virtuozzo.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Dec 18, 2021 at 09:52:04PM +0300, Nikita Yushchenko wrote:
> For architectures that use free_page_and_swap_cache() as their
> __tlb_remove_table(), place that common implementation into
> mm/mmu_gather.c, ifdef'ed by CONFIG_MMU_GATHER_TABLE_FREE_COMMON.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
> ---
>  arch/Kconfig                 |  3 +++
>  arch/arm/Kconfig             |  1 +
>  arch/arm/include/asm/tlb.h   |  5 -----
>  arch/arm64/Kconfig           |  1 +
>  arch/arm64/include/asm/tlb.h |  5 -----
>  arch/x86/Kconfig             |  1 +
>  arch/x86/include/asm/tlb.h   | 14 --------------
>  include/asm-generic/tlb.h    |  5 +++++
>  mm/mmu_gather.c              | 10 ++++++++++
>  9 files changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index d3c4ab249e9c..9eba553cd86f 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -415,6 +415,9 @@ config HAVE_ARCH_JUMP_LABEL_RELATIVE
>  config MMU_GATHER_TABLE_FREE
>  	bool
>  
> +config MMU_GATHER_TABLE_FREE_COMMON
> +	bool

I don't like that name... The point isn't that it's common, the point is
that the page-table's are backed by pages.

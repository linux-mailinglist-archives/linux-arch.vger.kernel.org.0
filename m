Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A421D5BE
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 14:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgGMMV5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 08:21:57 -0400
Received: from foss.arm.com ([217.140.110.172]:59286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMMV4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jul 2020 08:21:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E83530E;
        Mon, 13 Jul 2020 05:21:56 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA0163F887;
        Mon, 13 Jul 2020 05:21:54 -0700 (PDT)
Date:   Mon, 13 Jul 2020 13:21:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers
Message-ID: <20200713122148.GA51007@lakrids.cambridge.arm.com>
References: <20200710135706.537715-1-hch@lst.de>
 <20200710135706.537715-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710135706.537715-6-hch@lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 10, 2020 at 03:57:05PM +0200, Christoph Hellwig wrote:
> Add helpers to wraper the get_fs/set_fs magic for undoing any damange
> done by set_fs(KERNEL_DS).  There is no real functional benefit, but this
> documents the intent of these calls better, and will allow stubbing the
> functions out easily for kernels builds that do not allow address space
> overrides in the future.

> diff --git a/arch/m68k/include/asm/tlbflush.h b/arch/m68k/include/asm/tlbflush.h
> index 191e75a6bb249e..30471549e1e224 100644
> --- a/arch/m68k/include/asm/tlbflush.h
> +++ b/arch/m68k/include/asm/tlbflush.h
> @@ -13,13 +13,13 @@ static inline void flush_tlb_kernel_page(void *addr)
>  	if (CPU_IS_COLDFIRE) {
>  		mmu_write(MMUOR, MMUOR_CNL);
>  	} else if (CPU_IS_040_OR_060) {
> -		mm_segment_t old_fs = get_fs();
> -		set_fs(KERNEL_DS);
> +		mm_segment_t old_fs = force_uaccess_begin();
> +

This used to set KERNEL_DS, and now it sets USER_DS, which looks wrong
superficially.

If the new behaviour is fine it suggests that the old behaviour was
wrong, or that this is superfluous and could go entirely.

Geert?

Mark.

>  		__asm__ __volatile__(".chip 68040\n\t"
>  				     "pflush (%0)\n\t"
>  				     ".chip 68k"
>  				     : : "a" (addr));
> -		set_fs(old_fs);
> +		force_uaccess_end(old_fs);
>  	} else if (CPU_IS_020_OR_030)
>  		__asm__ __volatile__("pflush #4,#4,(%0)" : : "a" (addr));

> +/*
> + * Force the uaccess routines to be wired up for actual userspace access,
> + * overriding any possible set_fs(KERNEL_DS) still lingering around.  Undone
> + * using force_uaccess_end below.
> + */
> +static inline mm_segment_t force_uaccess_begin(void)
> +{
> +	mm_segment_t fs = get_fs();
> +
> +	set_fs(USER_DS);
> +	return fs;
> +}
> +
> +static inline void force_uaccess_end(mm_segment_t oldfs)
> +{
> +	set_fs(oldfs);
> +}

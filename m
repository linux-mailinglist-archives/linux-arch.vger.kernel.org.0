Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409D5390111
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 14:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhEYMh3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 08:37:29 -0400
Received: from verein.lst.de ([213.95.11.211]:58985 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232353AbhEYMh2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 08:37:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 647BA6736F; Tue, 25 May 2021 14:35:56 +0200 (CEST)
Date:   Tue, 25 May 2021 14:35:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     guoren@kernel.org
Cc:     anup.patel@wdc.com, palmerdabbelt@google.com, arnd@arndb.de,
        hch@lst.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V3 2/2] riscv: Use use_asid_allocator flush TLB
Message-ID: <20210525123556.GB4842@lst.de>
References: <1621945447-38820-1-git-send-email-guoren@kernel.org> <1621945447-38820-3-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621945447-38820-3-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 12:24:07PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Use static_branch_unlikely(&use_asid_allocator) to keep the origin
> tlb flush style, so it's no effect on the existing machine. Here
> are the optimized functions:
>  - flush_tlb_mm
>  - flush_tlb_page
>  - flush_tlb_range
> 
> All above are based on the below new implement functions:
>  - __sbi_tlb_flush_range_asid
>  - local_flush_tlb_range_asid


This mentiones what functions you're changing, but not what the
substantial change is, and more importantly why you change it.

> +static inline void local_flush_tlb_range_asid(unsigned long start, unsigned long size,
> +					      unsigned long asid)

Crazy long line.  Should be:

static inline void local_flush_tlb_range_asid(unsigned long start,
		unsigned long size, unsigned long asid)

> +{
> +	unsigned long tmp = start & PAGE_MASK;
> +	unsigned long end = ALIGN(start + size, PAGE_SIZE);
> +
> +	if (size == -1) {
> +		__asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) : "memory");
> +		return;

Please split the global (size == -1) case into separate helpers.

> +	while(tmp < end) {

Missing whitespace befre the (.

Also I think this would read nicer as:

	for (tmp = start & PAGE_MASK; tmp < end; tmp += PAGE_SIZE)

> +static void __sbi_tlb_flush_range_asid(struct cpumask *cmask, unsigned long start,
> +				       unsigned long size, unsigned long asid)

Another overly long line.

Also for all thee __sbi_* functions, why the __ prefix?

> +	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
> +		local_flush_tlb_range_asid(start, size, asid);
> +	} else {
> +		riscv_cpuid_to_hartid_mask(cmask, &hmask);
> +		sbi_remote_sfence_vma_asid(cpumask_bits(&hmask), start, size, asid);

Another long line (and a few more later).

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA98D39CF91
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFFOkm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 10:40:42 -0400
Received: from verein.lst.de ([213.95.11.211]:42995 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhFFOkm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 10:40:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1D8B767373; Sun,  6 Jun 2021 16:38:49 +0200 (CEST)
Date:   Sun, 6 Jun 2021 16:38:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     guoren@kernel.org
Cc:     anup.patel@wdc.com, palmerdabbelt@google.com, arnd@arndb.de,
        wens@csie.org, maxime@cerno.tech, drew@beagleboard.org,
        liush@allwinnertech.com, lazyparser@gmail.com, wefu@redhat.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 2/3] riscv: Add ASID-based tlbflushing methods
Message-ID: <20210606143848.GA5983@lst.de>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org> <1622970249-50770-4-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622970249-50770-4-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 09:03:58AM +0000, guoren@kernel.org wrote:
> +static inline void local_flush_tlb_all_asid(unsigned long asid)
> +{
> +	__asm__ __volatile__ ("sfence.vma x0, %0"
> +			:
> +			: "r" (asid)
> +			: "memory");
> +}
> +
> +static inline void local_flush_tlb_range_asid(unsigned long start,
> +				unsigned long size, unsigned long asid)
> +{
> +	unsigned long tmp, end = ALIGN(start + size, PAGE_SIZE);
> +
> +	for (tmp = start & PAGE_MASK; tmp < end; tmp += PAGE_SIZE) {
> +		__asm__ __volatile__ ("sfence.vma %0, %1"
> +				:
> +				: "r" (tmp), "r" (asid)
> +				: "memory");
> +	}

No need to expose these in a header.

> +static void __sbi_tlb_flush_range_asid(struct cpumask *cmask,
> +				       unsigned long start,
> +				       unsigned long size,
> +				       unsigned long asid)
> +{
> +	struct cpumask hmask;
> +	unsigned int cpuid;
> +
> +	if (cpumask_empty(cmask))
> +		return;
> +
> +	cpuid = get_cpu();
> +
> +	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
> +		if (size == -1)
> +			local_flush_tlb_all_asid(asid);
> +		else
> +			local_flush_tlb_range_asid(start, size, asid);
> +	} else {
> +		riscv_cpuid_to_hartid_mask(cmask, &hmask);
> +		sbi_remote_sfence_vma_asid(cpumask_bits(&hmask),
> +					   start, size, asid);
> +	}
> +
> +	put_cpu();
> +}

Still no need to duplicate most of this logic.  Also please document
why this uses a different tradeoff for the flush all logic compared
to the non-ASID path.

> +
>  void flush_tlb_mm(struct mm_struct *mm)
>  {
> -	__sbi_tlb_flush_range(mm_cpumask(mm), 0, -1);
> +	if (static_branch_unlikely(&use_asid_allocator))
> +		__sbi_tlb_flush_range_asid(mm_cpumask(mm), 0, -1,
> +					   atomic_long_read(&mm->context.id));
> +	else
> +		__sbi_tlb_flush_range(mm_cpumask(mm), 0, -1);
>  }
>  
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  {
> -	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
> +	if (static_branch_unlikely(&use_asid_allocator))
> +		__sbi_tlb_flush_range_asid(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE,
> +					   atomic_long_read(&vma->vm_mm->context.id));
> +	else
> +		__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
>  }
>  
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  		     unsigned long end)
>  {
> -	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start);
> +	if (static_branch_unlikely(&use_asid_allocator))
> +		__sbi_tlb_flush_range_asid(mm_cpumask(vma->vm_mm), start, end - start,
> +					   atomic_long_read(&vma->vm_mm->context.id));
> +	else
> +		__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start);

Various overly long lines (which are trivially avoided when doing the
right thing from the beginning).

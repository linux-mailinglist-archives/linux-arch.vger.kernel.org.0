Return-Path: <linux-arch+bounces-9805-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B05A1507A
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2025 14:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455EB1885184
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2025 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC27200106;
	Fri, 17 Jan 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCvHMpF2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECADE1FF609;
	Fri, 17 Jan 2025 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120339; cv=none; b=bkmePTx4/SxrARAOio/0gqSLXcSTWs34TYSWrNNZM2I3oPAcX4iPwzD6HcLhi4KxXNU//ACpWHdqph2gJar5i+Zsuz2ne6nghcY4r/IqsHI2ZGgKcBuEe1VWqL4bZKrbfX9/lUYJWLb4EjGeCba8NUqwr1hI1wlgDdiQmCuvMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120339; c=relaxed/simple;
	bh=i5g2DbcJlsukG3CuQeCOvnrmGoI0+t7RerfHcE2ITE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucdu0Os/gLhJRTQzLQuhS12caSJ1cmaga+uuBWqYmQadtDVdt3+LwH3iVzAOowAQdRBD71n1zbG/BlNUic/9ZhzLn0FqQNxUQhKhdPF5vYrs9oi3X/uqYuVq700AkviUM+DClMUABbX5bbkZAqwqR/6E1v3hLNCxpmggUA3OPrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCvHMpF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C43C4CEDD;
	Fri, 17 Jan 2025 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737120338;
	bh=i5g2DbcJlsukG3CuQeCOvnrmGoI0+t7RerfHcE2ITE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCvHMpF21/84VoMzTIfTmODZawDxjude8tCR6JJtkJECU6I5I9whWXy05LWEyoVNW
	 KSzrpuQi7EY7p8WZMS465l3rzsHJ8EnYeKCSayrYuWoVdpTDqvziBmoejLV5qSMBK6
	 f5E+BQjEiCRh0u6SKqq//93pPU+X4JoeMx70R+9aHhWo8pxelv+5LYbQpozArWbl4N
	 fjahkxBv/te1ioiDTpeoXYuLizhvr0ePIgbB6YsYdqX4IS/429ehvwWhMUBrLB8HOx
	 2ER9LwPKInXFc4sc8Z5xZ0s6RECYLRZli7PrwB954w5tTFqDoUfRjjNblQvSNEU4sb
	 Uskxi7/yiLEew==
Date: Fri, 17 Jan 2025 13:25:28 +0000
From: Will Deacon <will@kernel.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, kevin.brodsky@arm.com,
	alex@ghiti.fr, andreas@gaisler.com, palmer@dabbelt.com,
	tglx@linutronix.de, david@redhat.com, jannh@google.com,
	hughd@google.com, yuzhao@google.com, willy@infradead.org,
	muchun.song@linux.dev, vbabka@kernel.org,
	lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
	rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de,
	aneesh.kumar@kernel.org, npiggin@gmail.com,
	dave.hansen@linux.intel.com, rppt@kernel.org, ryan.roberts@arm.com,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v5 05/17] arm64: pgtable: use mmu gather to free p4d
 level page table
Message-ID: <20250117132527.GA17058@willie-the-truck>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
 <3fd48525397b34a64f7c0eb76746da30814dc941.1736317725.git.zhengqi.arch@bytedance.com>
 <20250113162600.GA14101@willie-the-truck>
 <a017d072-943f-4008-bb1d-7be438804a44@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a017d072-943f-4008-bb1d-7be438804a44@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jan 14, 2025 at 10:26:54AM +0800, Qi Zheng wrote:
> Hi Will,
> 
> On 2025/1/14 00:26, Will Deacon wrote:
> > On Wed, Jan 08, 2025 at 02:57:21PM +0800, Qi Zheng wrote:
> > > Like other levels of page tables, also use mmu gather mechanism to free
> > > p4d level page table.
> > > 
> > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > ---
> > >   arch/arm64/include/asm/pgalloc.h |  1 -
> > >   arch/arm64/include/asm/tlb.h     | 14 ++++++++++++++
> > >   2 files changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> > > index 2965f5a7e39e3..1b4509d3382c6 100644
> > > --- a/arch/arm64/include/asm/pgalloc.h
> > > +++ b/arch/arm64/include/asm/pgalloc.h
> > > @@ -85,7 +85,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
> > >   	__pgd_populate(pgdp, __pa(p4dp), pgdval);
> > >   }
> > > -#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
> > >   #else
> > >   static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
> > >   {
> > > diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> > > index a947c6e784ed2..445282cde9afb 100644
> > > --- a/arch/arm64/include/asm/tlb.h
> > > +++ b/arch/arm64/include/asm/tlb.h
> > > @@ -111,4 +111,18 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
> > >   }
> > >   #endif
> > > +#if CONFIG_PGTABLE_LEVELS > 4
> > > +static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
> > > +				  unsigned long addr)
> > > +{
> > > +	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
> > > +
> > > +	if (!pgtable_l5_enabled())
> > > +		return;
> > > +
> > > +	pagetable_p4d_dtor(ptdesc);
> > > +	tlb_remove_ptdesc(tlb, ptdesc);
> > > +}
> > 
> > Should we update p4d_free() to call the destructor, too? It looks like
> > it just does free_page() atm.
> 
> The patch #3 introduces the generic p4d_free() and lets arm64 to use it.
> The patch #4 adds the destructor to generic p4d_free(). So IIUC, there
> is no problem here.

Sorry, I missed that. In which case:

Acked-by: Will Deacon <will@kernel.org>

Will


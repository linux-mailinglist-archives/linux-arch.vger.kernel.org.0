Return-Path: <linux-arch+bounces-1223-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C7A82169C
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 04:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8F42813F8
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 03:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94774EC6;
	Tue,  2 Jan 2024 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFpz/HwQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7DEBC;
	Tue,  2 Jan 2024 03:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABCFC433C7;
	Tue,  2 Jan 2024 03:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704165920;
	bh=o/p87hu05uv8+RjO26XUTaEkNHmf3m3Fyaag4qcW8jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFpz/HwQpMqLwV8rzZWW11P6Dv8qkJCFf/jA3j9XCkL7/ypnfinGbNA8QHws0wBUj
	 wgYpbC096foRDJI1zKTYJ+eFZJ23P+/seKkF0K4GTanOpPW4trwk21boCAcz7rH1jt
	 W+GOyIlUPV6uRl7EeHQJKqaxDMweOKubhk89NArt78GqNR/QEireW4+2vfU/+/Gl8T
	 9h3MA9fZK4+f/aGVWSTsy+LklekVjKO/0rJ1AUq7faP+1ZbPJ/3BaPUo/CQakpck/2
	 ifxd8ipDb53P3TKakbMzxyGG51wiXE3sikJoFCMGAVs+LwB18YNYXyGG7z3wgoqls3
	 TENkP7y2dOl1Q==
Date: Tue, 2 Jan 2024 11:12:32 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] riscv: tlb: avoid tlb flushing if fullmm == 1
Message-ID: <ZZN/IKBgbtyIc+NL@xhacker>
References: <20231228084642.1765-1-jszhang@kernel.org>
 <20231228084642.1765-3-jszhang@kernel.org>
 <e227f095-0c3d-43c4-8ba3-8ec1b925b929@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e227f095-0c3d-43c4-8ba3-8ec1b925b929@ghiti.fr>

On Sat, Dec 30, 2023 at 07:26:11PM +0100, Alexandre Ghiti wrote:
> Hi Jisheng,

Hi Alex,

> 
> On 28/12/2023 09:46, Jisheng Zhang wrote:
> > The mmu_gather code sets fullmm=1 when tearing down the entire address
> > space for an mm_struct on exit or execve. So if the underlying platform
> > supports ASID, the tlb flushing can be avoided because the ASID
> > allocator will never re-allocate a dirty ASID.
> > 
> > Use the performance of Process creation in unixbench on T-HEAD TH1520
> > platform is improved by about 4%.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   arch/riscv/include/asm/tlb.h | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
> > index 1eb5682b2af6..35f3c214332e 100644
> > --- a/arch/riscv/include/asm/tlb.h
> > +++ b/arch/riscv/include/asm/tlb.h
> > @@ -12,10 +12,19 @@ static void tlb_flush(struct mmu_gather *tlb);
> >   #define tlb_flush tlb_flush
> >   #include <asm-generic/tlb.h>
> > +#include <asm/mmu_context.h>
> >   static inline void tlb_flush(struct mmu_gather *tlb)
> >   {
> >   #ifdef CONFIG_MMU
> > +	/*
> > +	 * If ASID is supported, the ASID allocator will either invalidate the
> > +	 * ASID or mark it as used. So we can avoid TLB invalidation when
> > +	 * pulling down a full mm.
> > +	 */
> 
> 
> Given the number of bits are limited for the ASID, at some point we'll reuse
> previously allocated ASID so the ASID allocator must make sure to invalidate
> the entries when reusing an ASID: can you point where this is done?

Per my understanding of the code, the path would be
set_mm_asid()
  __new_context()
    __flush_context()  // set context_tlb_flush_pending
if (need_flush_tlb)
  local_flush_tlb_all()

Thanks
 
> 
> > +	if (static_branch_likely(&use_asid_allocator) && tlb->fullmm)
> > +		return;
> > +
> >   	if (tlb->fullmm || tlb->need_flush_all)
> >   		flush_tlb_mm(tlb->mm);
> >   	else


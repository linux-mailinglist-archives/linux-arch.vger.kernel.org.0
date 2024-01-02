Return-Path: <linux-arch+bounces-1225-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824F08216A8
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 04:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7BCB20F75
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 03:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A9DEC4;
	Tue,  2 Jan 2024 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbN/lWB+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441B5EBC;
	Tue,  2 Jan 2024 03:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB25C433C8;
	Tue,  2 Jan 2024 03:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704166719;
	bh=sqjF+WOs+/Ej1dm+kRiv34bMwdUQi5o86nzg58LpkDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbN/lWB+mMNkcDOyfAmuvldxhZoz4+kmWPEmLA5B/1PxsWD+5Xj9PbHL/KBycP2s7
	 MbSOthA8nrqgEAtFNpFEVqdPKCLGdpuXc5yrseVEOo8mywulDkMIwrtjFRLZ5Z0ow6
	 +dG4bf9OIEIhFG8PZqpj2Ot0E2qYPmEPF6uxR7qV+wvk+6Yc+KBGZ8F0USKJ6ug7+G
	 fb6Wftzh6J+fChGZOY7FDMItIJNS7+qUpEkZRH6THKmgmAILrvooJ27F1waBhFNnHl
	 f0/EiSV4Uox/QrDzrFAniIXnpNTapL7vWjUpw/uTFe3s3lHIKEXedq+RFWmB6jNZ/9
	 Vs4F5EdGiP8Ew==
Date: Tue, 2 Jan 2024 11:25:57 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] riscv: enable HAVE_FAST_GUP if MMU
Message-ID: <ZZOCRZjBch1grrFp@xhacker>
References: <20231219175046.2496-1-jszhang@kernel.org>
 <20231219175046.2496-5-jszhang@kernel.org>
 <3d36ca3c-9a91-41a7-9e68-288982c2c8a8@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d36ca3c-9a91-41a7-9e68-288982c2c8a8@ghiti.fr>

On Sun, Dec 31, 2023 at 07:37:33AM +0100, Alexandre Ghiti wrote:
> On 19/12/2023 18:50, Jisheng Zhang wrote:
> > Activate the fast gup for riscv mmu platforms. Here are some
> > GUP_FAST_BENCHMARK performance numbers:
> > 
> > Before the patch:
> > GUP_FAST_BENCHMARK: Time: get:53203 put:5085 us
> > 
> > After the patch:
> > GUP_FAST_BENCHMARK: Time: get:17711 put:5060 us
> 
> 
> On which platform did you run this benchmark?

T-HEAD th1520(cpufreq isn't enabled since the clk/pll isn't upstreamed,
so cpu is running at the default freq set by u-boot)
> 
> 
> > 
> > The get time is reduced by 66.7%! IOW, 3x get speed!
> 
> 
> Well done!
> 
> Thanks,
> 
> Alex
> 
> 
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   arch/riscv/Kconfig               | 1 +
> >   arch/riscv/include/asm/pgtable.h | 6 ++++++
> >   2 files changed, 7 insertions(+)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d3555173d9f4..04df9920282d 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -119,6 +119,7 @@ config RISCV
> >   	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
> >   	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
> >   	select HAVE_EBPF_JIT if MMU
> > +	select HAVE_FAST_GUP if MMU
> >   	select HAVE_FUNCTION_ARG_ACCESS_API
> >   	select HAVE_FUNCTION_ERROR_INJECTION
> >   	select HAVE_GCC_PLUGINS
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index ab00235b018f..c6eb214139e6 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -673,6 +673,12 @@ static inline int pmd_write(pmd_t pmd)
> >   	return pte_write(pmd_pte(pmd));
> >   }
> > +#define pud_write pud_write
> > +static inline int pud_write(pud_t pud)
> > +{
> > +	return pte_write(pud_pte(pud));
> > +}
> > +
> >   static inline int pmd_dirty(pmd_t pmd)
> >   {
> >   	return pte_dirty(pmd_pte(pmd));


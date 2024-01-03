Return-Path: <linux-arch+bounces-1247-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA55382374F
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 22:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8CD287FA8
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 21:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EE11DA2B;
	Wed,  3 Jan 2024 21:54:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD51DA28;
	Wed,  3 Jan 2024 21:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD1BC433C8;
	Wed,  3 Jan 2024 21:54:34 +0000 (UTC)
Date: Wed, 3 Jan 2024 21:54:32 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Nadav Amit <namit@vmware.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Yu Zhao <yuzhao@google.com>,
	x86@kernel.org
Subject: Re: [PATCH 1/2] mm/tlb: fix fullmm semantics
Message-ID: <ZZXXmFthrXO6G9OE@arm.com>
References: <20231228084642.1765-1-jszhang@kernel.org>
 <20231228084642.1765-2-jszhang@kernel.org>
 <ZZWh4c3ZUtadFqD1@arm.com>
 <6ee6340a-ffe2-4106-b845-47cf443558c3@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ee6340a-ffe2-4106-b845-47cf443558c3@intel.com>

On Wed, Jan 03, 2024 at 12:26:29PM -0800, Dave Hansen wrote:
> On 1/3/24 10:05, Catalin Marinas wrote:
> >> --- a/mm/mmu_gather.c
> >> +++ b/mm/mmu_gather.c
> >> @@ -384,7 +384,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb)
> >>  		 * On x86 non-fullmm doesn't yield significant difference
> >>  		 * against fullmm.
> >>  		 */
> >> -		tlb->fullmm = 1;
> >> +		tlb->need_flush_all = 1;
> >>  		__tlb_reset_range(tlb);
> >>  		tlb->freed_tables = 1;
> >>  	}
> > The optimisation here was added about a year later in commit
> > 7a30df49f63a ("mm: mmu_gather: remove __tlb_reset_range() for force
> > flush"). Do we still need to keep freed_tables = 1 here? I'd say only
> > __tlb_reset_range().
> 
> I think the __tlb_reset_range() can be dangerous if it clears
> ->freed_tables.  On x86 at least, it might lead to skipping the TLB IPI
> for CPUs that are in lazy TLB mode.  When those wake back up they might
> start using the freed page tables.

You are right, I did not realise freed_tables is reset in
__tlb_reset_range().

-- 
Catalin


Return-Path: <linux-arch+bounces-15681-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0592CFCC3A
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 10:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DBC230F6EF9
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF6C2F6574;
	Wed,  7 Jan 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp3clrex"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A7139579;
	Wed,  7 Jan 2026 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767776766; cv=none; b=JKTvE81rp7U7fF002EfkTv7Bvjun+1Vx9Fvv4cP5VPHZFnZreZJKm8bE3kG47wF2ILsVfosPprpqYadWQ74V8/zVLu8Pe3lh5dWwoWRBgyTJ1/oygCgiZiORQjDrpOuzK41GUe7Dm1ZOG+ri32pjTLQB36gpLRlH7VAwCkDHk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767776766; c=relaxed/simple;
	bh=pMgU+C5FcOLCmP6ptKqgGVGjjrLsI8HbEkAssUEFqo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGVZKvknXFNDn7nEo9Va6l6h5K63mCPER8sPd40W63bONmgztZ9UlxkF11EapwWHi9Yuy2z4+RNnOVE7+zsKeeMa6hnrg0r6Lf03ydEdBMfBdTFnJIGlQtASmoDY9IWj0uGw1pnEEBRgcKh8PeTh66HV3Y1cU0SymFNDiueL2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp3clrex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E975C4CEF7;
	Wed,  7 Jan 2026 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767776765;
	bh=pMgU+C5FcOLCmP6ptKqgGVGjjrLsI8HbEkAssUEFqo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gp3clrexlQYTflBjEroGcywSAtzuN1Rwv0/QCEq3+PrJVFxFCVnDuCiuhES9FxML1
	 +DUJuEGclss/ATJRkynVca+Jnh3h6LZ1jKDlpzlWcRAo6+izc5O03Sz6x9cKrXFMgx
	 Y9bLrHVqoYADWUH0XXdTVI1WfeT51LlKWgWoIjuvqFNTY1UuAQKsvL4rxcgKYa53RT
	 HwvCsYN0oC3j7a2aYW9dIrhGAdIXV+DZgKRIozZxrf5fhJ5MEoUdXKbMDnSFYYNvLk
	 A7qYfjWXWSXUlNaU2pK6XIEQpbQqJGgs3DYcZ5NSns73Gyit+KIQRcRWBuYWEkPzAs
	 SZx9UZSS/0clA==
Date: Wed, 7 Jan 2026 11:05:42 +0200
From: Mike Rapoport <rppt@kernel.org>
To: alexs@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
	"moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
	"open list:MMU GATHER AND TLB INVALIDATION" <linux-arch@vger.kernel.org>,
	"open list:MMU GATHER AND TLB INVALIDATION" <linux-mm@kvack.org>,
	"open list:C-SKY ARCHITECTURE" <linux-csky@vger.kernel.org>,
	"open list:QUALCOMM HEXAGON ARCHITECTURE" <linux-hexagon@vger.kernel.org>,
	"open list:LOONGARCH" <loongarch@lists.linux.dev>,
	"open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
	"open list:MIPS" <linux-mips@vger.kernel.org>,
	"open list:OPENRISC ARCHITECTURE" <linux-openrisc@vger.kernel.org>,
	"open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:SUPERH" <linux-sh@vger.kernel.org>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>
Subject: Re: [PATCH] mm/pgtable: convert pgtable_t to ptdesc pointer
Message-ID: <aV4h5vQUNXn5cpMY@kernel.org>
References: <20260107064642.15771-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107064642.15771-1-alexs@kernel.org>

On Wed, Jan 07, 2026 at 02:46:35PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> After struct ptdesc introduced, pgtable_t should used it instead of old
> struct page pointer. The only thing in the way for this change is just
> pgtable->lru in pgtable_trans_huge_deposit/withdraw.
> 
> Let's convert them into ptdesc and use struct ptdesc* as pgtable_t.
> Thanks testing support from kernel test robot <lkp@intel.com>
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> ---

...

> diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
> index a17f01235c29..1a3484c2df4c 100644
> --- a/arch/arm/include/asm/pgalloc.h
> +++ b/arch/arm/include/asm/pgalloc.h
> @@ -96,12 +96,12 @@ pte_alloc_one(struct mm_struct *mm)
>  {
>  	struct page *pte;
>  
> -	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
> +	pte = ptdesc_page(__pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM));

When ptdesc will be separated from struct page, ptdesc_page() would fail if the
allocation failed. This line should be split into something like

	struct ptdesc *ptdesc = __pte_alloc_one(...);
	if (!ptesc)
		return NULL;
	pte = ptdesc_page(ptdesc);


>  	if (!pte)
>  		return NULL;
>  	if (!PageHighMem(pte))
>  		clean_pte_table(page_address(pte));
> -	return pte;
> +	return page_ptdesc(pte);
>  }
>  
>  static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t pte,

-- 
Sincerely yours,
Mike.


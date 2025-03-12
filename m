Return-Path: <linux-arch+bounces-10678-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF1A5D655
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 07:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93596177490
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 06:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F081E5B66;
	Wed, 12 Mar 2025 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5OTgyGp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63AF1E5701;
	Wed, 12 Mar 2025 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761320; cv=none; b=moXZK/UtD2p2bySJATUc3SvXMN7/OVYOdTgNRhbyHO9KJDIdRoLNAMiagieLmptEqsNqy3UMswjc96Z2G/3AQh9viXnhLsNheQR+tM/pWq3v+wJaSrmTXWpalUav+KOLHyXroZdkA1AVE1WLXI50CQLuH1MUmpKbVt5P0huB53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761320; c=relaxed/simple;
	bh=5mdaPZVI9H0/LV5hmobVgKrUIL2iuMSKhSTxPs81fPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrk+q2A8RBxWW5DthX4LRQA4N3kRlpbHsRv7abk7x+F/Mz16Fu+RlUiPFSe4OlX1QTMybemZiQ51STrsf2EL0aXlykcg2SQR0v9ZoTIy7EG79PvLV4re2IKpmKcVKudK3LyzAdI35bgVELVjFymcDEguB7kmg2V3gVbyouki+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5OTgyGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407D8C4CEE3;
	Wed, 12 Mar 2025 06:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741761319;
	bh=5mdaPZVI9H0/LV5hmobVgKrUIL2iuMSKhSTxPs81fPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5OTgyGpaumshikTp+iDDuLZlaDN5ZFNt0xhyxhEjxDoGdrRr5fCFJqupGsQ1e9mc
	 x5+ujh1N69RbM6sMUkTLS3DxQMtFw4J494229H1wYU5SpwxEIdYz9MdPy8mIFSl7pw
	 l37VuFqhXXoOyw7aw+nwsTVBrmtEviGrZHfYnDThjgKfYUlSm8F0VvgI37TsJEXPQg
	 Z/TS0S2P3vKV4E8YK2hLZIT0IUPWeSPBaDZrgP63fW1/ioeooSw+E437KEQCfrER7m
	 3bE2KZoye8/AcR9u24hQHDyQiTnD+Psif0K5SR2GQnCkTLYx0lBk09w8YpbQLP/phf
	 PvVxVGjqV5khg==
Date: Wed, 12 Mar 2025 08:34:56 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Mark Brown <broonie@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 10/13] arch, mm: set high_memory in free_area_init()
Message-ID: <Z9ErEBuMMvd6i2n9@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
 <20250306185124.3147510-11-rppt@kernel.org>
 <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk>
 <Z9CyRHewqfZlmgIo@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9CyRHewqfZlmgIo@shell.armlinux.org.uk>

On Tue, Mar 11, 2025 at 09:59:32PM +0000, Russell King (Oracle) wrote:
> On Tue, Mar 11, 2025 at 05:51:06PM +0000, Mark Brown wrote:
> > On Thu, Mar 06, 2025 at 08:51:20PM +0200, Mike Rapoport wrote:
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > 
> > > high_memory defines upper bound on the directly mapped memory.
> > > This bound is defined by the beginning of ZONE_HIGHMEM when a system has
> > > high memory and by the end of memory otherwise.
> > > 
> > > All this is known to generic memory management initialization code that
> > > can set high_memory while initializing core mm structures.
> > > 
> > > Remove per-architecture calculation of high_memory and add a generic
> > > version to free_area_init().
> > 
> > This patch appears to be causing breakage on a number of 32 bit arm
> > platforms, including qemu's virt-2.11,gic-version=3.  Affected platforms
> > die on boot with no output, a bisect with qemu points at this commit and
> > those for physical platforms appear to be converging on the same place.
> 
> I'm not convinced that the old and the new code is doing the same
> thing.
> 
> The new code:
> 
> +       phys_addr_t highmem = memblock_end_of_DRAM();
> +
> +#ifdef CONFIG_HIGHMEM
> +       unsigned long pfn = arch_zone_lowest_possible_pfn[ZONE_HIGHMEM];
> +
> +       if (arch_has_descending_max_zone_pfns() || highmem > PFN_PHYS(pfn))
> +               highmem = PFN_PHYS(pfn);
> +#endif
> +
> +       high_memory = phys_to_virt(highmem - 1) + 1;
> 
> First, when CONFIG_HIGHMEM is disabled, this code assumes that the last
> byte of DRAM declared to memblock is the highmem limit. This _could_
> overflow phys_to_virt() and lead to an invalid value for high_memory.
> 
> Second, arch_zone_lowest_possible_pfn[ZONE_HIGHMEM] is the _start_ of
> highmem. This is not what arch code sets high_memory to - because
> the start of highmem may not contiguously follow on from lowmem.
> 
> In arch/arm/mm/mmu.c, lowmem_limit is computed to be the highest + 1
> physical address that lowmem can possibly be, taking into account the
> amount of vmalloc memory that is required. This is used to set
> high_memory.
> 
> We also limit the amount of usable RAM via memblock_set_current_limit()
> which memblock_end_of_DRAM() doesn't respect.
> 
> I don't think the proposed generic version is suitable for 32-bit arm.

Unless I'm missing something, both memblock.current_limit and start of
ZONE_HIGHMEM are set to arm_lowmem_limit which will be different from
memblock_end_of_DRAM() only for machines with more than nearly 4GiB of RAM
and those will supposedly use HIGHMEM anyway.

But this does not matter anyway because failures Mark reported happen
because 32-bit arm uses high_memory before mem_init() and that what causes
the hangs. 

Here's the fix I have, I'll send v2 shortly.

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e492d58a0386..f02f872ea8a9 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1250,6 +1250,8 @@ void __init adjust_lowmem_bounds(void)
 
 	arm_lowmem_limit = lowmem_limit;
 
+	high_memory = __va(arm_lowmem_limit - 1) + 1;
+
 	if (!memblock_limit)
 		memblock_limit = arm_lowmem_limit;
 
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 65903ed5e80d..1a8f6914ee59 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -146,6 +146,7 @@ void __init adjust_lowmem_bounds(void)
 	phys_addr_t end;
 	adjust_lowmem_bounds_mpu();
 	end = memblock_end_of_DRAM();
+	high_memory = __va(end - 1) + 1;
 	memblock_set_current_limit(end);
 }
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 545e11f1a3ba..0aef4bef93c4 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1765,14 +1765,20 @@ static bool arch_has_descending_max_zone_pfns(void)
 
 static void set_high_memory(void)
 {
+	unsigned long pfn = arch_zone_lowest_possible_pfn[ZONE_HIGHMEM];
 	phys_addr_t highmem = memblock_end_of_DRAM();
 
-#ifdef CONFIG_HIGHMEM
-	unsigned long pfn = arch_zone_lowest_possible_pfn[ZONE_HIGHMEM];
+	/*
+	 * Some architectures (e.g. ARM) set high_memory very early and
+	 * use it in arch setup code.
+	 * If an architecture already set high_memory don't overwrite it
+	 */
+	if (high_memory)
+		return;
 
-	if (arch_has_descending_max_zone_pfns() || highmem > PFN_PHYS(pfn))
+	if (IS_ENABLED(CONFIG_HIGHMEM) &&
+	    (arch_has_descending_max_zone_pfns() || highmem > PFN_PHYS(pfn)))
 		highmem = PFN_PHYS(pfn);
-#endif
 
 	high_memory = phys_to_virt(highmem - 1) + 1;
 }

-- 
Sincerely yours,
Mike.


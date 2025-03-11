Return-Path: <linux-arch+bounces-10674-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAE5A5D225
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 23:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B250D175460
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4461E3DF9;
	Tue, 11 Mar 2025 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F1O49Jcd"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25301E32D9;
	Tue, 11 Mar 2025 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730422; cv=none; b=YGFN/VcnJXW6o+0Bc3qpIxq4k/PlTOCOlE5WqKUvMvYLHu79regCIoOs7rOia47iBA0T5nVnNY3TNs6wLkyD392A+K1KZaPiddjz7ClOoJE5oFao4NuQDCipbuljCcnTRbsR4xY1cKblUpAOJukp7CZ5rHwFljZgTCCMo1u4w6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730422; c=relaxed/simple;
	bh=KW9q+EPECptB7iseFxr1KMbGaCZk6HumkEumo9/sS7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlAiOC8oFCqjCfhwiyGLFohoioPFLGr9tsXG0YHi81evUmWe3VAVO8xWd9arSCCXtN6ekuVwkMBajoh2Dagm9gquAKV5nKBm9RKCPabC6ULrYncB8ZPDWDnEmwAs1SCbi8wzHyXoxl/H+QtaOkEO3nq/J8L98JQybkBv3ez/9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F1O49Jcd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LWqJoM88kHGjOcIG7y4jtQUycMU0Xkkz6/jQHA0YJWI=; b=F1O49JcdrryD+c7bjEti6SJD0k
	5m7yB4f0mnO5oz3PWpTGFZeEDOz6jtfbEDUSGHdJuMJUdyyJrvc8w+axXtk6TDmTIIbFbkuO1ydxZ
	ZkUVQwkCQYx3t/GvJXd0N89ERqlBZ1oyV/qsqt5n8bhxYILHdPBMEdtZh+E3rV1O6LTEgz6NY19dX
	uMkm10gBWDJvLQbGsJ+OV21R+sYmoK2kOuMEJxHVPH/5fNpWBs+wMK5IxvFr7yXp1/8ISm8hB2ZeX
	FrHvjmC4OQ8J8YC0afIQJre6b+7hqinDLiAbLbux5CbnHbe0gdh4CpCr9WT+96+4aXVFDLO7rTs/o
	DeeyVT7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55314)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ts7dT-0004fB-2A;
	Tue, 11 Mar 2025 21:59:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ts7dN-0003qv-0O;
	Tue, 11 Mar 2025 21:59:33 +0000
Date: Tue, 11 Mar 2025 21:59:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
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
Message-ID: <Z9CyRHewqfZlmgIo@shell.armlinux.org.uk>
References: <20250306185124.3147510-1-rppt@kernel.org>
 <20250306185124.3147510-11-rppt@kernel.org>
 <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 11, 2025 at 05:51:06PM +0000, Mark Brown wrote:
> On Thu, Mar 06, 2025 at 08:51:20PM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > high_memory defines upper bound on the directly mapped memory.
> > This bound is defined by the beginning of ZONE_HIGHMEM when a system has
> > high memory and by the end of memory otherwise.
> > 
> > All this is known to generic memory management initialization code that
> > can set high_memory while initializing core mm structures.
> > 
> > Remove per-architecture calculation of high_memory and add a generic
> > version to free_area_init().
> 
> This patch appears to be causing breakage on a number of 32 bit arm
> platforms, including qemu's virt-2.11,gic-version=3.  Affected platforms
> die on boot with no output, a bisect with qemu points at this commit and
> those for physical platforms appear to be converging on the same place.

I'm not convinced that the old and the new code is doing the same
thing.

The new code:

+       phys_addr_t highmem = memblock_end_of_DRAM();
+
+#ifdef CONFIG_HIGHMEM
+       unsigned long pfn = arch_zone_lowest_possible_pfn[ZONE_HIGHMEM];
+
+       if (arch_has_descending_max_zone_pfns() || highmem > PFN_PHYS(pfn))
+               highmem = PFN_PHYS(pfn);
+#endif
+
+       high_memory = phys_to_virt(highmem - 1) + 1;

First, when CONFIG_HIGHMEM is disabled, this code assumes that the last
byte of DRAM declared to memblock is the highmem limit. This _could_
overflow phys_to_virt() and lead to an invalid value for high_memory.

Second, arch_zone_lowest_possible_pfn[ZONE_HIGHMEM] is the _start_ of
highmem. This is not what arch code sets high_memory to - because
the start of highmem may not contiguously follow on from lowmem.

In arch/arm/mm/mmu.c, lowmem_limit is computed to be the highest + 1
physical address that lowmem can possibly be, taking into account the
amount of vmalloc memory that is required. This is used to set
high_memory.

We also limit the amount of usable RAM via memblock_set_current_limit()
which memblock_end_of_DRAM() doesn't respect.

I don't think the proposed generic version is suitable for 32-bit arm.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


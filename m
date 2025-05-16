Return-Path: <linux-arch+bounces-11976-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E34AB9FD3
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 17:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2374A16C9FD
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148251AF0C1;
	Fri, 16 May 2025 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="FeIM8Z8K"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A161526AF3;
	Fri, 16 May 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409309; cv=none; b=u4uxtwKI6oITiwih+wVp1a9yyuNcbV2zgExs6wWo6RiGouBlGqGocGOrlmuFx8Qxmu07BWXa1WCma20NbdDrfJCa9PHik9eQf+v7HG6mltIzwMS64fqc4wjdJUAxfefGtKZm/HdWg0HD1nEDpPn7diKYG+vY0gQim5n1cUjBgeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409309; c=relaxed/simple;
	bh=KS18mCmBwG/oVexqoftqFNnI2Pv+d2v1jXLpreeKDCY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ih/86XbS3vXjD6IVim48diR750ka/SbiPF/gIIcF/kZpkUob0vAXiQG4oLfJEI2PbhC/8Olz3ALt8fR6/aPgWuH+us4+uv7dEF6RvtD6Q/Pjy9N94ae+L5cZ/8woH2Ob2B7YKocCpy2K+GsU9rtBy/7hQGWvb19i6ycriiLalko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=FeIM8Z8K; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1747409306; x=1778945306;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/YGeJfXKIquYSt90tYMJ+el7wnECiC9xpMwa6JMR6os=;
  b=FeIM8Z8KuDAPcndq66uQEdPjn33Y0ubbuJDxci9SWbN/isGE9HAWsRPl
   YrgLTNX69DPbSddR+GOFTQT+H3sjcjy+1C3chTy+rFEHZsQltlbepszi9
   hSvuzQVkT3Es9RKKeoKLDy39yU5Chrqll5eflmae1RQRHQu5yZ5uy9juK
   c1VarOclAca951HhniU0ltYeL1SV9U5aedUJ9Phihk5uFU/FD3rmlu0Hf
   8fkxRXUGREVku0pmmr32GDaxxWAgs9zSm6ZcH/DuAi6l7xkvgTxgMpqgY
   VVy099TelrAdRRCY5BfSoBYumBYDhUtqcdCfCGMdalVk4Fk/vrCuNR3UO
   g==;
X-IronPort-AV: E=Sophos;i="6.15,294,1739836800"; 
   d="scan'208";a="201345194"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 15:28:22 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:47743]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.20:2525] with esmtp (Farcaster)
 id 1137334b-40d1-491e-811e-d1ae65cd81a3; Fri, 16 May 2025 15:28:22 +0000 (UTC)
X-Farcaster-Flow-ID: 1137334b-40d1-491e-811e-d1ae65cd81a3
Received: from EX19EXOUWA001.ant.amazon.com (10.250.64.209) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 15:28:20 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19EXOUWA001.ant.amazon.com (10.250.64.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 15:28:18 +0000
Received: from email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 15:28:18 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com (Postfix) with ESMTP id 00E5840281;
	Fri, 16 May 2025 15:28:18 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 89B166204; Fri, 16 May 2025 17:28:17 +0200 (CEST)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Mike Rapoport <rppt@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, "Andy
 Lutomirski" <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain
	<bcain@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, "Dinh
 Nguyen" <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, "Huacai
 Chen" <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jiaxun Yang
	<jiaxun.yang@flygoat.com>, Johannes Berg <johannes@sipsolutions.net>, "John
 Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>, Matt Turner
	<mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt
	<palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, "Richard
 Weinberger" <richard@nod.at>, Russell King <linux@armlinux.org.uk>, "Stafford
 Horne" <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, "Praveen
 Kumar" <pravkmr@amazon.de>, <linux-alpha@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-snps-arc@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-csky@vger.kernel.org>,
	<linux-hexagon@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-m68k@lists.linux-m68k.org>, <linux-mips@vger.kernel.org>,
	<linux-openrisc@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-um@lists.infradead.org>,
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH v2 10/13] arch, mm: set high_memory in free_area_init()
In-Reply-To: <20250313135003.836600-11-rppt@kernel.org>
References: <20250313135003.836600-1-rppt@kernel.org>
	<20250313135003.836600-11-rppt@kernel.org>
Date: Fri, 16 May 2025 17:28:17 +0200
Message-ID: <mafs05xi0o9ri.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mike, Andrew,

On Thu, Mar 13 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> high_memory defines upper bound on the directly mapped memory.
> This bound is defined by the beginning of ZONE_HIGHMEM when a system has
> high memory and by the end of memory otherwise.
>
> All this is known to generic memory management initialization code that
> can set high_memory while initializing core mm structures.
>
> Add a generic calculation of high_memory to free_area_init() and remove
> per-architecture calculation except for the architectures that set and
> use high_memory earlier than that.
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>	# x86
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/alpha/mm/init.c         |  1 -
>  arch/arc/mm/init.c           |  2 --
>  arch/arm64/mm/init.c         |  2 --
>  arch/csky/mm/init.c          |  1 -
>  arch/hexagon/mm/init.c       |  6 ------
>  arch/loongarch/kernel/numa.c |  1 -
>  arch/loongarch/mm/init.c     |  2 --
>  arch/microblaze/mm/init.c    |  2 --
>  arch/mips/mm/init.c          |  2 --
>  arch/nios2/mm/init.c         |  6 ------
>  arch/openrisc/mm/init.c      |  2 --
>  arch/parisc/mm/init.c        |  1 -
>  arch/riscv/mm/init.c         |  1 -
>  arch/s390/mm/init.c          |  2 --
>  arch/sh/mm/init.c            |  7 -------
>  arch/sparc/mm/init_32.c      |  1 -
>  arch/sparc/mm/init_64.c      |  2 --
>  arch/um/kernel/um_arch.c     |  1 -
>  arch/x86/kernel/setup.c      |  2 --
>  arch/x86/mm/init_32.c        |  3 ---
>  arch/x86/mm/numa_32.c        |  3 ---
>  arch/xtensa/mm/init.c        |  2 --
>  mm/memory.c                  |  8 --------
>  mm/mm_init.c                 | 30 ++++++++++++++++++++++++++++++
>  mm/nommu.c                   |  2 --
>  25 files changed, 30 insertions(+), 62 deletions(-)

This patch causes a BUG() when built with CONFIG_DEBUG_VIRTUAL and
passing in the cma= commandline parameter:

    ------------[ cut here ]------------
    kernel BUG at arch/x86/mm/physaddr.c:23!
    ception 0x06 IP 10:ffffffff812ebbf8 error 0 cr2 0xffff88903ffff000
    CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc6+ #231 PREEMPT(undef)
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
    RIP: 0010:__phys_addr+0x58/0x60
    Code: 01 48 89 c2 48 d3 ea 48 85 d2 75 05 e9 91 52 cf 00 0f 0b 48 3d ff ff ff 1f 77 0f 48 8b 05 20 54 55 01 48 01 d0 e9 78 52 cf 00 <0f> 0b 90 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
    RSP: 0000:ffffffff82803dd8 EFLAGS: 00010006 ORIG_RAX: 0000000000000000
    RAX: 000000007fffffff RBX: 00000000ffffffff RCX: 0000000000000000
    RDX: 000000007fffffff RSI: 0000000280000000 RDI: ffffffffffffffff
    RBP: ffffffff82803e68 R08: 0000000000000000 R09: 0000000000000000
    R10: ffffffff83153180 R11: ffffffff82803e48 R12: ffffffff83c9aed0
    R13: 0000000000000000 R14: 0000001040000000 R15: 0000000000000000
    FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffff88903ffff000 CR3: 0000000002838000 CR4: 00000000000000b0
    Call Trace:
     <TASK>
     ? __cma_declare_contiguous_nid+0x6e/0x340
     ? cma_declare_contiguous_nid+0x33/0x70
     ? dma_contiguous_reserve_area+0x2f/0x70
     ? setup_arch+0x6f1/0x870
     ? start_kernel+0x52/0x4b0
     ? x86_64_start_reservations+0x29/0x30
     ? x86_64_start_kernel+0x7c/0x80
     ? common_startup_64+0x13e/0x141

The reason is that __cma_declare_contiguous_nid() does:

    	highmem_start = __pa(high_memory - 1) + 1;

If dma_contiguous_reserve_area() (or any other CMA declaration) is
called before free_area_init(), high_memory is uninitialized. Without
CONFIG_DEBUG_VIRTUAL, it will likely work but use the wrong value for
highmem_start.

Among the architectures this patch touches, the below call
dma_contiguous_reserve_area() _before_ free_area_init():

- x86
- s390
- mips
- riscv
- xtensa
- loongarch
- csky

The below call it _after_ free_area_init():
- arm64

And the below don't call it at all:
- sparc
- nios2
- openrisc
- hexagon
- sh
- um
- alpha

One possible fix would be to move the calls to
dma_contiguous_reserve_area() after free_area_init(). On x86, it would
look like the diff below. The obvious downside is that moving the call
later increases the chances of allocation failure. I'm not sure how much
that actually matters, but at least on x86, that means crash kernel and
hugetlb reservations go before DMA reservation. Also, adding a patch
like that at rc7 is a bit risky.

The other option would be to revert this. I tried a revert, but it isn't
trivial. It runs into merge conflicts in pretty much all of the arch
files. Maybe reverting patches 11, 12, and 13 as well would make it
easier but I didn't try that.

Which option should we take? If we want to move
dma_contiguous_reserve_area() a bit further down the line then I can
send a patch doing that on the rest of the architectures. Otherwise I
can try my hand at the revert.

--- 8< ---
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 9d2a13b37833..ca6928dde0c9 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1160,7 +1160,6 @@ void __init setup_arch(char **cmdline_p)
 	x86_flattree_get_config();
 
 	initmem_init();
-	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
 	if (boot_cpu_has(X86_FEATURE_GBPAGES)) {
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
@@ -1178,6 +1177,8 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_init.paging.pagetable_init();
 
+	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
+
 	kasan_init();
 
 	/*

-- 
Regards,
Pratyush Yadav



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597



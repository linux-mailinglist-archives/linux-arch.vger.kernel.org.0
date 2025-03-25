Return-Path: <linux-arch+bounces-11064-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2EAA6F78F
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 12:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAAE3B9A0A
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 11:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91CD1EE7BB;
	Tue, 25 Mar 2025 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOf08xfD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB2E1E7C28;
	Tue, 25 Mar 2025 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903382; cv=none; b=XWzFQWcSC+4ZXTrm44Nw8zkncQ6RSkxsmHt6iGzsMkZm3XO2aRvh0Ir2tt165D6seTPH4TREY1U8gZtyIhJGG6bRKW/dLAxZpPFuP2ERvKxaE+HHYlo0KuK5d2OKNgsOUNqu7TUSkCbPgKyzEyt5ZTMjMttW0IxN/gr23hHDUcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903382; c=relaxed/simple;
	bh=qfpWtkjNYrQGK3RsZjqYJLcEX3OyIabqO13P6PMbc7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGPnq3xPTkcNchBySiduLbMeC/XjbTeGe63OKXU1VmqDC0Lmu0/uWadwegbiSphd4QaaUgis4z85jlQtAr+cz+gcMo2xXWTgd69FQBdfzTVmJKSLDguXYuTxUrweFDi8+wP3RktA0U4HSo6x6x7g9OLBNMrrHxoPoLDpvXrSnIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOf08xfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8A3C4CEED;
	Tue, 25 Mar 2025 11:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742903382;
	bh=qfpWtkjNYrQGK3RsZjqYJLcEX3OyIabqO13P6PMbc7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOf08xfDf7JzudFmXaZx8QWeA/W+a8SOYgOsPFECAhIF+Kz9dt9TuQGFBcqSCdotd
	 IoKuOSro0BZO0ID5go5sb8p8Nqjq5q6RSs4zpHIZJGG749PgL/qovWE0z5vhmBN+3W
	 xhnUdNxCS7lSedIoO74EMJr9uNwWYu2iWpY9Ig3jRJ+YsMpgr/sEyhQSzo1VfS6ifV
	 54eD0LCdZYzKjgwkc3SwEvUifbEI8XH30cPaEupxQWQcdbFC5ESOCtORKNBk7rxm/T
	 ogXNTDcmu2zBx51ubw91Gf0jjFjiwRXAN/KkeCajqMAzJfm/kVY3bQWO0HXMljOGoS
	 ylQE4zurVIhIA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	kernel test robot <oliver.sang@intel.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH 1/2] mm/mm_init: init holes in the end of the memory map for FLATMEM
Date: Tue, 25 Mar 2025 13:49:27 +0200
Message-ID: <20250325114928.1791109-2-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250325114928.1791109-1-rppt@kernel.org>
References: <20250325114928.1791109-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Kernel test robot reports the following crash on 32-bit system with
FLATMEM and DEBUG_VM_PGFLAGS enabled:

[    0.478822][    T0] kernel BUG at include/linux/page-flags.h:536!
[    0.479312][    T0] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
[    0.479768][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc6-00357-g8268af309d07 #1
[    0.480470][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.481260][ T0] EIP: reserve_bootmem_region (include/linux/page-flags.h:536)
[ 0.481683][ T0] Code: 5d c3 01 f1 89 c8 ba e1 38 f4 c3 e8 1e 37 8e fc 0f 0b b8 90 e2 62 c4 e8 e2 05 5e fc 01 f1 89 c8 ba be 85 f7 c3 e8 04 37 8e fc <0f> 0b b8 80 e2 62 c4 e8 c8 05 5e fc 55 89 e5 53 57 56 83 ec 10 89
[    0.483177][    T0] EAX: 00000000 EBX: c425df50 ECX: 00000000 EDX: 00000000
[    0.483712][    T0] ESI: 017ffc00 EDI: ffffffff EBP: c425df34 ESP: c425df2c
[    0.484248][    T0] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210046
[    0.484846][    T0] CR0: 80050033 CR2: 00000000 CR3: 04b48000 CR4: 00000090
[    0.485376][    T0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.485907][    T0] DR6: fffe0ff0 DR7: 00000400
[    0.486253][    T0] Call Trace:
[ 0.486494][ T0] ? __die_body (arch/x86/kernel/dumpstack.c:478)
[ 0.486822][ T0] ? die (arch/x86/kernel/dumpstack.c:?)
[ 0.487099][ T0] ? do_trap (arch/x86/kernel/traps.c:? arch/x86/kernel/traps.c:197)
[ 0.487409][ T0] ? do_error_trap (arch/x86/kernel/traps.c:217)
[ 0.487752][ T0] ? reserve_bootmem_region (include/linux/page-flags.h:536)
[ 0.488153][ T0] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 0.488490][ T0] ? handle_invalid_op (arch/x86/kernel/traps.c:254)
[ 0.488869][ T0] ? reserve_bootmem_region (include/linux/page-flags.h:536)
[ 0.489271][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:316)
[ 0.489619][ T0] ? handle_exception (arch/x86/entry/entry_32.S:1055)
[ 0.489996][ T0] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 0.490332][ T0] ? reserve_bootmem_region (include/linux/page-flags.h:536)
[ 0.490733][ T0] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 0.491068][ T0] ? reserve_bootmem_region (include/linux/page-flags.h:536)
[ 0.491470][ T0] memmap_init_reserved_pages (mm/memblock.c:2203)
[ 0.491887][ T0] free_low_memory_core_early (mm/memblock.c:?)
[ 0.492302][ T0] memblock_free_all (mm/memblock.c:2272 include/linux/atomic/atomic-arch-fallback.h:546 include/linux/atomic/atomic-long.h:123 include/linux/atomic/atomic-instrumented.h:3261 include/linux/mm.h:67 mm/memblock.c:2273)
[ 0.492659][ T0] mem_init (arch/x86/mm/init_32.c:735)
[ 0.492952][ T0] mm_core_init (mm/mm_init.c:2730)
[ 0.493271][ T0] start_kernel (init/main.c:958)
[ 0.493604][ T0] i386_start_kernel (arch/x86/kernel/head32.c:79)
[ 0.493969][ T0] startup_32_smp (arch/x86/kernel/head_32.S:292)

The crash happens because after commit 8268af309d07 ("arch, mm: set
max_mapnr when allocating memory map for FLATMEM") max_mapnr is rounded up
to MAX_ORDER_NR_PAGES and the pages in the end of the memory map are
passing pfn_valid() check in reserve_bootmem_region().

Make sure that that pages in the end of the memory map are initialized,
just like the pages in the end of the last section for SPARSEMEM.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503241424.d16223ec-lkp@intel.com
Fixes: 8268af309d07 ("arch, mm: set max_mapnr when allocating memory map for FLATMEM")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/mm_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index a38a1909b407..84f14fa12d0d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -984,19 +984,19 @@ static void __init memmap_init(void)
 		}
 	}
 
-#ifdef CONFIG_SPARSEMEM
 	/*
 	 * Initialize the memory map for hole in the range [memory_end,
-	 * section_end].
+	 * section_end] for SPARSEMEM and in the range [memory_end, memmap_end]
+	 * for FLATMEM.
 	 * Append the pages in this hole to the highest zone in the last
 	 * node.
-	 * The call to init_unavailable_range() is outside the ifdef to
-	 * silence the compiler warining about zone_id set but not used;
-	 * for FLATMEM it is a nop anyway
 	 */
+#ifdef CONFIG_SPARSEMEM
 	end_pfn = round_up(end_pfn, PAGES_PER_SECTION);
-	if (hole_pfn < end_pfn)
+#else
+	end_pfn = round_up(end_pfn, MAX_ORDER_NR_PAGES);
 #endif
+	if (hole_pfn < end_pfn)
 		init_unavailable_range(hole_pfn, end_pfn, zone_id, nid);
 }
 
-- 
2.47.2



Return-Path: <linux-arch+bounces-8472-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611909AD080
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1667128429A
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC281CC165;
	Wed, 23 Oct 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyRbmLCU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C81C9B71;
	Wed, 23 Oct 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700856; cv=none; b=Wb7Y8UNIIGVWekmVyMxUikp/ZBLfyj5C953ufKrijqKCqyND2GT+hvnilcFbRuIYj8++1XblR/r2gWTi3B0r3hUf5nGEaf1HQu9PYoEHV/SNNWGpQzvIY73Bb2l8cnbs1W1WPewXVkm9es6l+T9wL5IzaKyzyGRf3kJpBcO03mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700856; c=relaxed/simple;
	bh=CAUHbpciOyKyDsHwZh+qoyCOqycSY3L+pQS4jF5xUzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i8gEAvS6nDUS4Au40KnQZ9ZhLdMv6lStF8QMQfFCbKHA2I1FkVXH6OVU2PF4D2rAUj6Lr78KvX1cgvuWvbaIClWKgMPBN0/bfUga8eMoRNP4ZTWsh01DcQFBdSttT4M3boY+B/9Id0UP8zH4+ydI0QRwGQHnLC431qy0ZIlCK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyRbmLCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F44EC4CEC6;
	Wed, 23 Oct 2024 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729700856;
	bh=CAUHbpciOyKyDsHwZh+qoyCOqycSY3L+pQS4jF5xUzU=;
	h=From:To:Cc:Subject:Date:From;
	b=GyRbmLCUG9JQB3z6KOucL0zaqdZJ/z+C+hR9jVOBdBVOVN/cw4qzM9u3MGS35Y8YD
	 dnM3cuw69OA44h4UALWLfrAtvfPlmhK05b940iXW5N7BM1bWTs+pwp1SUfgaq9q44a
	 2cm/u+eFE//qMgYmTjg8EyRhmgFa/JqhE6H1exzvXMS7vaPYCnHTI2amWa4VfUpKst
	 IbDgtUU+y/WOcER10iuY4ta05P2VPLnzJhhKcicOcNlAueU033Ls3BTyu8sqvTM9pa
	 nvsX9jSxLzIxdsSSviOh0QFGpx0rw93qMfgT2GTbnxqoAs6gxUiU5I23CuQ540ki4r
	 tF94t/qKGqNcg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v7 0/8] x86/module: use large ROX pages for text allocations
Date: Wed, 23 Oct 2024 19:27:03 +0300
Message-ID: <20241023162711.2579610-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

This is an updated version of execmem ROX caches.

v6: https://lore.kernel.org/all/20241016122424.1655560-1-rppt@kernel.org
* Fixed handling of alternatives for fineibt (kbuild bot)
* Restored usage of text_poke_early for ftrace boot time initialization (Steve)
* Made !module path in module_writable_address inline

v5: https://lore.kernel.org/all/20241009180816.83591-1-rppt@kernel.org 
* Droped check for !area in mas_for_each() loop (Kees Bakker)
* Droped externs in include/linux/vmalloc.h (Christoph)
* Fixed handling of alternatives for CFI-enabled configs (Nathan)
* Fixed interaction with kmemleak (Sergey).
  It looks like execmem and kmemleak interaction should be improved
  further, but it's out of scope of this series.
* Added ARCH_HAS_EXECMEM_ROX configuration option to arch/Kconfig. The
  option serves two purposes:
  - make sure architecture that uses ROX caches implements
    execmem_fill_trapping_insns() callback (Christoph)
  - make sure entire physical memory is mapped in the direct map (Dave) 

v4: https://lore.kernel.org/all/20241007062858.44248-1-rppt@kernel.org
* Fix copy/paste error in looongarch (Huacai)

v3: https://lore.kernel.org/all/20240909064730.3290724-1-rppt@kernel.org
* Drop ftrace_swap_func(). It is not needed because mcount array lives
  in a data section (Peter)
* Update maple_tree usage (Liam)
* Set ->fill_trapping_insns pointer on init (Ard)
* Instead of using VM_FLUSH_RESET_PERMS for execmem cache, completely
  remove it from the direct map

v2: https://lore.kernel.org/all/20240826065532.2618273-1-rppt@kernel.org
* add comment why ftrace_swap_func() is needed (Steve)

Since RFC: https://lore.kernel.org/all/20240411160526.2093408-1-rppt@kernel.org
* update changelog about HUGE_VMAP allocations (Christophe) 
* move module_writable_address() from x86 to modules core (Ingo)
* rename execmem_invalidate() to execmem_fill_trapping_insns() (Peter)
* call alternatives_smp_unlock() after module text in-place is up to
  date (Nadav)

= Original cover letter =

These patches add support for using large ROX pages for allocations of
executable memory on x86.

They address Andy's comments [1] about having executable mappings for code
that was not completely formed.

The approach taken is to allocate ROX memory along with writable but not
executable memory and use the writable copy to perform relocations and
alternatives patching. After the module text gets into its final shape, the
contents of the writable memory is copied into the actual ROX location
using text poking.

The allocations of the ROX memory use vmalloc(VMAP_ALLOW_HUGE_MAP) to
allocate PMD aligned memory, fill that memory with invalid instructions and
in the end remap it as ROX. Portions of these large pages are handed out to
execmem_alloc() callers without any changes to the permissions. When the
memory is freed with execmem_free() it is invalidated again so that it
won't contain stale instructions.

The module memory allocation, x86 code dealing with relocations and
alternatives patching take into account the existence of the two copies,
the writable memory and the ROX memory at the actual allocated virtual
address.

The patches are available at git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=execmem/x86-rox/v6

[1] https://lore.kernel.org/all/a17c65c6-863f-4026-9c6f-a04b659e9ab4@app.fastmail.com

Mike Rapoport (Microsoft) (8):
  mm: vmalloc: group declarations depending on CONFIG_MMU together
  mm: vmalloc: don't account for number of nodes for HUGE_VMAP allocations
  asm-generic: introduce text-patching.h
  module: prepare to handle ROX allocations for text
  arch: introduce set_direct_map_valid_noflush()
  x86/module: prepare module loading for ROX allocations of text
  execmem: add support for cache of large ROX pages
  x86/module: enable ROX caches for module text on 64 bit

 arch/Kconfig                                  |   8 +
 arch/alpha/include/asm/Kbuild                 |   1 +
 arch/arc/include/asm/Kbuild                   |   1 +
 .../include/asm/{patch.h => text-patching.h}  |   0
 arch/arm/kernel/ftrace.c                      |   2 +-
 arch/arm/kernel/jump_label.c                  |   2 +-
 arch/arm/kernel/kgdb.c                        |   2 +-
 arch/arm/kernel/patch.c                       |   2 +-
 arch/arm/probes/kprobes/core.c                |   2 +-
 arch/arm/probes/kprobes/opt-arm.c             |   2 +-
 arch/arm64/include/asm/set_memory.h           |   1 +
 .../asm/{patching.h => text-patching.h}       |   0
 arch/arm64/kernel/ftrace.c                    |   2 +-
 arch/arm64/kernel/jump_label.c                |   2 +-
 arch/arm64/kernel/kgdb.c                      |   2 +-
 arch/arm64/kernel/patching.c                  |   2 +-
 arch/arm64/kernel/probes/kprobes.c            |   2 +-
 arch/arm64/kernel/traps.c                     |   2 +-
 arch/arm64/mm/pageattr.c                      |  10 +
 arch/arm64/net/bpf_jit_comp.c                 |   2 +-
 arch/csky/include/asm/Kbuild                  |   1 +
 arch/hexagon/include/asm/Kbuild               |   1 +
 arch/loongarch/include/asm/Kbuild             |   1 +
 arch/loongarch/include/asm/set_memory.h       |   1 +
 arch/loongarch/mm/pageattr.c                  |  19 +
 arch/m68k/include/asm/Kbuild                  |   1 +
 arch/microblaze/include/asm/Kbuild            |   1 +
 arch/mips/include/asm/Kbuild                  |   1 +
 arch/nios2/include/asm/Kbuild                 |   1 +
 arch/openrisc/include/asm/Kbuild              |   1 +
 .../include/asm/{patch.h => text-patching.h}  |   0
 arch/parisc/kernel/ftrace.c                   |   2 +-
 arch/parisc/kernel/jump_label.c               |   2 +-
 arch/parisc/kernel/kgdb.c                     |   2 +-
 arch/parisc/kernel/kprobes.c                  |   2 +-
 arch/parisc/kernel/patch.c                    |   2 +-
 arch/powerpc/include/asm/kprobes.h            |   2 +-
 .../asm/{code-patching.h => text-patching.h}  |   0
 arch/powerpc/kernel/crash_dump.c              |   2 +-
 arch/powerpc/kernel/epapr_paravirt.c          |   2 +-
 arch/powerpc/kernel/jump_label.c              |   2 +-
 arch/powerpc/kernel/kgdb.c                    |   2 +-
 arch/powerpc/kernel/kprobes.c                 |   2 +-
 arch/powerpc/kernel/module_32.c               |   2 +-
 arch/powerpc/kernel/module_64.c               |   2 +-
 arch/powerpc/kernel/optprobes.c               |   2 +-
 arch/powerpc/kernel/process.c                 |   2 +-
 arch/powerpc/kernel/security.c                |   2 +-
 arch/powerpc/kernel/setup_32.c                |   2 +-
 arch/powerpc/kernel/setup_64.c                |   2 +-
 arch/powerpc/kernel/static_call.c             |   2 +-
 arch/powerpc/kernel/trace/ftrace.c            |   2 +-
 arch/powerpc/kernel/trace/ftrace_64_pg.c      |   2 +-
 arch/powerpc/lib/code-patching.c              |   2 +-
 arch/powerpc/lib/feature-fixups.c             |   2 +-
 arch/powerpc/lib/test-code-patching.c         |   2 +-
 arch/powerpc/lib/test_emulate_step.c          |   2 +-
 arch/powerpc/mm/book3s32/mmu.c                |   2 +-
 arch/powerpc/mm/book3s64/hash_utils.c         |   2 +-
 arch/powerpc/mm/book3s64/slb.c                |   2 +-
 arch/powerpc/mm/kasan/init_32.c               |   2 +-
 arch/powerpc/mm/mem.c                         |   2 +-
 arch/powerpc/mm/nohash/44x.c                  |   2 +-
 arch/powerpc/mm/nohash/book3e_pgtable.c       |   2 +-
 arch/powerpc/mm/nohash/tlb.c                  |   2 +-
 arch/powerpc/mm/nohash/tlb_64e.c              |   2 +-
 arch/powerpc/net/bpf_jit_comp.c               |   2 +-
 arch/powerpc/perf/8xx-pmu.c                   |   2 +-
 arch/powerpc/perf/core-book3s.c               |   2 +-
 arch/powerpc/platforms/85xx/smp.c             |   2 +-
 arch/powerpc/platforms/86xx/mpc86xx_smp.c     |   2 +-
 arch/powerpc/platforms/cell/smp.c             |   2 +-
 arch/powerpc/platforms/powermac/smp.c         |   2 +-
 arch/powerpc/platforms/powernv/idle.c         |   2 +-
 arch/powerpc/platforms/powernv/smp.c          |   2 +-
 arch/powerpc/platforms/pseries/smp.c          |   2 +-
 arch/powerpc/xmon/xmon.c                      |   2 +-
 arch/riscv/errata/andes/errata.c              |   2 +-
 arch/riscv/errata/sifive/errata.c             |   2 +-
 arch/riscv/errata/thead/errata.c              |   2 +-
 arch/riscv/include/asm/set_memory.h           |   1 +
 .../include/asm/{patch.h => text-patching.h}  |   0
 arch/riscv/include/asm/uprobes.h              |   2 +-
 arch/riscv/kernel/alternative.c               |   2 +-
 arch/riscv/kernel/cpufeature.c                |   3 +-
 arch/riscv/kernel/ftrace.c                    |   2 +-
 arch/riscv/kernel/jump_label.c                |   2 +-
 arch/riscv/kernel/patch.c                     |   2 +-
 arch/riscv/kernel/probes/kprobes.c            |   2 +-
 arch/riscv/mm/pageattr.c                      |  15 +
 arch/riscv/net/bpf_jit_comp64.c               |   2 +-
 arch/riscv/net/bpf_jit_core.c                 |   2 +-
 arch/s390/include/asm/set_memory.h            |   1 +
 arch/s390/mm/pageattr.c                       |  11 +
 arch/sh/include/asm/Kbuild                    |   1 +
 arch/sparc/include/asm/Kbuild                 |   1 +
 arch/um/kernel/um_arch.c                      |  16 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/vma.c                     |   3 +-
 arch/x86/include/asm/alternative.h            |  14 +-
 arch/x86/include/asm/set_memory.h             |   1 +
 arch/x86/include/asm/text-patching.h          |   1 +
 arch/x86/kernel/alternative.c                 | 181 ++++++----
 arch/x86/kernel/ftrace.c                      |  30 +-
 arch/x86/kernel/module.c                      |  45 ++-
 arch/x86/mm/init.c                            |  37 +-
 arch/x86/mm/pat/set_memory.c                  |   8 +
 arch/xtensa/include/asm/Kbuild                |   1 +
 include/asm-generic/text-patching.h           |   5 +
 include/linux/execmem.h                       |  37 ++
 include/linux/module.h                        |  16 +
 include/linux/moduleloader.h                  |   4 +
 include/linux/set_memory.h                    |   6 +
 include/linux/text-patching.h                 |  15 +
 include/linux/vmalloc.h                       |  60 ++--
 kernel/module/debug_kmemleak.c                |   3 +-
 kernel/module/main.c                          |  74 +++-
 kernel/module/strict_rwx.c                    |   3 +
 mm/execmem.c                                  | 336 +++++++++++++++++-
 mm/internal.h                                 |   1 +
 mm/vmalloc.c                                  |  14 +-
 121 files changed, 885 insertions(+), 247 deletions(-)
 rename arch/arm/include/asm/{patch.h => text-patching.h} (100%)
 rename arch/arm64/include/asm/{patching.h => text-patching.h} (100%)
 rename arch/parisc/include/asm/{patch.h => text-patching.h} (100%)
 rename arch/powerpc/include/asm/{code-patching.h => text-patching.h} (100%)
 rename arch/riscv/include/asm/{patch.h => text-patching.h} (100%)
 create mode 100644 include/asm-generic/text-patching.h
 create mode 100644 include/linux/text-patching.h


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.43.0



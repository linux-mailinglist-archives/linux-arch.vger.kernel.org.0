Return-Path: <linux-arch+bounces-7733-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B214992468
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 08:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC361C21FEB
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 06:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AE5145FE5;
	Mon,  7 Oct 2024 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAvpd3li"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59C140E5F;
	Mon,  7 Oct 2024 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728282563; cv=none; b=qHoo3qCajQqLJ6MFDjZrXAMk0jjtT5g5IqJcUlgMUBmarNuhY/ba4u3g7WdSZVxZ92X3yR6zoMYUC5N/751usyCfWCj+zhfUayQtr08H7E4JzewUBL5g6hWd+Q8bZlVf8k4hX07bkT0KIlE+5uqg3c+QHXdRGsNtqL/vnSUn81Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728282563; c=relaxed/simple;
	bh=GYz9jJeJwdTzMuunM08gf0B0slcAjxJN/5ca8sCoryM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSKSOTFzGVZreXKIr2jEC4Qv0hGdflchS8jFTCHNDLTCvQE+ctWoWv30NXZNBoFPmXed88iWJcxNWUzODWxcMc1PmiX6BHuuGVyiT1JE+h6Dg0Prl35S2OvA2jLVLV8CKcGRey6ybnWowehtd62EKvveQ6PAkSRwIqIC7JfbSTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAvpd3li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B94C4CEC6;
	Mon,  7 Oct 2024 06:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728282562;
	bh=GYz9jJeJwdTzMuunM08gf0B0slcAjxJN/5ca8sCoryM=;
	h=From:To:Cc:Subject:Date:From;
	b=mAvpd3li61HdTUdxFJIe7eyvRfePLEvKecXQdexCLVpbBEa8HxHGH4u3IK8jVju4x
	 ZXgoWx2/G65gU8/jWAV0QcRmBNwVxuebK3LnO7N6jsJxAiKtM3WlATwassj9ysIxRf
	 JMkkeWiqetONDupxedDcqAYSK6K+hWFncl2o2LE1/LXb6kyCjzd2wzXgw7Yk9EJGAz
	 bMWr/AwedePV7iVNtLs5+ErNIgVz90TWToU4sfjPGxTZUPTZwiKvYcEPtVhBTKYZL0
	 nHAhBcqyxEcAbP8TanB1vMyYdueNcpnycESXgCpWvBxKeH9MKkSWS4f/IP5DbcrXTz
	 xYawM/9Xr6WPA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
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
	Luis Chamberlain <mcgrof@kernel.org>,
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
Subject: [PATCH v4 0/8] x86/module: use large ROX pages for text allocations
Date: Mon,  7 Oct 2024 09:28:50 +0300
Message-ID: <20241007062858.44248-1-rppt@kernel.org>
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
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=execmem/x86-rox/v2

[1] https://lore.kernel.org/all/a17c65c6-863f-4026-9c6f-a04b659e9ab4@app.fastmail.com

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

Mike Rapoport (Microsoft) (8):
  mm: vmalloc: group declarations depending on CONFIG_MMU together
  mm: vmalloc: don't account for number of nodes for HUGE_VMAP allocations
  asm-generic: introduce text-patching.h
  module: prepare to handle ROX allocations for text
  arch: introduce set_direct_map_valid_noflush()
  x86/module: perpare module loading for ROX allocations of text
  execmem: add support for cache of large ROX pages
  x86/module: enable ROX caches for module text

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
 arch/loongarch/mm/pageattr.c                  |  21 ++
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
 arch/x86/entry/vdso/vma.c                     |   3 +-
 arch/x86/include/asm/alternative.h            |  14 +-
 arch/x86/include/asm/set_memory.h             |   1 +
 arch/x86/include/asm/text-patching.h          |   1 +
 arch/x86/kernel/alternative.c                 | 160 +++++----
 arch/x86/kernel/ftrace.c                      |  30 +-
 arch/x86/kernel/module.c                      |  45 ++-
 arch/x86/mm/init.c                            |  26 +-
 arch/x86/mm/pat/set_memory.c                  |   8 +
 arch/xtensa/include/asm/Kbuild                |   1 +
 include/asm-generic/text-patching.h           |   5 +
 include/linux/execmem.h                       |  25 ++
 include/linux/module.h                        |   9 +
 include/linux/moduleloader.h                  |   4 +
 include/linux/set_memory.h                    |   6 +
 include/linux/text-patching.h                 |  15 +
 include/linux/vmalloc.h                       |  60 ++--
 kernel/module/main.c                          |  77 +++-
 kernel/module/strict_rwx.c                    |   3 +
 mm/execmem.c                                  | 328 +++++++++++++++++-
 mm/internal.h                                 |   1 +
 mm/vmalloc.c                                  |  14 +-
 118 files changed, 831 insertions(+), 235 deletions(-)
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



Return-Path: <linux-arch+bounces-7141-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3512B970E21
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 08:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C4A1F21634
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 06:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3351ACDF5;
	Mon,  9 Sep 2024 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZTJc1yo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8A177999;
	Mon,  9 Sep 2024 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864475; cv=none; b=OSWNftjZhoEH3mAVgKqgqoUoRG8jnZ75wqpI1lbtuWSe4HVFr4kHAACFpp7jXwjGrpFLc97tR6abEPWSy/kbV0u07+doxUs8On/yS66H4eKmsDknBHEs89fLhTPs11w8uEeeqiFJjApbyhWGD21PJgdVS3uQnV1oxE5MXpfMUAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864475; c=relaxed/simple;
	bh=B9x+q6EZd7K9Ar6u2d/l/9Mk8JmglYJFdX3xwumRUgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOGr9+OdsAcyIVzvAhIbw/GJ6y/l7QDoXgX+TEriVvQ1F4JHxFfUlOz/vIoA9MyxhVSm73XttDr4fpwdgg9Y6tdnmokdaNPMlB59TDMMq9ZwCnXCRyHnTfFOJA2uq4wTWpyZZsMWX22QUDqWc5B9tsaxuchjfUNrfG2IT+JR/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZTJc1yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F127C4CEC5;
	Mon,  9 Sep 2024 06:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725864475;
	bh=B9x+q6EZd7K9Ar6u2d/l/9Mk8JmglYJFdX3xwumRUgY=;
	h=From:To:Cc:Subject:Date:From;
	b=GZTJc1yoHgAC1vrKmkrTik6bpeO/Ba3QeazSMwPEzdJE6v6r2E7ixgB1ws7HJXN1F
	 HRwEzExXYATn3fg6VyMu83WZRGIqkCuTqIpvYBgI7GMvZ2fNpZanOxVPd3ZxuoqB0K
	 kwTmCftX0HBa5qu7J42H4mXCg8BICIgqgeYhEDOMsEPSqM10sT99D9eEaHA26BQrpc
	 fWMQM7MbpHVOJx1YrHAuv2j7+cuQdZMv1YBYBeSYPLwSZAqusrJbcD9XnNmcUVYqMp
	 6acnhTwIIPKoUx5UMRy32HTx9KDEvPL+OqTadSOplha4y8PQUwonrxBocNmxw0Twq/
	 7gmEoI8OZn75Q==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
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
Subject: [PATCH v3 0/8] x86/module: use large ROX pages for text allocations
Date: Mon,  9 Sep 2024 09:47:22 +0300
Message-ID: <20240909064730.3290724-1-rppt@kernel.org>
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

v2: https://lore.kernel.org/all/20240826065532.2618273-1-rppt@kernel.org
* add comment why ftrace_swap_func() is needed (Steve)

Since RFC: https://lore.kernel.org/all/20240411160526.2093408-1-rppt@kernel.org
* update changelog about HUGE_VMAP allocations (Christophe) 
* move module_writable_address() from x86 to modules core (Ingo)
* rename execmem_invalidate() to execmem_fill_trapping_insns() (Peter)
* call alternatives_smp_unlock() after module text in-place is up to
  date (Nadav)

Mike Rapoport (Microsoft) (7):
  mm: vmalloc: group declarations depending on CONFIG_MMU together
  mm: vmalloc: don't account for number of nodes for HUGE_VMAP allocations
  asm-generic: introduce text-patching.h
  module: prepare to handle ROX allocations for text
  x86/module: perpare module loading for ROX allocations of text
  execmem: add support for cache of large ROX pages
  x86/module: enable ROX caches for module text

Song Liu (1):
  ftrace: Add swap_func to ftrace_process_locs()

 arch/alpha/include/asm/Kbuild                 |   1 +
 arch/arc/include/asm/Kbuild                   |   1 +
 .../include/asm/{patch.h => text-patching.h}  |   0
 arch/arm/kernel/ftrace.c                      |   2 +-
 arch/arm/kernel/jump_label.c                  |   2 +-
 arch/arm/kernel/kgdb.c                        |   2 +-
 arch/arm/kernel/patch.c                       |   2 +-
 arch/arm/probes/kprobes/core.c                |   2 +-
 arch/arm/probes/kprobes/opt-arm.c             |   2 +-
 .../asm/{patching.h => text-patching.h}       |   0
 arch/arm64/kernel/ftrace.c                    |   2 +-
 arch/arm64/kernel/jump_label.c                |   2 +-
 arch/arm64/kernel/kgdb.c                      |   2 +-
 arch/arm64/kernel/patching.c                  |   2 +-
 arch/arm64/kernel/probes/kprobes.c            |   2 +-
 arch/arm64/kernel/traps.c                     |   2 +-
 arch/arm64/net/bpf_jit_comp.c                 |   2 +-
 arch/csky/include/asm/Kbuild                  |   1 +
 arch/hexagon/include/asm/Kbuild               |   1 +
 arch/loongarch/include/asm/Kbuild             |   1 +
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
 .../include/asm/{patch.h => text-patching.h}  |   0
 arch/riscv/include/asm/uprobes.h              |   2 +-
 arch/riscv/kernel/alternative.c               |   2 +-
 arch/riscv/kernel/cpufeature.c                |   3 +-
 arch/riscv/kernel/ftrace.c                    |   2 +-
 arch/riscv/kernel/jump_label.c                |   2 +-
 arch/riscv/kernel/patch.c                     |   2 +-
 arch/riscv/kernel/probes/kprobes.c            |   2 +-
 arch/riscv/net/bpf_jit_comp64.c               |   2 +-
 arch/riscv/net/bpf_jit_core.c                 |   2 +-
 arch/sh/include/asm/Kbuild                    |   1 +
 arch/sparc/include/asm/Kbuild                 |   1 +
 arch/um/kernel/um_arch.c                      |  16 +-
 arch/x86/entry/vdso/vma.c                     |   3 +-
 arch/x86/include/asm/alternative.h            |  14 +-
 arch/x86/include/asm/text-patching.h          |   1 +
 arch/x86/kernel/alternative.c                 | 160 ++++++----
 arch/x86/kernel/ftrace.c                      |  41 ++-
 arch/x86/kernel/module.c                      |  45 ++-
 arch/x86/mm/init.c                            |  26 +-
 arch/xtensa/include/asm/Kbuild                |   1 +
 include/asm-generic/text-patching.h           |   5 +
 include/linux/execmem.h                       |  25 ++
 include/linux/ftrace.h                        |   2 +
 include/linux/module.h                        |   9 +
 include/linux/moduleloader.h                  |   4 +
 include/linux/text-patching.h                 |  15 +
 include/linux/vmalloc.h                       |  60 ++--
 kernel/module/main.c                          |  77 ++++-
 kernel/module/strict_rwx.c                    |   3 +
 kernel/trace/ftrace.c                         |  19 +-
 mm/execmem.c                                  | 300 +++++++++++++++++-
 mm/vmalloc.c                                  |   9 +-
 108 files changed, 752 insertions(+), 236 deletions(-)
 rename arch/arm/include/asm/{patch.h => text-patching.h} (100%)
 rename arch/arm64/include/asm/{patching.h => text-patching.h} (100%)
 rename arch/parisc/include/asm/{patch.h => text-patching.h} (100%)
 rename arch/powerpc/include/asm/{code-patching.h => text-patching.h} (100%)
 rename arch/riscv/include/asm/{patch.h => text-patching.h} (100%)
 create mode 100644 include/asm-generic/text-patching.h
 create mode 100644 include/linux/text-patching.h


base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.43.0



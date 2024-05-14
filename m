Return-Path: <linux-arch+bounces-4391-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8C78C4DA2
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 10:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE3D2827BA
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 08:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FBB18E20;
	Tue, 14 May 2024 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vv991aFK"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417AD17BD2;
	Tue, 14 May 2024 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715674959; cv=none; b=TKVKofs61X6D2WlbnKKo8KquqrDqjOg+IY1w7V4tzQT8XZcs7WWe/a8rFakOA6x7M+10U24Ngs8pfGXvJyvrcAc6ywdE7R0OFgsrLbMtNi4Lt1W+05wdF6f5qmzH2zAbC+3Ev0v83zjeDAKmA2mwxK1MGOL4XP03O38VbeQNVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715674959; c=relaxed/simple;
	bh=pp1cHNisj+tKz9XnjQgXLHVPUh8pqcGAdMvNqdaZNQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BKQ7YuHtsZkDPPOQgT4fFeOMJ9bD818R7hoCDmDzosT0SAwGMrcEaDoszbfOaAvsL9PPUb9jCliNpP3R6X8mU4VEnjKVygnO/RGYfY2Cuxl1zdLBZ7oNxnPga/w+fYU6uODYmDeTP/9ecmguC021u4wCPoXTWvfBVI+G0mmn3nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vv991aFK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=i2r1tYPEIFq5ICtSDsTyOodWu9HoIuruvn+TZUTQ0y8=; b=Vv991aFKT1XN/drhhQgMf2jEtZ
	v068ortgpU6RLM/jvJZXbhNziqOEckfDgR1S23T1VX2gDkEPDKOOtfW7fMpNoziJeNxKuhZ+9NQ6g
	offVVLb04CTmfWs0HLStyA2EIkLsYD1eR2tesQdOLJCHuGytm7ahMhIgdxIbUf8oFIUR6qmSjn08d
	xEv3OX9Mm3QQMq1mH3Fce6811Py/bG/h3ikPzyEEfKLNQPJXeR76u6aaI+NxU2U82Sj3JRuLF8lBo
	wXcxJaZIEGi+PCXJDHPjtzC1rH2SyOfmrMctQuPMVr0yJ72j3h1mTC6fIH6nXLDIgJ0jD51uW8D9n
	C/HEtH4A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6nQh-0000000FLBc-2A8j;
	Tue, 14 May 2024 08:22:35 +0000
Date: Tue, 14 May 2024 01:22:35 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-modules@vger.kernel.org, mcgrof@kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, rppt@kernel.org, song@kernel.org,
	tglx@linutronix.de, bjorn@kernel.org, mhiramat@kernel.org,
	rostedt@goodmis.org, philmd@linaro.org, will@kernel.org,
	sam@ravnborg.org, alexghiti@rivosinc.com, liviu@dudau.co.uk,
	justinstitt@google.com, elsk@google.com
Subject: [GIT PULL] Modules changes for v6.10-rc1
Message-ID: <ZkMfS727s_1MQWzQ@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>

The following changes since commit a5131c3fdf2608f1c15f3809e201cf540eb28489:

  Merge tag 'x86-shstk-2024-05-13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2024-05-13 19:33:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.10-rc1

for you to fetch changes up to 2c9e5d4a008293407836d29d35dfd4353615bd2f:

  bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of (2024-05-14 00:36:29 -0700)

----------------------------------------------------------------
Modules changes for v6.10-rc1

Finally something fun. Mike Rapoport does some cleanup to allow us to
take out module_alloc() out of modules into a new paint shedded execmem_alloc()
and execmem_free() so to make emphasis these helpers are actually used outside
of modules. It starts with a no-functional changes API rename / placeholders
to then allow architectures to define their requirements into a new shiny
struct execmem_info with ranges, and requirements for those ranges. Archs
now can intitialize this execmem_info as the last part of mm_core_init() if
they have to diverge from the norm. Each range is a known type clearly
articulated and spelled out in enum execmem_type.

Although a lot of this is major cleanup and prep work for future enhancements an
immediate clear gain is we get to enable KPROBES without MODULES now. That is
ultimately what motiviated to pick this work up again, now with smaller goal as
concrete stepping stone.

This has been sitting on linux-next for a little less than a month, a few issues
were found already and fixed, in particular an odd mips boot issue. Arch folks
reviewed the code too. This is ready for wider exposure and testing.

----------------------------------------------------------------
Justin Stitt (1):
      kallsyms: replace deprecated strncpy with strscpy

Mike Rapoport (IBM) (16):
      arm64: module: remove unneeded call to kasan_alloc_module_shadow()
      mips: module: rename MODULE_START to MODULES_VADDR
      nios2: define virtual address space for modules
      sparc: simplify module_alloc()
      module: make module_memory_{alloc,free} more self-contained
      mm: introduce execmem_alloc() and execmem_free()
      mm/execmem, arch: convert simple overrides of module_alloc to execmem
      mm/execmem, arch: convert remaining overrides of module_alloc to execmem
      riscv: extend execmem_params for generated code allocations
      arm64: extend execmem_info for generated code allocations
      powerpc: extend execmem_params for kprobes allocations
      arch: make execmem setup available regardless of CONFIG_MODULES
      x86/ftrace: enable dynamic ftrace without CONFIG_MODULES
      powerpc: use CONFIG_EXECMEM instead of CONFIG_MODULES where appropriate
      kprobes: remove dependency on CONFIG_MODULES
      bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of

Yifan Hong (1):
      module: allow UNUSED_KSYMS_WHITELIST to be relative against objtree.

 arch/Kconfig                         |  10 ++-
 arch/arm/kernel/module.c             |  34 ---------
 arch/arm/mm/init.c                   |  45 +++++++++++
 arch/arm64/Kconfig                   |   1 +
 arch/arm64/kernel/module.c           | 126 ------------------------------
 arch/arm64/kernel/probes/kprobes.c   |   7 --
 arch/arm64/mm/init.c                 | 140 ++++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c        |  11 ---
 arch/loongarch/kernel/module.c       |   6 --
 arch/loongarch/mm/init.c             |  21 +++++
 arch/mips/include/asm/pgtable-64.h   |   4 +-
 arch/mips/kernel/module.c            |  10 ---
 arch/mips/mm/fault.c                 |   4 +-
 arch/mips/mm/init.c                  |  23 ++++++
 arch/nios2/include/asm/pgtable.h     |   5 +-
 arch/nios2/kernel/module.c           |  20 -----
 arch/nios2/mm/init.c                 |  21 +++++
 arch/parisc/kernel/module.c          |  12 ---
 arch/parisc/mm/init.c                |  23 +++++-
 arch/powerpc/Kconfig                 |   2 +-
 arch/powerpc/include/asm/kasan.h     |   2 +-
 arch/powerpc/kernel/head_8xx.S       |   4 +-
 arch/powerpc/kernel/head_book3s_32.S |   6 +-
 arch/powerpc/kernel/kprobes.c        |  22 +-----
 arch/powerpc/kernel/module.c         |  38 ----------
 arch/powerpc/lib/code-patching.c     |   2 +-
 arch/powerpc/mm/book3s32/mmu.c       |   2 +-
 arch/powerpc/mm/mem.c                |  64 ++++++++++++++++
 arch/riscv/include/asm/pgtable.h     |   3 +
 arch/riscv/kernel/module.c           |  12 ---
 arch/riscv/kernel/probes/kprobes.c   |  10 ---
 arch/riscv/mm/init.c                 |  35 +++++++++
 arch/riscv/net/bpf_jit_core.c        |  13 ----
 arch/s390/kernel/ftrace.c            |   4 +-
 arch/s390/kernel/kprobes.c           |   4 +-
 arch/s390/kernel/module.c            |  42 +---------
 arch/s390/mm/init.c                  |  30 ++++++++
 arch/sparc/include/asm/pgtable_32.h  |   2 +
 arch/sparc/kernel/module.c           |  30 --------
 arch/sparc/mm/Makefile               |   2 +
 arch/sparc/mm/execmem.c              |  21 +++++
 arch/sparc/net/bpf_jit_comp_32.c     |   8 +-
 arch/x86/Kconfig                     |   1 +
 arch/x86/kernel/ftrace.c             |  16 +---
 arch/x86/kernel/kprobes/core.c       |   4 +-
 arch/x86/kernel/module.c             |  51 -------------
 arch/x86/mm/init.c                   |  29 +++++++
 include/linux/execmem.h              | 132 ++++++++++++++++++++++++++++++++
 include/linux/module.h               |   9 +++
 include/linux/moduleloader.h         |  15 ----
 kernel/bpf/Kconfig                   |   2 +-
 kernel/bpf/core.c                    |   6 +-
 kernel/kprobes.c                     |  63 +++++++++------
 kernel/module/Kconfig                |   3 +-
 kernel/module/kallsyms.c             |   2 +-
 kernel/module/main.c                 | 105 ++++++++++++-------------
 kernel/trace/trace_kprobe.c          |  20 ++++-
 mm/Kconfig                           |   3 +
 mm/Makefile                          |   1 +
 mm/execmem.c                         | 143 +++++++++++++++++++++++++++++++++++
 mm/mm_init.c                         |   2 +
 scripts/Makefile.modpost             |   2 +-
 62 files changed, 906 insertions(+), 584 deletions(-)
 create mode 100644 arch/sparc/mm/execmem.c
 create mode 100644 include/linux/execmem.h
 create mode 100644 mm/execmem.c


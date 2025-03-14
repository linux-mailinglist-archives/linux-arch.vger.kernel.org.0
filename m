Return-Path: <linux-arch+bounces-10758-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44585A60970
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A033AD3A1
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBB6166F06;
	Fri, 14 Mar 2025 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOQbzNNN"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01041607AA
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936247; cv=none; b=iylpO3CJGKEgpV2NMsM4fCxXqRFT0hLvDENBHUlF1G3GskJiYR2DDZwXjLjqx6T0mvkYA+pPK4UgAIXDjmt4LGyCQK6XlnugRe1zd+UYeNm+4g9qa/HxLXO2FwLdXXqHXhngjCAq1xR5j/U78kONbxkZjU8iVdefN9NbEuwQG+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936247; c=relaxed/simple;
	bh=hD6AJcqGL3gCW2kvHtprFpD67/YuqXXoH36mo12kCYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrOIfVDBlcOCiKt3xIyr3UGXBkmjEaikJS3GhjGx3mQ1kZ5pn53WQvvvvJvwP/ujPkNUOnoahzYrNSbBopI+E8ACs3bWZ4OANc0qZSPNZNnrDD7gB4pkQrlFx2KEQ0EQxH1StHoDMF8zCdpd7k2+Obr7xwGx//zdUY37SumobBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOQbzNNN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a9HlZfcpIhkq8NMXMd024Z+zzHPvDCkqbfJrf7lS7V8=;
	b=LOQbzNNNDOJavjc/IZd5GC2KxJ/ClfX/6v8E+vkqBWQo4nzzw16+4JVt+C/hYb9JUXG3zp
	ecw0OH8wL7QNAXYZ14+q7GPE+h5g4fBnWMUH4FLm4Wz2m/O0vquFFpRUztnQbw+APV77kH
	kkJRwJni8OG94zG0p8kEAXAcYabD//8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-eYj6cpkWPZOeVjrZ_gAmAA-1; Fri,
 14 Mar 2025 03:10:38 -0400
X-MC-Unique: eYj6cpkWPZOeVjrZ_gAmAA-1
X-Mimecast-MFC-AGG-ID: eYj6cpkWPZOeVjrZ_gAmAA_1741936237
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEBB7180899B;
	Fri, 14 Mar 2025 07:10:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 209E818001DE;
	Fri, 14 Mar 2025 07:10:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH 00/41] treewide: Replace __ASSEMBLY__ with __ASSEMBLER__ in header files
Date: Fri, 14 Mar 2025 08:09:31 +0100
Message-ID: <20250314071013.1575167-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The kernel Makefiles define the __ASSEMBLY__ macro to provide
a way to use headers in both, assembly and C source code.
However, all the supported versions of the GCC and Clang compilers
also define the macro __ASSEMBLER__ automatically already when compiling
assembly code, so some kernel headers are using __ASSEMBLER__ instead.
With regards to userspace code, this seems also to be constant source
of confusion, see for example these links here:

 https://lore.kernel.org/kvm/20250222014526.2302653-1-seanjc@google.com/
 https://stackoverflow.com/questions/28924355/gcc-assembler-preprocessor-not-compatible-with-standard-headers
 https://forums.raspberrypi.com/viewtopic.php?p=1652944#p1653834
 https://github.com/riscv-software-src/opensbi/issues/199

To avoid confusion in the future, it would make sense to standardize
on the macro that gets defined by the compiler, so this patch series
changes all occurances of __ASSEMBLY__ into __ASSEMBLER__ and
finally removes the -D__ASSEMBLY__ from the Makefiles.

I split the patches per architecture to ease the review, and I also
split the uapi headers from the normal ones in case we decide that
uapi needs to be treated differently from the normal headers here.

Thomas Huth (41):
  uapi: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  include: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  alpha: Replace __ASSEMBLY__ with __ASSEMBLER__ in the alpha headers
  arc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  arc: Replace __ASSEMBLY__ with __ASSEMBLER__ in the non-uapi headers
  arm: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  arm: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  arm64: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  arm64: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  csky: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi header
  csky: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  hexagon: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  hexagon: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  loongarch: Replace __ASSEMBLY__ with __ASSEMBLER__ in the loongarch
    headers
  m68k: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  m68k: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  microblaze: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  microblaze: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi
    headers
  mips: Replace __ASSEMBLY__ with __ASSEMBLER__ in the mips headers
  nios2: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  nios2: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  openrisc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  openrisc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  parisc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  parisc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  s390/uapi: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  s390x: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  sh: Replace __ASSEMBLY__ with __ASSEMBLER__ in the SuperH headers
  sparc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  sparc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  um: Replace __ASSEMBLY__ with __ASSEMBLER__ in the usermode headers
  x86: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  x86: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  xtensa: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  xtensa: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  scripts/dtc: Update fdt.h to the latest version
  treewide: Stop defining __ASSEMBLY__ for assembler files

 Documentation/dev-tools/checkuapi.rst         |  2 +-
 Makefile                                      |  2 +-
 arch/alpha/include/asm/console.h              |  4 +-
 arch/alpha/include/asm/page.h                 |  4 +-
 arch/alpha/include/asm/pal.h                  |  4 +-
 arch/alpha/include/asm/thread_info.h          |  8 +-
 arch/arc/include/asm/arcregs.h                |  2 +-
 arch/arc/include/asm/atomic.h                 |  4 +-
 arch/arc/include/asm/bitops.h                 |  4 +-
 arch/arc/include/asm/bug.h                    |  4 +-
 arch/arc/include/asm/cache.h                  |  4 +-
 arch/arc/include/asm/current.h                |  4 +-
 arch/arc/include/asm/dsp-impl.h               |  2 +-
 arch/arc/include/asm/dsp.h                    |  4 +-
 arch/arc/include/asm/dwarf.h                  |  4 +-
 arch/arc/include/asm/entry.h                  |  4 +-
 arch/arc/include/asm/irqflags-arcv2.h         |  4 +-
 arch/arc/include/asm/irqflags-compact.h       |  4 +-
 arch/arc/include/asm/jump_label.h             |  4 +-
 arch/arc/include/asm/linkage.h                |  6 +-
 arch/arc/include/asm/mmu-arcv2.h              |  4 +-
 arch/arc/include/asm/mmu.h                    |  2 +-
 arch/arc/include/asm/page.h                   |  4 +-
 arch/arc/include/asm/pgtable-bits-arcv2.h     |  4 +-
 arch/arc/include/asm/pgtable-levels.h         |  4 +-
 arch/arc/include/asm/pgtable.h                |  4 +-
 arch/arc/include/asm/processor.h              |  4 +-
 arch/arc/include/asm/ptrace.h                 |  4 +-
 arch/arc/include/asm/switch_to.h              |  2 +-
 arch/arc/include/asm/thread_info.h            |  4 +-
 arch/arc/include/uapi/asm/ptrace.h            |  4 +-
 arch/arm/include/asm/arch_gicv3.h             |  4 +-
 arch/arm/include/asm/assembler.h              |  2 +-
 arch/arm/include/asm/barrier.h                |  4 +-
 arch/arm/include/asm/cache.h                  |  2 +-
 arch/arm/include/asm/cp15.h                   |  4 +-
 arch/arm/include/asm/cputype.h                |  4 +-
 arch/arm/include/asm/current.h                |  4 +-
 arch/arm/include/asm/delay.h                  |  4 +-
 arch/arm/include/asm/domain.h                 |  8 +-
 arch/arm/include/asm/fpstate.h                |  2 +-
 arch/arm/include/asm/ftrace.h                 |  6 +-
 arch/arm/include/asm/hardware/cache-b15-rac.h |  2 +-
 arch/arm/include/asm/hardware/cache-l2x0.h    |  4 +-
 arch/arm/include/asm/hardware/dec21285.h      |  2 +-
 arch/arm/include/asm/hardware/ioc.h           |  2 +-
 arch/arm/include/asm/hardware/iomd.h          |  4 +-
 arch/arm/include/asm/hardware/memc.h          |  2 +-
 arch/arm/include/asm/hwcap.h                  |  2 +-
 arch/arm/include/asm/irq.h                    |  2 +-
 arch/arm/include/asm/jump_label.h             |  4 +-
 arch/arm/include/asm/kexec.h                  |  4 +-
 arch/arm/include/asm/kgdb.h                   |  4 +-
 arch/arm/include/asm/mach/arch.h              |  2 +-
 arch/arm/include/asm/mcpm.h                   |  4 +-
 arch/arm/include/asm/memory.h                 |  4 +-
 arch/arm/include/asm/mpu.h                    |  4 +-
 arch/arm/include/asm/opcodes.h                | 12 +--
 arch/arm/include/asm/page.h                   |  4 +-
 arch/arm/include/asm/pgtable-2level.h         |  4 +-
 arch/arm/include/asm/pgtable-3level.h         |  4 +-
 arch/arm/include/asm/pgtable-nommu.h          |  4 +-
 arch/arm/include/asm/pgtable.h                | 10 +-
 arch/arm/include/asm/probes.h                 |  4 +-
 arch/arm/include/asm/proc-fns.h               |  4 +-
 arch/arm/include/asm/ptrace.h                 |  4 +-
 arch/arm/include/asm/system_info.h            |  4 +-
 arch/arm/include/asm/system_misc.h            |  4 +-
 arch/arm/include/asm/thread_info.h            |  2 +-
 arch/arm/include/asm/thread_notify.h          |  2 +-
 arch/arm/include/asm/tlbflush.h               | 10 +-
 arch/arm/include/asm/tls.h                    |  4 +-
 arch/arm/include/asm/unified.h                |  6 +-
 arch/arm/include/asm/unwind.h                 |  4 +-
 arch/arm/include/asm/v7m.h                    |  4 +-
 arch/arm/include/asm/vdso.h                   |  4 +-
 arch/arm/include/asm/vdso/cp15.h              |  4 +-
 arch/arm/include/asm/vdso/gettimeofday.h      |  4 +-
 arch/arm/include/asm/vdso/processor.h         |  4 +-
 arch/arm/include/asm/vdso/vsyscall.h          |  4 +-
 arch/arm/include/asm/vfp.h                    |  2 +-
 arch/arm/include/asm/virt.h                   |  4 +-
 arch/arm/include/uapi/asm/ptrace.h            |  4 +-
 arch/arm/mach-at91/pm.h                       |  2 +-
 arch/arm/mach-exynos/smc.h                    |  4 +-
 .../mach-footbridge/include/mach/hardware.h   |  2 +-
 arch/arm/mach-imx/hardware.h                  |  2 +-
 arch/arm/mach-imx/mxc.h                       |  2 +-
 arch/arm/mach-omap2/control.h                 |  8 +-
 arch/arm/mach-omap2/soc.h                     |  4 +-
 arch/arm/mach-omap2/sram.h                    |  4 +-
 arch/arm/mach-pxa/irqs.h                      |  2 +-
 arch/arm/mach-pxa/pxa-regs.h                  |  2 +-
 arch/arm/mach-s3c/map-base.h                  |  2 +-
 arch/arm/mach-sa1100/include/mach/bitfield.h  |  2 +-
 arch/arm/mach-sa1100/include/mach/hardware.h  |  2 +-
 arch/arm/mach-tegra/reset.h                   |  2 +-
 arch/arm/mach-tegra/sleep.h                   |  2 +-
 arch/arm/tools/gen-mach-types                 |  2 +-
 arch/arm64/include/asm/alternative-macros.h   |  8 +-
 arch/arm64/include/asm/alternative.h          |  4 +-
 arch/arm64/include/asm/arch_gicv3.h           |  4 +-
 arch/arm64/include/asm/asm-extable.h          |  6 +-
 arch/arm64/include/asm/assembler.h            |  2 +-
 arch/arm64/include/asm/barrier.h              |  4 +-
 arch/arm64/include/asm/cache.h                |  4 +-
 arch/arm64/include/asm/cpucaps.h              |  4 +-
 arch/arm64/include/asm/cpufeature.h           |  4 +-
 arch/arm64/include/asm/cputype.h              |  4 +-
 arch/arm64/include/asm/current.h              |  4 +-
 arch/arm64/include/asm/debug-monitors.h       |  4 +-
 arch/arm64/include/asm/el2_setup.h            |  2 +-
 arch/arm64/include/asm/elf.h                  |  4 +-
 arch/arm64/include/asm/esr.h                  |  4 +-
 arch/arm64/include/asm/fixmap.h               |  4 +-
 arch/arm64/include/asm/fpsimd.h               |  2 +-
 arch/arm64/include/asm/ftrace.h               |  6 +-
 arch/arm64/include/asm/gpr-num.h              |  6 +-
 arch/arm64/include/asm/hwcap.h                |  2 +-
 arch/arm64/include/asm/image.h                |  4 +-
 arch/arm64/include/asm/insn.h                 |  4 +-
 arch/arm64/include/asm/jump_label.h           |  4 +-
 arch/arm64/include/asm/kasan.h                |  2 +-
 arch/arm64/include/asm/kexec.h                |  4 +-
 arch/arm64/include/asm/kgdb.h                 |  4 +-
 arch/arm64/include/asm/kvm_asm.h              |  4 +-
 arch/arm64/include/asm/kvm_mmu.h              |  4 +-
 arch/arm64/include/asm/kvm_mte.h              |  4 +-
 arch/arm64/include/asm/kvm_ptrauth.h          |  6 +-
 arch/arm64/include/asm/linkage.h              |  2 +-
 arch/arm64/include/asm/memory.h               |  4 +-
 arch/arm64/include/asm/mmu.h                  |  4 +-
 arch/arm64/include/asm/mmu_context.h          |  4 +-
 arch/arm64/include/asm/mte-kasan.h            |  4 +-
 arch/arm64/include/asm/mte.h                  |  4 +-
 arch/arm64/include/asm/page.h                 |  4 +-
 arch/arm64/include/asm/pgtable-prot.h         |  4 +-
 arch/arm64/include/asm/pgtable.h              |  4 +-
 arch/arm64/include/asm/proc-fns.h             |  4 +-
 arch/arm64/include/asm/processor.h            |  4 +-
 arch/arm64/include/asm/ptrace.h               |  4 +-
 arch/arm64/include/asm/rsi_smc.h              |  4 +-
 arch/arm64/include/asm/rwonce.h               |  4 +-
 arch/arm64/include/asm/scs.h                  |  4 +-
 arch/arm64/include/asm/sdei.h                 |  4 +-
 arch/arm64/include/asm/smp.h                  |  4 +-
 arch/arm64/include/asm/spectre.h              |  4 +-
 arch/arm64/include/asm/stacktrace/frame.h     |  4 +-
 arch/arm64/include/asm/sysreg.h               | 10 +-
 arch/arm64/include/asm/system_misc.h          |  4 +-
 arch/arm64/include/asm/thread_info.h          |  2 +-
 arch/arm64/include/asm/tlbflush.h             |  2 +-
 arch/arm64/include/asm/vdso.h                 |  4 +-
 arch/arm64/include/asm/vdso/compat_barrier.h  |  4 +-
 .../include/asm/vdso/compat_gettimeofday.h    |  4 +-
 arch/arm64/include/asm/vdso/getrandom.h       |  4 +-
 arch/arm64/include/asm/vdso/gettimeofday.h    |  4 +-
 arch/arm64/include/asm/vdso/processor.h       |  4 +-
 arch/arm64/include/asm/vdso/vsyscall.h        |  4 +-
 arch/arm64/include/asm/virt.h                 |  4 +-
 arch/arm64/include/uapi/asm/kvm.h             |  2 +-
 arch/arm64/include/uapi/asm/ptrace.h          |  4 +-
 arch/arm64/include/uapi/asm/sigcontext.h      |  4 +-
 arch/arm64/kernel/vdso32/Makefile             |  1 -
 arch/csky/abiv1/inc/abi/regdef.h              |  2 +-
 arch/csky/abiv2/inc/abi/regdef.h              |  2 +-
 arch/csky/include/asm/barrier.h               |  4 +-
 arch/csky/include/asm/cache.h                 |  2 +-
 arch/csky/include/asm/ftrace.h                |  4 +-
 arch/csky/include/asm/jump_label.h            |  4 +-
 arch/csky/include/asm/page.h                  |  4 +-
 arch/csky/include/asm/ptrace.h                |  4 +-
 arch/csky/include/asm/string.h                |  2 +-
 arch/csky/include/asm/thread_info.h           |  4 +-
 arch/csky/include/uapi/asm/ptrace.h           |  4 +-
 arch/hexagon/include/asm/hexagon_vm.h         |  4 +-
 arch/hexagon/include/asm/mem-layout.h         |  6 +-
 arch/hexagon/include/asm/page.h               |  4 +-
 arch/hexagon/include/asm/processor.h          |  4 +-
 arch/hexagon/include/asm/thread_info.h        | 12 +--
 arch/hexagon/include/uapi/asm/registers.h     |  4 +-
 arch/loongarch/include/asm/addrspace.h        |  8 +-
 arch/loongarch/include/asm/alternative-asm.h  |  4 +-
 arch/loongarch/include/asm/alternative.h      |  4 +-
 arch/loongarch/include/asm/asm-extable.h      |  6 +-
 arch/loongarch/include/asm/asm.h              |  8 +-
 arch/loongarch/include/asm/cpu.h              |  4 +-
 arch/loongarch/include/asm/ftrace.h           |  4 +-
 arch/loongarch/include/asm/gpr-num.h          |  6 +-
 arch/loongarch/include/asm/irqflags.h         |  4 +-
 arch/loongarch/include/asm/jump_label.h       |  4 +-
 arch/loongarch/include/asm/kasan.h            |  2 +-
 arch/loongarch/include/asm/loongarch.h        | 16 ++--
 arch/loongarch/include/asm/orc_types.h        |  4 +-
 arch/loongarch/include/asm/page.h             |  4 +-
 arch/loongarch/include/asm/pgtable-bits.h     |  4 +-
 arch/loongarch/include/asm/pgtable.h          |  4 +-
 arch/loongarch/include/asm/prefetch.h         |  2 +-
 arch/loongarch/include/asm/thread_info.h      |  4 +-
 arch/loongarch/include/asm/types.h            |  2 +-
 arch/loongarch/include/asm/unwind_hints.h     |  4 +-
 arch/loongarch/include/asm/vdso/getrandom.h   |  4 +-
 .../loongarch/include/asm/vdso/gettimeofday.h |  4 +-
 arch/loongarch/include/asm/vdso/processor.h   |  4 +-
 arch/loongarch/include/asm/vdso/vdso.h        |  4 +-
 arch/loongarch/include/asm/vdso/vsyscall.h    |  4 +-
 arch/loongarch/vdso/Makefile                  |  2 +-
 arch/m68k/include/asm/adb_iop.h               |  4 +-
 arch/m68k/include/asm/bootinfo.h              |  4 +-
 arch/m68k/include/asm/entry.h                 |  4 +-
 arch/m68k/include/asm/kexec.h                 |  4 +-
 arch/m68k/include/asm/mac_baboon.h            |  4 +-
 arch/m68k/include/asm/mac_iop.h               |  4 +-
 arch/m68k/include/asm/mac_oss.h               |  4 +-
 arch/m68k/include/asm/mac_psc.h               |  4 +-
 arch/m68k/include/asm/mac_via.h               |  4 +-
 arch/m68k/include/asm/math-emu.h              |  6 +-
 arch/m68k/include/asm/mcf_pgtable.h           |  4 +-
 arch/m68k/include/asm/mcfmmu.h                |  2 +-
 arch/m68k/include/asm/motorola_pgtable.h      |  4 +-
 arch/m68k/include/asm/nettel.h                |  4 +-
 arch/m68k/include/asm/openprom.h              |  4 +-
 arch/m68k/include/asm/page.h                  |  4 +-
 arch/m68k/include/asm/page_mm.h               |  4 +-
 arch/m68k/include/asm/page_no.h               |  4 +-
 arch/m68k/include/asm/pgtable.h               |  2 +-
 arch/m68k/include/asm/pgtable_mm.h            |  8 +-
 arch/m68k/include/asm/ptrace.h                |  4 +-
 arch/m68k/include/asm/setup.h                 | 10 +-
 arch/m68k/include/asm/sun3_pgtable.h          |  8 +-
 arch/m68k/include/asm/sun3mmu.h               |  4 +-
 arch/m68k/include/asm/thread_info.h           |  6 +-
 arch/m68k/include/asm/traps.h                 |  6 +-
 arch/m68k/include/uapi/asm/bootinfo-vme.h     |  4 +-
 arch/m68k/include/uapi/asm/bootinfo.h         |  8 +-
 arch/m68k/include/uapi/asm/ptrace.h           |  4 +-
 arch/m68k/math-emu/fp_emu.h                   |  8 +-
 arch/microblaze/include/asm/asm-compat.h      |  2 +-
 arch/microblaze/include/asm/current.h         |  4 +-
 arch/microblaze/include/asm/entry.h           |  4 +-
 arch/microblaze/include/asm/exceptions.h      |  4 +-
 arch/microblaze/include/asm/fixmap.h          |  4 +-
 arch/microblaze/include/asm/ftrace.h          |  2 +-
 arch/microblaze/include/asm/kgdb.h            |  4 +-
 arch/microblaze/include/asm/mmu.h             |  4 +-
 arch/microblaze/include/asm/page.h            |  8 +-
 arch/microblaze/include/asm/pgtable.h         | 18 ++--
 arch/microblaze/include/asm/processor.h       |  8 +-
 arch/microblaze/include/asm/ptrace.h          |  4 +-
 arch/microblaze/include/asm/sections.h        |  4 +-
 arch/microblaze/include/asm/setup.h           |  4 +-
 arch/microblaze/include/asm/thread_info.h     |  4 +-
 arch/microblaze/include/asm/unistd.h          |  4 +-
 .../include/asm/xilinx_mb_manager.h           |  4 +-
 arch/microblaze/include/uapi/asm/ptrace.h     |  4 +-
 arch/mips/boot/compressed/Makefile            |  2 +-
 arch/mips/include/asm/addrspace.h             |  4 +-
 arch/mips/include/asm/asm-eva.h               |  6 +-
 arch/mips/include/asm/asm.h                   |  8 +-
 arch/mips/include/asm/bmips.h                 |  4 +-
 arch/mips/include/asm/cpu.h                   |  4 +-
 arch/mips/include/asm/dec/ecc.h               |  2 +-
 arch/mips/include/asm/dec/interrupts.h        |  4 +-
 arch/mips/include/asm/dec/kn01.h              |  2 +-
 arch/mips/include/asm/dec/kn02.h              |  2 +-
 arch/mips/include/asm/dec/kn02xa.h            |  2 +-
 arch/mips/include/asm/eva.h                   |  4 +-
 arch/mips/include/asm/ftrace.h                |  4 +-
 arch/mips/include/asm/hazards.h               |  4 +-
 arch/mips/include/asm/irqflags.h              |  4 +-
 arch/mips/include/asm/jazz.h                  | 16 ++--
 arch/mips/include/asm/jump_label.h            |  4 +-
 arch/mips/include/asm/linkage.h               |  2 +-
 arch/mips/include/asm/mach-generic/spaces.h   |  4 +-
 arch/mips/include/asm/mips-boards/bonito64.h  |  4 +-
 arch/mips/include/asm/mipsmtregs.h            |  6 +-
 arch/mips/include/asm/mipsregs.h              |  6 +-
 arch/mips/include/asm/msa.h                   |  4 +-
 arch/mips/include/asm/pci/bridge.h            |  4 +-
 arch/mips/include/asm/pm.h                    |  6 +-
 arch/mips/include/asm/prefetch.h              |  2 +-
 arch/mips/include/asm/regdef.h                |  4 +-
 arch/mips/include/asm/sibyte/board.h          |  4 +-
 arch/mips/include/asm/sibyte/sb1250.h         |  2 +-
 arch/mips/include/asm/sibyte/sb1250_defs.h    |  6 +-
 arch/mips/include/asm/smp-cps.h               |  6 +-
 arch/mips/include/asm/sn/addrs.h              | 18 ++--
 arch/mips/include/asm/sn/gda.h                |  4 +-
 arch/mips/include/asm/sn/kldir.h              |  4 +-
 arch/mips/include/asm/sn/klkernvars.h         |  4 +-
 arch/mips/include/asm/sn/launch.h             |  4 +-
 arch/mips/include/asm/sn/nmi.h                |  8 +-
 arch/mips/include/asm/sn/sn0/addrs.h          | 14 +--
 arch/mips/include/asm/sn/sn0/hub.h            |  2 +-
 arch/mips/include/asm/sn/sn0/hubio.h          | 36 ++++----
 arch/mips/include/asm/sn/sn0/hubmd.h          |  4 +-
 arch/mips/include/asm/sn/sn0/hubni.h          |  6 +-
 arch/mips/include/asm/sn/sn0/hubpi.h          |  4 +-
 arch/mips/include/asm/sn/types.h              |  2 +-
 arch/mips/include/asm/sync.h                  |  2 +-
 arch/mips/include/asm/thread_info.h           |  4 +-
 arch/mips/include/asm/unistd.h                |  4 +-
 arch/mips/include/asm/vdso/gettimeofday.h     |  4 +-
 arch/mips/include/asm/vdso/processor.h        |  4 +-
 arch/mips/include/asm/vdso/vdso.h             |  4 +-
 arch/mips/include/asm/vdso/vsyscall.h         |  4 +-
 arch/mips/include/asm/xtalk/xtalk.h           |  4 +-
 arch/mips/include/asm/xtalk/xwidget.h         |  4 +-
 arch/mips/vdso/Makefile                       |  2 +-
 arch/nios2/include/asm/entry.h                |  4 +-
 arch/nios2/include/asm/page.h                 |  4 +-
 arch/nios2/include/asm/processor.h            |  4 +-
 arch/nios2/include/asm/ptrace.h               |  4 +-
 arch/nios2/include/asm/registers.h            |  4 +-
 arch/nios2/include/asm/setup.h                |  4 +-
 arch/nios2/include/asm/thread_info.h          |  4 +-
 arch/nios2/include/asm/traps.h                |  2 +-
 arch/nios2/include/uapi/asm/ptrace.h          |  4 +-
 arch/openrisc/include/asm/mmu.h               |  2 +-
 arch/openrisc/include/asm/page.h              |  8 +-
 arch/openrisc/include/asm/pgtable.h           |  4 +-
 arch/openrisc/include/asm/processor.h         |  4 +-
 arch/openrisc/include/asm/ptrace.h            |  4 +-
 arch/openrisc/include/asm/setup.h             |  2 +-
 arch/openrisc/include/asm/thread_info.h       |  8 +-
 arch/openrisc/include/uapi/asm/ptrace.h       |  2 +-
 arch/parisc/include/asm/alternative.h         |  4 +-
 arch/parisc/include/asm/assembly.h            |  4 +-
 arch/parisc/include/asm/barrier.h             |  4 +-
 arch/parisc/include/asm/cache.h               |  4 +-
 arch/parisc/include/asm/current.h             |  4 +-
 arch/parisc/include/asm/dwarf.h               |  4 +-
 arch/parisc/include/asm/fixmap.h              |  4 +-
 arch/parisc/include/asm/ftrace.h              |  4 +-
 arch/parisc/include/asm/jump_label.h          |  4 +-
 arch/parisc/include/asm/kexec.h               |  4 +-
 arch/parisc/include/asm/kgdb.h                |  2 +-
 arch/parisc/include/asm/linkage.h             |  4 +-
 arch/parisc/include/asm/page.h                |  6 +-
 arch/parisc/include/asm/pdc.h                 |  4 +-
 arch/parisc/include/asm/pdcpat.h              |  4 +-
 arch/parisc/include/asm/pgtable.h             |  8 +-
 arch/parisc/include/asm/prefetch.h            |  4 +-
 arch/parisc/include/asm/processor.h           |  8 +-
 arch/parisc/include/asm/psw.h                 |  4 +-
 arch/parisc/include/asm/signal.h              |  4 +-
 arch/parisc/include/asm/smp.h                 |  4 +-
 arch/parisc/include/asm/spinlock_types.h      |  4 +-
 arch/parisc/include/asm/thread_info.h         |  4 +-
 arch/parisc/include/asm/traps.h               |  2 +-
 arch/parisc/include/asm/unistd.h              |  4 +-
 arch/parisc/include/asm/vdso.h                |  4 +-
 arch/parisc/include/uapi/asm/pdc.h            |  4 +-
 arch/parisc/include/uapi/asm/signal.h         |  4 +-
 arch/powerpc/boot/Makefile                    |  2 +-
 arch/powerpc/boot/page.h                      |  2 +-
 arch/powerpc/include/asm/asm-const.h          |  2 +-
 arch/powerpc/include/asm/barrier.h            |  2 +-
 arch/powerpc/include/asm/book3s/32/kup.h      |  4 +-
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  8 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h  | 12 +--
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  4 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  4 +-
 arch/powerpc/include/asm/book3s/64/hash.h     |  4 +-
 arch/powerpc/include/asm/book3s/64/kup.h      |  6 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 12 +--
 arch/powerpc/include/asm/book3s/64/mmu.h      |  8 +-
 .../include/asm/book3s/64/pgtable-64k.h       |  4 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 10 +-
 arch/powerpc/include/asm/book3s/64/radix.h    |  8 +-
 arch/powerpc/include/asm/book3s/64/slice.h    |  4 +-
 arch/powerpc/include/asm/bug.h                | 14 +--
 arch/powerpc/include/asm/cache.h              |  4 +-
 arch/powerpc/include/asm/cpu_has_feature.h    |  4 +-
 arch/powerpc/include/asm/cpuidle.h            |  2 +-
 arch/powerpc/include/asm/cputable.h           |  8 +-
 arch/powerpc/include/asm/cputhreads.h         |  4 +-
 arch/powerpc/include/asm/dcr-generic.h        |  4 +-
 arch/powerpc/include/asm/dcr-native.h         |  4 +-
 arch/powerpc/include/asm/dcr.h                |  4 +-
 arch/powerpc/include/asm/epapr_hcalls.h       |  4 +-
 arch/powerpc/include/asm/exception-64e.h      |  2 +-
 arch/powerpc/include/asm/exception-64s.h      |  6 +-
 arch/powerpc/include/asm/extable.h            |  2 +-
 arch/powerpc/include/asm/feature-fixups.h     |  6 +-
 arch/powerpc/include/asm/firmware.h           |  4 +-
 arch/powerpc/include/asm/fixmap.h             |  4 +-
 arch/powerpc/include/asm/ftrace.h             |  8 +-
 arch/powerpc/include/asm/head-64.h            |  4 +-
 arch/powerpc/include/asm/hvcall.h             |  4 +-
 arch/powerpc/include/asm/hw_irq.h             |  4 +-
 arch/powerpc/include/asm/interrupt.h          |  4 +-
 arch/powerpc/include/asm/irqflags.h           |  2 +-
 arch/powerpc/include/asm/jump_label.h         |  2 +-
 arch/powerpc/include/asm/kasan.h              |  4 +-
 arch/powerpc/include/asm/kdump.h              |  4 +-
 arch/powerpc/include/asm/kexec.h              |  4 +-
 arch/powerpc/include/asm/kgdb.h               |  4 +-
 arch/powerpc/include/asm/kup.h                |  8 +-
 arch/powerpc/include/asm/kvm_asm.h            |  2 +-
 arch/powerpc/include/asm/kvm_book3s_asm.h     |  6 +-
 arch/powerpc/include/asm/kvm_booke_hv_asm.h   |  4 +-
 arch/powerpc/include/asm/lv1call.h            |  4 +-
 arch/powerpc/include/asm/mmu.h                |  8 +-
 arch/powerpc/include/asm/mpc52xx.h            | 12 +--
 arch/powerpc/include/asm/nohash/32/kup-8xx.h  |  4 +-
 arch/powerpc/include/asm/nohash/32/mmu-44x.h  |  4 +-
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h  |  4 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h  | 12 +--
 arch/powerpc/include/asm/nohash/32/pte-8xx.h  |  2 +-
 .../include/asm/nohash/64/pgtable-4k.h        |  8 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  4 +-
 arch/powerpc/include/asm/nohash/kup-booke.h   |  4 +-
 arch/powerpc/include/asm/nohash/mmu-e500.h    |  4 +-
 arch/powerpc/include/asm/nohash/pgtable.h     |  6 +-
 arch/powerpc/include/asm/nohash/pte-e500.h    |  4 +-
 arch/powerpc/include/asm/opal-api.h           |  4 +-
 arch/powerpc/include/asm/opal.h               |  4 +-
 arch/powerpc/include/asm/page.h               | 14 +--
 arch/powerpc/include/asm/page_32.h            |  4 +-
 arch/powerpc/include/asm/page_64.h            |  4 +-
 arch/powerpc/include/asm/pgtable.h            |  8 +-
 arch/powerpc/include/asm/ppc_asm.h            |  4 +-
 arch/powerpc/include/asm/processor.h          |  8 +-
 arch/powerpc/include/asm/ptrace.h             |  6 +-
 arch/powerpc/include/asm/reg.h                |  6 +-
 arch/powerpc/include/asm/reg_booke.h          |  4 +-
 arch/powerpc/include/asm/reg_fsl_emb.h        |  4 +-
 arch/powerpc/include/asm/setup.h              |  4 +-
 arch/powerpc/include/asm/smp.h                |  4 +-
 arch/powerpc/include/asm/spu_csa.h            |  4 +-
 arch/powerpc/include/asm/synch.h              |  4 +-
 arch/powerpc/include/asm/thread_info.h        |  8 +-
 arch/powerpc/include/asm/tm.h                 |  4 +-
 arch/powerpc/include/asm/types.h              |  4 +-
 arch/powerpc/include/asm/unistd.h             |  4 +-
 arch/powerpc/include/asm/vdso.h               |  6 +-
 arch/powerpc/include/asm/vdso/getrandom.h     |  4 +-
 arch/powerpc/include/asm/vdso/gettimeofday.h  |  4 +-
 arch/powerpc/include/asm/vdso/processor.h     |  4 +-
 arch/powerpc/include/asm/vdso/vsyscall.h      |  4 +-
 arch/powerpc/include/asm/vdso_datapage.h      |  6 +-
 arch/powerpc/include/uapi/asm/opal-prd.h      |  4 +-
 arch/powerpc/include/uapi/asm/ptrace.h        | 12 +--
 arch/powerpc/include/uapi/asm/types.h         |  4 +-
 arch/powerpc/kernel/head_booke.h              |  4 +-
 arch/powerpc/net/bpf_jit.h                    |  2 +-
 arch/powerpc/platforms/cell/spufs/Makefile    |  2 +-
 arch/powerpc/platforms/powernv/subcore.h      |  4 +-
 arch/powerpc/xmon/xmon_bpts.h                 |  4 +-
 arch/riscv/include/asm/alternative-macros.h   | 12 +--
 arch/riscv/include/asm/alternative.h          |  2 +-
 arch/riscv/include/asm/asm-extable.h          |  6 +-
 arch/riscv/include/asm/asm.h                  | 10 +-
 arch/riscv/include/asm/assembler.h            |  2 +-
 arch/riscv/include/asm/barrier.h              |  4 +-
 arch/riscv/include/asm/cache.h                |  4 +-
 arch/riscv/include/asm/cpu_ops_sbi.h          |  2 +-
 arch/riscv/include/asm/csr.h                  |  4 +-
 arch/riscv/include/asm/current.h              |  4 +-
 arch/riscv/include/asm/errata_list.h          |  6 +-
 arch/riscv/include/asm/ftrace.h               |  6 +-
 arch/riscv/include/asm/gpr-num.h              |  6 +-
 arch/riscv/include/asm/image.h                |  4 +-
 arch/riscv/include/asm/insn-def.h             |  6 +-
 arch/riscv/include/asm/jump_label.h           |  4 +-
 arch/riscv/include/asm/kasan.h                |  2 +-
 arch/riscv/include/asm/kgdb.h                 |  4 +-
 arch/riscv/include/asm/mmu.h                  |  4 +-
 arch/riscv/include/asm/page.h                 |  4 +-
 arch/riscv/include/asm/pgtable.h              |  4 +-
 arch/riscv/include/asm/processor.h            |  4 +-
 arch/riscv/include/asm/ptrace.h               |  4 +-
 arch/riscv/include/asm/scs.h                  |  4 +-
 arch/riscv/include/asm/set_memory.h           |  4 +-
 arch/riscv/include/asm/thread_info.h          |  4 +-
 arch/riscv/include/asm/vdso.h                 |  4 +-
 arch/riscv/include/asm/vdso/gettimeofday.h    |  4 +-
 arch/riscv/include/asm/vdso/processor.h       |  4 +-
 arch/riscv/include/asm/vdso/vsyscall.h        |  4 +-
 arch/riscv/include/uapi/asm/kvm.h             |  2 +-
 arch/riscv/include/uapi/asm/ptrace.h          |  4 +-
 arch/riscv/include/uapi/asm/sigcontext.h      |  4 +-
 arch/s390/Makefile                            |  2 +-
 arch/s390/boot/boot.h                         |  4 +-
 arch/s390/include/asm/alternative.h           |  6 +-
 arch/s390/include/asm/asm-const.h             |  2 +-
 arch/s390/include/asm/cpu.h                   |  4 +-
 arch/s390/include/asm/cpu_mf-insn.h           |  4 +-
 arch/s390/include/asm/ctlreg.h                |  4 +-
 arch/s390/include/asm/dwarf.h                 |  4 +-
 arch/s390/include/asm/extmem.h                |  2 +-
 arch/s390/include/asm/fpu-insn-asm.h          |  4 +-
 arch/s390/include/asm/fpu-insn.h              |  4 +-
 arch/s390/include/asm/ftrace.h                |  4 +-
 arch/s390/include/asm/irq.h                   |  4 +-
 arch/s390/include/asm/jump_label.h            |  4 +-
 arch/s390/include/asm/lowcore.h               |  6 +-
 arch/s390/include/asm/mem_encrypt.h           |  4 +-
 arch/s390/include/asm/nmi.h                   |  4 +-
 arch/s390/include/asm/nospec-branch.h         |  4 +-
 arch/s390/include/asm/nospec-insn.h           |  4 +-
 arch/s390/include/asm/page.h                  |  4 +-
 arch/s390/include/asm/processor.h             |  4 +-
 arch/s390/include/asm/ptrace.h                |  4 +-
 arch/s390/include/asm/purgatory.h             |  4 +-
 arch/s390/include/asm/sclp.h                  |  4 +-
 arch/s390/include/asm/setup.h                 |  4 +-
 arch/s390/include/asm/sigp.h                  |  4 +-
 arch/s390/include/asm/thread_info.h           |  2 +-
 arch/s390/include/asm/tpi.h                   |  4 +-
 arch/s390/include/asm/types.h                 |  4 +-
 arch/s390/include/asm/vdso.h                  |  4 +-
 arch/s390/include/asm/vdso/getrandom.h        |  4 +-
 arch/s390/include/asm/vdso/vsyscall.h         |  4 +-
 arch/s390/include/uapi/asm/ptrace.h           |  5 +-
 arch/s390/include/uapi/asm/schid.h            |  4 +-
 arch/s390/include/uapi/asm/types.h            |  4 +-
 arch/s390/net/bpf_jit.h                       |  4 +-
 arch/sh/include/asm/cache.h                   |  4 +-
 arch/sh/include/asm/dwarf.h                   |  6 +-
 arch/sh/include/asm/fpu.h                     |  4 +-
 arch/sh/include/asm/ftrace.h                  |  8 +-
 arch/sh/include/asm/mmu.h                     |  4 +-
 arch/sh/include/asm/page.h                    |  8 +-
 arch/sh/include/asm/pgtable.h                 |  4 +-
 arch/sh/include/asm/pgtable_32.h              |  8 +-
 arch/sh/include/asm/processor.h               |  4 +-
 arch/sh/include/asm/smc37c93x.h               |  4 +-
 arch/sh/include/asm/suspend.h                 |  2 +-
 arch/sh/include/asm/thread_info.h             | 10 +-
 arch/sh/include/asm/tlb.h                     |  4 +-
 arch/sh/include/asm/types.h                   |  4 +-
 arch/sh/include/mach-common/mach/romimage.h   |  6 +-
 arch/sh/include/mach-ecovec24/mach/romimage.h |  6 +-
 arch/sh/include/mach-kfr2r09/mach/romimage.h  |  6 +-
 arch/sparc/include/asm/adi_64.h               |  4 +-
 arch/sparc/include/asm/auxio.h                |  4 +-
 arch/sparc/include/asm/auxio_32.h             |  4 +-
 arch/sparc/include/asm/auxio_64.h             |  4 +-
 arch/sparc/include/asm/cacheflush_64.h        |  4 +-
 arch/sparc/include/asm/cpudata.h              |  4 +-
 arch/sparc/include/asm/cpudata_64.h           |  4 +-
 arch/sparc/include/asm/delay_64.h             |  4 +-
 arch/sparc/include/asm/ftrace.h               |  2 +-
 arch/sparc/include/asm/hvtramp.h              |  2 +-
 arch/sparc/include/asm/hypervisor.h           | 92 +++++++++----------
 arch/sparc/include/asm/irqflags_32.h          |  4 +-
 arch/sparc/include/asm/irqflags_64.h          |  4 +-
 arch/sparc/include/asm/jump_label.h           |  4 +-
 arch/sparc/include/asm/kdebug_32.h            |  4 +-
 arch/sparc/include/asm/leon.h                 |  8 +-
 arch/sparc/include/asm/leon_amba.h            |  6 +-
 arch/sparc/include/asm/mman.h                 |  4 +-
 arch/sparc/include/asm/mmu_64.h               |  4 +-
 arch/sparc/include/asm/mmu_context_32.h       |  4 +-
 arch/sparc/include/asm/mmu_context_64.h       |  4 +-
 arch/sparc/include/asm/mxcc.h                 |  4 +-
 arch/sparc/include/asm/obio.h                 |  4 +-
 arch/sparc/include/asm/openprom.h             |  4 +-
 arch/sparc/include/asm/page_32.h              |  8 +-
 arch/sparc/include/asm/page_64.h              |  8 +-
 arch/sparc/include/asm/pcic.h                 |  2 +-
 arch/sparc/include/asm/pgtable_32.h           |  4 +-
 arch/sparc/include/asm/pgtable_64.h           |  8 +-
 arch/sparc/include/asm/pgtsrmmu.h             |  6 +-
 arch/sparc/include/asm/processor_64.h         | 10 +-
 arch/sparc/include/asm/psr.h                  |  4 +-
 arch/sparc/include/asm/ptrace.h               | 12 +--
 arch/sparc/include/asm/ross.h                 |  4 +-
 arch/sparc/include/asm/sbi.h                  |  4 +-
 arch/sparc/include/asm/sigcontext.h           |  4 +-
 arch/sparc/include/asm/signal.h               |  6 +-
 arch/sparc/include/asm/smp_32.h               |  8 +-
 arch/sparc/include/asm/smp_64.h               |  8 +-
 arch/sparc/include/asm/spinlock_32.h          |  4 +-
 arch/sparc/include/asm/spinlock_64.h          |  4 +-
 arch/sparc/include/asm/spitfire.h             |  4 +-
 arch/sparc/include/asm/starfire.h             |  2 +-
 arch/sparc/include/asm/thread_info_32.h       |  4 +-
 arch/sparc/include/asm/thread_info_64.h       | 12 +--
 arch/sparc/include/asm/trap_block.h           |  4 +-
 arch/sparc/include/asm/traps.h                |  4 +-
 arch/sparc/include/asm/tsb.h                  |  2 +-
 arch/sparc/include/asm/ttable.h               |  2 +-
 arch/sparc/include/asm/turbosparc.h           |  4 +-
 arch/sparc/include/asm/upa.h                  |  4 +-
 arch/sparc/include/asm/vaddrs.h               |  2 +-
 arch/sparc/include/asm/viking.h               |  4 +-
 arch/sparc/include/asm/visasm.h               |  2 +-
 arch/sparc/include/uapi/asm/ptrace.h          | 24 ++---
 arch/sparc/include/uapi/asm/signal.h          |  4 +-
 arch/sparc/include/uapi/asm/traps.h           |  4 +-
 arch/sparc/include/uapi/asm/utrap.h           |  4 +-
 arch/um/include/asm/cpufeature.h              |  4 +-
 arch/um/include/asm/current.h                 |  4 +-
 arch/um/include/asm/page.h                    |  4 +-
 arch/um/include/asm/ptrace-generic.h          |  2 +-
 arch/um/include/asm/thread_info.h             |  2 +-
 arch/um/include/shared/as-layout.h            |  2 +-
 arch/x86/boot/Makefile                        |  2 +-
 arch/x86/boot/boot.h                          |  4 +-
 arch/x86/boot/compressed/Makefile             |  2 +-
 arch/x86/entry/vdso/extable.h                 |  2 +-
 arch/x86/include/asm/alternative.h            |  6 +-
 arch/x86/include/asm/asm.h                    | 10 +-
 arch/x86/include/asm/boot.h                   |  2 +-
 arch/x86/include/asm/cpufeature.h             |  4 +-
 arch/x86/include/asm/cpumask.h                |  4 +-
 arch/x86/include/asm/current.h                |  4 +-
 arch/x86/include/asm/desc_defs.h              |  4 +-
 arch/x86/include/asm/dwarf2.h                 |  2 +-
 arch/x86/include/asm/fixmap.h                 |  4 +-
 arch/x86/include/asm/frame.h                  | 10 +-
 arch/x86/include/asm/fred.h                   |  4 +-
 arch/x86/include/asm/fsgsbase.h               |  4 +-
 arch/x86/include/asm/ftrace.h                 |  8 +-
 arch/x86/include/asm/hw_irq.h                 |  4 +-
 arch/x86/include/asm/ibt.h                    | 12 +--
 arch/x86/include/asm/idtentry.h               |  6 +-
 arch/x86/include/asm/inst.h                   |  2 +-
 arch/x86/include/asm/irqflags.h               | 10 +-
 arch/x86/include/asm/jump_label.h             |  4 +-
 arch/x86/include/asm/kasan.h                  |  2 +-
 arch/x86/include/asm/kexec.h                  |  4 +-
 arch/x86/include/asm/linkage.h                |  6 +-
 arch/x86/include/asm/mem_encrypt.h            |  4 +-
 arch/x86/include/asm/msr.h                    |  4 +-
 arch/x86/include/asm/nops.h                   |  2 +-
 arch/x86/include/asm/nospec-branch.h          |  6 +-
 arch/x86/include/asm/orc_types.h              |  4 +-
 arch/x86/include/asm/page.h                   |  4 +-
 arch/x86/include/asm/page_32.h                |  4 +-
 arch/x86/include/asm/page_32_types.h          |  4 +-
 arch/x86/include/asm/page_64.h                |  4 +-
 arch/x86/include/asm/page_64_types.h          |  2 +-
 arch/x86/include/asm/page_types.h             |  4 +-
 arch/x86/include/asm/paravirt.h               | 14 +--
 arch/x86/include/asm/paravirt_types.h         |  4 +-
 arch/x86/include/asm/percpu.h                 |  6 +-
 arch/x86/include/asm/pgtable-2level_types.h   |  4 +-
 arch/x86/include/asm/pgtable-3level_types.h   |  4 +-
 arch/x86/include/asm/pgtable-invert.h         |  4 +-
 arch/x86/include/asm/pgtable.h                | 12 +--
 arch/x86/include/asm/pgtable_32.h             |  4 +-
 arch/x86/include/asm/pgtable_32_areas.h       |  2 +-
 arch/x86/include/asm/pgtable_64.h             |  6 +-
 arch/x86/include/asm/pgtable_64_types.h       |  4 +-
 arch/x86/include/asm/pgtable_types.h          | 10 +-
 arch/x86/include/asm/prom.h                   |  4 +-
 arch/x86/include/asm/pti.h                    |  4 +-
 arch/x86/include/asm/ptrace.h                 |  4 +-
 arch/x86/include/asm/purgatory.h              |  4 +-
 arch/x86/include/asm/pvclock-abi.h            |  4 +-
 arch/x86/include/asm/realmode.h               |  4 +-
 arch/x86/include/asm/segment.h                |  8 +-
 arch/x86/include/asm/setup.h                  |  6 +-
 arch/x86/include/asm/setup_data.h             |  4 +-
 arch/x86/include/asm/shared/tdx.h             |  4 +-
 arch/x86/include/asm/shstk.h                  |  4 +-
 arch/x86/include/asm/signal.h                 |  8 +-
 arch/x86/include/asm/smap.h                   |  6 +-
 arch/x86/include/asm/smp.h                    |  4 +-
 arch/x86/include/asm/tdx.h                    |  4 +-
 arch/x86/include/asm/thread_info.h            | 12 +--
 arch/x86/include/asm/unwind_hints.h           |  4 +-
 arch/x86/include/asm/vdso/getrandom.h         |  4 +-
 arch/x86/include/asm/vdso/gettimeofday.h      |  4 +-
 arch/x86/include/asm/vdso/processor.h         |  4 +-
 arch/x86/include/asm/vdso/vsyscall.h          |  4 +-
 arch/x86/include/asm/xen/interface.h          | 10 +-
 arch/x86/include/asm/xen/interface_32.h       |  4 +-
 arch/x86/include/asm/xen/interface_64.h       |  4 +-
 arch/x86/include/uapi/asm/bootparam.h         |  4 +-
 arch/x86/include/uapi/asm/e820.h              |  4 +-
 arch/x86/include/uapi/asm/ldt.h               |  4 +-
 arch/x86/include/uapi/asm/msr.h               |  4 +-
 arch/x86/include/uapi/asm/ptrace-abi.h        |  6 +-
 arch/x86/include/uapi/asm/ptrace.h            |  4 +-
 arch/x86/include/uapi/asm/setup_data.h        |  4 +-
 arch/x86/include/uapi/asm/signal.h            |  8 +-
 arch/x86/math-emu/control_w.h                 |  2 +-
 arch/x86/math-emu/exception.h                 |  6 +-
 arch/x86/math-emu/fpu_emu.h                   |  6 +-
 arch/x86/math-emu/status_w.h                  |  6 +-
 arch/x86/realmode/rm/Makefile                 |  2 +-
 arch/x86/realmode/rm/realmode.h               |  4 +-
 arch/x86/realmode/rm/wakeup.h                 |  2 +-
 arch/xtensa/include/asm/bootparam.h           |  2 +-
 arch/xtensa/include/asm/cmpxchg.h             |  4 +-
 arch/xtensa/include/asm/coprocessor.h         |  8 +-
 arch/xtensa/include/asm/current.h             |  2 +-
 arch/xtensa/include/asm/ftrace.h              |  8 +-
 arch/xtensa/include/asm/initialize_mmu.h      |  4 +-
 arch/xtensa/include/asm/jump_label.h          |  4 +-
 arch/xtensa/include/asm/kasan.h               |  2 +-
 arch/xtensa/include/asm/kmem_layout.h         |  2 +-
 arch/xtensa/include/asm/page.h                |  4 +-
 arch/xtensa/include/asm/pgtable.h             |  8 +-
 arch/xtensa/include/asm/processor.h           |  4 +-
 arch/xtensa/include/asm/ptrace.h              |  6 +-
 arch/xtensa/include/asm/signal.h              |  4 +-
 arch/xtensa/include/asm/thread_info.h         |  8 +-
 arch/xtensa/include/asm/tlbflush.h            |  4 +-
 arch/xtensa/include/uapi/asm/ptrace.h         |  2 +-
 arch/xtensa/include/uapi/asm/signal.h         |  6 +-
 arch/xtensa/include/uapi/asm/types.h          |  4 +-
 arch/xtensa/kernel/Makefile                   |  2 +-
 drivers/char/hw_random/n2rng.h                |  4 +-
 drivers/memory/emif.h                         |  4 +-
 drivers/net/wan/Makefile                      |  2 +-
 drivers/soc/bcm/brcmstb/pm/pm.h               |  2 +-
 include/asm-generic/barrier.h                 |  4 +-
 include/asm-generic/bug.h                     |  4 +-
 include/asm-generic/current.h                 |  2 +-
 include/asm-generic/error-injection.h         |  2 +-
 include/asm-generic/fixmap.h                  |  4 +-
 include/asm-generic/getorder.h                |  4 +-
 include/asm-generic/int-ll64.h                |  6 +-
 include/asm-generic/kprobes.h                 |  4 +-
 include/asm-generic/memory_model.h            |  4 +-
 include/asm-generic/mmu.h                     |  2 +-
 include/asm-generic/pgtable-nop4d.h           |  4 +-
 include/asm-generic/pgtable-nopmd.h           |  4 +-
 include/asm-generic/pgtable-nopud.h           |  4 +-
 include/asm-generic/rwonce.h                  |  4 +-
 include/asm-generic/signal.h                  |  4 +-
 include/asm-generic/vdso/vsyscall.h           |  4 +-
 include/linux/amba/serial.h                   |  4 +-
 include/linux/arm-smccc.h                     |  4 +-
 include/linux/bitmap.h                        |  4 +-
 include/linux/bits.h                          |  4 +-
 include/linux/cfi_types.h                     |  4 +-
 include/linux/compiler.h                      |  4 +-
 include/linux/compiler_types.h                |  4 +-
 include/linux/edd.h                           |  4 +-
 include/linux/err.h                           |  2 +-
 include/linux/export.h                        |  2 +-
 include/linux/init.h                          |  6 +-
 include/linux/ioport.h                        |  4 +-
 include/linux/irqchip/arm-gic-v3.h            |  2 +-
 include/linux/irqchip/arm-gic.h               |  4 +-
 include/linux/jump_label.h                    | 10 +-
 include/linux/kexec.h                         |  2 +-
 include/linux/linkage.h                       |  6 +-
 include/linux/mem_encrypt.h                   |  4 +-
 include/linux/mmzone.h                        |  4 +-
 include/linux/objtool.h                       | 10 +-
 include/linux/objtool_types.h                 |  4 +-
 include/linux/of_fdt.h                        |  4 +-
 include/linux/pe.h                            |  4 +-
 include/linux/percpu-defs.h                   |  4 +-
 include/linux/pfn.h                           |  2 +-
 include/linux/pgtable.h                       |  4 +-
 include/linux/platform_data/emif_plat.h       |  4 +-
 include/linux/serial_s3c.h                    |  4 +-
 include/linux/ti-emif-sram.h                  |  2 +-
 include/linux/types.h                         |  4 +-
 include/soc/imx/cpu.h                         |  2 +-
 include/soc/tegra/flowctrl.h                  |  4 +-
 include/soc/tegra/fuse.h                      |  4 +-
 include/uapi/asm-generic/int-l64.h            |  4 +-
 include/uapi/asm-generic/int-ll64.h           |  4 +-
 include/uapi/asm-generic/signal-defs.h        |  2 +-
 include/uapi/asm-generic/signal.h             |  4 +-
 include/uapi/linux/a.out.h                    |  4 +-
 include/uapi/linux/const.h                    |  4 +-
 include/uapi/linux/edd.h                      |  4 +-
 include/uapi/linux/hdlc/ioctl.h               |  4 +-
 include/uapi/linux/sched.h                    |  2 +-
 include/uapi/linux/types.h                    |  4 +-
 include/vdso/datapage.h                       |  4 +-
 include/vdso/helpers.h                        |  4 +-
 include/vdso/processor.h                      |  4 +-
 include/vdso/vsyscall.h                       |  4 +-
 include/xen/arm/interface.h                   |  2 +-
 include/xen/interface/xen-mca.h               |  4 +-
 include/xen/interface/xen.h                   |  8 +-
 scripts/Makefile.build                        |  2 +-
 scripts/dtc/libfdt/fdt.h                      |  4 +-
 scripts/gfp-translate                         |  2 +-
 tools/arch/arm64/include/asm/cputype.h        |  4 +-
 tools/arch/arm64/include/asm/esr.h            |  4 +-
 tools/arch/arm64/include/asm/gpr-num.h        |  6 +-
 tools/arch/arm64/include/asm/sysreg.h         | 10 +-
 tools/arch/arm64/include/uapi/asm/kvm.h       |  2 +-
 tools/arch/loongarch/include/asm/orc_types.h  |  4 +-
 tools/arch/riscv/include/asm/csr.h            |  6 +-
 tools/arch/riscv/include/asm/vdso/processor.h |  4 +-
 tools/arch/x86/include/asm/asm.h              |  8 +-
 tools/arch/x86/include/asm/nops.h             |  2 +-
 tools/arch/x86/include/asm/orc_types.h        |  4 +-
 tools/arch/x86/include/asm/pvclock-abi.h      |  4 +-
 tools/include/asm-generic/barrier.h           |  4 +-
 tools/include/asm/alternative.h               |  2 +-
 tools/include/linux/bits.h                    |  4 +-
 tools/include/linux/compiler.h                |  4 +-
 tools/include/linux/objtool_types.h           |  4 +-
 tools/include/uapi/linux/const.h              |  4 +-
 .../trace/beauty/include/uapi/linux/sched.h   |  2 +-
 .../selftests/kvm/lib/riscv/handlers.S        |  4 -
 .../selftests/powerpc/include/instructions.h  |  2 +-
 .../selftests/vDSO/vgetrandom-chacha.S        |  2 -
 803 files changed, 1831 insertions(+), 1837 deletions(-)

-- 
2.48.1



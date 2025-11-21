Return-Path: <linux-arch+bounces-14997-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66114C785E8
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 11:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 059014EEC46
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 10:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C82DE6EF;
	Fri, 21 Nov 2025 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9lY26Ih"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C522248B9
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719263; cv=none; b=Gdf+gTtH8cMORZIuHoTmRxCZe9oVTDo8e1GeoOXzhhxgNGRui0n2H35yB6JozJATdnCIOw9gOcZN4UzIBBtAvd4mFpWAXGBp0PQXVEGhXVX/cW8d9xJwL7+uMCFo6Xgb1qeJESSroniMUeCm4f/nKXPspZAXfzUETNtBFI6bIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719263; c=relaxed/simple;
	bh=tEgSZvFijDEsSKDlHZkHTfovTwlrn3LypySy+/kDsPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sd8dQthOBjYo4PyUavv4Oo5Sj3BnM39R+N0dQgiNip2JzkpzgBOJR3Tp/+V0moNfYkXh+dhQ6HmyP+OHT9jOV4hwWlWgTjVtwu5Y3d6a98vWCMr6F+Dx+cm+YA9/rDhPJHH7WYYdKZY2d4MvuSUihAcDx+gIlTNfr3ySYaLls4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9lY26Ih; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763719260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=95i1p9owPsncEna8IT6dFRMEiBK6JP9W4qSsbGs/sRs=;
	b=I9lY26IhaZEu7UFcipkgZ1ECjhJ6VT9Ens1LmovCtk2m1rY2YzZZyiLiWRueVW+z+76zTW
	8P+Na1pMxPL2dvcu5oyQ8YDICYIjhpoSjrGCissv4BVfdx8qkYbv9qrnlly254KhpXPFn/
	D0IGYHCvRf/VIFRjZ3P0lj+IfciRJPM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-3nTmsyRbM6qtk_GlSnfP7w-1; Fri,
 21 Nov 2025 05:00:58 -0500
X-MC-Unique: 3nTmsyRbM6qtk_GlSnfP7w-1
X-Mimecast-MFC-AGG-ID: 3nTmsyRbM6qtk_GlSnfP7w_1763719257
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C176B195609F;
	Fri, 21 Nov 2025 10:00:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08D6B1955F66;
	Fri, 21 Nov 2025 10:00:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 0/9] treewide: Replace __ASSEMBLY__ with __ASSEMBLER__ in header files
Date: Fri, 21 Nov 2025 11:00:35 +0100
Message-ID: <20251121100044.282684-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

 Hi Arnd!

Could you please help to get the remaining patches of this macro
renaming series merged? I already got most patches from the initial
version merged through the architecture specific trees (thanks to every
maintainer who helped me here!), but for alpha and arm 32-bit, I did
not manage to get the attention of the maintainers. Hexagon got an
Acked-by by Brian, but the patches did not get merged yet.

Anyway, original patch series description follows:

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

v4:
- Most patches from the original series got already merged via the
  tree of the individual architectures, so the amount of patches here
  has been greatly reduced
- Rebased patches on top of linux-next, fixed conflicts and new
  occurances

Thomas Huth (9):
  alpha: Replace __ASSEMBLY__ with __ASSEMBLER__ in the alpha headers
  arm: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  arm: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  hexagon: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  hexagon: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  uapi: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  include: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
  x86/headers: Replace __ASSEMBLY__ stragglers with __ASSEMBLER__
  treewide: Stop defining __ASSEMBLY__ for assembler files

 Documentation/dev-tools/checkuapi.rst          |  2 +-
 Makefile                                       |  2 +-
 arch/alpha/include/asm/console.h               |  4 ++--
 arch/alpha/include/asm/page.h                  |  4 ++--
 arch/alpha/include/asm/pal.h                   |  4 ++--
 arch/alpha/include/asm/thread_info.h           |  8 ++++----
 arch/arm/include/asm/arch_gicv3.h              |  4 ++--
 arch/arm/include/asm/assembler.h               |  2 +-
 arch/arm/include/asm/barrier.h                 |  4 ++--
 arch/arm/include/asm/cache.h                   |  2 +-
 arch/arm/include/asm/cp15.h                    |  4 ++--
 arch/arm/include/asm/cputype.h                 |  4 ++--
 arch/arm/include/asm/current.h                 |  4 ++--
 arch/arm/include/asm/delay.h                   |  4 ++--
 arch/arm/include/asm/domain.h                  |  8 ++++----
 arch/arm/include/asm/fpstate.h                 |  2 +-
 arch/arm/include/asm/ftrace.h                  |  6 +++---
 arch/arm/include/asm/hardware/cache-b15-rac.h  |  2 +-
 arch/arm/include/asm/hardware/cache-l2x0.h     |  4 ++--
 arch/arm/include/asm/hardware/dec21285.h       |  2 +-
 arch/arm/include/asm/hardware/ioc.h            |  2 +-
 arch/arm/include/asm/hardware/iomd.h           |  4 ++--
 arch/arm/include/asm/hardware/memc.h           |  2 +-
 arch/arm/include/asm/hwcap.h                   |  2 +-
 arch/arm/include/asm/irq.h                     |  2 +-
 arch/arm/include/asm/jump_label.h              |  4 ++--
 arch/arm/include/asm/kexec.h                   |  4 ++--
 arch/arm/include/asm/kgdb.h                    |  4 ++--
 arch/arm/include/asm/mach/arch.h               |  2 +-
 arch/arm/include/asm/mcpm.h                    |  4 ++--
 arch/arm/include/asm/memory.h                  |  4 ++--
 arch/arm/include/asm/mpu.h                     |  4 ++--
 arch/arm/include/asm/opcodes.h                 | 12 ++++++------
 arch/arm/include/asm/page.h                    |  4 ++--
 arch/arm/include/asm/pgtable-2level.h          |  4 ++--
 arch/arm/include/asm/pgtable-3level.h          |  4 ++--
 arch/arm/include/asm/pgtable-nommu.h           |  4 ++--
 arch/arm/include/asm/pgtable.h                 | 10 +++++-----
 arch/arm/include/asm/probes.h                  |  4 ++--
 arch/arm/include/asm/proc-fns.h                |  4 ++--
 arch/arm/include/asm/ptrace.h                  |  4 ++--
 arch/arm/include/asm/system_info.h             |  4 ++--
 arch/arm/include/asm/system_misc.h             |  4 ++--
 arch/arm/include/asm/thread_info.h             |  2 +-
 arch/arm/include/asm/thread_notify.h           |  2 +-
 arch/arm/include/asm/tlbflush.h                | 10 +++++-----
 arch/arm/include/asm/tls.h                     |  4 ++--
 arch/arm/include/asm/unified.h                 |  6 +++---
 arch/arm/include/asm/unwind.h                  |  4 ++--
 arch/arm/include/asm/v7m.h                     |  4 ++--
 arch/arm/include/asm/vdso.h                    |  4 ++--
 arch/arm/include/asm/vdso/cp15.h               |  4 ++--
 arch/arm/include/asm/vdso/gettimeofday.h       |  4 ++--
 arch/arm/include/asm/vdso/processor.h          |  4 ++--
 arch/arm/include/asm/vdso/vsyscall.h           |  4 ++--
 arch/arm/include/asm/vfp.h                     |  2 +-
 arch/arm/include/asm/virt.h                    |  4 ++--
 arch/arm/include/uapi/asm/ptrace.h             |  4 ++--
 arch/arm/mach-at91/pm.h                        |  2 +-
 arch/arm/mach-exynos/smc.h                     |  4 ++--
 .../mach-footbridge/include/mach/hardware.h    |  2 +-
 arch/arm/mach-imx/hardware.h                   |  2 +-
 arch/arm/mach-imx/mxc.h                        |  2 +-
 arch/arm/mach-omap2/control.h                  |  8 ++++----
 arch/arm/mach-omap2/soc.h                      |  4 ++--
 arch/arm/mach-omap2/sram.h                     |  4 ++--
 arch/arm/mach-pxa/irqs.h                       |  2 +-
 arch/arm/mach-pxa/pxa-regs.h                   |  2 +-
 arch/arm/mach-s3c/map-base.h                   |  2 +-
 arch/arm/mach-sa1100/include/mach/bitfield.h   |  2 +-
 arch/arm/mach-sa1100/include/mach/hardware.h   |  2 +-
 arch/arm/mach-tegra/reset.h                    |  2 +-
 arch/arm/mach-tegra/sleep.h                    |  2 +-
 arch/arm/tools/gen-mach-types                  |  2 +-
 arch/arm64/kernel/vdso32/Makefile              |  1 -
 arch/hexagon/include/asm/hexagon_vm.h          |  4 ++--
 arch/hexagon/include/asm/mem-layout.h          |  6 +++---
 arch/hexagon/include/asm/page.h                |  4 ++--
 arch/hexagon/include/asm/processor.h           |  4 ++--
 arch/hexagon/include/asm/thread_info.h         | 12 ++++++------
 arch/hexagon/include/uapi/asm/registers.h      |  4 ++--
 arch/loongarch/vdso/Makefile                   |  2 +-
 arch/mips/boot/compressed/Makefile             |  2 +-
 arch/mips/vdso/Makefile                        |  2 +-
 arch/powerpc/boot/Makefile                     |  2 +-
 arch/powerpc/platforms/cell/spufs/Makefile     |  2 +-
 arch/s390/Makefile                             |  2 +-
 arch/x86/boot/Makefile                         |  2 +-
 arch/x86/boot/compressed/Makefile              |  2 +-
 arch/x86/include/asm/irqflags.h                |  4 ++--
 arch/x86/include/asm/percpu.h                  |  2 +-
 arch/x86/include/asm/runtime-const.h           |  6 +++---
 arch/x86/realmode/rm/Makefile                  |  2 +-
 arch/xtensa/kernel/Makefile                    |  2 +-
 drivers/firmware/efi/libstub/Makefile          |  2 +-
 drivers/memory/emif.h                          |  4 ++--
 drivers/net/wan/Makefile                       |  2 +-
 include/asm-generic/barrier.h                  |  4 ++--
 include/asm-generic/bug.h                      |  4 ++--
 include/asm-generic/current.h                  |  2 +-
 include/asm-generic/error-injection.h          |  2 +-
 include/asm-generic/fixmap.h                   |  4 ++--
 include/asm-generic/getorder.h                 |  4 ++--
 include/asm-generic/int-ll64.h                 |  6 +++---
 include/asm-generic/kprobes.h                  |  4 ++--
 include/asm-generic/memory_model.h             |  4 ++--
 include/asm-generic/mmu.h                      |  2 +-
 include/asm-generic/pgtable-nop4d.h            |  4 ++--
 include/asm-generic/pgtable-nopmd.h            |  4 ++--
 include/asm-generic/pgtable-nopud.h            |  4 ++--
 include/asm-generic/rwonce.h                   |  4 ++--
 include/asm-generic/signal.h                   |  4 ++--
 include/asm-generic/vdso/vsyscall.h            |  4 ++--
 include/linux/amba/serial.h                    |  4 ++--
 include/linux/annotate.h                       | 18 +++++++++---------
 include/linux/arm-smccc.h                      | 10 +++++-----
 include/linux/bitmap.h                         |  4 ++--
 include/linux/bits.h                           |  6 +++---
 include/linux/cfi_types.h                      |  6 +++---
 include/linux/compiler.h                       |  4 ++--
 include/linux/compiler_types.h                 |  4 ++--
 include/linux/edd.h                            |  4 ++--
 include/linux/err.h                            |  2 +-
 include/linux/export.h                         |  2 +-
 include/linux/init.h                           |  6 +++---
 include/linux/ioport.h                         |  4 ++--
 include/linux/irqchip/arm-gic-v3.h             |  2 +-
 include/linux/irqchip/arm-gic.h                |  4 ++--
 include/linux/jump_label.h                     | 10 +++++-----
 include/linux/kexec.h                          |  2 +-
 include/linux/linkage.h                        |  6 +++---
 include/linux/mem_encrypt.h                    |  4 ++--
 include/linux/mmzone.h                         |  4 ++--
 include/linux/objtool.h                        |  8 ++++----
 include/linux/objtool_types.h                  |  4 ++--
 include/linux/of_fdt.h                         |  4 ++--
 include/linux/pe.h                             |  4 ++--
 include/linux/percpu-defs.h                    |  4 ++--
 include/linux/pfn.h                            |  2 +-
 include/linux/pgtable.h                        |  4 ++--
 include/linux/platform_data/emif_plat.h        |  4 ++--
 include/linux/serial_s3c.h                     |  4 ++--
 include/linux/static_call_types.h              |  4 ++--
 include/linux/ti-emif-sram.h                   |  2 +-
 include/linux/types.h                          |  4 ++--
 include/soc/imx/cpu.h                          |  2 +-
 include/soc/tegra/flowctrl.h                   |  4 ++--
 include/soc/tegra/fuse.h                       |  4 ++--
 include/uapi/asm-generic/int-l64.h             |  4 ++--
 include/uapi/asm-generic/int-ll64.h            |  4 ++--
 include/uapi/asm-generic/signal-defs.h         |  2 +-
 include/uapi/asm-generic/signal.h              |  4 ++--
 include/uapi/linux/a.out.h                     |  4 ++--
 include/uapi/linux/const.h                     |  4 ++--
 include/uapi/linux/edd.h                       |  4 ++--
 include/uapi/linux/hdlc/ioctl.h                |  4 ++--
 include/uapi/linux/sched.h                     |  2 +-
 include/uapi/linux/types.h                     |  4 ++--
 include/vdso/datapage.h                        |  6 +++---
 include/vdso/helpers.h                         |  4 ++--
 include/vdso/processor.h                       |  4 ++--
 include/vdso/vsyscall.h                        |  4 ++--
 include/xen/arm/interface.h                    |  2 +-
 include/xen/interface/xen-mca.h                |  4 ++--
 include/xen/interface/xen.h                    |  8 ++++----
 scripts/Makefile.build                         |  2 +-
 scripts/gfp-translate                          |  2 +-
 tools/include/asm-generic/barrier.h            |  4 ++--
 tools/include/asm/alternative.h                |  2 +-
 tools/include/linux/bits.h                     |  6 +++---
 tools/include/linux/cfi_types.h                |  6 +++---
 tools/include/linux/compiler.h                 |  4 ++--
 tools/include/linux/objtool_types.h            |  4 ++--
 tools/include/linux/static_call_types.h        |  4 ++--
 tools/include/uapi/linux/const.h               |  4 ++--
 .../trace/beauty/include/uapi/linux/sched.h    |  2 +-
 .../testing/selftests/kvm/lib/riscv/handlers.S |  4 ----
 .../testing/selftests/vDSO/vgetrandom-chacha.S |  2 --
 178 files changed, 342 insertions(+), 349 deletions(-)

-- 
2.51.1



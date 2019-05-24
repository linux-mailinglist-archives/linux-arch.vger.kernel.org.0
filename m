Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A57A295A3
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2019 12:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbfEXKZm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 May 2019 06:25:42 -0400
Received: from foss.arm.com ([217.140.101.70]:39104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389616AbfEXKZm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 May 2019 06:25:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DD1B15A2;
        Fri, 24 May 2019 03:25:41 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6EB33F703;
        Fri, 24 May 2019 03:25:38 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Andrew Jones <drjones@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Sudakshina Das <sudi.das@arm.com>,
        Paul Elliott <paul.elliott@arm.com>
Subject: [PATCH 0/8] arm64: ARMv8.5-A: Branch Target Identification support
Date:   Fri, 24 May 2019 11:25:25 +0100
Message-Id: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch implements support for ARMv8.5-A Branch Target Identification
(BTI), which is a control flow integrity protection feature introduced
as part of the ARMv8.5-A extensions [1].

The series is based on v5.2-rc1.

Patch 1 is from Yu-Cheng Yu of Intel, providing generic support
for parsing the ELF NT_GNU_PROPERTY_TYPE_0 note.  It makes sense to
share this mechanism with x86 rather than reinventing it.


Various things need nailing down before this can be upstreamable:

 * Not tested with hugepages yet.  (If anyone has any suggestions about
   how best to do that, please shout!)

 * The NT_GNU_PROPERTY_TYPE_0 ELF note parsing support is not upstream
   yet and may be subject to further change.

Todo:

 * Add BTI protection in the vDSO, so that user code can no longer
   jump to random locations in there.  Lack of this protection doesn't
   break anything, however.


Tested on the ARM Fast Model.

Notes:

 * GCC 9 can compile backwards-compatible BTI-enabled code with
   -mbranch-protection=bti or -mbranch-protection=standard.

 * Binutils trunk supports the new ELF note, but this isn't in a release
   yet.

   Creation of a BTI-enabled binary requires _everything_ linked in to
   be BTI-enabled.  For now ld --force-bti can be used to override this,
   but some things may break until the required C library support is in
   place.

   There is no straightforward way to mark a .s file as BTI-enabled:
   scraping the output from gcc -S works as a quick hack for now.

   readelf -n can be used to examing the program properties in an ELF
   file.

 * Runtime mmap() and mprotect() can be used to enable BTI on a
   page-by-page basis using the new PROT_BTI_GUARDED, but the code in
   the affected pages still needs to be written or compiled to contain
   the appopriate BTI landing pads.


Dave Martin (7):
  mm: Reserve asm-generic prot flag 0x10 for arch use
  arm64: docs: cpu-feature-registers: Document ID_AA64PFR1_EL1
  arm64: Basic Branch Target Identification support
  elf: Parse program properties before destroying the old process
  elf: Allow arch to tweak initial mmap prot flags
  arm64: elf: Enable BTI at exec based on ELF program properties
  arm64: BTI: Decode BYTPE bits when printing PSTATE

Yu-cheng Yu (1):
  binfmt_elf: Extract .note.gnu.property from an ELF file

 Documentation/arm64/cpu-feature-registers.txt |  18 +-
 Documentation/arm64/elf_hwcaps.txt            |   4 +
 arch/arm64/Kconfig                            |  26 ++
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |   6 +
 arch/arm64/include/asm/elf.h                  |  28 ++
 arch/arm64/include/asm/esr.h                  |   2 +-
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/mman.h                 |  33 +++
 arch/arm64/include/asm/pgtable-hwdef.h        |   1 +
 arch/arm64/include/asm/pgtable.h              |   2 +-
 arch/arm64/include/asm/ptrace.h               |   3 +
 arch/arm64/include/asm/sysreg.h               |   2 +
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/include/uapi/asm/mman.h            |   9 +
 arch/arm64/include/uapi/asm/ptrace.h          |   1 +
 arch/arm64/kernel/cpufeature.c                |  17 ++
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/entry.S                     |  11 +
 arch/arm64/kernel/process.c                   |  64 ++++-
 arch/arm64/kernel/ptrace.c                    |   2 +-
 arch/arm64/kernel/signal.c                    |   5 +
 arch/arm64/kernel/syscall.c                   |   1 +
 arch/arm64/kernel/traps.c                     |   7 +
 fs/Kconfig.binfmt                             |   7 +
 fs/Makefile                                   |   1 +
 fs/binfmt_elf.c                               |  31 ++-
 fs/gnu_property.c                             | 363 ++++++++++++++++++++++++++
 include/linux/elf.h                           |  32 +++
 include/linux/mm.h                            |   3 +
 include/uapi/asm-generic/mman-common.h        |   1 +
 include/uapi/linux/elf.h                      |  14 +
 32 files changed, 684 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/include/asm/mman.h
 create mode 100644 arch/arm64/include/uapi/asm/mman.h
 create mode 100644 fs/gnu_property.c

-- 
2.1.4


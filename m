Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E87AD309F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfJJSou (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 14:44:50 -0400
Received: from foss.arm.com ([217.140.110.172]:38218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfJJSou (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 14:44:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF0FF28;
        Thu, 10 Oct 2019 11:44:49 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E14733F703;
        Thu, 10 Oct 2019 11:44:46 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Sudakshina Das <sudi.das@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/12] arm64: ARMv8.5-A: Branch Target Identification support
Date:   Thu, 10 Oct 2019 19:44:28 +0100
Message-Id: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch implements support for ARMv8.5-A Branch Target Identification
(BTI), which is a control flow integrity protection feature introduced
as part of the ARMv8.5-A extensions.

The series is based on v5.4-rc2.

A branch for this series is available in Git [4].

This series supersedes the previous posting [1], and also incorporates
my proposed ELF GNU property parsing implementation, previously posted
separately [2] (see [3] for the ABI spec describing
NT_GNU_PROPERTY_TYPE_0).

Changes:

 * Mostly minor cleanups, renaming of #defines, renumbering of HWCAPs
   that lost the race for upstream etc.

   See the individual patches for details.


Potential open issues:

 * Not tested with hugepages yet.  (If anyone has any suggestions about
   how best to do that, please shout!)

   Possibly this series is missing some hugepage related #define updates
   to allow the GP bit to be taken into account when merging/shattering
   hugepages -- anyone who understands this stuff, please comment :)

 * The VM_ARM64_BTI flag (i.e., the intenal vma flag corresponding to
   PROT_BTI) currently reads out in /proc/<pid>/smaps as the generic
   string "ar".  Perhaps we should have a dedicated string for this,
   and/or use a dedicated VM_HIGH_ARCH_BIT_* flag instead of VM_ARCH_1.

 * This series does not add BTI protection in the vDSO, so user code can
   still jump to random locations in there via function pointers.  This
   doesn't break anything, but it would be a good idea to close it down,
   to minimise the number of potentially accessible JOP gadgets for
   userspace.

   This could be added in a later patch.

Tested on the ARM Fast Model.

Notes:

 * GCC 9 can compile backwards-compatible BTI-enabled code with
   -mbranch-protection=bti or -mbranch-protection=standard.

 * Binutils trunk supports the new ELF note, but this wasn't in a release
   the last time I posted this series.  (The situation _might_ have changed
   in the meantime...)

   Creation of a BTI-enabled binary requires _everything_ linked in to
   be BTI-enabled.  For now ld --force-bti can be used to override this,
   but some things may break until the required C library support is in
   place.

   There is no straightforward way to mark a .s file as BTI-enabled:
   scraping the output from gcc -S works as a quick hack for now.

   readelf -n can be used to examing the program properties in an ELF
   file.

 * Runtime mmap() and mprotect() can be used to enable BTI on a
   page-by-page basis using the new PROT_BTI, but the code in the
   affected pages still needs to be written or compiled to contain the
   appopriate BTI landing pads.


[1] [PATCH 0/8] arm64: ARMv8.5-A: Branch Target Identification support
https://lore.kernel.org/linux-arm-kernel/1558693533-13465-1-git-send-email-Dave.Martin@arm.com/

[2] [RFC PATCH v2 0/2] ELF: Alternate program property parser
https://lore.kernel.org/lkml/1566581020-9953-1-git-send-email-Dave.Martin@arm.com/

[3] Linux Extensions to gABI
https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI

[4] Git branch:
git://linux-arm.org/linux-dm.git arm64/bti/v2/head
http://linux-arm.org/git?p=linux-dm.git;a=shortlog;h=refs/heads/arm64/bti/v2/head


Dave Martin (12):
  ELF: UAPI and Kconfig additions for ELF program properties
  ELF: Add ELF program property parsing support
  mm: Reserve asm-generic prot flag 0x10 for arch use
  arm64: docs: cpu-feature-registers: Document ID_AA64PFR1_EL1
  arm64: Basic Branch Target Identification support
  elf: Allow arch to tweak initial mmap prot flags
  arm64: elf: Enable BTI at exec based on ELF program properties
  arm64: BTI: Decode BYTPE bits when printing PSTATE
  arm64: traps: Fix inconsistent faulting instruction skipping
  arm64: traps: Shuffle code to eliminate forward declarations
  arm64: BTI: Reset BTYPE when skipping emulated instructions
  KVM: arm64: BTI: Reset BTYPE when skipping emulated instructions

 Documentation/arm64/cpu-feature-registers.rst |  17 ++-
 Documentation/arm64/elf_hwcaps.rst            |   4 +
 arch/arm64/Kconfig                            |  26 +++++
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |   6 ++
 arch/arm64/include/asm/elf.h                  |  50 +++++++++
 arch/arm64/include/asm/esr.h                  |   2 +-
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/kvm_emulate.h          |   4 +-
 arch/arm64/include/asm/mman.h                 |  33 ++++++
 arch/arm64/include/asm/pgtable-hwdef.h        |   1 +
 arch/arm64/include/asm/pgtable.h              |   2 +-
 arch/arm64/include/asm/ptrace.h               |   8 ++
 arch/arm64/include/asm/sysreg.h               |   4 +
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/include/uapi/asm/mman.h            |   9 ++
 arch/arm64/include/uapi/asm/ptrace.h          |   1 +
 arch/arm64/kernel/cpufeature.c                |  33 ++++++
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/entry.S                     |  11 ++
 arch/arm64/kernel/process.c                   |  36 ++++++-
 arch/arm64/kernel/ptrace.c                    |   2 +-
 arch/arm64/kernel/signal.c                    |   5 +
 arch/arm64/kernel/syscall.c                   |  18 ++++
 arch/arm64/kernel/traps.c                     | 126 +++++++++++-----------
 fs/Kconfig.binfmt                             |   6 ++
 fs/binfmt_elf.c                               | 145 ++++++++++++++++++++++++--
 fs/compat_binfmt_elf.c                        |   4 +
 include/linux/elf.h                           |  43 ++++++++
 include/linux/mm.h                            |   3 +
 include/uapi/asm-generic/mman-common.h        |   1 +
 include/uapi/linux/elf.h                      |  11 ++
 32 files changed, 539 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm64/include/asm/mman.h
 create mode 100644 arch/arm64/include/uapi/asm/mman.h

-- 
2.1.4


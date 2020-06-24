Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D243207AD3
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 19:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405846AbgFXRwt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 13:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405615AbgFXRwt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 13:52:49 -0400
Received: from localhost.localdomain (unknown [2.26.170.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC19B2077D;
        Wed, 24 Jun 2020 17:52:45 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 00/25] arm64: Memory Tagging Extension user-space support
Date:   Wed, 24 Jun 2020 18:52:19 +0100
Message-Id: <20200624175244.25837-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the 5th version (4th version here [1]) of the series adding
user-space support for the ARMv8.5 Memory Tagging Extension ([2], [3]).
The patches are also available on this branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux devel/mte-v5

There are no user ABI changes from v4 and I do not anticipate further
updates affecting the ABI. Subsequent ABI improvements, if needed, will
be done in a backwards-compatible manner. The glibc counterpart is also
under discussion [4].

My plan is to push these patches into linux-next for wider coverage,
with an aim for merging into 5.9 unless major reworking is needed. I
would be grateful if mm folks review/ack/nak those patches touching mm/
(and, of course, any other patch in this series, feedback always
welcomed). Thank you.

Changes in this version:

- Removed the Device Tree memory node description requirement after
  agreement with the hardware architects that the CPUID should reflect
  the features supported by the general purpose memory.

- Dropped the command line argument to disable MTE at boot in the
  absence of a strong argument in its favour.

- Fixed handling of compound pages (inadvertently clearing valid tags in
  previously mapped small pages).

- Some reworking of the copy_{user,}highpage() functions.

- Rebased to 5.8-rc2

[1] https://lore.kernel.org/linux-arm-kernel/20200515171612.1020-1-catalin.marinas@arm.com/
[2] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
[3] https://developer.arm.com/-/media/Arm%20Developer%20Community/PDF/Arm_Memory_Tagging_Extension_Whitepaper.pdf
[4] https://sourceware.org/pipermail/libc-alpha/2020-June/115039.html

Catalin Marinas (13):
  arm64: mte: Use Normal Tagged attributes for the linear map
  arm64: mte: Clear the tags when a page is mapped in user-space with
    PROT_MTE
  arm64: Avoid unnecessary clear_user_page() indirection
  arm64: mte: Tags-aware aware memcmp_pages() implementation
  arm64: mte: Add PROT_MTE support to mmap() and mprotect()
  mm: Introduce arch_validate_flags()
  arm64: mte: Validate the PROT_MTE request via arch_validate_flags()
  mm: Allow arm64 mmap(PROT_MTE) on RAM-based files
  arm64: mte: Allow user control of the tag check mode via prctl()
  arm64: mte: Allow user control of the generated random tags via
    prctl()
  arm64: mte: Restore the GCR_EL1 register after a suspend
  arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS support
  fs: Handle intra-page faults in copy_mount_options()

Kevin Brodsky (1):
  mm: Introduce arch_calc_vm_flag_bits()

Steven Price (4):
  mm: Add PG_ARCH_2 page flag
  mm: Add arch hooks for saving/restoring tags
  arm64: mte: Enable swap of tagged pages
  arm64: mte: Save tags when hibernating

Vincenzo Frascino (7):
  arm64: mte: system register definitions
  arm64: mte: CPU feature detection and initial sysreg configuration
  arm64: mte: Add specific SIGSEGV codes
  arm64: mte: Handle synchronous and asynchronous tag check faults
  arm64: mte: Tags-aware copy_{user_,}highpage() implementations
  arm64: mte: Kconfig entry
  arm64: mte: Add Memory Tagging Extension documentation

 Documentation/arm64/cpu-feature-registers.rst |   2 +
 Documentation/arm64/elf_hwcaps.rst            |   4 +
 Documentation/arm64/index.rst                 |   1 +
 .../arm64/memory-tagging-extension.rst        | 297 ++++++++++++++++
 arch/arm64/Kconfig                            |  29 ++
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |   6 +
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/kvm_arm.h              |   3 +-
 arch/arm64/include/asm/memory.h               |  17 +-
 arch/arm64/include/asm/mman.h                 |  56 ++-
 arch/arm64/include/asm/mte.h                  |  86 +++++
 arch/arm64/include/asm/page.h                 |  19 +-
 arch/arm64/include/asm/pgtable-prot.h         |   2 +
 arch/arm64/include/asm/pgtable.h              |  46 ++-
 arch/arm64/include/asm/processor.h            |   4 +
 arch/arm64/include/asm/sysreg.h               |  61 ++++
 arch/arm64/include/asm/thread_info.h          |   4 +-
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/include/uapi/asm/mman.h            |   1 +
 arch/arm64/include/uapi/asm/ptrace.h          |   4 +
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/cpufeature.c                |  61 ++++
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/entry.S                     |  37 ++
 arch/arm64/kernel/hibernate.c                 | 118 +++++++
 arch/arm64/kernel/mte.c                       | 331 ++++++++++++++++++
 arch/arm64/kernel/process.c                   |  31 +-
 arch/arm64/kernel/ptrace.c                    |   9 +-
 arch/arm64/kernel/signal.c                    |   8 +
 arch/arm64/kernel/suspend.c                   |   4 +
 arch/arm64/kernel/syscall.c                   |  10 +
 arch/arm64/lib/Makefile                       |   2 +
 arch/arm64/lib/mte.S                          | 151 ++++++++
 arch/arm64/mm/Makefile                        |   1 +
 arch/arm64/mm/copypage.c                      |  25 +-
 arch/arm64/mm/dump.c                          |   4 +
 arch/arm64/mm/fault.c                         |   9 +-
 arch/arm64/mm/mmu.c                           |  22 +-
 arch/arm64/mm/mteswap.c                       |  82 +++++
 arch/arm64/mm/proc.S                          |   8 +-
 arch/x86/kernel/signal_compat.c               |   2 +-
 fs/namespace.c                                |  24 +-
 fs/proc/page.c                                |   3 +
 fs/proc/task_mmu.c                            |   4 +
 include/{linux => asm-generic}/pgtable.h      | 222 ++----------
 include/linux/kernel-page-flags.h             |   1 +
 include/linux/mm.h                            |   8 +
 include/linux/mman.h                          |  22 +-
 include/linux/page-flags.h                    |   3 +
 include/linux/pgtable.h                       |  23 ++
 include/trace/events/mmflags.h                |   9 +-
 include/uapi/asm-generic/siginfo.h            |   4 +-
 include/uapi/linux/prctl.h                    |   9 +
 mm/Kconfig                                    |   3 +
 mm/mmap.c                                     |   9 +
 mm/mprotect.c                                 |   6 +
 mm/page_io.c                                  |  10 +
 mm/shmem.c                                    |   9 +
 mm/swapfile.c                                 |   2 +
 mm/util.c                                     |   2 +-
 tools/vm/page-types.c                         |   2 +
 62 files changed, 1704 insertions(+), 235 deletions(-)
 create mode 100644 Documentation/arm64/memory-tagging-extension.rst
 create mode 100644 arch/arm64/include/asm/mte.h
 create mode 100644 arch/arm64/kernel/mte.c
 create mode 100644 arch/arm64/lib/mte.S
 create mode 100644 arch/arm64/mm/mteswap.c
 copy include/{linux => asm-generic}/pgtable.h (85%)


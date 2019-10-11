Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9159D3EC2
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 13:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfJKLvN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 07:51:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:33030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727198AbfJKLvN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24D44B42F;
        Fri, 11 Oct 2019 11:51:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v9 00/28] New macros for assembler symbols
Date:   Fri, 11 Oct 2019 13:50:40 +0200
Message-Id: <20191011115108.12392-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

So this is an updated version (v9) of the series based on comments
provided mostly by Boris and rebased on the top of current tree (quite a
few conflicting changes in assembly happened lately). See respective
patches for changes done in them since the last submission.  Now the
summary:

This series introduces new macros for assembly as was discussed [1]. The
rationale is that now we use several undocumented random macros
collected over time. There are even some defined for different
architectures differently.  In many cases, developers do not know the
difference in semantics between two basic macros END and ENDPROC. But in
this very case, the difference is crucial especially for objtool when
generating e.g. debuginfo for assembly. For this reason, we define a set
of macros with documented meanings and hopefully intuitive names. These
macros greatly support automatic tools working on the generated code
from assembly or on the assembly proper.

The macros are introduced in the first patch of the series. The rest
of patches start using these new macros in x86, converting *all* uses
of the old macros to the new ones throughout the last patch. With
every last user of some old macro, the macro is immediately made
forbidden for x86.

When this settles down, conversion of other architectures can be done
too.

For introduction, documentation, use and examples, please see
Documentation/asm-annotations.rst from the first patch of the series.

[1] https://lkml.kernel.org/r/<20170301093855.GA27152@gmail.com>

Jiri Slaby (28):
  linkage: Introduce new macros for assembler symbols
  x86/asm/suspend: Use SYM_DATA for data
  x86/asm: Annotate relocate_kernel_{32,64}.c
  x86/asm/entry: Annotate THUNKs
  x86/asm: Annotate local pseudo-functions
  x86/asm/crypto: Annotate local functions
  x86/boot: Annotate local functions
  x86/uaccess: Annotate local function
  x86/asm: Annotate aliases
  x86/asm/entry: Annotate interrupt symbols properly
  x86/asm/head: Annotate data appropriately
  x86/boot: Annotate data appropriately
  um: Annotate data appropriately
  xen/pvh: Annotate data appropriately
  x86/asm/purgatory: Start using annotations
  x86/asm: Do not annotate functions by GLOBAL
  x86/asm: Use SYM_INNER_LABEL instead of GLOBAL
  x86/asm/realmode: Use SYM_DATA_* instead of GLOBAL
  x86/asm: Kill the last GLOBAL user and remove the macro
  x86/asm: Make some functions local
  x86/asm/ftrace: Mark function_hook as function
  x86_64/asm: Add ENDs to some functions and relabel with SYM_CODE_*
  x86_64/asm: Change all ENTRY+END to SYM_CODE_*
  x86_64/asm: Change all ENTRY+ENDPROC to SYM_FUNC_*
  x86_32/asm: Add ENDs to some functions and relabel with SYM_CODE_*
  x86_32/asm: Change all ENTRY+END to SYM_CODE_*
  x86_32/asm: Change all ENTRY+ENDPROC to SYM_FUNC_*
  x86/asm: Replace WEAK uses by SYM_INNER_LABEL_ALIGN

 Documentation/asm-annotations.rst            | 216 ++++++++++++++++
 Documentation/index.rst                      |   8 +
 arch/x86/boot/compressed/efi_stub_32.S       |   4 +-
 arch/x86/boot/compressed/efi_thunk_64.S      |  33 +--
 arch/x86/boot/compressed/head_32.S           |  15 +-
 arch/x86/boot/compressed/head_64.S           |  63 ++---
 arch/x86/boot/compressed/mem_encrypt.S       |  11 +-
 arch/x86/boot/copy.S                         |  16 +-
 arch/x86/boot/pmjump.S                       |   8 +-
 arch/x86/crypto/aegis128-aesni-asm.S         |  36 +--
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S      |  12 +-
 arch/x86/crypto/aesni-intel_asm.S            | 114 ++++-----
 arch/x86/crypto/aesni-intel_avx-x86_64.S     |  32 +--
 arch/x86/crypto/blowfish-x86_64-asm_64.S     |  16 +-
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  |  44 ++--
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S |  44 ++--
 arch/x86/crypto/camellia-x86_64-asm_64.S     |  16 +-
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S    |  24 +-
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S    |  32 +--
 arch/x86/crypto/chacha-avx2-x86_64.S         |  12 +-
 arch/x86/crypto/chacha-avx512vl-x86_64.S     |  12 +-
 arch/x86/crypto/chacha-ssse3-x86_64.S        |  16 +-
 arch/x86/crypto/crc32-pclmul_asm.S           |   4 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    |   4 +-
 arch/x86/crypto/crct10dif-pcl-asm_64.S       |   4 +-
 arch/x86/crypto/des3_ede-asm_64.S            |   8 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S    |  12 +-
 arch/x86/crypto/nh-avx2-x86_64.S             |   4 +-
 arch/x86/crypto/nh-sse2-x86_64.S             |   4 +-
 arch/x86/crypto/poly1305-avx2-x86_64.S       |   4 +-
 arch/x86/crypto/poly1305-sse2-x86_64.S       |   8 +-
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S  |  32 +--
 arch/x86/crypto/serpent-avx2-asm_64.S        |  32 +--
 arch/x86/crypto/serpent-sse2-i586-asm_32.S   |   8 +-
 arch/x86/crypto/serpent-sse2-x86_64-asm_64.S |   8 +-
 arch/x86/crypto/sha1_avx2_x86_64_asm.S       |   4 +-
 arch/x86/crypto/sha1_ni_asm.S                |   4 +-
 arch/x86/crypto/sha1_ssse3_asm.S             |   4 +-
 arch/x86/crypto/sha256-avx-asm.S             |   4 +-
 arch/x86/crypto/sha256-avx2-asm.S            |   4 +-
 arch/x86/crypto/sha256-ssse3-asm.S           |   4 +-
 arch/x86/crypto/sha256_ni_asm.S              |   4 +-
 arch/x86/crypto/sha512-avx-asm.S             |   4 +-
 arch/x86/crypto/sha512-avx2-asm.S            |   4 +-
 arch/x86/crypto/sha512-ssse3-asm.S           |   4 +-
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S  |  32 +--
 arch/x86/crypto/twofish-i586-asm_32.S        |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64.S      |   8 +-
 arch/x86/entry/entry_32.S                    | 163 ++++++------
 arch/x86/entry/entry_64.S                    | 105 ++++----
 arch/x86/entry/entry_64_compat.S             |  16 +-
 arch/x86/entry/thunk_32.S                    |   4 +-
 arch/x86/entry/thunk_64.S                    |   7 +-
 arch/x86/entry/vdso/vdso32/system_call.S     |   2 +-
 arch/x86/include/asm/linkage.h               |   4 -
 arch/x86/kernel/acpi/wakeup_32.S             |   9 +-
 arch/x86/kernel/acpi/wakeup_64.S             |  10 +-
 arch/x86/kernel/ftrace_32.S                  |  19 +-
 arch/x86/kernel/ftrace_64.S                  |  42 ++--
 arch/x86/kernel/head_32.S                    |  60 ++---
 arch/x86/kernel/head_64.S                    | 108 ++++----
 arch/x86/kernel/irqflags.S                   |   8 +-
 arch/x86/kernel/relocate_kernel_32.S         |  13 +-
 arch/x86/kernel/relocate_kernel_64.S         |  13 +-
 arch/x86/kernel/verify_cpu.S                 |   4 +-
 arch/x86/kvm/vmx/vmenter.S                   |  12 +-
 arch/x86/lib/atomic64_386_32.S               |   4 +-
 arch/x86/lib/atomic64_cx8_32.S               |  32 +--
 arch/x86/lib/checksum_32.S                   |  16 +-
 arch/x86/lib/clear_page_64.S                 |  12 +-
 arch/x86/lib/cmpxchg16b_emu.S                |   4 +-
 arch/x86/lib/cmpxchg8b_emu.S                 |   4 +-
 arch/x86/lib/copy_page_64.S                  |   8 +-
 arch/x86/lib/copy_user_64.S                  |  21 +-
 arch/x86/lib/csum-copy_64.S                  |   4 +-
 arch/x86/lib/getuser.S                       |  22 +-
 arch/x86/lib/hweight.S                       |   8 +-
 arch/x86/lib/iomap_copy_64.S                 |   4 +-
 arch/x86/lib/memcpy_64.S                     |  20 +-
 arch/x86/lib/memmove_64.S                    |   8 +-
 arch/x86/lib/memset_64.S                     |  16 +-
 arch/x86/lib/msr-reg.S                       |   8 +-
 arch/x86/lib/putuser.S                       |  19 +-
 arch/x86/lib/retpoline.S                     |   4 +-
 arch/x86/math-emu/div_Xsig.S                 |   4 +-
 arch/x86/math-emu/div_small.S                |   4 +-
 arch/x86/math-emu/mul_Xsig.S                 |  12 +-
 arch/x86/math-emu/polynom_Xsig.S             |   4 +-
 arch/x86/math-emu/reg_norm.S                 |   8 +-
 arch/x86/math-emu/reg_round.S                |   4 +-
 arch/x86/math-emu/reg_u_add.S                |   4 +-
 arch/x86/math-emu/reg_u_div.S                |   4 +-
 arch/x86/math-emu/reg_u_mul.S                |   4 +-
 arch/x86/math-emu/reg_u_sub.S                |   4 +-
 arch/x86/math-emu/round_Xsig.S               |   8 +-
 arch/x86/math-emu/shr_Xsig.S                 |   4 +-
 arch/x86/math-emu/wm_shrx.S                  |   8 +-
 arch/x86/math-emu/wm_sqrt.S                  |   4 +-
 arch/x86/mm/mem_encrypt_boot.S               |   8 +-
 arch/x86/platform/efi/efi_stub_32.S          |   4 +-
 arch/x86/platform/efi/efi_stub_64.S          |   4 +-
 arch/x86/platform/efi/efi_thunk_64.S         |  16 +-
 arch/x86/platform/olpc/xo1-wakeup.S          |   3 +-
 arch/x86/platform/pvh/head.S                 |  18 +-
 arch/x86/power/hibernate_asm_32.S            |  14 +-
 arch/x86/power/hibernate_asm_64.S            |  14 +-
 arch/x86/purgatory/entry64.S                 |  21 +-
 arch/x86/purgatory/setup-x86_64.S            |  14 +-
 arch/x86/purgatory/stack.S                   |   7 +-
 arch/x86/realmode/rm/header.S                |   8 +-
 arch/x86/realmode/rm/reboot.S                |  13 +-
 arch/x86/realmode/rm/stack.S                 |  14 +-
 arch/x86/realmode/rm/trampoline_32.S         |  16 +-
 arch/x86/realmode/rm/trampoline_64.S         |  29 ++-
 arch/x86/realmode/rm/trampoline_common.S     |   2 +-
 arch/x86/realmode/rm/wakeup_asm.S            |  15 +-
 arch/x86/realmode/rmpiggy.S                  |  10 +-
 arch/x86/um/vdso/vdso.S                      |   6 +-
 arch/x86/xen/xen-asm.S                       |  28 +--
 arch/x86/xen/xen-asm_32.S                    |   7 +-
 arch/x86/xen/xen-asm_64.S                    |  34 +--
 arch/x86/xen/xen-head.S                      |   8 +-
 include/linux/linkage.h                      | 249 ++++++++++++++++++-
 124 files changed, 1475 insertions(+), 988 deletions(-)
 create mode 100644 Documentation/asm-annotations.rst

-- 
2.23.0


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265D755701D
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 03:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357515AbiFWBvu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 21:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357371AbiFWBvt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 21:51:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2D943AC4;
        Wed, 22 Jun 2022 18:51:47 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LT39h4JVHzkWbN;
        Thu, 23 Jun 2022 09:50:32 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:51:45 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:51:45 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <live-patching@vger.kernel.org>
CC:     <jpoimboe@kernel.org>, <peterz@infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <ndesaulniers@google.com>, <mark.rutland@arm.com>,
        <pasha.tatashin@soleen.com>, <broonie@kernel.org>,
        <chenzhongjin@huawei.com>, <rmk+kernel@armlinux.org.uk>,
        <madvenka@linux.microsoft.com>, <christophe.leroy@csgroup.eu>,
        <daniel.thompson@linaro.org>
Subject: [PATCH v5 00/33] objtool: add base support for arm64
Date:   Thu, 23 Jun 2022 09:48:44 +0800
Message-ID: <20220623014917.199563-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series enables objtool to start doing stack validation and orc
generation on arm64 kernel builds.

Based on Julien's previous work(1)(2), Now I have finished most of work
for objtool enable on arm64. This series includes objtool part [1-13]
and arm64 support part [14-33], the second part is to make objtool run
correctly with no warning on arm64 so if necessary it can be taken apart
as two series.

ORC generation feature is implemented but not used because we don't have
an unwinder_orc on arm64, now it only be used to check whether objtool
has correct validation.

This series depends on series:
"objtool: Reorganize x86 arch-specific code"
(https://lkml.org/lkml/2022/6/22/463)
I moved some changes which work for all architectures to that series
because this one becomes too big now.
And two series are rebased to tip/objtool/core branch:
'commit 22682a07acc3 ("objtool: Fix objtool regression on x32 systems")'

I think the series is complete enough so I removed the RFC.
However now there are still (maybe only) two unsolved problems:

1. the switch optimization and dynamic jump
Although this problem has been troubling us for a long time and
temporarily resolved by -no-jump-table. Hopefully we have chance
to fix it. I'm trying for that and it will be updated in next version.

2. alternative_cb
alternative_cb in arm64 is an dynamic patch mechanism on arm64 which is
similar to alternative instruction but doesn't give instructions explicitly.
It cause trouble when there is a jump instructions inside it and causes some
branch that objtool can't reach.
I have solved some of them by adding UNWIND_HINT one macro
"mitigate_spectre_bhb_loop" can't be fixed because it is used in
different assembly files.

(1) https://lkml.org/lkml/2021/3/3/1135
(2) https://github.com/julien-thierry/linux.git
---
v6 Changes:
Fix conflicts makes patches can't be applied.

v5 Changes:
Compare to last RFC v4 series, this series does a lot of changes, including
code rebase, refactoring and solution for several warning in last series.
After refactoring and moving some patches out, the number of lines in this
series decrease a thousand.

Here are changes for each patch.

[1] Removed unnecessary part from insn.h and insn.c to avoid extra
dependencies and wired hack. So the patch to add head files also be removed.

[2] Rebase Makefile, clear sync-check for insn.h/c and add arm64 elf
relocation types in elf.h.
Remove other callee saved registers tracking except FP and LR. Beacause
in arm64 there are lots of branches store these CSRs in different order
or positions, tracking them will cause some false stack state mismatch
warnings.

[3-6] Refactor code. Add some macros to make code more clean.
For instructions load/store on stack, Simplifies the logic of moving SP
and accessing data because the order of ops makes no differences.

[7-8] Remove delete in record_invalid_insn because now we don't need to
handle special undecoded instructions.

[13] New patch to enable ORC generation.

[12, 14, 17] Rebase to current branch.

[19-21] Add annotations for trans_pgd-asm.S and some unreachable
branches.

[29] Moves kuser32.S and sigreturn32.S to rodata because they are VDSO.

[31] Remove ignores for hibernate.c.

[33] New patch to fix a fallthrough problem.

v4 Changes:
- fix EX_ENTRY_SIZE from 8 to 12.
- modify arm64 for supporting objtool, including annotation,
	asm code modification, ignoring some validation, to make objtool
	be enable to pass arm64 builds.

v3 Changes:
- rebase Julien's version to mainstream and solve conflicts.
- Merge dumplicate "*type = INSN_OTHER".
- When meeting unrecognized instructions such as datas
	in .text code or 0x0 padding insns, last version used
	"loc->ignorable" to mark and remove them from objtool insn list.

	However there are two problems to do so:
	1. when meeting insns can't be decoded or excluded, objtool will
	just stop.
	
	2. deleting every insn can cause problems in fellow procedure.

	So I changed "record_invalid_insn" that we can delete one insn or
	just set it ignored. Now check will throw an error and going on when
	meeting undecodable instructions.

	Also, to prevent the confusion between "loc->ignorable" and
	"insn->ignore" I changed "ignore" to "delete".

v2 Changes:
	- Drop gcc plugin in favor of -fno-jump-tables
	- miscelaneous fixes and cleanups
___

Chen Zhongjin (33):
  tools: arm64: Make aarch64 instruction decoder available to tools
  objtool: arm64: Add base definition for arm64 backend
  objtool: arm64: Decode add/sub instructions
  objtool: arm64: Decode jump and call related instructions
  objtool: arm64: Decode other system instructions
  objtool: arm64: Decode load/store instructions
  objtool: arm64: Decode LDR instructions
  objtool: arm64: Accept non-instruction data in code sections
  objtool: check: Support data in text section
  objtool: arm64: Handle supported relocations in alternatives
  objtool: arm64: Ignore replacement section for alternative callback
  objtool: arm64: Enable stack validation for arm64
  objtool: arm64: Enable ORC for arm64
  objtool: arm64: Add annotate_reachable() for objtools
  arm64: bug: Add reachable annotation to warning macros
  arm64: kgdb: Add reachable annotation after kgdb brk
  objtool: arm64: Add unwind_hint support
  arm64: Change symbol type annotations
  arm64: Annotate unwind_hint for symbols with empty stack
  arm64: entry: Annotate unwind_hint for entry
  arm64: kvm: Annotate unwind_hint for hyp entry
  arm64: efi-header: Mark efi header as data
  arm64: head: Mark constants as data
  arm64: proc: Mark constant as data
  arm64: crypto: Mark constant as data
  arm64: crypto: Remove unnecessary stackframe
  arm64: Set intra-function call annotations
  arm64: sleep: Properly set frame pointer before call
  arm64: compat: Move VDSO code to .rodata section
  arm64: entry: Align stack size for alternative
  arm64: kernel: Skip validation of proton-pack.c
  arm64: irq-gic: Replace unreachable() with -EINVAL
  objtool: revert c_file fallthrough detection for arm64

 arch/arm64/Kconfig                            |   2 +
 arch/arm64/Kconfig.debug                      |  31 ++
 arch/arm64/Makefile                           |   4 +
 arch/arm64/crypto/aes-neonbs-core.S           |  14 +-
 arch/arm64/crypto/crct10dif-ce-core.S         |   5 +
 arch/arm64/crypto/poly1305-armv8.pl           |   4 +
 arch/arm64/crypto/sha512-armv8.pl             |  29 +-
 arch/arm64/include/asm/assembler.h            |   2 +
 arch/arm64/include/asm/bug.h                  |   6 +-
 arch/arm64/include/asm/kgdb.h                 |   1 +
 arch/arm64/include/asm/module.h               |   7 +
 arch/arm64/include/asm/orc_types.h            |  68 +++
 arch/arm64/include/asm/unwind_hints.h         |  26 +
 arch/arm64/kernel/cpu-reset.S                 |   2 +
 arch/arm64/kernel/efi-entry.S                 |   2 +
 arch/arm64/kernel/efi-header.S                |   2 +
 arch/arm64/kernel/entry.S                     |  30 +-
 arch/arm64/kernel/head.S                      |  76 +--
 arch/arm64/kernel/hibernate-asm.S             |   2 +
 arch/arm64/kernel/kuser32.S                   |   1 +
 arch/arm64/kernel/proton-pack.c               |   2 +
 arch/arm64/kernel/relocate_kernel.S           |   2 +
 arch/arm64/kernel/sigreturn32.S               |   1 +
 arch/arm64/kernel/sleep.S                     |   8 +-
 arch/arm64/kernel/vmlinux.lds.S               |   3 +
 arch/arm64/kvm/hyp/entry.S                    |   9 +-
 arch/arm64/kvm/hyp/hyp-entry.S                |   4 +
 arch/arm64/kvm/hyp/vgic-v3-sr.c               |   7 +-
 arch/arm64/mm/proc.S                          |   4 +-
 arch/arm64/mm/trans_pgd-asm.S                 |   3 +
 drivers/irqchip/irq-gic-v3.c                  |   2 +-
 include/linux/compiler.h                      |   9 +
 scripts/Makefile                              |   6 +-
 tools/arch/arm64/include/asm/insn.h           | 458 +++++++++++++++++
 tools/arch/arm64/include/asm/orc_types.h      |  68 +++
 tools/arch/arm64/include/asm/unwind_hints.h   |  26 +
 tools/arch/arm64/lib/insn.c                   | 335 +++++++++++++
 tools/objtool/Makefile                        |   5 +
 tools/objtool/arch/arm64/Build                |   9 +
 tools/objtool/arch/arm64/decode.c             | 465 ++++++++++++++++++
 .../arch/arm64/include/arch/cfi_regs.h        |  14 +
 tools/objtool/arch/arm64/include/arch/elf.h   |  12 +
 .../arch/arm64/include/arch/endianness.h      |   9 +
 .../objtool/arch/arm64/include/arch/special.h |  22 +
 tools/objtool/arch/arm64/orc.c                | 117 +++++
 tools/objtool/arch/arm64/special.c            |  36 ++
 tools/objtool/arch/x86/decode.c               |   5 +
 tools/objtool/check.c                         |  22 +-
 tools/objtool/elf.c                           |  14 +
 tools/objtool/include/objtool/arch.h          |   2 +
 tools/objtool/include/objtool/elf.h           |   1 +
 tools/objtool/include/objtool/objtool.h       |   2 +-
 tools/objtool/objtool.c                       |   1 +
 53 files changed, 1924 insertions(+), 73 deletions(-)
 create mode 100644 arch/arm64/include/asm/orc_types.h
 create mode 100644 arch/arm64/include/asm/unwind_hints.h
 create mode 100644 tools/arch/arm64/include/asm/insn.h
 create mode 100644 tools/arch/arm64/include/asm/orc_types.h
 create mode 100644 tools/arch/arm64/include/asm/unwind_hints.h
 create mode 100644 tools/arch/arm64/lib/insn.c
 create mode 100644 tools/objtool/arch/arm64/Build
 create mode 100644 tools/objtool/arch/arm64/decode.c
 create mode 100644 tools/objtool/arch/arm64/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/elf.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/endianness.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/special.h
 create mode 100644 tools/objtool/arch/arm64/orc.c
 create mode 100644 tools/objtool/arch/arm64/special.c

-- 
2.17.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713F55145C9
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 11:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356742AbiD2JtR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 05:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356763AbiD2Jss (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 05:48:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF55939AB;
        Fri, 29 Apr 2022 02:45:21 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KqSJb5V4tzhYq4;
        Fri, 29 Apr 2022 17:45:03 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:09 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:09 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arch@vger.kernel.org>
CC:     <jthierry@redhat.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <masahiroy@kernel.org>, <jpoimboe@redhat.com>,
        <peterz@infradead.org>, <ycote@redhat.com>,
        <herbert@gondor.apana.org.au>, <mark.rutland@arm.com>,
        <davem@davemloft.net>, <ardb@kernel.org>, <maz@kernel.org>,
        <tglx@linutronix.de>, <luc.vanoostenryck@gmail.com>,
        <chenzhongjin@huawei.com>
Subject: [RFC PATCH v4 00/37] objtool: add base support for arm64
Date:   Fri, 29 Apr 2022 17:43:18 +0800
Message-ID: <20220429094355.122389-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series enables objtool to start doing stack validation/check 
on arm64 kernel builds.

Gathering Julien's previous work[1][2], now objtool can check build
on arm64 build for defconfig and yesconfig, with only few unreachable
warning.

This series includes objtool part (1-15) and arm64 part (16-37), if
necessary it can be taken apart as two series.

I'm not sure that UNWIND_HINT added to entry (33-36) is complete
and correct, because after Julien finished it there was a
refactoring for entry. It will be fully tested after I implement
unwinder_orc for arm64.

[1] https://lkml.org/lkml/2021/3/3/1135
[2] https://github.com/julien-thierry/linux.git

---
Changes v3 -> v4:
- [1] fix EX_ENTRY_SIZE from 8 to 12.
- [14-37] modify arm64 for supporting objtool, including annotation,
	asm code modification, ignoring some validation, to make objtool
	be enable to pass arm64 builds.

Changes v2 -> v3:
- [04] rebase Julien's version to mainstream and solve conflicts.
- [05, 06, 08] Merge dumplicate "*type = INSN_OTHER".
- [08, 09, 10] When meeting unrecognized instructions such as  datas
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

Changes v1 -> v2:
	- Drop gcc plugin in favor of -fno-jump-tables
	- miscelaneous fixes and cleanups

--->
Chen Zhongjin (6):
  arm64: Add annotate_reachable() for objtools
  arm64: irq-gic: Replace unreachable() with -EINVAL
  arm64: ftrace: Skip validation of entry-ftrace.o
  arm64: bpf: Skip validation of ___bpf_prog_run
  arm64: Annotate ASM symbols with unknown stack state
  arm64: entry: Align stack size for alternative

Julien Thierry (29):
  tools: Add some generic functions and headers
  tools: arm64: Make aarch64 instruction decoder available to tools
  tools: bug: Remove duplicate definition
  objtool: arm64: Add base definition for arm64 backend
  objtool: arm64: Decode add/sub instructions
  objtool: arm64: Decode jump and call related instructions
  objtool: arm64: Decode other system instructions
  objtool: arm64: Decode load/store instructions
  objtool: arm64: Decode LDR instructions
  objtool: arm64: Accept non-instruction data in code sections
  objtool: arm64: Handle supported relocations in alternatives
  objtool: arm64: Ignore replacement section for alternative callback
  objtool: check: Support data in text section
  objtool: arm64: Add unwind_hint support
  arm64: bug: Add reachable annotation to warning macros
  arm64: kgdb: Mark code following kgdb brk as reachable
  arm64: Set intra-function call annotations
  arm64: kernel: Skip validation of proton-pack.c.c and hibernate.c
  arm64: kernel: Skip validation of sigreturn32.o
  arm64: crypto: Remove unnecessary stackframe
  arm64: sleep: Properly set frame pointer before call
  arm64: Change symbol annotations
  arm64: efi-header: Mark efi header as data
  arm64: head: Mark constants as data
  arm64: proc: Mark constant as data
  arm64: crypto: Mark data in code sections
  arm64: entry: Annotate valid stack in kernel entry
  arm64: entry: Annotate code switching to tasks
  arm64: kvm: Annotate stack state for guest enter/exit code

Raphael Gault (2):
  objtool: arm64: Enable stack validation for arm64
  arm64: kernel: Skip validation of kuser32.o

 arch/arm64/Kconfig                            |    1 +
 arch/arm64/Makefile                           |    4 +
 arch/arm64/crypto/aes-neonbs-core.S           |   14 +-
 arch/arm64/crypto/crct10dif-ce-core.S         |    5 +
 arch/arm64/crypto/poly1305-armv8.pl           |    4 +
 arch/arm64/crypto/sha512-armv8.pl             |   29 +-
 arch/arm64/include/asm/assembler.h            |    2 +
 arch/arm64/include/asm/bug.h                  |    6 +-
 arch/arm64/include/asm/kgdb.h                 |    1 +
 arch/arm64/include/asm/unwind_hints.h         |   27 +
 arch/arm64/kernel/Makefile                    |   10 +
 arch/arm64/kernel/cpu-reset.S                 |    2 +
 arch/arm64/kernel/efi-entry.S                 |    2 +
 arch/arm64/kernel/efi-header.S                |    2 +
 arch/arm64/kernel/entry.S                     |   29 +-
 arch/arm64/kernel/head.S                      |   75 +-
 arch/arm64/kernel/hibernate-asm.S             |    2 +
 arch/arm64/kernel/hibernate.c                 |    2 +
 arch/arm64/kernel/proton-pack.c               |    2 +
 arch/arm64/kernel/relocate_kernel.S           |    2 +
 arch/arm64/kernel/sleep.S                     |    8 +-
 arch/arm64/kvm/hyp/entry.S                    |    7 +-
 arch/arm64/kvm/hyp/hyp-entry.S                |    3 +
 arch/arm64/kvm/hyp/vgic-v3-sr.c               |    7 +-
 arch/arm64/mm/proc.S                          |    4 +-
 drivers/irqchip/irq-gic-v3.c                  |    2 +-
 include/linux/compiler.h                      |    9 +
 kernel/bpf/core.c                             |    3 +
 tools/arch/arm64/include/asm/insn.h           |  565 +++++++
 tools/arch/arm64/include/asm/unwind_hints.h   |   27 +
 tools/arch/arm64/lib/insn.c                   | 1464 +++++++++++++++++
 tools/include/asm-generic/bitops/__ffs.h      |   11 +
 tools/include/linux/bug.h                     |    6 +-
 tools/include/linux/kernel.h                  |   21 +
 tools/include/linux/printk.h                  |   40 +
 tools/objtool/Makefile                        |    5 +
 tools/objtool/arch/arm64/Build                |    8 +
 tools/objtool/arch/arm64/decode.c             |  506 ++++++
 .../arch/arm64/include/arch/cfi_regs.h        |   14 +
 tools/objtool/arch/arm64/include/arch/elf.h   |    8 +
 .../arch/arm64/include/arch/endianness.h      |    9 +
 .../objtool/arch/arm64/include/arch/special.h |   22 +
 tools/objtool/arch/arm64/special.c            |   36 +
 tools/objtool/arch/x86/decode.c               |    5 +
 tools/objtool/check.c                         |   25 +-
 tools/objtool/elf.c                           |   14 +
 tools/objtool/include/objtool/arch.h          |    3 +
 tools/objtool/include/objtool/elf.h           |    1 +
 tools/objtool/sync-check.sh                   |    5 +
 49 files changed, 2985 insertions(+), 74 deletions(-)
 create mode 100644 arch/arm64/include/asm/unwind_hints.h
 create mode 100644 tools/arch/arm64/include/asm/insn.h
 create mode 100644 tools/arch/arm64/include/asm/unwind_hints.h
 create mode 100644 tools/arch/arm64/lib/insn.c
 create mode 100644 tools/include/linux/printk.h
 create mode 100644 tools/objtool/arch/arm64/Build
 create mode 100644 tools/objtool/arch/arm64/decode.c
 create mode 100644 tools/objtool/arch/arm64/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/elf.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/endianness.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/special.h
 create mode 100644 tools/objtool/arch/arm64/special.c

-- 
2.17.1


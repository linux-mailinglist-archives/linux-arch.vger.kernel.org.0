Return-Path: <linux-arch+bounces-7921-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63162997464
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 20:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280751C20FD2
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 18:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960111E32B7;
	Wed,  9 Oct 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj5W1kBm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B61DFDAB;
	Wed,  9 Oct 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497382; cv=none; b=FEhsPgmQ5qMES/lir6hu+NLzMHyvkAT5CatO76hCZatRa4NYHv8v2GwAYYi+HJ8iyLRZ3KOTBGP3Y/hJK3meoncaopwFR/y7x62dvs0RvmVzsKRIXXdPwxHYYoeVXubkhJe84jPh5u3dJp5raGUinwztY2uLdk1TrdLGBIWdN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497382; c=relaxed/simple;
	bh=jEiSFm6FJn7pRttqD6dzkUS+KBpD8IXjedOPjVAr2yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuYcABRAHQnrrIPASRC2EjfgHdLgwDrVQ6owoxSBPN+Nc0N7A6npin1ervn3gN51wnmvN3xegjSMeyfC+VVeEFu6kcIP5ghhlsRaMBRGAluWLbRvJN/lxpgXKhMLq+4QUZVKAb257VYoqraxqzKdFnJyGJxxSfaFFkBJu1C2SX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj5W1kBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F20BC4CED0;
	Wed,  9 Oct 2024 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497382;
	bh=jEiSFm6FJn7pRttqD6dzkUS+KBpD8IXjedOPjVAr2yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dj5W1kBmf4CwYhgY7A2Zhw8k7XaZHDrqO0Qsmlzrm7Q6S+OMTLWXLQDc4+IjiBRaH
	 S5pyRfhrydw86WfTJ21vLxmzalMAGjfmjS+BqEvH8QOM6OlxqN9J9j1/l+/GEfuzpM
	 iLbQuS05hX0kj2DZ95X9WCdkPVh20oPOTjheJwz9NJJn/ksb8/YQigLIalFHMffjRA
	 USRi2Bf/SLBJWST0pYPr0T9+GE4wDONzdwmuHIDAr6Ux1ZjK/lc8ca+2IPJLSYTOyz
	 m/+AIwZaTyJXjpbykAneEV0eqrlwdZfD/xIvBM8C35vFqUJIYZqdXokPWBKx2YUmpE
	 KEwg3aca9mViw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
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
Subject: [PATCH v5 3/8] asm-generic: introduce text-patching.h
Date: Wed,  9 Oct 2024 21:08:11 +0300
Message-ID: <20241009180816.83591-4-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009180816.83591-1-rppt@kernel.org>
References: <20241009180816.83591-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Several architectures support text patching, but they name the header
files that declare patching functions differently.

Make all such headers consistently named text-patching.h and add an empty
header in asm-generic for architectures that do not support text patching.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/alpha/include/asm/Kbuild                     |  1 +
 arch/arc/include/asm/Kbuild                       |  1 +
 arch/arm/include/asm/{patch.h => text-patching.h} |  0
 arch/arm/kernel/ftrace.c                          |  2 +-
 arch/arm/kernel/jump_label.c                      |  2 +-
 arch/arm/kernel/kgdb.c                            |  2 +-
 arch/arm/kernel/patch.c                           |  2 +-
 arch/arm/probes/kprobes/core.c                    |  2 +-
 arch/arm/probes/kprobes/opt-arm.c                 |  2 +-
 .../include/asm/{patching.h => text-patching.h}   |  0
 arch/arm64/kernel/ftrace.c                        |  2 +-
 arch/arm64/kernel/jump_label.c                    |  2 +-
 arch/arm64/kernel/kgdb.c                          |  2 +-
 arch/arm64/kernel/patching.c                      |  2 +-
 arch/arm64/kernel/probes/kprobes.c                |  2 +-
 arch/arm64/kernel/traps.c                         |  2 +-
 arch/arm64/net/bpf_jit_comp.c                     |  2 +-
 arch/csky/include/asm/Kbuild                      |  1 +
 arch/hexagon/include/asm/Kbuild                   |  1 +
 arch/loongarch/include/asm/Kbuild                 |  1 +
 arch/m68k/include/asm/Kbuild                      |  1 +
 arch/microblaze/include/asm/Kbuild                |  1 +
 arch/mips/include/asm/Kbuild                      |  1 +
 arch/nios2/include/asm/Kbuild                     |  1 +
 arch/openrisc/include/asm/Kbuild                  |  1 +
 .../include/asm/{patch.h => text-patching.h}      |  0
 arch/parisc/kernel/ftrace.c                       |  2 +-
 arch/parisc/kernel/jump_label.c                   |  2 +-
 arch/parisc/kernel/kgdb.c                         |  2 +-
 arch/parisc/kernel/kprobes.c                      |  2 +-
 arch/parisc/kernel/patch.c                        |  2 +-
 arch/powerpc/include/asm/kprobes.h                |  2 +-
 .../asm/{code-patching.h => text-patching.h}      |  0
 arch/powerpc/kernel/crash_dump.c                  |  2 +-
 arch/powerpc/kernel/epapr_paravirt.c              |  2 +-
 arch/powerpc/kernel/jump_label.c                  |  2 +-
 arch/powerpc/kernel/kgdb.c                        |  2 +-
 arch/powerpc/kernel/kprobes.c                     |  2 +-
 arch/powerpc/kernel/module_32.c                   |  2 +-
 arch/powerpc/kernel/module_64.c                   |  2 +-
 arch/powerpc/kernel/optprobes.c                   |  2 +-
 arch/powerpc/kernel/process.c                     |  2 +-
 arch/powerpc/kernel/security.c                    |  2 +-
 arch/powerpc/kernel/setup_32.c                    |  2 +-
 arch/powerpc/kernel/setup_64.c                    |  2 +-
 arch/powerpc/kernel/static_call.c                 |  2 +-
 arch/powerpc/kernel/trace/ftrace.c                |  2 +-
 arch/powerpc/kernel/trace/ftrace_64_pg.c          |  2 +-
 arch/powerpc/lib/code-patching.c                  |  2 +-
 arch/powerpc/lib/feature-fixups.c                 |  2 +-
 arch/powerpc/lib/test-code-patching.c             |  2 +-
 arch/powerpc/lib/test_emulate_step.c              |  2 +-
 arch/powerpc/mm/book3s32/mmu.c                    |  2 +-
 arch/powerpc/mm/book3s64/hash_utils.c             |  2 +-
 arch/powerpc/mm/book3s64/slb.c                    |  2 +-
 arch/powerpc/mm/kasan/init_32.c                   |  2 +-
 arch/powerpc/mm/mem.c                             |  2 +-
 arch/powerpc/mm/nohash/44x.c                      |  2 +-
 arch/powerpc/mm/nohash/book3e_pgtable.c           |  2 +-
 arch/powerpc/mm/nohash/tlb.c                      |  2 +-
 arch/powerpc/mm/nohash/tlb_64e.c                  |  2 +-
 arch/powerpc/net/bpf_jit_comp.c                   |  2 +-
 arch/powerpc/perf/8xx-pmu.c                       |  2 +-
 arch/powerpc/perf/core-book3s.c                   |  2 +-
 arch/powerpc/platforms/85xx/smp.c                 |  2 +-
 arch/powerpc/platforms/86xx/mpc86xx_smp.c         |  2 +-
 arch/powerpc/platforms/cell/smp.c                 |  2 +-
 arch/powerpc/platforms/powermac/smp.c             |  2 +-
 arch/powerpc/platforms/powernv/idle.c             |  2 +-
 arch/powerpc/platforms/powernv/smp.c              |  2 +-
 arch/powerpc/platforms/pseries/smp.c              |  2 +-
 arch/powerpc/xmon/xmon.c                          |  2 +-
 arch/riscv/errata/andes/errata.c                  |  2 +-
 arch/riscv/errata/sifive/errata.c                 |  2 +-
 arch/riscv/errata/thead/errata.c                  |  2 +-
 .../include/asm/{patch.h => text-patching.h}      |  0
 arch/riscv/include/asm/uprobes.h                  |  2 +-
 arch/riscv/kernel/alternative.c                   |  2 +-
 arch/riscv/kernel/cpufeature.c                    |  3 ++-
 arch/riscv/kernel/ftrace.c                        |  2 +-
 arch/riscv/kernel/jump_label.c                    |  2 +-
 arch/riscv/kernel/patch.c                         |  2 +-
 arch/riscv/kernel/probes/kprobes.c                |  2 +-
 arch/riscv/net/bpf_jit_comp64.c                   |  2 +-
 arch/riscv/net/bpf_jit_core.c                     |  2 +-
 arch/sh/include/asm/Kbuild                        |  1 +
 arch/sparc/include/asm/Kbuild                     |  1 +
 arch/um/kernel/um_arch.c                          |  5 +++++
 arch/x86/include/asm/text-patching.h              |  1 +
 arch/xtensa/include/asm/Kbuild                    |  1 +
 include/asm-generic/text-patching.h               |  5 +++++
 include/linux/text-patching.h                     | 15 +++++++++++++++
 92 files changed, 110 insertions(+), 70 deletions(-)
 rename arch/arm/include/asm/{patch.h => text-patching.h} (100%)
 rename arch/arm64/include/asm/{patching.h => text-patching.h} (100%)
 rename arch/parisc/include/asm/{patch.h => text-patching.h} (100%)
 rename arch/powerpc/include/asm/{code-patching.h => text-patching.h} (100%)
 rename arch/riscv/include/asm/{patch.h => text-patching.h} (100%)
 create mode 100644 include/asm-generic/text-patching.h
 create mode 100644 include/linux/text-patching.h

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index 396caece6d6d..483965c5a4de 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -5,3 +5,4 @@ generic-y += agp.h
 generic-y += asm-offsets.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += text-patching.h
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 49285a3ce239..4c69522e0328 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -6,3 +6,4 @@ generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += user.h
+generic-y += text-patching.h
diff --git a/arch/arm/include/asm/patch.h b/arch/arm/include/asm/text-patching.h
similarity index 100%
rename from arch/arm/include/asm/patch.h
rename to arch/arm/include/asm/text-patching.h
diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index e61591f33a6c..845acf9ce21e 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -23,7 +23,7 @@
 #include <asm/insn.h>
 #include <asm/set_memory.h>
 #include <asm/stacktrace.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 
 /*
  * The compiler emitted profiling hook consists of
diff --git a/arch/arm/kernel/jump_label.c b/arch/arm/kernel/jump_label.c
index eb9c24b6e8e2..a06a92d0f550 100644
--- a/arch/arm/kernel/jump_label.c
+++ b/arch/arm/kernel/jump_label.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include <linux/jump_label.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 #include <asm/insn.h>
 
 static void __arch_jump_label_transform(struct jump_entry *entry,
diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
index 22f937e6f3ff..ab76c55fd610 100644
--- a/arch/arm/kernel/kgdb.c
+++ b/arch/arm/kernel/kgdb.c
@@ -15,7 +15,7 @@
 #include <linux/kgdb.h>
 #include <linux/uaccess.h>
 
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 #include <asm/traps.h>
 
 struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] =
diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index e9e828b6bb30..4d45e60cd46d 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -9,7 +9,7 @@
 #include <asm/fixmap.h>
 #include <asm/smp_plat.h>
 #include <asm/opcodes.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 
 struct patch {
 	void *addr;
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index d8238da095df..9fd877c87a38 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -25,7 +25,7 @@
 #include <asm/cacheflush.h>
 #include <linux/percpu.h>
 #include <linux/bug.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 #include <asm/sections.h>
 
 #include "../decode-arm.h"
diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index 7f65048380ca..966c6042c5ad 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -14,7 +14,7 @@
 /* for arm_gen_branch */
 #include <asm/insn.h>
 /* for patch_text */
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 
 #include "core.h"
 
diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/text-patching.h
similarity index 100%
rename from arch/arm64/include/asm/patching.h
rename to arch/arm64/include/asm/text-patching.h
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index a650f5e11fc5..3575d03d60af 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -15,7 +15,7 @@
 #include <asm/debug-monitors.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
-#include <asm/patching.h>
+#include <asm/text-patching.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 struct fregs_offset {
diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
index f63ea915d6ad..b345425193d2 100644
--- a/arch/arm64/kernel/jump_label.c
+++ b/arch/arm64/kernel/jump_label.c
@@ -9,7 +9,7 @@
 #include <linux/jump_label.h>
 #include <linux/smp.h>
 #include <asm/insn.h>
-#include <asm/patching.h>
+#include <asm/text-patching.h>
 
 bool arch_jump_label_transform_queue(struct jump_entry *entry,
 				     enum jump_label_type type)
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 4e1f983df3d1..f3c4d3a8a20f 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -17,7 +17,7 @@
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
-#include <asm/patching.h>
+#include <asm/text-patching.h>
 #include <asm/traps.h>
 
 struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index 945df74005c7..7f99723fbb8c 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -10,7 +10,7 @@
 #include <asm/fixmap.h>
 #include <asm/insn.h>
 #include <asm/kprobes.h>
-#include <asm/patching.h>
+#include <asm/text-patching.h>
 #include <asm/sections.h>
 
 static DEFINE_RAW_SPINLOCK(patch_lock);
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 4268678d0e86..01dbe9a56956 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -27,7 +27,7 @@
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
 #include <asm/irq.h>
-#include <asm/patching.h>
+#include <asm/text-patching.h>
 #include <asm/ptrace.h>
 #include <asm/sections.h>
 #include <asm/system_misc.h>
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 563cbce11126..7d8199804086 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -41,7 +41,7 @@
 #include <asm/extable.h>
 #include <asm/insn.h>
 #include <asm/kprobes.h>
-#include <asm/patching.h>
+#include <asm/text-patching.h>
 #include <asm/traps.h>
 #include <asm/smp.h>
 #include <asm/stack_pointer.h>
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 8bbd0b20136a..2da25086c4ed 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -19,7 +19,7 @@
 #include <asm/cacheflush.h>
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
-#include <asm/patching.h>
+#include <asm/text-patching.h>
 #include <asm/set_memory.h>
 
 #include "bpf_jit.h"
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 9a9bc65b57a9..3a5c7f6e5aac 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -11,3 +11,4 @@ generic-y += qspinlock.h
 generic-y += parport.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
+generic-y += text-patching.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 8c1a78c8f527..1efa1e993d4b 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -5,3 +5,4 @@ generic-y += extable.h
 generic-y += iomap.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += text-patching.h
diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 5b5a6c90e6e2..80ddb5edb845 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -11,3 +11,4 @@ generic-y += ioctl.h
 generic-y += mmzone.h
 generic-y += statfs.h
 generic-y += param.h
+generic-y += text-patching.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 0dbf9c5c6fae..b282e0dd8dc1 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -4,3 +4,4 @@ generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += spinlock.h
+generic-y += text-patching.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index a055f5dbe00a..7178f990e8b3 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -8,3 +8,4 @@ generic-y += parport.h
 generic-y += syscalls.h
 generic-y += tlb.h
 generic-y += user.h
+generic-y += text-patching.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 7ba67a0d6c97..684569b2ecd6 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -13,3 +13,4 @@ generic-y += parport.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += user.h
+generic-y += text-patching.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 0d09829ed144..28004301c236 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += spinlock.h
 generic-y += user.h
+generic-y += text-patching.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index cef49d60d74c..2b1a6b00cdac 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -9,3 +9,4 @@ generic-y += spinlock.h
 generic-y += qrwlock_types.h
 generic-y += qrwlock.h
 generic-y += user.h
+generic-y += text-patching.h
diff --git a/arch/parisc/include/asm/patch.h b/arch/parisc/include/asm/text-patching.h
similarity index 100%
rename from arch/parisc/include/asm/patch.h
rename to arch/parisc/include/asm/text-patching.h
diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index c91f9c2e61ed..3e34b4473d3a 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -20,7 +20,7 @@
 #include <asm/assembly.h>
 #include <asm/sections.h>
 #include <asm/ftrace.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 
 #define __hot __section(".text.hot")
 
diff --git a/arch/parisc/kernel/jump_label.c b/arch/parisc/kernel/jump_label.c
index e253b134500d..ea51f15bf0e6 100644
--- a/arch/parisc/kernel/jump_label.c
+++ b/arch/parisc/kernel/jump_label.c
@@ -8,7 +8,7 @@
 #include <linux/jump_label.h>
 #include <linux/bug.h>
 #include <asm/alternative.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 
 static inline int reassemble_17(int as17)
 {
diff --git a/arch/parisc/kernel/kgdb.c b/arch/parisc/kernel/kgdb.c
index b16fa9bac5f4..fee81f877525 100644
--- a/arch/parisc/kernel/kgdb.c
+++ b/arch/parisc/kernel/kgdb.c
@@ -16,7 +16,7 @@
 #include <asm/ptrace.h>
 #include <asm/traps.h>
 #include <asm/processor.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 #include <asm/cacheflush.h>
 
 const struct kgdb_arch arch_kgdb_ops = {
diff --git a/arch/parisc/kernel/kprobes.c b/arch/parisc/kernel/kprobes.c
index 6e0b86652f30..9255adba67a3 100644
--- a/arch/parisc/kernel/kprobes.c
+++ b/arch/parisc/kernel/kprobes.c
@@ -12,7 +12,7 @@
 #include <linux/kprobes.h>
 #include <linux/slab.h>
 #include <asm/cacheflush.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
diff --git a/arch/parisc/kernel/patch.c b/arch/parisc/kernel/patch.c
index e59574f65e64..35dd764b871e 100644
--- a/arch/parisc/kernel/patch.c
+++ b/arch/parisc/kernel/patch.c
@@ -13,7 +13,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 
 struct patch {
 	void *addr;
diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 4525a9c68260..dfe2e5ad3b21 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -21,7 +21,7 @@
 #include <linux/percpu.h>
 #include <linux/module.h>
 #include <asm/probes.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 
 #ifdef CONFIG_KPROBES
 #define  __ARCH_WANT_KPROBES_INSN_SLOT
diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/text-patching.h
similarity index 100%
rename from arch/powerpc/include/asm/code-patching.h
rename to arch/powerpc/include/asm/text-patching.h
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 2086fa6cdc25..103b6605dd68 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 #include <linux/memblock.h>
 #include <linux/of.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/kdump.h>
 #include <asm/firmware.h>
 #include <linux/uio.h>
diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
index d4b8aff20815..247ab2acaccc 100644
--- a/arch/powerpc/kernel/epapr_paravirt.c
+++ b/arch/powerpc/kernel/epapr_paravirt.c
@@ -9,7 +9,7 @@
 #include <linux/of_fdt.h>
 #include <asm/epapr_hcalls.h>
 #include <asm/cacheflush.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/machdep.h>
 #include <asm/inst.h>
 
diff --git a/arch/powerpc/kernel/jump_label.c b/arch/powerpc/kernel/jump_label.c
index 5277cf582c16..2659e1ac8604 100644
--- a/arch/powerpc/kernel/jump_label.c
+++ b/arch/powerpc/kernel/jump_label.c
@@ -5,7 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/jump_label.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/inst.h>
 
 void arch_jump_label_transform(struct jump_entry *entry,
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 7a8bc03a00af..5081334b7bd2 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -21,7 +21,7 @@
 #include <asm/processor.h>
 #include <asm/machdep.h>
 #include <asm/debug.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <linux/slab.h>
 #include <asm/inst.h>
 
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index f8aa91bc3b17..9c85bbcc5201 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <linux/set_memory.h>
 #include <linux/execmem.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/cacheflush.h>
 #include <asm/sstep.h>
 #include <asm/sections.h>
diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index 816a63fd71fb..f930e3395a7f 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -18,7 +18,7 @@
 #include <linux/bug.h>
 #include <linux/sort.h>
 #include <asm/setup.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 
 /* Count how many different relocations (different symbol, different
    addend) */
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index e9bab599d0c2..135960918d14 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -17,7 +17,7 @@
 #include <linux/kernel.h>
 #include <asm/module.h>
 #include <asm/firmware.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <linux/sort.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index c0b351d61058..2e83702bf9ba 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -13,7 +13,7 @@
 #include <asm/kprobes.h>
 #include <asm/ptrace.h>
 #include <asm/cacheflush.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/sstep.h>
 #include <asm/ppc-opcode.h>
 #include <asm/inst.h>
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ff61a3e7984c..7b739b9a91ab 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -54,7 +54,7 @@
 #include <asm/firmware.h>
 #include <asm/hw_irq.h>
 #endif
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/exec.h>
 #include <asm/livepatch.h>
 #include <asm/cpu_has_feature.h>
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 4856e1a5161c..fbb7ebd8aa08 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -14,7 +14,7 @@
 #include <linux/debugfs.h>
 
 #include <asm/asm-prototypes.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/security_features.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index e515c1f7d8d3..75dbf3e0d9c4 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -40,7 +40,7 @@
 #include <asm/time.h>
 #include <asm/serial.h>
 #include <asm/udbg.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/cpu_has_feature.h>
 #include <asm/asm-prototypes.h>
 #include <asm/kdump.h>
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 22f83fbbc762..3ebf5b9fbe98 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -60,7 +60,7 @@
 #include <asm/xmon.h>
 #include <asm/udbg.h>
 #include <asm/kexec.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/ftrace.h>
 #include <asm/opal.h>
 #include <asm/cputhreads.h>
diff --git a/arch/powerpc/kernel/static_call.c b/arch/powerpc/kernel/static_call.c
index 1502b7e439ca..7cfd0710e757 100644
--- a/arch/powerpc/kernel/static_call.c
+++ b/arch/powerpc/kernel/static_call.c
@@ -2,7 +2,7 @@
 #include <linux/memory.h>
 #include <linux/static_call.h>
 
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 
 void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 {
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index d8d6b4fd9a14..be1a245241b3 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -23,7 +23,7 @@
 #include <linux/list.h>
 
 #include <asm/cacheflush.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/ftrace.h>
 #include <asm/syscall.h>
 #include <asm/inst.h>
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel/trace/ftrace_64_pg.c
index 12fab1803bcf..9e862ba55263 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.c
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.c
@@ -23,7 +23,7 @@
 #include <linux/list.h>
 
 #include <asm/cacheflush.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/ftrace.h>
 #include <asm/syscall.h>
 #include <asm/inst.h>
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index acdab294b340..af97fbb3c257 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -17,7 +17,7 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/page.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/inst.h>
 
 static int __patch_mem(void *exec_addr, unsigned long val, void *patch_addr, bool is_dword)
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index b7201ba50b2e..587c8cf1230f 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -16,7 +16,7 @@
 #include <linux/sched/mm.h>
 #include <linux/stop_machine.h>
 #include <asm/cputable.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/interrupt.h>
 #include <asm/page.h>
 #include <asm/sections.h>
diff --git a/arch/powerpc/lib/test-code-patching.c b/arch/powerpc/lib/test-code-patching.c
index 8cd3b32f805b..1440d99630b3 100644
--- a/arch/powerpc/lib/test-code-patching.c
+++ b/arch/powerpc/lib/test-code-patching.c
@@ -6,7 +6,7 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 
 static int __init instr_is_branch_to_addr(const u32 *instr, unsigned long addr)
 {
diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
index 23c7805fb7b3..66b5b4fa1686 100644
--- a/arch/powerpc/lib/test_emulate_step.c
+++ b/arch/powerpc/lib/test_emulate_step.c
@@ -11,7 +11,7 @@
 #include <asm/cpu_has_feature.h>
 #include <asm/sstep.h>
 #include <asm/ppc-opcode.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/inst.h>
 
 #define MAX_SUBTESTS	16
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 2db167f4233f..6978344edcb4 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -25,7 +25,7 @@
 
 #include <asm/mmu.h>
 #include <asm/machdep.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/sections.h>
 
 #include <mm/mmu_decl.h>
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index e1eadd03f133..47b22282269c 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -57,7 +57,7 @@
 #include <asm/sections.h>
 #include <asm/copro.h>
 #include <asm/udbg.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/fadump.h>
 #include <asm/firmware.h>
 #include <asm/tm.h>
diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/slb.c
index f2708c8629a5..6b783552403c 100644
--- a/arch/powerpc/mm/book3s64/slb.c
+++ b/arch/powerpc/mm/book3s64/slb.c
@@ -24,7 +24,7 @@
 #include <linux/pgtable.h>
 
 #include <asm/udbg.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 
 #include "internal.h"
 
diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/init_32.c
index aa9aa11927b2..03666d790a53 100644
--- a/arch/powerpc/mm/kasan/init_32.c
+++ b/arch/powerpc/mm/kasan/init_32.c
@@ -7,7 +7,7 @@
 #include <linux/memblock.h>
 #include <linux/sched/task.h>
 #include <asm/pgalloc.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <mm/mmu_decl.h>
 
 static pgprot_t __init kasan_prot_ro(void)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 1221c561b43a..c7708c8fad29 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -26,7 +26,7 @@
 #include <asm/svm.h>
 #include <asm/mmzone.h>
 #include <asm/ftrace.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/setup.h>
 #include <asm/fixmap.h>
 
diff --git a/arch/powerpc/mm/nohash/44x.c b/arch/powerpc/mm/nohash/44x.c
index 1beae802bb1c..6d10c6d8be71 100644
--- a/arch/powerpc/mm/nohash/44x.c
+++ b/arch/powerpc/mm/nohash/44x.c
@@ -24,7 +24,7 @@
 #include <asm/mmu.h>
 #include <asm/page.h>
 #include <asm/cacheflush.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/smp.h>
 
 #include <mm/mmu_decl.h>
diff --git a/arch/powerpc/mm/nohash/book3e_pgtable.c b/arch/powerpc/mm/nohash/book3e_pgtable.c
index ad2a7c26f2a0..062e8785c1bb 100644
--- a/arch/powerpc/mm/nohash/book3e_pgtable.c
+++ b/arch/powerpc/mm/nohash/book3e_pgtable.c
@@ -10,7 +10,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/dma.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 
 #include <mm/mmu_decl.h>
 
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index b653a7be4cb1..0a650742f3a0 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -37,7 +37,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/cputhreads.h>
 #include <asm/hugetlb.h>
 #include <asm/paca.h>
diff --git a/arch/powerpc/mm/nohash/tlb_64e.c b/arch/powerpc/mm/nohash/tlb_64e.c
index d26656b07b72..4f925adf2695 100644
--- a/arch/powerpc/mm/nohash/tlb_64e.c
+++ b/arch/powerpc/mm/nohash/tlb_64e.c
@@ -24,7 +24,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/cputhreads.h>
 
 #include <mm/mmu_decl.h>
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 2a36cc2e7e9e..68c6a13e6acb 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -18,7 +18,7 @@
 #include <linux/bpf.h>
 
 #include <asm/kprobes.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 
 #include "bpf_jit.h"
 
diff --git a/arch/powerpc/perf/8xx-pmu.c b/arch/powerpc/perf/8xx-pmu.c
index 308a2e40d7be..1d2972229e3a 100644
--- a/arch/powerpc/perf/8xx-pmu.c
+++ b/arch/powerpc/perf/8xx-pmu.c
@@ -14,7 +14,7 @@
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 #include <asm/ptrace.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/inst.h>
 
 #define PERF_8xx_ID_CPU_CYCLES		1
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 42867469752d..a727cd111cac 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -16,7 +16,7 @@
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 #include <asm/ptrace.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/hw_irq.h>
 #include <asm/interrupt.h>
 
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index e52b848b64b7..32fa5fb557c0 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -23,7 +23,7 @@
 #include <asm/mpic.h>
 #include <asm/cacheflush.h>
 #include <asm/dbell.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/cputhreads.h>
 #include <asm/fsl_pm.h>
 
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
index 8a7e55acf090..9be33e41af6d 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
@@ -12,7 +12,7 @@
 #include <linux/delay.h>
 #include <linux/pgtable.h>
 
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/page.h>
 #include <asm/pci-bridge.h>
 #include <asm/mpic.h>
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index fee638fd8970..0e8f20ecca08 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -35,7 +35,7 @@
 #include <asm/firmware.h>
 #include <asm/rtas.h>
 #include <asm/cputhreads.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 
 #include "interrupt.h"
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index d21b681f52fb..09e7fe24fac1 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -35,7 +35,7 @@
 
 #include <asm/ptrace.h>
 #include <linux/atomic.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/sections.h>
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index ad41dffe4d92..d98b933e4984 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -18,7 +18,7 @@
 #include <asm/opal.h>
 #include <asm/cputhreads.h>
 #include <asm/cpuidle.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/smp.h>
 #include <asm/runlatch.h>
 #include <asm/dbell.h>
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 8f14f0581a21..6b746feeabe4 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -28,7 +28,7 @@
 #include <asm/xive.h>
 #include <asm/opal.h>
 #include <asm/runlatch.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/dbell.h>
 #include <asm/kvm_ppc.h>
 #include <asm/ppc-opcode.h>
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index c597711ef20a..db99725e752b 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -39,7 +39,7 @@
 #include <asm/xive.h>
 #include <asm/dbell.h>
 #include <asm/plpar_wrappers.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/svm.h>
 #include <asm/kvm_guest.h>
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e6cddbb2305f..e76e1d5d0611 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -50,7 +50,7 @@
 #include <asm/xive.h>
 #include <asm/opal.h>
 #include <asm/firmware.h>
-#include <asm/code-patching.h>
+#include <asm/text-patching.h>
 #include <asm/sections.h>
 #include <asm/inst.h>
 #include <asm/interrupt.h>
diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
index fc1a34faa5f3..dcc9d1ee5ffd 100644
--- a/arch/riscv/errata/andes/errata.c
+++ b/arch/riscv/errata/andes/errata.c
@@ -13,7 +13,7 @@
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/errata_list.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 #include <asm/processor.h>
 #include <asm/sbi.h>
 #include <asm/vendorid_list.h>
diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index cea3b96ade11..38aac2c47845 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/bug.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/vendorid_list.h>
 #include <asm/errata_list.h>
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index f5120e07c318..e24770a77932 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -16,7 +16,7 @@
 #include <asm/errata_list.h>
 #include <asm/hwprobe.h>
 #include <asm/io.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 #include <asm/vendorid_list.h>
 #include <asm/vendor_extensions.h>
 
diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/text-patching.h
similarity index 100%
rename from arch/riscv/include/asm/patch.h
rename to arch/riscv/include/asm/text-patching.h
diff --git a/arch/riscv/include/asm/uprobes.h b/arch/riscv/include/asm/uprobes.h
index 3fc7deda9190..5008f76cdc27 100644
--- a/arch/riscv/include/asm/uprobes.h
+++ b/arch/riscv/include/asm/uprobes.h
@@ -4,7 +4,7 @@
 #define _ASM_RISCV_UPROBES_H
 
 #include <asm/probes.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 #include <asm/bug.h>
 
 #define MAX_UINSN_BYTES		8
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 0128b161bfda..7eb3cb1215c6 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -18,7 +18,7 @@
 #include <asm/sbi.h>
 #include <asm/csr.h>
 #include <asm/insn.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 
 struct cpu_manufacturer_info_t {
 	unsigned long vendor_id;
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3a8eeaa9310c..826f46b21f2e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -20,7 +20,8 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/hwcap.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
+#include <asm/hwprobe.h>
 #include <asm/processor.h>
 #include <asm/sbi.h>
 #include <asm/vector.h>
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 4b95c574fd04..a7620ef93b6c 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -10,7 +10,7 @@
 #include <linux/memory.h>
 #include <linux/stop_machine.h>
 #include <asm/cacheflush.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 void ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
index 11ad789c60c6..6eee6f736f68 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -10,7 +10,7 @@
 #include <linux/mutex.h>
 #include <asm/bug.h>
 #include <asm/cacheflush.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 
 #define RISCV_INSN_NOP 0x00000013U
 #define RISCV_INSN_JAL 0x0000006fU
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 34ef522f07a8..db13c9ddf9e3 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -13,7 +13,7 @@
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
 #include <asm/ftrace.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 #include <asm/sections.h>
 
 struct patch_insn {
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 474a65213657..380a0e8cecc0 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -12,7 +12,7 @@
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
 #include <asm/bug.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 
 #include "decode-insn.h"
 
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 99f34409fb60..c9f6c4d56012 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -10,7 +10,7 @@
 #include <linux/filter.h>
 #include <linux/memory.h>
 #include <linux/stop_machine.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 #include <asm/cfi.h>
 #include <asm/percpu.h>
 #include "bpf_jit.h"
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 6de753c667f4..f8cd2f70a7fb 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -9,7 +9,7 @@
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
-#include <asm/patch.h>
+#include <asm/text-patching.h>
 #include <asm/cfi.h>
 #include "bpf_jit.h"
 
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index fc44d9c88b41..4d3f10ed8275 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -3,3 +3,4 @@ generated-y += syscall_table.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
+generic-y += text-patching.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 43b0ae4c2c21..17ee8a273aa6 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -4,3 +4,4 @@ generated-y += syscall_table_64.h
 generic-y += agp.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += text-patching.h
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 8e594cda6d77..f8de31a0c5d1 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -468,6 +468,11 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 	return memcpy(addr, opcode, len);
 }
 
+void *text_poke_copy(void *addr, const void *opcode, size_t len)
+{
+	return text_poke(addr, opcode, len);
+}
+
 void text_poke_sync(void)
 {
 }
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 6259f1937fe7..ab9e143ec9fe 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -35,6 +35,7 @@ extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void text_poke_sync(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
+#define text_poke_copy text_poke_copy
 extern void *text_poke_copy_locked(void *addr, const void *opcode, size_t len, bool core_ok);
 extern void *text_poke_set(void *addr, int c, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index fa07c686cbcc..cc5dba738389 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -8,3 +8,4 @@ generic-y += parport.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += user.h
+generic-y += text-patching.h
diff --git a/include/asm-generic/text-patching.h b/include/asm-generic/text-patching.h
new file mode 100644
index 000000000000..2245c641b741
--- /dev/null
+++ b/include/asm-generic/text-patching.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_TEXT_PATCHING_H
+#define _ASM_GENERIC_TEXT_PATCHING_H
+
+#endif /* _ASM_GENERIC_TEXT_PATCHING_H */
diff --git a/include/linux/text-patching.h b/include/linux/text-patching.h
new file mode 100644
index 000000000000..ad5877ab0855
--- /dev/null
+++ b/include/linux/text-patching.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TEXT_PATCHING_H
+#define _LINUX_TEXT_PATCHING_H
+
+#include <asm/text-patching.h>
+
+#ifndef text_poke_copy
+static inline void *text_poke_copy(void *dst, const void *src, size_t len)
+{
+	return memcpy(dst, src, len);
+}
+#define text_poke_copy text_poke_copy
+#endif
+
+#endif /* _LINUX_TEXT_PATCHING_H */
-- 
2.43.0



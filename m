Return-Path: <linux-arch+bounces-6270-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0F6954C8C
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 16:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246531F229CE
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 14:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233D01BD4EB;
	Fri, 16 Aug 2024 14:37:43 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BCE1BD015;
	Fri, 16 Aug 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819063; cv=none; b=sCQa+ehBxKBWNA+6JV/KnW8lky7HauPl9Fj73R5ZMu1RQN8tIgg97K4qf+vlZ+toHB6MQUW/hMsP/L0MTKwE3DLr90gWNqDgkd5dNFuSZaBZozttEi20v3/rOXdOJIhgy9zuDmq0Y6R0YxJnDBDZFjCojc4ZYG0WBiion5fo/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819063; c=relaxed/simple;
	bh=XrmofFtku9UFtlIRoRQATwK6AOMTi8xpHx3tASxzQf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXQD10SffraoUUUGFls38ecmtCekpT9GnBVPe80X3gxB+k12Sgq3HkgDC+34e9DEVKtK7uScnjnXOQbeBP2KxlmyOWFjNeG2f7bppx8cxuzVxr1vZDLM8DYQvpaj1nOklIk39B2jq/++dLhk9ccCi7s7vm6Ms6g5z+JoUirmNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wll1q0y4zz9sSb;
	Fri, 16 Aug 2024 16:37:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rO7cTVIDJce1; Fri, 16 Aug 2024 16:37:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wll1n5MJFz9sSK;
	Fri, 16 Aug 2024 16:37:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A6CCA8B764;
	Fri, 16 Aug 2024 16:37:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id j3Gv5iHN7xf1; Fri, 16 Aug 2024 16:37:01 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.147])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C07D18B775;
	Fri, 16 Aug 2024 16:37:00 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 8/9] powerpc/vdso: Wire up getrandom() vDSO implementation
Date: Fri, 16 Aug 2024 16:36:55 +0200
Message-ID: <7e118080fc47a5c2e5616a7bfc7da127763d3bad.1723817900.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1723817900.git.christophe.leroy@csgroup.eu>
References: <cover.1723817900.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819012; l=20771; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=XrmofFtku9UFtlIRoRQATwK6AOMTi8xpHx3tASxzQf4=; b=EwPsFl3yvISLaJF3TBDgnAdtVAaHl8uhn6zIaMUN45iZDSCdG/mwDW6mZ13XTTl9R/Sd9hgD3 TInc8PrlSqAA3CSrxbZcXdnLcGunkqqVQogmfk567eeZVz+ua0Mag/y
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

To be consistent with other VDSO functions, the function is called
__kernel_getrandom()

__arch_chacha20_blocks_nostack() fonction is implemented basically
with 32 bits operations. It performs 4 QUARTERROUND operations in
parallele. There are enough registers to avoid using the stack:

On input:
	r3: output bytes
	r4: 32-byte key input
	r5: 8-byte counter input/output
	r6: number of 64-byte blocks to write to output

During operation:
	r0: counter of blocks (initialised with r6)
	r4: Value '4' after key has been read.
	r6-r13: key
	r14-r15 : block counter
	r16-r31 : chacha state

At the end:
	r0, r6-r13: Zeroised
	r14-r31: Restored

Performance on powerpc 885 (using kernel selftest):
	~# ./vdso_test_getrandom bench-single
	   vdso: 2500000 times in 7.897495392 seconds
	   libc: 2500000 times in 56.091632232 seconds
	syscall: 2500000 times in 55.704851989 seconds

Performance on powerpc 8321 (using kernel selftest):
	~# ./vdso_test_getrandom bench-single
	   vdso: 2500000 times in 2.017183250 seconds
	   libc: 2500000 times in 13.088533630 seconds
	syscall: 2500000 times in 12.952458068 seconds

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig                         |   1 +
 arch/powerpc/include/asm/vdso/getrandom.h    |  61 ++++
 arch/powerpc/include/asm/vdso/vsyscall.h     |   7 +
 arch/powerpc/include/asm/vdso_datapage.h     |   2 +
 arch/powerpc/kernel/asm-offsets.c            |   1 +
 arch/powerpc/kernel/vdso/Makefile            |  41 ++-
 arch/powerpc/kernel/vdso/getrandom.S         |  62 ++++
 arch/powerpc/kernel/vdso/vdso32.lds.S        |   1 +
 arch/powerpc/kernel/vdso/vdso64.lds.S        |   1 +
 arch/powerpc/kernel/vdso/vgetrandom-chacha.S | 297 +++++++++++++++++++
 arch/powerpc/kernel/vdso/vgetrandom.c        |  12 +
 11 files changed, 482 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vdso/getrandom.h
 create mode 100644 arch/powerpc/kernel/vdso/getrandom.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom-chacha.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d7b09b064a8a..f61cfa9ac360 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -311,6 +311,7 @@ config PPC
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
+	select VDSO_GETRANDOM			if !COMPAT
 	#
 	# Please keep this list sorted alphabetically.
 	#
diff --git a/arch/powerpc/include/asm/vdso/getrandom.h b/arch/powerpc/include/asm/vdso/getrandom.h
new file mode 100644
index 000000000000..37a678d982b4
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/getrandom.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_VDSO_GETRANDOM_H
+#define _ASM_POWERPC_VDSO_GETRANDOM_H
+
+#ifndef __ASSEMBLY__
+
+static __always_inline int do_syscall_3(const unsigned long _r0, const unsigned long _r3,
+					const unsigned long _r4, const unsigned long _r5)
+{
+	register long r0 asm("r0") = _r0;
+	register unsigned long r3 asm("r3") = _r3;
+	register unsigned long r4 asm("r4") = _r4;
+	register unsigned long r5 asm("r5") = _r5;
+	register int ret asm ("r3");
+
+	asm volatile(
+		"       sc\n"
+		"	bns+	1f\n"
+		"	neg	%0, %0\n"
+		"1:\n"
+	: "=r" (ret), "+r" (r4), "+r" (r5), "+r" (r0)
+	: "r" (r3)
+	: "memory", "r6", "r7", "r8", "r9", "r10", "r11", "r12", "cr0", "ctr");
+
+	return ret;
+}
+
+/**
+ * getrandom_syscall - Invoke the getrandom() syscall.
+ * @buffer:	Destination buffer to fill with random bytes.
+ * @len:	Size of @buffer in bytes.
+ * @flags:	Zero or more GRND_* flags.
+ * Returns:	The number of random bytes written to @buffer, or a negative value indicating an error.
+ */
+static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
+{
+	return do_syscall_3(__NR_getrandom, (unsigned long)buffer,
+			    (unsigned long)len, (unsigned long)flags);
+}
+
+const struct vdso_rng_data *__arch_get_vdso_rng_data(void);
+
+ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state,
+			     size_t opaque_len, const struct vdso_rng_data *vd);
+
+/**
+ * __arch_chacha20_blocks_nostack - Generate ChaCha20 stream without using the stack.
+ * @dst_bytes:	Destination buffer to hold @nblocks * 64 bytes of output.
+ * @key:	32-byte input key.
+ * @counter:	8-byte counter, read on input and updated on return.
+ * @nblocks:	Number of blocks to generate.
+ *
+ * Generates a given positive number of blocks of ChaCha20 output with nonce=0, and does not write
+ * to any stack or memory outside of the parameters passed to it, in order to mitigate stack data
+ * leaking into forked child processes.
+ */
+void __arch_chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks);
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_VDSO_GETRANDOM_H */
diff --git a/arch/powerpc/include/asm/vdso/vsyscall.h b/arch/powerpc/include/asm/vdso/vsyscall.h
index 48cf23f1e273..ed60a21bba40 100644
--- a/arch/powerpc/include/asm/vdso/vsyscall.h
+++ b/arch/powerpc/include/asm/vdso/vsyscall.h
@@ -17,6 +17,13 @@ struct vdso_data *__arch_get_k_vdso_data(void)
 }
 #define __arch_get_k_vdso_data __arch_get_k_vdso_data
 
+static __always_inline
+struct vdso_rng_data *__arch_get_k_vdso_rng_data(void)
+{
+	return &vdso_data->rng_data;
+}
+#define __arch_get_k_vdso_rng_data __arch_get_k_vdso_rng_data
+
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index a585c8e538ff..e17500c5237e 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -83,6 +83,7 @@ struct vdso_arch_data {
 	__u32 compat_syscall_map[SYSCALL_MAP_SIZE];	/* Map of compat syscalls */
 
 	struct vdso_data data[CS_BASES];
+	struct vdso_rng_data rng_data;
 };
 
 #else /* CONFIG_PPC64 */
@@ -95,6 +96,7 @@ struct vdso_arch_data {
 	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
 	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
 	struct vdso_data data[CS_BASES];
+	struct vdso_rng_data rng_data;
 };
 
 #endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 23733282de4d..eedb2e04c785 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -335,6 +335,7 @@ int main(void)
 
 	/* datapage offsets for use by vdso */
 	OFFSET(VDSO_DATA_OFFSET, vdso_arch_data, data);
+	OFFSET(VDSO_RNG_DATA_OFFSET, vdso_arch_data, rng_data);
 	OFFSET(CFG_TB_TICKS_PER_SEC, vdso_arch_data, tb_ticks_per_sec);
 #ifdef CONFIG_PPC64
 	OFFSET(CFG_ICACHE_BLOCKSZ, vdso_arch_data, icache_block_size);
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index c07a425b8f78..b380af35001a 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -8,6 +8,9 @@ include $(srctree)/lib/vdso/Makefile
 obj-vdso32 = sigtramp32-32.o gettimeofday-32.o datapage-32.o cacheflush-32.o note-32.o getcpu-32.o
 obj-vdso64 = sigtramp64-64.o gettimeofday-64.o datapage-64.o cacheflush-64.o note-64.o getcpu-64.o
 
+obj-vdso32 += getrandom-32.o vgetrandom-chacha-32.o
+obj-vdso64 += getrandom-64.o vgetrandom-chacha-64.o
+
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday-32.o += -include $(c-gettimeofday-y)
   CFLAGS_vgettimeofday-32.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
@@ -34,6 +37,32 @@ ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday-64.o += $(call cc-option, -ffixed-r30)
 endif
 
+ifneq ($(c-getrandom-y),)
+  CFLAGS_vgetrandom-32.o += -include $(c-getrandom-y)
+  CFLAGS_vgetrandom-32.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
+  CFLAGS_vgetrandom-32.o += $(call cc-option, -fno-stack-protector)
+  CFLAGS_vgetrandom-32.o += -DDISABLE_BRANCH_PROFILING
+  CFLAGS_vgetrandom-32.o += -ffreestanding -fasynchronous-unwind-tables
+  CFLAGS_REMOVE_vgetrandom-32.o = $(CC_FLAGS_FTRACE)
+  CFLAGS_REMOVE_vgetrandom-32.o += -mcmodel=medium -mabi=elfv1 -mabi=elfv2 -mcall-aixdesc
+  # This flag is supported by clang for 64-bit but not 32-bit so it will cause
+  # an unused command line flag warning for this file.
+  ifdef CONFIG_CC_IS_CLANG
+  CFLAGS_REMOVE_vgetrandom-32.o += -fno-stack-clash-protection
+  endif
+  CFLAGS_vgetrandom-64.o += -include $(c-getrandom-y)
+  CFLAGS_vgetrandom-64.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
+  CFLAGS_vgetrandom-64.o += $(call cc-option, -fno-stack-protector)
+  CFLAGS_vgetrandom-64.o += -DDISABLE_BRANCH_PROFILING
+  CFLAGS_vgetrandom-64.o += -ffreestanding -fasynchronous-unwind-tables
+  CFLAGS_REMOVE_vgetrandom-64.o = $(CC_FLAGS_FTRACE)
+# Go prior to 1.16.x assumes r30 is not clobbered by any VDSO code. That used to be true
+# by accident when the VDSO was hand-written asm code, but may not be now that the VDSO is
+# compiler generated. To avoid breaking Go tell GCC not to use r30. Impact on code
+# generation is minimal, it will just use r29 instead.
+  CFLAGS_vgetrandom-64.o += $(call cc-option, -ffixed-r30)
+endif
+
 # Build rules
 
 ifdef CROSS32_COMPILE
@@ -42,10 +71,10 @@ else
     VDSOCC := $(CC)
 endif
 
-targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday-32.o
+targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday-32.o vgetrandom-32.o
 targets += crtsavres-32.o
 obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
-targets += $(obj-vdso64) vdso64.so.dbg vgettimeofday-64.o
+targets += $(obj-vdso64) vdso64.so.dbg vgettimeofday-64.o vgetrandom-64.o
 obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
 
 ccflags-y := -fno-common -fno-builtin
@@ -69,9 +98,9 @@ targets += vdso64.lds
 CPPFLAGS_vdso64.lds += -P -C
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/crtsavres-32.o FORCE
+$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o FORCE
 	$(call if_changed,vdso32ld_and_check)
-$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o FORCE
+$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o FORCE
 	$(call if_changed,vdso64ld_and_check)
 
 # assembly rules for the .S files
@@ -81,10 +110,14 @@ $(obj)/crtsavres-32.o: %-32.o: $(srctree)/arch/powerpc/lib/crtsavres.S FORCE
 	$(call if_changed_dep,vdso32as)
 $(obj)/vgettimeofday-32.o: %-32.o: %.c FORCE
 	$(call if_changed_dep,vdso32cc)
+$(obj)/vgetrandom-32.o: %-32.o: %.c FORCE
+	$(call if_changed_dep,vdso32cc)
 $(obj-vdso64): %-64.o: %.S FORCE
 	$(call if_changed_dep,vdso64as)
 $(obj)/vgettimeofday-64.o: %-64.o: %.c FORCE
 	$(call if_changed_dep,cc_o_c)
+$(obj)/vgetrandom-64.o: %-64.o: %.c FORCE
+	$(call if_changed_dep,cc_o_c)
 
 # Generate VDSO offsets using helper script
 gen-vdso32sym := $(src)/gen_vdso32_offsets.sh
diff --git a/arch/powerpc/kernel/vdso/getrandom.S b/arch/powerpc/kernel/vdso/getrandom.S
new file mode 100644
index 000000000000..e196a61a6634
--- /dev/null
+++ b/arch/powerpc/kernel/vdso/getrandom.S
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Userland implementation of getrandom() for processes
+ * for use in the vDSO
+ *
+ * Copyright (C) 2024 Christophe Leroy <christophe.leroy@csgroup.eu>, CS GROUP France
+ */
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+#include <asm/vdso.h>
+#include <asm/vdso_datapage.h>
+#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
+
+/*
+ * The macro sets two stack frames, one for the caller and one for the callee
+ * because there are no requirement for the caller to set a stack frame when
+ * calling VDSO so it may have omitted to set one, especially on PPC64
+ */
+
+.macro cvdso_call funct
+  .cfi_startproc
+	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
+  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
+	mflr		r0
+	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
+  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
+	PPC_STL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
+  .cfi_rel_offset lr, PPC_MIN_STKFRM + PPC_LR_STKOFF
+#ifdef __powerpc64__
+	PPC_STL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
+  .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
+#endif
+	get_datapage	r8
+	addi		r8, r8, VDSO_RNG_DATA_OFFSET
+#ifdef __powerpc64__
+	bl		CFUNC(DOTSYM(\funct))
+#else
+	bl		\funct
+#endif
+	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
+#ifdef __powerpc64__
+	PPC_LL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
+  .cfi_restore r2
+#endif
+	cmpwi		r3, 0
+	mtlr		r0
+	addi		r1, r1, 2 * PPC_MIN_STKFRM
+  .cfi_restore lr
+  .cfi_def_cfa_offset 0
+	crclr		so
+	bgelr+
+	crset		so
+	neg		r3, r3
+	blr
+  .cfi_endproc
+.endm
+
+	.text
+V_FUNCTION_BEGIN(__kernel_getrandom)
+	cvdso_call __c_kernel_getrandom
+V_FUNCTION_END(__kernel_getrandom)
diff --git a/arch/powerpc/kernel/vdso/vdso32.lds.S b/arch/powerpc/kernel/vdso/vdso32.lds.S
index 8f57107000a2..7b41d5d256e8 100644
--- a/arch/powerpc/kernel/vdso/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso32.lds.S
@@ -130,6 +130,7 @@ VERSION
 #if defined(CONFIG_PPC64) || !defined(CONFIG_SMP)
 		__kernel_getcpu;
 #endif
+		__kernel_getrandom;
 
 	local: *;
 	};
diff --git a/arch/powerpc/kernel/vdso/vdso64.lds.S b/arch/powerpc/kernel/vdso/vdso64.lds.S
index 400819258c06..9481e4b892ed 100644
--- a/arch/powerpc/kernel/vdso/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso64.lds.S
@@ -123,6 +123,7 @@ VERSION
 		__kernel_sigtramp_rt64;
 		__kernel_getcpu;
 		__kernel_time;
+		__kernel_getrandom;
 
 	local: *;
 	};
diff --git a/arch/powerpc/kernel/vdso/vgetrandom-chacha.S b/arch/powerpc/kernel/vdso/vgetrandom-chacha.S
new file mode 100644
index 000000000000..355594f814e0
--- /dev/null
+++ b/arch/powerpc/kernel/vdso/vgetrandom-chacha.S
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Christophe Leroy <christophe.leroy@csgroup.eu>, CS GROUP France
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/ppc_asm.h>
+
+.macro quarterround4 a1 b1 c1 d1 a2 b2 c2 d2 a3 b3 c3 d3 a4 b4 c4 d4
+	add	\a1, \a1, \b1
+	add	\a2, \a2, \b2
+	add	\a3, \a3, \b3
+	add	\a4, \a4, \b4
+	xor	\d1, \d1, \a1
+	xor	\d2, \d2, \a2
+	xor	\d3, \d3, \a3
+	xor	\d4, \d4, \a4
+	rotlwi	\d1, \d1, 16
+	rotlwi	\d2, \d2, 16
+	rotlwi	\d3, \d3, 16
+	rotlwi	\d4, \d4, 16
+	add	\c1, \c1, \d1
+	add	\c2, \c2, \d2
+	add	\c3, \c3, \d3
+	add	\c4, \c4, \d4
+	xor	\b1, \b1, \c1
+	xor	\b2, \b2, \c2
+	xor	\b3, \b3, \c3
+	xor	\b4, \b4, \c4
+	rotlwi	\b1, \b1, 12
+	rotlwi	\b2, \b2, 12
+	rotlwi	\b3, \b3, 12
+	rotlwi	\b4, \b4, 12
+	add	\a1, \a1, \b1
+	add	\a2, \a2, \b2
+	add	\a3, \a3, \b3
+	add	\a4, \a4, \b4
+	xor	\d1, \d1, \a1
+	xor	\d2, \d2, \a2
+	xor	\d3, \d3, \a3
+	xor	\d4, \d4, \a4
+	rotlwi	\d1, \d1, 8
+	rotlwi	\d2, \d2, 8
+	rotlwi	\d3, \d3, 8
+	rotlwi	\d4, \d4, 8
+	add	\c1, \c1, \d1
+	add	\c2, \c2, \d2
+	add	\c3, \c3, \d3
+	add	\c4, \c4, \d4
+	xor	\b1, \b1, \c1
+	xor	\b2, \b2, \c2
+	xor	\b3, \b3, \c3
+	xor	\b4, \b4, \c4
+	rotlwi	\b1, \b1, 7
+	rotlwi	\b2, \b2, 7
+	rotlwi	\b3, \b3, 7
+	rotlwi	\b4, \b4, 7
+.endm
+
+#define QUARTERROUND4(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4) quarterround4 16+a1 16+b1 16+c1 16+d1 16+a2 16+b2 16+c2 16+d2 16+a3 16+b3 16+c3 16+d3 16+a4 16+b4 16+c4 16+d4
+
+/*
+ * Very basic 32 bits implementation of ChaCha20. Produces a given positive number
+ * of blocks of output with a nonce of 0, taking an input key and 8-byte
+ * counter. Importantly does not spill to the stack. Its arguments are:
+ *
+ *	r3: output bytes
+ *	r4: 32-byte key input
+ *	r5: 8-byte counter input/output
+ *	r6: number of 64-byte blocks to write to output
+ *
+ *	r0: counter of blocks (initialised with r6)
+ *	r4: Value '4' after key has been read.
+ *	r6-r13: key
+ *	r14-r15 : counter
+ *	r16-r31 : state
+ */
+SYM_FUNC_START(__arch_chacha20_blocks_nostack)
+#ifdef __powerpc64__
+	std	r14,-144(r1)
+	std	r15,-136(r1)
+	std	r16,-128(r1)
+	std	r17,-120(r1)
+	std	r18,-112(r1)
+	std	r19,-104(r1)
+	std	r20,-96(r1)
+	std	r21,-88(r1)
+	std	r22,-80(r1)
+	std	r23,-72(r1)
+	std	r24,-64(r1)
+	std	r25,-56(r1)
+	std	r26,-48(r1)
+	std	r27,-40(r1)
+	std	r28,-32(r1)
+	std	r29,-24(r1)
+	std	r30,-16(r1)
+	std	r31,-8(r1)
+#else
+	stwu	r1, -96(r1)
+#if defined(CONFIG_CPU_LITTLE_ENDIAN)
+	stw	r14,24(r1)
+	stw	r15,28(r1)
+	stw	r16,32(r1)
+	stw	r17,36(r1)
+	stw	r18,40(r1)
+	stw	r19,44(r1)
+	stw	r20,48(r1)
+	stw	r21,52(r1)
+	stw	r22,56(r1)
+	stw	r23,60(r1)
+	stw	r24,64(r1)
+	stw	r25,68(r1)
+	stw	r26,72(r1)
+	stw	r27,76(r1)
+	stw	r28,80(r1)
+	stw	r29,84(r1)
+	stw	r30,88(r1)
+	stw	r31,92(r1)
+#else
+	stmw	r14, 24(r1)
+#endif
+#endif
+	mr	r0, r6
+
+	li	r31, 4
+
+	LWZX_LE	r6, 0, r4
+	LWZX_LE	r7, r31, r4
+	addi	r4, r4, 8
+	LWZX_LE	r8, 0, r4
+	LWZX_LE	r9, r31, r4
+	addi	r4, r4, 8
+	LWZX_LE	r10, 0, r4
+	LWZX_LE	r11, r31, r4
+	addi	r4, r4, 8
+	LWZX_LE	r12, 0, r4
+	LWZX_LE	r13, r31, r4
+
+	li	r4, 4
+
+#ifdef __powerpc64__
+	LDX_LE	r14, 0, r5
+	srdi	r15, r14, 32
+#else
+	LWZX_LE	r14, 0, r5
+	LWZX_LE	r15, r4, r5
+#endif
+.Lblock:
+	li	r31, 10
+
+	lis	r16, 0x6170
+	lis	r17, 0x3320
+	lis	r18, 0x7962
+	lis	r19, 0x6b20
+	addi	r16, r16, 0x7865
+	addi	r17, r17, 0x646e
+	addi	r18, r18, 0x2d32
+	addi	r19, r19, 0x6574
+
+	mtctr	r31
+
+	mr	r20, r6
+	mr	r21, r7
+	mr	r22, r8
+	mr	r23, r9
+	mr	r24, r10
+	mr	r25, r11
+	mr	r26, r12
+	mr	r27, r13
+
+	mr	r28, r14
+	mr	r29, r15
+	li	r30, 0
+	li	r31, 0
+
+.Lpermute:
+	QUARTERROUND4( 0, 4, 8,12, 1, 5, 9,13, 2, 6,10,14, 3, 7,11,15)
+	QUARTERROUND4( 0, 5,10,15, 1, 6,11,12, 2, 7, 8,13, 3, 4, 9,14)
+
+	bdnz	.Lpermute
+
+	addis	r16, r16, 0x6170
+	addis	r17, r17, 0x3320
+	addis	r18, r18, 0x7962
+	addis	r19, r19, 0x6b20
+	addi	r16, r16, 0x7865
+	addi	r17, r17, 0x646e
+	addi	r18, r18, 0x2d32
+	addi	r19, r19, 0x6574
+
+	add	r20, r20, r6
+	add	r21, r21, r7
+	add	r22, r22, r8
+	add	r23, r23, r9
+	add	r24, r24, r10
+	add	r25, r25, r11
+	add	r26, r26, r12
+	add	r27, r27, r13
+
+	add	r28, r28, r14
+	add	r29, r29, r15
+
+	STWX_LE	r16, 0, r3
+	STWX_LE	r17, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r18, 0, r3
+	STWX_LE	r19, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r20, 0, r3
+	STWX_LE	r21, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r22, 0, r3
+	STWX_LE	r23, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r24, 0, r3
+	STWX_LE	r25, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r26, 0, r3
+	STWX_LE	r27, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r28, 0, r3
+	STWX_LE	r29, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r30, 0, r3
+	STWX_LE	r31, r4, r3
+	addi	r3, r3, 8
+
+#ifdef __powerpc64__
+	addi	r14, r14, 1
+	srdi	r15, r14, 32
+#else
+	addic	r14, r14, 1
+	addze	r15, r15
+#endif
+
+	subic.	r0, r0, 1
+	bne	.Lblock
+
+	STWX_LE	r14, 0, r5
+	STWX_LE	r15, r4, r5
+
+	li	r6, 0
+	li	r7, 0
+	li	r8, 0
+	li	r9, 0
+	li	r10, 0
+	li	r11, 0
+	li	r12, 0
+	li	r13, 0
+
+#ifdef __powerpc64__
+	ld	r14,-144(r1)
+	ld	r15,-136(r1)
+	ld	r16,-128(r1)
+	ld	r17,-120(r1)
+	ld	r18,-112(r1)
+	ld	r19,-104(r1)
+	ld	r20,-96(r1)
+	ld	r21,-88(r1)
+	ld	r22,-80(r1)
+	ld	r23,-72(r1)
+	ld	r24,-64(r1)
+	ld	r25,-56(r1)
+	ld	r26,-48(r1)
+	ld	r27,-40(r1)
+	ld	r28,-32(r1)
+	ld	r29,-24(r1)
+	ld	r30,-16(r1)
+	ld	r31,-8(r1)
+#else
+#if defined(CONFIG_CPU_LITTLE_ENDIAN)
+	lwz	r14,24(r1)
+	lwz	r15,28(r1)
+	lwz	r16,32(r1)
+	lwz	r17,36(r1)
+	lwz	r18,40(r1)
+	lwz	r19,44(r1)
+	lwz	r20,48(r1)
+	lwz	r21,52(r1)
+	lwz	r22,56(r1)
+	lwz	r23,60(r1)
+	lwz	r24,64(r1)
+	lwz	r25,68(r1)
+	lwz	r26,72(r1)
+	lwz	r27,76(r1)
+	lwz	r28,80(r1)
+	lwz	r29,84(r1)
+	lwz	r30,88(r1)
+	lwz	r31,92(r1)
+#else
+	lmw	r14, 24(r1)
+#endif
+	addi	r1, r1, 96
+#endif
+	blr
+SYM_FUNC_END(__arch_chacha20_blocks_nostack)
diff --git a/arch/powerpc/kernel/vdso/vgetrandom.c b/arch/powerpc/kernel/vdso/vgetrandom.c
new file mode 100644
index 000000000000..f442396c3715
--- /dev/null
+++ b/arch/powerpc/kernel/vdso/vgetrandom.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Powerpc userspace implementations of getrandom()
+ */
+#include <linux/time.h>
+#include <linux/types.h>
+
+ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state,
+			     size_t opaque_len, const struct vdso_rng_data *vd)
+{
+       return __cvdso_getrandom_data(vd, buffer, len, flags, opaque_state, opaque_len);
+}
-- 
2.44.0



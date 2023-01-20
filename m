Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ACF675760
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjATOgE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjATOfx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:35:53 -0500
Received: from fx305.security-mail.net (smtpout30.security-mail.net [85.31.212.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D62490B23
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:35:09 -0800 (PST)
Received: from localhost (fx305.security-mail.net [127.0.0.1])
        by fx305.security-mail.net (Postfix) with ESMTP id 94C1730FCC6
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:20:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674224445;
        bh=fEolq90cY5EVuj1+uEWf79Pf+IA5puQR/p9asxKN+A8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fqLUMUllp0Eu6hCiF6a/9yQWxlMRGPBYgKxpP30yFrf159+jmiaoS3uudx/MShVfU
         a0IA4SJc9pEeAG8FkN97IaRKMZih9IcMw+/gTh1+wb6K3XLrA4m7WVz2sJqowl0DN7
         MdmjDaodhmXfFrU66nn7v8j2IfLBg0eE6Vf/7w6E=
Received: from fx305 (fx305.security-mail.net [127.0.0.1]) by
 fx305.security-mail.net (Postfix) with ESMTP id 5555F30FD6F; Fri, 20 Jan
 2023 15:20:45 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx305.security-mail.net (Postfix) with ESMTPS id 7BD1A30FCAF; Fri, 20 Jan
 2023 15:20:44 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 38E4227E0452; Fri, 20 Jan 2023
 15:10:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 20A5E27E0454; Fri, 20 Jan 2023 15:10:36 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 g2cicOgIF5vL; Fri, 20 Jan 2023 15:10:36 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 6496127E043A; Fri, 20 Jan 2023
 15:10:35 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <13de6.63caa33c.7a428.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 20A5E27E0454
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223836;
 bh=cF5CoaZgmR1DuYZiI1Z/oNzdyD7coVLwL5/tSu1i9wQ=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=j5hX1EY3DQWjpD0GffZPmcCW1pATwP/ux72mimsi2RzoDPkPiD+pGMILaWxOeKxz4
 kzuu4uIUoPtUy5Oh2rn954ACY+VEHvcoTZIwuMFqr1AvlKmOFTnMvCYAHG32kpHHgs
 4VfbzprQcq0M0FO3Hlbee2Wz+8siLQIRrDpRo0Ms=
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Yann Sionneau <ysionneau@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: [RFC PATCH v2 24/31] kvx: Add misc common routines
Date:   Fri, 20 Jan 2023 15:09:55 +0100
Message-ID: <20230120141002.2442-25-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add some misc common routines for kvx, including: asm-offsets routines,
futex functions, i/o memory access functions.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Jonathan Borne <jborne@kalray.eu>
Signed-off-by: Jonathan Borne <jborne@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Julien Villette <jvillette@kalray.eu>
Signed-off-by: Julien Villette <jvillette@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: no changes

 arch/kvx/include/asm/futex.h  | 141 ++++++++++++++++++++++++++++++
 arch/kvx/include/asm/io.h     |  34 ++++++++
 arch/kvx/kernel/asm-offsets.c | 157 ++++++++++++++++++++++++++++++++++
 arch/kvx/kernel/io.c          |  96 +++++++++++++++++++++
 4 files changed, 428 insertions(+)
 create mode 100644 arch/kvx/include/asm/futex.h
 create mode 100644 arch/kvx/include/asm/io.h
 create mode 100644 arch/kvx/kernel/asm-offsets.c
 create mode 100644 arch/kvx/kernel/io.c

diff --git a/arch/kvx/include/asm/futex.h b/arch/kvx/include/asm/futex.h
new file mode 100644
index 000000000000..b71b52339729
--- /dev/null
+++ b/arch/kvx/include/asm/futex.h
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2018-2023 Kalray Inc.
+ * Authors:
+ *      Clement Leger <cleger@kalray.eu>
+ *      Yann Sionneau <ysionneau@kalray.eu>
+ *      Jonathan Borne <jborne@kalray.eu>
+ *
+ * Part of code is taken from RiscV port
+ */
+
+#ifndef _ASM_KVX_FUTEX_H
+#define _ASM_KVX_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+
+#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
+{ \
+	__enable_user_access();                                 \
+	__asm__ __volatile__ (                                  \
+	"       fence                                   \n"     \
+	"       ;;\n                                      "     \
+	"1:     lwz $r63 = 0[%[u]]                      \n"     \
+	"       ;;\n                                      "     \
+	"       " insn "                                \n"     \
+	"       ;;\n                                      "     \
+	"       acswapw 0[%[u]], $r62r63                \n"     \
+	"       ;;\n                                      "     \
+	"       cb.deqz $r62? 1b                        \n"     \
+	"       ;;\n                                      "     \
+	"       copyd %[ov] = $r63                      \n"     \
+	"       ;;\n                                      "     \
+	"2:                                             \n"     \
+	"       .section .fixup,\"ax\"                  \n"     \
+	"3:     make %[r] = 2b                          \n"     \
+	"       ;;\n                                      "     \
+	"       make %[r] = %[e]                        \n"     \
+	"       igoto %[r]                              \n"     \
+	"       ;;\n                                      "     \
+	"       .previous                               \n"     \
+	"       .section __ex_table,\"a\"               \n"     \
+	"       .align 8                                \n"     \
+	"       .dword 1b,3b                            \n"     \
+	"       .dword 2b,3b                            \n"     \
+	"       .previous                               \n"     \
+	: [r] "+r" (ret), [ov] "+r" (oldval)                   \
+	: [u] "r" (uaddr),                                      \
+	  [op] "r" (oparg), [e] "i" (-EFAULT)                   \
+	: "r62", "r63", "memory");                              \
+	__disable_user_access();                                \
+}
+
+
+static inline int
+arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
+{
+	int oldval = 0, ret = 0;
+
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+	switch (op) {
+	case FUTEX_OP_SET: /* *(int *)UADDR = OPARG; */
+		__futex_atomic_op("copyd $r62 = %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD: /* *(int *)UADDR += OPARG; */
+		__futex_atomic_op("addw $r62 = $r63, %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_OR: /* *(int *)UADDR |= OPARG; */
+		__futex_atomic_op("orw $r62 = $r63, %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN: /* *(int *)UADDR &= ~OPARG; */
+		__futex_atomic_op("andnw $r62 = %[op], $r63",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("xorw $r62 = $r63, %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+
+	if (!ret)
+		*oval = oldval;
+
+	return ret;
+}
+
+static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+						u32 oldval, u32 newval)
+{
+	int ret = 0;
+
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+	__enable_user_access();
+	__asm__ __volatile__ (
+	"      fence                           \n"/* commit previous stores  */
+	"      copyd $r63 = %[ov]              \n"/* init "expect" with ov   */
+	"      copyd $r62 = %[nv]              \n"/* init "update" with nv   */
+	"      ;;\n                              "
+	"1:    acswapw 0[%[u]], $r62r63        \n"
+	"      ;;\n                              "
+	"      cb.dnez $r62? 3f                \n"/* if acswap ok -> return  */
+	"      ;;\n                              "
+	"2:    lws $r63 = 0[%[u]]              \n"/* fail -> load old value  */
+	"      ;;\n                              "
+	"      compw.ne $r62 = $r63, %[ov]     \n"/* check if equal to "old" */
+	"      ;;\n                              "
+	"      cb.deqz $r62? 1b                \n"/* if not equal, try again */
+	"      ;;\n                              "
+	"3:                                    \n"
+	"      .section .fixup,\"ax\"          \n"
+	"4:    make %[r] = 3b                  \n"
+	"      ;;\n                              "
+	"      make %[r] = %[e]                \n"
+	"      igoto %[r]                      \n"/* goto 3b                 */
+	"      ;;\n                              "
+	"      .previous                       \n"
+	"      .section __ex_table,\"a\"       \n"
+	"      .align 8                        \n"
+	"      .dword 1b,4b                    \n"
+	"      .dword 2b,4b                    \n"
+	".previous                             \n"
+	: [r] "+r" (ret)
+	: [ov] "r" (oldval), [nv] "r" (newval),
+	  [e] "i" (-EFAULT), [u] "r" (uaddr)
+	: "r62", "r63", "memory");
+	__disable_user_access();
+	*uval = oldval;
+	return ret;
+}
+
+#endif
+#endif /* _ASM_KVX_FUTEX_H */
diff --git a/arch/kvx/include/asm/io.h b/arch/kvx/include/asm/io.h
new file mode 100644
index 000000000000..c5e458c59bbb
--- /dev/null
+++ b/arch/kvx/include/asm/io.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_IO_H
+#define _ASM_KVX_IO_H
+
+#include <linux/types.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+#define _PAGE_IOREMAP _PAGE_KERNEL_DEVICE
+
+/*
+ * String version of I/O memory access operations.
+ */
+extern void __memcpy_fromio(void *to, const volatile void __iomem *from,
+			    size_t count);
+extern void __memcpy_toio(volatile void __iomem *to, const void *from,
+			  size_t count);
+extern void __memset_io(volatile void __iomem *dst, int c, size_t count);
+
+#define memset_io(c, v, l)	__memset_io((c), (v), (l))
+#define memcpy_fromio(a, c, l)	__memcpy_fromio((a), (c), (l))
+#define memcpy_toio(c, a, l)	__memcpy_toio((c), (a), (l))
+
+#include <asm-generic/io.h>
+
+extern int devmem_is_allowed(unsigned long pfn);
+
+#endif	/* _ASM_KVX_IO_H */
diff --git a/arch/kvx/kernel/asm-offsets.c b/arch/kvx/kernel/asm-offsets.c
new file mode 100644
index 000000000000..3e79b6dd13bd
--- /dev/null
+++ b/arch/kvx/kernel/asm-offsets.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Yann Sionneau
+ */
+
+#include <linux/preempt.h>
+#include <linux/thread_info.h>
+#include <linux/kbuild.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/bug.h>
+
+#include <asm/processor.h>
+#include <asm/ptrace.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
+#include <asm/page_size.h>
+#include <asm/pgtable.h>
+#include <asm/ptrace.h>
+#include <asm/tlb_defs.h>
+#include <asm/mmu_stats.h>
+#include <asm/stacktrace.h>
+
+int foo(void)
+{
+	BUILD_BUG_ON(sizeof(struct pt_regs) != PT_REGS_STRUCT_EXPECTED_SIZE);
+	/*
+	 * For stack alignment purposes we must make sure the pt_regs size is
+	 * a mutliple of stack_align
+	 */
+	BUILD_BUG_ON(!IS_ALIGNED(sizeof(struct pt_regs), STACK_ALIGNMENT));
+
+	/* Check that user_pt_regs size matches the beginning of pt_regs */
+	BUILD_BUG_ON((offsetof(struct user_pt_regs, spc) + sizeof(uint64_t)) !=
+		     sizeof(struct user_pt_regs));
+
+	DEFINE(FIX_GDB_MEM_BASE_IDX, FIX_GDB_BARE_DISPLACED_MEM_BASE);
+
+#ifdef CONFIG_DEBUG_EXCEPTION_STACK
+	DEFINE(STACK_REG_SIZE, ALIGN(sizeof(uint64_t), STACK_ALIGNMENT));
+#endif
+
+	/*
+	 * We allocate a pt_regs on the stack when entering the kernel.  This
+	 * ensures the alignment is sane.
+	 */
+	DEFINE(PT_SIZE_ON_STACK, sizeof(struct pt_regs));
+	DEFINE(TI_FLAGS_SIZE, sizeof(unsigned long));
+	DEFINE(QUAD_REG_SIZE, 4 * sizeof(uint64_t));
+
+	/*
+	 * When restoring registers, we do not want to restore r12
+	 * right now since this is our stack pointer. Allow to save
+	 * only $r13 by using this offset.
+	 */
+	OFFSET(PT_R12, pt_regs, r12);
+	OFFSET(PT_R13, pt_regs, r13);
+	OFFSET(PT_TP, pt_regs, tp);
+	OFFSET(PT_R14R15, pt_regs, r14);
+	OFFSET(PT_R16R17, pt_regs, r16);
+	OFFSET(PT_R18R19, pt_regs, r18);
+	OFFSET(PT_FP, pt_regs, fp);
+	OFFSET(PT_SPS, pt_regs, sps);
+
+	/* Quad description */
+	OFFSET(PT_Q0, pt_regs, r0);
+	OFFSET(PT_Q4, pt_regs, r4);
+	OFFSET(PT_Q8, pt_regs, r8);
+	OFFSET(PT_Q12, pt_regs, r12);
+	OFFSET(PT_Q16, pt_regs, r16);
+	OFFSET(PT_Q20, pt_regs, r20);
+	OFFSET(PT_Q24, pt_regs, r24);
+	OFFSET(PT_Q28, pt_regs, r28);
+	OFFSET(PT_Q32, pt_regs, r32);
+	OFFSET(PT_Q36, pt_regs, r36);
+	OFFSET(PT_R38, pt_regs, r38);
+	OFFSET(PT_Q40, pt_regs, r40);
+	OFFSET(PT_Q44, pt_regs, r44);
+	OFFSET(PT_Q48, pt_regs, r48);
+	OFFSET(PT_Q52, pt_regs, r52);
+	OFFSET(PT_Q56, pt_regs, r56);
+	OFFSET(PT_Q60, pt_regs, r60);
+	OFFSET(PT_CS_SPC_SPS_ES, pt_regs, cs);
+	OFFSET(PT_LC_LE_LS_RA, pt_regs, lc);
+	OFFSET(PT_ILR, pt_regs, ilr);
+	OFFSET(PT_ORIG_R0, pt_regs, orig_r0);
+
+	/*
+	 * Flags in thread info
+	 */
+	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
+
+	/*
+	 * Stack pointers
+	 */
+	OFFSET(TASK_THREAD_KERNEL_SP, task_struct, thread.kernel_sp);
+
+	/*
+	 * Offsets to save registers in switch_to using quads
+	 */
+	OFFSET(CTX_SWITCH_RA_SP_R18_R19, task_struct, thread.ctx_switch.ra);
+	OFFSET(CTX_SWITCH_Q20, task_struct, thread.ctx_switch.r20);
+	OFFSET(CTX_SWITCH_Q24, task_struct, thread.ctx_switch.r24);
+	OFFSET(CTX_SWITCH_Q28, task_struct, thread.ctx_switch.r28);
+	OFFSET(CTX_SWITCH_FP, task_struct, thread.ctx_switch.fp);
+
+#ifdef CONFIG_ENABLE_TCA
+	OFFSET(CTX_SWITCH_TCA_REGS, task_struct, thread.ctx_switch.tca_regs[0]);
+	OFFSET(CTX_SWITCH_TCA_REGS_SAVED, task_struct,
+					thread.ctx_switch.tca_regs_saved);
+	DEFINE(TCA_REG_SIZE, sizeof(struct tca_reg));
+#endif
+
+	/* Save area offset */
+	OFFSET(TASK_THREAD_SAVE_AREA, task_struct, thread.save_area);
+
+	/* Fast tlb refill defines */
+	OFFSET(TASK_ACTIVE_MM, task_struct, active_mm);
+	OFFSET(MM_PGD, mm_struct, pgd);
+#ifdef CONFIG_KVX_DEBUG_ASN
+	OFFSET(MM_CTXT_ASN, mm_struct, context.asn);
+#endif
+
+#ifdef CONFIG_KVX_MMU_STATS
+	DEFINE(MMU_REFILL_SIZE, sizeof(struct mmu_refill_stats));
+
+	OFFSET(MMU_STATS_REFILL_USER_OFF, mmu_stats,
+	       refill[MMU_REFILL_TYPE_USER]);
+	OFFSET(MMU_STATS_REFILL_KERNEL_OFF, mmu_stats,
+	       refill[MMU_REFILL_TYPE_KERNEL]);
+	OFFSET(MMU_STATS_REFILL_KERNEL_DIRECT_OFF, mmu_stats,
+	       refill[MMU_REFILL_TYPE_KERNEL_DIRECT]);
+	OFFSET(MMU_STATS_CYCLES_BETWEEN_REFILL_OFF, mmu_stats,
+	       cycles_between_refill);
+	OFFSET(MMU_STATS_LAST_REFILL, mmu_stats, last_refill);
+
+	OFFSET(TASK_THREAD_ENTRY_TS, task_struct, thread.trap_entry_ts);
+#endif
+
+	DEFINE(ASM_PGDIR_SHIFT, PGDIR_SHIFT);
+	DEFINE(ASM_PMD_SHIFT, PMD_SHIFT);
+
+	DEFINE(ASM_PGDIR_BITS, PGDIR_BITS);
+	DEFINE(ASM_PMD_BITS, PMD_BITS);
+	DEFINE(ASM_PTE_BITS, PTE_BITS);
+
+	DEFINE(ASM_PTRS_PER_PGD, PTRS_PER_PGD);
+	DEFINE(ASM_PTRS_PER_PMD, PTRS_PER_PMD);
+	DEFINE(ASM_PTRS_PER_PTE, PTRS_PER_PTE);
+
+	DEFINE(ASM_TLB_PS, TLB_DEFAULT_PS);
+
+	return 0;
+}
diff --git a/arch/kvx/kernel/io.c b/arch/kvx/kernel/io.c
new file mode 100644
index 000000000000..0922c1d6d0f7
--- /dev/null
+++ b/arch/kvx/kernel/io.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/arm/kernel/io.c
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#define REPLICATE_BYTE_MASK	0x0101010101010101
+
+/*
+ * Copy data from IO memory space to "real" memory space.
+ */
+void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)from, 8)) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= 8) {
+		*(u64 *)to = __raw_readq(from);
+		from += 8;
+		to += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_fromio);
+
+/*
+ * Copy data from "real" memory space to IO memory space.
+ */
+void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)to, 8)) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= 8) {
+		__raw_writeq(*(u64 *)from, to);
+		from += 8;
+		to += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_toio);
+
+/*
+ * "memset" on IO memory space.
+ */
+void __memset_io(volatile void __iomem *dst, int c, size_t count)
+{
+	u64 qc = __builtin_kvx_sbmm8(c, REPLICATE_BYTE_MASK);
+
+	while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+
+	while (count >= 8) {
+		__raw_writeq(qc, dst);
+		dst += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memset_io);
-- 
2.37.2






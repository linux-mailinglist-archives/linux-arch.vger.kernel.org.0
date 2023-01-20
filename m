Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AF6675705
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjATOZj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjATOZh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:25:37 -0500
Received: from fx303.security-mail.net (mxout.security-mail.net [85.31.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF61D3B65C
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:25:14 -0800 (PST)
Received: from localhost (fx303.security-mail.net [127.0.0.1])
        by fx303.security-mail.net (Postfix) with ESMTP id 5A88D30F7A7
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:20:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674224446;
        bh=pOkBOIfM3JMD67ygOoVKu1eQ66cv53r7ZKUe6yP7yBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QCZGQaIysX3VnwI0oLpXH0rg5WKYZkIc53LdJOnrKJmUsY2Ahi1V3e0CX95xiYv6W
         Vy7d+FJsAPp1Tsu7VGvpPncstW9Kf8Np3nAfzeLBn96w1BvtLuelP+vbpbNcjeU6FH
         pVd2VgAgtkBTukPPwGJhR4NKQKtXkZjepzX4umZM=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id 2142630F7C2; Fri, 20 Jan
 2023 15:20:46 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx303.security-mail.net (Postfix) with ESMTPS id 259B630F7C0; Fri, 20 Jan
 2023 15:20:44 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 05DAE27E046C; Fri, 20 Jan 2023
 15:10:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id E1B3627E0457; Fri, 20 Jan 2023 15:10:37 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 IvWjvNbLtKjb; Fri, 20 Jan 2023 15:10:37 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 7A7EF27E045E; Fri, 20 Jan 2023
 15:10:37 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <168e6.63caa33c.bea66.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu E1B3627E0457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223837;
 bh=MWFUeJSXqLDohlytQZd/iLpZT+G8twsG/8uQn0QCk30=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=UuqinM2S2Qepgl5gcemf89cU/+xmR/I2NOCerz0NYOkRRoqf6tMhwh0YdjfOwNPhP
 hbPwi7gXupTxq/rpKVzY6hyE2mFc74OosyuP0A+u0C+ldJGkF24OtxkYoTbCSVNxcn
 2u/tBn13StGHmMLWcwz/mTNrZBsYy2a8sijheQtQ=
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
Subject: [RFC PATCH v2 28/31] kvx: Add debugging related support
Date:   Fri, 20 Jan 2023 15:09:59 +0100
Message-ID: <20230120141002.2442-29-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add kvx support for debugging

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Marius Gligor <mgligor@kalray.eu>
Signed-off-by: Marius Gligor <mgligor@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: no changes

 arch/kvx/include/asm/debug.h      |  35 ++++++
 arch/kvx/include/asm/insns.h      |  16 +++
 arch/kvx/include/asm/insns_defs.h | 197 ++++++++++++++++++++++++++++++
 arch/kvx/kernel/break_hook.c      |  76 ++++++++++++
 arch/kvx/kernel/debug.c           |  64 ++++++++++
 arch/kvx/kernel/insns.c           | 144 ++++++++++++++++++++++
 6 files changed, 532 insertions(+)
 create mode 100644 arch/kvx/include/asm/debug.h
 create mode 100644 arch/kvx/include/asm/insns.h
 create mode 100644 arch/kvx/include/asm/insns_defs.h
 create mode 100644 arch/kvx/kernel/break_hook.c
 create mode 100644 arch/kvx/kernel/debug.c
 create mode 100644 arch/kvx/kernel/insns.c

diff --git a/arch/kvx/include/asm/debug.h b/arch/kvx/include/asm/debug.h
new file mode 100644
index 000000000000..f60c632e6697
--- /dev/null
+++ b/arch/kvx/include/asm/debug.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef __ASM_KVX_DEBUG_HOOK_H_
+#define __ASM_KVX_DEBUG_HOOK_H_
+
+/**
+ * enum debug_ret - Break return value
+ * @DEBUG_HOOK_HANDLED: Hook handled successfully
+ * @DEBUG_HOOK_IGNORED: Hook call has been ignored
+ */
+enum debug_ret {
+	DEBUG_HOOK_HANDLED = 0,
+	DEBUG_HOOK_IGNORED = 1,
+};
+
+/**
+ * struct debug_hook - Debug hook description
+ * @node: List node
+ * @handler: handler called on debug entry
+ * @mode: Hook mode (user/kernel)
+ */
+struct debug_hook {
+	struct list_head node;
+	int (*handler)(u64 ea, struct pt_regs *regs);
+	u8 mode;
+};
+
+void debug_hook_register(struct debug_hook *dbg_hook);
+void debug_hook_unregister(struct debug_hook *dbg_hook);
+
+#endif /* __ASM_KVX_DEBUG_HOOK_H_ */
diff --git a/arch/kvx/include/asm/insns.h b/arch/kvx/include/asm/insns.h
new file mode 100644
index 000000000000..36a9e8335ce8
--- /dev/null
+++ b/arch/kvx/include/asm/insns.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_INSNS_H
+#define _ASM_KVX_INSNS_H
+
+int kvx_insns_write_nostop(u32 *insns, u8 insns_len, u32 *insn_addr);
+
+int kvx_insns_write(u32 *insns, unsigned long insns_len, u32 *addr);
+
+int kvx_insns_read(u32 *insns, unsigned long insns_len, u32 *addr);
+
+#endif
diff --git a/arch/kvx/include/asm/insns_defs.h b/arch/kvx/include/asm/insns_defs.h
new file mode 100644
index 000000000000..ed8d9d6f0817
--- /dev/null
+++ b/arch/kvx/include/asm/insns_defs.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+#ifndef __ASM_KVX_INSNS_DEFS_H_
+#define __ASM_KVX_INSNS_DEFS_H_
+
+#include <linux/bits.h>
+
+#ifndef __ASSEMBLY__
+static inline int check_signed_imm(long long imm, int bits)
+{
+	long long min, max;
+
+	min = -BIT_ULL(bits - 1);
+	max = BIT_ULL(bits - 1) - 1;
+	if (imm < min || imm > max)
+		return 1;
+
+	return 0;
+}
+#endif /* __ASSEMBLY__ */
+
+#define BITMASK(bits)		(BIT_ULL(bits) - 1)
+
+#define KVX_INSN_SYLLABLE_WIDTH 4
+
+#define IS_INSN(__insn, __mnemo) \
+	((__insn & KVX_INSN_ ## __mnemo ## _MASK_0) == \
+	 KVX_INSN_ ## __mnemo ## _OPCODE_0)
+
+#define INSN_SIZE(__insn) \
+	(KVX_INSN_ ## __insn ## _SIZE * KVX_INSN_SYLLABLE_WIDTH)
+
+/* Values for general registers */
+#define KVX_REG_R0	0
+#define KVX_REG_R1	1
+#define KVX_REG_R2	2
+#define KVX_REG_R3	3
+#define KVX_REG_R4	4
+#define KVX_REG_R5	5
+#define KVX_REG_R6	6
+#define KVX_REG_R7	7
+#define KVX_REG_R8	8
+#define KVX_REG_R9	9
+#define KVX_REG_R10	10
+#define KVX_REG_R11	11
+#define KVX_REG_R12	12
+#define KVX_REG_SP	12
+#define KVX_REG_R13	13
+#define KVX_REG_TP	13
+#define KVX_REG_R14	14
+#define KVX_REG_FP	14
+#define KVX_REG_R15	15
+#define KVX_REG_R16	16
+#define KVX_REG_R17	17
+#define KVX_REG_R18	18
+#define KVX_REG_R19	19
+#define KVX_REG_R20	20
+#define KVX_REG_R21	21
+#define KVX_REG_R22	22
+#define KVX_REG_R23	23
+#define KVX_REG_R24	24
+#define KVX_REG_R25	25
+#define KVX_REG_R26	26
+#define KVX_REG_R27	27
+#define KVX_REG_R28	28
+#define KVX_REG_R29	29
+#define KVX_REG_R30	30
+#define KVX_REG_R31	31
+#define KVX_REG_R32	32
+#define KVX_REG_R33	33
+#define KVX_REG_R34	34
+#define KVX_REG_R35	35
+#define KVX_REG_R36	36
+#define KVX_REG_R37	37
+#define KVX_REG_R38	38
+#define KVX_REG_R39	39
+#define KVX_REG_R40	40
+#define KVX_REG_R41	41
+#define KVX_REG_R42	42
+#define KVX_REG_R43	43
+#define KVX_REG_R44	44
+#define KVX_REG_R45	45
+#define KVX_REG_R46	46
+#define KVX_REG_R47	47
+#define KVX_REG_R48	48
+#define KVX_REG_R49	49
+#define KVX_REG_R50	50
+#define KVX_REG_R51	51
+#define KVX_REG_R52	52
+#define KVX_REG_R53	53
+#define KVX_REG_R54	54
+#define KVX_REG_R55	55
+#define KVX_REG_R56	56
+#define KVX_REG_R57	57
+#define KVX_REG_R58	58
+#define KVX_REG_R59	59
+#define KVX_REG_R60	60
+#define KVX_REG_R61	61
+#define KVX_REG_R62	62
+#define KVX_REG_R63	63
+
+/* Value for bitfield parallel */
+#define KVX_INSN_PARALLEL_EOB	0x0
+#define KVX_INSN_PARALLEL_NONE	0x1
+
+#define KVX_INSN_PARALLEL(__insn)       (((__insn) >> 31) & 0x1)
+
+#define KVX_INSN_MAKE_IMM64_SIZE 3
+#define KVX_INSN_MAKE_IMM64_W64_CHECK(__val) \
+	(check_signed_imm(__val, 64))
+#define KVX_INSN_MAKE_IMM64_MASK_0 0xff030000
+#define KVX_INSN_MAKE_IMM64_OPCODE_0 0xe0000000
+#define KVX_INSN_MAKE_IMM64_SYLLABLE_0(__rw, __w64) \
+	(KVX_INSN_MAKE_IMM64_OPCODE_0 | (((__rw) & 0x3f) << 18) | (((__w64) & 0x3ff) << 6))
+#define KVX_INSN_MAKE_IMM64_MASK_1 0xe0000000
+#define KVX_INSN_MAKE_IMM64_OPCODE_1 0x80000000
+#define KVX_INSN_MAKE_IMM64_SYLLABLE_1(__w64) \
+	(KVX_INSN_MAKE_IMM64_OPCODE_1 | (((__w64) >> 10) & 0x7ffffff))
+#define KVX_INSN_MAKE_IMM64_SYLLABLE_2(__p, __w64) \
+	(((__p) << 31) | (((__w64) >> 37) & 0x7ffffff))
+#define KVX_INSN_MAKE_IMM64(__buf, __p, __rw, __w64) \
+do { \
+	(__buf)[0] = KVX_INSN_MAKE_IMM64_SYLLABLE_0(__rw, __w64); \
+	(__buf)[1] = KVX_INSN_MAKE_IMM64_SYLLABLE_1(__w64); \
+	(__buf)[2] = KVX_INSN_MAKE_IMM64_SYLLABLE_2(__p, __w64); \
+} while (0)
+
+#define KVX_INSN_ICALL_SIZE 1
+#define KVX_INSN_ICALL_MASK_0 0x7ffc0000
+#define KVX_INSN_ICALL_OPCODE_0 0xfdc0000
+#define KVX_INSN_ICALL_SYLLABLE_0(__p, __rz) \
+	(KVX_INSN_ICALL_OPCODE_0 | ((__p) << 31) | ((__rz) & 0x3f))
+#define KVX_INSN_ICALL(__buf, __p, __rz) \
+do { \
+	(__buf)[0] = KVX_INSN_ICALL_SYLLABLE_0(__p, __rz); \
+} while (0)
+
+#define KVX_INSN_IGOTO_SIZE 1
+#define KVX_INSN_IGOTO_MASK_0 0x7ffc0000
+#define KVX_INSN_IGOTO_OPCODE_0 0xfd80000
+#define KVX_INSN_IGOTO_SYLLABLE_0(__p, __rz) \
+	(KVX_INSN_IGOTO_OPCODE_0 | ((__p) << 31) | ((__rz) & 0x3f))
+#define KVX_INSN_IGOTO(__buf, __p, __rz) \
+do { \
+	(__buf)[0] = KVX_INSN_IGOTO_SYLLABLE_0(__p, __rz); \
+} while (0)
+
+#define KVX_INSN_CALL_SIZE 1
+#define KVX_INSN_CALL_PCREL27_CHECK(__val) \
+	(((__val) & BITMASK(2)) || check_signed_imm((__val) >> 2, 27))
+#define KVX_INSN_CALL_MASK_0 0x78000000
+#define KVX_INSN_CALL_OPCODE_0 0x18000000
+#define KVX_INSN_CALL_SYLLABLE_0(__p, __pcrel27) \
+	(KVX_INSN_CALL_OPCODE_0 | ((__p) << 31) | (((__pcrel27) >> 2) & 0x7ffffff))
+#define KVX_INSN_CALL(__buf, __p, __pcrel27) \
+do { \
+	(__buf)[0] = KVX_INSN_CALL_SYLLABLE_0(__p, __pcrel27); \
+} while (0)
+
+#define KVX_INSN_GOTO_SIZE 1
+#define KVX_INSN_GOTO_PCREL27_CHECK(__val) \
+	(((__val) & BITMASK(2)) || check_signed_imm((__val) >> 2, 27))
+#define KVX_INSN_GOTO_MASK_0 0x78000000
+#define KVX_INSN_GOTO_OPCODE_0 0x10000000
+#define KVX_INSN_GOTO_SYLLABLE_0(__p, __pcrel27) \
+	(KVX_INSN_GOTO_OPCODE_0 | ((__p) << 31) | (((__pcrel27) >> 2) & 0x7ffffff))
+#define KVX_INSN_GOTO(__buf, __p, __pcrel27) \
+do { \
+	(__buf)[0] = KVX_INSN_GOTO_SYLLABLE_0(__p, __pcrel27); \
+} while (0)
+
+#define KVX_INSN_NOP_SIZE 1
+#define KVX_INSN_NOP_MASK_0 0x7f03f000
+#define KVX_INSN_NOP_OPCODE_0 0x7f03f000
+#define KVX_INSN_NOP_SYLLABLE_0(__p) \
+	(KVX_INSN_NOP_OPCODE_0 | ((__p) << 31))
+#define KVX_INSN_NOP(__buf, __p) \
+do { \
+	(__buf)[0] = KVX_INSN_NOP_SYLLABLE_0(__p); \
+} while (0)
+
+#define KVX_INSN_SET_SIZE 1
+#define KVX_INSN_SET_MASK_0 0x7ffc0000
+#define KVX_INSN_SET_OPCODE_0 0xfc00000
+#define KVX_INSN_SET_SYLLABLE_0(__p, __systemT3, __rz) \
+	(KVX_INSN_SET_OPCODE_0 | ((__p) << 31) | (((__systemT3) & 0x1ff) << 6) | ((__rz) & 0x3f))
+#define KVX_INSN_SET(__buf, __p, __systemT3, __rz) \
+do { \
+	(__buf)[0] = KVX_INSN_SET_SYLLABLE_0(__p, __systemT3, __rz); \
+} while (0)
+
+#endif /* __ASM_KVX_INSNS_DEFS_H_ */
diff --git a/arch/kvx/kernel/break_hook.c b/arch/kvx/kernel/break_hook.c
new file mode 100644
index 000000000000..da38910dab04
--- /dev/null
+++ b/arch/kvx/kernel/break_hook.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
+
+#include <asm/traps.h>
+#include <asm/processor.h>
+#include <asm/break_hook.h>
+
+static DEFINE_SPINLOCK(debug_hook_lock);
+static LIST_HEAD(user_break_hook);
+static LIST_HEAD(kernel_break_hook);
+
+void kvx_skip_break_insn(struct pt_regs *regs)
+{
+	regs->spc += KVX_BREAK_INSN_SIZE;
+}
+
+int break_hook_handler(uint64_t es, struct pt_regs *regs)
+{
+	int (*fn)(struct break_hook *brk_hook, struct pt_regs *regs) = NULL;
+	struct break_hook *tmp_hook, *hook = NULL;
+	struct list_head *list;
+	unsigned long flags;
+	u32 idx;
+
+	if (trap_sfri(es) != KVX_TRAP_SFRI_SET ||
+	    trap_sfrp(es) != KVX_SFR_VSFR0)
+		return BREAK_HOOK_ERROR;
+
+	idx = trap_gprp(es);
+	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
+
+	local_irq_save(flags);
+	list_for_each_entry_rcu(tmp_hook, list, node) {
+		if (idx == tmp_hook->id) {
+			hook = tmp_hook;
+			break;
+		}
+	}
+	local_irq_restore(flags);
+
+	if (!hook)
+		return BREAK_HOOK_ERROR;
+
+	fn = hook->handler;
+	return fn(hook, regs);
+}
+
+void break_hook_register(struct break_hook *brk_hook)
+{
+	struct list_head *list;
+
+	if (brk_hook->mode == MODE_USER)
+		list = &user_break_hook;
+	else
+		list = &kernel_break_hook;
+
+	spin_lock(&debug_hook_lock);
+	list_add_rcu(&brk_hook->node, list);
+	spin_unlock(&debug_hook_lock);
+}
+
+void break_hook_unregister(struct break_hook *brk_hook)
+{
+	spin_lock(&debug_hook_lock);
+	list_del_rcu(&brk_hook->node);
+	spin_unlock(&debug_hook_lock);
+	synchronize_rcu();
+}
diff --git a/arch/kvx/kernel/debug.c b/arch/kvx/kernel/debug.c
new file mode 100644
index 000000000000..d4cde403bca9
--- /dev/null
+++ b/arch/kvx/kernel/debug.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
+
+#include <asm/dame.h>
+#include <asm/debug.h>
+
+static DEFINE_SPINLOCK(debug_hook_lock);
+static LIST_HEAD(user_debug_hook);
+static LIST_HEAD(kernel_debug_hook);
+
+static struct list_head *debug_hook_list(bool user_mode)
+{
+	return user_mode ? &user_debug_hook : &kernel_debug_hook;
+}
+
+static void call_debug_hook(u64 ea, struct pt_regs *regs)
+{
+	int ret;
+	struct debug_hook *hook;
+	struct list_head *list = debug_hook_list(user_mode(regs));
+
+	list_for_each_entry_rcu(hook, list, node) {
+		ret = hook->handler(ea, regs);
+		if (ret == DEBUG_HOOK_HANDLED)
+			return;
+	}
+
+	panic("Entered debug but no requester !");
+}
+
+void debug_hook_register(struct debug_hook *dbg_hook)
+{
+	struct list_head *list = debug_hook_list(dbg_hook->mode == MODE_USER);
+
+	spin_lock(&debug_hook_lock);
+	list_add_rcu(&dbg_hook->node, list);
+	spin_unlock(&debug_hook_lock);
+}
+
+void debug_hook_unregister(struct debug_hook *dbg_hook)
+{
+	spin_lock(&debug_hook_lock);
+	list_del_rcu(&dbg_hook->node);
+	spin_unlock(&debug_hook_lock);
+	synchronize_rcu();
+}
+
+/**
+ * Main debug handler called by the _debug_handler routine in entry.S
+ * This handler will perform the required action
+ */
+void debug_handler(u64 ea, struct pt_regs *regs)
+{
+	trace_hardirqs_off();
+	call_debug_hook(ea, regs);
+	dame_irq_check(regs);
+}
diff --git a/arch/kvx/kernel/insns.c b/arch/kvx/kernel/insns.c
new file mode 100644
index 000000000000..361621552cd5
--- /dev/null
+++ b/arch/kvx/kernel/insns.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ *            Marius Gligor
+ *            Guillaume Thouvenin
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/atomic.h>
+#include <linux/cpumask.h>
+#include <linux/uaccess.h>
+#include <linux/stop_machine.h>
+
+#include <asm/cacheflush.h>
+#include <asm/insns_defs.h>
+#include <asm/fixmap.h>
+
+struct insns_patch {
+	atomic_t cpu_count;
+	u32 *addr;
+	u32 *insns;
+	unsigned long insns_len;
+};
+
+static void *insn_patch_map(void *addr)
+{
+	unsigned long uintaddr = (uintptr_t) addr;
+	bool module = !core_kernel_text(uintaddr);
+	struct page *page;
+
+	if (module && IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		page = vmalloc_to_page(addr);
+	else
+		return addr;
+
+	BUG_ON(!page);
+	return (void *)set_fixmap_offset(FIX_TEXT_PATCH, page_to_phys(page) +
+			(uintaddr & ~PAGE_MASK));
+}
+
+static void insn_patch_unmap(void)
+{
+	clear_fixmap(FIX_TEXT_PATCH);
+}
+
+int kvx_insns_write_nostop(u32 *insns, u8 insns_len, u32 *insn_addr)
+{
+	unsigned long current_insn_addr = (unsigned long) insn_addr;
+	unsigned long len_remain = insns_len;
+	unsigned long next_insn_page, patch_len;
+	void *map_patch_addr;
+	int ret = 0;
+
+	do {
+		/* Compute next upper page boundary */
+		next_insn_page = (current_insn_addr + PAGE_SIZE) & PAGE_MASK;
+
+		patch_len = min(next_insn_page - current_insn_addr, len_remain);
+		len_remain -= patch_len;
+
+		/* Map & patch insns */
+		map_patch_addr = insn_patch_map((void *) current_insn_addr);
+		ret = copy_to_kernel_nofault(map_patch_addr, insns, patch_len);
+		if (ret)
+			break;
+
+		insns = (void *) insns + patch_len;
+		current_insn_addr = next_insn_page;
+
+	} while (len_remain);
+
+	insn_patch_unmap();
+
+	/*
+	 * Flush & invalidate L2 + L1 icache to reload instructions from memory
+	 * L2 wbinval is necessary because we write through DEVICE cache policy
+	 * mapping which is uncached therefore L2 is bypassed
+	 */
+	wbinval_icache_range(virt_to_phys(insn_addr), insns_len);
+
+	return ret;
+}
+
+static int patch_insns_percpu(void *data)
+{
+	struct insns_patch *ip = data;
+	unsigned long insn_addr = (unsigned long) ip->addr;
+	int ret;
+
+	if (atomic_inc_return(&ip->cpu_count) == 1) {
+		ret = kvx_insns_write_nostop(ip->insns, ip->insns_len,
+					     ip->addr);
+		/* Additionnal up to release other processors */
+		atomic_inc(&ip->cpu_count);
+
+		return ret;
+	}
+
+	/* Wait for first processor to update instructions */
+	while (atomic_read(&ip->cpu_count) <= num_online_cpus())
+		cpu_relax();
+
+	/* Simply invalidate L1 I-cache to reload from L2 or memory */
+	l1_inval_icache_range(insn_addr, insn_addr + ip->insns_len);
+	return 0;
+}
+
+/**
+ * kvx_insns_write() Patch instructions at a specified address
+ * @insns: Instructions to be written at @addr
+ * @insns_len: Size of instructions to patch
+ * @addr: Address of the first instruction to patch
+ */
+int kvx_insns_write(u32 *insns, unsigned long insns_len, u32 *addr)
+{
+	struct insns_patch ip = {
+		.cpu_count = ATOMIC_INIT(0),
+		.addr = addr,
+		.insns = insns,
+		.insns_len = insns_len
+	};
+
+	if (!insns_len)
+		return -EINVAL;
+
+	if (!IS_ALIGNED((unsigned long) addr, KVX_INSN_SYLLABLE_WIDTH))
+		return -EINVAL;
+
+	/*
+	 * Function name is a "bit" misleading. while being named
+	 * stop_machine, this function does not stop the machine per se
+	 * but execute the provided function on all CPU in a safe state.
+	 */
+	return stop_machine(patch_insns_percpu, &ip, cpu_online_mask);
+}
+
+int kvx_insns_read(u32 *insns, unsigned long insns_len, u32 *addr)
+{
+	l1_inval_dcache_range((unsigned long)addr, insns_len);
+	return copy_from_kernel_nofault(insns, addr, insns_len);
+}
-- 
2.37.2






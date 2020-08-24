Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E91250791
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 20:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHXS27 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 14:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgHXS2z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 14:28:55 -0400
Received: from localhost.localdomain (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAA5120738;
        Mon, 24 Aug 2020 18:28:51 +0000 (UTC)
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
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Hayward <Alan.Hayward@arm.com>,
        Luis Machado <luis.machado@linaro.org>,
        Omair Javaid <omair.javaid@linaro.org>
Subject: [PATCH v8 22/28] arm64: mte: ptrace: Add NT_ARM_TAGGED_ADDR_CTRL regset
Date:   Mon, 24 Aug 2020 19:27:52 +0100
Message-Id: <20200824182758.27267-23-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824182758.27267-1-catalin.marinas@arm.com>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This regset allows read/write access to a ptraced process
prctl(PR_SET_TAGGED_ADDR_CTRL) setting.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Alan Hayward <Alan.Hayward@arm.com>
Cc: Luis Machado <luis.machado@linaro.org>
Cc: Omair Javaid <omair.javaid@linaro.org>
---

Notes:
    v8:
    - Removed user_regset_copyout().
    
    New in v7.

 arch/arm64/kernel/ptrace.c | 42 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 101040a37d40..f49b349e16a3 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1033,6 +1033,35 @@ static int pac_generic_keys_set(struct task_struct *target,
 #endif /* CONFIG_CHECKPOINT_RESTORE */
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
+#ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
+static int tagged_addr_ctrl_get(struct task_struct *target,
+				const struct user_regset *regset,
+				struct membuf to)
+{
+	long ctrl = get_tagged_addr_ctrl(target);
+
+	if (IS_ERR_VALUE(ctrl))
+		return ctrl;
+
+	return membuf_write(&to, &ctrl, sizeof(ctrl));
+}
+
+static int tagged_addr_ctrl_set(struct task_struct *target, const struct
+				user_regset *regset, unsigned int pos,
+				unsigned int count, const void *kbuf, const
+				void __user *ubuf)
+{
+	int ret;
+	long ctrl;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ctrl, 0, -1);
+	if (ret)
+		return ret;
+
+	return set_tagged_addr_ctrl(target, ctrl);
+}
+#endif
+
 enum aarch64_regset {
 	REGSET_GPR,
 	REGSET_FPR,
@@ -1052,6 +1081,9 @@ enum aarch64_regset {
 	REGSET_PACG_KEYS,
 #endif
 #endif
+#ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
+	REGSET_TAGGED_ADDR_CTRL,
+#endif
 };
 
 static const struct user_regset aarch64_regsets[] = {
@@ -1149,6 +1181,16 @@ static const struct user_regset aarch64_regsets[] = {
 	},
 #endif
 #endif
+#ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
+	[REGSET_TAGGED_ADDR_CTRL] = {
+		.core_note_type = NT_ARM_TAGGED_ADDR_CTRL,
+		.n = 1,
+		.size = sizeof(long),
+		.align = sizeof(long),
+		.regset_get = tagged_addr_ctrl_get,
+		.set = tagged_addr_ctrl_set,
+	},
+#endif
 };
 
 static const struct user_regset_view user_aarch64_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 22220945a5fd..30f68b42eeb5 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -425,6 +425,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_PAC_MASK		0x406	/* ARM pointer authentication code masks */
 #define NT_ARM_PACA_KEYS	0x407	/* ARM pointer authentication address keys */
 #define NT_ARM_PACG_KEYS	0x408	/* ARM pointer authentication generic key */
+#define NT_ARM_TAGGED_ADDR_CTRL	0x409	/* arm64 tagged address control (prctl()) */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */

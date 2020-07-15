Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E27221353
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgGORJp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 13:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgGORJo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 13:09:44 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF7A12075F;
        Wed, 15 Jul 2020 17:09:41 +0000 (UTC)
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
Subject: [PATCH v7 23/29] arm64: mte: ptrace: Add NT_ARM_TAGGED_ADDR_CTRL regset
Date:   Wed, 15 Jul 2020 18:08:38 +0100
Message-Id: <20200715170844.30064-24-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200715170844.30064-1-catalin.marinas@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
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
    New in v7.

 arch/arm64/kernel/ptrace.c | 44 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h   |  1 +
 2 files changed, 45 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 653a03598c75..e21ce360348b 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1108,6 +1108,37 @@ static int pac_generic_keys_set(struct task_struct *target,
 #endif /* CONFIG_CHECKPOINT_RESTORE */
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
+#ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
+static int tagged_addr_ctrl_get(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				void *kbuf, void __user *ubuf)
+{
+	long ctrl = get_tagged_addr_ctrl(target);
+
+	if (IS_ERR_VALUE(ctrl))
+		return ctrl;
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &ctrl, 0, -1);
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
@@ -1127,6 +1158,9 @@ enum aarch64_regset {
 	REGSET_PACG_KEYS,
 #endif
 #endif
+#ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
+	REGSET_TAGGED_ADDR_CTRL,
+#endif
 };
 
 static const struct user_regset aarch64_regsets[] = {
@@ -1225,6 +1259,16 @@ static const struct user_regset aarch64_regsets[] = {
 	},
 #endif
 #endif
+#ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
+	[REGSET_TAGGED_ADDR_CTRL] = {
+		.core_note_type = NT_ARM_TAGGED_ADDR_CTRL,
+		.n = 1,
+		.size = sizeof(long),
+		.align = sizeof(long),
+		.get = tagged_addr_ctrl_get,
+		.set = tagged_addr_ctrl_set,
+	},
+#endif
 };
 
 static const struct user_regset_view user_aarch64_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index c6dd0215482e..0a806c1c4a02 100644
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

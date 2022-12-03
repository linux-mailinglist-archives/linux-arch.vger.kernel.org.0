Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C522464194E
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 22:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiLCVzs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Dec 2022 16:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiLCVzn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Dec 2022 16:55:43 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA4E193DD
        for <linux-arch@vger.kernel.org>; Sat,  3 Dec 2022 13:55:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f13so12751863lfa.6
        for <linux-arch@vger.kernel.org>; Sat, 03 Dec 2022 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi3n+kVrXBjnnt2095tFaJL6C3hilfYYv1s6JmrGtDA=;
        b=DHnhbDCkwpaYJypY3u45GL2dEzYe9OvjwSsQnxfDZjvxD3L7Hic9IA1omRlPFl4HOA
         y5Npl2QD+K+SBQrgPu0iWtH3RyBdb6ie2rNBESeG016OKu+NatAzAfdBDsjSFlfGG4VL
         8oE1NDr/FUO6RjnbGsZ/Mtc3Emg2EakyUX0Zl83Nzd9cTxuof1HAI67ITbB9btJXahy2
         zSGHLbwJX7IbgNSKRCrVNFT+wMJRi1VcgRz/ENQFN0yBeLtCbHgPhfvsZfTqws+nuv/A
         MgnYYNJ4u0wY6khEwOoeCp0g0UzCZV5xj9TLGAzvJ+5Tvep7DHCzmIUus6LXjafXDHdp
         K9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wi3n+kVrXBjnnt2095tFaJL6C3hilfYYv1s6JmrGtDA=;
        b=tSm0GzDdLswReV485rNl+dEn9r8Yjl/hCkrHyWH0IWyv5QlXiVqfFnjwK7RiMNN4sV
         0KXckh7sBYv5bqLfOqCuVq8CHvPf/PnSWbaEAsm1M35PEisjauqHEOX8ZjLpcAJdrNGU
         9bpGUYM1kXWdoOZWy+BhoCfangiNQ8laGP2tMbPE61cAM65XAHIdyOVk/eicPFocd1D8
         T55rr8oit9wT3vDzYfH94aogXoJbAo9oZUZI4CXvcADoepRhm5wS20ZIYXsTZY45Mwpb
         vBoVm69AqmvbuW8/FKc/heSfmI7K5aK8vHraWCP1mVAn0Q6Bp7EW1nauHJ0EK5iFlqT7
         SIMw==
X-Gm-Message-State: ANoB5pmTSQN5XgVr3+ZNhHyrKD8f3SE1meP3zvMIgf+1ECAv1koQHKMX
        HUihj1FRLTbRSSOGnt6/GvI=
X-Google-Smtp-Source: AA0mqf79CvR9u4+RKnhgFwjZy47L3B0GO+4w84mPLQDsLK2GAZaas1mlZKf1QyJngmadu1QfJzaPHA==
X-Received: by 2002:ac2:508d:0:b0:4a4:72b0:9a2b with SMTP id f13-20020ac2508d000000b004a472b09a2bmr24434251lfm.469.1670104540605;
        Sat, 03 Dec 2022 13:55:40 -0800 (PST)
Received: from localhost.localdomain ([5.188.167.245])
        by smtp.googlemail.com with ESMTPSA id j2-20020a056512344200b004b4f2a30e6csm1537002lfr.0.2022.12.03.13.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 13:55:39 -0800 (PST)
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Subject: [PATCH RFC v2 2/3] riscv: ptrace: expose hardware breakpoints to debuggers
Date:   Sun,  4 Dec 2022 00:55:34 +0300
Message-Id: <20221203215535.208948-3-geomatsi@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203215535.208948-1-geomatsi@gmail.com>
References: <20221203215535.208948-1-geomatsi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sergey Matyukevich <sergey.matyukevich@syntacore.com>

Implement regset-based ptrace interface that exposes hardware
breakpoints to user-space debuggers.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
---
 arch/riscv/include/uapi/asm/ptrace.h |   9 ++
 arch/riscv/kernel/process.c          |   2 +
 arch/riscv/kernel/ptrace.c           | 188 +++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index 882547f6bd5c..e7a5e1b9ea58 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -77,6 +77,15 @@ union __riscv_fp_state {
 	struct __riscv_q_ext_state q;
 };
 
+struct user_hwdebug_state {
+	__u64     dbg_info;
+	struct {
+		__u64 addr;
+		__u64 type;
+		__u64 len;
+	}       dbg_regs[16];
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index cd99bececed8..b66936b02caf 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -15,6 +15,7 @@
 #include <linux/tick.h>
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
+#include <linux/hw_breakpoint.h>
 
 #include <asm/unistd.h>
 #include <asm/processor.h>
@@ -148,6 +149,7 @@ void flush_thread(void)
 	fstate_off(current, task_pt_regs(current));
 	memset(&current->thread.fstate, 0, sizeof(current->thread.fstate));
 #endif
+	flush_ptrace_hw_breakpoint(current);
 }
 
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 2ae8280ae475..9bdc70ad7819 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -18,6 +18,7 @@
 #include <linux/regset.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
+#include <linux/hw_breakpoint.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -27,6 +28,10 @@ enum riscv_regset {
 #ifdef CONFIG_FPU
 	REGSET_F,
 #endif
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	REGSET_HW_BREAK,
+	REGSET_HW_WATCH,
+#endif
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -83,6 +88,170 @@ static int riscv_fpr_set(struct task_struct *target,
 }
 #endif
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+static void ptrace_hbptriggered(struct perf_event *bp,
+				struct perf_sample_data *data,
+				struct pt_regs *regs)
+{
+	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
+
+	force_sig_fault(SIGTRAP, TRAP_HWBKPT, (void __user *)bkpt->address);
+}
+
+static int hw_break_get(struct task_struct *target,
+			const struct user_regset *regset,
+			struct membuf to)
+{
+	/* send total number of h/w debug triggers */
+	u64 count = hw_breakpoint_slots(regset->core_note_type);
+
+	membuf_write(&to, &count, sizeof(count));
+	return 0;
+}
+
+static inline int hw_break_empty(u64 addr, u64 type, u64 size)
+{
+	/* TODO: for now adjusted to current riscv-gdb behavior */
+	return (!addr && !size);
+}
+
+static int hw_break_setup_trigger(struct task_struct *target, u64 addr,
+				  u64 type, u64 size, int idx)
+{
+	struct perf_event *bp = ERR_PTR(-EINVAL);
+	struct perf_event_attr attr;
+	u32 bp_type;
+	u64 bp_len;
+
+	if (!hw_break_empty(addr, type, size)) {
+		/* bp size: gdb to kernel */
+		switch (size) {
+		case 2:
+			bp_len = HW_BREAKPOINT_LEN_2;
+			break;
+		case 4:
+			bp_len = HW_BREAKPOINT_LEN_4;
+			break;
+		case 8:
+			bp_len = HW_BREAKPOINT_LEN_8;
+			break;
+		default:
+			pr_warn("%s: unsupported size: %llu\n", __func__, size);
+			return -EINVAL;
+		}
+
+		/* bp type: gdb to kernel */
+		switch (type) {
+		case 0:
+			bp_type = HW_BREAKPOINT_X;
+			break;
+		case 1:
+			bp_type = HW_BREAKPOINT_R;
+			break;
+		case 2:
+			bp_type = HW_BREAKPOINT_W;
+			break;
+		case 3:
+			bp_type = HW_BREAKPOINT_RW;
+			break;
+		default:
+			pr_warn("%s: unsupported type: %llu\n", __func__, type);
+			return -EINVAL;
+		}
+	}
+
+	bp = target->thread.ptrace_bps[idx];
+	if (bp) {
+		attr = bp->attr;
+
+		if (hw_break_empty(addr, type, size)) {
+			attr.disabled = 1;
+		} else {
+			attr.bp_type = bp_type;
+			attr.bp_addr = addr;
+			attr.bp_len = bp_len;
+			attr.disabled = 0;
+		}
+
+		return modify_user_hw_breakpoint(bp, &attr);
+	}
+
+	if (hw_break_empty(addr, type, size))
+		return 0;
+
+	ptrace_breakpoint_init(&attr);
+	attr.bp_type = bp_type;
+	attr.bp_addr = addr;
+	attr.bp_len = bp_len;
+
+	bp = register_user_hw_breakpoint(&attr, ptrace_hbptriggered,
+					 NULL, target);
+	if (IS_ERR(bp))
+		return PTR_ERR(bp);
+
+	target->thread.ptrace_bps[idx] = bp;
+	return 0;
+}
+
+static int hw_break_set(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			const void *kbuf, const void __user *ubuf)
+{
+	int ret, idx = 0, offset, limit;
+	u64 addr;
+	u64 type;
+	u64 size;
+
+#define PTRACE_HBP_ADDR_SZ	sizeof(u64)
+#define PTRACE_HBP_TYPE_SZ	sizeof(u64)
+#define PTRACE_HBP_SIZE_SZ	sizeof(u64)
+
+	/* Resource info and pad */
+	offset = offsetof(struct user_hwdebug_state, dbg_regs);
+	ret = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf, 0, offset);
+	if (ret)
+		return ret;
+
+	/* trigger settings */
+	limit = regset->n * regset->size;
+	while (count && offset < limit) {
+		if (count < PTRACE_HBP_ADDR_SZ)
+			return -EINVAL;
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &addr,
+					 offset, offset + PTRACE_HBP_ADDR_SZ);
+		if (ret)
+			return ret;
+
+		offset += PTRACE_HBP_ADDR_SZ;
+
+		if (!count)
+			break;
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &type,
+					 offset, offset + PTRACE_HBP_TYPE_SZ);
+		if (ret)
+			return ret;
+
+		offset += PTRACE_HBP_TYPE_SZ;
+
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &size,
+					 offset, offset + PTRACE_HBP_SIZE_SZ);
+		if (ret)
+			return ret;
+
+		offset += PTRACE_HBP_SIZE_SZ;
+
+		ret = hw_break_setup_trigger(target, addr, type, size, idx);
+		if (ret)
+			return ret;
+
+		idx++;
+	}
+
+	return 0;
+}
+#endif
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		.core_note_type = NT_PRSTATUS,
@@ -102,6 +271,25 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = riscv_fpr_set,
 	},
 #endif
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	[REGSET_HW_BREAK] = {
+		.core_note_type = NT_ARM_HW_BREAK,
+		.n = sizeof(struct user_hwdebug_state) / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.regset_get = hw_break_get,
+		.set = hw_break_set,
+	},
+	[REGSET_HW_WATCH] = {
+		.core_note_type = NT_ARM_HW_WATCH,
+		.n = sizeof(struct user_hwdebug_state) / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.regset_get = hw_break_get,
+		.set = hw_break_set,
+	},
+#endif
+
 };
 
 static const struct user_regset_view riscv_user_native_view = {
-- 
2.38.1


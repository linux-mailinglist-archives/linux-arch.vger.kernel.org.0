Return-Path: <linux-arch+bounces-3426-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85326897C91
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 01:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DD01F21C75
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 23:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7FF15B142;
	Wed,  3 Apr 2024 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cFwHQCUv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0456115B124
	for <linux-arch@vger.kernel.org>; Wed,  3 Apr 2024 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187762; cv=none; b=MaKVhmZQXLuhsxp28SwGynwWr4mS0fOc7Gx7+LlKfIUajZ4096JU81GJDg49vlAgk2E072fIVqu5eeQ5HZRtW9cnS2/ckTUloS4CpaHe6Ro7YnHZR9ExnxZHa+FCHvz1ZgrXEcJd37Kasj8j1F85rPW+uuM8IE32s/F7bfvFGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187762; c=relaxed/simple;
	bh=NwxAiZ0YCizIIW2hyNtK6wrcmJT3VuR5xXwwHrshYfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/f9rrxpTsrUPzIxkvrnbGK/95YV89V093TGfqkru1vCDCbMp5R5B9RmjJPdGdWRwV43MpoMZybviA90BuUhPamsATD+LaO/S6Jlu0cyK/jyKQ5cBJ928PvRfaKLz4zo5koLDlXka+vYPS8RBeOwUzEFIIRRmbxOuTkKtwrMkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cFwHQCUv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e244c7cbf8so3460445ad.0
        for <linux-arch@vger.kernel.org>; Wed, 03 Apr 2024 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187759; x=1712792559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Khz8ikyQpN700q+teRby/p+dyzEQ886SCy2AoWH5oD0=;
        b=cFwHQCUvGNARqJN730BjaZ9lX/f5E77yxqV7Bjpfgtlo09q3Yh9WoMAC5dDTZaTEB0
         J7/wJrAOAalFUEqE1vE1bCGW30ItMJ5yB6MM1pMfNmDjHDClb1B0b1y0/KM73liYTB7J
         TO0+s3PjlVI3B5Ny5vasj6LF72RqwW9UWQqISviPFF0p7QEX0zyOSZxwK6njTFm130yT
         iAhOrtwDg2beGaaLLk2975DB/rlVo6ECf25b/ZIWz9f9r6uZvKJNaWZuv7+rsRrm4I/v
         5O/v6f9ijtw73oMM/JeMEcp4kfroyDt4i++PnR51MAkPcSfhpEafZpV+S4b6A9TMdNAY
         QozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187759; x=1712792559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Khz8ikyQpN700q+teRby/p+dyzEQ886SCy2AoWH5oD0=;
        b=A/S8A2DYv9QzBUIQU+rh9iAPQzXGlD7tdXdcsXE2SES8Sn2GPKDTgOwA/BS6pxn0N5
         d2VKf94KriirHCTroSOVHY6Piq6m+wxvmaRWgmjkuOD5uiEWEn9tqaJ1p9lFA04Z1XXr
         I3TybH//9PrdBA7T3nC/UfIA/Q7t5bAx8EJqAN5n6VL4i2wg+ZO6FNsiyz1qIUB3k6Bo
         wcE09dZqobl/vWXvRH2owwBP9WTUayKDUkJ080i8TU0VrQ7xarxu90UzqYu9KmI2qXwy
         wZs9WjBHu27m8uRI5vlAXwqk+gwAv5/+8wPPGRphRMtYFAwQ4aGksf0RrDRowT5MEeQJ
         Vl/A==
X-Forwarded-Encrypted: i=1; AJvYcCVifBKDKAgfWal5p4chVuIYin2l1+1jyd9HnnPvJrCUs+LmrDCU0UMrlMVrzr2pXkSXyQdRXQQX8T/T9kh58ka6EaSNIWOM6Alxvg==
X-Gm-Message-State: AOJu0YwQMsAbfLBXCXK7iBTVP/E1YVR0kmGbrcVVYjEibQag9iBwZ84D
	iae4iE0dF1UPVFSvkqnIgbwhDFuaaQ0G7o3JPyRsyrvKkf8wIsIf6Msm8RHOeEQ=
X-Google-Smtp-Source: AGHT+IE68qWmATPhXV1Rat+Ver9WaYarHZF7n/8/iZq8gRLxh8kCGb8Ckpz5WZ6DY6GOuSzrKLE5Sg==
X-Received: by 2002:a17:902:e5d2:b0:1dd:c288:899f with SMTP id u18-20020a170902e5d200b001ddc288899fmr843683plf.18.1712187759354;
        Wed, 03 Apr 2024 16:42:39 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:42:38 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	conor@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v3 23/29] riscv signal: Save and restore of shadow stack for signal
Date: Wed,  3 Apr 2024 16:35:11 -0700
Message-ID: <20240403234054.2020347-24-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403234054.2020347-1-debug@rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save shadow stack pointer in sigcontext structure while delivering signal.
Restore shadow stack pointer from sigcontext on sigreturn.

As part of save operation, kernel uses `ssamoswap` to save snapshot of
current shadow stack on shadow stack itself (can be called as a save
token). During restore on sigreturn, kernel retrieves token from top of
shadow stack and validates it. This allows that user mode can't arbitrary
pivot to any shadow stack address without having a token and thus provide
strong security assurance between signaly delivery and sigreturn window.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/usercfi.h | 19 +++++++++++
 arch/riscv/kernel/signal.c       | 45 +++++++++++++++++++++++++
 arch/riscv/kernel/usercfi.c      | 57 ++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)

diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index 8accdc8ec164..507a27d5f53c 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -8,6 +8,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 #include <linux/prctl.h>
+#include <linux/errno.h>
 
 struct task_struct;
 struct kernel_clone_args;
@@ -35,6 +36,9 @@ void set_shstk_status(struct task_struct *task, bool enable);
 bool is_indir_lp_enabled(struct task_struct *task);
 bool is_indir_lp_locked(struct task_struct *task);
 void set_indir_lp_status(struct task_struct *task, bool enable);
+unsigned long get_active_shstk(struct task_struct *task);
+int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr);
+int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr);
 
 #define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK (PR_SHADOW_STACK_ENABLE)
 
@@ -77,6 +81,16 @@ static inline void set_shstk_status(struct task_struct *task, bool enable)
 
 }
 
+static inline int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr)
+{
+	return -EINVAL;
+}
+
+static inline int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr)
+{
+	return -EINVAL;
+}
+
 static inline bool is_indir_lp_enabled(struct task_struct *task)
 {
 	return false;
@@ -92,6 +106,11 @@ static inline void set_indir_lp_status(struct task_struct *task, bool enable)
 
 }
 
+static inline unsigned long get_active_shstk(struct task_struct *task)
+{
+	return 0;
+}
+
 #endif /* CONFIG_RISCV_USER_CFI */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 501e66debf69..428a886ab6ef 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -22,6 +22,7 @@
 #include <asm/vector.h>
 #include <asm/csr.h>
 #include <asm/cacheflush.h>
+#include <asm/usercfi.h>
 
 unsigned long signal_minsigstksz __ro_after_init;
 
@@ -232,6 +233,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe __user *frame;
 	struct task_struct *task;
+	unsigned long ss_ptr = 0;
 	sigset_t set;
 	size_t frame_size = get_rt_frame_size(false);
 
@@ -254,6 +256,26 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
+	/*
+	 * Restore shadow stack as a form of token stored on shadow stack itself as a safe
+	 * way to restore.
+	 * A token on shadow gives following properties
+	 *	- Safe save and restore for shadow stack switching. Any save of shadow stack
+	 *	  must have had saved a token on shadow stack. Similarly any restore of shadow
+	 *	  stack must check the token before restore. Since writing to shadow stack with
+	 *	  address of shadow stack itself is not easily allowed. A restore without a save
+	 *	  is quite difficult for an attacker to perform.
+	 *	- A natural break. A token in shadow stack provides a natural break in shadow stack
+	 *	  So a single linear range can be bucketed into different shadow stack segments.
+	 *	  sspopchk will detect the condition and fault to kernel as sw check exception.
+	 */
+	if (__copy_from_user(&ss_ptr, &frame->uc.uc_mcontext.sc_cfi_state.ss_ptr,
+						 sizeof(unsigned long)))
+		goto badframe;
+
+	if (is_shstk_enabled(current) && restore_user_shstk(current, ss_ptr))
+		goto badframe;
+
 	regs->cause = -1UL;
 
 	return regs->a0;
@@ -323,6 +345,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	struct rt_sigframe __user *frame;
 	long err = 0;
 	unsigned long __maybe_unused addr;
+	unsigned long ss_ptr = 0;
 	size_t frame_size = get_rt_frame_size(false);
 
 	frame = get_sigframe(ksig, regs, frame_size);
@@ -334,6 +357,23 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	/* Create the ucontext. */
 	err |= __put_user(0, &frame->uc.uc_flags);
 	err |= __put_user(NULL, &frame->uc.uc_link);
+	/*
+	 * Save a pointer to shadow stack itself on shadow stack as a form of token.
+	 * A token on shadow gives following properties
+	 *	- Safe save and restore for shadow stack switching. Any save of shadow stack
+	 *	  must have had saved a token on shadow stack. Similarly any restore of shadow
+	 *	  stack must check the token before restore. Since writing to shadow stack with
+	 *	  address of shadow stack itself is not easily allowed. A restore without a save
+	 *	  is quite difficult for an attacker to perform.
+	 *	- A natural break. A token in shadow stack provides a natural break in shadow stack
+	 *	  So a single linear range can be bucketed into different shadow stack segments. Any
+	 *	  sspopchk will detect the condition and fault to kernel as sw check exception.
+	 */
+	if (is_shstk_enabled(current)) {
+		err |= save_user_shstk(current, &ss_ptr);
+		err |= __put_user(ss_ptr, &frame->uc.uc_mcontext.sc_cfi_state.ss_ptr);
+	}
+
 	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
 	err |= setup_sigcontext(frame, regs);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
@@ -344,6 +384,11 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 #ifdef CONFIG_MMU
 	regs->ra = (unsigned long)VDSO_SYMBOL(
 		current->mm->context.vdso, rt_sigreturn);
+
+	/* if bcfi is enabled x1 (ra) and x5 (t0) must match. not sure if we need this? */
+	if (is_shstk_enabled(current))
+		regs->t0 = regs->ra;
+
 #else
 	/*
 	 * For the nommu case we don't have a VDSO.  Instead we push two
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 13920b9d86f3..db5b32500050 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -52,6 +52,11 @@ void set_active_shstk(struct task_struct *task, unsigned long shstk_addr)
 	task->thread_info.user_cfi_state.user_shdw_stk = shstk_addr;
 }
 
+unsigned long get_active_shstk(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.user_shdw_stk;
+}
+
 void set_shstk_status(struct task_struct *task, bool enable)
 {
 	task->thread_info.user_cfi_state.ubcfi_en = enable ? 1 : 0;
@@ -168,6 +173,58 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
 	return 0;
 }
 
+/*
+ * Save user shadow stack pointer on shadow stack itself and return pointer to saved location
+ * returns -EFAULT if operation was unsuccessful
+ */
+int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr)
+{
+	unsigned long ss_ptr = 0;
+	unsigned long token_loc = 0;
+	int ret = 0;
+
+	if (saved_shstk_ptr == NULL)
+		return -EINVAL;
+
+	ss_ptr = get_active_shstk(tsk);
+	ret = create_rstor_token(ss_ptr, &token_loc);
+
+	if (!ret) {
+		*saved_shstk_ptr = token_loc;
+		set_active_shstk(tsk, token_loc);
+	}
+
+	return ret;
+}
+
+/*
+ * Restores user shadow stack pointer from token on shadow stack for task `tsk`
+ * returns -EFAULT if operation was unsuccessful
+ */
+int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr)
+{
+	unsigned long token = 0;
+
+	token = amo_user_shstk((unsigned long __user *)shstk_ptr, 0);
+
+	if (token == -1)
+		return -EFAULT;
+
+	/* invalid token, return EINVAL */
+	if ((token - shstk_ptr) != SHSTK_ENTRY_SIZE) {
+		pr_info_ratelimited(
+				"%s[%d]: bad restore token in %s: pc=%p sp=%p, token=%p, shstk_ptr=%p\n",
+				tsk->comm, task_pid_nr(tsk), __func__,
+				(void *)(task_pt_regs(tsk)->epc), (void *)(task_pt_regs(tsk)->sp),
+				(void *)token, (void *)shstk_ptr);
+		return -EINVAL;
+	}
+
+	/* all checks passed, set active shstk and return success */
+	set_active_shstk(tsk, token);
+	return 0;
+}
+
 static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long size,
 				unsigned long token_offset,
 				bool set_tok)
-- 
2.43.2



Return-Path: <linux-arch+bounces-3301-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5FD8912E0
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 05:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A302D28A87F
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 04:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAE269DFA;
	Fri, 29 Mar 2024 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IBRCW8Xj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F85F69D3C
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687620; cv=none; b=nAWkseb8BNDvrKFXF02+NbkRBcuJVYGuTwEgyQ5XitjsCTqcaUdkWNhh0vT8GTgcosg+ggV2c0FnFMj977yY1uAQW5AR+lEwjux7Qjo2law8XondL4qqAWF3ly089erc9iYuBLpFqhswPMJ6aj4Tg4hz7A+VMBDFbrbeLYmBXys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687620; c=relaxed/simple;
	bh=NNxtM8g6DmawrgZeEGMkNgZaiKZRi6Of2VCB8Si4zr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+E8aXOOdjewLE5wvgCLHiB6pa14LfRVMxXnEkm3RRikk2uVe2T+ZWWzDzEYOH7TxTauaifozHVFjQT4W777zVPTkX4IzyI+mFRE6xNqyb47Fc8Lo8Wbh/rxvUGIRaENJhLSnZ3dPxhagepTs4wT/n2SRGEDW8QCerUr+hy96RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IBRCW8Xj; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60a104601dcso17852287b3.2
        for <linux-arch@vger.kernel.org>; Thu, 28 Mar 2024 21:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711687616; x=1712292416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xPSsLde4QcON9OUri1oh5/a4S8lr1+b1lPRkRykHsg=;
        b=IBRCW8XjARbh3G7ngvUoMD+2iRQLV1w0i3qjpPEq8gjEr9ZIiHaSK96Z8VfMXro6aT
         LJVIr0taUYjgs5rJmhcQzRInRKtHb1lDZkJd1QTi0vDetL1qOvVYpwVi8ykUHq7PhxPY
         WArcfh+PLbZNHo7ACwSA/uA2pCrBpoRLuqV294aO3Pao45FhhldIVxSYpfQMUQvJKh5J
         FGhQ33dnlx6r51CaZLQEr2MxU/5ETLgGA5/BPknf2uCmWQvV2DPHfuCr1qEKAq5YbE6y
         xIv1YoydWOJyxyVJ18sM1LyKeAtq/z8+T6geo2vdnzpucLemKO6qT12MCl64fSTRAeHW
         EuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687616; x=1712292416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xPSsLde4QcON9OUri1oh5/a4S8lr1+b1lPRkRykHsg=;
        b=vNkCDG4+lIa67SGMXB9htthqOMxr9meSKbJn5u8/iTn/9krYiMSVNAG+9O5+e9uac/
         Hud2h2i6dn1qziXmXjlmLtNH32UsV8QK2IM3/KsUkAeMnCftFkIGTzSL2CdPS3r8aBo4
         hDGRpqPncU92oiv7HvCWLCHrRGuOLzUTrk0kZOXey7T9dDehRixX01ZGc5dqzYJE5lhC
         CKM4Lv4VPYzKnGQmdXTFQVFlDnl/Bu5q+lX0WleLJ7/xCZO6T6vegAOZn6pJ4JO5ID20
         vpZaJ8ojhbvRiKAuEwZNwUKnN1dqhoe9sApfKJX2eC2A1gdlU54QOJeDrFAni5Fqc1T6
         wE9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXp4YgwFsKKV9xf8PZrw7D5Wr/9mDpou+b9dew2pDLt4w2ZmEvGZ2yHzDvM2lG+MoclyCBQMlIT4ut1Qr30um8coxne7Gzg8INVgA==
X-Gm-Message-State: AOJu0Yx2nQtpTi6mHD5zZdkvWoHOaWVl6e5/k53+enXPlVXyIznrYlu9
	X0yfYUi0FsAjy9iI3gJgZ4QS7EjmDTzmJ0Vy8sbnaaa+PYfHZiI9lbPb47PpuhA=
X-Google-Smtp-Source: AGHT+IG37uJ/8ULWQEDE9K/aNOWfaGhUBUQD9mzyCMKEi7OurcbLU8SW7cmlTnAwB08yd2tdRDG0ag==
X-Received: by 2002:a25:3dc4:0:b0:dc6:b088:e742 with SMTP id k187-20020a253dc4000000b00dc6b088e742mr1330005yba.8.1711687616422;
        Thu, 28 Mar 2024 21:46:56 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b006ea7e972947sm2217120pfd.130.2024.03.28.21.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:46:56 -0700 (PDT)
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
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	tech-j-ext@lists.risc-v.org,
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
Subject: [PATCH v2 22/27] riscv signal: Save and restore of shadow stack for signal
Date: Thu, 28 Mar 2024 21:44:54 -0700
Message-Id: <20240329044459.3990638-23-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329044459.3990638-1-debug@rivosinc.com>
References: <20240329044459.3990638-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save shadow stack pointer in sigcontext structure while delivering signal.
Restore shadow stack pointer from sigcontext on sigreturn.

As part of save operation, kernel uses `ssamoswap` to save snapshot of current
shadow stack on shadow stack itself (can be called as a save token). During
restore on sigreturn, kernel retrieves token from top of shadow stack and
validates it. This allows that user mode can't arbitrary pivot to any shadow
stack address without having a token and thus provide strong security assurance
between signaly delivery and sigreturn window.

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



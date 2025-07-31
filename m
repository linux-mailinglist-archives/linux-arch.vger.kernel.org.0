Return-Path: <linux-arch+bounces-13004-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9518BB179B7
	for <lists+linux-arch@lfdr.de>; Fri,  1 Aug 2025 01:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6CD3A8F83
	for <lists+linux-arch@lfdr.de>; Thu, 31 Jul 2025 23:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611B0288C21;
	Thu, 31 Jul 2025 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NgIr3QM7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E3288529
	for <linux-arch@vger.kernel.org>; Thu, 31 Jul 2025 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754004004; cv=none; b=F6DMyUdSPY3rsTU6so4O1f4erfFEzIisqaBox20+tGEwBRbTxKrrDU2DsI956sWY+W5/AxKUnhj/o7WUIBji+/+nLwwVytR1Ia0wbh/ZWdJm5VT4UB7LgD1HQSt/fWXIOBhy6JX/7XFvpDZEhYQ1vwQGlRjusFtBDpSBoPnVou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754004004; c=relaxed/simple;
	bh=aKjFz3YU+9CJiZUEIVQ03s/1XLRpOir+/tuLzIsUaBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QtVzeato466dFnNv9mH/8Ma5Sf4NKIbQkOCecP7BEs6B5ZsC/ysUcGA5e9QtbcftFBsjn2I/isl7VwspOBXc/ZA0G89/nTmDUx7uUCXcFbrGJHbRK4pm9t0khnEEZTcvRyNHAUo063ZT5romJ60wNO9n/AsCpa1ehtX4RAmwUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NgIr3QM7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31f28d0495fso1583983a91.1
        for <linux-arch@vger.kernel.org>; Thu, 31 Jul 2025 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754004001; x=1754608801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAHuKrnww+9qbIr6JM1qL6EAF5HbaPIujBY/570p1VA=;
        b=NgIr3QM7x5rmen1bklIgizizx/GvZFX2uRM9SrQVrfHPLbeDhydY5wb3dZk5Qv3DI8
         tjcV6UgJ4PDPweXtGnmfC+YETs9P1usTHN80tUkjfjycOD5dHkEbL9Ez4wR3py1cj5Ik
         NgZT6N42wApdFYKlROlCWKOAtba8dpal6Qy6UAnlJ64AEifda7hvXcvBWjK8GuXG5pXn
         hn+EktR3aMzNb6SDlMexpEDjqqhfcJxfE7Gkg0LscsajGKRW7PxC+Npt9VPa0xYPqTDY
         dVdf3MwlkdUX2MQzDBIEXr45wlkb7tZcUolnCN6qSPJyEDF1xPx3vPtkB4/ZG3/hgVxs
         Tv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754004001; x=1754608801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAHuKrnww+9qbIr6JM1qL6EAF5HbaPIujBY/570p1VA=;
        b=YQP95wo0EehJy5xBmd8pZJmjycEGFozEbtZwZIJKQ1DkFWG7QC/cG9FduRbFpY4Kte
         1Q40SCIfIvlbs2h0A0zHrfS0Wq1Z47YI8wYj6duLhqICovmbF/YbUsQnH6l2Im+vDfzw
         f+MYrZ4XPev6BJ2XsOnVMQESTwKy59qzkZH2FdJ5pfioRpy1y6qHM7ov4TpYovTlbbgw
         iYifx+RvVW+BzEPPr7cdCf3Fp+uby/qEuYzlZf9B8OeiYziW0QeY7CZ0BKYvAmf7wwMD
         HhWckSc6IWl/AZ/xF3dtddi3cePdMmKXs2gVWzbHKMaXihSwPKgoSmRjE6+fEzfmpyu0
         ZyjA==
X-Forwarded-Encrypted: i=1; AJvYcCXBFD0SINuwH44WnMdKsKn+lkKBw8PADb+AMMHyTgK+FNQL5ABhAdf7TqBRkElSG+Jkj0ySmyPgnBGK@vger.kernel.org
X-Gm-Message-State: AOJu0YxICKrW1Ji7a6XzJbob2a0msq2JKTy4DQkpvhdPQgATO4It16hs
	F/xZK+dID/emjD6kq5c0b7dHin4aCcntMy7WjeQGlDN4CizpiJEK3Y1tmoQPfjZi8EA=
X-Gm-Gg: ASbGncvXvdgDTlm3eY+KKm7rrt1bsyOPnaZX/BdPbdMb5/D6lEuSL27kjmt9p97Am2G
	QsYyacVF8IeDxJGrUPU6u5+QZH6hVAz7TUaFt7HpvCOGw1T7ELTTR8UZOh55cKBbW+5nF7PvckM
	BegEC6hymN8wWUccrcO8Fd/jybfNLLWcS28VJLffvkOqqxFA/xhlbgW8dCYFQjTm6ByRAOjiZQ3
	3tYFEHueHTmvjNf774aZ/7c9J55Z/2elwUK55+z/avYNLWPQ3zPSuqZeScU2Sv4A0OtnYGSje7i
	eVX/LXVrewbPKcJDBYPpBSIdvCJ4R50m0HXQ8wQvRlZWJvfy2V2JW5HVFUfkcgMcxPFTTQ5HYbb
	kBAWvYHRsjfbHuhejG/CVYb+nbUW4efih
X-Google-Smtp-Source: AGHT+IGITqjfmzWEeQlPFYZt/Blqpt3anuEJYNIJBbv7j+NDOPU2d5XpMbrZuqrXio/lQTzz2bbznw==
X-Received: by 2002:a17:90b:4cc1:b0:31e:d929:5ca5 with SMTP id 98e67ed59e1d1-31f5dd8ca97mr10141692a91.1.1754004001133;
        Thu, 31 Jul 2025 16:20:01 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:20:00 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:24 -0700
Subject: [PATCH v19 14/27] riscv: Implements arch agnostic indirect branch
 tracking prctls
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-14-09b468d7beab@rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

prctls implemented are:
PR_SET_INDIR_BR_LP_STATUS, PR_GET_INDIR_BR_LP_STATUS and
PR_LOCK_INDIR_BR_LP_STATUS

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/usercfi.h | 14 +++++++
 arch/riscv/kernel/entry.S        |  4 ++
 arch/riscv/kernel/process.c      |  5 +++
 arch/riscv/kernel/usercfi.c      | 79 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index f747ad469c7c..98820d93c6e1 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -16,6 +16,8 @@ struct kernel_clone_args;
 struct cfi_state {
 	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
 	unsigned long ubcfi_locked : 1;
+	unsigned long ufcfi_en : 1; /* Enable for forward cfi. Note that ELP goes in sstatus */
+	unsigned long ufcfi_locked : 1;
 	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
 	unsigned long shdw_stk_base; /* Base address of shadow stack */
 	unsigned long shdw_stk_size; /* size of shadow stack */
@@ -32,6 +34,10 @@ bool is_shstk_locked(struct task_struct *task);
 bool is_shstk_allocated(struct task_struct *task);
 void set_shstk_lock(struct task_struct *task);
 void set_shstk_status(struct task_struct *task, bool enable);
+bool is_indir_lp_enabled(struct task_struct *task);
+bool is_indir_lp_locked(struct task_struct *task);
+void set_indir_lp_status(struct task_struct *task, bool enable);
+void set_indir_lp_lock(struct task_struct *task);
 
 #define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK (PR_SHADOW_STACK_ENABLE)
 
@@ -57,6 +63,14 @@ void set_shstk_status(struct task_struct *task, bool enable);
 
 #define set_shstk_status(task, enable) do {} while (0)
 
+#define is_indir_lp_enabled(task) false
+
+#define is_indir_lp_locked(task) false
+
+#define set_indir_lp_status(task, enable) do {} while (0)
+
+#define set_indir_lp_lock(task) do {} while (0)
+
 #endif /* CONFIG_RISCV_USER_CFI */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 3513ade7a4f2..633d66b5ae71 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -173,6 +173,10 @@ SYM_CODE_START(handle_exception)
 	 * or vector in kernel space.
 	 */
 	li t0, SR_SUM | SR_FS_VS
+#ifdef CONFIG_64BIT
+	li t1, SR_ELP
+	or t0, t0, t1
+#endif
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index a449218f174f..91db51413fab 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -163,6 +163,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	set_shstk_status(current, false);
 	set_shstk_base(current, 0, 0);
 	set_active_shstk(current, 0);
+	/*
+	 * disable indirect branch tracking on exec.
+	 * libc will enable it later via prctl.
+	 */
+	set_indir_lp_status(current, false);
 
 #ifdef CONFIG_64BIT
 	regs->status &= ~SR_UXL;
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 08620bdae696..2ebe789caa6b 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -72,6 +72,35 @@ void set_shstk_lock(struct task_struct *task)
 	task->thread_info.user_cfi_state.ubcfi_locked = 1;
 }
 
+bool is_indir_lp_enabled(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ufcfi_en;
+}
+
+bool is_indir_lp_locked(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ufcfi_locked;
+}
+
+void set_indir_lp_status(struct task_struct *task, bool enable)
+{
+	if (!cpu_supports_indirect_br_lp_instr())
+		return;
+
+	task->thread_info.user_cfi_state.ufcfi_en = enable ? 1 : 0;
+
+	if (enable)
+		task->thread.envcfg |= ENVCFG_LPE;
+	else
+		task->thread.envcfg &= ~ENVCFG_LPE;
+
+	csr_write(CSR_ENVCFG, task->thread.envcfg);
+}
+
+void set_indir_lp_lock(struct task_struct *task)
+{
+	task->thread_info.user_cfi_state.ufcfi_locked = 1;
+}
 /*
  * If size is 0, then to be compatible with regular stack we want it to be as big as
  * regular stack. Else PAGE_ALIGN it and return back
@@ -371,3 +400,53 @@ int arch_lock_shadow_stack_status(struct task_struct *task,
 
 	return 0;
 }
+
+int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	unsigned long fcfi_status = 0;
+
+	if (!cpu_supports_indirect_br_lp_instr())
+		return -EINVAL;
+
+	/* indirect branch tracking is enabled on the task or not */
+	fcfi_status |= (is_indir_lp_enabled(t) ? PR_INDIR_BR_LP_ENABLE : 0);
+
+	return copy_to_user(status, &fcfi_status, sizeof(fcfi_status)) ? -EFAULT : 0;
+}
+
+int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
+{
+	bool enable_indir_lp = false;
+
+	if (!cpu_supports_indirect_br_lp_instr())
+		return -EINVAL;
+
+	/* indirect branch tracking is locked and further can't be modified by user */
+	if (is_indir_lp_locked(t))
+		return -EINVAL;
+
+	/* Reject unknown flags */
+	if (status & ~PR_INDIR_BR_LP_ENABLE)
+		return -EINVAL;
+
+	enable_indir_lp = (status & PR_INDIR_BR_LP_ENABLE);
+	set_indir_lp_status(t, enable_indir_lp);
+
+	return 0;
+}
+
+int arch_lock_indir_br_lp_status(struct task_struct *task,
+				 unsigned long arg)
+{
+	/*
+	 * If indirect branch tracking is not supported or not enabled on task,
+	 * nothing to lock here
+	 */
+	if (!cpu_supports_indirect_br_lp_instr() ||
+	    !is_indir_lp_enabled(task) || arg != 0)
+		return -EINVAL;
+
+	set_indir_lp_lock(task);
+
+	return 0;
+}

-- 
2.43.0



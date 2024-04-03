Return-Path: <linux-arch+bounces-3422-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD254897C7D
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 01:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29002B275A5
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 23:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6FA156F56;
	Wed,  3 Apr 2024 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="D6cTHhlv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2B159595
	for <linux-arch@vger.kernel.org>; Wed,  3 Apr 2024 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187751; cv=none; b=gc7gT8sj0V/QPia6FQnYFwn5SMiuOvkq07ZcEcfHlsYa7KDSTudbIHE99/cLHRIqVfg+1iM99S1/8LKGJrGbFvkCSnl7ns+da08o4cUGhVeBuiOd5pLjJjqEAbDqmdSeRQJUBlm0X/bjK1QLAPRN/sm/dTsMyjtKaGnzAHE9vKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187751; c=relaxed/simple;
	bh=+J/YrC2NBo8byYOu7LSRpVV4IYT+L+/GanL/ELzJdwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4fIGxQ1QkcPjaF5jiUGBUgQKEsaC0V4MjS+FPfiiPzkiatXvJHBY19dMRTue98euqkKzDtUoFb95aFPqIcTajv+xFf4gYDHe9/IPW0jvaU+8LJs+/XSQxj1ltR7HEnMRY5W9vCtmPBQzO2ZUyQ/WC463QjL8QwCn1rUt8nm5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=D6cTHhlv; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso339820a12.3
        for <linux-arch@vger.kernel.org>; Wed, 03 Apr 2024 16:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187749; x=1712792549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZuOqDvC0Z7orZ7kqn38837045KjWIfnwy63b75kPss=;
        b=D6cTHhlvB6JD6A4xVERevVgTnfvzv4Z0ae8nt2Cjyo6LF9+//l3s3sUEc0PdWQFLRZ
         pZ3L6kkDYDAkbyNAZhz9JpIQkvKdRzwdbAb0i4eRBcS+DteX2N4RexUx559QWnxmtgdY
         A8Y5LgAh02fteWrpjWTJtlBD8QhUB5Bo0HVCkKpLTst8LxTJ/EAbB+YxyCLB6dlg5zCs
         x77CmnJxgY5lcHV/ldvlUqIbBpEZWvXQTQtPFBofTfKX76YGcCMNWpvJPPWYShhTdFWj
         0PrBF5imsi4siArlNJHzLdoVutF9vJYJtDZzua0vEkY8AZUCAowBkmtOOPtZjhaIzsDT
         G1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187749; x=1712792549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZuOqDvC0Z7orZ7kqn38837045KjWIfnwy63b75kPss=;
        b=CGzOGNnC+i10ToYNfyfCURLdHblpP7AeSVSikD4FjPTyFZK/1PAr8ZMgZF0xXfBGIj
         DNLqlquHYAEXI9MQgIETr9SDR63qP1CKkYX/Phu+wfBx8pHPPlPy87nCidjlGOOmVvoa
         G2HltULl/xFAePUQvJ9PsHWIqOBUGUoTG+KbhKf5HJCJ+TmFfEsn0n/mgSwwO9dK7EZF
         GzuE76mpcG6DvQ0vhvFjz7Zyr+VkdzNbc/VDcb4JYNjiCIW1l28EGlZ3QjbBRpFC5z3g
         dqigMGqeF3ou4k1rzy1f50ON2dRn8a4xe4EdDDbuBfQf5ot+J5INstjark2jBMwNCXht
         00Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUznwx/pTAKBOOn6VCXAm0SB1AEZ4At/m5f5CP7Uc0VCT/WSdZalJbDuuDtP/nqaLTgYeOWL5TpqdIs2r9fTnXf/Gea1Y9Oq1XrIQ==
X-Gm-Message-State: AOJu0YyQiAHpTAuyjpmUR2dk10xgNmpJZ1BRenNvT+PDWt9rbGhcE3wH
	8hvyJ9WbG4ulYvOX8QF820fLXaQFVqaAobIKlixp3fo4UwKdLLfos2c5vhDZPcs=
X-Google-Smtp-Source: AGHT+IFlDR3O+4GEi6icblP42gxGgn6vi8m6/NIcpSF/j+yTm57ooaZOA9iB5WMfSYbFBKo9qpApOQ==
X-Received: by 2002:a05:6a20:3953:b0:1a3:466d:d33 with SMTP id r19-20020a056a20395300b001a3466d0d33mr1558419pzg.9.1712187748866;
        Wed, 03 Apr 2024 16:42:28 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:42:28 -0700 (PDT)
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
Subject: [PATCH v3 19/29] riscv: Implements arch agnostic indirect branch tracking prctls
Date: Wed,  3 Apr 2024 16:35:07 -0700
Message-ID: <20240403234054.2020347-20-debug@rivosinc.com>
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

prctls implemented are:
PR_SET_INDIR_BR_LP_STATUS, PR_GET_INDIR_BR_LP_STATUS and
PR_LOCK_INDIR_BR_LP_STATUS.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/usercfi.h | 22 ++++++++-
 arch/riscv/kernel/process.c      |  5 +++
 arch/riscv/kernel/usercfi.c      | 76 ++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index a168ae0fa5d8..8accdc8ec164 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -16,7 +16,9 @@ struct kernel_clone_args;
 struct cfi_status {
 	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
 	unsigned long ubcfi_locked : 1;
-	unsigned long rsvd : ((sizeof(unsigned long)*8) - 2);
+	unsigned long ufcfi_en : 1; /* Enable for forward cfi. Note that ELP goes in sstatus */
+	unsigned long ufcfi_locked : 1;
+	unsigned long rsvd : ((sizeof(unsigned long)*8) - 4);
 	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
 	unsigned long shdw_stk_base; /* Base address of shadow stack */
 	unsigned long shdw_stk_size; /* size of shadow stack */
@@ -30,6 +32,9 @@ void set_active_shstk(struct task_struct *task, unsigned long shstk_addr);
 bool is_shstk_enabled(struct task_struct *task);
 bool is_shstk_locked(struct task_struct *task);
 void set_shstk_status(struct task_struct *task, bool enable);
+bool is_indir_lp_enabled(struct task_struct *task);
+bool is_indir_lp_locked(struct task_struct *task);
+void set_indir_lp_status(struct task_struct *task, bool enable);
 
 #define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK (PR_SHADOW_STACK_ENABLE)
 
@@ -72,6 +77,21 @@ static inline void set_shstk_status(struct task_struct *task, bool enable)
 
 }
 
+static inline bool is_indir_lp_enabled(struct task_struct *task)
+{
+	return false;
+}
+
+static inline bool is_indir_lp_locked(struct task_struct *task)
+{
+	return false;
+}
+
+static inline void set_indir_lp_status(struct task_struct *task, bool enable)
+{
+
+}
+
 #endif /* CONFIG_RISCV_USER_CFI */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 3fb8b23f629b..ebed7589c51a 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -152,6 +152,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
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
index cdedf1f78b3e..13920b9d86f3 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -69,6 +69,32 @@ void set_shstk_lock(struct task_struct *task)
 	task->thread_info.user_cfi_state.ubcfi_locked = 1;
 }
 
+bool is_indir_lp_enabled(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ufcfi_en ? true : false;
+}
+
+bool is_indir_lp_locked(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ufcfi_locked ? true : false;
+}
+
+void set_indir_lp_status(struct task_struct *task, bool enable)
+{
+	task->thread_info.user_cfi_state.ufcfi_en = enable ? 1 : 0;
+
+	if (enable)
+		task->thread_info.envcfg |= ENVCFG_LPE;
+	else
+		task->thread_info.envcfg &= ~ENVCFG_LPE;
+
+	csr_write(CSR_ENVCFG, task->thread_info.envcfg);
+}
+
+void set_indir_lp_lock(struct task_struct *task)
+{
+	task->thread_info.user_cfi_state.ufcfi_locked = 1;
+}
 /*
  * If size is 0, then to be compatible with regular stack we want it to be as big as
  * regular stack. Else PAGE_ALIGN it and return back
@@ -375,3 +401,53 @@ int arch_lock_shadow_stack_status(struct task_struct *task,
 
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
+	enable_indir_lp = (status & PR_INDIR_BR_LP_ENABLE) ? true : false;
+	set_indir_lp_status(t, enable_indir_lp);
+
+	return 0;
+}
+
+int arch_lock_indir_br_lp_status(struct task_struct *task,
+				unsigned long arg)
+{
+	/*
+	 * If indirect branch tracking is not supported or not enabled on task,
+	 * nothing to lock here
+	 */
+	if (!cpu_supports_indirect_br_lp_instr() ||
+		!is_indir_lp_enabled(task))
+		return -EINVAL;
+
+	set_indir_lp_lock(task);
+
+	return 0;
+}
-- 
2.43.2



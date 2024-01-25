Return-Path: <linux-arch+bounces-1536-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E24983B9B2
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CE71C240B2
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 06:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37F111BF;
	Thu, 25 Jan 2024 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CIIpriPf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5E134B7
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164145; cv=none; b=kH03xlc1Ct/FGMuDZS9rm2/aLLAKZPuFJf15zpVa8YjnF8wDp+7dqU5ZQUmIs1obH/8OI1tFXnnn66+ipekem2mZvVhMXVGJqorLSuMC8dG+b4+ZNPxRuNMKX7P46zJRoOlF8YZmheLQYkUMFh5pqg3ptMtzbWYLj0fNphujwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164145; c=relaxed/simple;
	bh=EY/9qGQfEhM2RCcY1q+hRsq8ge3YefHtxwppIf8wECo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldqSe0XxqxJWIp9Qc/Xu3Im7gkU29jVsLjTGcZ7pYudtyDeYMgeQllMB/+gXAVrECCYFmesy0nwPqm2qlXUJGYBsTVnoTCoUkkMEr9uAgloezCcSCMzxyHpNPdbO/w8ATMA213lX4IF8rJ4YawaAtYHwk8IxkdBUEJej+rExx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CIIpriPf; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-598ee012192so2865537eaf.1
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 22:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164142; x=1706768942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rs1o7FymY4gTUwXZVJx54t4Zjv5gF4CojhNG+aQW4Ms=;
        b=CIIpriPf7PgyR0lfDu25pFyLHN+//3/qe4yRnnNzcIpinj7wmuezksEQ/+ylrmaho4
         bwKsmt9pm2XvVBcOWzLKEafFx+sQOX5XNRVAwzHrYdXxNMJ4GfE4oYw2ANgBOuTJ/BKA
         HUsRSCkQDIzHMOTuete0nz7PDVgNbIU/UkLvnFlx9Rnn/O/50PyzGDxoORbJCBlA+eEM
         skQdUyRquVQKhCZ99H+qWFi7o/05XYORHdC3xDZpQbAC2MOQj6Uc7f3bIYRwnMD8Dln1
         Rp3Hpa539NCRWyZ35CtK6zeT3jWYyY3jcrWYpJ0sjujEu7EzMp7E3Cv8s10MBipGzWU0
         XBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164142; x=1706768942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rs1o7FymY4gTUwXZVJx54t4Zjv5gF4CojhNG+aQW4Ms=;
        b=JFosl7qGSPsLXggj4RObVp1yR9CC4ggXjnI+ZJ4EVLqePn9EcWcKzX7c3s9g+Arnbb
         Q3AfeNJEe2tx2GS+NAqKBCLDm4xWAbetGTPDepjWUY0/WzwLOfaK5bLEylNmrhsMSRR8
         HQ5YBs4pHBYIh3Bra2DqRZPXOK+PvLuecOxy1qAumSTsIAExBNKqr0AEELtzy9zbP4FQ
         8e0DxhPfkVLnMpEtV1mtdkW1XyweCIlMmy7miT/9ZW7cIrX2kW96CGiUu3flbGz28xx6
         wb9PZfSg6VOqu4d+OpTGEeX+j9IDUG6Njsokt7L3gPjXlBqflEVov/hr3f1XCGzEUyVF
         NJew==
X-Gm-Message-State: AOJu0Yzo7j48TVPL0uk/pD+2+C58l5fou0zGMmUr2onFZsnbtpT1ppXj
	r7IGw/UuiS0KmxbHXgDYlb6lM+FfqO2GYFHz8CtdtVDPCKE1XuxsnNuWbe8D3/I=
X-Google-Smtp-Source: AGHT+IGQZnueATOgDHrwaXrd5AWfHpxvbbHwGR+jLnJrGj0m/f+oWOE49v8FM+hbtn4VeA1L1U6wQQ==
X-Received: by 2002:a05:6358:d388:b0:176:5cad:5144 with SMTP id mp8-20020a056358d38800b001765cad5144mr620289rwb.45.1706164142630;
        Wed, 24 Jan 2024 22:29:02 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:29:02 -0800 (PST)
From: debug@rivosinc.com
To: rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com
Cc: corbet@lwn.net,
	aou@eecs.berkeley.edu,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	waylingii@gmail.com,
	greentime.hu@sifive.com,
	heiko@sntech.de,
	jszhang@kernel.org,
	shikemeng@huaweicloud.com,
	david@redhat.com,
	charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn,
	willy@infradead.org,
	vincent.chen@sifive.com,
	andy.chiu@sifive.com,
	gerg@kernel.org,
	jeeheng.sia@starfivetech.com,
	mason.huo@starfivetech.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	ruscur@russell.cc,
	bgray@linux.ibm.com,
	alx@kernel.org,
	baruch@tkos.co.il,
	zhangqing@loongson.cn,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	joey.gouly@arm.com,
	shr@devkernel.io,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 07/28] riscv: kernel handling on trap entry/exit for user cfi
Date: Wed, 24 Jan 2024 22:21:32 -0800
Message-ID: <20240125062739.1339782-8-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125062739.1339782-1-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepak Gupta <debug@rivosinc.com>

Carves out space in arch specific thread struct for cfi status and shadow stack
in usermode on riscv.

This patch does following
- defines a new structure cfi_status with status bit for cfi feature
- defines shadow stack pointer, base and size in cfi_status structure
- defines offsets to new member fields in thread in asm-offsets.c
- Saves and restore shadow stack pointer on trap entry (U --> S) and exit
  (S --> U)

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/processor.h   |  1 +
 arch/riscv/include/asm/thread_info.h |  3 +++
 arch/riscv/include/asm/usercfi.h     | 24 ++++++++++++++++++++++++
 arch/riscv/kernel/asm-offsets.c      |  5 ++++-
 arch/riscv/kernel/entry.S            | 25 +++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/usercfi.h

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index ee2f51787ff8..d4dc298880fc 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -14,6 +14,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/hwcap.h>
+#include <asm/usercfi.h>
 
 #ifdef CONFIG_64BIT
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 320bc899a63b..6a2acecec546 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -58,6 +58,9 @@ struct thread_info {
 	int			cpu;
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
 	unsigned long envcfg;
+#ifdef CONFIG_RISCV_USER_CFI
+	struct cfi_status       user_cfi_state;
+#endif
 #ifdef CONFIG_SHADOW_CALL_STACK
 	void			*scs_base;
 	void			*scs_sp;
diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
new file mode 100644
index 000000000000..080d7077d12c
--- /dev/null
+++ b/arch/riscv/include/asm/usercfi.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2023 Rivos, Inc.
+ * Deepak Gupta <debug@rivosinc.com>
+ */
+#ifndef _ASM_RISCV_USERCFI_H
+#define _ASM_RISCV_USERCFI_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+#ifdef CONFIG_RISCV_USER_CFI
+struct cfi_status {
+	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
+	unsigned long rsvd : ((sizeof(unsigned long)*8) - 1);
+	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
+	unsigned long shdw_stk_base; /* Base address of shadow stack */
+	unsigned long shdw_stk_size; /* size of shadow stack */
+};
+
+#endif /* CONFIG_RISCV_USER_CFI */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_USERCFI_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index cdd8f095c30c..5e1f412e96ba 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -43,8 +43,11 @@ void asm_offsets(void)
 #ifdef CONFIG_SHADOW_CALL_STACK
 	OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
 #endif
-
 	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
+#ifdef CONFIG_RISCV_USER_CFI
+	OFFSET(TASK_TI_CFI_STATUS, task_struct, thread_info.user_cfi_state);
+	OFFSET(TASK_TI_USER_SSP, task_struct, thread_info.user_cfi_state.user_shdw_stk);
+#endif
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
 	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 63c3855ba80d..410659e2eadb 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -49,6 +49,21 @@ SYM_CODE_START(handle_exception)
 	REG_S x5,  PT_T0(sp)
 	save_from_x6_to_x31
 
+#ifdef CONFIG_RISCV_USER_CFI
+	/*
+	* we need to save cfi status only when previous mode was U
+	*/
+	csrr s2, CSR_STATUS
+	andi s2, s2, SR_SPP
+	bnez s2, skip_bcfi_save
+	/* load cfi status word */
+	lw s3, TASK_TI_CFI_STATUS(tp)
+	andi s3, s3, 1
+	beqz s3, skip_bcfi_save
+	csrr s3, CSR_SSP
+	REG_S s3, TASK_TI_USER_SSP(tp) /* save user ssp in thread_info */
+skip_bcfi_save:
+#endif
 	/*
 	 * Disable user-mode memory access as it should only be set in the
 	 * actual user copy routines.
@@ -141,6 +156,16 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	 * structures again.
 	 */
 	csrw CSR_SCRATCH, tp
+
+#ifdef CONFIG_RISCV_USER_CFI
+	lw s3, TASK_TI_CFI_STATUS(tp)
+	andi s3, s3, 1
+	beqz s3, skip_bcfi_resume
+	REG_L s3, TASK_TI_USER_SSP(tp) /* restore user ssp from thread struct */
+	csrw CSR_SSP, s3
+skip_bcfi_resume:
+#endif
+
 1:
 	REG_L a0, PT_STATUS(sp)
 	/*
-- 
2.43.0



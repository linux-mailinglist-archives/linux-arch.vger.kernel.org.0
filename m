Return-Path: <linux-arch+bounces-12688-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8030B024E2
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 21:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EACB31C86A7C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 19:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303D2F4A09;
	Fri, 11 Jul 2025 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qtMXOoOA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FE22F49E9
	for <linux-arch@vger.kernel.org>; Fri, 11 Jul 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263192; cv=none; b=sM//w4oNlKblghKMRMmxXTV9Emq0l0k03vBVfHEvZ02r2SKOmV6LMOHguHpkfdN/rstebYdkXqk3cq0qbMAZ8hg07WEsLI754LRcDiJqBM0y3Lbv09XlOlVWVKJIs7ifkBwKCcXdmPLa3nEuwuYa00hoBOoVElfb4cszqurILh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263192; c=relaxed/simple;
	bh=K67udbiceFnHxhmq5Gt6miheHUdkfkMSDOwKkO+tz3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhN01rpCO7NQuZhXiVx2Sw6cKZypsRaQpU4Wd/zUWeO3kwbt2NbWok2OEBvkgYPFYbp9zKVlMTVYKwfrO3yeYdtOBhnuR9i9xvVaK9d8v/W6Hcz79c623Mga0hsPFsB/AXgNZKLiyUvVGANGw+oOoMiKeeS94SyOvT6eFs8fGlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qtMXOoOA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74b56b1d301so1574358b3a.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Jul 2025 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752263189; x=1752867989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eteaCmT0EJsGXoaQXFp/atdpLS4Y2Q5v/by8IU2Gxr4=;
        b=qtMXOoOA+WB5i4ndOQlQrNMUFGaXE8tsLF4CCzGIBUoNM43gysrMdxRBH5M3EO7Tvd
         +CU/Y0vmeHr/DpXvSqHTFGHMSs8uHrKytFFGni/uGBesotq8vym6Y3kyAj/XEJEfch4/
         /N+do+aVFQiAm+LBR0oqnxnqdL6bLr2SmVkoBrHxBpTBQZhmd7e22Gyrmg9kRwg9xOKJ
         2SwOgLAs61+sVuLJiVjUac+tz8aS3h8Bs3SpOHbx3+WMzySLLVyWj+lIEGVkj8GCPENQ
         xxfuvWF/IwFayEaNAtJ91cC7buHWDgB1tBAWDfDs4vVcweZc9zdwhoAKuOTmw66Lyngf
         awsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263189; x=1752867989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eteaCmT0EJsGXoaQXFp/atdpLS4Y2Q5v/by8IU2Gxr4=;
        b=D46Jz8knYNHIpCy4Ueihbf1OCrb98aQPe20VwR0sdDXdTUV1S/gW6nx4M0Ka8THUne
         0NLwE7po/PTp42NwLJYXvisNdRX/851tTt05vMbP1W8emx/3Hw++3neA49kXPKsnAUrX
         OJLnFOxsJzA06SZU7j8Q0bCXaViJYvPn3BLLWxygZ/sbZFCzcIOe3aziGf9GlikXdp7Q
         nGKtdOYhekMNQVTJgesgXqg98/VEDIUZvNMttr14iu+lldCH7m5rJpe5niVLolhdPPyU
         aSBbpgllbi1cfdhpsRUgEuRJiqJBMVRRXU54RK9mNc65x9/qnEwtAayKEmtXRfvcZoUv
         p8kg==
X-Forwarded-Encrypted: i=1; AJvYcCUCEQTADPXrWvjarkv6ukowyceAoPhpUisbZPmFV626zz71PZKUtvSgUguCqwqtNeYMVQLw+GwYGQSZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYOEIppbX4ZGzyDoQ1TLQVW7hHU33XEs9dlioPOoMAFNv9VwA
	V8lFsjgcmgH8wYj6SEQe/wGrqylJpsp4c3iKbjhG5M+h54PVwNPfI5HUb4errHFHBx4=
X-Gm-Gg: ASbGncsXXK3SNXAWW97tQy0FddnjlzooDxsTvP6c8AlpsFVF2qj6wod0GxhBCz5Cjp4
	0uu6miRI0eULxp+VpayIEmxC4LnbX6JfF1sasQo3WVxviyIrJSflgqcgKJ3PLjblRPmki2HWpZ1
	N8gun2TrKg3MwDJbFSf2vvQXb4hvc8beE1cKP04xrfmG70kT9BRq2t/JMo1Vj802vR371oGOKw8
	AFwRJTER0ZuWt7uVUcxyECypEN3PsSQq22o1xetuIJcCRkyKw7nHFwBpXJLQqq6H8VtlOcvylrB
	L8w5e1zNO9XN18DvYJ393P1YYIORPk2IAWpgIy0aMFp8h2Rd29/aLwVgZ3aAIsZxYK4exligxVu
	q5sbNZqw64Ch+hvRX99mTtcRSCipyc002
X-Google-Smtp-Source: AGHT+IEYcftmUHCewCA9bm5p1quNtCkSK2wS/dmMOUbK5G8Wa/yoknIwkXZYR6mmW8ANl49nIA4hJg==
X-Received: by 2002:a05:6a00:178f:b0:748:e1e4:71de with SMTP id d2e1a72fcca58-74ee255866dmr4585903b3a.14.1752263189226;
        Fri, 11 Jul 2025 12:46:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06995sm5840977b3a.38.2025.07.11.12.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:46:28 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 11 Jul 2025 12:46:10 -0700
Subject: [PATCH v18 05/27] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-v5_user_cfi_series-v18-5-a8ee62f9f38e@rivosinc.com>
References: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
In-Reply-To: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
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

Carves out space in arch specific thread struct for cfi status and shadow
stack in usermode on riscv.

This patch does following
- defines a new structure cfi_status with status bit for cfi feature
- defines shadow stack pointer, base and size in cfi_status structure
- defines offsets to new member fields in thread in asm-offsets.c
- Saves and restore shadow stack pointer on trap entry (U --> S) and exit
  (S --> U)

Shadow stack save/restore is gated on feature availiblity and implemented
using alternative. CSR can be context switched in `switch_to` as well but
soon as kernel shadow stack support gets rolled in, shadow stack pointer
will need to be switched at trap entry/exit point (much like `sp`). It can
be argued that kernel using shadow stack deployment scenario may not be as
prevalant as user mode using this feature. But even if there is some
minimal deployment of kernel shadow stack, that means that it needs to be
supported. And thus save/restore of shadow stack pointer in entry.S instead
of in `switch_to.h`.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/processor.h   |  1 +
 arch/riscv/include/asm/thread_info.h |  3 +++
 arch/riscv/include/asm/usercfi.h     | 23 +++++++++++++++++++++++
 arch/riscv/kernel/asm-offsets.c      |  4 ++++
 arch/riscv/kernel/entry.S            | 28 ++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 24d3af4d3807..05eb65fe9578 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -16,6 +16,7 @@
 #include <asm/insn-def.h>
 #include <asm/alternative-macros.h>
 #include <asm/hwcap.h>
+#include <asm/usercfi.h>
 
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index f5916a70879a..e066f41176ca 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -73,6 +73,9 @@ struct thread_info {
 	 */
 	unsigned long		a0, a1, a2;
 #endif
+#ifdef CONFIG_RISCV_USER_CFI
+	struct cfi_state	user_cfi_state;
+#endif
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
new file mode 100644
index 000000000000..94b214c295c0
--- /dev/null
+++ b/arch/riscv/include/asm/usercfi.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2024 Rivos, Inc.
+ * Deepak Gupta <debug@rivosinc.com>
+ */
+#ifndef _ASM_RISCV_USERCFI_H
+#define _ASM_RISCV_USERCFI_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+#ifdef CONFIG_RISCV_USER_CFI
+struct cfi_state {
+	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
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
index 6e8c0d6feae9..9bd6c3e868c9 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -50,6 +50,10 @@ void asm_offsets(void)
 #endif
 
 	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
+#ifdef CONFIG_RISCV_USER_CFI
+	OFFSET(TASK_TI_CFI_STATE, task_struct, thread_info.user_cfi_state);
+	OFFSET(TASK_TI_USER_SSP, task_struct, thread_info.user_cfi_state.user_shdw_stk);
+#endif
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
 	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 75656afa2d6b..05ebb811724b 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -91,6 +91,32 @@
 	REG_L	a0, TASK_TI_A0(tp)
 .endm
 
+/*
+ * If previous mode was U, capture shadow stack pointer and save it away
+ * Zero CSR_SSP at the same time for sanitization.
+ */
+.macro save_userssp tmp, status
+	ALTERNATIVE("nops(4)",
+		__stringify(				\
+		andi \tmp, \status, SR_SPP;		\
+		bnez \tmp, skip_ssp_save;		\
+		csrrw \tmp, CSR_SSP, x0;		\
+		REG_S \tmp, TASK_TI_USER_SSP(tp);	\
+		skip_ssp_save:),
+		0,
+		RISCV_ISA_EXT_ZICFISS,
+		CONFIG_RISCV_USER_CFI)
+.endm
+
+.macro restore_userssp tmp
+	ALTERNATIVE("nops(2)",
+		__stringify(				\
+		REG_L \tmp, TASK_TI_USER_SSP(tp);	\
+		csrw CSR_SSP, \tmp),
+		0,
+		RISCV_ISA_EXT_ZICFISS,
+		CONFIG_RISCV_USER_CFI)
+.endm
 
 SYM_CODE_START(handle_exception)
 	/*
@@ -147,6 +173,7 @@ SYM_CODE_START(handle_exception)
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
+	save_userssp s2, s1
 	csrr s2, CSR_EPC
 	csrr s3, CSR_TVAL
 	csrr s4, CSR_CAUSE
@@ -236,6 +263,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	 * structures again.
 	 */
 	csrw CSR_SCRATCH, tp
+	restore_userssp s3
 1:
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
 	move a0, sp

-- 
2.43.0



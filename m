Return-Path: <linux-arch+bounces-10022-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D3A28100
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 02:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C001882A45
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 01:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC51E22B586;
	Wed,  5 Feb 2025 01:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3PNsGhyk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A022CBC4
	for <linux-arch@vger.kernel.org>; Wed,  5 Feb 2025 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718544; cv=none; b=JaohJu+Luyli+h8nnWuKGnRQPVvLSQ4+yhreipCFr3O7MzqRsEMnFchvwOO6RdjF7RvL1aMXXbFVaHLxGC1VOX0svJyjafPGlSvOY3p0CImaaSd5ZqzI0Xyz1ydxwpmbKqkA2md4jxgnfEhJf39CqNKugUSYBXi+38d8vhFTF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718544; c=relaxed/simple;
	bh=mWDyYETp4wr+sZ2udIiiXn9veUStZJ0b+YrPzAFDVJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KAQ04z19WcxY88bk7ao+c2Jn2s8GikzIEtI5VIZLoZ4ZAhA7vm+Wbxcca0WsPrVvrmAU2VW8RLSQ1osFnmkYDDPDkI5shvTyYVvGTyK0OxklAjTaIjdsiiVr3jKA3S0fcfE6o0CPWjV8GxozcyznMnm/G4FSX8h5UiKuObJ5ipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3PNsGhyk; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so2449982a91.2
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2025 17:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718541; x=1739323341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M49HWf8gzr6wWBf1Qtr4VOivQAEEQjfyuWgORGOVTSw=;
        b=3PNsGhykqshNyYMB5IH6venzMKMUgaAz232xODj2RvoR/msJI3DA3Gk+/cm4OoIxR5
         p6TseogC9c1/YWCzelBCUa0ihtWpHqSlYIFpnGwiq1czNxEHBjnwaAGoagp8mq1EVa/P
         dTnqCDOguY/jxUrzW45GjQuT4LgMfwxuzxEuOOjtrRgzsfUiqC9xE1xOwwR25CUVICWa
         wf/VptJLhs6B8SzrQbOAIw4Vx8hcHf7siMeGez4VP57FwvIdxhiYAGV2h9I3xjwDUVto
         8sa4zXljyus5pR635poXczxcphvxdv2cAd2+lH0nPCU8V98U6vJeRDevBS091y0jNYq8
         74Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718541; x=1739323341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M49HWf8gzr6wWBf1Qtr4VOivQAEEQjfyuWgORGOVTSw=;
        b=nKXjyjfp/W3ex2GSnUg9S0Aw6g0AZM98IIemtodVRvi+7wLr+ogKs2KsYFYlfwZTsK
         XWt5OVpDtdT/gIZ5fZdYYrQdzjdb5pGUt+DIr/30Cny+0eEUMO6yRgbWKXlJYntNZddA
         kOa29reZ7DAX0WIXgvRBS9wVaKP2kg4Zpvbr8XRpLMDqGFnLuR4ILvFZod9ALLJLpaza
         qANX9RnyIsjfl7jW/OMlvVuH1J92qj86fNVFejmmVGg6Yzvf2c5tJwE7s7kHoZVGBdXU
         O2smr4fYAY5n3bolxFwxwWl6K+vuQBb2NhEl8n8GUe/5rz53pQEV8oURuAEyqCvarBkc
         Ifmw==
X-Forwarded-Encrypted: i=1; AJvYcCXd8xUH5saT3tnUepOwB23ZMIjPg7jFHGnzoAPYsSbaScWHHZAQgCqKEjeY+9IqNBw2bAKh5sxM1QQ/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5WSrj8/n/hROCqT/hXiBeVpVSIi/h38sQLMSWJeK5WOUYbI0e
	3zDslfIj4du9W667zYuV6N5Ab1IU2Wx/yQtguQFonmaip5eVHHwcxsBWttq6F5c=
X-Gm-Gg: ASbGncs+FXtAoEqZjeolsiQZtPKDatRLWu5rTZnyg+YidT+iRFBbUJG8sFv9h+gskJa
	miEyzSvZlBizi7D8XUJp7sCvfGcNnd04n8ZwjNsCjNp+qc34Et5bjhnd4aRPmevD76l1WeVk/uP
	belbpw5hXtxw5aMQMOQmVyTvM6661uehFHZPRw/j4RQzA2GFFBH8JLYs1LBaxX8QXHaQgdULdKP
	bvil70ZbIV95Bh7m3jY6w6aTNNIjSnJug2eiD73dNXJ4QgwYQmtbxu0Calju61TInFXDhQpaDXT
	S7Tny8F6aMqlh8eGuJrK0hV+FQ==
X-Google-Smtp-Source: AGHT+IFplfoY4kwYRUYkUapPyLUTmtCYI1kOBemc2Fu2DroKYmpICeBEsM6C9QAH02Mf3MaRp7pG+A==
X-Received: by 2002:a05:6a00:3cc1:b0:72d:4d77:ccc with SMTP id d2e1a72fcca58-7303511ae5cmr1489432b3a.6.1738718540683;
        Tue, 04 Feb 2025 17:22:20 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:22:20 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:22:01 -0800
Subject: [PATCH v9 14/26] riscv/traps: Introduce software check exception
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-14-b37a49c5205c@rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
In-Reply-To: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

zicfiss / zicfilp introduces a new exception to priv isa `software check
exception` with cause code = 18. This patch implements software check
exception.

Additionally it implements a cfi violation handler which checks for code
in xtval. If xtval=2, it means that sw check exception happened because of
an indirect branch not landing on 4 byte aligned PC or not landing on
`lpad` instruction or label value embedded in `lpad` not matching label
value setup in `x7`. If xtval=3, it means that sw check exception happened
because of mismatch between link register (x1 or x5) and top of shadow
stack (on execution of `sspopchk`).

In case of cfi violation, SIGSEGV is raised with code=SEGV_CPERR.
SEGV_CPERR was introduced by x86 shadow stack patches.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/asm-prototypes.h |  1 +
 arch/riscv/include/asm/entry-common.h   |  2 ++
 arch/riscv/kernel/entry.S               |  3 +++
 arch/riscv/kernel/traps.c               | 43 +++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index cd627ec289f1..5a27cefd7805 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -51,6 +51,7 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_u);
 DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
 DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
 DECLARE_DO_ERROR_INFO(do_trap_break);
+DECLARE_DO_ERROR_INFO(do_trap_software_check);
 
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
 asmlinkage void do_page_fault(struct pt_regs *regs);
diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index b28ccc6cdeea..34ed149af5d1 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -40,4 +40,6 @@ static inline int handle_misaligned_store(struct pt_regs *regs)
 }
 #endif
 
+bool handle_user_cfi_violation(struct pt_regs *regs);
+
 #endif /* _ASM_RISCV_ENTRY_COMMON_H */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 00494b54ff4a..9c00cac3f6f2 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -472,6 +472,9 @@ SYM_DATA_START_LOCAL(excp_vect_table)
 	RISCV_PTR do_page_fault   /* load page fault */
 	RISCV_PTR do_trap_unknown
 	RISCV_PTR do_page_fault   /* store page fault */
+	RISCV_PTR do_trap_unknown /* cause=16 */
+	RISCV_PTR do_trap_unknown /* cause=17 */
+	RISCV_PTR do_trap_software_check /* cause=18 is sw check exception */
 SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
 
 #ifndef CONFIG_MMU
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8ff8e8b36524..3f7709f4595a 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -354,6 +354,49 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 }
 
+#define CFI_TVAL_FCFI_CODE	2
+#define CFI_TVAL_BCFI_CODE	3
+/* handle cfi violations */
+bool handle_user_cfi_violation(struct pt_regs *regs)
+{
+	bool ret = false;
+	unsigned long tval = csr_read(CSR_TVAL);
+
+	if ((tval == CFI_TVAL_FCFI_CODE && cpu_supports_indirect_br_lp_instr()) ||
+	    (tval == CFI_TVAL_BCFI_CODE && cpu_supports_shadow_stack())) {
+		do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
+			      "Oops - control flow violation");
+		ret = true;
+	}
+
+	return ret;
+}
+
+/*
+ * software check exception is defined with risc-v cfi spec. Software check
+ * exception is raised when:-
+ * a) An indirect branch doesn't land on 4 byte aligned PC or `lpad`
+ *    instruction or `label` value programmed in `lpad` instr doesn't
+ *    match with value setup in `x7`. reported code in `xtval` is 2.
+ * b) `sspopchk` instruction finds a mismatch between top of shadow stack (ssp)
+ *    and x1/x5. reported code in `xtval` is 3.
+ */
+asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		irqentry_enter_from_user_mode(regs);
+
+		/* not a cfi violation, then merge into flow of unknown trap handler */
+		if (!handle_user_cfi_violation(regs))
+			do_trap_unknown(regs);
+
+		irqentry_exit_to_user_mode(regs);
+	} else {
+		/* sw check exception coming from kernel is a bug in kernel */
+		die(regs, "Kernel BUG");
+	}
+}
+
 #ifdef CONFIG_MMU
 asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 {

-- 
2.34.1



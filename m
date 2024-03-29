Return-Path: <linux-arch+bounces-3299-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87E88912D7
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 05:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE8E28A70E
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 04:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E799C57874;
	Fri, 29 Mar 2024 04:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="a6jcO/zV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5052F7D
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687613; cv=none; b=Ame+3GyOpX+rMAwV1Vc6oboWsfix9792RxF9FGbP6JuoesPa9ib0TsrLML90tNCYUjiWx4XoNnOmbEcKsYRHSwX1RbzFele5JGZktyG01aCof8jam2Wo0JcAsdXrNp1n4ZZ+hwicWpZoZCwnB8KXl6aNVVNApyDTyaWbk/fKCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687613; c=relaxed/simple;
	bh=7ejQLxDl0OzMS3eteFBqa38DhYmvgNUzj8lISnVMkc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwfqQYxJPQ4Psi9Ne6hMmE5Gsn5HjRwsJPXzBCC2tt0Zw2SULchv2sZwK6qnReH7XOvCikWIHp9Rhk1vJDjeX6B1MysiQLCD5Lh84jfAAw2bHQII9DGPJcQRgIoDTnF71BMsKr6gVMKu4Cf0DKfelkGKi8UMqm+9GAR2f56dT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=a6jcO/zV; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c3f3806d88so90670b6e.3
        for <linux-arch@vger.kernel.org>; Thu, 28 Mar 2024 21:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711687610; x=1712292410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO0iTqSJGMZjgI8FFL6Efs68zyEh3di0+Ee8Co7Xl3I=;
        b=a6jcO/zVruFdIri1d3i0+RrySNJBJpgYPKcgs1hR6tUHZgpSDYbsK/YtNMdoQuUZiv
         Dtt/sylCVtRH1p7OkkFe05jHFH70iykVxoeXqQCjVDmvYSf0PbryFoDEnBSDaIhbfUvw
         b2mG6MycIU1eVpheB/Llq4t4Bi3dC/3sS2Ed4rJHdJuQDpDwJ8FMbwfnQU+3vbH4HhU2
         d4LGhoL/Qoye+JZfLBKroTdTp6xustmTqypraJUTxwkwPsRtzob1tdE1L+k528tnNc0Y
         6Ql84NN7feyT2HEpBV4zzJejgnyAzrszlfQGgfwdd+HO91eC/ywilQEU+W7PsI6u+NDv
         ohhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687610; x=1712292410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YO0iTqSJGMZjgI8FFL6Efs68zyEh3di0+Ee8Co7Xl3I=;
        b=LEj3mfZkXdaV+/Pk1bb6KPiDH9vN7lZUKWBYPseYnM6kUnK/R/IoaOmsejkb2Kzr2u
         MV4ZrErYZoB1komwUzFobiRBEI5EagTOu4Ku0ayGmBoatMzc3D9HGoDb6j+DDbB8RNsk
         Uu/2wAwdUNiPTY4in7KwGEEP5V9ZsKbVpJr+qrDhrf8XmuZWV+wvd+vbFtkuJg5g5uY5
         u3NlzFrfdgTI+lOHDLLKKfmjAbUJ4l6fuMD1IJe7IM9uQU9U1xLgCaAfo0bWXI1MJScy
         Q4gUjWiMhDtWml5eJu7yJHoecpm4ZWN4Xyw7Npsgr0q6r9FFZMg8eSCMFPgkMneacRrG
         jkIA==
X-Forwarded-Encrypted: i=1; AJvYcCXHR2apWk7RLT61KhbKyvhg7MBheZPFgQ8cpWIJZJgkytmI4X9El5rLaT8Z+dFuh5j4ocjCYw3XzIqxaE4qbPbeeX7HKLVCb3ML4g==
X-Gm-Message-State: AOJu0Yz7aW4hA1NvhJX0X+8IxGCLc8mrfF/y9jZkJbER3afi1j2HCGW5
	nwkRJdyD4WZrzVvB8mA6TY2li+qSJjTbixjZ0r2Wlzq9uLyPCNCr9tJgPg4OZoE=
X-Google-Smtp-Source: AGHT+IEEkqqoh9ZCSipkYJyi1sYiOeAupA2Zd/Tw6FmqvNWOmZwwVKoooYj2QwBiFKxvGUt1R6r40A==
X-Received: by 2002:a05:6808:1885:b0:3c3:e436:881f with SMTP id bi5-20020a056808188500b003c3e436881fmr1602543oib.36.1711687610580;
        Thu, 28 Mar 2024 21:46:50 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b006ea7e972947sm2217120pfd.130.2024.03.28.21.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:46:49 -0700 (PDT)
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
Subject: [PATCH v2 20/27] riscv/traps: Introduce software check exception
Date: Thu, 28 Mar 2024 21:44:52 -0700
Message-Id: <20240329044459.3990638-21-debug@rivosinc.com>
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

zicfiss / zicfilp introduces a new exception to priv isa `software check
exception` with cause code = 18. This patch implements software check exception.

Additionally it implements a cfi violation handler which checks for code in xtval
If xtval=2, it means that sw check exception happened because of an indirect
branch not landing on 4 byte aligned PC or not landing on `lpad` instruction or
label value embedded in `lpad` not matching label value setup in `x7`.
If xtval=3, it means that sw check exception happened because of mismatch between
link register (x1 or x5) and top of shadow stack (on execution of `sspopchk`)

In case of cfi violation, SIGSEGV is raised with code=SEGV_CPERR. SEGV_CPERR was
introduced by x86 shadow stack patches.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/asm-prototypes.h |  1 +
 arch/riscv/kernel/entry.S               |  3 ++
 arch/riscv/kernel/traps.c               | 38 +++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

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
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 7245a0ea25c1..f97af4ff5237 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -374,6 +374,9 @@ SYM_DATA_START_LOCAL(excp_vect_table)
 	RISCV_PTR do_page_fault   /* load page fault */
 	RISCV_PTR do_trap_unknown
 	RISCV_PTR do_page_fault   /* store page fault */
+	RISCV_PTR do_trap_unknown /* cause=16 */
+	RISCV_PTR do_trap_unknown /* cause=17 */
+	RISCV_PTR do_trap_software_check /* cause=18 is sw check exception */
 SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
 
 #ifndef CONFIG_MMU
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index a1b9be3c4332..9fba263428a1 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -339,6 +339,44 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 }
 
+#define CFI_TVAL_FCFI_CODE	2
+#define CFI_TVAL_BCFI_CODE	3
+/* handle cfi violations */
+bool handle_user_cfi_violation(struct pt_regs *regs)
+{
+	bool ret = false;
+	unsigned long tval = csr_read(CSR_TVAL);
+
+	if (((tval == CFI_TVAL_FCFI_CODE) && cpu_supports_indirect_br_lp_instr()) ||
+		((tval == CFI_TVAL_BCFI_CODE) && cpu_supports_shadow_stack())) {
+		do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
+					  "Oops - control flow violation");
+		ret = true;
+	}
+
+	return ret;
+}
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
+		/* not a cfi violation, then merge into flow of unknown trap handler */
+		if (!handle_user_cfi_violation(regs))
+			do_trap_unknown(regs);
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
2.43.2



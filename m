Return-Path: <linux-arch+bounces-1550-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7898983B9FC
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E2328A037
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 06:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C8C12E50;
	Thu, 25 Jan 2024 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LHuiVm1f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C081BF27
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164217; cv=none; b=QOBK04+cWGAdVhjbP2YZ5kHsCHvxhpTAljoZDWlsHd4eUMBk4LQgBoPo04NuJ4sc7NAYqOYIbs/lMxfGGkNSO7H1TKnxpMFsQb4i2uuyiXL6iPifkmhJ7WwybSCoTBwJTLc/McOtkFPAozOmpFy0kveW7jAzPoqcvSs3aFj3/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164217; c=relaxed/simple;
	bh=Iw9o++lUhsJG5xH47NbdLp+1ZL2m0D0Eopr2tTL9+ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBMKIsEbTQShm/fsUZRexzvNPNsiNnPJU2NB6/SJ4mfszGaC8H0zoTz12aqKupEf3xDh3kvIy1p91hNrc1ArAL6Uf5InNGsn0PT200rntHzLpIwNm3Mb9atrlkPOcwvgIsGATt8tKyiUmTD3t7zhUSBee0+pk4ukG3A9fJJcdJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LHuiVm1f; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ddf26eba3cso4168254a34.0
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 22:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164214; x=1706769014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWoZzchBSoMo3jyN4IG6PBlEmlapmOPwf7uW/AAql2Y=;
        b=LHuiVm1fbiqrGfA6QIcn1hbrVZuZ3k08DRMPPnsQ8zadwBWNPiL75mftrtZQCo/ITk
         kTu50sCwOODwmf9EX38dbdpyTtpM3ha4CQ6nlAR6do/uhOZXdxcIZw3BX4rxZnlq+gAb
         oAOmTMrXAOkpZaK914Fx/tGMY6UmKayp2EE6NgXoQofxAQuRs8N56IPZ2yL89u9o2AO2
         FiU3dSK6FRsC8P/yQ5VZCk0ctM7QpLrbyqfHWuaVIDtJwz/idqc1oGfXrEHckXI5S6Ra
         4O9hjjkVLLBUWaUaG1KavRagQY/u2+RJLimEsAoXnv05GfxAjwEF3v7T9LPxDcqwyeMs
         jjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164214; x=1706769014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWoZzchBSoMo3jyN4IG6PBlEmlapmOPwf7uW/AAql2Y=;
        b=cXk4BcBAX0gy3UGaCekQPjODGG/0WP4Oy/PjeYacw9AYUh/J5A/bmWaWQh+fr09532
         0gUH7GbMLQjQOQyuom2M5PZIRBKzY6dkDyrIoV4dOHLHPry9l1VSh0QJKNzixyUQfWJJ
         kwD8nZEwvdodyPFIfm6hRTv47ivpJjHH756H5A7GWMCVhFz2N1yQ4gI09vT4K8CVyR44
         ATsnpOQWkv0lIzURfl4Qw18w3BNvTPnXFPkoQ2TVZW8y+iIxCwokohaufJcVKzAU9A0D
         7ZGNAbY3oZZW7FirIJTESV+5pYhCZokAH9vJVYHcEz/69/vVadd13JzAE7VDJIzO2L75
         OWlA==
X-Gm-Message-State: AOJu0YyTyywNl+B7fYLBXU0HvcrEdy32UPBNCNpkabmzT6A5fyk0F7ZS
	ZcoMzLPZx2PFSzz71Wg+R3iwPubaMwPpesHDKoQfkdjPAYRxMpnJJt6f6bTLNMo=
X-Google-Smtp-Source: AGHT+IGSbF8wk8MWD9JER43fwMC5oLI81Tos6BLVy/7m1/KYy4B5vfc7HAeOJWEYyCkNhHGvZRDwAg==
X-Received: by 2002:a9d:4d9a:0:b0:6dd:bf77:480 with SMTP id u26-20020a9d4d9a000000b006ddbf770480mr380479otk.51.1706164214351;
        Wed, 24 Jan 2024 22:30:14 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:30:14 -0800 (PST)
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
Subject: [RFC PATCH v1 21/28] riscv/traps: Introduce software check exception
Date: Wed, 24 Jan 2024 22:21:46 -0800
Message-ID: <20240125062739.1339782-22-debug@rivosinc.com>
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
index 36b955c762ba..4ba8aea58dd0 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -24,6 +24,7 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_u);
 DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
 DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
 DECLARE_DO_ERROR_INFO(do_trap_break);
+DECLARE_DO_ERROR_INFO(do_trap_software_check);
 
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
 asmlinkage void do_page_fault(struct pt_regs *regs);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 410659e2eadb..56dfe04094c1 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -369,6 +369,9 @@ SYM_DATA_START_LOCAL(excp_vect_table)
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
2.43.0



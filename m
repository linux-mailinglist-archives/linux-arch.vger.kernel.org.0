Return-Path: <linux-arch+bounces-3427-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3FF897C95
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 01:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C926D282624
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 23:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B725015B96F;
	Wed,  3 Apr 2024 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dTuQKAgV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094EA15B549
	for <linux-arch@vger.kernel.org>; Wed,  3 Apr 2024 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187764; cv=none; b=MylN+ev7r0IAzTr4mMe730tliKJt3n1+5I6sakd6t3uB5+lkQX/CBDWFGf4D6fhTFGs+pVKUgpK1OKcYbPv4X4SalhgMbYTwAVSvzG+hOj57GJFkrwbm597NYdncSLqjim7KBpL0AW9VNi2D/hU6FcoH99eXVfE4hOXvsaBjKhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187764; c=relaxed/simple;
	bh=l/nyvaOgUV9mE95wDYkfkeHkD4SONVQazcZc1dFrpBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMLIu7UhFaH8QaSpUbmutjfSgCNruWd+p0hbyB7VSTOwusyGX/gGGtxbpquc/tSvZAWPECDogvI6dtcSYJY+zlesAC3+BKb8lL9+2YxGzbzCzXtbhvYcEyr8ZRxlMyt3z7oyp7+nb8j8pcRB3sY5e4iwYMfT05fZjsmfY85+usI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dTuQKAgV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso303882a12.2
        for <linux-arch@vger.kernel.org>; Wed, 03 Apr 2024 16:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187762; x=1712792562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4h29gLixoMV8jqguvN/5Pzgz4C0EFoOwStmiEzJSk4=;
        b=dTuQKAgVUJ0XzCVllrEPLQ1FPbO6krXIxuVMEnAP2FCj73uhgAW87nUT8GKAjim7I3
         laklmnMWQ/oLU2nqUbpzPMYoG9ixc31NSYwgOaUFe15dB0nmSvjwEfSkf/XW2oQEQiHZ
         zeCF4vIBjX5cOPhyqAYkeQBhBqMgj51F2Txq5vPFK813Stc+aRIdYTLYjdQtFdcMyVkN
         DoIUVsS/iS6CIs/+sXJfqdOjDWfK0pGqBYSpjKufMJnRigcC7fF/NCn91z3/hkA4SZRy
         XHSQ+tpt5KDbFknjyJKvHzMDpuChgtzMrczDfROrE8Lu34Kh9/zisky/seydFDt3Ctwf
         /fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187762; x=1712792562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4h29gLixoMV8jqguvN/5Pzgz4C0EFoOwStmiEzJSk4=;
        b=MN+8bs2f0c5PcpilB1WE3GAKVtgNhhFsO5tTMp4h7/OUElPnptx+sicvzn9aMx5zjC
         XRMvTcSRzAje7L6GSV1YtJs8KYGJ2K1Zk3rJPl3SaoqdafVx4/BIZMJyAZZf65EcUyLy
         efoUooK3o+cxWK28cuabhzP/wDCgAGIXGYbfoYhl6zzyXPKtMDoekOQRUgR8T6HuAhrQ
         Sxh0so2UR/GOG+5qo0IZ2f89RH0TG8xyIUNWoqM+B504iSqFv3YiuiIhSuJPYoh+GLjp
         n2pv4L4sHtZ4/g9byx8HVFObQ3WwuEDDy3HzwkUgcI3slYzXsVp2VlvO8g+zhJNg3yn9
         lpRg==
X-Forwarded-Encrypted: i=1; AJvYcCWcSgtprHmBaXwUKGlr9+QzP89OvxiWV/unN2l5yyZRWKKWDclRPAqXhw1e8Jg0NgWlJ9b+3ILwHwxoSARVtHPK6+2mMgT7MY/qzw==
X-Gm-Message-State: AOJu0YxuqX/rByEw2Yxg36ucN8AAkYIBFhx4577WszEaSbge3Ab3ecyi
	wtrbkTUCOVRScSKXleAJ3x6a0rb8ViFMR1YKazPiCKtCtKdx88RRv38GeK+8peo=
X-Google-Smtp-Source: AGHT+IG6JjvBwkxgqryw6XYXQuT6s6l7JFwHNmCUllxfSiPnkNHrCcfUHOA44/lFJ8XzXC2yFAlGAA==
X-Received: by 2002:a05:6a20:6a0b:b0:1a7:ea4:e13a with SMTP id p11-20020a056a206a0b00b001a70ea4e13amr1275128pzk.54.1712187761904;
        Wed, 03 Apr 2024 16:42:41 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:42:41 -0700 (PDT)
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
Subject: [PATCH v3 24/29] riscv/ptrace: riscv cfi status and state via ptrace and in core files
Date: Wed,  3 Apr 2024 16:35:12 -0700
Message-ID: <20240403234054.2020347-25-debug@rivosinc.com>
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

Expose a new register type NT_RISCV_USER_CFI for risc-v cfi status and
state. Intentionally both landing pad and shadow stack status and state
are rolled into cfi state. Creating two different NT_RISCV_USER_XXX would
not be useful and wastage of a note type. Enabling or disabling of feature
is not allowed via ptrace set interface. However setting `elp` state or
setting shadow stack pointer are allowed via ptrace set interface. It is
expected `gdb` might have use to fixup `elp` state or `shadow stack`
pointer.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/ptrace.h | 18 ++++++
 arch/riscv/kernel/ptrace.c           | 83 ++++++++++++++++++++++++++++
 include/uapi/linux/elf.h             |  1 +
 3 files changed, 102 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index a38268b19c3d..512be06a8661 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -127,6 +127,24 @@ struct __riscv_v_regset_state {
  */
 #define RISCV_MAX_VLENB (8192)
 
+struct __cfi_status {
+	/* indirect branch tracking state */
+	__u64 lp_en : 1;
+	__u64 lp_lock : 1;
+	__u64 elp_state : 1;
+
+	/* shadow stack status */
+	__u64 shstk_en : 1;
+	__u64 shstk_lock : 1;
+
+	__u64 rsvd : sizeof(__u64) - 5;
+};
+
+struct user_cfi_state {
+	struct __cfi_status	cfi_status;
+	__u64 shstk_ptr;
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index e8515aa9d80b..33d4b32cc6a7 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -19,6 +19,7 @@
 #include <linux/regset.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
+#include <asm/usercfi.h>
 
 enum riscv_regset {
 	REGSET_X,
@@ -28,6 +29,9 @@ enum riscv_regset {
 #ifdef CONFIG_RISCV_ISA_V
 	REGSET_V,
 #endif
+#ifdef CONFIG_RISCV_USER_CFI
+	REGSET_CFI,
+#endif
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -152,6 +156,75 @@ static int riscv_vr_set(struct task_struct *target,
 }
 #endif
 
+#ifdef CONFIG_RISCV_USER_CFI
+static int riscv_cfi_get(struct task_struct *target,
+			const struct user_regset *regset,
+			struct membuf to)
+{
+	struct user_cfi_state user_cfi;
+	struct pt_regs *regs;
+
+	regs = task_pt_regs(target);
+
+	user_cfi.cfi_status.lp_en = is_indir_lp_enabled(target);
+	user_cfi.cfi_status.lp_lock = is_indir_lp_locked(target);
+	user_cfi.cfi_status.elp_state = (regs->status & SR_ELP);
+
+	user_cfi.cfi_status.shstk_en = is_shstk_enabled(target);
+	user_cfi.cfi_status.shstk_lock = is_shstk_locked(target);
+	user_cfi.shstk_ptr = get_active_shstk(target);
+
+	return membuf_write(&to, &user_cfi, sizeof(user_cfi));
+}
+
+/*
+ * Does it make sense to allowing enable / disable of cfi via ptrace?
+ * Not allowing enable / disable / locking control via ptrace for now.
+ * Setting shadow stack pointer is allowed. GDB might use it to unwind or
+ * some other fixup. Similarly gdb might want to suppress elp and may want
+ * to reset elp state.
+ */
+static int riscv_cfi_set(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	struct user_cfi_state user_cfi;
+	struct pt_regs *regs;
+
+	regs = task_pt_regs(target);
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &user_cfi, 0, -1);
+	if (ret)
+		return ret;
+
+	/*
+	 * Not allowing enabling or locking shadow stack or landing pad
+	 * There is no disabling of shadow stack or landing pad via ptrace
+	 * rsvd field should be set to zero so that if those fields are needed in future
+	 */
+	if (user_cfi.cfi_status.lp_en || user_cfi.cfi_status.lp_lock ||
+		user_cfi.cfi_status.shstk_en || user_cfi.cfi_status.shstk_lock ||
+		!user_cfi.cfi_status.rsvd)
+		return -EINVAL;
+
+	/* If lpad is enabled on target and ptrace requests to set / clear elp, do that */
+	if (is_indir_lp_enabled(target)) {
+		if (user_cfi.cfi_status.elp_state) /* set elp state */
+			regs->status |= SR_ELP;
+		else
+			regs->status &= ~SR_ELP; /* clear elp state */
+	}
+
+	/* If shadow stack enabled on target, set new shadow stack pointer */
+	if (is_shstk_enabled(target))
+		set_active_shstk(target, user_cfi.shstk_ptr);
+
+	return 0;
+}
+#endif
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		.core_note_type = NT_PRSTATUS,
@@ -182,6 +255,16 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = riscv_vr_set,
 	},
 #endif
+#ifdef CONFIG_RISCV_USER_CFI
+	[REGSET_CFI] = {
+		.core_note_type = NT_RISCV_USER_CFI,
+		.align = sizeof(__u64),
+		.n = sizeof(struct user_cfi_state) / sizeof(__u64),
+		.size = sizeof(__u64),
+		.regset_get = riscv_cfi_get,
+		.set = riscv_cfi_set,
+	}
+#endif
 };
 
 static const struct user_regset_view riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 9417309b7230..f60b2de66b1c 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -447,6 +447,7 @@ typedef struct elf64_shdr {
 #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
 #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
+#define NT_RISCV_USER_CFI	0x902		/* RISC-V shadow stack state */
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
-- 
2.43.2



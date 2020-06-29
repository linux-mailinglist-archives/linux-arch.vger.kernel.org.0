Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01F020E46E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgF2VZW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgF2Smu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7775CC033C19;
        Mon, 29 Jun 2020 11:26:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUB-002DvL-2m; Mon, 29 Jun 2020 18:26:31 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 24/41] arm64: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:11 +0100
Message-Id: <20200629182628.529995-24-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm64/kernel/ptrace.c | 225 +++++++++++++--------------------------------
 1 file changed, 62 insertions(+), 163 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 9f769e862f68..8745aecffcae 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -474,11 +474,10 @@ static int ptrace_hbp_set_addr(unsigned int note_type,
 
 static int hw_break_get(struct task_struct *target,
 			const struct user_regset *regset,
-			unsigned int pos, unsigned int count,
-			void *kbuf, void __user *ubuf)
+			struct membuf to)
 {
 	unsigned int note_type = regset->core_note_type;
-	int ret, idx = 0, offset, limit;
+	int ret, idx = 0;
 	u32 info, ctrl;
 	u64 addr;
 
@@ -487,49 +486,21 @@ static int hw_break_get(struct task_struct *target,
 	if (ret)
 		return ret;
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &info, 0,
-				  sizeof(info));
-	if (ret)
-		return ret;
-
-	/* Pad */
-	offset = offsetof(struct user_hwdebug_state, pad);
-	ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf, offset,
-				       offset + PTRACE_HBP_PAD_SZ);
-	if (ret)
-		return ret;
-
+	membuf_write(&to, &info, sizeof(info));
+	membuf_zero(&to, sizeof(u32));
 	/* (address, ctrl) registers */
-	offset = offsetof(struct user_hwdebug_state, dbg_regs);
-	limit = regset->n * regset->size;
-	while (count && offset < limit) {
+	while (to.left) {
 		ret = ptrace_hbp_get_addr(note_type, target, idx, &addr);
 		if (ret)
 			return ret;
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &addr,
-					  offset, offset + PTRACE_HBP_ADDR_SZ);
-		if (ret)
-			return ret;
-		offset += PTRACE_HBP_ADDR_SZ;
-
 		ret = ptrace_hbp_get_ctrl(note_type, target, idx, &ctrl);
 		if (ret)
 			return ret;
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &ctrl,
-					  offset, offset + PTRACE_HBP_CTRL_SZ);
-		if (ret)
-			return ret;
-		offset += PTRACE_HBP_CTRL_SZ;
-
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       offset,
-					       offset + PTRACE_HBP_PAD_SZ);
-		if (ret)
-			return ret;
-		offset += PTRACE_HBP_PAD_SZ;
+		membuf_store(&to, addr);
+		membuf_store(&to, ctrl);
+		membuf_zero(&to, sizeof(u32));
 		idx++;
 	}
-
 	return 0;
 }
 
@@ -589,11 +560,10 @@ static int hw_break_set(struct task_struct *target,
 
 static int gpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
 	struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0, -1);
+	return membuf_write(&to, uregs, sizeof(*uregs));
 }
 
 static int gpr_set(struct task_struct *target, const struct user_regset *regset,
@@ -626,8 +596,7 @@ static int fpr_active(struct task_struct *target, const struct user_regset *regs
  */
 static int __fpr_get(struct task_struct *target,
 		     const struct user_regset *regset,
-		     unsigned int pos, unsigned int count,
-		     void *kbuf, void __user *ubuf, unsigned int start_pos)
+		     struct membuf to)
 {
 	struct user_fpsimd_state *uregs;
 
@@ -635,13 +604,11 @@ static int __fpr_get(struct task_struct *target,
 
 	uregs = &target->thread.uw.fpsimd_state;
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs,
-				   start_pos, start_pos + sizeof(*uregs));
+	return membuf_write(&to, uregs, sizeof(*uregs));
 }
 
 static int fpr_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
 	if (!system_supports_fpsimd())
 		return -EINVAL;
@@ -649,7 +616,7 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 	if (target == current)
 		fpsimd_preserve_current_state();
 
-	return __fpr_get(target, regset, pos, count, kbuf, ubuf, 0);
+	return __fpr_get(target, regset, to);
 }
 
 static int __fpr_set(struct task_struct *target,
@@ -699,15 +666,12 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 }
 
 static int tls_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
-	unsigned long *tls = &target->thread.uw.tp_value;
-
 	if (target == current)
 		tls_preserve_current_state();
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, tls, 0, -1);
+	return membuf_store(&to, target->thread.uw.tp_value);
 }
 
 static int tls_set(struct task_struct *target, const struct user_regset *regset,
@@ -727,13 +691,9 @@ static int tls_set(struct task_struct *target, const struct user_regset *regset,
 
 static int system_call_get(struct task_struct *target,
 			   const struct user_regset *regset,
-			   unsigned int pos, unsigned int count,
-			   void *kbuf, void __user *ubuf)
+			   struct membuf to)
 {
-	int syscallno = task_pt_regs(target)->syscallno;
-
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &syscallno, 0, -1);
+	return membuf_store(&to, task_pt_regs(target)->syscallno);
 }
 
 static int system_call_set(struct task_struct *target,
@@ -794,10 +754,8 @@ static unsigned int sve_get_size(struct task_struct *target,
 
 static int sve_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
-	int ret;
 	struct user_sve_header header;
 	unsigned int vq;
 	unsigned long start, end;
@@ -809,10 +767,7 @@ static int sve_get(struct task_struct *target,
 	sve_init_header_from_task(&header, target);
 	vq = sve_vq_from_vl(header.vl);
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &header,
-				  0, sizeof(header));
-	if (ret)
-		return ret;
+	membuf_write(&to, &header, sizeof(header));
 
 	if (target == current)
 		fpsimd_preserve_current_state();
@@ -821,26 +776,18 @@ static int sve_get(struct task_struct *target,
 
 	BUILD_BUG_ON(SVE_PT_FPSIMD_OFFSET != sizeof(header));
 	if ((header.flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD)
-		return __fpr_get(target, regset, pos, count, kbuf, ubuf,
-				 SVE_PT_FPSIMD_OFFSET);
+		return __fpr_get(target, regset, to);
 
 	/* Otherwise: full SVE case */
 
 	BUILD_BUG_ON(SVE_PT_SVE_OFFSET != sizeof(header));
 	start = SVE_PT_SVE_OFFSET;
 	end = SVE_PT_SVE_FFR_OFFSET(vq) + SVE_PT_SVE_FFR_SIZE(vq);
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  target->thread.sve_state,
-				  start, end);
-	if (ret)
-		return ret;
+	membuf_write(&to, target->thread.sve_state, end - start);
 
 	start = end;
 	end = SVE_PT_SVE_FPSR_OFFSET(vq);
-	ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-				       start, end);
-	if (ret)
-		return ret;
+	membuf_zero(&to, end - start);
 
 	/*
 	 * Copy fpsr, and fpcr which must follow contiguously in
@@ -848,16 +795,11 @@ static int sve_get(struct task_struct *target,
 	 */
 	start = end;
 	end = SVE_PT_SVE_FPCR_OFFSET(vq) + SVE_PT_SVE_FPCR_SIZE;
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.uw.fpsimd_state.fpsr,
-				  start, end);
-	if (ret)
-		return ret;
+	membuf_write(&to, &target->thread.uw.fpsimd_state.fpsr, end - start);
 
 	start = end;
 	end = sve_size_from_header(&header);
-	return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					start, end);
+	return membuf_zero(&to, end - start);
 }
 
 static int sve_set(struct task_struct *target,
@@ -961,8 +903,7 @@ static int sve_set(struct task_struct *target,
 #ifdef CONFIG_ARM64_PTR_AUTH
 static int pac_mask_get(struct task_struct *target,
 			const struct user_regset *regset,
-			unsigned int pos, unsigned int count,
-			void *kbuf, void __user *ubuf)
+			struct membuf to)
 {
 	/*
 	 * The PAC bits can differ across data and instruction pointers
@@ -978,7 +919,7 @@ static int pac_mask_get(struct task_struct *target,
 	if (!system_supports_address_auth())
 		return -EINVAL;
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &uregs, 0, -1);
+	return membuf_write(&to, &uregs, sizeof(uregs));
 }
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
@@ -1017,8 +958,7 @@ static void pac_address_keys_from_user(struct ptrauth_keys_user *keys,
 
 static int pac_address_keys_get(struct task_struct *target,
 				const struct user_regset *regset,
-				unsigned int pos, unsigned int count,
-				void *kbuf, void __user *ubuf)
+				struct membuf to)
 {
 	struct ptrauth_keys_user *keys = &target->thread.keys_user;
 	struct user_pac_address_keys user_keys;
@@ -1028,8 +968,7 @@ static int pac_address_keys_get(struct task_struct *target,
 
 	pac_address_keys_to_user(&user_keys, keys);
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &user_keys, 0, -1);
+	return membuf_write(&to, &user_keys, sizeof(user_keys));
 }
 
 static int pac_address_keys_set(struct task_struct *target,
@@ -1068,8 +1007,7 @@ static void pac_generic_keys_from_user(struct ptrauth_keys_user *keys,
 
 static int pac_generic_keys_get(struct task_struct *target,
 				const struct user_regset *regset,
-				unsigned int pos, unsigned int count,
-				void *kbuf, void __user *ubuf)
+				struct membuf to)
 {
 	struct ptrauth_keys_user *keys = &target->thread.keys_user;
 	struct user_pac_generic_keys user_keys;
@@ -1079,8 +1017,7 @@ static int pac_generic_keys_get(struct task_struct *target,
 
 	pac_generic_keys_to_user(&user_keys, keys);
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &user_keys, 0, -1);
+	return membuf_write(&to, &user_keys, sizeof(user_keys));
 }
 
 static int pac_generic_keys_set(struct task_struct *target,
@@ -1134,7 +1071,7 @@ static const struct user_regset aarch64_regsets[] = {
 		.n = sizeof(struct user_pt_regs) / sizeof(u64),
 		.size = sizeof(u64),
 		.align = sizeof(u64),
-		.get = gpr_get,
+		.get2 = gpr_get,
 		.set = gpr_set
 	},
 	[REGSET_FPR] = {
@@ -1147,7 +1084,7 @@ static const struct user_regset aarch64_regsets[] = {
 		.size = sizeof(u32),
 		.align = sizeof(u32),
 		.active = fpr_active,
-		.get = fpr_get,
+		.get2 = fpr_get,
 		.set = fpr_set
 	},
 	[REGSET_TLS] = {
@@ -1155,7 +1092,7 @@ static const struct user_regset aarch64_regsets[] = {
 		.n = 1,
 		.size = sizeof(void *),
 		.align = sizeof(void *),
-		.get = tls_get,
+		.get2 = tls_get,
 		.set = tls_set,
 	},
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
@@ -1164,7 +1101,7 @@ static const struct user_regset aarch64_regsets[] = {
 		.n = sizeof(struct user_hwdebug_state) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = hw_break_get,
+		.get2 = hw_break_get,
 		.set = hw_break_set,
 	},
 	[REGSET_HW_WATCH] = {
@@ -1172,7 +1109,7 @@ static const struct user_regset aarch64_regsets[] = {
 		.n = sizeof(struct user_hwdebug_state) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = hw_break_get,
+		.get2 = hw_break_get,
 		.set = hw_break_set,
 	},
 #endif
@@ -1181,7 +1118,7 @@ static const struct user_regset aarch64_regsets[] = {
 		.n = 1,
 		.size = sizeof(int),
 		.align = sizeof(int),
-		.get = system_call_get,
+		.get2 = system_call_get,
 		.set = system_call_set,
 	},
 #ifdef CONFIG_ARM64_SVE
@@ -1191,7 +1128,7 @@ static const struct user_regset aarch64_regsets[] = {
 				  SVE_VQ_BYTES),
 		.size = SVE_VQ_BYTES,
 		.align = SVE_VQ_BYTES,
-		.get = sve_get,
+		.get2 = sve_get,
 		.set = sve_set,
 		.get_size = sve_get_size,
 	},
@@ -1202,7 +1139,7 @@ static const struct user_regset aarch64_regsets[] = {
 		.n = sizeof(struct user_pac_mask) / sizeof(u64),
 		.size = sizeof(u64),
 		.align = sizeof(u64),
-		.get = pac_mask_get,
+		.get2 = pac_mask_get,
 		/* this cannot be set dynamically */
 	},
 #ifdef CONFIG_CHECKPOINT_RESTORE
@@ -1211,7 +1148,7 @@ static const struct user_regset aarch64_regsets[] = {
 		.n = sizeof(struct user_pac_address_keys) / sizeof(__uint128_t),
 		.size = sizeof(__uint128_t),
 		.align = sizeof(__uint128_t),
-		.get = pac_address_keys_get,
+		.get2 = pac_address_keys_get,
 		.set = pac_address_keys_set,
 	},
 	[REGSET_PACG_KEYS] = {
@@ -1219,7 +1156,7 @@ static const struct user_regset aarch64_regsets[] = {
 		.n = sizeof(struct user_pac_generic_keys) / sizeof(__uint128_t),
 		.size = sizeof(__uint128_t),
 		.align = sizeof(__uint128_t),
-		.get = pac_generic_keys_get,
+		.get2 = pac_generic_keys_get,
 		.set = pac_generic_keys_set,
 	},
 #endif
@@ -1255,39 +1192,13 @@ static inline compat_ulong_t compat_get_user_reg(struct task_struct *task, int i
 
 static int compat_gpr_get(struct task_struct *target,
 			  const struct user_regset *regset,
-			  unsigned int pos, unsigned int count,
-			  void *kbuf, void __user *ubuf)
+			  struct membuf to)
 {
-	int ret = 0;
-	unsigned int i, start, num_regs;
-
-	/* Calculate the number of AArch32 registers contained in count */
-	num_regs = count / regset->size;
-
-	/* Convert pos into an register number */
-	start = pos / regset->size;
-
-	if (start + num_regs > regset->n)
-		return -EIO;
-
-	for (i = 0; i < num_regs; ++i) {
-		compat_ulong_t reg = compat_get_user_reg(target, start + i);
-
-		if (kbuf) {
-			memcpy(kbuf, &reg, sizeof(reg));
-			kbuf += sizeof(reg);
-		} else {
-			ret = copy_to_user(ubuf, &reg, sizeof(reg));
-			if (ret) {
-				ret = -EFAULT;
-				break;
-			}
+	int i = 0;
 
-			ubuf += sizeof(reg);
-		}
-	}
-
-	return ret;
+	while (to.left)
+		membuf_store(&to, compat_get_user_reg(target, i++));
+	return 0;
 }
 
 static int compat_gpr_set(struct task_struct *target,
@@ -1354,12 +1265,10 @@ static int compat_gpr_set(struct task_struct *target,
 
 static int compat_vfp_get(struct task_struct *target,
 			  const struct user_regset *regset,
-			  unsigned int pos, unsigned int count,
-			  void *kbuf, void __user *ubuf)
+			  struct membuf to)
 {
 	struct user_fpsimd_state *uregs;
 	compat_ulong_t fpscr;
-	int ret, vregs_end_pos;
 
 	if (!system_supports_fpsimd())
 		return -EINVAL;
@@ -1373,19 +1282,10 @@ static int compat_vfp_get(struct task_struct *target,
 	 * The VFP registers are packed into the fpsimd_state, so they all sit
 	 * nicely together for us. We just need to create the fpscr separately.
 	 */
-	vregs_end_pos = VFP_STATE_SIZE - sizeof(compat_ulong_t);
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs,
-				  0, vregs_end_pos);
-
-	if (count && !ret) {
-		fpscr = (uregs->fpsr & VFP_FPSCR_STAT_MASK) |
-			(uregs->fpcr & VFP_FPSCR_CTRL_MASK);
-
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &fpscr,
-					  vregs_end_pos, VFP_STATE_SIZE);
-	}
-
-	return ret;
+	membuf_write(&to, uregs, VFP_STATE_SIZE - sizeof(compat_ulong_t));
+	fpscr = (uregs->fpsr & VFP_FPSCR_STAT_MASK) |
+		(uregs->fpcr & VFP_FPSCR_CTRL_MASK);
+	return membuf_store(&to, fpscr);
 }
 
 static int compat_vfp_set(struct task_struct *target,
@@ -1420,11 +1320,10 @@ static int compat_vfp_set(struct task_struct *target,
 }
 
 static int compat_tls_get(struct task_struct *target,
-			  const struct user_regset *regset, unsigned int pos,
-			  unsigned int count, void *kbuf, void __user *ubuf)
+			  const struct user_regset *regset,
+			  struct membuf to)
 {
-	compat_ulong_t tls = (compat_ulong_t)target->thread.uw.tp_value;
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &tls, 0, -1);
+	return membuf_store(&to, (compat_ulong_t)target->thread.uw.tp_value);
 }
 
 static int compat_tls_set(struct task_struct *target,
@@ -1449,7 +1348,7 @@ static const struct user_regset aarch32_regsets[] = {
 		.n = COMPAT_ELF_NGREG,
 		.size = sizeof(compat_elf_greg_t),
 		.align = sizeof(compat_elf_greg_t),
-		.get = compat_gpr_get,
+		.get2 = compat_gpr_get,
 		.set = compat_gpr_set
 	},
 	[REGSET_COMPAT_VFP] = {
@@ -1458,7 +1357,7 @@ static const struct user_regset aarch32_regsets[] = {
 		.size = sizeof(compat_ulong_t),
 		.align = sizeof(compat_ulong_t),
 		.active = fpr_active,
-		.get = compat_vfp_get,
+		.get2 = compat_vfp_get,
 		.set = compat_vfp_set
 	},
 };
@@ -1474,7 +1373,7 @@ static const struct user_regset aarch32_ptrace_regsets[] = {
 		.n = COMPAT_ELF_NGREG,
 		.size = sizeof(compat_elf_greg_t),
 		.align = sizeof(compat_elf_greg_t),
-		.get = compat_gpr_get,
+		.get2 = compat_gpr_get,
 		.set = compat_gpr_set
 	},
 	[REGSET_FPR] = {
@@ -1482,7 +1381,7 @@ static const struct user_regset aarch32_ptrace_regsets[] = {
 		.n = VFP_STATE_SIZE / sizeof(compat_ulong_t),
 		.size = sizeof(compat_ulong_t),
 		.align = sizeof(compat_ulong_t),
-		.get = compat_vfp_get,
+		.get2 = compat_vfp_get,
 		.set = compat_vfp_set
 	},
 	[REGSET_TLS] = {
@@ -1490,7 +1389,7 @@ static const struct user_regset aarch32_ptrace_regsets[] = {
 		.n = 1,
 		.size = sizeof(compat_ulong_t),
 		.align = sizeof(compat_ulong_t),
-		.get = compat_tls_get,
+		.get2 = compat_tls_get,
 		.set = compat_tls_set,
 	},
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
@@ -1499,7 +1398,7 @@ static const struct user_regset aarch32_ptrace_regsets[] = {
 		.n = sizeof(struct user_hwdebug_state) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = hw_break_get,
+		.get2 = hw_break_get,
 		.set = hw_break_set,
 	},
 	[REGSET_HW_WATCH] = {
@@ -1507,7 +1406,7 @@ static const struct user_regset aarch32_ptrace_regsets[] = {
 		.n = sizeof(struct user_hwdebug_state) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = hw_break_get,
+		.get2 = hw_break_get,
 		.set = hw_break_set,
 	},
 #endif
@@ -1516,7 +1415,7 @@ static const struct user_regset aarch32_ptrace_regsets[] = {
 		.n = 1,
 		.size = sizeof(int),
 		.align = sizeof(int),
-		.get = system_call_get,
+		.get2 = system_call_get,
 		.set = system_call_set,
 	},
 };
-- 
2.11.0


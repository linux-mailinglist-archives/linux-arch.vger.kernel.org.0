Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854FE20E494
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgF2V0t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbgF2Smp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:45 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E40DC033C16;
        Mon, 29 Jun 2020 11:26:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUA-002Dus-Jq; Mon, 29 Jun 2020 18:26:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 20/41] powerpc: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:07 +0100
Message-Id: <20200629182628.529995-20-viro@ZenIV.linux.org.uk>
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

Note: compat variant of REGSET_TM_CGPR is almost certainly wrong;
it claims to be 48*64bit, but just as compat REGSET_GPR it stores
44*32bit of (truncated) registers + 4 32bit zeros... followed by
48 more 32bit zeroes.  Might be too late to change - it's a userland
ABI, after all ;-/

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/kernel/ptrace/ptrace-altivec.c |  37 ++----
 arch/powerpc/kernel/ptrace/ptrace-decl.h    |  44 +++----
 arch/powerpc/kernel/ptrace/ptrace-novsx.c   |   5 +-
 arch/powerpc/kernel/ptrace/ptrace-spe.c     |  16 +--
 arch/powerpc/kernel/ptrace/ptrace-tm.c      | 152 +++++++----------------
 arch/powerpc/kernel/ptrace/ptrace-view.c    | 185 ++++++++++------------------
 arch/powerpc/kernel/ptrace/ptrace-vsx.c     |  13 +-
 7 files changed, 148 insertions(+), 304 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace-altivec.c b/arch/powerpc/kernel/ptrace/ptrace-altivec.c
index dd8b75dfbd06..0d9bc4bd4972 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-altivec.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-altivec.c
@@ -41,38 +41,25 @@ int vr_active(struct task_struct *target, const struct user_regset *regset)
  * };
  */
 int vr_get(struct task_struct *target, const struct user_regset *regset,
-	   unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+	   struct membuf to)
 {
-	int ret;
+	union {
+		elf_vrreg_t reg;
+		u32 word;
+	} vrsave;
 
 	flush_altivec_to_thread(target);
 
 	BUILD_BUG_ON(offsetof(struct thread_vr_state, vscr) !=
 		     offsetof(struct thread_vr_state, vr[32]));
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.vr_state, 0,
-				  33 * sizeof(vector128));
-	if (!ret) {
-		/*
-		 * Copy out only the low-order word of vrsave.
-		 */
-		int start, end;
-		union {
-			elf_vrreg_t reg;
-			u32 word;
-		} vrsave;
-		memset(&vrsave, 0, sizeof(vrsave));
-
-		vrsave.word = target->thread.vrsave;
-
-		start = 33 * sizeof(vector128);
-		end = start + sizeof(vrsave);
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &vrsave,
-					  start, end);
-	}
-
-	return ret;
+	membuf_write(&to, &target->thread.vr_state, 33 * sizeof(vector128));
+	/*
+	 * Copy out only the low-order word of vrsave.
+	 */
+	memset(&vrsave, 0, sizeof(vrsave));
+	vrsave.word = target->thread.vrsave;
+	return membuf_write(&to, &vrsave, sizeof(vrsave));
 }
 
 /*
diff --git a/arch/powerpc/kernel/ptrace/ptrace-decl.h b/arch/powerpc/kernel/ptrace/ptrace-decl.h
index 3c8a81999292..67447a6197eb 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-decl.h
+++ b/arch/powerpc/kernel/ptrace/ptrace-decl.h
@@ -63,8 +63,7 @@ enum powerpc_regset {
 
 /* ptrace-(no)vsx */
 
-int fpr_get(struct task_struct *target, const struct user_regset *regset,
-	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+user_regset_get2_fn fpr_get;
 int fpr_set(struct task_struct *target, const struct user_regset *regset,
 	    unsigned int pos, unsigned int count,
 	    const void *kbuf, const void __user *ubuf);
@@ -72,8 +71,7 @@ int fpr_set(struct task_struct *target, const struct user_regset *regset,
 /* ptrace-vsx */
 
 int vsr_active(struct task_struct *target, const struct user_regset *regset);
-int vsr_get(struct task_struct *target, const struct user_regset *regset,
-	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+user_regset_get2_fn vsr_get;
 int vsr_set(struct task_struct *target, const struct user_regset *regset,
 	    unsigned int pos, unsigned int count,
 	    const void *kbuf, const void __user *ubuf);
@@ -81,8 +79,7 @@ int vsr_set(struct task_struct *target, const struct user_regset *regset,
 /* ptrace-altivec */
 
 int vr_active(struct task_struct *target, const struct user_regset *regset);
-int vr_get(struct task_struct *target, const struct user_regset *regset,
-	   unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+user_regset_get2_fn vr_get;
 int vr_set(struct task_struct *target, const struct user_regset *regset,
 	   unsigned int pos, unsigned int count,
 	   const void *kbuf, const void __user *ubuf);
@@ -90,8 +87,7 @@ int vr_set(struct task_struct *target, const struct user_regset *regset,
 /* ptrace-spe */
 
 int evr_active(struct task_struct *target, const struct user_regset *regset);
-int evr_get(struct task_struct *target, const struct user_regset *regset,
-	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+user_regset_get2_fn evr_get;
 int evr_set(struct task_struct *target, const struct user_regset *regset,
 	    unsigned int pos, unsigned int count,
 	    const void *kbuf, const void __user *ubuf);
@@ -100,9 +96,8 @@ int evr_set(struct task_struct *target, const struct user_regset *regset,
 
 int gpr32_get_common(struct task_struct *target,
 		     const struct user_regset *regset,
-		     unsigned int pos, unsigned int count,
-			    void *kbuf, void __user *ubuf,
-			    unsigned long *regs);
+		     struct membuf to,
+		     unsigned long *regs);
 int gpr32_set_common(struct task_struct *target,
 		     const struct user_regset *regset,
 		     unsigned int pos, unsigned int count,
@@ -118,55 +113,46 @@ static inline void flush_tmregs_to_thread(struct task_struct *tsk) { }
 #endif
 
 int tm_cgpr_active(struct task_struct *target, const struct user_regset *regset);
-int tm_cgpr_get(struct task_struct *target, const struct user_regset *regset,
-		unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+user_regset_get2_fn tm_cgpr_get;
 int tm_cgpr_set(struct task_struct *target, const struct user_regset *regset,
 		unsigned int pos, unsigned int count,
 		const void *kbuf, const void __user *ubuf);
 int tm_cfpr_active(struct task_struct *target, const struct user_regset *regset);
-int tm_cfpr_get(struct task_struct *target, const struct user_regset *regset,
-		unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+user_regset_get2_fn tm_cfpr_get;
 int tm_cfpr_set(struct task_struct *target, const struct user_regset *regset,
 		unsigned int pos, unsigned int count,
 		const void *kbuf, const void __user *ubuf);
 int tm_cvmx_active(struct task_struct *target, const struct user_regset *regset);
-int tm_cvmx_get(struct task_struct *target, const struct user_regset *regset,
-		unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+user_regset_get2_fn tm_cvmx_get;
 int tm_cvmx_set(struct task_struct *target, const struct user_regset *regset,
 		unsigned int pos, unsigned int count,
 		const void *kbuf, const void __user *ubuf);
 int tm_cvsx_active(struct task_struct *target, const struct user_regset *regset);
-int tm_cvsx_get(struct task_struct *target, const struct user_regset *regset,
-		unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+user_regset_get2_fn tm_cvsx_get;
 int tm_cvsx_set(struct task_struct *target, const struct user_regset *regset,
 		unsigned int pos, unsigned int count,
 		const void *kbuf, const void __user *ubuf);
 int tm_spr_active(struct task_struct *target, const struct user_regset *regset);
-int tm_spr_get(struct task_struct *target, const struct user_regset *regset,
-	       unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+user_regset_get2_fn tm_spr_get;
 int tm_spr_set(struct task_struct *target, const struct user_regset *regset,
 	       unsigned int pos, unsigned int count,
 	       const void *kbuf, const void __user *ubuf);
 int tm_tar_active(struct task_struct *target, const struct user_regset *regset);
-int tm_tar_get(struct task_struct *target, const struct user_regset *regset,
-	       unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+user_regset_get2_fn tm_tar_get;
 int tm_tar_set(struct task_struct *target, const struct user_regset *regset,
 	       unsigned int pos, unsigned int count,
 	       const void *kbuf, const void __user *ubuf);
 int tm_ppr_active(struct task_struct *target, const struct user_regset *regset);
-int tm_ppr_get(struct task_struct *target, const struct user_regset *regset,
-	       unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+user_regset_get2_fn tm_ppr_get;
 int tm_ppr_set(struct task_struct *target, const struct user_regset *regset,
 	       unsigned int pos, unsigned int count,
 	       const void *kbuf, const void __user *ubuf);
 int tm_dscr_active(struct task_struct *target, const struct user_regset *regset);
-int tm_dscr_get(struct task_struct *target, const struct user_regset *regset,
-		unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+user_regset_get2_fn tm_dscr_get;
 int tm_dscr_set(struct task_struct *target, const struct user_regset *regset,
 		unsigned int pos, unsigned int count,
 		const void *kbuf, const void __user *ubuf);
-int tm_cgpr32_get(struct task_struct *target, const struct user_regset *regset,
-		  unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+user_regset_get2_fn tm_cgpr32_get;
 int tm_cgpr32_set(struct task_struct *target, const struct user_regset *regset,
 		  unsigned int pos, unsigned int count,
 		  const void *kbuf, const void __user *ubuf);
diff --git a/arch/powerpc/kernel/ptrace/ptrace-novsx.c b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
index b2dc4e92d11a..b3b36835658a 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-novsx.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
@@ -19,15 +19,14 @@
  * };
  */
 int fpr_get(struct task_struct *target, const struct user_regset *regset,
-	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+	    struct membuf to)
 {
 	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
 		     offsetof(struct thread_fp_state, fpr[32]));
 
 	flush_fp_to_thread(target);
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &target->thread.fp_state, 0, -1);
+	return membuf_write(&to, &target->thread.fp_state, 33 * sizeof(u64));
 }
 
 /*
diff --git a/arch/powerpc/kernel/ptrace/ptrace-spe.c b/arch/powerpc/kernel/ptrace/ptrace-spe.c
index 68b86b4a4be4..47034d069045 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-spe.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-spe.c
@@ -23,25 +23,17 @@ int evr_active(struct task_struct *target, const struct user_regset *regset)
 }
 
 int evr_get(struct task_struct *target, const struct user_regset *regset,
-	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+	    struct membuf to)
 {
-	int ret;
-
 	flush_spe_to_thread(target);
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.evr,
-				  0, sizeof(target->thread.evr));
+	membuf_write(&to, &target->thread.evr, sizeof(target->thread.evr));
 
 	BUILD_BUG_ON(offsetof(struct thread_struct, acc) + sizeof(u64) !=
 		     offsetof(struct thread_struct, spefscr));
 
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &target->thread.acc,
-					  sizeof(target->thread.evr), -1);
-
-	return ret;
+	return membuf_write(&to, &target->thread.acc,
+				sizeof(u64) + sizeof(u32));
 }
 
 int evr_set(struct task_struct *target, const struct user_regset *regset,
diff --git a/arch/powerpc/kernel/ptrace/ptrace-tm.c b/arch/powerpc/kernel/ptrace/ptrace-tm.c
index 32d62c606681..54f2d076206f 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-tm.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-tm.c
@@ -70,10 +70,7 @@ int tm_cgpr_active(struct task_struct *target, const struct user_regset *regset)
  * tm_cgpr_get - get CGPR registers
  * @target:	The target task.
  * @regset:	The user regset structure.
- * @pos:	The buffer position.
- * @count:	Number of bytes to copy.
- * @kbuf:	Kernel buffer to copy from.
- * @ubuf:	User buffer to copy into.
+ * @to:		Destination of copy.
  *
  * This function gets transaction checkpointed GPR registers.
  *
@@ -87,10 +84,8 @@ int tm_cgpr_active(struct task_struct *target, const struct user_regset *regset)
  * };
  */
 int tm_cgpr_get(struct task_struct *target, const struct user_regset *regset,
-		unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+		struct membuf to)
 {
-	int ret;
-
 	if (!cpu_has_feature(CPU_FTR_TM))
 		return -ENODEV;
 
@@ -101,31 +96,18 @@ int tm_cgpr_get(struct task_struct *target, const struct user_regset *regset,
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.ckpt_regs,
-				  0, offsetof(struct pt_regs, msr));
-	if (!ret) {
-		unsigned long msr = get_user_ckpt_msr(target);
-
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &msr,
-					  offsetof(struct pt_regs, msr),
-					  offsetof(struct pt_regs, msr) +
-					  sizeof(msr));
-	}
+	membuf_write(&to, &target->thread.ckpt_regs,
+			offsetof(struct pt_regs, msr));
+	membuf_store(&to, get_user_ckpt_msr(target));
 
 	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
 		     offsetof(struct pt_regs, msr) + sizeof(long));
 
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &target->thread.ckpt_regs.orig_gpr3,
-					  offsetof(struct pt_regs, orig_gpr3),
-					  sizeof(struct user_pt_regs));
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       sizeof(struct user_pt_regs), -1);
-
-	return ret;
+	membuf_write(&to, &target->thread.ckpt_regs.orig_gpr3,
+			sizeof(struct user_pt_regs) -
+			offsetof(struct pt_regs, orig_gpr3));
+	return membuf_zero(&to, ELF_NGREG * sizeof(unsigned long) -
+			sizeof(struct user_pt_regs));
 }
 
 /*
@@ -229,10 +211,7 @@ int tm_cfpr_active(struct task_struct *target, const struct user_regset *regset)
  * tm_cfpr_get - get CFPR registers
  * @target:	The target task.
  * @regset:	The user regset structure.
- * @pos:	The buffer position.
- * @count:	Number of bytes to copy.
- * @kbuf:	Kernel buffer to copy from.
- * @ubuf:	User buffer to copy into.
+ * @to:		Destination of copy.
  *
  * This function gets in transaction checkpointed FPR registers.
  *
@@ -247,7 +226,7 @@ int tm_cfpr_active(struct task_struct *target, const struct user_regset *regset)
  *};
  */
 int tm_cfpr_get(struct task_struct *target, const struct user_regset *regset,
-		unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+		struct membuf to)
 {
 	u64 buf[33];
 	int i;
@@ -266,7 +245,7 @@ int tm_cfpr_get(struct task_struct *target, const struct user_regset *regset,
 	for (i = 0; i < 32 ; i++)
 		buf[i] = target->thread.TS_CKFPR(i);
 	buf[32] = target->thread.ckfp_state.fpscr;
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
+	return membuf_write(&to, buf, sizeof(buf));
 }
 
 /**
@@ -344,10 +323,7 @@ int tm_cvmx_active(struct task_struct *target, const struct user_regset *regset)
  * tm_cvmx_get - get CMVX registers
  * @target:	The target task.
  * @regset:	The user regset structure.
- * @pos:	The buffer position.
- * @count:	Number of bytes to copy.
- * @kbuf:	Kernel buffer to copy from.
- * @ubuf:	User buffer to copy into.
+ * @to:		Destination of copy.
  *
  * This function gets in transaction checkpointed VMX registers.
  *
@@ -363,10 +339,12 @@ int tm_cvmx_active(struct task_struct *target, const struct user_regset *regset)
  *};
  */
 int tm_cvmx_get(struct task_struct *target, const struct user_regset *regset,
-		unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+		struct membuf to)
 {
-	int ret;
-
+	union {
+		elf_vrreg_t reg;
+		u32 word;
+	} vrsave;
 	BUILD_BUG_ON(TVSO(vscr) != TVSO(vr[32]));
 
 	if (!cpu_has_feature(CPU_FTR_TM))
@@ -380,23 +358,13 @@ int tm_cvmx_get(struct task_struct *target, const struct user_regset *regset,
 	flush_fp_to_thread(target);
 	flush_altivec_to_thread(target);
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &target->thread.ckvr_state,
-				  0, 33 * sizeof(vector128));
-	if (!ret) {
-		/*
-		 * Copy out only the low-order word of vrsave.
-		 */
-		union {
-			elf_vrreg_t reg;
-			u32 word;
-		} vrsave;
-		memset(&vrsave, 0, sizeof(vrsave));
-		vrsave.word = target->thread.ckvrsave;
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &vrsave,
-					  33 * sizeof(vector128), -1);
-	}
-
-	return ret;
+	membuf_write(&to, &target->thread.ckvr_state, 33 * sizeof(vector128));
+	/*
+	 * Copy out only the low-order word of vrsave.
+	 */
+	memset(&vrsave, 0, sizeof(vrsave));
+	vrsave.word = target->thread.ckvrsave;
+	return membuf_write(&to, &vrsave, sizeof(vrsave));
 }
 
 /**
@@ -484,10 +452,7 @@ int tm_cvsx_active(struct task_struct *target, const struct user_regset *regset)
  * tm_cvsx_get - get CVSX registers
  * @target:	The target task.
  * @regset:	The user regset structure.
- * @pos:	The buffer position.
- * @count:	Number of bytes to copy.
- * @kbuf:	Kernel buffer to copy from.
- * @ubuf:	User buffer to copy into.
+ * @to:		Destination of copy.
  *
  * This function gets in transaction checkpointed VSX registers.
  *
@@ -501,10 +466,10 @@ int tm_cvsx_active(struct task_struct *target, const struct user_regset *regset)
  *};
  */
 int tm_cvsx_get(struct task_struct *target, const struct user_regset *regset,
-		unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+		struct membuf to)
 {
 	u64 buf[32];
-	int ret, i;
+	int i;
 
 	if (!cpu_has_feature(CPU_FTR_TM))
 		return -ENODEV;
@@ -520,10 +485,7 @@ int tm_cvsx_get(struct task_struct *target, const struct user_regset *regset,
 
 	for (i = 0; i < 32 ; i++)
 		buf[i] = target->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET];
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  buf, 0, 32 * sizeof(double));
-
-	return ret;
+	return membuf_write(&to, buf, 32 * sizeof(double));
 }
 
 /**
@@ -597,10 +559,7 @@ int tm_spr_active(struct task_struct *target, const struct user_regset *regset)
  * tm_spr_get - get the TM related SPR registers
  * @target:	The target task.
  * @regset:	The user regset structure.
- * @pos:	The buffer position.
- * @count:	Number of bytes to copy.
- * @kbuf:	Kernel buffer to copy from.
- * @ubuf:	User buffer to copy into.
+ * @to:		Destination of copy.
  *
  * This function gets transactional memory related SPR registers.
  * The userspace interface buffer layout is as follows.
@@ -612,10 +571,8 @@ int tm_spr_active(struct task_struct *target, const struct user_regset *regset)
  * };
  */
 int tm_spr_get(struct task_struct *target, const struct user_regset *regset,
-	       unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+	       struct membuf to)
 {
-	int ret;
-
 	/* Build tests */
 	BUILD_BUG_ON(TSO(tm_tfhar) + sizeof(u64) != TSO(tm_texasr));
 	BUILD_BUG_ON(TSO(tm_texasr) + sizeof(u64) != TSO(tm_tfiar));
@@ -630,21 +587,11 @@ int tm_spr_get(struct task_struct *target, const struct user_regset *regset,
 	flush_altivec_to_thread(target);
 
 	/* TFHAR register */
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.tm_tfhar, 0, sizeof(u64));
-
+	membuf_write(&to, &target->thread.tm_tfhar, sizeof(u64));
 	/* TEXASR register */
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &target->thread.tm_texasr, sizeof(u64),
-					  2 * sizeof(u64));
-
+	membuf_write(&to, &target->thread.tm_texasr, sizeof(u64));
 	/* TFIAR register */
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &target->thread.tm_tfiar,
-					  2 * sizeof(u64), 3 * sizeof(u64));
-	return ret;
+	return membuf_write(&to, &target->thread.tm_tfiar, sizeof(u64));
 }
 
 /**
@@ -714,19 +661,15 @@ int tm_tar_active(struct task_struct *target, const struct user_regset *regset)
 }
 
 int tm_tar_get(struct task_struct *target, const struct user_regset *regset,
-	       unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+	       struct membuf to)
 {
-	int ret;
-
 	if (!cpu_has_feature(CPU_FTR_TM))
 		return -ENODEV;
 
 	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
 		return -ENODATA;
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.tm_tar, 0, sizeof(u64));
-	return ret;
+	return membuf_write(&to, &target->thread.tm_tar, sizeof(u64));
 }
 
 int tm_tar_set(struct task_struct *target, const struct user_regset *regset,
@@ -759,19 +702,15 @@ int tm_ppr_active(struct task_struct *target, const struct user_regset *regset)
 
 
 int tm_ppr_get(struct task_struct *target, const struct user_regset *regset,
-	       unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+	       struct membuf to)
 {
-	int ret;
-
 	if (!cpu_has_feature(CPU_FTR_TM))
 		return -ENODEV;
 
 	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
 		return -ENODATA;
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.tm_ppr, 0, sizeof(u64));
-	return ret;
+	return membuf_write(&to, &target->thread.tm_ppr, sizeof(u64));
 }
 
 int tm_ppr_set(struct task_struct *target, const struct user_regset *regset,
@@ -803,19 +742,15 @@ int tm_dscr_active(struct task_struct *target, const struct user_regset *regset)
 }
 
 int tm_dscr_get(struct task_struct *target, const struct user_regset *regset,
-		unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+		struct membuf to)
 {
-	int ret;
-
 	if (!cpu_has_feature(CPU_FTR_TM))
 		return -ENODEV;
 
 	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
 		return -ENODATA;
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.tm_dscr, 0, sizeof(u64));
-	return ret;
+	return membuf_write(&to, &target->thread.tm_dscr, sizeof(u64));
 }
 
 int tm_dscr_set(struct task_struct *target, const struct user_regset *regset,
@@ -836,10 +771,11 @@ int tm_dscr_set(struct task_struct *target, const struct user_regset *regset,
 }
 
 int tm_cgpr32_get(struct task_struct *target, const struct user_regset *regset,
-		  unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+		  struct membuf to)
 {
-	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf,
+	gpr32_get_common(target, regset, to,
 				&target->thread.ckpt_regs.gpr[0]);
+	return membuf_zero(&to, ELF_NGREG * sizeof(u32));
 }
 
 int tm_cgpr32_set(struct task_struct *target, const struct user_regset *regset,
diff --git a/arch/powerpc/kernel/ptrace/ptrace-view.c b/arch/powerpc/kernel/ptrace/ptrace-view.c
index caeb5822a8f4..9dbd786a1e08 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-view.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-view.c
@@ -215,9 +215,9 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
 }
 
 static int gpr_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
-	int i, ret;
+	int i;
 
 	if (target->thread.regs == NULL)
 		return -EIO;
@@ -228,30 +228,17 @@ static int gpr_get(struct task_struct *target, const struct user_regset *regset,
 			target->thread.regs->gpr[i] = NV_REG_POISON;
 	}
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  target->thread.regs,
-				  0, offsetof(struct pt_regs, msr));
-	if (!ret) {
-		unsigned long msr = get_user_msr(target);
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &msr,
-					  offsetof(struct pt_regs, msr),
-					  offsetof(struct pt_regs, msr) +
-					  sizeof(msr));
-	}
+	membuf_write(&to, target->thread.regs, offsetof(struct pt_regs, msr));
+	membuf_store(&to, get_user_msr(target));
 
 	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
 		     offsetof(struct pt_regs, msr) + sizeof(long));
 
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &target->thread.regs->orig_gpr3,
-					  offsetof(struct pt_regs, orig_gpr3),
-					  sizeof(struct user_pt_regs));
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       sizeof(struct user_pt_regs), -1);
-
-	return ret;
+	membuf_write(&to, &target->thread.regs->orig_gpr3,
+			sizeof(struct user_pt_regs) -
+			offsetof(struct pt_regs, orig_gpr3));
+	return membuf_zero(&to, ELF_NGREG * sizeof(unsigned long) -
+				 sizeof(struct user_pt_regs));
 }
 
 static int gpr_set(struct task_struct *target, const struct user_regset *regset,
@@ -309,10 +296,9 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 
 #ifdef CONFIG_PPC64
 static int ppr_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &target->thread.regs->ppr, 0, sizeof(u64));
+	return membuf_write(&to, &target->thread.regs->ppr, sizeof(u64));
 }
 
 static int ppr_set(struct task_struct *target, const struct user_regset *regset,
@@ -324,10 +310,9 @@ static int ppr_set(struct task_struct *target, const struct user_regset *regset,
 }
 
 static int dscr_get(struct task_struct *target, const struct user_regset *regset,
-		    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+		    struct membuf to)
 {
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &target->thread.dscr, 0, sizeof(u64));
+	return membuf_write(&to, &target->thread.dscr, sizeof(u64));
 }
 static int dscr_set(struct task_struct *target, const struct user_regset *regset,
 		    unsigned int pos, unsigned int count, const void *kbuf,
@@ -339,10 +324,9 @@ static int dscr_set(struct task_struct *target, const struct user_regset *regset
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
 static int tar_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &target->thread.tar, 0, sizeof(u64));
+	return membuf_write(&to, &target->thread.tar, sizeof(u64));
 }
 static int tar_set(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count, const void *kbuf,
@@ -364,7 +348,7 @@ static int ebb_active(struct task_struct *target, const struct user_regset *regs
 }
 
 static int ebb_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
 	/* Build tests */
 	BUILD_BUG_ON(TSO(ebbrr) + sizeof(unsigned long) != TSO(ebbhr));
@@ -376,8 +360,7 @@ static int ebb_get(struct task_struct *target, const struct user_regset *regset,
 	if (!target->thread.used_ebb)
 		return -ENODATA;
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &target->thread.ebbrr,
-				   0, 3 * sizeof(unsigned long));
+	return membuf_write(&to, &target->thread.ebbrr, 3 * sizeof(unsigned long));
 }
 
 static int ebb_set(struct task_struct *target, const struct user_regset *regset,
@@ -420,7 +403,7 @@ static int pmu_active(struct task_struct *target, const struct user_regset *regs
 }
 
 static int pmu_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
 	/* Build tests */
 	BUILD_BUG_ON(TSO(siar) + sizeof(unsigned long) != TSO(sdar));
@@ -431,8 +414,7 @@ static int pmu_get(struct task_struct *target, const struct user_regset *regset,
 	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
 		return -ENODEV;
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &target->thread.siar,
-				   0, 5 * sizeof(unsigned long));
+	return membuf_write(&to, &target->thread.siar, 5 * sizeof(unsigned long));
 }
 
 static int pmu_set(struct task_struct *target, const struct user_regset *regset,
@@ -486,7 +468,7 @@ static int pkey_active(struct task_struct *target, const struct user_regset *reg
 }
 
 static int pkey_get(struct task_struct *target, const struct user_regset *regset,
-		    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+		    struct membuf to)
 {
 	BUILD_BUG_ON(TSO(amr) + sizeof(unsigned long) != TSO(iamr));
 	BUILD_BUG_ON(TSO(iamr) + sizeof(unsigned long) != TSO(uamor));
@@ -494,8 +476,7 @@ static int pkey_get(struct task_struct *target, const struct user_regset *regset
 	if (!arch_pkeys_enabled())
 		return -ENODEV;
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &target->thread.amr,
-				   0, ELF_NPKEY * sizeof(unsigned long));
+	return membuf_write(&to, &target->thread.amr, ELF_NPKEY * sizeof(unsigned long));
 }
 
 static int pkey_set(struct task_struct *target, const struct user_regset *regset,
@@ -529,110 +510,110 @@ static const struct user_regset native_regsets[] = {
 	[REGSET_GPR] = {
 		.core_note_type = NT_PRSTATUS, .n = ELF_NGREG,
 		.size = sizeof(long), .align = sizeof(long),
-		.get = gpr_get, .set = gpr_set
+		.get2 = gpr_get, .set = gpr_set
 	},
 	[REGSET_FPR] = {
 		.core_note_type = NT_PRFPREG, .n = ELF_NFPREG,
 		.size = sizeof(double), .align = sizeof(double),
-		.get = fpr_get, .set = fpr_set
+		.get2 = fpr_get, .set = fpr_set
 	},
 #ifdef CONFIG_ALTIVEC
 	[REGSET_VMX] = {
 		.core_note_type = NT_PPC_VMX, .n = 34,
 		.size = sizeof(vector128), .align = sizeof(vector128),
-		.active = vr_active, .get = vr_get, .set = vr_set
+		.active = vr_active, .get2 = vr_get, .set = vr_set
 	},
 #endif
 #ifdef CONFIG_VSX
 	[REGSET_VSX] = {
 		.core_note_type = NT_PPC_VSX, .n = 32,
 		.size = sizeof(double), .align = sizeof(double),
-		.active = vsr_active, .get = vsr_get, .set = vsr_set
+		.active = vsr_active, .get2 = vsr_get, .set = vsr_set
 	},
 #endif
 #ifdef CONFIG_SPE
 	[REGSET_SPE] = {
 		.core_note_type = NT_PPC_SPE, .n = 35,
 		.size = sizeof(u32), .align = sizeof(u32),
-		.active = evr_active, .get = evr_get, .set = evr_set
+		.active = evr_active, .get2 = evr_get, .set = evr_set
 	},
 #endif
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	[REGSET_TM_CGPR] = {
 		.core_note_type = NT_PPC_TM_CGPR, .n = ELF_NGREG,
 		.size = sizeof(long), .align = sizeof(long),
-		.active = tm_cgpr_active, .get = tm_cgpr_get, .set = tm_cgpr_set
+		.active = tm_cgpr_active, .get2 = tm_cgpr_get, .set = tm_cgpr_set
 	},
 	[REGSET_TM_CFPR] = {
 		.core_note_type = NT_PPC_TM_CFPR, .n = ELF_NFPREG,
 		.size = sizeof(double), .align = sizeof(double),
-		.active = tm_cfpr_active, .get = tm_cfpr_get, .set = tm_cfpr_set
+		.active = tm_cfpr_active, .get2 = tm_cfpr_get, .set = tm_cfpr_set
 	},
 	[REGSET_TM_CVMX] = {
 		.core_note_type = NT_PPC_TM_CVMX, .n = ELF_NVMX,
 		.size = sizeof(vector128), .align = sizeof(vector128),
-		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
+		.active = tm_cvmx_active, .get2 = tm_cvmx_get, .set = tm_cvmx_set
 	},
 	[REGSET_TM_CVSX] = {
 		.core_note_type = NT_PPC_TM_CVSX, .n = ELF_NVSX,
 		.size = sizeof(double), .align = sizeof(double),
-		.active = tm_cvsx_active, .get = tm_cvsx_get, .set = tm_cvsx_set
+		.active = tm_cvsx_active, .get2 = tm_cvsx_get, .set = tm_cvsx_set
 	},
 	[REGSET_TM_SPR] = {
 		.core_note_type = NT_PPC_TM_SPR, .n = ELF_NTMSPRREG,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = tm_spr_active, .get = tm_spr_get, .set = tm_spr_set
+		.active = tm_spr_active, .get2 = tm_spr_get, .set = tm_spr_set
 	},
 	[REGSET_TM_CTAR] = {
 		.core_note_type = NT_PPC_TM_CTAR, .n = 1,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = tm_tar_active, .get = tm_tar_get, .set = tm_tar_set
+		.active = tm_tar_active, .get2 = tm_tar_get, .set = tm_tar_set
 	},
 	[REGSET_TM_CPPR] = {
 		.core_note_type = NT_PPC_TM_CPPR, .n = 1,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = tm_ppr_active, .get = tm_ppr_get, .set = tm_ppr_set
+		.active = tm_ppr_active, .get2 = tm_ppr_get, .set = tm_ppr_set
 	},
 	[REGSET_TM_CDSCR] = {
 		.core_note_type = NT_PPC_TM_CDSCR, .n = 1,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = tm_dscr_active, .get = tm_dscr_get, .set = tm_dscr_set
+		.active = tm_dscr_active, .get2 = tm_dscr_get, .set = tm_dscr_set
 	},
 #endif
 #ifdef CONFIG_PPC64
 	[REGSET_PPR] = {
 		.core_note_type = NT_PPC_PPR, .n = 1,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.get = ppr_get, .set = ppr_set
+		.get2 = ppr_get, .set = ppr_set
 	},
 	[REGSET_DSCR] = {
 		.core_note_type = NT_PPC_DSCR, .n = 1,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.get = dscr_get, .set = dscr_set
+		.get2 = dscr_get, .set = dscr_set
 	},
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	[REGSET_TAR] = {
 		.core_note_type = NT_PPC_TAR, .n = 1,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.get = tar_get, .set = tar_set
+		.get2 = tar_get, .set = tar_set
 	},
 	[REGSET_EBB] = {
 		.core_note_type = NT_PPC_EBB, .n = ELF_NEBB,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = ebb_active, .get = ebb_get, .set = ebb_set
+		.active = ebb_active, .get2 = ebb_get, .set = ebb_set
 	},
 	[REGSET_PMR] = {
 		.core_note_type = NT_PPC_PMU, .n = ELF_NPMU,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = pmu_active, .get = pmu_get, .set = pmu_set
+		.active = pmu_active, .get2 = pmu_get, .set = pmu_set
 	},
 #endif
 #ifdef CONFIG_PPC_MEM_KEYS
 	[REGSET_PKEY] = {
 		.core_note_type = NT_PPC_PKEY, .n = ELF_NPKEY,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = pkey_active, .get = pkey_get, .set = pkey_set
+		.active = pkey_active, .get2 = pkey_get, .set = pkey_set
 	},
 #endif
 };
@@ -646,49 +627,16 @@ const struct user_regset_view user_ppc_native_view = {
 
 int gpr32_get_common(struct task_struct *target,
 		     const struct user_regset *regset,
-		     unsigned int pos, unsigned int count,
-			    void *kbuf, void __user *ubuf,
-			    unsigned long *regs)
+		     struct membuf to, unsigned long *regs)
 {
-	compat_ulong_t *k = kbuf;
-	compat_ulong_t __user *u = ubuf;
-	compat_ulong_t reg;
-
-	pos /= sizeof(reg);
-	count /= sizeof(reg);
-
-	if (kbuf)
-		for (; count > 0 && pos < PT_MSR; --count)
-			*k++ = regs[pos++];
-	else
-		for (; count > 0 && pos < PT_MSR; --count)
-			if (__put_user((compat_ulong_t)regs[pos++], u++))
-				return -EFAULT;
-
-	if (count > 0 && pos == PT_MSR) {
-		reg = get_user_msr(target);
-		if (kbuf)
-			*k++ = reg;
-		else if (__put_user(reg, u++))
-			return -EFAULT;
-		++pos;
-		--count;
-	}
-
-	if (kbuf)
-		for (; count > 0 && pos < PT_REGS_COUNT; --count)
-			*k++ = regs[pos++];
-	else
-		for (; count > 0 && pos < PT_REGS_COUNT; --count)
-			if (__put_user((compat_ulong_t)regs[pos++], u++))
-				return -EFAULT;
+	int i;
 
-	kbuf = k;
-	ubuf = u;
-	pos *= sizeof(reg);
-	count *= sizeof(reg);
-	return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					PT_REGS_COUNT * sizeof(reg), -1);
+	for (i = 0; i < PT_MSR; i++)
+		membuf_store(&to, (u32)regs[i]);
+	membuf_store(&to, (u32)get_user_msr(target));
+	for (i++ ; i < PT_REGS_COUNT; i++)
+		membuf_store(&to, (u32)regs[i]);
+	return membuf_zero(&to, (ELF_NGREG - PT_REGS_COUNT) * sizeof(u32));
 }
 
 int gpr32_set_common(struct task_struct *target,
@@ -761,8 +709,7 @@ int gpr32_set_common(struct task_struct *target,
 
 static int gpr32_get(struct task_struct *target,
 		     const struct user_regset *regset,
-		     unsigned int pos, unsigned int count,
-		     void *kbuf, void __user *ubuf)
+		     struct membuf to)
 {
 	int i;
 
@@ -777,7 +724,7 @@ static int gpr32_get(struct task_struct *target,
 		for (i = 14; i < 32; i++)
 			target->thread.regs->gpr[i] = NV_REG_POISON;
 	}
-	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf,
+	return gpr32_get_common(target, regset, to,
 			&target->thread.regs->gpr[0]);
 }
 
@@ -801,25 +748,25 @@ static const struct user_regset compat_regsets[] = {
 	[REGSET_GPR] = {
 		.core_note_type = NT_PRSTATUS, .n = ELF_NGREG,
 		.size = sizeof(compat_long_t), .align = sizeof(compat_long_t),
-		.get = gpr32_get, .set = gpr32_set
+		.get2 = gpr32_get, .set = gpr32_set
 	},
 	[REGSET_FPR] = {
 		.core_note_type = NT_PRFPREG, .n = ELF_NFPREG,
 		.size = sizeof(double), .align = sizeof(double),
-		.get = fpr_get, .set = fpr_set
+		.get2 = fpr_get, .set = fpr_set
 	},
 #ifdef CONFIG_ALTIVEC
 	[REGSET_VMX] = {
 		.core_note_type = NT_PPC_VMX, .n = 34,
 		.size = sizeof(vector128), .align = sizeof(vector128),
-		.active = vr_active, .get = vr_get, .set = vr_set
+		.active = vr_active, .get2 = vr_get, .set = vr_set
 	},
 #endif
 #ifdef CONFIG_SPE
 	[REGSET_SPE] = {
 		.core_note_type = NT_PPC_SPE, .n = 35,
 		.size = sizeof(u32), .align = sizeof(u32),
-		.active = evr_active, .get = evr_get, .set = evr_set
+		.active = evr_active, .get2 = evr_get, .set = evr_set
 	},
 #endif
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
@@ -827,66 +774,66 @@ static const struct user_regset compat_regsets[] = {
 		.core_note_type = NT_PPC_TM_CGPR, .n = ELF_NGREG,
 		.size = sizeof(long), .align = sizeof(long),
 		.active = tm_cgpr_active,
-		.get = tm_cgpr32_get, .set = tm_cgpr32_set
+		.get2 = tm_cgpr32_get, .set = tm_cgpr32_set
 	},
 	[REGSET_TM_CFPR] = {
 		.core_note_type = NT_PPC_TM_CFPR, .n = ELF_NFPREG,
 		.size = sizeof(double), .align = sizeof(double),
-		.active = tm_cfpr_active, .get = tm_cfpr_get, .set = tm_cfpr_set
+		.active = tm_cfpr_active, .get2 = tm_cfpr_get, .set = tm_cfpr_set
 	},
 	[REGSET_TM_CVMX] = {
 		.core_note_type = NT_PPC_TM_CVMX, .n = ELF_NVMX,
 		.size = sizeof(vector128), .align = sizeof(vector128),
-		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
+		.active = tm_cvmx_active, .get2 = tm_cvmx_get, .set = tm_cvmx_set
 	},
 	[REGSET_TM_CVSX] = {
 		.core_note_type = NT_PPC_TM_CVSX, .n = ELF_NVSX,
 		.size = sizeof(double), .align = sizeof(double),
-		.active = tm_cvsx_active, .get = tm_cvsx_get, .set = tm_cvsx_set
+		.active = tm_cvsx_active, .get2 = tm_cvsx_get, .set = tm_cvsx_set
 	},
 	[REGSET_TM_SPR] = {
 		.core_note_type = NT_PPC_TM_SPR, .n = ELF_NTMSPRREG,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = tm_spr_active, .get = tm_spr_get, .set = tm_spr_set
+		.active = tm_spr_active, .get2 = tm_spr_get, .set = tm_spr_set
 	},
 	[REGSET_TM_CTAR] = {
 		.core_note_type = NT_PPC_TM_CTAR, .n = 1,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = tm_tar_active, .get = tm_tar_get, .set = tm_tar_set
+		.active = tm_tar_active, .get2 = tm_tar_get, .set = tm_tar_set
 	},
 	[REGSET_TM_CPPR] = {
 		.core_note_type = NT_PPC_TM_CPPR, .n = 1,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = tm_ppr_active, .get = tm_ppr_get, .set = tm_ppr_set
+		.active = tm_ppr_active, .get2 = tm_ppr_get, .set = tm_ppr_set
 	},
 	[REGSET_TM_CDSCR] = {
 		.core_note_type = NT_PPC_TM_CDSCR, .n = 1,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = tm_dscr_active, .get = tm_dscr_get, .set = tm_dscr_set
+		.active = tm_dscr_active, .get2 = tm_dscr_get, .set = tm_dscr_set
 	},
 #endif
 #ifdef CONFIG_PPC64
 	[REGSET_PPR] = {
 		.core_note_type = NT_PPC_PPR, .n = 1,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.get = ppr_get, .set = ppr_set
+		.get2 = ppr_get, .set = ppr_set
 	},
 	[REGSET_DSCR] = {
 		.core_note_type = NT_PPC_DSCR, .n = 1,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.get = dscr_get, .set = dscr_set
+		.get2 = dscr_get, .set = dscr_set
 	},
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	[REGSET_TAR] = {
 		.core_note_type = NT_PPC_TAR, .n = 1,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.get = tar_get, .set = tar_set
+		.get2 = tar_get, .set = tar_set
 	},
 	[REGSET_EBB] = {
 		.core_note_type = NT_PPC_EBB, .n = ELF_NEBB,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = ebb_active, .get = ebb_get, .set = ebb_set
+		.active = ebb_active, .get2 = ebb_get, .set = ebb_set
 	},
 #endif
 };
diff --git a/arch/powerpc/kernel/ptrace/ptrace-vsx.c b/arch/powerpc/kernel/ptrace/ptrace-vsx.c
index d53466d49cc0..1da4303128ef 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-vsx.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-vsx.c
@@ -19,7 +19,7 @@
  * };
  */
 int fpr_get(struct task_struct *target, const struct user_regset *regset,
-	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+	    struct membuf to)
 {
 	u64 buf[33];
 	int i;
@@ -30,7 +30,7 @@ int fpr_get(struct task_struct *target, const struct user_regset *regset,
 	for (i = 0; i < 32 ; i++)
 		buf[i] = target->thread.TS_FPR(i);
 	buf[32] = target->thread.fp_state.fpscr;
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
+	return membuf_write(&to, buf, 33 * sizeof(u64));
 }
 
 /*
@@ -95,10 +95,10 @@ int vsr_active(struct task_struct *target, const struct user_regset *regset)
  * };
  */
 int vsr_get(struct task_struct *target, const struct user_regset *regset,
-	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+	    struct membuf to)
 {
 	u64 buf[32];
-	int ret, i;
+	int i;
 
 	flush_tmregs_to_thread(target);
 	flush_fp_to_thread(target);
@@ -108,10 +108,7 @@ int vsr_get(struct task_struct *target, const struct user_regset *regset,
 	for (i = 0; i < 32 ; i++)
 		buf[i] = target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  buf, 0, 32 * sizeof(double));
-
-	return ret;
+	return membuf_write(&to, buf, 32 * sizeof(double));
 }
 
 /*
-- 
2.11.0


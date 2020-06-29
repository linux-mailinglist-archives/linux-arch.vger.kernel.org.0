Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E65B20E4B6
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgF2V2Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbgF2Smn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:43 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F6DC033C1C;
        Mon, 29 Jun 2020 11:26:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUB-002DvF-00; Mon, 29 Jun 2020 18:26:31 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 23/41] mips: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:10 +0100
Message-Id: <20200629182628.529995-23-viro@ZenIV.linux.org.uk>
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
 arch/mips/kernel/ptrace.c | 204 +++++++++++++---------------------------------
 1 file changed, 58 insertions(+), 146 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 2a61641c680b..9622c059f54d 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -210,15 +210,13 @@ int ptrace_set_watch_regs(struct task_struct *child,
 
 static int gpr32_get(struct task_struct *target,
 		     const struct user_regset *regset,
-		     unsigned int pos, unsigned int count,
-		     void *kbuf, void __user *ubuf)
+		     struct membuf to)
 {
 	struct pt_regs *regs = task_pt_regs(target);
 	u32 uregs[ELF_NGREG] = {};
 
 	mips_dump_regs32(uregs, regs);
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0,
-				   sizeof(uregs));
+	return membuf_write(&to, uregs, sizeof(uregs));
 }
 
 static int gpr32_set(struct task_struct *target,
@@ -277,15 +275,13 @@ static int gpr32_set(struct task_struct *target,
 
 static int gpr64_get(struct task_struct *target,
 		     const struct user_regset *regset,
-		     unsigned int pos, unsigned int count,
-		     void *kbuf, void __user *ubuf)
+		     struct membuf to)
 {
 	struct pt_regs *regs = task_pt_regs(target);
 	u64 uregs[ELF_NGREG] = {};
 
 	mips_dump_regs64(uregs, regs);
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0,
-				   sizeof(uregs));
+	return membuf_write(&to, uregs, sizeof(uregs));
 }
 
 static int gpr64_set(struct task_struct *target,
@@ -408,13 +404,11 @@ int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
  * !CONFIG_CPU_HAS_MSA variant.  FP context's general register slots
  * correspond 1:1 to buffer slots.  Only general registers are copied.
  */
-static int fpr_get_fpa(struct task_struct *target,
-		       unsigned int *pos, unsigned int *count,
-		       void **kbuf, void __user **ubuf)
+static void fpr_get_fpa(struct task_struct *target,
+		       struct membuf *to)
 {
-	return user_regset_copyout(pos, count, kbuf, ubuf,
-				   &target->thread.fpu,
-				   0, NUM_FPU_REGS * sizeof(elf_fpreg_t));
+	membuf_write(to, &target->thread.fpu,
+			NUM_FPU_REGS * sizeof(elf_fpreg_t));
 }
 
 /*
@@ -423,25 +417,13 @@ static int fpr_get_fpa(struct task_struct *target,
  * general register slots are copied to buffer slots.  Only general
  * registers are copied.
  */
-static int fpr_get_msa(struct task_struct *target,
-		       unsigned int *pos, unsigned int *count,
-		       void **kbuf, void __user **ubuf)
+static void fpr_get_msa(struct task_struct *target, struct membuf *to)
 {
 	unsigned int i;
-	u64 fpr_val;
-	int err;
-
-	BUILD_BUG_ON(sizeof(fpr_val) != sizeof(elf_fpreg_t));
-	for (i = 0; i < NUM_FPU_REGS; i++) {
-		fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
-		err = user_regset_copyout(pos, count, kbuf, ubuf,
-					  &fpr_val, i * sizeof(elf_fpreg_t),
-					  (i + 1) * sizeof(elf_fpreg_t));
-		if (err)
-			return err;
-	}
 
-	return 0;
+	BUILD_BUG_ON(sizeof(u64) != sizeof(elf_fpreg_t));
+	for (i = 0; i < NUM_FPU_REGS; i++)
+		membuf_store(to, get_fpr64(&target->thread.fpu.fpr[i], 0));
 }
 
 /*
@@ -451,31 +433,16 @@ static int fpr_get_msa(struct task_struct *target,
  */
 static int fpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
-	const int fcr31_pos = NUM_FPU_REGS * sizeof(elf_fpreg_t);
-	const int fir_pos = fcr31_pos + sizeof(u32);
-	int err;
-
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
-		err = fpr_get_fpa(target, &pos, &count, &kbuf, &ubuf);
+		fpr_get_fpa(target, &to);
 	else
-		err = fpr_get_msa(target, &pos, &count, &kbuf, &ubuf);
-	if (err)
-		return err;
-
-	err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.fpu.fcr31,
-				  fcr31_pos, fcr31_pos + sizeof(u32));
-	if (err)
-		return err;
+		fpr_get_msa(target, &to);
 
-	err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &boot_cpu_data.fpu_id,
-				  fir_pos, fir_pos + sizeof(u32));
-
-	return err;
+	membuf_write(&to, &target->thread.fpu.fcr31, sizeof(u32));
+	membuf_write(&to, &boot_cpu_data.fpu_id, sizeof(u32));
+	return 0;
 }
 
 /*
@@ -576,14 +543,9 @@ static int fpr_set(struct task_struct *target,
 /* Copy the FP mode setting to the supplied NT_MIPS_FP_MODE buffer.  */
 static int fp_mode_get(struct task_struct *target,
 		       const struct user_regset *regset,
-		       unsigned int pos, unsigned int count,
-		       void *kbuf, void __user *ubuf)
+		       struct membuf to)
 {
-	int fp_mode;
-
-	fp_mode = mips_get_process_fp_mode(target);
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &fp_mode, 0,
-				   sizeof(fp_mode));
+	return membuf_store(&to, (int)mips_get_process_fp_mode(target));
 }
 
 /*
@@ -630,13 +592,12 @@ struct msa_control_regs {
 	unsigned int msacsr;
 };
 
-static int copy_pad_fprs(struct task_struct *target,
+static void copy_pad_fprs(struct task_struct *target,
 			 const struct user_regset *regset,
-			 unsigned int *ppos, unsigned int *pcount,
-			 void **pkbuf, void __user **pubuf,
+			 struct membuf *to,
 			 unsigned int live_sz)
 {
-	int i, j, start, start_pad, err;
+	int i, j;
 	unsigned long long fill = ~0ull;
 	unsigned int cp_sz, pad_sz;
 
@@ -644,28 +605,16 @@ static int copy_pad_fprs(struct task_struct *target,
 	pad_sz = regset->size - cp_sz;
 	WARN_ON(pad_sz % sizeof(fill));
 
-	i = start = err = 0;
-	for (; i < NUM_FPU_REGS; i++, start += regset->size) {
-		err |= user_regset_copyout(ppos, pcount, pkbuf, pubuf,
-					   &target->thread.fpu.fpr[i],
-					   start, start + cp_sz);
-
-		start_pad = start + cp_sz;
-		for (j = 0; j < (pad_sz / sizeof(fill)); j++) {
-			err |= user_regset_copyout(ppos, pcount, pkbuf, pubuf,
-						   &fill, start_pad,
-						   start_pad + sizeof(fill));
-			start_pad += sizeof(fill);
-		}
+	for (i = 0; i < NUM_FPU_REGS; i++) {
+		membuf_write(to, &target->thread.fpu.fpr[i], cp_sz);
+		for (j = 0; j < (pad_sz / sizeof(fill)); j++)
+			membuf_store(to, fill);
 	}
-
-	return err;
 }
 
 static int msa_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
 	const unsigned int wr_size = NUM_FPU_REGS * regset->size;
 	const struct msa_control_regs ctrl_regs = {
@@ -674,32 +623,23 @@ static int msa_get(struct task_struct *target,
 		.msair = boot_cpu_data.msa_id,
 		.msacsr = target->thread.fpu.msacsr,
 	};
-	int err;
 
 	if (!tsk_used_math(target)) {
 		/* The task hasn't used FP or MSA, fill with 0xff */
-		err = copy_pad_fprs(target, regset, &pos, &count,
-				    &kbuf, &ubuf, 0);
+		copy_pad_fprs(target, regset, &to, 0);
 	} else if (!test_tsk_thread_flag(target, TIF_MSA_CTX_LIVE)) {
 		/* Copy scalar FP context, fill the rest with 0xff */
-		err = copy_pad_fprs(target, regset, &pos, &count,
-				    &kbuf, &ubuf, 8);
+		copy_pad_fprs(target, regset, &to, 8);
 	} else if (sizeof(target->thread.fpu.fpr[0]) == regset->size) {
 		/* Trivially copy the vector registers */
-		err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &target->thread.fpu.fpr,
-					  0, wr_size);
+		membuf_write(&to, &target->thread.fpu.fpr, wr_size);
 	} else {
 		/* Copy as much context as possible, fill the rest with 0xff */
-		err = copy_pad_fprs(target, regset, &pos, &count,
-				    &kbuf, &ubuf,
-				    sizeof(target->thread.fpu.fpr[0]));
+		copy_pad_fprs(target, regset, &to,
+				sizeof(target->thread.fpu.fpr[0]));
 	}
 
-	err |= user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &ctrl_regs, wr_size,
-				   wr_size + sizeof(ctrl_regs));
-	return err;
+	return membuf_write(&to, &ctrl_regs, sizeof(ctrl_regs));
 }
 
 static int msa_set(struct task_struct *target,
@@ -752,34 +692,20 @@ static int msa_set(struct task_struct *target,
  */
 static int dsp32_get(struct task_struct *target,
 		     const struct user_regset *regset,
-		     unsigned int pos, unsigned int count,
-		     void *kbuf, void __user *ubuf)
+		     struct membuf to)
 {
-	unsigned int start, num_regs, i;
 	u32 dspregs[NUM_DSP_REGS + 1];
+	unsigned int i;
 
-	BUG_ON(count % sizeof(u32));
+	BUG_ON(to.left % sizeof(u32));
 
 	if (!cpu_has_dsp)
 		return -EIO;
 
-	start = pos / sizeof(u32);
-	num_regs = count / sizeof(u32);
-
-	if (start + num_regs > NUM_DSP_REGS + 1)
-		return -EIO;
-
-	for (i = start; i < num_regs; i++)
-		switch (i) {
-		case 0 ... NUM_DSP_REGS - 1:
-			dspregs[i] = target->thread.dsp.dspr[i];
-			break;
-		case NUM_DSP_REGS:
-			dspregs[i] = target->thread.dsp.dspcontrol;
-			break;
-		}
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, dspregs, 0,
-				   sizeof(dspregs));
+	for (i = 0; i < NUM_DSP_REGS; i++)
+		dspregs[i] = target->thread.dsp.dspr[i];
+	dspregs[NUM_DSP_REGS] = target->thread.dsp.dspcontrol;
+	return membuf_write(&to, dspregs, sizeof(dspregs));
 }
 
 /*
@@ -832,34 +758,20 @@ static int dsp32_set(struct task_struct *target,
  */
 static int dsp64_get(struct task_struct *target,
 		     const struct user_regset *regset,
-		     unsigned int pos, unsigned int count,
-		     void *kbuf, void __user *ubuf)
+		     struct membuf to)
 {
-	unsigned int start, num_regs, i;
 	u64 dspregs[NUM_DSP_REGS + 1];
+	unsigned int i;
 
-	BUG_ON(count % sizeof(u64));
+	BUG_ON(to.left % sizeof(u64));
 
 	if (!cpu_has_dsp)
 		return -EIO;
 
-	start = pos / sizeof(u64);
-	num_regs = count / sizeof(u64);
-
-	if (start + num_regs > NUM_DSP_REGS + 1)
-		return -EIO;
-
-	for (i = start; i < num_regs; i++)
-		switch (i) {
-		case 0 ... NUM_DSP_REGS - 1:
-			dspregs[i] = target->thread.dsp.dspr[i];
-			break;
-		case NUM_DSP_REGS:
-			dspregs[i] = target->thread.dsp.dspcontrol;
-			break;
-		}
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, dspregs, 0,
-				   sizeof(dspregs));
+	for (i = 0; i < NUM_DSP_REGS; i++)
+		dspregs[i] = target->thread.dsp.dspr[i];
+	dspregs[NUM_DSP_REGS] = target->thread.dsp.dspcontrol;
+	return membuf_write(&to, dspregs, sizeof(dspregs));
 }
 
 /*
@@ -1018,7 +930,7 @@ static const struct user_regset mips_regsets[] = {
 		.n		= ELF_NGREG,
 		.size		= sizeof(unsigned int),
 		.align		= sizeof(unsigned int),
-		.get		= gpr32_get,
+		.get2		= gpr32_get,
 		.set		= gpr32_set,
 	},
 	[REGSET_DSP] = {
@@ -1026,7 +938,7 @@ static const struct user_regset mips_regsets[] = {
 		.n		= NUM_DSP_REGS + 1,
 		.size		= sizeof(u32),
 		.align		= sizeof(u32),
-		.get		= dsp32_get,
+		.get2		= dsp32_get,
 		.set		= dsp32_set,
 		.active		= dsp_active,
 	},
@@ -1036,7 +948,7 @@ static const struct user_regset mips_regsets[] = {
 		.n		= ELF_NFPREG,
 		.size		= sizeof(elf_fpreg_t),
 		.align		= sizeof(elf_fpreg_t),
-		.get		= fpr_get,
+		.get2		= fpr_get,
 		.set		= fpr_set,
 	},
 	[REGSET_FP_MODE] = {
@@ -1044,7 +956,7 @@ static const struct user_regset mips_regsets[] = {
 		.n		= 1,
 		.size		= sizeof(int),
 		.align		= sizeof(int),
-		.get		= fp_mode_get,
+		.get2		= fp_mode_get,
 		.set		= fp_mode_set,
 	},
 #endif
@@ -1054,7 +966,7 @@ static const struct user_regset mips_regsets[] = {
 		.n		= NUM_FPU_REGS + 1,
 		.size		= 16,
 		.align		= 16,
-		.get		= msa_get,
+		.get2		= msa_get,
 		.set		= msa_set,
 	},
 #endif
@@ -1078,7 +990,7 @@ static const struct user_regset mips64_regsets[] = {
 		.n		= ELF_NGREG,
 		.size		= sizeof(unsigned long),
 		.align		= sizeof(unsigned long),
-		.get		= gpr64_get,
+		.get2		= gpr64_get,
 		.set		= gpr64_set,
 	},
 	[REGSET_DSP] = {
@@ -1086,7 +998,7 @@ static const struct user_regset mips64_regsets[] = {
 		.n		= NUM_DSP_REGS + 1,
 		.size		= sizeof(u64),
 		.align		= sizeof(u64),
-		.get		= dsp64_get,
+		.get2		= dsp64_get,
 		.set		= dsp64_set,
 		.active		= dsp_active,
 	},
@@ -1096,7 +1008,7 @@ static const struct user_regset mips64_regsets[] = {
 		.n		= 1,
 		.size		= sizeof(int),
 		.align		= sizeof(int),
-		.get		= fp_mode_get,
+		.get2		= fp_mode_get,
 		.set		= fp_mode_set,
 	},
 	[REGSET_FPR] = {
@@ -1104,7 +1016,7 @@ static const struct user_regset mips64_regsets[] = {
 		.n		= ELF_NFPREG,
 		.size		= sizeof(elf_fpreg_t),
 		.align		= sizeof(elf_fpreg_t),
-		.get		= fpr_get,
+		.get2		= fpr_get,
 		.set		= fpr_set,
 	},
 #endif
@@ -1114,7 +1026,7 @@ static const struct user_regset mips64_regsets[] = {
 		.n		= NUM_FPU_REGS + 1,
 		.size		= 16,
 		.align		= 16,
-		.get		= msa_get,
+		.get2		= msa_get,
 		.set		= msa_set,
 	},
 #endif
-- 
2.11.0


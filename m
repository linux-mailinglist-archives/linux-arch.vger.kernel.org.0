Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEC320E4C2
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391186AbgF2V2q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbgF2Smm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864E8C033C22;
        Mon, 29 Jun 2020 11:26:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUA-002Dul-HA; Mon, 29 Jun 2020 18:26:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 19/41] x86: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:06 +0100
Message-Id: <20200629182628.529995-19-viro@ZenIV.linux.org.uk>
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

	All instances of ->get() in arch/x86 switched; that might or might
not be worth splitting up.  Notes:

	* for xstateregs_get() the amount we want to store is determined at
the boot time; see init_xstate_size() and update_regset_xstate_info() for
details.  task->thread.fpu.state.xsave ends with a flexible array member and
the amount of data in it depends upon the FPU features supported/enabled.

	* fpregs_get() writes slightly less than full ->thread.fpu.state.fsave
(the last word is not copied); we pass the full size of state.fsave and let
membuf_write() trim to the amount declared by regset - __regset_get() will
make sure that the space in buffer is no more than that.

	* copy_xstate_to_user() and its helpers are gone now.

	* fpregs_soft_get() was getting user_regset_copyout() arguments
wrong.  Since "x86: x86 user_regset math_emu" back in 2008...  I really
doubt that it's worth splitting out for -stable, though - you need
a 486SX box for that to trigger...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/fpu/regset.h |   4 +-
 arch/x86/include/asm/fpu/xstate.h |   4 +-
 arch/x86/kernel/fpu/regset.c      |  39 ++++-----
 arch/x86/kernel/fpu/signal.c      |   3 +-
 arch/x86/kernel/fpu/xstate.c      | 164 +++++++-------------------------------
 arch/x86/kernel/ptrace.c          |  75 ++++++-----------
 arch/x86/kernel/tls.c             |  32 ++------
 arch/x86/kernel/tls.h             |   2 +-
 arch/x86/math-emu/fpu_entry.c     |  19 ++---
 9 files changed, 83 insertions(+), 259 deletions(-)

diff --git a/arch/x86/include/asm/fpu/regset.h b/arch/x86/include/asm/fpu/regset.h
index d5bdffb9d27f..4f928d6a367b 100644
--- a/arch/x86/include/asm/fpu/regset.h
+++ b/arch/x86/include/asm/fpu/regset.h
@@ -8,8 +8,8 @@
 #include <linux/regset.h>
 
 extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active;
-extern user_regset_get_fn fpregs_get, xfpregs_get, fpregs_soft_get,
-				xstateregs_get;
+extern user_regset_get2_fn fpregs_get, xfpregs_get, fpregs_soft_get,
+				 xstateregs_get;
 extern user_regset_set_fn fpregs_set, xfpregs_set, fpregs_soft_set,
 				 xstateregs_set;
 
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 422d8369012a..f691ea1bc086 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -71,8 +71,8 @@ extern void __init update_regset_xstate_info(unsigned int size,
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
-int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
-int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
+struct membuf;
+void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave);
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 void copy_supervisor_to_kernel(struct xregs_state *xsave);
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 91f80aca27fb..c413756ba89f 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -27,8 +27,7 @@ int regset_xregset_fpregs_active(struct task_struct *target, const struct user_r
 }
 
 int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
-		unsigned int pos, unsigned int count,
-		void *kbuf, void __user *ubuf)
+		struct membuf to)
 {
 	struct fpu *fpu = &target->thread.fpu;
 
@@ -38,8 +37,7 @@ int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 	fpu__prepare_read(fpu);
 	fpstate_sanitize_xstate(fpu);
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &fpu->state.fxsave, 0, -1);
+	return membuf_write(&to, &fpu->state.fxsave, sizeof(struct fxregs_state));
 }
 
 int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
@@ -74,12 +72,10 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 }
 
 int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
-		unsigned int pos, unsigned int count,
-		void *kbuf, void __user *ubuf)
+		struct membuf to)
 {
 	struct fpu *fpu = &target->thread.fpu;
 	struct xregs_state *xsave;
-	int ret;
 
 	if (!boot_cpu_has(X86_FEATURE_XSAVE))
 		return -ENODEV;
@@ -89,10 +85,8 @@ int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 	fpu__prepare_read(fpu);
 
 	if (using_compacted_format()) {
-		if (kbuf)
-			ret = copy_xstate_to_kernel(kbuf, xsave, pos, count);
-		else
-			ret = copy_xstate_to_user(ubuf, xsave, pos, count);
+		copy_xstate_to_kernel(to, xsave);
+		return 0;
 	} else {
 		fpstate_sanitize_xstate(fpu);
 		/*
@@ -105,9 +99,8 @@ int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 		/*
 		 * Copy the xstate memory layout.
 		 */
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, xsave, 0, -1);
+		return membuf_write(&to, xsave, fpu_user_xstate_size);
 	}
-	return ret;
 }
 
 int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
@@ -293,8 +286,7 @@ void convert_to_fxsr(struct fxregs_state *fxsave,
 }
 
 int fpregs_get(struct task_struct *target, const struct user_regset *regset,
-	       unsigned int pos, unsigned int count,
-	       void *kbuf, void __user *ubuf)
+	       struct membuf to)
 {
 	struct fpu *fpu = &target->thread.fpu;
 	struct user_i387_ia32_struct env;
@@ -302,23 +294,22 @@ int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 	fpu__prepare_read(fpu);
 
 	if (!boot_cpu_has(X86_FEATURE_FPU))
-		return fpregs_soft_get(target, regset, pos, count, kbuf, ubuf);
+		return fpregs_soft_get(target, regset, to);
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR))
-		return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					   &fpu->state.fsave, 0,
-					   -1);
+	if (!boot_cpu_has(X86_FEATURE_FXSR)) {
+		return membuf_write(&to, &fpu->state.fsave,
+				    sizeof(struct fregs_state));
+	}
 
 	fpstate_sanitize_xstate(fpu);
 
-	if (kbuf && pos == 0 && count == sizeof(env)) {
-		convert_from_fxsr(kbuf, target);
+	if (to.left == sizeof(env)) {
+		convert_from_fxsr(to.p, target);
 		return 0;
 	}
 
 	convert_from_fxsr(&env, target);
-
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &env, 0, -1);
+	return membuf_write(&to, &env, sizeof(env));
 }
 
 int fpregs_set(struct task_struct *target, const struct user_regset *regset,
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index e0b832df7404..a4ec65317a7f 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -172,7 +172,8 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 
 	if (!static_cpu_has(X86_FEATURE_FPU)) {
 		struct user_i387_ia32_struct fp;
-		fpregs_soft_get(current, NULL, 0, sizeof(fp), &fp, NULL);
+		fpregs_soft_get(current, NULL, (struct membuf){.p = &fp,
+						.left = sizeof(fp)});
 		return copy_to_user(buf, &fp, sizeof(fp)) ? -EFAULT : 0;
 	}
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index bda2e5eaca0e..c80d4734c1f6 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1009,32 +1009,20 @@ static inline bool xfeatures_mxcsr_quirk(u64 xfeatures)
 	return true;
 }
 
-static void fill_gap(unsigned to, void **kbuf, unsigned *pos, unsigned *count)
+static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
 {
-	if (*pos < to) {
-		unsigned size = to - *pos;
-
-		if (size > *count)
-			size = *count;
-		memcpy(*kbuf, (void *)&init_fpstate.xsave + *pos, size);
-		*kbuf += size;
-		*pos += size;
-		*count -= size;
-	}
+	if (*last >= offset)
+		return;
+	membuf_write(to, (void *)&init_fpstate.xsave + *last, offset - *last);
+	*last = offset;
 }
 
-static void copy_part(unsigned offset, unsigned size, void *from,
-			void **kbuf, unsigned *pos, unsigned *count)
+static void copy_part(struct membuf *to, unsigned *last, unsigned offset,
+		      unsigned size, void *from)
 {
-	fill_gap(offset, kbuf, pos, count);
-	if (size > *count)
-		size = *count;
-	if (size) {
-		memcpy(*kbuf, from, size);
-		*kbuf += size;
-		*pos += size;
-		*count -= size;
-	}
+	fill_gap(to, last, offset);
+	membuf_write(to, from, size);
+	*last = offset + size;
 }
 
 /*
@@ -1044,20 +1032,15 @@ static void copy_part(unsigned offset, unsigned size, void *from,
  * It supports partial copy but pos always starts from zero. This is called
  * from xstateregs_get() and there we check the CPU has XSAVES.
  */
-int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int offset_start, unsigned int size_total)
+void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
 {
 	struct xstate_header header;
 	const unsigned off_mxcsr = offsetof(struct fxregs_state, mxcsr);
-	unsigned count = size_total;
+	unsigned size = to.left;
+	unsigned last = 0;
 	int i;
 
 	/*
-	 * Currently copy_regset_to_user() starts from pos 0:
-	 */
-	if (unlikely(offset_start != 0))
-		return -EFAULT;
-
-	/*
 	 * The destination is a ptrace buffer; we put in only user xstates:
 	 */
 	memset(&header, 0, sizeof(header));
@@ -1065,27 +1048,26 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 	header.xfeatures &= xfeatures_mask_user();
 
 	if (header.xfeatures & XFEATURE_MASK_FP)
-		copy_part(0, off_mxcsr,
-			  &xsave->i387, &kbuf, &offset_start, &count);
+		copy_part(&to, &last, 0, off_mxcsr, &xsave->i387);
 	if (header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM))
-		copy_part(off_mxcsr, MXCSR_AND_FLAGS_SIZE,
-			  &xsave->i387.mxcsr, &kbuf, &offset_start, &count);
+		copy_part(&to, &last, off_mxcsr,
+			  MXCSR_AND_FLAGS_SIZE, &xsave->i387.mxcsr);
 	if (header.xfeatures & XFEATURE_MASK_FP)
-		copy_part(offsetof(struct fxregs_state, st_space), 128,
-			  &xsave->i387.st_space, &kbuf, &offset_start, &count);
+		copy_part(&to, &last, offsetof(struct fxregs_state, st_space),
+			  128, &xsave->i387.st_space);
 	if (header.xfeatures & XFEATURE_MASK_SSE)
-		copy_part(xstate_offsets[XFEATURE_MASK_SSE], 256,
-			  &xsave->i387.xmm_space, &kbuf, &offset_start, &count);
+		copy_part(&to, &last, xstate_offsets[XFEATURE_MASK_SSE],
+			  256, &xsave->i387.xmm_space);
 	/*
 	 * Fill xsave->i387.sw_reserved value for ptrace frame:
 	 */
-	copy_part(offsetof(struct fxregs_state, sw_reserved), 48,
-		  xstate_fx_sw_bytes, &kbuf, &offset_start, &count);
+	copy_part(&to, &last, offsetof(struct fxregs_state, sw_reserved),
+		  48, xstate_fx_sw_bytes);
 	/*
 	 * Copy xregs_state->header:
 	 */
-	copy_part(offsetof(struct xregs_state, header), sizeof(header),
-		  &header, &kbuf, &offset_start, &count);
+	copy_part(&to, &last, offsetof(struct xregs_state, header),
+		  sizeof(header), &header);
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		/*
@@ -1094,104 +1076,12 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 		if ((header.xfeatures >> i) & 1) {
 			void *src = __raw_xsave_addr(xsave, i);
 
-			copy_part(xstate_offsets[i], xstate_sizes[i],
-				  src, &kbuf, &offset_start, &count);
+			copy_part(&to, &last, xstate_offsets[i],
+				  xstate_sizes[i], src);
 		}
 
 	}
-	fill_gap(size_total, &kbuf, &offset_start, &count);
-
-	return 0;
-}
-
-static inline int
-__copy_xstate_to_user(void __user *ubuf, const void *data, unsigned int offset, unsigned int size, unsigned int size_total)
-{
-	if (!size)
-		return 0;
-
-	if (offset < size_total) {
-		unsigned int copy = min(size, size_total - offset);
-
-		if (__copy_to_user(ubuf + offset, data, copy))
-			return -EFAULT;
-	}
-	return 0;
-}
-
-/*
- * Convert from kernel XSAVES compacted format to standard format and copy
- * to a user-space buffer. It supports partial copy but pos always starts from
- * zero. This is called from xstateregs_get() and there we check the CPU
- * has XSAVES.
- */
-int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned int offset_start, unsigned int size_total)
-{
-	unsigned int offset, size;
-	int ret, i;
-	struct xstate_header header;
-
-	/*
-	 * Currently copy_regset_to_user() starts from pos 0:
-	 */
-	if (unlikely(offset_start != 0))
-		return -EFAULT;
-
-	/*
-	 * The destination is a ptrace buffer; we put in only user xstates:
-	 */
-	memset(&header, 0, sizeof(header));
-	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= xfeatures_mask_user();
-
-	/*
-	 * Copy xregs_state->header:
-	 */
-	offset = offsetof(struct xregs_state, header);
-	size = sizeof(header);
-
-	ret = __copy_xstate_to_user(ubuf, &header, offset, size, size_total);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < XFEATURE_MAX; i++) {
-		/*
-		 * Copy only in-use xstates:
-		 */
-		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(xsave, i);
-
-			offset = xstate_offsets[i];
-			size = xstate_sizes[i];
-
-			/* The next component has to fit fully into the output buffer: */
-			if (offset + size > size_total)
-				break;
-
-			ret = __copy_xstate_to_user(ubuf, src, offset, size, size_total);
-			if (ret)
-				return ret;
-		}
-
-	}
-
-	if (xfeatures_mxcsr_quirk(header.xfeatures)) {
-		offset = offsetof(struct fxregs_state, mxcsr);
-		size = MXCSR_AND_FLAGS_SIZE;
-		__copy_xstate_to_user(ubuf, &xsave->i387.mxcsr, offset, size, size_total);
-	}
-
-	/*
-	 * Fill xsave->i387.sw_reserved value for ptrace frame:
-	 */
-	offset = offsetof(struct fxregs_state, sw_reserved);
-	size = sizeof(xstate_fx_sw_bytes);
-
-	ret = __copy_xstate_to_user(ubuf, xstate_fx_sw_bytes, offset, size, size_total);
-	if (ret)
-		return ret;
-
-	return 0;
+	fill_gap(&to, &last, size);
 }
 
 /*
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 44130588987f..81725806d61d 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -433,26 +433,12 @@ static unsigned long getreg(struct task_struct *task, unsigned long offset)
 
 static int genregs_get(struct task_struct *target,
 		       const struct user_regset *regset,
-		       unsigned int pos, unsigned int count,
-		       void *kbuf, void __user *ubuf)
+		       struct membuf to)
 {
-	if (kbuf) {
-		unsigned long *k = kbuf;
-		while (count >= sizeof(*k)) {
-			*k++ = getreg(target, pos);
-			count -= sizeof(*k);
-			pos += sizeof(*k);
-		}
-	} else {
-		unsigned long __user *u = ubuf;
-		while (count >= sizeof(*u)) {
-			if (__put_user(getreg(target, pos), u++))
-				return -EFAULT;
-			count -= sizeof(*u);
-			pos += sizeof(*u);
-		}
-	}
+	int reg;
 
+	for (reg = 0; to.left; reg++)
+		membuf_store(&to, getreg(target, reg * sizeof(unsigned long)));
 	return 0;
 }
 
@@ -716,16 +702,14 @@ static int ioperm_active(struct task_struct *target,
 
 static int ioperm_get(struct task_struct *target,
 		      const struct user_regset *regset,
-		      unsigned int pos, unsigned int count,
-		      void *kbuf, void __user *ubuf)
+		      struct membuf to)
 {
 	struct io_bitmap *iobm = target->thread.io_bitmap;
 
 	if (!iobm)
 		return -ENXIO;
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   iobm->bitmap, 0, IO_BITMAP_BYTES);
+	return membuf_write(&to, iobm->bitmap, IO_BITMAP_BYTES);
 }
 
 /*
@@ -1003,28 +987,15 @@ static int getreg32(struct task_struct *child, unsigned regno, u32 *val)
 
 static int genregs32_get(struct task_struct *target,
 			 const struct user_regset *regset,
-			 unsigned int pos, unsigned int count,
-			 void *kbuf, void __user *ubuf)
+			 struct membuf to)
 {
-	if (kbuf) {
-		compat_ulong_t *k = kbuf;
-		while (count >= sizeof(*k)) {
-			getreg32(target, pos, k++);
-			count -= sizeof(*k);
-			pos += sizeof(*k);
-		}
-	} else {
-		compat_ulong_t __user *u = ubuf;
-		while (count >= sizeof(*u)) {
-			compat_ulong_t word;
-			getreg32(target, pos, &word);
-			if (__put_user(word, u++))
-				return -EFAULT;
-			count -= sizeof(*u);
-			pos += sizeof(*u);
-		}
-	}
+	int reg;
 
+	for (reg = 0; to.left; reg++) {
+		u32 val;
+		getreg32(target, reg * 4, &val);
+		membuf_store(&to, val);
+	}
 	return 0;
 }
 
@@ -1234,25 +1205,25 @@ static struct user_regset x86_64_regsets[] __ro_after_init = {
 		.core_note_type = NT_PRSTATUS,
 		.n = sizeof(struct user_regs_struct) / sizeof(long),
 		.size = sizeof(long), .align = sizeof(long),
-		.get = genregs_get, .set = genregs_set
+		.get2 = genregs_get, .set = genregs_set
 	},
 	[REGSET_FP] = {
 		.core_note_type = NT_PRFPREG,
 		.n = sizeof(struct user_i387_struct) / sizeof(long),
 		.size = sizeof(long), .align = sizeof(long),
-		.active = regset_xregset_fpregs_active, .get = xfpregs_get, .set = xfpregs_set
+		.active = regset_xregset_fpregs_active, .get2 = xfpregs_get, .set = xfpregs_set
 	},
 	[REGSET_XSTATE] = {
 		.core_note_type = NT_X86_XSTATE,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = xstateregs_active, .get = xstateregs_get,
+		.active = xstateregs_active, .get2 = xstateregs_get,
 		.set = xstateregs_set
 	},
 	[REGSET_IOPERM64] = {
 		.core_note_type = NT_386_IOPERM,
 		.n = IO_BITMAP_LONGS,
 		.size = sizeof(long), .align = sizeof(long),
-		.active = ioperm_active, .get = ioperm_get
+		.active = ioperm_active, .get2 = ioperm_get
 	},
 };
 
@@ -1275,24 +1246,24 @@ static struct user_regset x86_32_regsets[] __ro_after_init = {
 		.core_note_type = NT_PRSTATUS,
 		.n = sizeof(struct user_regs_struct32) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
-		.get = genregs32_get, .set = genregs32_set
+		.get2 = genregs32_get, .set = genregs32_set
 	},
 	[REGSET_FP] = {
 		.core_note_type = NT_PRFPREG,
 		.n = sizeof(struct user_i387_ia32_struct) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
-		.active = regset_fpregs_active, .get = fpregs_get, .set = fpregs_set
+		.active = regset_fpregs_active, .get2 = fpregs_get, .set = fpregs_set
 	},
 	[REGSET_XFP] = {
 		.core_note_type = NT_PRXFPREG,
 		.n = sizeof(struct user32_fxsr_struct) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
-		.active = regset_xregset_fpregs_active, .get = xfpregs_get, .set = xfpregs_set
+		.active = regset_xregset_fpregs_active, .get2 = xfpregs_get, .set = xfpregs_set
 	},
 	[REGSET_XSTATE] = {
 		.core_note_type = NT_X86_XSTATE,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.active = xstateregs_active, .get = xstateregs_get,
+		.active = xstateregs_active, .get2 = xstateregs_get,
 		.set = xstateregs_set
 	},
 	[REGSET_TLS] = {
@@ -1301,13 +1272,13 @@ static struct user_regset x86_32_regsets[] __ro_after_init = {
 		.size = sizeof(struct user_desc),
 		.align = sizeof(struct user_desc),
 		.active = regset_tls_active,
-		.get = regset_tls_get, .set = regset_tls_set
+		.get2 = regset_tls_get, .set = regset_tls_set
 	},
 	[REGSET_IOPERM32] = {
 		.core_note_type = NT_386_IOPERM,
 		.n = IO_BITMAP_BYTES / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
-		.active = ioperm_active, .get = ioperm_get
+		.active = ioperm_active, .get2 = ioperm_get
 	},
 };
 
diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index 71d3fef1edc9..64a496a0687f 100644
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -256,36 +256,16 @@ int regset_tls_active(struct task_struct *target,
 }
 
 int regset_tls_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
 	const struct desc_struct *tls;
+	struct user_desc v;
+	int pos;
 
-	if (pos >= GDT_ENTRY_TLS_ENTRIES * sizeof(struct user_desc) ||
-	    (pos % sizeof(struct user_desc)) != 0 ||
-	    (count % sizeof(struct user_desc)) != 0)
-		return -EINVAL;
-
-	pos /= sizeof(struct user_desc);
-	count /= sizeof(struct user_desc);
-
-	tls = &target->thread.tls_array[pos];
-
-	if (kbuf) {
-		struct user_desc *info = kbuf;
-		while (count-- > 0)
-			fill_user_desc(info++, GDT_ENTRY_TLS_MIN + pos++,
-				       tls++);
-	} else {
-		struct user_desc __user *u_info = ubuf;
-		while (count-- > 0) {
-			struct user_desc info;
-			fill_user_desc(&info, GDT_ENTRY_TLS_MIN + pos++, tls++);
-			if (__copy_to_user(u_info++, &info, sizeof(info)))
-				return -EFAULT;
-		}
+	for (pos = 0, tls = target->thread.tls_array; to.left; pos++, tls++) {
+		fill_user_desc(&v, GDT_ENTRY_TLS_MIN + pos, tls);
+		membuf_write(&to, &v, sizeof(v));
 	}
-
 	return 0;
 }
 
diff --git a/arch/x86/kernel/tls.h b/arch/x86/kernel/tls.h
index 3a76e1d3535e..fc39447a0c1a 100644
--- a/arch/x86/kernel/tls.h
+++ b/arch/x86/kernel/tls.h
@@ -12,7 +12,7 @@
 #include <linux/regset.h>
 
 extern user_regset_active_fn regset_tls_active;
-extern user_regset_get_fn regset_tls_get;
+extern user_regset_get2_fn regset_tls_get;
 extern user_regset_set_fn regset_tls_set;
 
 #endif	/* _ARCH_X86_KERNEL_TLS_H */
diff --git a/arch/x86/math-emu/fpu_entry.c b/arch/x86/math-emu/fpu_entry.c
index a873da6b46d6..8679a9d6c47f 100644
--- a/arch/x86/math-emu/fpu_entry.c
+++ b/arch/x86/math-emu/fpu_entry.c
@@ -689,12 +689,10 @@ int fpregs_soft_set(struct task_struct *target,
 
 int fpregs_soft_get(struct task_struct *target,
 		    const struct user_regset *regset,
-		    unsigned int pos, unsigned int count,
-		    void *kbuf, void __user *ubuf)
+		    struct membuf to)
 {
 	struct swregs_state *s387 = &target->thread.fpu.state.soft;
 	const void *space = s387->st_space;
-	int ret;
 	int offset = (S387->ftop & 7) * 10, other = 80 - offset;
 
 	RE_ENTRANT_CHECK_OFF;
@@ -709,18 +707,11 @@ int fpregs_soft_get(struct task_struct *target,
 	S387->fos |= 0xffff0000;
 #endif /* PECULIAR_486 */
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, s387, 0,
-				  offsetof(struct swregs_state, st_space));
-
-	/* Copy all registers in stack order. */
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  space + offset, 0, other);
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  space, 0, offset);
+	membuf_write(&to, s387, offsetof(struct swregs_state, st_space));
+	membuf_write(&to, space + offset, other);
+	membuf_write(&to, space, offset);
 
 	RE_ENTRANT_CHECK_ON;
 
-	return ret;
+	return 0;
 }
-- 
2.11.0


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB520E485
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbgF2V0N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgF2Smr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:47 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6376DC033C17;
        Mon, 29 Jun 2020 11:26:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUA-002Dux-NW; Mon, 29 Jun 2020 18:26:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 21/41] s390: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:08 +0100
Message-Id: <20200629182628.529995-21-viro@ZenIV.linux.org.uk>
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

NB: compat NT_S390_LAST_BREAK might be better as compat_long_t
rather than long.  User-visible ABI, again...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/s390/kernel/ptrace.c | 199 ++++++++++++++--------------------------------
 1 file changed, 58 insertions(+), 141 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index ce60a459a143..421bfec0a9e9 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -890,28 +890,14 @@ asmlinkage void do_syscall_trace_exit(struct pt_regs *regs)
 
 static int s390_regs_get(struct task_struct *target,
 			 const struct user_regset *regset,
-			 unsigned int pos, unsigned int count,
-			 void *kbuf, void __user *ubuf)
+			 struct membuf to)
 {
+	unsigned pos;
 	if (target == current)
 		save_access_regs(target->thread.acrs);
 
-	if (kbuf) {
-		unsigned long *k = kbuf;
-		while (count > 0) {
-			*k++ = __peek_user(target, pos);
-			count -= sizeof(*k);
-			pos += sizeof(*k);
-		}
-	} else {
-		unsigned long __user *u = ubuf;
-		while (count > 0) {
-			if (__put_user(__peek_user(target, pos), u++))
-				return -EFAULT;
-			count -= sizeof(*u);
-			pos += sizeof(*u);
-		}
-	}
+	for (pos = 0; pos < sizeof(s390_regs); pos += sizeof(long))
+		membuf_store(&to, __peek_user(target, pos));
 	return 0;
 }
 
@@ -952,8 +938,8 @@ static int s390_regs_set(struct task_struct *target,
 }
 
 static int s390_fpregs_get(struct task_struct *target,
-			   const struct user_regset *regset, unsigned int pos,
-			   unsigned int count, void *kbuf, void __user *ubuf)
+			   const struct user_regset *regset,
+			   struct membuf to)
 {
 	_s390_fp_regs fp_regs;
 
@@ -963,8 +949,7 @@ static int s390_fpregs_get(struct task_struct *target,
 	fp_regs.fpc = target->thread.fpu.fpc;
 	fpregs_store(&fp_regs, &target->thread.fpu);
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &fp_regs, 0, -1);
+	return membuf_write(&to, &fp_regs, sizeof(fp_regs));
 }
 
 static int s390_fpregs_set(struct task_struct *target,
@@ -1011,20 +996,9 @@ static int s390_fpregs_set(struct task_struct *target,
 
 static int s390_last_break_get(struct task_struct *target,
 			       const struct user_regset *regset,
-			       unsigned int pos, unsigned int count,
-			       void *kbuf, void __user *ubuf)
+			       struct membuf to)
 {
-	if (count > 0) {
-		if (kbuf) {
-			unsigned long *k = kbuf;
-			*k = target->thread.last_break;
-		} else {
-			unsigned long  __user *u = ubuf;
-			if (__put_user(target->thread.last_break, u))
-				return -EFAULT;
-		}
-	}
-	return 0;
+	return membuf_store(&to, target->thread.last_break);
 }
 
 static int s390_last_break_set(struct task_struct *target,
@@ -1037,16 +1011,13 @@ static int s390_last_break_set(struct task_struct *target,
 
 static int s390_tdb_get(struct task_struct *target,
 			const struct user_regset *regset,
-			unsigned int pos, unsigned int count,
-			void *kbuf, void __user *ubuf)
+			struct membuf to)
 {
 	struct pt_regs *regs = task_pt_regs(target);
-	unsigned char *data;
 
 	if (!(regs->int_code & 0x200))
 		return -ENODATA;
-	data = target->thread.trap_tdb;
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, data, 0, 256);
+	return membuf_write(&to, target->thread.trap_tdb, 256);
 }
 
 static int s390_tdb_set(struct task_struct *target,
@@ -1059,8 +1030,7 @@ static int s390_tdb_set(struct task_struct *target,
 
 static int s390_vxrs_low_get(struct task_struct *target,
 			     const struct user_regset *regset,
-			     unsigned int pos, unsigned int count,
-			     void *kbuf, void __user *ubuf)
+			     struct membuf to)
 {
 	__u64 vxrs[__NUM_VXRS_LOW];
 	int i;
@@ -1071,7 +1041,7 @@ static int s390_vxrs_low_get(struct task_struct *target,
 		save_fpu_regs();
 	for (i = 0; i < __NUM_VXRS_LOW; i++)
 		vxrs[i] = *((__u64 *)(target->thread.fpu.vxrs + i) + 1);
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, vxrs, 0, -1);
+	return membuf_write(&to, vxrs, sizeof(vxrs));
 }
 
 static int s390_vxrs_low_set(struct task_struct *target,
@@ -1100,18 +1070,14 @@ static int s390_vxrs_low_set(struct task_struct *target,
 
 static int s390_vxrs_high_get(struct task_struct *target,
 			      const struct user_regset *regset,
-			      unsigned int pos, unsigned int count,
-			      void *kbuf, void __user *ubuf)
+			      struct membuf to)
 {
-	__vector128 vxrs[__NUM_VXRS_HIGH];
-
 	if (!MACHINE_HAS_VX)
 		return -ENODEV;
 	if (target == current)
 		save_fpu_regs();
-	memcpy(vxrs, target->thread.fpu.vxrs + __NUM_VXRS_LOW, sizeof(vxrs));
-
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, vxrs, 0, -1);
+	return membuf_write(&to, target->thread.fpu.vxrs + __NUM_VXRS_LOW,
+			    __NUM_VXRS_HIGH * sizeof(__vector128));
 }
 
 static int s390_vxrs_high_set(struct task_struct *target,
@@ -1133,12 +1099,9 @@ static int s390_vxrs_high_set(struct task_struct *target,
 
 static int s390_system_call_get(struct task_struct *target,
 				const struct user_regset *regset,
-				unsigned int pos, unsigned int count,
-				void *kbuf, void __user *ubuf)
+				struct membuf to)
 {
-	unsigned int *data = &target->thread.system_call;
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   data, 0, sizeof(unsigned int));
+	return membuf_store(&to, target->thread.system_call);
 }
 
 static int s390_system_call_set(struct task_struct *target,
@@ -1153,8 +1116,7 @@ static int s390_system_call_set(struct task_struct *target,
 
 static int s390_gs_cb_get(struct task_struct *target,
 			  const struct user_regset *regset,
-			  unsigned int pos, unsigned int count,
-			  void *kbuf, void __user *ubuf)
+			  struct membuf to)
 {
 	struct gs_cb *data = target->thread.gs_cb;
 
@@ -1164,8 +1126,7 @@ static int s390_gs_cb_get(struct task_struct *target,
 		return -ENODATA;
 	if (target == current)
 		save_gs_cb(data);
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   data, 0, sizeof(struct gs_cb));
+	return membuf_write(&to, data, sizeof(struct gs_cb));
 }
 
 static int s390_gs_cb_set(struct task_struct *target,
@@ -1209,8 +1170,7 @@ static int s390_gs_cb_set(struct task_struct *target,
 
 static int s390_gs_bc_get(struct task_struct *target,
 			  const struct user_regset *regset,
-			  unsigned int pos, unsigned int count,
-			  void *kbuf, void __user *ubuf)
+			  struct membuf to)
 {
 	struct gs_cb *data = target->thread.gs_bc_cb;
 
@@ -1218,8 +1178,7 @@ static int s390_gs_bc_get(struct task_struct *target,
 		return -ENODEV;
 	if (!data)
 		return -ENODATA;
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   data, 0, sizeof(struct gs_cb));
+	return membuf_write(&to, data, sizeof(struct gs_cb));
 }
 
 static int s390_gs_bc_set(struct task_struct *target,
@@ -1270,8 +1229,7 @@ static bool is_ri_cb_valid(struct runtime_instr_cb *cb)
 
 static int s390_runtime_instr_get(struct task_struct *target,
 				const struct user_regset *regset,
-				unsigned int pos, unsigned int count,
-				void *kbuf, void __user *ubuf)
+				struct membuf to)
 {
 	struct runtime_instr_cb *data = target->thread.ri_cb;
 
@@ -1280,8 +1238,7 @@ static int s390_runtime_instr_get(struct task_struct *target,
 	if (!data)
 		return -ENODATA;
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   data, 0, sizeof(struct runtime_instr_cb));
+	return membuf_write(&to, data, sizeof(struct runtime_instr_cb));
 }
 
 static int s390_runtime_instr_set(struct task_struct *target,
@@ -1337,7 +1294,7 @@ static const struct user_regset s390_regsets[] = {
 		.n = sizeof(s390_regs) / sizeof(long),
 		.size = sizeof(long),
 		.align = sizeof(long),
-		.get = s390_regs_get,
+		.get2 = s390_regs_get,
 		.set = s390_regs_set,
 	},
 	{
@@ -1345,7 +1302,7 @@ static const struct user_regset s390_regsets[] = {
 		.n = sizeof(s390_fp_regs) / sizeof(long),
 		.size = sizeof(long),
 		.align = sizeof(long),
-		.get = s390_fpregs_get,
+		.get2 = s390_fpregs_get,
 		.set = s390_fpregs_set,
 	},
 	{
@@ -1353,7 +1310,7 @@ static const struct user_regset s390_regsets[] = {
 		.n = 1,
 		.size = sizeof(unsigned int),
 		.align = sizeof(unsigned int),
-		.get = s390_system_call_get,
+		.get2 = s390_system_call_get,
 		.set = s390_system_call_set,
 	},
 	{
@@ -1361,7 +1318,7 @@ static const struct user_regset s390_regsets[] = {
 		.n = 1,
 		.size = sizeof(long),
 		.align = sizeof(long),
-		.get = s390_last_break_get,
+		.get2 = s390_last_break_get,
 		.set = s390_last_break_set,
 	},
 	{
@@ -1369,7 +1326,7 @@ static const struct user_regset s390_regsets[] = {
 		.n = 1,
 		.size = 256,
 		.align = 1,
-		.get = s390_tdb_get,
+		.get2 = s390_tdb_get,
 		.set = s390_tdb_set,
 	},
 	{
@@ -1377,7 +1334,7 @@ static const struct user_regset s390_regsets[] = {
 		.n = __NUM_VXRS_LOW,
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
-		.get = s390_vxrs_low_get,
+		.get2 = s390_vxrs_low_get,
 		.set = s390_vxrs_low_set,
 	},
 	{
@@ -1385,7 +1342,7 @@ static const struct user_regset s390_regsets[] = {
 		.n = __NUM_VXRS_HIGH,
 		.size = sizeof(__vector128),
 		.align = sizeof(__vector128),
-		.get = s390_vxrs_high_get,
+		.get2 = s390_vxrs_high_get,
 		.set = s390_vxrs_high_set,
 	},
 	{
@@ -1393,7 +1350,7 @@ static const struct user_regset s390_regsets[] = {
 		.n = sizeof(struct gs_cb) / sizeof(__u64),
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
-		.get = s390_gs_cb_get,
+		.get2 = s390_gs_cb_get,
 		.set = s390_gs_cb_set,
 	},
 	{
@@ -1401,7 +1358,7 @@ static const struct user_regset s390_regsets[] = {
 		.n = sizeof(struct gs_cb) / sizeof(__u64),
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
-		.get = s390_gs_bc_get,
+		.get2 = s390_gs_bc_get,
 		.set = s390_gs_bc_set,
 	},
 	{
@@ -1409,7 +1366,7 @@ static const struct user_regset s390_regsets[] = {
 		.n = sizeof(struct runtime_instr_cb) / sizeof(__u64),
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
-		.get = s390_runtime_instr_get,
+		.get2 = s390_runtime_instr_get,
 		.set = s390_runtime_instr_set,
 	},
 };
@@ -1424,28 +1381,15 @@ static const struct user_regset_view user_s390_view = {
 #ifdef CONFIG_COMPAT
 static int s390_compat_regs_get(struct task_struct *target,
 				const struct user_regset *regset,
-				unsigned int pos, unsigned int count,
-				void *kbuf, void __user *ubuf)
+				struct membuf to)
 {
+	unsigned n;
+
 	if (target == current)
 		save_access_regs(target->thread.acrs);
 
-	if (kbuf) {
-		compat_ulong_t *k = kbuf;
-		while (count > 0) {
-			*k++ = __peek_user_compat(target, pos);
-			count -= sizeof(*k);
-			pos += sizeof(*k);
-		}
-	} else {
-		compat_ulong_t __user *u = ubuf;
-		while (count > 0) {
-			if (__put_user(__peek_user_compat(target, pos), u++))
-				return -EFAULT;
-			count -= sizeof(*u);
-			pos += sizeof(*u);
-		}
-	}
+	for (n = 0; n < sizeof(s390_compat_regs); n += sizeof(compat_ulong_t))
+		membuf_store(&to, __peek_user_compat(target, n));
 	return 0;
 }
 
@@ -1487,29 +1431,14 @@ static int s390_compat_regs_set(struct task_struct *target,
 
 static int s390_compat_regs_high_get(struct task_struct *target,
 				     const struct user_regset *regset,
-				     unsigned int pos, unsigned int count,
-				     void *kbuf, void __user *ubuf)
+				     struct membuf to)
 {
 	compat_ulong_t *gprs_high;
+	int i;
 
-	gprs_high = (compat_ulong_t *)
-		&task_pt_regs(target)->gprs[pos / sizeof(compat_ulong_t)];
-	if (kbuf) {
-		compat_ulong_t *k = kbuf;
-		while (count > 0) {
-			*k++ = *gprs_high;
-			gprs_high += 2;
-			count -= sizeof(*k);
-		}
-	} else {
-		compat_ulong_t __user *u = ubuf;
-		while (count > 0) {
-			if (__put_user(*gprs_high, u++))
-				return -EFAULT;
-			gprs_high += 2;
-			count -= sizeof(*u);
-		}
-	}
+	gprs_high = (compat_ulong_t *)task_pt_regs(target)->gprs;
+	for (i = 0; i < NUM_GPRS; i++, gprs_high += 2)
+		membuf_store(&to, *gprs_high);
 	return 0;
 }
 
@@ -1548,23 +1477,11 @@ static int s390_compat_regs_high_set(struct task_struct *target,
 
 static int s390_compat_last_break_get(struct task_struct *target,
 				      const struct user_regset *regset,
-				      unsigned int pos, unsigned int count,
-				      void *kbuf, void __user *ubuf)
+				      struct membuf to)
 {
-	compat_ulong_t last_break;
+	compat_ulong_t last_break = target->thread.last_break;
 
-	if (count > 0) {
-		last_break = target->thread.last_break;
-		if (kbuf) {
-			unsigned long *k = kbuf;
-			*k = last_break;
-		} else {
-			unsigned long  __user *u = ubuf;
-			if (__put_user(last_break, u))
-				return -EFAULT;
-		}
-	}
-	return 0;
+	return membuf_store(&to, (unsigned long)last_break);
 }
 
 static int s390_compat_last_break_set(struct task_struct *target,
@@ -1581,7 +1498,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.n = sizeof(s390_compat_regs) / sizeof(compat_long_t),
 		.size = sizeof(compat_long_t),
 		.align = sizeof(compat_long_t),
-		.get = s390_compat_regs_get,
+		.get2 = s390_compat_regs_get,
 		.set = s390_compat_regs_set,
 	},
 	{
@@ -1589,7 +1506,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.n = sizeof(s390_fp_regs) / sizeof(compat_long_t),
 		.size = sizeof(compat_long_t),
 		.align = sizeof(compat_long_t),
-		.get = s390_fpregs_get,
+		.get2 = s390_fpregs_get,
 		.set = s390_fpregs_set,
 	},
 	{
@@ -1597,7 +1514,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.n = 1,
 		.size = sizeof(compat_uint_t),
 		.align = sizeof(compat_uint_t),
-		.get = s390_system_call_get,
+		.get2 = s390_system_call_get,
 		.set = s390_system_call_set,
 	},
 	{
@@ -1605,7 +1522,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.n = 1,
 		.size = sizeof(long),
 		.align = sizeof(long),
-		.get = s390_compat_last_break_get,
+		.get2 = s390_compat_last_break_get,
 		.set = s390_compat_last_break_set,
 	},
 	{
@@ -1613,7 +1530,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.n = 1,
 		.size = 256,
 		.align = 1,
-		.get = s390_tdb_get,
+		.get2 = s390_tdb_get,
 		.set = s390_tdb_set,
 	},
 	{
@@ -1621,7 +1538,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.n = __NUM_VXRS_LOW,
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
-		.get = s390_vxrs_low_get,
+		.get2 = s390_vxrs_low_get,
 		.set = s390_vxrs_low_set,
 	},
 	{
@@ -1629,7 +1546,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.n = __NUM_VXRS_HIGH,
 		.size = sizeof(__vector128),
 		.align = sizeof(__vector128),
-		.get = s390_vxrs_high_get,
+		.get2 = s390_vxrs_high_get,
 		.set = s390_vxrs_high_set,
 	},
 	{
@@ -1637,7 +1554,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.n = sizeof(s390_compat_regs_high) / sizeof(compat_long_t),
 		.size = sizeof(compat_long_t),
 		.align = sizeof(compat_long_t),
-		.get = s390_compat_regs_high_get,
+		.get2 = s390_compat_regs_high_get,
 		.set = s390_compat_regs_high_set,
 	},
 	{
@@ -1645,7 +1562,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.n = sizeof(struct gs_cb) / sizeof(__u64),
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
-		.get = s390_gs_cb_get,
+		.get2 = s390_gs_cb_get,
 		.set = s390_gs_cb_set,
 	},
 	{
@@ -1653,7 +1570,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.n = sizeof(struct gs_cb) / sizeof(__u64),
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
-		.get = s390_gs_bc_get,
+		.get2 = s390_gs_bc_get,
 		.set = s390_gs_bc_set,
 	},
 	{
@@ -1661,7 +1578,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.n = sizeof(struct runtime_instr_cb) / sizeof(__u64),
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
-		.get = s390_runtime_instr_get,
+		.get2 = s390_runtime_instr_get,
 		.set = s390_runtime_instr_set,
 	},
 };
-- 
2.11.0


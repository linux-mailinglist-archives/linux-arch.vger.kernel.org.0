Return-Path: <linux-arch+bounces-15423-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB44CBF2E1
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 18:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 004D6301B2FE
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111203446D5;
	Mon, 15 Dec 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BEI/XNR7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UDbdiEuk"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAF3446BD;
	Mon, 15 Dec 2025 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817541; cv=none; b=WAWZd6hB+2w3kutEHgPSvrUCMEUQjkHCnEHklxz+hwWU4l1R2AgCsBWHyZJlT9XMG/HQj5o6fvIzUaQsJjDTPgUK2CcacQbOCmgDvCvec+lFHeo+K9f+9nfHS5ZoqHI5d8qj+CxzsF7Y2gGnPEj8C40vqSM+/2F/A+2uT0F4Hus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817541; c=relaxed/simple;
	bh=0FwuQjknkbnnvgRDT9FQddzVKF44/E9JeeTt7njSjQc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=LvKZVJ8U9JRu6reM0QJoOjwYJPue9JnfHbuKImeVnInC7ymV4t2f5UeZHle2ryQ+N7hEEJ20L1Rb+Td5Sf6tIns4bJJUeDyZSwflXDVTTL8ch9Thwn7sT73FcpGPBr87hQdCI+udcoruzJVqEnc90qQpwTXpHlCnj3c4osVlN3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BEI/XNR7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UDbdiEuk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251215155708.929634896@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765817537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7wCihJrg1rLd49suBr+CSO8hbNtSaDqzdB363NzzLtU=;
	b=BEI/XNR7V0/A0qi4wLXd/E07WJeFsPx7l0ErGVC6l2Yr0nd10nHi446ov/ae1ERXuHVi7r
	V3nRkDinzyuQRKj8ixHyxiyTO52VRiMrLJ6WjofbbAt+DV6ARh3pPvAEN7RrP6R59eM8tJ
	EE6gsLuCZ0Op7Sfe0STC2ox1t1xiKncaVEE6dsPXzRrbKVbWPeeobLwRXdIvYnB5zYHVK3
	WIgs3n8GNwbMRI3+zzKu3JthyvJpjOfudlOhVjalXSyd7FqXGuDHrDnD2L1cKaNk7BlCp8
	rUkz3wumexCmeurDm8cbVIKIg6lcFnMTCcPSzerCFOkOL131W/V/XPNF60ZXXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765817537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7wCihJrg1rLd49suBr+CSO8hbNtSaDqzdB363NzzLtU=;
	b=UDbdiEukttIsBVBbBTKQncN/q7DJX38TeKGio6sfAl9tjBGpyPYdptbXztu6EBDNlQoKK6
	utvfWmButoIFf8CQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ron Geva <rongevarg@gmail.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch V6 05/11] rseq: Implement sys_rseq_slice_yield()
References: <20251215155615.870031952@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 17:52:15 +0100 (CET)

Provide a new syscall which has the only purpose to yield the CPU after the
kernel granted a time slice extension.

sched_yield() is not suitable for that because it unconditionally
schedules, but the end of the time slice extension is not required to
schedule when the task was already preempted. This also allows to have a
strict check for termination to catch user space invoking random syscalls
including sched_yield() from a time slice extension region.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
---
Note: This still uses 470 which conflicts with -next, but this is scheduled
      for post -rc1 and basing it on -next makes it more complicated for
      now. Will be changed in the final submission.
---
V5: Rework to adjust to support for arbitrary syscall changes
    Use n32/n64/o32 for MIPS - Arnd
V2: Use the proper name in sys_ni.c and add comment - Prateek
---
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 +
 arch/arm/tools/syscall.tbl                  |    1 +
 arch/arm64/tools/syscall_32.tbl             |    1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 +
 arch/s390/kernel/syscalls/syscall.tbl       |    1 +
 arch/sh/kernel/syscalls/syscall.tbl         |    1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 +
 include/linux/rseq_types.h                  |    2 ++
 include/linux/syscalls.h                    |    1 +
 include/uapi/asm-generic/unistd.h           |    5 ++++-
 kernel/rseq.c                               |   21 +++++++++++++++++++++
 kernel/sys_ni.c                             |    1 +
 scripts/syscall.tbl                         |    1 +
 22 files changed, 46 insertions(+), 1 deletion(-)

--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -510,3 +510,4 @@
 578	common	file_getattr			sys_file_getattr
 579	common	file_setattr			sys_file_setattr
 580	common	listns				sys_listns
+581	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -485,3 +485,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -482,3 +482,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -470,3 +470,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -476,3 +476,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -409,3 +409,4 @@
 468	n32	file_getattr			sys_file_getattr
 469	n32	file_setattr			sys_file_setattr
 470	n32	listns				sys_listns
+471	n32	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -385,3 +385,4 @@
 468	n64	file_getattr			sys_file_getattr
 469	n64	file_setattr			sys_file_setattr
 470	n64	listns				sys_listns
+471	n64	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -458,3 +458,4 @@
 468	o32	file_getattr			sys_file_getattr
 469	o32	file_setattr			sys_file_setattr
 470	o32	listns				sys_listns
+471	o32	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -469,3 +469,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -561,3 +561,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	nospu	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -397,3 +397,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -474,3 +474,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -516,3 +516,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -476,3 +476,4 @@
 468	i386	file_getattr		sys_file_getattr
 469	i386	file_setattr		sys_file_setattr
 470	i386	listns			sys_listns
+471	i386	rseq_slice_yield	sys_rseq_slice_yield
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -395,6 +395,7 @@
 468	common	file_getattr		sys_file_getattr
 469	common	file_setattr		sys_file_setattr
 470	common	listns			sys_listns
+471	common	rseq_slice_yield	sys_rseq_slice_yield
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -89,9 +89,11 @@ union rseq_slice_state {
 /**
  * struct rseq_slice - Status information for rseq time slice extension
  * @state:	Time slice extension state
+ * @yielded:	Indicator for rseq_slice_yield()
  */
 struct rseq_slice {
 	union rseq_slice_state	state;
+	u8			yielded;
 };
 
 /**
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -961,6 +961,7 @@ asmlinkage long sys_statx(int dfd, const
 			  unsigned mask, struct statx __user *buffer);
 asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
 			 int flags, uint32_t sig);
+asmlinkage long sys_rseq_slice_yield(void);
 asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
 asmlinkage long sys_open_tree_attr(int dfd, const char __user *path,
 				   unsigned flags,
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -860,8 +860,11 @@
 #define __NR_listns 470
 __SYSCALL(__NR_listns, sys_listns)
 
+#define __NR_rseq_slice_yield 471
+__SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
+
 #undef __NR_syscalls
-#define __NR_syscalls 471
+#define __NR_syscalls 472
 
 /*
  * 32 bit systems traditionally used different
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -553,6 +553,27 @@ int rseq_slice_extension_prctl(unsigned
 	return -EFAULT;
 }
 
+/**
+ * sys_rseq_slice_yield - yield the current processor side effect free if a
+ *			  task granted with a time slice extension is done with
+ *			  the critical work before being forced out.
+ *
+ * Return: 1 if the task successfully yielded the CPU within the granted slice.
+ *         0 if the slice extension was either never granted or was revoked by
+ *	     going over the granted extension, using a syscall other than this one
+ *	     or being scheduled out earlier due to a subsequent interrupt.
+ *
+ * The syscall does not schedule because the syscall entry work immediately
+ * relinquishes the CPU and schedules if required.
+ */
+SYSCALL_DEFINE0(rseq_slice_yield)
+{
+	int yielded = !!current->rseq.slice.yielded;
+
+	current->rseq.slice.yielded = 0;
+	return yielded;
+}
+
 static int __init rseq_slice_cmdline(char *str)
 {
 	bool on;
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -390,6 +390,7 @@ COND_SYSCALL(setuid16);
 
 /* restartable sequence */
 COND_SYSCALL(rseq);
+COND_SYSCALL(rseq_slice_yield);
 
 COND_SYSCALL(uretprobe);
 COND_SYSCALL(uprobe);
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -411,3 +411,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield



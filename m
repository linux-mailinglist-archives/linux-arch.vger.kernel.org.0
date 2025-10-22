Return-Path: <linux-arch+bounces-14263-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 325E0BFC08F
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 15:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68D21897D6C
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 13:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E9C34C9A6;
	Wed, 22 Oct 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KoqhV8f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ex4Uk0bP"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417634B69E;
	Wed, 22 Oct 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137860; cv=none; b=tx6lvWaEsMYYPVNm94lUFTulnrTR9fQHe0vU1oL8oZbaz3zxl5ML5+J0l6VbrzdZsGsYXjceF6v5Cx/Qs736+cM821IQ/+ijYpUkGwUxpDxwgBDNNpiWC/JC57mlM+6tTWVpsNbu44zV+qvu2yU7UsnDpR1RzDIjkG8MCaLZxAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137860; c=relaxed/simple;
	bh=rHCqZwcbQsrhjWo0YTjdDo7y3XflTTly0D8YdvljEv8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=G1Asxdtv9cdGfwy+aGhxM1EIM6E1pvUJBoj64a8XYbglixmvoDYUdTIO4NUOjBIi8UaAEQjrY8dY1rE+0h0R7/nrkK7yU/EQx63wauKJD+RK77gDGJEBT6Tdo7/N0ldOEDtnVqa1duLNFw8BAS8gB5DTw0TbEWPb0jBuEAfmUmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0KoqhV8f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ex4Uk0bP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121427.279937503@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=OpdbS6Zuaut97AzYIjOkI0xEPTqIRMFDT+XNhENsnBU=;
	b=0KoqhV8fj6Ctl8IIY/cdQ6tpIdExA5kgCHPtJ0W4Mj5YWO46MRkkiI9j/hQpZGxik1oxhx
	8B87f8LHGr5gsK63E0CmLMg/7PtbzBaVBmX/HuY218EhG8sjj0+vmjRTsRnwEt2Kq91KVV
	fD+6dRgDtpuIuiADQfkgZFykHuAc+OQOJNOVUY90qWewcH5VsszB+RqjOalLTTXr8sdSbQ
	b8ZA6l8dp8yxous4LSL7HKdmaBoKXfX2Gvgc6jdP4m0JKD1PJj7y9L6a9z4LEHaGjbiVdV
	9A2ofty6kmLg2rFPCs4hsKIqwNP7JCri+0wCS8cDsxxdyrRmCtoA8RmRvOpJ/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=OpdbS6Zuaut97AzYIjOkI0xEPTqIRMFDT+XNhENsnBU=;
	b=Ex4Uk0bPzz8zKzrMhpAiyedlTcHPqq0fqWGyWhF7mFXRyA7PHJz5ARJJ3aTkae6TttEuYC
	IsBQak4ofZJZ/YDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org,
 Peter Zilstra <peterz@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 06/12] rseq: Implement sys_rseq_slice_yield()
References: <20251022110646.839870156@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:57:36 +0200 (CEST)

Provide a new syscall which has the only purpose to yield the CPU after the
kernel granted a time slice extension.

sched_yield() is not suitable for that because it unconditionally
schedules, but the end of the time slice extension is not required to
schedule when the task was already preempted. This also allows to have a
strict check for termination to catch user space invoking random syscalls
including sched_yield() from a time slice extension region.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
---
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
 include/linux/syscalls.h                    |    1 +
 include/uapi/asm-generic/unistd.h           |    5 ++++-
 kernel/rseq.c                               |   21 +++++++++++++++++++++
 kernel/sys_ni.c                             |    1 +
 scripts/syscall.tbl                         |    1 +
 21 files changed, 44 insertions(+), 1 deletion(-)

--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -509,3 +509,4 @@
 577	common	open_tree_attr			sys_open_tree_attr
 578	common	file_getattr			sys_file_getattr
 579	common	file_setattr			sys_file_setattr
+580	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -484,3 +484,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -481,3 +481,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -469,3 +469,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -475,3 +475,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -408,3 +408,4 @@
 467	n32	open_tree_attr			sys_open_tree_attr
 468	n32	file_getattr			sys_file_getattr
 469	n32	file_setattr			sys_file_setattr
+470	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -384,3 +384,4 @@
 467	n64	open_tree_attr			sys_open_tree_attr
 468	n64	file_getattr			sys_file_getattr
 469	n64	file_setattr			sys_file_setattr
+470	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -457,3 +457,4 @@
 467	o32	open_tree_attr			sys_open_tree_attr
 468	o32	file_getattr			sys_file_getattr
 469	o32	file_setattr			sys_file_setattr
+470	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -468,3 +468,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -560,3 +560,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	nospu	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -472,3 +472,4 @@
 467  common	open_tree_attr		sys_open_tree_attr		sys_open_tree_attr
 468  common	file_getattr		sys_file_getattr		sys_file_getattr
 469  common	file_setattr		sys_file_setattr		sys_file_setattr
+470  common	rseq_slice_yield	sys_rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -473,3 +473,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -515,3 +515,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -475,3 +475,4 @@
 467	i386	open_tree_attr		sys_open_tree_attr
 468	i386	file_getattr		sys_file_getattr
 469	i386	file_setattr		sys_file_setattr
+470	i386	rseq_slice_yield	sys_rseq_slice_yield
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -394,6 +394,7 @@
 467	common	open_tree_attr		sys_open_tree_attr
 468	common	file_getattr		sys_file_getattr
 469	common	file_setattr		sys_file_setattr
+470	common	rseq_slice_yield	sys_rseq_slice_yield
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	rseq_slice_yield		sys_rseq_slice_yield
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -957,6 +957,7 @@ asmlinkage long sys_statx(int dfd, const
 			  unsigned mask, struct statx __user *buffer);
 asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
 			 int flags, uint32_t sig);
+asmlinkage long sys_rseq_slice_yield(void);
 asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
 asmlinkage long sys_open_tree_attr(int dfd, const char __user *path,
 				   unsigned flags,
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -858,8 +858,11 @@
 #define __NR_file_setattr 469
 __SYSCALL(__NR_file_setattr, sys_file_setattr)
 
+#define __NR_rseq_slice_yield 470
+__SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
+
 #undef __NR_syscalls
-#define __NR_syscalls 470
+#define __NR_syscalls 471
 
 /*
  * 32 bit systems traditionally used different
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -552,6 +552,27 @@ int rseq_slice_extension_prctl(unsigned
 	return -EFAULT;
 }
 
+/**
+ * sys_rseq_slice_yield - yield the current processor if a task granted
+ *			  with a time slice extension is done with the
+ *			  critical work before being forced out.
+ *
+ * On entry from user space, syscall_entry_work() ensures that NEED_RESCHED is
+ * set if the task was granted a slice extension before arriving here.
+ *
+ * Return: 1 if the task successfully yielded the CPU within the granted slice.
+ *         0 if the slice extension was either never granted or was revoked by
+ *	     going over the granted extension or being scheduled out earlier
+ */
+SYSCALL_DEFINE0(rseq_slice_yield)
+{
+	if (need_resched()) {
+		schedule();
+		return 1;
+	}
+	return 0;
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
@@ -410,3 +410,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	rseq_slice_yield		sys_rseq_slice_yield



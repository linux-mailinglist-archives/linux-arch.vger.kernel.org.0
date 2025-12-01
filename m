Return-Path: <linux-arch+bounces-15115-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E96AFC95F36
	for <lists+linux-arch@lfdr.de>; Mon, 01 Dec 2025 08:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A51364E1B3A
	for <lists+linux-arch@lfdr.de>; Mon,  1 Dec 2025 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01AA28BA95;
	Mon,  1 Dec 2025 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gOijDErV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jJlxYkrl"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D8329A9FA;
	Mon,  1 Dec 2025 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764572775; cv=none; b=H3iHS21rtVdr1mlrFekk+6rHCo3efpUPGzFdi/F6N2S7LcSIdcfTAY9m1jI4OxK0Anan/iYnCoq3bYtXvvw/l7Zyfk0GQnD5a/fJSzZm7Cf7q85+Z3NVRaxLnTYaRa4WtVrcr0rtquvzf3moY3W7/auRfypNQPbxh+TaRpKpHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764572775; c=relaxed/simple;
	bh=8qxHtJRRRzk3uVpjshOhEnnkXYXpm6Xl9z3dNpxYA+4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=WwhnCh3TAaF9jCYyjkoeOYPEIQZC18DBuGlU2OHrr36ooVoZrADyFBOkMg6+04Jtvg7sm0E3VOBWOiRIv90sDF2p2aSdXHIil8vrsF/jcCGbho2nc8t2CPjyyKNMBi5tIAymsvWT9PpifUMwIvn2oJ9LJaHCEZw91JsRYr169js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gOijDErV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jJlxYkrl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251128230240.966757043@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764572772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/KE7e4TTCsqHLZVVJrE3eSPewTRbYHAXmhqBYlGbKis=;
	b=gOijDErVln8e7xQSnkk0W8sIzTSe6BoHeYTGvHKe9igrhqz3XAbV05PdnsVg6Rrb33kwu3
	QOum8LET7gFZi+9zdwb4wOBXGyWhX+M8iZIBmqNv7xUbfjeI/jdn8z4vh3Trj2054QTLgk
	uso6HWeOlIOhO+tD6LYgIxBu0EufVKEoStGBcyWP8Se9UmuemcPAP7UuCHVl2vA+/TJWrl
	uLZcmnReuid+Or6VhmSOYxeXreqefrNxu8Dfi3oij47IQWfLps7QM+h5QHQHhBXwnCY5Zt
	Wt6OME2LrIovbvsGuGT3rdtlVzjp3pSVeV1DxVIR8+4XT/EHxlYSwJmSugPpvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764572772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/KE7e4TTCsqHLZVVJrE3eSPewTRbYHAXmhqBYlGbKis=;
	b=jJlxYkrlrtZQtvxknRtvqYjQ2EtC4KGfY7/LeFoGkN0oJTW7mHFLNjcl+AxXchn/00oCwZ
	M/V/kevapZm5aKBA==
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
Subject: [patch V5 05/11] rseq: Implement sys_rseq_slice_yield()
References: <20251128225931.959481199@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  1 Dec 2025 08:06:06 +0100 (CET)

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
+470	n32	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -384,3 +384,4 @@
 467	n64	open_tree_attr			sys_open_tree_attr
 468	n64	file_getattr			sys_file_getattr
 469	n64	file_setattr			sys_file_setattr
+470	n64	rseq_slice_yield		sys_rseq_slice_yield
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -457,3 +457,4 @@
 467	o32	open_tree_attr			sys_open_tree_attr
 468	o32	file_getattr			sys_file_getattr
 469	o32	file_setattr			sys_file_setattr
+470	o32	rseq_slice_yield		sys_rseq_slice_yield
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
@@ -410,3 +410,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	rseq_slice_yield		sys_rseq_slice_yield



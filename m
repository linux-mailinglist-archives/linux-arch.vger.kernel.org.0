Return-Path: <linux-arch+bounces-14395-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E2DC1AB39
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 14:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EA51A2743A
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 13:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7239A2E5D17;
	Wed, 29 Oct 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T7TVEZ3d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XmwzxNk7"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1542D592F;
	Wed, 29 Oct 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744136; cv=none; b=G0zpDHcVg+9p99GG3xXmEOU+eLwK2Ivv4Zvhxp1yT3Jt9VBtWsv4i58YM776bS1KE/sKJ3aOUsRE4tRqUJfwEAC+aDYNzhhM3/rsYr44vayD7JSc1OaMoHfunaRUa/x3q1Jj9SDt3lrlg6ZuS4LSKXKN+xNgVRWiPqtlywSHXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744136; c=relaxed/simple;
	bh=MRPEFUByKoE3E171/ADQDFHjmxTGLxKHSLI8zF+1fME=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Rf475GdAe+5F+1RoT6hGpSz7uIC63PxOy9kll87U1pZLqGPHWQKQYGo8a2GG2IFXo8iJFYmV202KN+5vGTiYkreRnNOYwrMBT++2QNKQsEJ1IWDmneyJB68dPFFke5EuA5ULSXZk+02a9rsc5OVprgiiezJF/HM3rpDuxI+Pb08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T7TVEZ3d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XmwzxNk7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029125514.496134233@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761744131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=jzd2cpBxZAlTZ6OeVYduP/faKRKX/ZIFERQS2qaMoWc=;
	b=T7TVEZ3du+bx/06gDUdQasHRMvjn6GDVaNb4zFr45ub34M9KBbG+SRkA1hEWSyL7xOT0oF
	4ZOFURVKPPyKBI1Nl0jeZ6GImmzoVPTwRNNYhed22r7ASVutw4LOgiSqZZhzsZ9G3qlOWq
	sG1pxYFm5+wpaVvoAhRkjMUGj5v3J+DKq/MiV3XTW499m4rTJ96kydvL4tZN3PkUrhkZNi
	hHnJuM330a6VUvINcZxbP1ITNv+9MOcBvFJWS1gO9jrez+9XQ7O+w1U5v9mHI3tEiTK4cM
	9aMProRrSwOdye/ucphh3Aw6UNBI5IhEEYN6w+CH1tS6AJkQQpM94CZdrSZffA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761744131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=jzd2cpBxZAlTZ6OeVYduP/faKRKX/ZIFERQS2qaMoWc=;
	b=XmwzxNk7bRAbJJ8jlmA3hDmj2UU4jxTjNMfSHgQF2dGiGjN09OMdXJ0esbMHlu4aG2IVSY
	oZFaukVMY5ZvymAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: [patch V3 00/12] rseq: Implement time slice extension mechanism
Date: Wed, 29 Oct 2025 14:22:11 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This is a follow up on the V2 version:

     https://lore.kernel.org/20251022110646.839870156@linutronix.de

V1 contains a detailed explanation:

     https://lore.kernel.org/20250908225709.144709889@linutronix.de

TLDR: Time slice extensions are an attempt to provide opportunistic
priority ceiling without the overhead of an actual priority ceiling
protocol, but also without the guarantees such a protocol provides.

The intent is to avoid situations where a user space thread is interrupted
in a critical section and scheduled out, while holding a resource on which
the preempting thread or other threads in the system might block on. That
obviously prevents those threads from making progress in the worst case for
at least a full time slice. Especially in the context of user space
spinlocks, which are a patently bad idea to begin with, but that's also
true for other mechanisms.

This series uses the existing RSEQ user memory to implement it.

Changes vs. V2:

   - Rebase on the newest RSEQ and uaccess changes

   - Document the command line parameter - Sebastian

   - Use ENOTSUPP in the stub inline to be consistent - Sebastian

   - Add sysctl documentation - Sebastian

   - Simplify timer cancelation - Sebastian

   - Restore the dropped 'From: Peter...' line in patch 1 - Sebastian

   - More documentation/comment fixes - Randy


The uaccess and RSEQ modifications on which this series is based can be
found here:

    https://lore.kernel.org/20251029123717.886619142@linutronix.de

and in git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/cid

For your convenience all of it is also available as a conglomerate from
git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice

Thanks,

	tglx

---
Peter Zijlstra (1):
      sched: Provide and use set_need_resched_current()

Thomas Gleixner (11):
      rseq: Add fields and constants for time slice extension
      rseq: Provide static branch for time slice extensions
      rseq: Add statistics for time slice extensions
      rseq: Add prctl() to enable time slice extensions
      rseq: Implement sys_rseq_slice_yield()
      rseq: Implement syscall entry work for time slice extensions
      rseq: Implement time slice extension enforcement timer
      rseq: Reset slice extension when scheduled
      rseq: Implement rseq_grant_slice_extension()
      entry: Hook up rseq time slice extension
      selftests/rseq: Implement time slice extension test

 Documentation/admin-guide/kernel-parameters.txt |    5 
 Documentation/admin-guide/sysctl/kernel.rst     |    6 
 Documentation/userspace-api/index.rst           |    1 
 Documentation/userspace-api/rseq.rst            |  118 +++++++++
 arch/alpha/kernel/syscalls/syscall.tbl          |    1 
 arch/arm/tools/syscall.tbl                      |    1 
 arch/arm64/tools/syscall_32.tbl                 |    1 
 arch/m68k/kernel/syscalls/syscall.tbl           |    1 
 arch/microblaze/kernel/syscalls/syscall.tbl     |    1 
 arch/mips/kernel/syscalls/syscall_n32.tbl       |    1 
 arch/mips/kernel/syscalls/syscall_n64.tbl       |    1 
 arch/mips/kernel/syscalls/syscall_o32.tbl       |    1 
 arch/parisc/kernel/syscalls/syscall.tbl         |    1 
 arch/powerpc/kernel/syscalls/syscall.tbl        |    1 
 arch/s390/kernel/syscalls/syscall.tbl           |    1 
 arch/s390/mm/pfault.c                           |    3 
 arch/sh/kernel/syscalls/syscall.tbl             |    1 
 arch/sparc/kernel/syscalls/syscall.tbl          |    1 
 arch/x86/entry/syscalls/syscall_32.tbl          |    1 
 arch/x86/entry/syscalls/syscall_64.tbl          |    1 
 arch/xtensa/kernel/syscalls/syscall.tbl         |    1 
 include/linux/entry-common.h                    |    2 
 include/linux/rseq.h                            |   11 
 include/linux/rseq_entry.h                      |  191 ++++++++++++++-
 include/linux/rseq_types.h                      |   30 ++
 include/linux/sched.h                           |    7 
 include/linux/syscalls.h                        |    1 
 include/linux/thread_info.h                     |   16 -
 include/uapi/asm-generic/unistd.h               |    5 
 include/uapi/linux/prctl.h                      |   10 
 include/uapi/linux/rseq.h                       |   38 +++
 init/Kconfig                                    |   12 
 kernel/entry/common.c                           |   14 -
 kernel/entry/syscall-common.c                   |   11 
 kernel/rcu/tiny.c                               |    8 
 kernel/rcu/tree.c                               |   14 -
 kernel/rcu/tree_exp.h                           |    3 
 kernel/rcu/tree_plugin.h                        |    9 
 kernel/rcu/tree_stall.h                         |    3 
 kernel/rseq.c                                   |  299 ++++++++++++++++++++++++
 kernel/sys.c                                    |    6 
 kernel/sys_ni.c                                 |    1 
 scripts/syscall.tbl                             |    1 
 tools/testing/selftests/rseq/.gitignore         |    1 
 tools/testing/selftests/rseq/Makefile           |    5 
 tools/testing/selftests/rseq/rseq-abi.h         |   27 ++
 tools/testing/selftests/rseq/slice_test.c       |  198 +++++++++++++++
 47 files changed, 1019 insertions(+), 53 deletions(-)



Return-Path: <linux-arch+bounces-13423-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90918B49D27
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 01:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9FC3BDB57
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 23:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653BE2F0661;
	Mon,  8 Sep 2025 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sKig7PyC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NAwb8SPG"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DAD2EE29F;
	Mon,  8 Sep 2025 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372395; cv=none; b=JeAb8p1tTJuVFne8GC31KV2eKRWRg+YnXDvTQiF1Jp1v5NyZi2VjEJKNELpXz4AIGx9PHWmHKz4KxTnYR6Mo/1vRn/Xit+lflCUvZ/GaI+hiKyVIhWwI5x8VVB847jZa5dz3Wo9ueoSm6ZfRUGLE0Zox9ZYrbxuoMHrLioPs3ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372395; c=relaxed/simple;
	bh=OhoCJiace39APLY9BORpuiClEw/tqSZuYxa6DA0/4Uk=;
	h=Message-ID:From:To:Subject:cc:Date; b=mjDZYEdA4UyymynxMIb3Tr4IRZkvJXvCaFRxQu8q7vShb3+xd0QltBXGveqLDf5eZ81E+LVz0zXV8dukI0SmfYa9IpeKWvhi6aE2+QM8Wvb8olQCM9BZgpKMaAcMzsYvwcmaYG7kZJb/fk1VQ9/3uoAUjZJhnYQLrKrOVPxhALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sKig7PyC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NAwb8SPG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908225709.144709889@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757372388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=ffQK8V2HC9r6ZlSkKcj/pbF3WZFDnMYvI5kkxuc7stg=;
	b=sKig7PyCMqUQ+TfYv2rSBbTktS/LsmHVilZJecgNVYODYwj9nkwXZiZxIMPcHYLlswtVZ4
	V7deVBYK3IEBZmSxAZHKJ7CV+h0sest9pjYyPJ/PVPr7uWWBhYmPR8LFKtrQmxiv0j88t4
	QJRNRy0128O4xaNoYtINJYTHu+s9NPekrPc7rwwiLLlGFQiZYLRsDhqfKFP375ZklomtNN
	nHfDuQPWdaqXO6GeJCiHOYxbveMYyZFD3PtGIqMsgFg48qCZzwur0WKNPUV+95oWyu7GZy
	B2y5t2hwIANMhXCzi5KmA9jKtCoT9pVDHk379iZrBleigpnTWreJKsHDlpeVFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757372388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=ffQK8V2HC9r6ZlSkKcj/pbF3WZFDnMYvI5kkxuc7stg=;
	b=NAwb8SPGA31KjMmlOz2OL7GG7Wkm4UOaToykFwtO+ahPJqQNHtXYW9qSzmgXaii/+0CAj0
	Ndw3AeWQ1kDmnxAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 00/12] rseq: Implement time slice extension mechanism
cc: Peter Zilstra <peterz@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>,
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
Date: Tue,  9 Sep 2025 00:59:47 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This is the proper implementation of the PoC code, which I posted in reply
to the latest iteration of Prakash's time slice extension patches:

     https://lore.kernel.org/all/87o6smb3a0.ffs@tglx

Time slice extensions are an attempt to provide opportunistic priority
ceiling without the overhead of an actual priority ceiling protocol, but
also without the guarantees such a protocol provides.

The intent is to avoid situations where a user space thread is interrupted
in a critical section and scheduled out, while holding a resource on which
the preempting thread or other threads in the system might block on. That
obviously prevents those threads from making progress in the worst case for
at least a full time slice. Especially in the context of user space
spinlocks, which are a patently bad idea to begin with, but that's also
true for other mechanisms.

This has been attempted to solve at least for a decade, but so far this
went nowhere.  The recent attempts, which started to integrate with the
already existing RSEQ mechanism, have been at least going into the right
direction. The full history is partially in the above mentioned mail thread
and it's ancestors, but also in various threads in the LKML archives, which
require archaeological efforts to retrieve.

When trying to morph the PoC into actual mergeable code, I stumbled over
various shortcomings in the RSEQ code, which have been addressed in a
separate effort. The latest iteration can be found here:

     https://lore.kernel.org/all/20250908212737.353775467@linutronix.de

That is a prerequisite for this series as it allows a tight integration
into the RSEQ code without inflicting a lot of extra overhead into the hot
paths.

The main change vs. the PoC and the previous attempts is that it utilizes a
new field in the user space ABI rseq struct, which allows to reduce the
atomic operations in user space to a bare minimum. If the architecture
supports CPU local atomics, which protect against the obvious RMW race
vs. an interrupt, then there is no actual overhead, e.g. LOCK prefix on
x86, required.

The kernel user space ABI consists only of two bits in this new field:

	REQUEST and GRANTED

User space sets REQUEST at the begin of the critical section. If it
finishes the critical section without interruption then it can clear the
bit and move on.

If it is interrupted and the interrupt return path in the kernel observes a
rescheduling request, then the kernel can grant a time slice extension. The
kernel clears the REQUEST bit and sets the GRANTED bit with a simple
non-atomic store operation. If it does not grant the extension only the
REQUEST bit is cleared.

If user space observes the REQUEST bit cleared, when it finished the
critical section, then it has to check the GRANTED bit. If that is set,
then it has to invoke the rseq_slice_yield() syscall to terminate the
extension and yield the CPU.

The code flow in user space is:

   	  // Simple store as there is no concurrency vs. the GRANTED bit
      	  rseq->slice_ctrl = REQUEST;

	  critical_section();

	  // CPU local atomic required here:
	  if (!test_and_clear_bit(REQUEST, &rseq->slice_ctrl)) {
	     	// Non-atomic check is sufficient as this can race
		// against an interrupt, which revokes the grant
		//
		// If not set, then the request was either cleared by the kernel
		// without grant or the grant was revoked.
		//
		// If set, tell the kernel that the critical section is done
		// so it can reschedule
	  	if (rseq->slice_ctrl & GRANTED)
			rseq_slice_yield();
	  }

The other details, which differ from earlier attempts and the PoC, are:

    - A separate syscall for terminating the extension to avoid side
      effects and overloading of the already ill defined sched_yield(2)

    - A separate per CPU timer, which again does not inflict side effects
      on the scheduler internal hrtick timer. The hrtick timer can be
      disabled at run-time and an expiry can cause interesting problems in
      the scheduler code when it is unexpectedly invoked.

    - Tight integration into the rseq exit to user mode code. It utilizes
      the path when TIF_RESQ is not set at the end of exit_to_user_mode()
      to arm the timer if an extension was granted. TIF_RSEQ indicates that
      the task was scheduled and therefore would revoke the grant anyway.

    - A futile attempt to make this "work" on the PREEMPT_LAZY preemption
      model which is utilized by PREEMPT_RT.

      It allows the extension to be granted when TIF_PREEMPT_LAZY is set,
      but not TIF_PREEMPT.

      Pretending that this can be made work for TIF_PREEMPT on a fully
      preemptible kernel is just wishful thinking as the chance that
      TIF_PREEMPT is set in exit_to_user_mode() is close to zero for
      obvious reasons.

      This only "works" by some definition of works, i.e. on a best effort
      basis, for the PREEMPT_NONE model and nothing else. Though given the
      problems PREEMPT_NONE and also PREEMPT_VOLUNTARY have vs. long
      running code sections, the days of these models should be hopefully
      numbered and everything consolidated on the LAZY model.

      That makes this distinction moot and everything restricted to
      TIF_PREEMPT_LAZY unless someone is crazy enough to inflict the slice
      extension mechanism into the scheduler hotpath. I'm sure there will
      be attempts to do that as there is no lack of crazy folks out
      there...

    - Actual documentation of the user space ABI and a initial self test.

The RSEQ modifications on which this series is based can be found here:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf

For your convenience all of it is also available as a conglomerate from
git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice

Thanks,

	tglx
---
 Documentation/userspace-api/index.rst       |    1 
 Documentation/userspace-api/rseq.rst        |  129 ++++++++++++
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/arm64/tools/syscall_32.tbl             |    1 
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 
 arch/s390/kernel/syscalls/syscall.tbl       |    1 
 arch/s390/mm/pfault.c                       |    3 
 arch/sh/kernel/syscalls/syscall.tbl         |    1 
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 
 include/linux/entry-common.h                |    2 
 include/linux/rseq.h                        |   11 +
 include/linux/rseq_entry.h                  |  176 ++++++++++++++++
 include/linux/rseq_types.h                  |   28 ++
 include/linux/sched.h                       |    7 
 include/linux/syscalls.h                    |    1 
 include/linux/thread_info.h                 |   16 -
 include/uapi/asm-generic/unistd.h           |    5 
 include/uapi/linux/prctl.h                  |   10 
 include/uapi/linux/rseq.h                   |   28 ++
 init/Kconfig                                |   12 +
 kernel/entry/common.c                       |   14 +
 kernel/entry/syscall-common.c               |   11 -
 kernel/rcu/tiny.c                           |    8 
 kernel/rcu/tree.c                           |   14 -
 kernel/rcu/tree_exp.h                       |    3 
 kernel/rcu/tree_plugin.h                    |    9 
 kernel/rcu/tree_stall.h                     |    3 
 kernel/rseq.c                               |  293 ++++++++++++++++++++++++++++
 kernel/sys.c                                |    6 
 kernel/sys_ni.c                             |    1 
 scripts/syscall.tbl                         |    1 
 tools/testing/selftests/rseq/.gitignore     |    1 
 tools/testing/selftests/rseq/Makefile       |    5 
 tools/testing/selftests/rseq/rseq-abi.h     |    2 
 tools/testing/selftests/rseq/slice_test.c   |  217 ++++++++++++++++++++
 45 files changed, 991 insertions(+), 42 deletions(-)




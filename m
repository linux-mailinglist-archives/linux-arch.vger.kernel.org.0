Return-Path: <linux-arch+bounces-14257-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC68FBFC0B0
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 15:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45BE7541802
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 13:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BF5344046;
	Wed, 22 Oct 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="leYxFwf4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aNinvXYR"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF7432E6B6;
	Wed, 22 Oct 2025 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137852; cv=none; b=pAz9JYTH1wS79RfDBcTqTMFZifXJVFMeUvjqNyCLD5+TId0uEQpY5gvlRaT2MOtxOyoaVgJyAaAceiU2CHB62fjdQdbCunZT0TA1Xt5x2Y1wUoALooY/tEXX7hmRb+4yTg5pep45ajoNkL5qtvfNkFq5L1kzUDUOCqw6wYznaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137852; c=relaxed/simple;
	bh=uU+yJJdN7UX2rf6FgcUo6WL4cDe0hH4Kc512BII8mY4=;
	h=Message-ID:From:To:Subject:cc:Date; b=e29EAjRBquJf4faWKMGQOEbN6ZLV/SfsLsuG348vjuUkGtvPlkKridCAHWv30s54cX40kwWJ2YRgHJqO7FAUJbpKviav+/2x4sFQ96PwYNmsBezsD++1WYa/HlH47T/PbuNbZuqE4rDzqYzvU8Py+hI/aY30vUBtFNmsZ7gDrGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=leYxFwf4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aNinvXYR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110646.839870156@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=wwHQlPNeKtHr3D+/0q7R8scym6snVoGqSI2dxv8wiUc=;
	b=leYxFwf4kfbiztmW0DrAGVTWU7cLBTCU7XkKkbl4CXoxyJEExJtVvgbzkiZjzJvVHrao6a
	5zu9fb0Ai0FfQo1iDxerT/5KBFJm71JGqG+cHWt9e50j2UCNEBixAgk4ShEaXdQf74+D2I
	HEPLEJ0boWxmMe/RcvXIBW4p+vWF6nG+U1n71n8ornruYtE0CnPW92PS2PXoPTqy7n2R9S
	8ys4vWkexPyQ/Qn5jlH3DZ6XV99uZ04bGG8WJ4CQIQAvX/8dUu310o05iTH4nmtmMpFTk5
	Bwg/629HGYSlEg3N3S6z7oYMElUBdmlPMzD9sBmFUUIpNMgezmHPc3IDt4dzWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=wwHQlPNeKtHr3D+/0q7R8scym6snVoGqSI2dxv8wiUc=;
	b=aNinvXYR1fWujSkIVzI/5iEuBvBx9pCOsf11X+r+ybJ1U3p4+w/quz0IZNjqF/mWpME6P4
	fEK28xSwsODpgEAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 00/12] rseq: Implement time slice extension mechanism
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
Date: Wed, 22 Oct 2025 14:57:28 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This is a follow up on the V1 version:

     https://lore.kernel.org/20250908225709.144709889@linutronix.de

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

This series uses the existing RSEQ user memory to implement it.

Changes vs. V1:

   - Rebase on the newest RSEQ and uaccess changes

   - Use seperate bytes for request and grant and lift the atomic operation
     requirement for user space - Mathieu

   - Kconfig indentation, fix typos and expressions - Randy

   - Provide an extra stub for the !RSEQ case - Prateek

   - Use the proper name in sys_ni.c and add comment - Prateek

   - Return 1 from __setup() - Prateek


The uaccess and RSEQ modifications on which this series is based can be
found here:

    https://lore.kernel.org/20251022104005.907410538@linutronix.de/

and in git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/cid

For your convenience all of it is also available as a conglomerate from
git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice

Thanks,

	tglx
---
Peter Zilstra (1):
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

 Documentation/userspace-api/index.rst       |    1 
 Documentation/userspace-api/rseq.rst        |  118 ++++++++++
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
 include/linux/rseq_entry.h                  |  190 ++++++++++++++++-
 include/linux/rseq_types.h                  |   28 ++
 include/linux/sched.h                       |    7 
 include/linux/syscalls.h                    |    1 
 include/linux/thread_info.h                 |   16 -
 include/uapi/asm-generic/unistd.h           |    5 
 include/uapi/linux/prctl.h                  |   10 
 include/uapi/linux/rseq.h                   |   38 +++
 init/Kconfig                                |   12 +
 kernel/entry/common.c                       |   14 +
 kernel/entry/syscall-common.c               |   11 -
 kernel/rcu/tiny.c                           |    8 
 kernel/rcu/tree.c                           |   14 -
 kernel/rcu/tree_exp.h                       |    3 
 kernel/rcu/tree_plugin.h                    |    9 
 kernel/rcu/tree_stall.h                     |    3 
 kernel/rseq.c                               |  304 ++++++++++++++++++++++++++++
 kernel/sys.c                                |    6 
 kernel/sys_ni.c                             |    1 
 scripts/syscall.tbl                         |    1 
 tools/testing/selftests/rseq/.gitignore     |    1 
 tools/testing/selftests/rseq/Makefile       |    5 
 tools/testing/selftests/rseq/rseq-abi.h     |   27 ++
 tools/testing/selftests/rseq/slice_test.c   |  198 ++++++++++++++++++
 45 files changed, 1011 insertions(+), 52 deletions(-)



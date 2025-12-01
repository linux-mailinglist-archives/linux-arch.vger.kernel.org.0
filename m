Return-Path: <linux-arch+bounces-15110-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F920C95F18
	for <lists+linux-arch@lfdr.de>; Mon, 01 Dec 2025 08:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF53D342ABC
	for <lists+linux-arch@lfdr.de>; Mon,  1 Dec 2025 07:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AA52877ED;
	Mon,  1 Dec 2025 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kHF5gM0X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OOUmdj3e"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685F849C;
	Mon,  1 Dec 2025 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764572746; cv=none; b=JtggRs660GCeFZF5wrVmAiG6HkVJgx+yhOMcVyUcu/kF/ofUOnAAbZc/FnahSocrwHgGiPGePPZkTt7U50/kq/v+eZfs4eaRJvz1WlYTaQ3Jn0HgnxcUuYst2OX94dH4L008IwOT3h38DHXyYWRb89djw7ctX6zSKOH6SjKFcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764572746; c=relaxed/simple;
	bh=E7QZEz8c7HOIXnKRkK/JiZ5wjCTAg6aPlYbm3TBkXQ4=;
	h=Message-ID:From:To:Cc:Subject:Date; b=dXVV2mQ1fgF1GEzY3aqEfgXloS/sqSGwoATySaTSq/dIBgx7/DTppz18pLmZwkWZBVI3/KodjzOejFjPBRC6a/PxOavd+DXwhLYfTqyTl+s0eGMKiWQThz1URCQFu3xOboXPe7oxJA2Z3hNpZVddB46pR2sQaF8yAPDh/B9MMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kHF5gM0X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OOUmdj3e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251128225931.959481199@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764572742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=/uvd38yTuKmX5/xf4WI9Tt7XUen1ACHqj4KIdaFPpRM=;
	b=kHF5gM0XV6BECUW86Etx+AlY6iBlGpqivIBGwLnHMTv7Mk71V5jhpNkqaBBC8WINBRM3GD
	ZVKoUQ6cX9KNluddBM1LBwUh0ZKYvwrI8UgYEu8necIrNkeqkQr8XB1kfD4C59SV6WbzxN
	Z1wRRYBW9hYsuB+MZNmBN3kiYW+tMZtG+nhbkfCQd2deb9zDe7TrT6a57o+omISeUniQsf
	SHbhcONod+FYy4LAJ0QjCiCG+HTVYH/LqJfObBO2aXarEfhNjuTKaqEAJbMmoeFifESBYz
	9mLAdR+qiAVHVy+BOThl+CedTwDBXS3vxMgQiobAxYedEe0OG0gpKGYrnPo42A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764572742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=/uvd38yTuKmX5/xf4WI9Tt7XUen1ACHqj4KIdaFPpRM=;
	b=OOUmdj3e4WbpK2zNJiVniAKA9prstuwvWwhzpxTtFNxOoeMqG8gG8aKwbMlUK4/NcQfzZC
	J4b505au8cf+MiDw==
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
Subject: [patch V5 00/11] rseq: Implement time slice extension mechanism
Date: Mon,  1 Dec 2025 08:05:36 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This is a follow up on the V4 version:

     https://lore.kernel.org/20251116173423.031443519@linutronix.de

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

Changes vs. V4:

   - Rebase on the newest uaccess, RSEQ and CID changes

   - Remove the restriction to use rseq_slice_yield() and allow arbitrary
     syscalls to terminate the granted extension gracefully. That's
     required to support onion architectured applications where the
     layering has no control over the actual code which runs inside the
     critical section which started with requesting the extension.

   - Drop the set_need_resched_current() patch as that has been merged into
     the scheduler tree already.

All prerequisites required can be found in git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/cid

For your convenience all of it is also available as a conglomerate from
git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice

This still uses syscall NR 470, which conflicts with pending changes in
-next, but that will be sorted after 6.19-rc1 with the hopefully final
submission of this. For now this sticks to 470 to avoid pulling the full
zoo of -next.

In the reply to the V3 and V4 series there have been actual numbers posted
vs. the Oracle workload which triggered this whole effort and numbers vs. a
hacked up version of a netflix global lock benchmark.

I took some inspiriation from that netflix benchmark and implemented a new
version from scratch to explore a few aspects of this time slice mechanism
especially concerning the overhead in the non-contended case and the
effects of the 'work' within and outside of the lock held region. Along
with the effects of background activity.

The results are not really always what you expect, but there is a clear
sweet spot where the overhead of the time slice magic in the uncontended
case flips over to a benefit. Your mileage might vary. :)

The benchmark source with a pile of barely documented command line options
is available here:

   https://tglx.de/~tglx/timeslice/lock_slice.c

Use it at your own peril. It's a hack and I only tried to build it with

    gcc -O2 -Wall lock_slice.c -o l

Thanks,

	tglx
---
 Documentation/admin-guide/kernel-parameters.txt |    5 
 Documentation/admin-guide/sysctl/kernel.rst     |    8 
 Documentation/userspace-api/index.rst           |    1 
 Documentation/userspace-api/rseq.rst            |  135 +++++++++
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
 arch/sh/kernel/syscalls/syscall.tbl             |    1 
 arch/sparc/kernel/syscalls/syscall.tbl          |    1 
 arch/x86/entry/syscalls/syscall_32.tbl          |    1 
 arch/x86/entry/syscalls/syscall_64.tbl          |    1 
 arch/xtensa/kernel/syscalls/syscall.tbl         |    1 
 include/linux/entry-common.h                    |    2 
 include/linux/rseq.h                            |   11 
 include/linux/rseq_entry.h                      |  192 +++++++++++++-
 include/linux/rseq_types.h                      |   32 ++
 include/linux/syscalls.h                        |    1 
 include/linux/thread_info.h                     |   16 -
 include/uapi/asm-generic/unistd.h               |    5 
 include/uapi/linux/prctl.h                      |   10 
 include/uapi/linux/rseq.h                       |   38 ++
 init/Kconfig                                    |   12 
 kernel/entry/common.c                           |   14 -
 kernel/entry/syscall-common.c                   |   11 
 kernel/rseq.c                                   |  328 ++++++++++++++++++++++++
 kernel/sys.c                                    |    6 
 kernel/sys_ni.c                                 |    1 
 scripts/syscall.tbl                             |    1 
 tools/testing/selftests/rseq/.gitignore         |    1 
 tools/testing/selftests/rseq/Makefile           |    5 
 tools/testing/selftests/rseq/rseq-abi.h         |   27 +
 tools/testing/selftests/rseq/slice_test.c       |  219 ++++++++++++++++
 40 files changed, 1070 insertions(+), 27 deletions(-)




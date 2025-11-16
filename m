Return-Path: <linux-arch+bounces-14812-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE98CC61CFE
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 21:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8161135669F
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A892609D4;
	Sun, 16 Nov 2025 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MFxrMEHE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qLPnE1J4"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC9264A9D;
	Sun, 16 Nov 2025 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326270; cv=none; b=A+MeIVPx31gdXrwKjubJaYdFrgngmN72JKWGHnlAA/mBXKm5EaqDA7J4udmahiJPkPkM8C0x82t9BkZp7XRg7NeQebUBMZASjlFB07PJ46LiKRGLPJC0tQZC/RDRw5ySXs7SWKoHH+JIAqjavYjtbyNF8ECOE+TJ+Mpuvt7rEPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326270; c=relaxed/simple;
	bh=rngUbCq+m5BEu5kQxAPeZ4SpXwtJjP7p1bvCeOWbV6c=;
	h=Message-ID:From:To:Cc:Subject:Date; b=bVAxufF2iMJg6hw7clrxOZQ7igkCZVMura3PORY979q9tKFoZzMa4MClVThlcePNfqSbnB5//liTYSYcDEPOA1A1f3XQ/W3GiNuDsWoXyfDYYQ869rBjBR02r4pNghmbpXwMLbwDCfU1Kk47bXDzLnZxL7mhJ2t5yyXcUeusy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MFxrMEHE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qLPnE1J4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251116173423.031443519@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763326266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=onPVar5CmW8JYnSH5Lk5d/XdFTAeU34vwmMqyHwJEP0=;
	b=MFxrMEHENMqyLE8XvTUFGtfwWLbT1dgAhMX6Sf+PELySr1pohyaejb8RVJutciaBS/gErt
	MH4c6lTaiWkZDPyY69vH5bsQGtQaBrMNu+8pWGJS7c2gooVSnLmDHzVUbAMO26selFNWab
	C21Gr98VRkA9826zkHOsNGb7636moTqPhne8JBefjVvkxuKJBwAfpoKzDBPYevCa3+WN7D
	bPatjqJGP9LKFHykQVMDot+WKxkZ73XRb6x8O6HJnP0j8K1eEtcoaYUUT7joZrqd1aPkxK
	TcydeRthoXMLI516qJnkvq7uJzJ6yWGmVKt3Jp/Fa8T7tYqPY8tCbwsNBD//Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763326266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=onPVar5CmW8JYnSH5Lk5d/XdFTAeU34vwmMqyHwJEP0=;
	b=qLPnE1J4p04CdOLkk28XTV6QHrL7WDt9VFjHRf2OdGBelphPjaA+JRpACaeAYa6XNpT2f5
	GVc5m5emy9pt80CA==
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
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V4 00/12] rseq: Implement time slice extension mechanism
Date: Sun, 16 Nov 2025 21:51:05 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This is a follow up on the V3 version:

     https://lore.kernel.org/20251029125514.496134233@linutronix.de

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

Changes vs. V3:

   - Rebase on the newest uaccess, RSEQ and CID changes

   - Make the example code correct - Prakash

   - Update comment - Steven

   - Finally get the __setup() nonsense right - Randy

   - Picked up Reviewed/Acked-by tags where appropriate

The CID modifications on which this series is based on can be found here:

    https://lore.kernel.org/20251104075053.700034556@linutronix.de

and in git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/cid

For your convenience all of it is also available as a conglomerate from
git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice

Thanks,

	tglx
---
 Documentation/admin-guide/kernel-parameters.txt |    5 
 Documentation/admin-guide/sysctl/kernel.rst     |    6 
 Documentation/userspace-api/index.rst           |    1 
 Documentation/userspace-api/rseq.rst            |  119 +++++++++
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
 47 files changed, 1020 insertions(+), 53 deletions(-)


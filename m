Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBB2567A5
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 15:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgH2NAC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 09:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH2M74 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Aug 2020 08:59:56 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACEEB2076D;
        Sat, 29 Aug 2020 12:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598705995;
        bh=MheKn7qA17nkyGJRDoDSoWuRmPBTERY8iqno8hbFt8E=;
        h=From:To:Cc:Subject:Date:From;
        b=UowAGL4CfBhIGG/THwvG2Rju9UmIIkkUwf8rqsXSnUlMOfHdNCEmtkaKUEA3XuOOq
         /n5draAtzGalbMEXI2rSNXp1pCY8X+GH8CDcbkJ3/lx+0Bhxixxq2l9xzZUKXRc3lN
         PYGJiZnPxsaZihyNCZODDq2lMbk0T/VyytGv43I0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers and make kretprobe lockless
Date:   Sat, 29 Aug 2020 21:59:49 +0900
Message-Id: <159870598914.1229682.15230803449082078353.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Here is the 5th version of the series to unify the kretprobe trampoline handler
and to make the kretprobe lockless. Thanks Peter for this work !!

Previous version is here;

 https://lkml.kernel.org/r/159861759775.992023.12553306821235086809.stgit@devnote2

This version merges the remove-task-scan patch into remove kretprobe hash
patch, fixes code according to the comments, and fixes a minor issues.

This version is also available on
git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git lockless-kretprobe-v5

I ran smoke test and ftracetest on x86-64 and did build tests for x86-64, i386, arm,
arm64, and mips.


Thank you,

---

Masami Hiramatsu (16):
      kprobes: Add generic kretprobe trampoline handler
      x86/kprobes: Use generic kretprobe trampoline handler
      arm: kprobes: Use generic kretprobe trampoline handler
      arm64: kprobes: Use generic kretprobe trampoline handler
      arc: kprobes: Use generic kretprobe trampoline handler
      csky: kprobes: Use generic kretprobe trampoline handler
      ia64: kprobes: Use generic kretprobe trampoline handler
      mips: kprobes: Use generic kretprobe trampoline handler
      parisc: kprobes: Use generic kretprobe trampoline handler
      powerpc: kprobes: Use generic kretprobe trampoline handler
      s390: kprobes: Use generic kretprobe trampoline handler
      sh: kprobes: Use generic kretprobe trampoline handler
      sparc: kprobes: Use generic kretprobe trampoline handler
      kprobes: Remove NMI context check
      kprobes: Free kretprobe_instance with rcu callback
      kprobes: Make local used functions static

Peter Zijlstra (5):
      llist: Add nonatomic __llist_add() and __llist_dell_all()
      kprobes: Remove kretprobe hash
      asm-generic/atomic: Add try_cmpxchg() fallbacks
      freelist: Lock less freelist
      kprobes: Replace rp->free_instance with freelist


 arch/arc/kernel/kprobes.c                 |   54 ------
 arch/arm/probes/kprobes/core.c            |   78 ---------
 arch/arm64/kernel/probes/kprobes.c        |   78 ---------
 arch/csky/kernel/probes/kprobes.c         |   77 --------
 arch/ia64/kernel/kprobes.c                |   77 --------
 arch/mips/kernel/kprobes.c                |   54 ------
 arch/parisc/kernel/kprobes.c              |   76 --------
 arch/powerpc/kernel/kprobes.c             |   53 ------
 arch/s390/kernel/kprobes.c                |   79 ---------
 arch/sh/kernel/kprobes.c                  |   58 ------
 arch/sparc/kernel/kprobes.c               |   51 ------
 arch/x86/include/asm/atomic.h             |    2 
 arch/x86/include/asm/atomic64_64.h        |    2 
 arch/x86/include/asm/cmpxchg.h            |    2 
 arch/x86/kernel/kprobes/core.c            |  108 ------------
 drivers/gpu/drm/i915/i915_request.c       |    6 -
 include/asm-generic/atomic-instrumented.h |  216 ++++++++++++++----------
 include/linux/atomic-arch-fallback.h      |   90 +++++++++-
 include/linux/atomic-fallback.h           |   90 +++++++++-
 include/linux/freelist.h                  |  129 ++++++++++++++
 include/linux/kprobes.h                   |   74 +++++---
 include/linux/llist.h                     |   23 +++
 include/linux/sched.h                     |    4 
 kernel/fork.c                             |    4 
 kernel/kprobes.c                          |  264 +++++++++++++----------------
 kernel/trace/trace_kprobe.c               |    3 
 scripts/atomic/gen-atomic-fallback.sh     |   63 ++++++-
 scripts/atomic/gen-atomic-instrumented.sh |   29 +++
 28 files changed, 735 insertions(+), 1109 deletions(-)
 create mode 100644 include/linux/freelist.h

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCA255A03
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 14:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgH1M0q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 08:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgH1M0o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 08:26:44 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7217A20848;
        Fri, 28 Aug 2020 12:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598617603;
        bh=fsyyxShImPuae7reDlXKBt0RWFjPdM+Hf6cWqd3qjac=;
        h=From:To:Cc:Subject:Date:From;
        b=trILrrb4jSMaZjbV3sWvQwkgX87nG2rSG5LSUSZoJL3GHnUBnczUx20VHlQIU0gRx
         mb+n3dKGSqlLVbVBva+wNpbZlWaqDeREAXJVnfGdtx3zMfOUZFthMjY+EoKKvD/NCE
         tjnl3Yml+1wSGzhJFvM5wrEKrsVEZmYhJmUdrBr4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v4 00/23] kprobes: Unify kretprobe trampoline handlers and make kretprobe lockless
Date:   Fri, 28 Aug 2020 21:26:38 +0900
Message-Id: <159861759775.992023.12553306821235086809.stgit@devnote2>
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

Here is the 4th version of the series to unify the kretprobe trampoline handler
and make kretprobe lockless.

Previous version is here;

 https://lkml.kernel.org/r/159854631442.736475.5062989489155389472.stgit@devnote2

In this version, I updated the generic trampoline handler a bit, merge 
the Peter's lockless patches(*), and add an RFC "remove task scan" patch
as [20/23].

(*) https://lkml.kernel.org/r/20200827161237.889877377@infradead.org

I ran some tests and ftracetest on x86-64. Mostly OK, but hit a BUG in the
trampoline handler once. I'm trying to reproduce it but not succeeded yet.
So this may need a careful review and tests.

I did something like:

mount -t debugfs debug /sys/kernel/debug
cd /sys/kernel/debug/tracing/
echo r:event1 vfs_read >> kprobe_events
echo r:event2 vfs_read %ax >> kprobe_events
echo r:event3 rw_verify_area %ax >> kprobe_events
echo 1 > events/kprobes/enable
sleep 1
less trace
cat ../kprobes/list
cd ~/linux/tools/testing/selftests/ftrace
./ftracetest

Then hits a BUG_ON at kernel/kprobes.c:1893 (no test executed, maybe
it happened when removing kretprobes?)

Thank you,

---

Masami Hiramatsu (17):
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
      [RFC] kprobes: Remove task scan for updating kretprobe_instance

Peter Zijlstra (6):
      llist: Add nonatomic __llist_add()
      sched: Fix try_invoke_on_locked_down_task() semantics
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
 include/linux/kprobes.h                   |   73 +++++---
 include/linux/llist.h                     |   15 ++
 include/linux/sched.h                     |    4 
 kernel/fork.c                             |    4 
 kernel/kprobes.c                          |  263 +++++++++++++----------------
 kernel/sched/core.c                       |    9 -
 kernel/trace/trace_kprobe.c               |    3 
 scripts/atomic/gen-atomic-fallback.sh     |   63 ++++++-
 scripts/atomic/gen-atomic-instrumented.sh |   29 +++
 29 files changed, 729 insertions(+), 1114 deletions(-)
 create mode 100644 include/linux/freelist.h

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

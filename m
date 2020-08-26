Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134EF25302C
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 15:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbgHZNqS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 09:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbgHZNqS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Aug 2020 09:46:18 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E08320707;
        Wed, 26 Aug 2020 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598449577;
        bh=q+K51byIGxXEy+LkzDILyQ4zwfpfSzzirxdr2/iE7C0=;
        h=From:To:Cc:Subject:Date:From;
        b=ncpQk8Xo0V+2hFgc+lsOiyTKgLB3GcVErgBKT7R5pMWc+M4j3gXLjZAhDvqqZo7Ay
         u5nPlT4SQaQXEvL5ovL857Jlfjy7fbIIqIo5dVSFKN1WvyYrvZSfSkXQSjtksgPTpj
         iKkOLC5cytnTsr/vombML0Y/iPGSW6Tznx1nrC7E=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH 00/14] kprobes: Unify kretprobe trampoline handlers
Date:   Wed, 26 Aug 2020 22:46:12 +0900
Message-Id: <159844957216.510284.17683703701627367133.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

Here is the series of patches to unify the kretprobe trampoline handler
implementation across all architectures which are currently kprobes supported.
Also, this finally removes the in_nmi() check from pre_kretprobe_handler()
since we can avoid double-lock deadlock from NMI by kprobe_busy_begin/end().

The unified generic kretprobe trampoline handler is based on x86 code, which
already support frame-pointer checker. I've enabled it on the arm and
arm64 which I can test. For other architecutres, currently the frame-pointer
checker does not work. If someone wants to enable it, please set the correct
frame pointer to ri->fp and pass it to kretprobe_trampoline_handler() as the
3rd parameter, instead of NULL.

Peter's lockless patch is not included yet because there seems more isses
to be solved. It seems that the cleanup_rp_inst() will be the biggest piece
of this pazzle.


Thank you,

---

Masami Hiramatsu (14):
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


 arch/arc/kernel/kprobes.c          |   55 +----------------
 arch/arm/probes/kprobes/core.c     |   79 +-----------------------
 arch/arm64/kernel/probes/kprobes.c |   79 +-----------------------
 arch/csky/kernel/probes/kprobes.c  |   78 +-----------------------
 arch/ia64/kernel/kprobes.c         |   79 +-----------------------
 arch/mips/kernel/kprobes.c         |   55 +----------------
 arch/parisc/kernel/kprobes.c       |   78 ++----------------------
 arch/powerpc/kernel/kprobes.c      |   55 ++---------------
 arch/s390/kernel/kprobes.c         |   81 +------------------------
 arch/sh/kernel/kprobes.c           |   59 +-----------------
 arch/sparc/kernel/kprobes.c        |   52 +---------------
 arch/x86/kernel/kprobes/core.c     |  109 +---------------------------------
 include/linux/kprobes.h            |   32 +++++++++-
 kernel/kprobes.c                   |  117 ++++++++++++++++++++++++++++++++----
 14 files changed, 182 insertions(+), 826 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

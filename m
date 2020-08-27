Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5D254AD0
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgH0Qij (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgH0Qij (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 12:38:39 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2292207DF;
        Thu, 27 Aug 2020 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598546318;
        bh=HGrRH/4Vl2y+5WfL1JRJOAX6fyVmu09yZMUE2UIP5pQ=;
        h=From:To:Cc:Subject:Date:From;
        b=PgYzr5Tmo+V6b037K2GnSW46YdXgHWNxcJ0Up99s4lUggkZH6wcWhgiQYm8ek7cXc
         ZAOGz0qNAEMXejDcogb0Q9Q6Me5/z4bd3TERc2vx25SP+uBCfz1NkrquLk0HR+tzyI
         kfQTKns4IXEdjjhCV7LUX1k2XMVmlzp58Fq5phuo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org, guoren@kernel.org
Subject: [PATCH v3 00/16] kprobes: Unify kretprobe trampoline handlers
Date:   Fri, 28 Aug 2020 01:38:34 +0900
Message-Id: <159854631442.736475.5062989489155389472.stgit@devnote2>
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

Here is the 3rd version of the series to unify the kretprobe trampoline handler
implementation across all architectures which are currently kprobes supported.
Previous version is here;

 https://lkml.kernel.org/r/159852811819.707944.12798182250041968537.stgit@devnote2

This series removes the in_nmi() check from pre_kretprobe_handler() since we
can avoid double-lock deadlock from NMI by kprobe_busy_begin/end() and use
kfree_rcu() to release kretprobe_instance. Also, cleanup local functions to
static symbols.

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


 arch/arc/kernel/kprobes.c          |   55 +--------------
 arch/arm/probes/kprobes/core.c     |   79 +--------------------
 arch/arm64/kernel/probes/kprobes.c |   79 +--------------------
 arch/csky/kernel/probes/kprobes.c  |   78 +--------------------
 arch/ia64/kernel/kprobes.c         |   79 +--------------------
 arch/mips/kernel/kprobes.c         |   55 +--------------
 arch/parisc/kernel/kprobes.c       |   78 ++-------------------
 arch/powerpc/kernel/kprobes.c      |   55 +--------------
 arch/s390/kernel/kprobes.c         |   81 +--------------------
 arch/sh/kernel/kprobes.c           |   59 +---------------
 arch/sparc/kernel/kprobes.c        |   52 +-------------
 arch/x86/kernel/kprobes/core.c     |  109 +----------------------------
 include/linux/kprobes.h            |   51 ++++++++------
 kernel/kprobes.c                   |  136 +++++++++++++++++++++++++++++-------
 14 files changed, 190 insertions(+), 856 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

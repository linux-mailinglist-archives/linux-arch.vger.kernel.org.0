Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA1249AB4
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 12:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHSKrj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 06:47:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53968 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgHSKra (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 06:47:30 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k8Lco-0006IE-NK; Wed, 19 Aug 2020 10:47:22 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stafford Horne <shorne@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-doc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hewllig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 00/11] Introduce kernel_clone(), kill _do_fork()
Date:   Wed, 19 Aug 2020 12:46:44 +0200
Message-Id: <20200819104655.436656-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hey everyone,

This is a follow-up to the fork-related cleanup. It's based on a brief
discussion after the initial series was merged.
Last cycle we removed copy_thread_tls() and the associated Kconfig
option for each architecture. Now we are only left with copy_thread().
Part of this work was removing the old do_fork() legacy clone()-style
calling convention in favor of the new struct kernel_clone args calling
convention.
The only remaining function callable outside of kernel/fork.c is
_do_fork(). It doesn't really follow the naming of kernel-internal
syscall helpers as Christoph righly pointed out. Switch all callers and
references to kernel_clone() and remove _do_fork() once and for all also
switching the return value for kernel_clone() from long to pid_t since
that's what we use in all other places where we're dealing with process
identifiers.

For all architectures I have done a full git rebase v5.9-rc1 -x "make
-j31". There were no built failures and the changes were fairly
mechanical.

The only helpers we have left now are kernel_thread() and kernel_clone()
where kernel_thread() just calls kernel_clone().

Thanks!
Christian

Christian Brauner (11):
  fork: introduce kernel_clone()
  h8300: switch to kernel_clone()
  ia64: switch to kernel_clone()
  m68k: switch to kernel_clone()
  nios2: switch to kernel_clone()
  sparc: switch to kernel_clone()
  x86: switch to kernel_clone()
  kprobes: switch to kernel_clone()
  kgdbts: switch to kernel_clone()
  tracing: switch to kernel_clone()
  sched: remove _do_fork()

 Documentation/trace/histogram.rst             |  4 +-
 arch/h8300/kernel/process.c                   |  2 +-
 arch/ia64/kernel/process.c                    |  4 +-
 arch/m68k/kernel/process.c                    | 10 ++--
 arch/nios2/kernel/process.c                   |  2 +-
 arch/sparc/kernel/process.c                   |  6 +--
 arch/x86/kernel/sys_ia32.c                    |  2 +-
 drivers/misc/kgdbts.c                         | 48 +++++++++----------
 include/linux/sched/task.h                    |  2 +-
 kernel/fork.c                                 | 16 +++----
 samples/kprobes/kprobe_example.c              |  6 +--
 samples/kprobes/kretprobe_example.c           |  4 +-
 .../test.d/dynevent/add_remove_kprobe.tc      |  2 +-
 .../test.d/dynevent/clear_select_events.tc    |  2 +-
 .../test.d/dynevent/generic_clear_event.tc    |  2 +-
 .../test.d/ftrace/func-filter-stacktrace.tc   |  4 +-
 .../ftrace/test.d/kprobe/add_and_remove.tc    |  2 +-
 .../ftrace/test.d/kprobe/busy_check.tc        |  2 +-
 .../ftrace/test.d/kprobe/kprobe_args.tc       |  4 +-
 .../ftrace/test.d/kprobe/kprobe_args_comm.tc  |  2 +-
 .../test.d/kprobe/kprobe_args_string.tc       |  4 +-
 .../test.d/kprobe/kprobe_args_symbol.tc       | 10 ++--
 .../ftrace/test.d/kprobe/kprobe_args_type.tc  |  2 +-
 .../ftrace/test.d/kprobe/kprobe_ftrace.tc     | 14 +++---
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc |  2 +-
 .../test.d/kprobe/kprobe_syntax_errors.tc     | 12 ++---
 .../ftrace/test.d/kprobe/kretprobe_args.tc    |  4 +-
 .../selftests/ftrace/test.d/kprobe/profile.tc |  2 +-
 28 files changed, 88 insertions(+), 88 deletions(-)


base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
-- 
2.28.0


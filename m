Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC3F4D26CA
	for <lists+linux-arch@lfdr.de>; Wed,  9 Mar 2022 05:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiCIBXw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Mar 2022 20:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiCIBXq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2022 20:23:46 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660F76B0B1;
        Tue,  8 Mar 2022 17:22:20 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:37556)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRjzj-001Qdt-51; Tue, 08 Mar 2022 17:15:59 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34144 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRjzh-002fL8-Qm; Tue, 08 Mar 2022 17:15:58 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     <linux-arch@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 03 Jan 2022 15:30:02 -0600")
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
        <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 08 Mar 2022 18:15:51 -0600
Message-ID: <87fsnsdlqg.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nRjzh-002fL8-Qm;;;mid=<87fsnsdlqg.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18OQQ6XmC3RRMxFckLcbtxXLE62EYCdQMg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=2 Fuz1=2 Fuz2=2 
X-Spam-Combo: **;<linux-arch@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 754 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 13 (1.7%), b_tie_ro: 11 (1.4%), parse: 2.4 (0.3%),
         extract_message_metadata: 9 (1.2%), get_uri_detail_list: 4.4 (0.6%),
        tests_pri_-1000: 8 (1.1%), tests_pri_-950: 2.6 (0.4%), tests_pri_-900:
        2.0 (0.3%), tests_pri_-90: 213 (28.2%), check_bayes: 211 (28.0%),
        b_tokenize: 16 (2.1%), b_tok_get_all: 11 (1.5%), b_comp_prob: 4.2
        (0.6%), b_tok_touch_all: 173 (23.0%), b_finish: 3.4 (0.4%),
        tests_pri_0: 472 (62.5%), check_dkim_signature: 0.76 (0.1%),
        check_dkim_adsp: 4.8 (0.6%), poll_dns_idle: 2.0 (0.3%), tests_pri_10:
        3.4 (0.4%), tests_pri_500: 11 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 00/13] Removing tracehook.h
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


While working on cleaning up do_exit I have been having to deal with the
code in tracehook.h.  Unfortunately the code in tracehook.h does not
make sense as organized.

This set of changes reorganizes things so that tracehook.h no longer
exists, and so that it's current contents are organized in a fashion
that is a little easier to understand.

The biggest change is that I lean into the fact that get_signal
always calls task_work_run and removes the logic that tried to
be smart and decouple task_work_run and get_signal as it has proven
to not be effective.

This is a conservative change and I am not changing the how things
like signal_pending operate (although it is probably justified).

A new header resume_user_mode.h is added to hold resume_user_mode_work
which was previously known as tracehook_notify_resume.

Eric W. Biederman (13):
      ptrace: Move ptrace_report_syscall into ptrace.h
      ptrace/arm: Rename tracehook_report_syscall report_syscall
      ptrace: Create ptrace_report_syscall_{entry,exit} in ptrace.h
      ptrace: Remove arch_syscall_{enter,exit}_tracehook
      ptrace: Remove tracehook_signal_handler
      task_work: Remove unnecessary include from posix_timers.h
      task_work: Introduce task_work_pending
      task_work: Call tracehook_notify_signal from get_signal on all architectures
      task_work: Decouple TIF_NOTIFY_SIGNAL and task_work
      signal: Move set_notify_signal and clear_notify_signal into sched/signal.h
      resume_user_mode: Remove #ifdef TIF_NOTIFY_RESUME in set_notify_resume
      resume_user_mode: Move to resume_user_mode.h
      tracehook: Remove tracehook.h

 MAINTAINERS                          |   1 -
 arch/Kconfig                         |   5 +-
 arch/alpha/kernel/ptrace.c           |   5 +-
 arch/alpha/kernel/signal.c           |   4 +-
 arch/arc/kernel/ptrace.c             |   5 +-
 arch/arc/kernel/signal.c             |   4 +-
 arch/arm/kernel/ptrace.c             |  12 +-
 arch/arm/kernel/signal.c             |   4 +-
 arch/arm64/kernel/ptrace.c           |  14 +--
 arch/arm64/kernel/signal.c           |   4 +-
 arch/csky/kernel/ptrace.c            |   5 +-
 arch/csky/kernel/signal.c            |   4 +-
 arch/h8300/kernel/ptrace.c           |   5 +-
 arch/h8300/kernel/signal.c           |   4 +-
 arch/hexagon/kernel/process.c        |   4 +-
 arch/hexagon/kernel/signal.c         |   1 -
 arch/hexagon/kernel/traps.c          |   6 +-
 arch/ia64/kernel/process.c           |   4 +-
 arch/ia64/kernel/ptrace.c            |   6 +-
 arch/ia64/kernel/signal.c            |   1 -
 arch/m68k/kernel/ptrace.c            |   6 +-
 arch/m68k/kernel/signal.c            |   4 +-
 arch/microblaze/kernel/ptrace.c      |   5 +-
 arch/microblaze/kernel/signal.c      |   4 +-
 arch/mips/kernel/ptrace.c            |   5 +-
 arch/mips/kernel/signal.c            |   4 +-
 arch/nds32/include/asm/syscall.h     |   2 +-
 arch/nds32/kernel/ptrace.c           |   5 +-
 arch/nds32/kernel/signal.c           |   4 +-
 arch/nios2/kernel/ptrace.c           |   5 +-
 arch/nios2/kernel/signal.c           |   4 +-
 arch/openrisc/kernel/ptrace.c        |   5 +-
 arch/openrisc/kernel/signal.c        |   4 +-
 arch/parisc/kernel/ptrace.c          |   7 +-
 arch/parisc/kernel/signal.c          |   4 +-
 arch/powerpc/kernel/ptrace/ptrace.c  |   8 +-
 arch/powerpc/kernel/signal.c         |   4 +-
 arch/riscv/kernel/ptrace.c           |   5 +-
 arch/riscv/kernel/signal.c           |   4 +-
 arch/s390/include/asm/entry-common.h |   1 -
 arch/s390/kernel/ptrace.c            |   1 -
 arch/s390/kernel/signal.c            |   5 +-
 arch/sh/kernel/ptrace_32.c           |   5 +-
 arch/sh/kernel/signal_32.c           |   4 +-
 arch/sparc/kernel/ptrace_32.c        |   5 +-
 arch/sparc/kernel/ptrace_64.c        |   5 +-
 arch/sparc/kernel/signal32.c         |   1 -
 arch/sparc/kernel/signal_32.c        |   4 +-
 arch/sparc/kernel/signal_64.c        |   4 +-
 arch/um/kernel/process.c             |   4 +-
 arch/um/kernel/ptrace.c              |   5 +-
 arch/x86/kernel/ptrace.c             |   1 -
 arch/x86/kernel/signal.c             |   5 +-
 arch/x86/mm/tlb.c                    |   1 +
 arch/xtensa/kernel/ptrace.c          |   5 +-
 arch/xtensa/kernel/signal.c          |   4 +-
 block/blk-cgroup.c                   |   2 +-
 fs/coredump.c                        |   1 -
 fs/exec.c                            |   1 -
 fs/io-wq.c                           |   6 +-
 fs/io_uring.c                        |  11 +-
 fs/proc/array.c                      |   1 -
 fs/proc/base.c                       |   1 -
 include/asm-generic/syscall.h        |   2 +-
 include/linux/entry-common.h         |  47 +-------
 include/linux/entry-kvm.h            |   2 +-
 include/linux/posix-timers.h         |   1 -
 include/linux/ptrace.h               |  78 ++++++++++++
 include/linux/resume_user_mode.h     |  64 ++++++++++
 include/linux/sched/signal.h         |  17 +++
 include/linux/task_work.h            |   5 +
 include/linux/tracehook.h            | 226 -----------------------------------
 include/uapi/linux/ptrace.h          |   2 +-
 kernel/entry/common.c                |  19 +--
 kernel/entry/kvm.c                   |   9 +-
 kernel/exit.c                        |   3 +-
 kernel/livepatch/transition.c        |   1 -
 kernel/seccomp.c                     |   1 -
 kernel/signal.c                      |  23 ++--
 kernel/task_work.c                   |   4 +-
 kernel/time/posix-cpu-timers.c       |   1 +
 mm/memcontrol.c                      |   2 +-
 security/apparmor/domain.c           |   1 -
 security/selinux/hooks.c             |   1 -
 84 files changed, 317 insertions(+), 462 deletions(-)

Eric

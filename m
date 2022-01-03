Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD92B483858
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiACVad (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:30:33 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55092 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiACVac (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:30:32 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:46186)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4UuV-008vwj-F0; Mon, 03 Jan 2022 14:30:31 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54250 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4UuU-003e4L-EZ; Mon, 03 Jan 2022 14:30:31 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, <linux-api@vger.kernel.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
Date:   Mon, 03 Jan 2022 15:30:02 -0600
In-Reply-To: <87bl1kunjj.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 13 Dec 2021 16:50:56 -0600")
Message-ID: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n4UuU-003e4L-EZ;;;mid=<87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/aA+IzElaQd+v65+nv0IBGxtz3edHDQoA=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 412 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.8 (1.2%), b_tie_ro: 3.3 (0.8%), parse: 1.12
        (0.3%), extract_message_metadata: 4.9 (1.2%), get_uri_detail_list: 2.6
        (0.6%), tests_pri_-1000: 3.2 (0.8%), tests_pri_-950: 1.13 (0.3%),
        tests_pri_-900: 0.90 (0.2%), tests_pri_-90: 56 (13.6%), check_bayes:
        55 (13.3%), b_tokenize: 7 (1.6%), b_tok_get_all: 9 (2.2%),
        b_comp_prob: 2.2 (0.5%), b_tok_touch_all: 34 (8.2%), b_finish: 0.74
        (0.2%), tests_pri_0: 327 (79.2%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 2.4 (0.6%), poll_dns_idle: 1.04 (0.3%), tests_pri_10:
        1.70 (0.4%), tests_pri_500: 5 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 00/17] exit: Making task exiting a first class concept
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


The changes below contain some cleanups and the work to make implement
first class asynchronous task exit.  Most of the cleanups are necessary
for this work but a couple of them (removing profile_task_exit and the
extra setting of PT_SEIZED in ptrace_attach) are included because I
stumbled over them and they are worth applying but they aren't
interesting enough to me to make be in their own patchset.

The core of this set of changes is the addition of
schedule_task_exit_locked.  Ptrace is cleaned up to avoid a conflict in
task->exit_code.  Then the existing task exit code is gradually moved
into the final shape of schedule_task_exit_locked.

This is the fundamental building block I need to fix alpha, m68k,
nios2 and any other architecture that does not always save all of
their registers except when entering into a ptrace context.

This is about half the work to allow coredump signals to use
short-circuit delivery.

With coredumps signals available for short-circuit delivery the
SA_IMMUTABLE hack can be replace by something clean.

The counting of the number of threads that have not been killed to
always set SIGNAL_GROUP_EXIT when a process exits and the coredump
signal short-circuit delivery is a foundation for updating the
SECCOMP_RET_KILL_THREAD implementation such that it can decide if it
should coredump without races.

I have most of those changes pretty much ready I just need to get these
changes finalized reviewed first.  At this point they are looking at
v5.18 material.

These patches are on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/ signal-for-v5.17

After these patches have been reviewed it is my plan to apply them to my
signal-for-v5.17 branch.  Any and all feedback is welcome.

Eric W. Biederman (17):
      exit: Remove profile_task_exit & profile_munmap
      exit: Coredumps reach do_group_exit
      exit: Fix the exit_code for wait_task_zombie
      exit: Use the correct exit_code in /proc/<pid>/stat
      taskstats: Cleanup the use of task->exit_code
      ptrace: Remove second setting of PT_SEIZED in ptrace_attach
      ptrace: Remove unused regs argument from ptrace_report_syscall
      ptrace/m68k: Stop open coding ptrace_report_syscall
      ptrace: Move setting/clearing ptrace_message into prace_stop
      ptrace: Return the signal to continue with from ptrace_stop
      ptrace: Separate task->ptrace_code out from task->exit_code
      signal: Compute the process exit_code in get_signal
      signal: Make individual tasks exiting a first class concept
      signal: Remove zap_other_threads
      signal: Add JOBCTL_WILL_EXIT to mark exiting tasks
      signal: Record the exit_code when an exit is scheduled
      signal: Always set SIGNAL_GROUP_EXIT on process exit

 arch/m68k/kernel/ptrace.c    |  12 +----
 fs/coredump.c                |  17 +++---
 fs/exec.c                    |  12 +++--
 fs/proc/array.c              |   9 +++-
 include/linux/profile.h      |  26 ---------
 include/linux/ptrace.h       |   5 +-
 include/linux/sched.h        |   1 +
 include/linux/sched/jobctl.h |   2 +
 include/linux/sched/signal.h |   6 ++-
 include/linux/tracehook.h    |  21 ++++----
 kernel/exit.c                |  29 +++++-----
 kernel/fork.c                |   2 +
 kernel/profile.c             |  50 ------------------
 kernel/ptrace.c              |  14 +++--
 kernel/signal.c              | 122 +++++++++++++++++++++++--------------------
 kernel/tsacct.c              |   7 ++-
 mm/mmap.c                    |   1 -
 17 files changed, 134 insertions(+), 202 deletions(-)


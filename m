Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F24DB62766
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2019 19:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfGHRkb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Jul 2019 13:40:31 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48333 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbfGHRkb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jul 2019 13:40:31 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hkXcq-0003nl-RL; Mon, 08 Jul 2019 11:40:28 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hkXcp-0003jJ-P0; Mon, 08 Jul 2019 11:40:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        <linux-arch@vger.kernel.org>
Date:   Mon, 08 Jul 2019 12:40:05 -0500
Message-ID: <87v9wcl91m.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hkXcp-0003jJ-P0;;;mid=<87v9wcl91m.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ep3e4WNamFJQGEhYFLaK+V+CRG6aa5Ps=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_XMDrugObfuBody_08,XMSubLong,XMSubMetaSxObfu_03,
        XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 669 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (0.4%), b_tie_ro: 1.65 (0.2%), parse: 0.92
        (0.1%), extract_message_metadata: 6 (0.9%), get_uri_detail_list: 4.3
        (0.6%), tests_pri_-1000: 3.6 (0.5%), tests_pri_-950: 1.21 (0.2%),
        tests_pri_-900: 0.98 (0.1%), tests_pri_-90: 44 (6.5%), check_bayes: 42
        (6.3%), b_tokenize: 18 (2.7%), b_tok_get_all: 12 (1.8%), b_comp_prob:
        2.8 (0.4%), b_tok_touch_all: 6 (0.9%), b_finish: 1.55 (0.2%),
        tests_pri_0: 591 (88.4%), check_dkim_signature: 0.67 (0.1%),
        check_dkim_adsp: 2.6 (0.4%), poll_dns_idle: 0.88 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 9 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] signal: Removing the task parameter from force_sig
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Linus,

Please pull the siginfo-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

   HEAD: 318759b4737c3b3789e2fd64d539f437d52386f5 signal/x86: Move tsk inside of CONFIG_MEMORY_FAILURE in do_sigbus

A source of error over the years has been that force_sig has taken a
task parameter when it is only safe to use force_sig with the current
task. The force_sig function is built for delivering synchronous signals
such as SIGSEGV where the userspace application caused a synchronous
fault (such as a page fault) and the kernel responded with a signal.

Because the name force_sig does not make this clear, and because the
force_sig takes a task parameter the function force_sig has been
abused for sending other kinds of signals over the years.  Slowly those
have been fixed when the oopses have been tracked down.

This set of changes fixes the remaining abusers of force_sig and
carefully rips out the task parameter from force_sig and friends making
this kind of error almost impossible in the future.

Eric W. Biederman (27):
      signal/usb: Replace kill_pid_info_as_cred with kill_pid_usb_asyncio
      signal: Correct namespace fixups of si_pid and si_uid
      signal/arm64: Use force_sig not force_sig_fault for SIGKILL
      signal/drbd: Use send_sig not force_sig
      signal/bpfilter: Fix bpfilter_kernl to use send_sig not force_sig
      signal/pid_namespace: Fix reboot_pid_ns to use send_sig not force_sig
      signal/cifs: Fix cifs_put_tcp_session to call send_sig instead of force_sig
      signal: Remove task parameter from force_sigsegv
      signal: Remove task parameter from force_sig
      signal: Remove task parameter from force_sig_mceerr
      signal/x86: Remove task parameter from send_sigtrap
      signal/um: Remove task parameter from send_sigtrap
      signal/sh: Remove tsk parameter from force_sig_info_fault
      signal/riscv: Remove tsk parameter from do_trap
      signal/nds32: Remove tsk parameter from send_sigtrap
      signal/arm: Remove tsk parameter from ptrace_break
      signal/arm: Remove tsk parameter from __do_user_fault
      signal/unicore32: Remove tsk parameter from __do_user_fault
      signal: Explicitly call force_sig_fault on current
      signal: Use force_sig_fault_to_task for the two calls that don't deliver to current
      signal: Remove the task parameter from force_sig_fault
      signal: Properly set TRACE_SIGNAL_LOSE_INFO in __send_signal
      signal: Move the computation of force into send_signal and correct it.
      signal: Generate the siginfo in force_sig
      signal: Factor force_sig_info_to_task out of force_sig_info
      signal: Remove the signal number and task parameters from force_sig_info
      signal/x86: Move tsk inside of CONFIG_MEMORY_FAILURE in do_sigbus

 arch/alpha/kernel/signal.c                |   4 +-
 arch/alpha/kernel/traps.c                 |   2 +-
 arch/alpha/mm/fault.c                     |   4 +-
 arch/arc/kernel/process.c                 |   4 +-
 arch/arc/kernel/signal.c                  |   2 +-
 arch/arc/kernel/traps.c                   |   2 +-
 arch/arc/mm/fault.c                       |   4 +-
 arch/arm/include/asm/traps.h              |   2 +-
 arch/arm/kernel/ptrace.c                  |   6 +-
 arch/arm/kernel/signal.c                  |   4 +-
 arch/arm/kernel/traps.c                   |   4 +-
 arch/arm/mm/alignment.c                   |   2 +-
 arch/arm/mm/fault.c                       |  13 +-
 arch/arm64/kernel/traps.c                 |   7 +-
 arch/c6x/kernel/signal.c                  |   2 +-
 arch/c6x/kernel/traps.c                   |   2 +-
 arch/csky/abiv1/alignment.c               |   2 +-
 arch/csky/abiv2/fpu.c                     |   2 +-
 arch/csky/kernel/signal.c                 |   4 +-
 arch/csky/kernel/traps.c                  |   2 +-
 arch/csky/mm/fault.c                      |   4 +-
 arch/h8300/kernel/ptrace_h.c              |   4 +-
 arch/h8300/kernel/ptrace_s.c              |   2 +-
 arch/h8300/kernel/signal.c                |   2 +-
 arch/hexagon/kernel/signal.c              |   2 +-
 arch/hexagon/kernel/traps.c               |  12 +-
 arch/hexagon/mm/vm_fault.c                |   4 +-
 arch/ia64/kernel/brl_emu.c                |   6 +-
 arch/ia64/kernel/signal.c                 |   8 +-
 arch/ia64/kernel/traps.c                  |  24 +--
 arch/ia64/kernel/unaligned.c              |   2 +-
 arch/ia64/mm/fault.c                      |   2 +-
 arch/m68k/kernel/signal.c                 |   4 +-
 arch/m68k/kernel/traps.c                  |  20 +--
 arch/m68k/mm/fault.c                      |   4 +-
 arch/microblaze/kernel/exceptions.c       |   2 +-
 arch/microblaze/kernel/signal.c           |   2 +-
 arch/microblaze/mm/fault.c                |   2 +-
 arch/mips/kernel/branch.c                 |  18 +--
 arch/mips/kernel/kprobes.c                |   2 +-
 arch/mips/kernel/signal.c                 |   8 +-
 arch/mips/kernel/signal_n32.c             |   4 +-
 arch/mips/kernel/signal_o32.c             |   8 +-
 arch/mips/kernel/traps.c                  |  50 +++---
 arch/mips/kernel/unaligned.c              |  20 +--
 arch/mips/mm/fault.c                      |   4 +-
 arch/mips/sgi-ip22/ip22-berr.c            |   2 +-
 arch/mips/sgi-ip22/ip28-berr.c            |   2 +-
 arch/mips/sgi-ip27/ip27-berr.c            |   2 +-
 arch/mips/sgi-ip32/ip32-berr.c            |   2 +-
 arch/nds32/kernel/fpu.c                   |   2 +-
 arch/nds32/kernel/signal.c                |   2 +-
 arch/nds32/kernel/traps.c                 |  17 +-
 arch/nds32/mm/fault.c                     |   4 +-
 arch/nios2/kernel/signal.c                |   4 +-
 arch/nios2/kernel/traps.c                 |   2 +-
 arch/openrisc/kernel/signal.c             |   2 +-
 arch/openrisc/kernel/traps.c              |  12 +-
 arch/openrisc/mm/fault.c                  |   4 +-
 arch/parisc/kernel/ptrace.c               |   6 +-
 arch/parisc/kernel/signal.c               |   2 +-
 arch/parisc/kernel/traps.c                |  14 +-
 arch/parisc/kernel/unaligned.c            |   4 +-
 arch/parisc/math-emu/driver.c             |   2 +-
 arch/parisc/mm/fault.c                    |   4 +-
 arch/powerpc/kernel/process.c             |   2 +-
 arch/powerpc/kernel/signal_32.c           |   6 +-
 arch/powerpc/kernel/signal_64.c           |   2 +-
 arch/powerpc/kernel/traps.c               |   4 +-
 arch/powerpc/mm/fault.c                   |   5 +-
 arch/powerpc/platforms/cell/spufs/fault.c |   9 +-
 arch/powerpc/platforms/cell/spufs/run.c   |   2 +-
 arch/riscv/include/asm/bug.h              |   2 +-
 arch/riscv/kernel/signal.c                |   2 +-
 arch/riscv/kernel/traps.c                 |  11 +-
 arch/riscv/mm/fault.c                     |   6 +-
 arch/s390/kernel/compat_signal.c          |   4 +-
 arch/s390/kernel/signal.c                 |   4 +-
 arch/s390/kernel/traps.c                  |   6 +-
 arch/s390/mm/fault.c                      |   6 +-
 arch/sh/kernel/cpu/sh2a/fpu.c             |   2 +-
 arch/sh/kernel/cpu/sh4/fpu.c              |   2 +-
 arch/sh/kernel/cpu/sh5/fpu.c              |   4 +-
 arch/sh/kernel/hw_breakpoint.c            |   2 +-
 arch/sh/kernel/ptrace_64.c                |   4 +-
 arch/sh/kernel/signal_32.c                |   4 +-
 arch/sh/kernel/signal_64.c                |   4 +-
 arch/sh/kernel/traps.c                    |   4 +-
 arch/sh/kernel/traps_32.c                 |  12 +-
 arch/sh/kernel/traps_64.c                 |   2 +-
 arch/sh/math-emu/math.c                   |   2 +-
 arch/sh/mm/fault.c                        |  11 +-
 arch/sparc/kernel/process_64.c            |   4 +-
 arch/sparc/kernel/signal32.c              |   8 +-
 arch/sparc/kernel/signal_32.c             |   4 +-
 arch/sparc/kernel/signal_64.c             |   8 +-
 arch/sparc/kernel/sys_sparc_32.c          |   2 +-
 arch/sparc/kernel/sys_sparc_64.c          |   2 +-
 arch/sparc/kernel/traps_32.c              |   4 +-
 arch/sparc/kernel/traps_64.c              |  41 +++--
 arch/sparc/mm/fault_32.c                  |   4 +-
 arch/sparc/mm/fault_64.c                  |   2 +-
 arch/um/kernel/exec.c                     |   2 +-
 arch/um/kernel/ptrace.c                   |   7 +-
 arch/um/kernel/skas/mmu.c                 |   2 +-
 arch/um/kernel/tlb.c                      |   4 +-
 arch/um/kernel/trap.c                     |  16 +-
 arch/unicore32/kernel/signal.c            |   4 +-
 arch/unicore32/kernel/traps.c             |   2 +-
 arch/unicore32/mm/fault.c                 |  13 +-
 arch/x86/entry/vsyscall/vsyscall_64.c     |   4 +-
 arch/x86/include/asm/ptrace.h             |   3 +-
 arch/x86/kernel/cpu/mce/core.c            |   2 +-
 arch/x86/kernel/ptrace.c                  |   9 +-
 arch/x86/kernel/signal.c                  |   2 +-
 arch/x86/kernel/traps.c                   |  10 +-
 arch/x86/kernel/umip.c                    |   2 +-
 arch/x86/kernel/uprobes.c                 |   2 +-
 arch/x86/kernel/vm86_32.c                 |   2 +-
 arch/x86/mm/fault.c                       |  12 +-
 arch/x86/mm/mpx.c                         |   2 +-
 arch/x86/um/signal.c                      |   4 +-
 arch/xtensa/kernel/signal.c               |   2 +-
 arch/xtensa/kernel/traps.c                |   8 +-
 arch/xtensa/mm/fault.c                    |   4 +-
 drivers/block/drbd/drbd_int.h             |   2 +-
 drivers/block/drbd/drbd_main.c            |   2 +-
 drivers/block/drbd/drbd_nl.c              |   2 +-
 drivers/misc/lkdtm/bugs.c                 |   2 +-
 drivers/usb/core/devio.c                  |  48 +++---
 fs/cifs/connect.c                         |   2 +-
 fs/exec.c                                 |   2 +-
 include/linux/ptrace.h                    |   2 +-
 include/linux/sched/signal.h              |  15 +-
 include/linux/syscalls.h                  |   2 +-
 kernel/events/uprobes.c                   |   4 +-
 kernel/pid_namespace.c                    |   2 +-
 kernel/rseq.c                             |   4 +-
 kernel/seccomp.c                          |   2 +-
 kernel/signal.c                           | 249 +++++++++++++++++++++---------
 mm/memory-failure.c                       |   2 +-
 net/bpfilter/bpfilter_kern.c              |   2 +-
 security/safesetid/lsm.c                  |   4 +-
 143 files changed, 569 insertions(+), 483 deletions(-)

Eric

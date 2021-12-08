Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883B346DCE3
	for <lists+linux-arch@lfdr.de>; Wed,  8 Dec 2021 21:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbhLHUVn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Dec 2021 15:21:43 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:38324 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhLHUVm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:21:42 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:51438)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3OC-00GZa0-On; Wed, 08 Dec 2021 13:18:08 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39158 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3O9-007SGF-QD; Wed, 08 Dec 2021 13:18:08 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Wed, 08 Dec 2021 14:17:22 -0600
Message-ID: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mv3O9-007SGF-QD;;;mid=<87a6ha4zsd.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+3FWH/ytp2ZJTTsaTvzANvNSYQqitFkJE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1104 ms - load_scoreonly_sql: 0.18 (0.0%),
        signal_user_changed: 13 (1.2%), b_tie_ro: 11 (1.0%), parse: 1.93
        (0.2%), extract_message_metadata: 9 (0.8%), get_uri_detail_list: 4.6
        (0.4%), tests_pri_-1000: 7 (0.6%), tests_pri_-950: 2.1 (0.2%),
        tests_pri_-900: 1.59 (0.1%), tests_pri_-90: 125 (11.3%), check_bayes:
        122 (11.1%), b_tokenize: 21 (1.9%), b_tok_get_all: 12 (1.1%),
        b_comp_prob: 5 (0.5%), b_tok_touch_all: 79 (7.1%), b_finish: 1.07
        (0.1%), tests_pri_0: 909 (82.4%), check_dkim_signature: 0.99 (0.1%),
        check_dkim_adsp: 3.6 (0.3%), poll_dns_idle: 0.90 (0.1%), tests_pri_10:
        3.5 (0.3%), tests_pri_500: 17 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 00/10] Removal of most do_exit calls
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


We have a lot of calls to do_exit that really don't want the semantics
of userspace calling pthread_exit, aka exit(2).  Instead the interesting
semantics are those of the current task exiting.

This set of changes removes a dead reference to do_exit on s390,
adds a function make_task_dead and changes all of the oops
implementations to use it, and adds function kthread_exit and
changes all of the kthread exits to use it.

The short term win of this set of changes is being able to move many
sanity checks out of do_exit that are only really interesting during an
oops.  Making it easier to see what do_exit is actually doing.

After this set of changes the number there are only about a big screen
full of do_exit calls left.  Making future changes much easier to
review.

s390 folks.  Can you please verify I read the s390 code correctly when
observing the reference to do_exit really is dead?  I would really
appreciate it.  I am not very familiar with s390.

This is on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/ signal-for-v5.17

It is my plan that after these changes are reviewed to apply these
changes into my signal-for-v5.17 branch.  After that I can get to
cleaning up where signals, coredumps and the exit code meets.

Eric W. Biederman (10):
      exit/s390: Remove dead reference to do_exit from copy_thread
      exit: Add and use make_task_dead.
      exit: Move oops specific logic from do_exit into make_task_dead
      exit: Stop poorly open coding do_task_dead in make_task_dead
      exit: Stop exporting do_exit
      exit: Implement kthread_exit
      exit: Rename module_put_and_exit to module_put_and_kthread_exit
      exit: Rename complete_and_exit to kthread_complete_and_exit
      kthread: Ensure struct kthread is present for all kthreads
      exit/kthread: Move the exit code for kernel threads into struct kthread

 arch/alpha/kernel/traps.c                    |  6 +-
 arch/alpha/mm/fault.c                        |  2 +-
 arch/arm/kernel/traps.c                      |  2 +-
 arch/arm/mm/fault.c                          |  2 +-
 arch/arm64/kernel/traps.c                    |  2 +-
 arch/arm64/mm/fault.c                        |  2 +-
 arch/csky/abiv1/alignment.c                  |  2 +-
 arch/csky/kernel/traps.c                     |  2 +-
 arch/csky/mm/fault.c                         |  2 +-
 arch/h8300/kernel/traps.c                    |  2 +-
 arch/h8300/mm/fault.c                        |  2 +-
 arch/hexagon/kernel/traps.c                  |  2 +-
 arch/ia64/kernel/mca_drv.c                   |  2 +-
 arch/ia64/kernel/traps.c                     |  2 +-
 arch/ia64/mm/fault.c                         |  2 +-
 arch/m68k/kernel/traps.c                     |  2 +-
 arch/m68k/mm/fault.c                         |  2 +-
 arch/microblaze/kernel/exceptions.c          |  4 +-
 arch/mips/kernel/traps.c                     |  2 +-
 arch/nds32/kernel/fpu.c                      |  2 +-
 arch/nds32/kernel/traps.c                    |  8 +--
 arch/nios2/kernel/traps.c                    |  4 +-
 arch/openrisc/kernel/traps.c                 |  2 +-
 arch/parisc/kernel/traps.c                   |  2 +-
 arch/powerpc/kernel/traps.c                  |  8 +--
 arch/riscv/kernel/traps.c                    |  2 +-
 arch/riscv/mm/fault.c                        |  2 +-
 arch/s390/kernel/dumpstack.c                 |  2 +-
 arch/s390/kernel/nmi.c                       |  2 +-
 arch/s390/kernel/process.c                   |  1 -
 arch/sh/kernel/traps.c                       |  2 +-
 arch/sparc/kernel/traps_32.c                 |  4 +-
 arch/sparc/kernel/traps_64.c                 |  4 +-
 arch/x86/entry/entry_32.S                    |  6 +-
 arch/x86/entry/entry_64.S                    |  6 +-
 arch/x86/kernel/dumpstack.c                  |  4 +-
 arch/xtensa/kernel/traps.c                   |  2 +-
 crypto/algboss.c                             |  4 +-
 drivers/net/wireless/rsi/rsi_91x_coex.c      |  2 +-
 drivers/net/wireless/rsi/rsi_91x_main.c      |  2 +-
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c  |  2 +-
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c   |  2 +-
 drivers/pnp/pnpbios/core.c                   |  6 +-
 drivers/staging/rts5208/rtsx.c               | 16 ++---
 drivers/usb/atm/usbatm.c                     |  2 +-
 drivers/usb/gadget/function/f_mass_storage.c |  2 +-
 fs/cifs/connect.c                            |  2 +-
 fs/exec.c                                    |  2 +
 fs/jffs2/background.c                        |  2 +-
 fs/nfs/callback.c                            |  4 +-
 fs/nfs/nfs4state.c                           |  2 +-
 fs/nfsd/nfssvc.c                             |  2 +-
 include/linux/kernel.h                       |  1 -
 include/linux/kthread.h                      |  4 +-
 include/linux/module.h                       |  6 +-
 include/linux/sched/task.h                   |  1 +
 kernel/exit.c                                | 88 ++++++++++++++--------------
 kernel/fork.c                                |  4 ++
 kernel/futex/core.c                          |  2 +-
 kernel/kexec_core.c                          |  2 +-
 kernel/kthread.c                             | 78 +++++++++++++++++-------
 kernel/module.c                              |  6 +-
 kernel/sched/core.c                          | 16 ++---
 lib/kunit/try-catch.c                        |  4 +-
 net/bluetooth/bnep/core.c                    |  2 +-
 net/bluetooth/cmtp/core.c                    |  2 +-
 net/bluetooth/hidp/core.c                    |  2 +-
 tools/objtool/check.c                        |  8 ++-
 68 files changed, 212 insertions(+), 173 deletions(-)

Eric

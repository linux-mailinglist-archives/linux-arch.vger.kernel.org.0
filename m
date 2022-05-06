Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3436351DBBB
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 17:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442734AbiEFPT6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 11:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347956AbiEFPT5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 11:19:57 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8031A66203;
        Fri,  6 May 2022 08:16:13 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:52514)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmygm-009mY8-CM; Fri, 06 May 2022 08:12:12 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37200 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmygj-007Bpk-Tg; Fri, 06 May 2022 08:12:11 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     <linux-arch@vger.kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
References: <CANpfEhOnNZa5d_G3e0dzzbbEtSuqxWY-fUCqzSiFpiQ2k0hJyw@mail.gmail.com>
        <CAHk-=wjfecvcUk2vNQM1GiUz_G=WQEJ8i8JS7yjnxjq_f-OgKw@mail.gmail.com>
        <87a6czifo7.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wj=EHvH-DEUHbkoB3vDZJ1xRzrk44JibtNOepNkachxPw@mail.gmail.com>
        <87ilrn1drx.ffs@tglx> <877d7zk1cf.ffs@tglx>
        <CAHk-=wiJPeANKYU4imYaeEuV6sNP+EDR=rWURSKv=y4Mhcn1hA@mail.gmail.com>
        <87y20fid4d.ffs@tglx>
        <87bkx5q3pk.fsf_-_@email.froward.int.ebiederm.org>
Date:   Fri, 06 May 2022 09:11:36 -0500
In-Reply-To: <87bkx5q3pk.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 12 Apr 2022 18:31:03 -0500")
Message-ID: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nmygj-007Bpk-Tg;;;mid=<87mtfu4up3.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19t4gV9Zdd4oP1qG3l/gRiLHnzIm5vjIGg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;<linux-arch@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1843 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 13 (0.7%), b_tie_ro: 11 (0.6%), parse: 1.21
        (0.1%), extract_message_metadata: 4.4 (0.2%), get_uri_detail_list:
        1.57 (0.1%), tests_pri_-1000: 7 (0.4%), tests_pri_-950: 1.86 (0.1%),
        tests_pri_-900: 1.71 (0.1%), tests_pri_-90: 503 (27.3%), check_bayes:
        501 (27.2%), b_tokenize: 9 (0.5%), b_tok_get_all: 9 (0.5%),
        b_comp_prob: 2.8 (0.2%), b_tok_touch_all: 475 (25.8%), b_finish: 1.22
        (0.1%), tests_pri_0: 1290 (70.0%), check_dkim_signature: 0.69 (0.0%),
        check_dkim_adsp: 3.1 (0.2%), poll_dns_idle: 1.08 (0.1%), tests_pri_10:
        2.4 (0.1%), tests_pri_500: 8 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/7] fork: Make init and umh ordinary tasks
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


In commit 40966e316f86 ("kthread: Ensure struct kthread is present for
all kthreads") caused init and the user mode helper threads that call
kernel_execve to have struct kthread allocated for them.

I believe my first patch in this series is enough to fix the bug
and is simple enough and obvious enough to be backportable.

The rest of the changes pass struct kernel_clone_args to clean things
up and cause the code to make sense.

There is one rough spot in this change.  In the init process before the
user space init process is exec'd there is a lot going on.  I have found
when async_schedule_domain is low on memory or has more than 32K callers
executing do_populate_rootfs will now run in a user space thread making
flush_delayed_fput meaningless, and __fput_sync is unusable.  I solved
this as I did in usermode_driver.c with an added explicit task_work_run.
I point this out as I have seen some talk about making flushing file
handles more explicit.

Eric W. Biederman (7):
      kthread: Don't allocate kthread_struct for init and umh
      fork: Pass struct kernel_clone_args into copy_thread
      fork: Explicity test for idle tasks in copy_thread
      fork: Generalize PF_IO_WORKER handling
      init: Deal with the init process being a user mode process
      fork: Explicitly set PF_KTHREAD
      fork: Stop allowing kthreads to call execve

 arch/alpha/kernel/process.c      | 13 ++++++------
 arch/arc/kernel/process.c        | 13 ++++++------
 arch/arm/kernel/process.c        | 12 ++++++-----
 arch/arm64/kernel/process.c      | 12 ++++++-----
 arch/csky/kernel/process.c       | 15 ++++++-------
 arch/h8300/kernel/process.c      | 10 ++++-----
 arch/hexagon/kernel/process.c    | 12 ++++++-----
 arch/ia64/kernel/process.c       | 15 +++++++------
 arch/m68k/kernel/process.c       | 12 ++++++-----
 arch/microblaze/kernel/process.c | 12 ++++++-----
 arch/mips/kernel/process.c       | 13 ++++++------
 arch/nios2/kernel/process.c      | 12 ++++++-----
 arch/openrisc/kernel/process.c   | 12 ++++++-----
 arch/parisc/kernel/process.c     | 18 +++++++++-------
 arch/powerpc/kernel/process.c    | 15 +++++++------
 arch/riscv/kernel/process.c      | 12 ++++++-----
 arch/s390/kernel/process.c       | 12 ++++++-----
 arch/sh/kernel/process_32.c      | 12 ++++++-----
 arch/sparc/kernel/process_32.c   | 12 ++++++-----
 arch/sparc/kernel/process_64.c   | 12 ++++++-----
 arch/um/kernel/process.c         | 15 +++++++------
 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/include/asm/switch_to.h |  8 +++----
 arch/x86/kernel/fpu/core.c       |  4 ++--
 arch/x86/kernel/process.c        | 18 +++++++++-------
 arch/xtensa/kernel/process.c     | 17 ++++++++-------
 fs/exec.c                        |  8 ++++---
 include/linux/sched/task.h       |  8 +++++--
 init/initramfs.c                 |  2 ++
 init/main.c                      |  2 +-
 kernel/fork.c                    | 46 +++++++++++++++++++++++++++++++++-------
 kernel/umh.c                     |  6 +++---
 32 files changed, 233 insertions(+), 159 deletions(-)

Eric

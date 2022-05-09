Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2496B520734
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 23:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiEIV7R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 17:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiEIV7G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 17:59:06 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE441274A01;
        Mon,  9 May 2022 14:53:03 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:60566)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1noBJN-00HXb7-2U; Mon, 09 May 2022 15:53:01 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37562 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1noBJM-009Wa9-0i; Mon, 09 May 2022 15:53:00 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     <linux-arch@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
        <20220509204654.GA200@qian>
Date:   Mon, 09 May 2022 16:52:07 -0500
In-Reply-To: <20220509204654.GA200@qian> (Qian Cai's message of "Mon, 9 May
        2022 16:46:54 -0400")
Message-ID: <87r152xtko.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1noBJM-009Wa9-0i;;;mid=<87r152xtko.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19hk9ZS6WavQatP9fRgufeJVz+cvKHeEus=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Qian Cai <quic_qiancai@quicinc.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 474 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (2.5%), b_tie_ro: 10 (2.1%), parse: 1.02
        (0.2%), extract_message_metadata: 12 (2.6%), get_uri_detail_list: 1.54
        (0.3%), tests_pri_-1000: 14 (2.9%), tests_pri_-950: 1.33 (0.3%),
        tests_pri_-900: 1.00 (0.2%), tests_pri_-90: 90 (18.9%), check_bayes:
        88 (18.6%), b_tokenize: 8 (1.6%), b_tok_get_all: 10 (2.0%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 65 (13.6%), b_finish: 1.01
        (0.2%), tests_pri_0: 321 (67.8%), check_dkim_signature: 0.84 (0.2%),
        check_dkim_adsp: 4.1 (0.9%), poll_dns_idle: 0.87 (0.2%), tests_pri_10:
        2.6 (0.6%), tests_pri_500: 16 (3.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/7] fork: Make init and umh ordinary tasks
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Qian Cai <quic_qiancai@quicinc.com> writes:

> On Fri, May 06, 2022 at 09:11:36AM -0500, Eric W. Biederman wrote:
>> 
>> In commit 40966e316f86 ("kthread: Ensure struct kthread is present for
>> all kthreads") caused init and the user mode helper threads that call
>> kernel_execve to have struct kthread allocated for them.
>> 
>> I believe my first patch in this series is enough to fix the bug
>> and is simple enough and obvious enough to be backportable.
>> 
>> The rest of the changes pass struct kernel_clone_args to clean things
>> up and cause the code to make sense.
>> 
>> There is one rough spot in this change.  In the init process before the
>> user space init process is exec'd there is a lot going on.  I have found
>> when async_schedule_domain is low on memory or has more than 32K callers
>> executing do_populate_rootfs will now run in a user space thread making
>> flush_delayed_fput meaningless, and __fput_sync is unusable.  I solved
>> this as I did in usermode_driver.c with an added explicit task_work_run.
>> I point this out as I have seen some talk about making flushing file
>> handles more explicit.
>
> Reverting the last 3 commits of the series fixed a boot crash.
>
> 1b2552cbdbe0 fork: Stop allowing kthreads to call execve
> 753550eb0ce1 fork: Explicitly set PF_KTHREAD
> 68d85f0a33b0 init: Deal with the init process being a user mode process

Hmm.  It looks like I missed a little detail.

task_tick_fair
  task_tick_numa
    task_scan_start
      task_scan_min
        task_nr_scan_windows
          p->mm

If I read this code right task_tick_numa makes the assumption that only
tasks with PF_KTHREAD set don't have an mm.

This should fix the failure.  For init we could possibly populate .mm
and not just .active_mm.  For user mode helpers cloned from kernel
threads I don't think that is a realistic option.  So I think this
is going to be the proper fix.

I believe this only happens when numa rebalancing happens at an
unfortunate moment.

Qian Cai can you test this?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..db6f0df9d43e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2915,7 +2915,7 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
        /*
         * We don't care about NUMA placement if we don't have memory.
         */
-       if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
+       if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
                return;
 
        /*


Eric

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6A6523BEE
	for <lists+linux-arch@lfdr.de>; Wed, 11 May 2022 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345855AbiEKRxP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 May 2022 13:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345844AbiEKRxJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2022 13:53:09 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA7069287;
        Wed, 11 May 2022 10:53:09 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:50264)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1noqWK-00FvKy-00; Wed, 11 May 2022 11:53:08 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37834 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1noqWI-002gjC-Sf; Wed, 11 May 2022 11:53:07 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CANpfEhOnNZa5d_G3e0dzzbbEtSuqxWY-fUCqzSiFpiQ2k0hJyw@mail.gmail.com>
        <CAHk-=wjfecvcUk2vNQM1GiUz_G=WQEJ8i8JS7yjnxjq_f-OgKw@mail.gmail.com>
        <87a6czifo7.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wj=EHvH-DEUHbkoB3vDZJ1xRzrk44JibtNOepNkachxPw@mail.gmail.com>
        <87ilrn1drx.ffs@tglx> <877d7zk1cf.ffs@tglx>
        <CAHk-=wiJPeANKYU4imYaeEuV6sNP+EDR=rWURSKv=y4Mhcn1hA@mail.gmail.com>
        <87y20fid4d.ffs@tglx>
        <87bkx5q3pk.fsf_-_@email.froward.int.ebiederm.org>
        <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
        <87r150ug1l.fsf_-_@email.froward.int.ebiederm.org>
        <CAHk-=whUy_cuJsVeob4zDnK5sWpE3U2EjVbnR2xobqgx7DOp4g@mail.gmail.com>
Date:   Wed, 11 May 2022 12:53:00 -0500
In-Reply-To: <CAHk-=whUy_cuJsVeob4zDnK5sWpE3U2EjVbnR2xobqgx7DOp4g@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 11 May 2022 10:42:21 -0700")
Message-ID: <87zgjot0qr.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1noqWI-002gjC-Sf;;;mid=<87zgjot0qr.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18EQ7vqdRIMDE/hVc5NAfTQ54XLnjwa7rg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linuxfoundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 509 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (2.4%), b_tie_ro: 11 (2.1%), parse: 1.33
        (0.3%), extract_message_metadata: 22 (4.3%), get_uri_detail_list: 2.7
        (0.5%), tests_pri_-1000: 36 (7.1%), tests_pri_-950: 1.31 (0.3%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 148 (29.1%), check_bayes:
        147 (28.8%), b_tokenize: 8 (1.6%), b_tok_get_all: 9 (1.8%),
        b_comp_prob: 3.1 (0.6%), b_tok_touch_all: 122 (24.0%), b_finish: 1.00
        (0.2%), tests_pri_0: 273 (53.6%), check_dkim_signature: 0.62 (0.1%),
        check_dkim_adsp: 3.0 (0.6%), poll_dns_idle: 1.04 (0.2%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 8 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 8/7] sched: Update task_tick_numa to ignore tasks
 without an mm
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linuxfoundation.org> writes:

 On Wed, May 11, 2022 at 10:37 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> With the change to init and the user mode helper processes to not have
>> PF_KTHREAD set before they call kernel_execve the PF_KTHREAD test in
>> task_tick_numa became insufficient to detect all tasks that have
>> "->mm == NULL".  Correct that by testing for "->mm == NULL" directly.
>
> If you end up rebasing at any time for other reasons (I didn't even
> check if you keep this series in a public git branch), please just
> fold this fix into the original commit, so that we don't have
> unnecessary bisection issues.

I do have it in a public git branch.  The testing in linux-next
is what revealed this.

However it is a topic branch that as far as I know no one depends
on so I should be able to rebase it.

I can rearrange the patches and tweak the description a bit.
Say:

    sched: Update task_tick_numa to ignore tasks without an mm

    With the change to init and the user mode helper processes to not have
    PF_KTHREAD set before they call kernel_execve the PF_KTHREAD test in
    task_tick_numa became insufficient to detect all tasks that have
    "->mm == NULL".  Correct that by testing for "->mm == NULL" directly.

    During testing Qian Cai <quic_qiancai@quicinc.com> found this and wrote:
    > Reverting the last 3 commits of the series fixed a boot crash.
    >
    > 1b2552cbdbe0 fork: Stop allowing kthreads to call execve
    > 753550eb0ce1 fork: Explicitly set PF_KTHREAD
    > 68d85f0a33b0 init: Deal with the init process being a user mode process
    >
    >  BUG: KASAN: null-ptr-deref in task_nr_scan_windows.isra.0
    >  arch_atomic_long_read at ./include/linux/atomic/atomic-long.h:29
    >  (inlined by) atomic_long_read at ./include/linux/atomic/atomic-instrumented.h:1266
    >  (inlined by) get_mm_counter at ./include/linux/mm.h:1996
    >  (inlined by) get_mm_rss at ./include/linux/mm.h:2049
    >  (inlined by) task_nr_scan_windows at kernel/sched/fair.c:1123
    >  Read of size 8 at addr 00000000000003d0 by task swapper/0/1
    
    Reported-by: Qian Cai <quic_qiancai@quicinc.com>
    Tested-by: Qian Cai <quic_qiancai@quicinc.com>
    Link: https://lkml.kernel.org/r/87r150ug1l.fsf_-_@email.froward.int.ebiederm.org
    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Does that sound reasonable?

Eric

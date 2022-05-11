Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731F3523BB3
	for <lists+linux-arch@lfdr.de>; Wed, 11 May 2022 19:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbiEKRho (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 May 2022 13:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiEKRhl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2022 13:37:41 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FAD692AC;
        Wed, 11 May 2022 10:37:40 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:58578)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1noqHJ-006mps-BT; Wed, 11 May 2022 11:37:37 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37816 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1noqHH-001c0M-Bx; Wed, 11 May 2022 11:37:36 -0600
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
        <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
Date:   Wed, 11 May 2022 12:37:10 -0500
In-Reply-To: <87mtfu4up3.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Fri, 06 May 2022 09:11:36 -0500")
Message-ID: <87r150ug1l.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1noqHH-001c0M-Bx;;;mid=<87r150ug1l.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19mmGlUvgKMqbZ/amgfpc+1CZO+CoJffcI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;<linux-arch@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1382 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 13 (0.9%), b_tie_ro: 11 (0.8%), parse: 1.07
        (0.1%), extract_message_metadata: 16 (1.2%), get_uri_detail_list: 1.64
        (0.1%), tests_pri_-1000: 24 (1.7%), tests_pri_-950: 1.29 (0.1%),
        tests_pri_-900: 1.08 (0.1%), tests_pri_-90: 79 (5.7%), check_bayes: 77
        (5.6%), b_tokenize: 10 (0.7%), b_tok_get_all: 9 (0.6%), b_comp_prob:
        2.4 (0.2%), b_tok_touch_all: 52 (3.8%), b_finish: 0.95 (0.1%),
        tests_pri_0: 1230 (89.1%), check_dkim_signature: 0.58 (0.0%),
        check_dkim_adsp: 2.6 (0.2%), poll_dns_idle: 0.80 (0.1%), tests_pri_10:
        3.1 (0.2%), tests_pri_500: 10 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 8/7] sched: Update task_tick_numa to ignore tasks without an mm
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Qian Cai <quic_qiancai@quicinc.com> wrote:
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

With the change to init and the user mode helper processes to not have
PF_KTHREAD set before they call kernel_execve the PF_KTHREAD test in
task_tick_numa became insufficient to detect all tasks that have
"->mm == NULL".  Correct that by testing for "->mm == NULL" directly.

Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Tested-by: Qian Cai <quic_qiancai@quicinc.com>
Fixes: 1b2552cbdbe0 ("fork: Stop allowing kthreads to call execve")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..db6f0df9d43e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2915,7 +2915,7 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	/*
 	 * We don't care about NUMA placement if we don't have memory.
 	 */
-	if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
+	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
 		return;
 
 	/*
-- 
2.35.3


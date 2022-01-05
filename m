Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC7C485BB6
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 23:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245082AbiAEWdc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 17:33:32 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:58600 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245076AbiAEWda (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 17:33:30 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:37110)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5EqW-00Dgtr-Im; Wed, 05 Jan 2022 15:33:28 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:50552 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5EqV-00Bkwt-J2; Wed, 05 Jan 2022 15:33:28 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211208202532.16409-4-ebiederm@xmission.com>
        <YdUzjrLAlRiNLQp2@zeniv-ca.linux.org.uk>
Date:   Wed, 05 Jan 2022 16:33:19 -0600
In-Reply-To: <YdUzjrLAlRiNLQp2@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Wed, 5 Jan 2022 05:58:38 +0000")
Message-ID: <87czl56ceo.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n5EqV-00Bkwt-J2;;;mid=<87czl56ceo.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Yfmn+oTCiK18n1oxnyRtCXguQm/Nklvg=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_B_SpammyWords,XM_Body_Dirty_Words autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 429 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.8 (1.1%), b_tie_ro: 3.3 (0.8%), parse: 1.07
        (0.2%), extract_message_metadata: 11 (2.6%), get_uri_detail_list: 1.74
        (0.4%), tests_pri_-1000: 8 (1.9%), tests_pri_-950: 1.02 (0.2%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 94 (21.9%), check_bayes:
        92 (21.5%), b_tokenize: 5 (1.2%), b_tok_get_all: 7 (1.7%),
        b_comp_prob: 1.72 (0.4%), b_tok_touch_all: 75 (17.4%), b_finish: 0.79
        (0.2%), tests_pri_0: 295 (68.7%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 1.72 (0.4%), poll_dns_idle: 0.37 (0.1%),
        tests_pri_10: 2.7 (0.6%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 04/10] exit: Stop poorly open coding do_task_dead in make_task_dead
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Wed, Dec 08, 2021 at 02:25:26PM -0600, Eric W. Biederman wrote:
>> When the kernel detects it is oops or otherwise force killing a task
>> while it exits the code poorly attempts to permanently stop the task
>> from scheduling.
>> 
>> I say poorly because it is possible for a task in TASK_UINTERRUPTIBLE
>> to be woken up.
>> 
>> As it makes no sense for the task to continue call do_task_dead
>> instead which actually does the work and permanently removes the task
>> from the scheduler.  Guaranteeing the task will never be woken
>> up again.
>
> NAK.  This is not all do_task_dead() leads to - see what finish_task_switch()
> does upon seeing TASK_DEAD:
>                 /* Task is done with its stack. */
> 		put_task_stack(prev);
> 		put_task_struct_rcu_user(prev);
>
>
> Now take a look at the comment just before that check for PF_EXITING -
> the point is to leave the task leaked, rather than proceeding with
> freeing the sucker.
>
> We are not going through the normal "turn zombie" motions, including
> waking wait(2) callers up, etc.  Going ahead and freeing it could
> fuck the things up quite badly.

I believe I was thinking this task won't be reaped because release_task
can never be called.  Which I admit depending on where we oops in
do_exit is not strictly true.

We can guarantee the leak with:
	
	tsk->exit_state = EXIT_DEAD;
        refcount_inc(&tsk->rcu_users);


It just feels wrong to me to have something dead and broken sticking around
the scheduler queue.  Especially as something could come along and wake
it up and then what do we do.

Hmm.  I think we want that tsk->exit_state = EXIT_DEAD regardless to
prevent it from being reaped and possibly causing more harm.

Eric

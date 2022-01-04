Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83A84848C9
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 20:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiADTrP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 14:47:15 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:44996 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiADTrP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 14:47:15 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:37404)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4pm6-00GCPA-4B; Tue, 04 Jan 2022 12:47:14 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:36000 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4pm5-009vcO-0I; Tue, 04 Jan 2022 12:47:13 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211213225350.27481-1-ebiederm@xmission.com>
        <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
Date:   Tue, 04 Jan 2022 13:47:05 -0600
In-Reply-To: <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 4 Jan 2022 10:44:59 -0800")
Message-ID: <87sfu3b7wm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n4pm5-009vcO-0I;;;mid=<87sfu3b7wm.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19/FjqjLqZn3YC2tQG1d74XlOdfVI1K+jo=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 533 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 4.6 (0.9%), b_tie_ro: 3.2 (0.6%), parse: 1.22
        (0.2%), extract_message_metadata: 14 (2.7%), get_uri_detail_list: 3.5
        (0.7%), tests_pri_-1000: 12 (2.2%), tests_pri_-950: 1.08 (0.2%),
        tests_pri_-900: 0.80 (0.2%), tests_pri_-90: 117 (21.9%), check_bayes:
        103 (19.4%), b_tokenize: 7 (1.4%), b_tok_get_all: 8 (1.6%),
        b_comp_prob: 2.2 (0.4%), b_tok_touch_all: 82 (15.4%), b_finish: 0.80
        (0.2%), tests_pri_0: 372 (69.7%), check_dkim_signature: 0.41 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 1.38 (0.3%), tests_pri_10:
        1.84 (0.3%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit special case
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Dec 13, 2021 at 2:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>>
>>         if (signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) {
>> -               if (!(signal->flags & SIGNAL_GROUP_EXIT))
>> -                       return sig == SIGKILL;
>> +               struct core_state *core_state = signal->core_state;
>> +               if (core_state) {
>
> This change is very confusing.
>
> Also, why does it do that 'signal->core_state->dumper.task', when we
> already know that it's the same as 'signal->group_exit_task'?
>
> The only thing that sets 'signal->core_state' also sets
> 'signal->group_exit_task', and the call chain has set both to the same
> task.
>
> So the code is odd and makes little sense.

As you say signal->group_exit_task, and core_state->dumper.task point to
the same task.  So it may be a little silly when viewed independently of
everything else to use core_state->dumper.task instead of
group_exit_task as it is an extra cache line dereference.

The thing is signal->group_exit_task is only used by coredumps currently
as a flag to tell signal_group_exit to return true.  It is exec that
actually uses signal->group_exit_task in conjunction with
signal->notify_count to wake itself up.

Using a pointer as a flag and not for it's value.  Having different
semantics for who sets the pointer.  All of those are weird enough
I just want to make signal->group_exit_task to go away.

By using core_state->dumper.task I was able to make
signal->group_exit_task exclusive to the exec case in the following
changes, and to rename it signal->group_exec_task so no one gets
confused what the field is for.

> But what's even more odd is how it
>
>  (a) sends the SIGKILL to somebody else
>
>  (b) does *NOT* send SIGKILL to itself
>
> Now, (a) is explained in the commit message. The intent is to signal
> the core dumper.

Which is the a specific thread of the target process, and it is
the only thread running of the target process.

> But (b) looks like a fundamental change in semantics. The target of
> the SIGKILL is still running, might be in some loop in the kernel that
> wants to be interrupted by a fatal signal, and you expressly disabled
> the code that would send that fatal signal.
>
> If I send SIGKILL to thread A, then that SIGKILL had *better* be
> delivered. To thread A, which may be in a "mutex_lock_killable()" or
> whatever else.
>
> The fact that thread B may be in the process of trying to dump core
> doesn't change that at all, as far as I can see.
>
> So I think this patch is fundamentally buggy and wrong. Or at least
> needs much more explanation of why you'd not send SIGKILL to the
> target thread.

If you look at zap_threads.  You can observe that it takes the siglock,
sets SIGNAL_GROUP_COREDUMP, and sets signal->core_state and in
zap_process makes SIGKILL pending is the per-task sigset, and calls
signal_wake_up on every task.

This case in prepare_signal happens after that.  After every task
has been told to die, and __fatal_signal_pending is true for all of
them if they have not reached do_exit yet.



If you look in zap_threads you will see that the core dumping thread
clears TIF_SIGPENDING, and in general makes fatal_signal_pending false
for itself.  But keep in mind that this thread because it is dumping
core is already on the path to do_exit.  It has already processed a
fatal signal.


So in the special case I only worry about the dumping task as it is the
only task after zap_threads that does not have fatal_signal_pending.


This is different than the ordinary case of delivering SIGKILL
where complete_signal makes SIGKILL pending in the per-task sigset
of every task in the process.


Currently I suspect changing wait_event_uninterruptible to
wait_event_killable, is causing problems.

Or perhaps there is some reason tasks that have already entered do_exit
need to have fatal_signal_pending set. (The will have
fatal_signal_pending set up until they enter get_signal which calls
do_group_exit which calls do_exit).

Which is why I am trying to reproduce the reported failure so I can get
the kernel to tell me what is going on.  If this is not resolved quickly
I won't send you this change, and I will pull it out of linux-next.

Eric

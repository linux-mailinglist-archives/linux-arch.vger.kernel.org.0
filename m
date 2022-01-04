Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2ED4845DF
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 17:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiADQSq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 4 Jan 2022 11:18:46 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:55430 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiADQSq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 11:18:46 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:52726)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4mWL-00Fnpu-5s; Tue, 04 Jan 2022 09:18:45 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:58676 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4mWJ-005z9S-KR; Tue, 04 Jan 2022 09:18:44 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211213225350.27481-1-ebiederm@xmission.com>
        <9363765f-9883-75ee-70f1-a1a8e9841812@gmail.com>
Date:   Tue, 04 Jan 2022 10:18:01 -0600
In-Reply-To: <9363765f-9883-75ee-70f1-a1a8e9841812@gmail.com> (Dmitry
        Osipenko's message of "Tue, 4 Jan 2022 09:30:45 +0300")
Message-ID: <877dbfmq4m.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1n4mWJ-005z9S-KR;;;mid=<877dbfmq4m.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18wdeeI7dN0yrlO0fUNDYcdfhDQ9Xigdg0=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Dmitry Osipenko <digetx@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 798 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.3 (0.4%), b_tie_ro: 2.2 (0.3%), parse: 1.28
        (0.2%), extract_message_metadata: 15 (1.9%), get_uri_detail_list: 4.1
        (0.5%), tests_pri_-1000: 15 (1.9%), tests_pri_-950: 1.50 (0.2%),
        tests_pri_-900: 1.09 (0.1%), tests_pri_-90: 295 (37.0%), check_bayes:
        293 (36.7%), b_tokenize: 10 (1.2%), b_tok_get_all: 9 (1.1%),
        b_comp_prob: 3.5 (0.4%), b_tok_touch_all: 268 (33.6%), b_finish: 0.79
        (0.1%), tests_pri_0: 454 (56.8%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 2.7 (0.3%), poll_dns_idle: 1.24 (0.2%), tests_pri_10:
        2.3 (0.3%), tests_pri_500: 7 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit special case
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dmitry Osipenko <digetx@gmail.com> writes:

> 14.12.2021 01:53, Eric W. Biederman пишет:
>> Simplify the code that allows SIGKILL during coredumps to terminate
>> the coredump.  As far as I can tell I have avoided breaking it
>> by dumb luck.
>> 
>> Historically with all of the other threads stopping in exit_mm the
>> wants_signal loop in complete_signal would find the dumper task and
>> then complete_signal would wake the dumper task with signal_wake_up.
>> 
>> After moving the coredump_task_exit above the setting of PF_EXITING in
>> commit 92307383082d ("coredump: Don't perform any cleanups before
>> dumping core") wants_signal will consider all of the threads in a
>> multi-threaded process for waking up, not just the core dumping task.
>> 
>> Luckily complete_signal short circuits SIGKILL during a coredump marks
>> every thread with SIGKILL and signal_wake_up.  This code is arguably
>> buggy however as it tries to skip creating a group exit when is already
>> present, and it fails that a coredump is in progress.
>> 
>> Ever since commit 06af8679449d ("coredump: Limit what can interrupt
>> coredumps") was added dump_interrupted needs not just TIF_SIGPENDING
>> set on the dumper task but also SIGKILL set in it's pending bitmap.
>> This means that if the code is ever fixed not to short-circuit and
>> kill a process after it has already been killed the special case
>> for SIGKILL during a coredump will be broken.
>> 
>> Sort all of this out by making the coredump special case more special,
>> and perform all of the work in prepare_signal and leave the rest of
>> the signal delivery path out of it.
>> 
>> In prepare_signal when the process coredumping is sent SIGKILL find
>> the task performing the coredump and use sigaddset and signal_wake_up
>> to ensure that task reports fatal_signal_pending.
>> 
>> Return false from prepare_signal to tell the rest of the signal
>> delivery path to ignore the signal.
>> 
>> Update wait_for_dump_helpers to perform a wait_event_killable wait
>> so that if signal_pending gets set spuriously the wait will not
>> be interrupted unless fatal_signal_pending is true.
>> 
>> I have tested this and verified I did not break SIGKILL during
>> coredumps by accident (before or after this change).  I actually
>> thought I had and I had to figure out what I had misread that kept
>> SIGKILL during coredumps working.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  fs/coredump.c   |  4 ++--
>>  kernel/signal.c | 11 +++++++++--
>>  2 files changed, 11 insertions(+), 4 deletions(-)
>> 
>> diff --git a/fs/coredump.c b/fs/coredump.c
>> index a6b3c196cdef..7b91fb32dbb8 100644
>> --- a/fs/coredump.c
>> +++ b/fs/coredump.c
>> @@ -448,7 +448,7 @@ static void coredump_finish(bool core_dumped)
>>  static bool dump_interrupted(void)
>>  {
>>  	/*
>> -	 * SIGKILL or freezing() interrupt the coredumping. Perhaps we
>> +	 * SIGKILL or freezing() interrupted the coredumping. Perhaps we
>>  	 * can do try_to_freeze() and check __fatal_signal_pending(),
>>  	 * but then we need to teach dump_write() to restart and clear
>>  	 * TIF_SIGPENDING.
>> @@ -471,7 +471,7 @@ static void wait_for_dump_helpers(struct file *file)
>>  	 * We actually want wait_event_freezable() but then we need
>>  	 * to clear TIF_SIGPENDING and improve dump_interrupted().
>>  	 */
>> -	wait_event_interruptible(pipe->rd_wait, pipe->readers == 1);
>> +	wait_event_killable(pipe->rd_wait, pipe->readers == 1);
>>  
>>  	pipe_lock(pipe);
>>  	pipe->readers--;
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 8272cac5f429..7e305a8ec7c2 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -907,8 +907,15 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
>>  	sigset_t flush;
>>  
>>  	if (signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) {
>> -		if (!(signal->flags & SIGNAL_GROUP_EXIT))
>> -			return sig == SIGKILL;
>> +		struct core_state *core_state = signal->core_state;
>> +		if (core_state) {
>> +			if (sig == SIGKILL) {
>> +				struct task_struct *dumper = core_state->dumper.task;
>> +				sigaddset(&dumper->pending.signal, SIGKILL);
>> +				signal_wake_up(dumper, 1);
>> +			}
>> +			return false;
>> +		}
>>  		/*
>>  		 * The process is in the middle of dying, nothing to do.
>>  		 */
>> 
>
> Hi,
>
> This patch breaks userspace, in particular it breaks gst-plugin-scanner
> of GStreamer which hangs now on next-20211224. IIUC, this tool builds a
> registry of good/working GStreamer plugins by loading them and
> blacklisting those that don't work (crash). Before the hang I see
> systemd-coredump process running, taking snapshot of gst-plugin-scanner
> and then gst-plugin-scanner gets stuck.
>
> Bisection points at this patch, reverting it restores
> gst-plugin-scanner. Systemd-coredump still running, but there is no hang
> anymore and everything works properly as before.
>
> I'm seeing this problem on ARM32 and haven't checked other arches.
> Please fix, thanks in advance.

That is weird.

Doubly weird really because this should only change the case where
coredumps are interrupted by SIGKILL.

What distro are you running?  I would like to match things as closely
as I can.  So I can reproduce the issue so I can figure out what
is wrong so I can fix it.

Eric

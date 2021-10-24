Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62AE438A8D
	for <lists+linux-arch@lfdr.de>; Sun, 24 Oct 2021 18:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhJXQJp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Oct 2021 12:09:45 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:39390 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhJXQJo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Oct 2021 12:09:44 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:50350)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1meg1q-0082Pa-1x; Sun, 24 Oct 2021 10:07:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39908 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1meg1o-009w8u-OV; Sun, 24 Oct 2021 10:07:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Andy Lutomirski" <luto@kernel.org>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Al Viro" <viro@ZenIV.linux.org.uk>,
        "Kees Cook" <keescook@chromium.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-10-ebiederm@xmission.com>
        <b5d52d25-7bde-4030-a7b1-7c6f8ab90660@www.fastmail.com>
Date:   Sun, 24 Oct 2021 11:06:55 -0500
In-Reply-To: <b5d52d25-7bde-4030-a7b1-7c6f8ab90660@www.fastmail.com> (Andy
        Lutomirski's message of "Thu, 21 Oct 2021 16:08:58 -0700")
Message-ID: <87sfwqxv8g.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1meg1o-009w8u-OV;;;mid=<87sfwqxv8g.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Ps+bwCgBhsXup+JBYYnsUwQ7W4RmWvV8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels,XMSubLong,XM_B_SpammyWords,
        XM_B_SpammyWords2 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.8 XM_B_SpammyWords2 Two or more commony used spammy words
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;"Andy Lutomirski" <luto@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 690 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 13 (1.8%), b_tie_ro: 11 (1.6%), parse: 1.70
        (0.2%), extract_message_metadata: 36 (5.2%), get_uri_detail_list: 7
        (1.0%), tests_pri_-1000: 45 (6.5%), tests_pri_-950: 1.42 (0.2%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 71 (10.3%), check_bayes:
        69 (10.0%), b_tokenize: 15 (2.1%), b_tok_get_all: 13 (1.9%),
        b_comp_prob: 4.5 (0.7%), b_tok_touch_all: 33 (4.8%), b_finish: 0.87
        (0.1%), tests_pri_0: 497 (72.1%), check_dkim_signature: 0.84 (0.1%),
        check_dkim_adsp: 3.2 (0.5%), poll_dns_idle: 0.47 (0.1%), tests_pri_10:
        4.5 (0.7%), tests_pri_500: 15 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 10/20] signal/vm86_32: Properly send SIGSEGV when the vm86 state cannot be saved.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

"Andy Lutomirski" <luto@kernel.org> writes:

> On Wed, Oct 20, 2021, at 10:43 AM, Eric W. Biederman wrote:
>> Instead of pretending to send SIGSEGV by calling do_exit(SIGSEGV)
>> call force_sigsegv(SIGSEGV) to force the process to take a SIGSEGV
>> and terminate.
>
> Why?  I realize it's more polite, but is this useful enough to justify
> the need for testing and potential security impacts?

The why is that do_exit as an interface needs to be refactored.

As it exists right now "do_exit" is bad enough that on a couple of older
architectures do_exit in a random location results in being able to
read/write the kernel stack using ptrace.

So to addresses the issues I need to get everything that really
shouldn't be using do_exit to use something else.

>> Update handle_signal to return immediately when save_v86_state fails
>> and kills the process.  Returning immediately without doing anything
>> except killing the process with SIGSEGV is also what signal_setup_done
>> does when setup_rt_frame fails.  Plus it is always ok to return
>> immediately without delivering a signal to a userspace handler when a
>> fatal signal has killed the current process.
>>
>
> I can mostly understand the individual sentences, but I don't
> understand what you're getting it.  If a fatal signal has killed the
> current process and we are guaranteed not to hit the exit-to-usermode
> path, then, sure, it's safe to return unless we're worried that the
> core dump code will explode.
>
> But, unless it's fixed elsewhere in your series, force_sigsegv() is
> itself quite racy, or at least looks racy -- it can race against
> another thread calling sigaction() and changing the action to
> something other than SIG_DFL.  So it does not appear to actually
> reliably kill the caller, especially if exposed to a malicious user
> program.

You are correct about the races.  I have changes in the works to make
the races go away but that is not an excuse for push a change that
is buggy without them.



>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: x86@kernel.org
>> Cc: H Peter Anvin <hpa@zytor.com>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  arch/x86/kernel/signal.c  | 6 +++++-
>>  arch/x86/kernel/vm86_32.c | 2 +-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
>> index f4d21e470083..25a230f705c1 100644
>> --- a/arch/x86/kernel/signal.c
>> +++ b/arch/x86/kernel/signal.c
>> @@ -785,8 +785,12 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>>  	bool stepping, failed;
>>  	struct fpu *fpu = &current->thread.fpu;
>> 
>> -	if (v8086_mode(regs))
>> +	if (v8086_mode(regs)) {
>>  		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
>> +		/* Has save_v86_state failed and killed the process? */
>> +		if (fatal_signal_pending(current))
>> +			return;
>
> This might be an ABI break, or at least it could be if anyone cared
> about vm86.  Imagine this wasn't guarded by if (v8086_mode) and was
> just if (fatal_signal_pending(current)) return; Then all the other
> processing gets skipped if a fatal signal is pending (e.g. from a
> concurrent kill), which could cause visible oddities in a core dump, I
> think.  Maybe it's minor.

I believe it is minor, because the test happens before anything is
written to userspace.  The worst case is a signal gets dequeued and
then not written to userspace.

On a second I am not certain this test is even necessary.  Especially
if the change you suggest be made to save_v86_state is made so that
the kernel is out of v86 state and kernel things can safely happen.

>> +	}
>> 
>>  	/* Are we from a system call? */
>>  	if (syscall_get_nr(current, regs) != -1) {
>> diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
>> index 63486da77272..040fd01be8b3 100644
>> --- a/arch/x86/kernel/vm86_32.c
>> +++ b/arch/x86/kernel/vm86_32.c
>> @@ -159,7 +159,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, 
>> int retval)
>>  	user_access_end();
>>  Efault:
>>  	pr_alert("could not access userspace vm86 info\n");
>> -	do_exit(SIGSEGV);
>> +	force_sigsegv(SIGSEGV);
>
> This causes us to run unwitting kernel code with the vm86 garbage
> still loaded into the relevant architectural areas (see the chunk if
> save_v86_state that's inside preempt_disable()).  So NAK, especially
> since the aforementioned race might cause the exit-to-usermode path to
> actually run with who-knows-what consequences.

Fair.  I suspect it might even make the current do_exit call run
with who-knows-what consequence.

> If you really want to make this change, please arrange for
> save_v86_state() to switch out of vm86 mode *before* anything that
> might fail so that it's guaranteed to at least put the task in a sane
> state.  And write an explicit test case that tests it.  I could help
> with the latter if you do the former.

I do really want to remove this do_exit.  If the error was causes by a
kernel malfunction we could do something like die.

As it is the code is effectively hand rolling die/oops for a userspace
caused condition.  Which is quite nasty from a maintenance point of
view.


I think your suggested changes to save_v86_state are much more robust
than my idea of simply calling force_sig... and expecting the kernel
to exit immediately.   Having to go another pass through the
exit_to_usermode_loop does not look like it is very hard to make
it robust against a kernel in a random state.

I could close the race today by replacing the force_sigsegv(SIGSEGV)
with force_sig(SIGKILL).  And that removes the coredump path from
the equation so is a bit interesting, but it really is unsatisfactory.


I will dig in and see what can be done including writing a test so that
this code path gracefully handles -EFAULT rather than tries to walk
through the rest of the kernel in a problematic state.


This change as proposed does not get this save_v86_state case to using
ordinary mechanisms to handle the problem, so as written it does not
solve the problem it set out to solve.

Eric

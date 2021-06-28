Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C0B3B6907
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 21:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbhF1T2R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 15:28:17 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:32802 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhF1T2R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 15:28:17 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lxwtB-0077lT-FQ; Mon, 28 Jun 2021 13:25:49 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39208 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lxwtA-00GC6G-Bf; Mon, 28 Jun 2021 13:25:49 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
        <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        <87a6njf0ia.fsf@disp2133>
        <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
        <87tulpbp19.fsf@disp2133>
        <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
        <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
        <874kdn6q87.fsf_-_@disp2133> <202106252038.389B963B6F@keescook>
Date:   Mon, 28 Jun 2021 14:25:41 -0500
In-Reply-To: <202106252038.389B963B6F@keescook> (Kees Cook's message of "Fri,
        25 Jun 2021 20:42:06 -0700")
Message-ID: <875yxxx03u.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lxwtA-00GC6G-Bf;;;mid=<875yxxx03u.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/8u7v6yaAqNjosMDiG7hIGwsbaE7HP7qs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 563 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (0.7%), b_tie_ro: 2.6 (0.5%), parse: 0.89
        (0.2%), extract_message_metadata: 13 (2.3%), get_uri_detail_list: 2.4
        (0.4%), tests_pri_-1000: 20 (3.6%), tests_pri_-950: 1.02 (0.2%),
        tests_pri_-900: 0.84 (0.1%), tests_pri_-90: 86 (15.3%), check_bayes:
        83 (14.8%), b_tokenize: 10 (1.8%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 2.1 (0.4%), b_tok_touch_all: 58 (10.4%), b_finish: 0.82
        (0.1%), tests_pri_0: 427 (75.8%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 1.73 (0.3%), poll_dns_idle: 0.09 (0.0%),
        tests_pri_10: 1.80 (0.3%), tests_pri_500: 6 (1.0%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 6/9] signal: Fold do_group_exit into get_signal fixing io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Jun 24, 2021 at 02:02:16PM -0500, Eric W. Biederman wrote:
>> 
>> Forld do_group_exit into get_signal as it is the last caller.
>> 
>> Move the group_exit logic above the PF_IO_WORKER exit, ensuring
>> that if an PF_IO_WORKER catches SIGKILL every thread in
>> the thread group will exit not just the the PF_IO_WORKER.
>> 
>> Now that the information is easily available only set PF_SIGNALED
>> when it was a signal that caused the exit.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  include/linux/sched/task.h |  1 -
>>  kernel/exit.c              | 31 -------------------------------
>>  kernel/signal.c            | 35 +++++++++++++++++++++++++----------
>>  3 files changed, 25 insertions(+), 42 deletions(-)
>> 
>> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
>> index ef02be869cf2..45525512e3d0 100644
>> --- a/include/linux/sched/task.h
>> +++ b/include/linux/sched/task.h
>> @@ -77,7 +77,6 @@ static inline void exit_thread(struct task_struct *tsk)
>>  {
>>  }
>>  #endif
>> -extern void do_group_exit(int);
>>  
>>  extern void exit_files(struct task_struct *);
>>  extern void exit_itimers(struct signal_struct *);
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index 921519d80b56..635f434122b7 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -892,37 +892,6 @@ SYSCALL_DEFINE1(exit, int, error_code)
>>  	do_exit((error_code&0xff)<<8);
>>  }
>>  
>> -/*
>> - * Take down every thread in the group.  This is called by fatal signals
>> - * as well as by sys_exit_group (below).
>> - */
>> -void
>> -do_group_exit(int exit_code)
>> -{
>> -	struct signal_struct *sig = current->signal;
>> -
>> -	BUG_ON(exit_code & 0x80); /* core dumps don't get here */
>> -
>> -	if (signal_group_exit(sig))
>> -		exit_code = sig->group_exit_code;
>> -	else if (!thread_group_empty(current)) {
>> -		struct sighand_struct *const sighand = current->sighand;
>> -
>> -		spin_lock_irq(&sighand->siglock);
>> -		if (signal_group_exit(sig))
>> -			/* Another thread got here before we took the lock.  */
>> -			exit_code = sig->group_exit_code;
>> -		else {
>> -			sig->group_exit_code = exit_code;
>> -			sig->flags = SIGNAL_GROUP_EXIT;
>> -			zap_other_threads(current);
>
> Oh, now I see it: the "new code" in start_group_exit() is an open-coded
> zap_other_threads()? That wasn't clear to me, but makes sense now.

Pretty much.  I think zap_other_threads has actually muddied the waters
quite a bit by putting reuse in the wrong place.

>> -		}
>> -		spin_unlock_irq(&sighand->siglock);
>> -	}
>> -
>> -	do_exit(exit_code);
>> -	/* NOTREACHED */
>> -}
>>  
>>  /*
>>   * this kills every thread in the thread group. Note that any externally
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index c79c010ca5f3..95a076af600a 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2646,6 +2646,7 @@ bool get_signal(struct ksignal *ksig)
>>  {
>>  	struct sighand_struct *sighand = current->sighand;
>>  	struct signal_struct *signal = current->signal;
>> +	int exit_code;
>>  	int signr;
>>  
>>  	if (unlikely(current->task_works))
>> @@ -2848,8 +2849,6 @@ bool get_signal(struct ksignal *ksig)
>>  		/*
>>  		 * Anything else is fatal, maybe with a core dump.
>>  		 */
>> -		current->flags |= PF_SIGNALED;
>> -
>>  		if (sig_kernel_coredump(signr)) {
>>  			if (print_fatal_signals)
>>  				print_fatal_signal(ksig->info.si_signo);
>> @@ -2857,14 +2856,33 @@ bool get_signal(struct ksignal *ksig)
>>  			/*
>>  			 * If it was able to dump core, this kills all
>>  			 * other threads in the group and synchronizes with
>> -			 * their demise.  If we lost the race with another
>> -			 * thread getting here, it set group_exit_code
>> -			 * first and our do_group_exit call below will use
>> -			 * that value and ignore the one we pass it.
>> +			 * their demise.  If  another thread makes it
>> +			 * to do_coredump first, it will set group_exit_code
>> +			 * which will be passed to do_exit.
>>  			 */
>>  			do_coredump(&ksig->info);
>>  		}
>>  
>> +		/*
>> +		 * Death signals, no core dump.
>> +		 */
>> +		exit_code = signr;
>> +		if (signal_group_exit(signal)) {
>> +			exit_code = signal->group_exit_code;
>> +		} else {
>> +			spin_lock_irq(&sighand->siglock);
>> +			if (signal_group_exit(signal)) {
>> +				/* Another thread got here before we took the lock.  */
>> +				exit_code = signal->group_exit_code;
>> +			} else {
>> +				start_group_exit_locked(signal, exit_code);
>
> And here's the "if we didn't already do start_group_exit(), do it here".
> And that state is entirely captured via the SIGNAL_GROUP_EXIT flag.
> Cool.

Yes.  At least when the dust clears. 

>> +			}
>> +			spin_unlock_irq(&sighand->siglock);
>> +		}
>> +
>> +		if (exit_code & 0x7f)
>> +			current->flags |= PF_SIGNALED;
>> +
>>  		/*
>>  		 * PF_IO_WORKER threads will catch and exit on fatal signals
>>  		 * themselves. They have cleanup that must be performed, so
>> @@ -2873,10 +2891,7 @@ bool get_signal(struct ksignal *ksig)
>>  		if (current->flags & PF_IO_WORKER)
>>  			goto out;
>>  
>> -		/*
>> -		 * Death signals, no core dump.
>> -		 */
>> -		do_group_exit(ksig->info.si_signo);
>> +		do_exit(exit_code);
>>  		/* NOTREACHED */
>>  	}
>>  	spin_unlock_irq(&sighand->siglock);
>> -- 
>> 2.20.1
>> 

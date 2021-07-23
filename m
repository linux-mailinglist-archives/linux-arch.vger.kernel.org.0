Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E1A3D42E9
	for <lists+linux-arch@lfdr.de>; Sat, 24 Jul 2021 00:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhGWVvT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 17:51:19 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55794 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhGWVvT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jul 2021 17:51:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:34762)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m73hv-0057OP-DB; Fri, 23 Jul 2021 16:31:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:42812 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m73ht-00Fs3L-SP; Fri, 23 Jul 2021 16:31:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
        <87zgunzovm.fsf@disp2133>
        <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
        <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com>
        <8735scvklk.fsf@disp2133>
        <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
        <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com>
        <87h7gopvz2.fsf@disp2133>
        <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com>
        <877dhio13t.fsf@disp2133>
        <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com>
Date:   Fri, 23 Jul 2021 17:31:20 -0500
In-Reply-To: <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com> (Michael
        Schmitz's message of "Fri, 23 Jul 2021 16:23:12 +1200")
Message-ID: <87tukkk6h3.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m73ht-00Fs3L-SP;;;mid=<87tukkk6h3.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19b8fjs0k/xYy08xj9A5jaPmyMDJkJz6II=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,TR_XM_PhishingBody,
        T_TM2_M_HEADER_IN_MSG,XMBrknScrpt_02,XM_B_Phish66,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  2.0 XM_B_Phish66 BODY: Obfuscated XMission
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.4 XMBrknScrpt_02 Possible Broken Spam Script
        *  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michael Schmitz <schmitzmic@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 901 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (1.3%), b_tie_ro: 10 (1.2%), parse: 1.93
        (0.2%), extract_message_metadata: 10 (1.1%), get_uri_detail_list: 6
        (0.7%), tests_pri_-1000: 4.0 (0.4%), tests_pri_-950: 1.37 (0.2%),
        tests_pri_-900: 1.13 (0.1%), tests_pri_-90: 146 (16.2%), check_bayes:
        143 (15.9%), b_tokenize: 19 (2.2%), b_tok_get_all: 26 (2.9%),
        b_comp_prob: 8 (0.9%), b_tok_touch_all: 83 (9.3%), b_finish: 2.2
        (0.2%), tests_pri_0: 697 (77.4%), check_dkim_signature: 1.19 (0.1%),
        check_dkim_adsp: 5.0 (0.6%), poll_dns_idle: 0.69 (0.1%), tests_pri_10:
        2.7 (0.3%), tests_pri_500: 14 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michael Schmitz <schmitzmic@gmail.com> writes:

> Hi Eric,
>
> Am 23.07.2021 um 02:49 schrieb Eric W. Biederman:
>> Michael Schmitz <schmitzmic@gmail.com> writes:
>>
>>> Hi Eric,
>>>
>>> On 21/07/21 8:32 am, Eric W. Biederman wrote:
>>>>
>>>>> diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
>>>>> index a8f4161..6c92d38 100644
>>>>> --- a/arch/m68k/fpsp040/skeleton.S
>>>>> +++ b/arch/m68k/fpsp040/skeleton.S
>>>>> @@ -502,7 +502,17 @@ in_ea:
>>>>>   	.section .fixup,#alloc,#execinstr
>>>>>   	.even
>>>>>   1:
>>>>> +
>>>>> +	SAVE_ALL_INT
>>>>> +	SAVE_SWITCH_STACK
>>>>          ^^^^^^^^^^
>>>>
>>>> I don't think this saves the registers in the well known fixed location
>>>> on the stack because some registers are saved at the exception entry
>>>> point.
>>>
>>> The FPU exception entry points are not using the exception entry code in
>>> head.S. These entry points are stored in the exception vector table directly. No
>>> saving of a syscall stack frame happens there. The FPU places its exception
>>> frame on the stack, and that is what the FPU exception handlers use.
>>>
>>> (If these have to call out to the generic exception handlers again, they will
>>> build a minimal stack frame, see code in skeleton.S.)
>>>
>>> Calling fpsp040_die() is no different from calling a syscall that may need to
>>> have access to the full stack frame. The 'fixed location' is just 'on the stack
>>> before calling  fpsp040_die()', again this is no different from calling
>>> e.g. sys_fork() which does not take a pointer to the begin of the stack frame as
>>> an argument.
>>>
>>> I must admit I never looked at how do_exit() figures out where the stack frame
>>> containing the saved registers is stored, I just assumed it unwinds the stack up
>>> to the point where the caller syscall was made, and works from there. The same
>>> strategy ought to work here.
>>
>> For do_exit the part we need to be careful with is PTRACE_EVENT_EXIT,
>> which means it is ptrace that we need to look at.
>>
>> For m68k the code in put_reg and get_reg finds the registers by looking
>> at task->thread.esp0.
>
> Thanks, that's what I was missing here.
>>
>> I was expecting m68k to use the same technique as alpha which expects a
>> fixed offset from task_stack_page(task).
>>
>> So your code will work if you add code to update task->thread.esp0 which
>> is also known as THREAD_ESP0 in entry.S
>
> Shoving
>
> movel   %sp,%curptr@(TASK_THREAD+THREAD_ESP0)
>
> in between the SAVE_ALL_INT and SAVE_SWITCH_STACK ought to do the
> trick there.
>
>>
>>>> Without being saved at the well known fixed location if some process
>>>> stops in PTRACE_EVENT_EXIT in do_exit we likely get some complete
>>>> gibberish.
>>>>
>>>> That is probably safe.
>>>>
>>>>>   	jbra	fpsp040_die
>>>>> +	addql   #8,%sp
>>>>> +	addql   #8,%sp
>>>>> +	addql   #8,%sp
>>>>> +	addql   #8,%sp
>>>>> +	addql   #8,%sp
>>>>> +	addql   #4,%sp
>>>>> +	rts
>>>> Especially as everything after jumping to fpsp040_die does not execute.
>>>
>>> Unless we change fpsp040_die() to call force_sig(SIGSEGV).
>>
>> Yes.  I think we would probably need to have it also call get_signal and
>> all of that, because I don't think the very light call path for that
>> exception includes testing if signals are pending.
>
> As far as I can see, there is a test for pending signals:
>
> ENTRY(ret_from_exception)
> .Lret_from_exception:
>         btst    #5,%sp@(PT_OFF_SR)      | check if returning to kernel
>         bnes    1f                      | if so, skip resched, signals
>         | only allow interrupts when we are really the last one on the
>         | kernel stack, otherwise stack overflow can occur during
>         | heavy interrupt load
>         andw    #ALLOWINT,%sr
>
> resume_userspace:
>         movel   %curptr@(TASK_STACK),%a1
>         moveb   %a1@(TINFO_FLAGS+3),%d0	| bits 0-7 of TINFO_FLAGS
>         jne     exit_work		| any bit set? -> exit_work
> 1:      RESTORE_ALL
>
> exit_work:
>         | save top of frame
>         movel   %sp,%curptr@(TASK_THREAD+THREAD_ESP0)
>         lslb    #1,%d0			| shift out TIF_NEED_RESCHED
>         jne     do_signal_return	| any remaining bit
> (signal/notify_resume)? -> do_signal_return
>         pea     resume_userspace
>         jra     schedule
>
> As long as TIF_NOTIFY_SIGNAL or TIF_SIGPENDING are set,
> do_signal_return will be called.

I was going to say I don't think so, as my tracing of
the code lead in a couple of different directions.  Upon closer
inspection all those paths either lead to fpsp_done or more
directly to ret_from_exception.

For anyone else who might want to trace the code, or for myself later on
when I forget.  As best as I can figure the hardware exception vector
table is setup in: arch/m68k/kernel/vector.c

For the vectors in question it appears to be this chunk of code:

	if (CPU_IS_040 && !FPU_IS_EMU) {
		/* set up FPSP entry points */
		asmlinkage void dz_vec(void) asm ("dz");
		asmlinkage void inex_vec(void) asm ("inex");
		asmlinkage void ovfl_vec(void) asm ("ovfl");
		asmlinkage void unfl_vec(void) asm ("unfl");
		asmlinkage void snan_vec(void) asm ("snan");
		asmlinkage void operr_vec(void) asm ("operr");
		asmlinkage void bsun_vec(void) asm ("bsun");
		asmlinkage void fline_vec(void) asm ("fline");
		asmlinkage void unsupp_vec(void) asm ("unsupp");

		vectors[VEC_FPDIVZ] = dz_vec;
		vectors[VEC_FPIR] = inex_vec;
		vectors[VEC_FPOVER] = ovfl_vec;
		vectors[VEC_FPUNDER] = unfl_vec;
		vectors[VEC_FPNAN] = snan_vec;
		vectors[VEC_FPOE] = operr_vec;
		vectors[VEC_FPBRUC] = bsun_vec;
		vectors[VEC_LINE11] = fline_vec;
		vectors[VEC_FPUNSUP] = unsupp_vec;
	}


Which leads me to call traces that look like this:

hw
  fline
    fpsp_fline
       mem_read
          user_read
             copyin
               in_ea
                  <page-fault>
                     fpsp040_die

If that mem_read returns it can be followed by
       not_mvcr
          real_fline
            ret_from_exception

Or it can be followed by
       fix_con
          uni_2
             gen_except
                 do_clean
                    finish_up
                       fpsp_done
                          ret_from_exception
                          


>> The way the code is structured it is actively incorrect to return from
>> fpsp040_die, as the code does not know what to do if it reads a byte
>> from userspace and there is nothing there.
>
> Correct - my hope is that upon return from the FPU exception (that
> continued after a dodgy read or write), we get the signal delivered
> and will die then.

Yes.  That does look like a good strategy.

I am wondering if there are values we can return that will make the
path out of the exit routine more deterministic.

I have played with that a little bit today, but it doesn't look like I
am going to have time to put together any kind of real patch today.

Simply modifying fpsp040_die to call force_sigsegv(SIGSEGV) should be
enough to trigger a signal (no call stack work needed if we remove
do_exit).  The tricky bit is what value do we want to fake when we
can not read anything from userspace.   For a write fault we should just
be able to skip the write entirely.

In both cases we probably should break out of the loop prematurely.  But
I don't know if that is necessary.


The lazy strategy would be to copy the ifpsp060 code and simply oops
the kernel if the read or write of userspace gets a page fault.

>> So instead of handling -EFAULT like most pieces of kernel code the code
>> just immediately calls do_exit, and does not even attempt to handle
>> the error.
>>
>> That is not my favorite strategy at all, but I suspect it isn't worth
>> it, or safe to update the skeleton.S to handle errors.  Especially as we
>> have not even figured out how to test that code yet.
>
> That's bothering me more than a little, but I need to find out whether
> the emulator even handles FPU exceptions correctly ...


As a fallback plan we can following the lead of ifpsp060/os.S and simply
not catch the kernel triggered page fault, and let
arch/m68k/mm/fault.c:send_fault_sig() return a kernel oops.  It is not
ideal as it allows userspace to trigger a kernel oops, but it does at
least keep the kernel in a consistent state.

diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index a8f41615d94a..4c6c4b07ef38 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -479,7 +479,6 @@ copyout:
 |	movec	%d1,%DFC		| set dfc for user data space
 moreout:
 	moveb	(%a0)+,%d1	| fetch supervisor byte
-out_ea:
 	movesb	%d1,(%a1)+	| write user byte
 	dbf	%d0,moreout
 	rts
@@ -493,21 +492,9 @@ copyin:
 |	SFC is already set
 |	movec	%d1,%SFC		| set sfc for user space
 morein:
-in_ea:
 	movesb	(%a0)+,%d1	| fetch user byte
 	moveb	%d1,(%a1)+	| write supervisor byte
 	dbf	%d0,morein
 	rts
 
-	.section .fixup,#alloc,#execinstr
-	.even
-1:
-	jbra	fpsp040_die
-
-	.section __ex_table,#alloc
-	.align	4
-
-	.long	in_ea,1b
-	.long	out_ea,1b
-
 	|end
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index e2a6f3556211..3ec6ae1bdaf9 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -1144,15 +1144,6 @@ asmlinkage void set_esp0(unsigned long ssp)
 	current->thread.esp0 = ssp;
 }
 
-/*
- * This function is called if an error occur while accessing
- * user-space from the fpsp040 code.
- */
-asmlinkage void fpsp040_die(void)
-{
-	do_exit(SIGSEGV);
-}
-
 #ifdef CONFIG_M68KFPU_EMU
 asmlinkage void fpemu_signal(int signal, int code, void *addr)
 {

Eric

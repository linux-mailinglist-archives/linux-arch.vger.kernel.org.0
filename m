Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8D63D0378
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jul 2021 22:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhGTUKN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jul 2021 16:10:13 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47172 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbhGTTyP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jul 2021 15:54:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:57780)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m5wRx-00F8R2-FB; Tue, 20 Jul 2021 14:34:45 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57530 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m5wRw-004pTa-0c; Tue, 20 Jul 2021 14:34:44 -0600
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
Date:   Tue, 20 Jul 2021 15:32:33 -0500
In-Reply-To: <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com> (Michael
        Schmitz's message of "Sun, 18 Jul 2021 11:04:31 +1200")
Message-ID: <87h7gopvz2.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m5wRw-004pTa-0c;;;mid=<87h7gopvz2.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ZdlMbrFUjqew0rwldYtfxp3fjzeeEkZs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4987]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Michael Schmitz <schmitzmic@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 510 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (1.9%), b_tie_ro: 8 (1.7%), parse: 0.95 (0.2%),
         extract_message_metadata: 11 (2.1%), get_uri_detail_list: 2.5 (0.5%),
        tests_pri_-1000: 11 (2.2%), tests_pri_-950: 1.05 (0.2%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 59 (11.5%), check_bayes:
        58 (11.3%), b_tokenize: 9 (1.7%), b_tok_get_all: 10 (1.9%),
        b_comp_prob: 2.9 (0.6%), b_tok_touch_all: 33 (6.5%), b_finish: 0.74
        (0.1%), tests_pri_0: 399 (78.2%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 0.98 (0.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 12 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michael Schmitz <schmitzmic@gmail.com> writes:

> Am 18.07.2021 um 08:09 schrieb Michael Schmitz:
>> Hi Eric,
>>
>> Am 18.07.2021 um 06:52 schrieb Eric W. Biederman:
>>>> I should have looked more closely at skeleton.S - most FPU exceptions
>>>> handled there call trap_c the same way as is done for generic traps,
>>>> i.e. SAVE_ALL_INT before, ret_from_exception after.
>>>>
>>>> Instead of adding code to entry.S, much better to add it in
>>>> skeleton.S. I'll try to come up with a way to test this code path
>>>> (calling fpsp040_die from the dz exception hander seems much the
>>>> easiest way) to make sure this doesn't have side effects.
>>>>
>>>> Does do_exit() ever return?
>>>
>>> No.  The function do_exit never returns.
>>
>> Fine - nothing to worry about as regards restoring the stack pointer
>> correctly then.
>>
>>> If it is not too much difficulty I would be in favor of having the code
>>> do force_sigsegv(SIGSEGV), instead of calling do_exit directly.
>>
>> That _would_ force a return, right? The exception handling in skeleton.S
>> won't be set up for that.
>
> See attached patch - note that when you change fpsp040_die() to call
> force_sig(SIGSEGV), the access exception handler will return to whatever
> function in fpsp040 attempted the user space access, and continue that operation
> with quite likely bogus data. That may well force another FPU trap before the
> SIGSEGV is delivered (will force_sig() immediately force a trap, or wait until
> returning to user space?).
>
> Compile tested - haven't found an easy way to execute that code path yet.
>
> Cheers,
>
> 	Michael
>
>
>>
>>> Looking at that code I have not been able to figure out the call paths
>>> that get into skeleton.S.  I am not certain saving all of the registers
>>> on an the exceptions that reach there make sense.  In practice I suspect
>>
>> The registers are saved only so trap_c has a stack frame to work with.
>> In that sense, adding a stack frame before calling fpsp040_die is no
>> different.
>>
>>> taking an exception is much more expensive than saving the registers
>>> so it
>>> might not make any difference.  But this definitely looks like code that
>>> is performance sensitive.
>>
>> We're only planning to add a stack frame save before calling out of the
>> user access exception handler, right? I doubt that will be called very
>> often.
>>
>>> My sense when I was reading through skeleton.S was just one or two
>>> registers were saved before the instruction emulation was called.
>>
>> skeleton.S only contains the entry points for code to handle FPU
>> exceptions, from what I've seen (plus the user space access code).
>>
>> Wherever that exception handling requires calling into the C exception
>> handler (trap_c), a stack frame is added.
>>
>> Cheers,
>>
>>     Michael
>>
>>>
>
> From 1e9be9238fb88dc0b87a7ffdd48068f944d8626c Mon Sep 17 00:00:00 2001
> From: Michael Schmitz <schmitzmic@gmail.com>
> Date: Sun, 18 Jul 2021 10:31:42 +1200
> Subject: [PATCH] m68k/fpsp040 - save full stack frame before calling
>  fpsp040_die
>
> The FPSP040 floating point support code does not know how to
> handle user space access faults gracefully, and just calls
> do_exit(SIGSEGV) indirectly on these faults to abort.
>
> do_exit() may stop if traced, and needs a full stack frame
> available to avoid exposing kernel data.
>
> Add the current stack frame before calling do_exit() from the
> fpsp040 user access exception handler. Unwind the stack frame
> and return to caller once done, in case do_exit() is replaced
> by force_sig() later on.
>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> ---
>  arch/m68k/fpsp040/skeleton.S | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
> index a8f4161..6c92d38 100644
> --- a/arch/m68k/fpsp040/skeleton.S
> +++ b/arch/m68k/fpsp040/skeleton.S
> @@ -502,7 +502,17 @@ in_ea:
>  	.section .fixup,#alloc,#execinstr
>  	.even
>  1:
> +
> +	SAVE_ALL_INT
> +	SAVE_SWITCH_STACK
        ^^^^^^^^^^

I don't think this saves the registers in the well known fixed location
on the stack because some registers are saved at the exception entry
point.

Without being saved at the well known fixed location if some process
stops in PTRACE_EVENT_EXIT in do_exit we likely get some complete
gibberish.

That is probably safe.

>  	jbra	fpsp040_die
> +	addql   #8,%sp
> +	addql   #8,%sp
> +	addql   #8,%sp
> +	addql   #8,%sp
> +	addql   #8,%sp
> +	addql   #4,%sp
> +	rts

Especially as everything after jumping to fpsp040_die does not execute.

Eric


>  
>  	.section __ex_table,#alloc
>  	.align	4

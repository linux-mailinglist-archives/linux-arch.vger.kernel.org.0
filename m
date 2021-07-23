Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276583D437B
	for <lists+linux-arch@lfdr.de>; Sat, 24 Jul 2021 01:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhGWXMN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 19:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhGWXMN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jul 2021 19:12:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8BAC061575
        for <linux-arch@vger.kernel.org>; Fri, 23 Jul 2021 16:52:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j1so4392378pjv.3
        for <linux-arch@vger.kernel.org>; Fri, 23 Jul 2021 16:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=hBa32E1+9JzGMtf5t7qSIrmBQ3TPsmJpfcXu/W7bj5Y=;
        b=uCBH0gXuNzFZ2U7JemmtONRt4Hd/048m+8JqQJR40CKIOkK8wWIViWupuxcsqqm5PI
         NG7Eu1C07N/WdeyuMiF0sasLHum0KnOTlBGiPqD2Lt7krmkiK+atCgpDu4GVPlwT8tc4
         8YIgqSi1RFCDpd3jHkghu0g1Nc9Kpytlgn/8H2E1H3hhbVzLWabG90ESOxarSD05IR30
         tetM7pAMIlcJYCmYHs3g7Exsdn45lF6YaoPerlNo5zKrwbK0D64uB+9wFQQ2HNN29UeF
         Q7rCyL9Vf3VSrHXi7XowaXaapRTGXclDLqa/siB10zao+kl5VP1UoxRmnF2iwe0hfcPN
         zcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=hBa32E1+9JzGMtf5t7qSIrmBQ3TPsmJpfcXu/W7bj5Y=;
        b=iVLtY/Q1+br6q7gLDjsfDHp1zSklXPcBz0upDAWYoPjhCpvOt2jAtR6V0RJOb77cJb
         PlEmzYYLKMLLi0ZYSRB1lMcCV9zmyH6mrewB8L4kh2enBmaCjsXhm76jZbbkNo2xpNa4
         RtmoG0GaFu+YIyW/MciwsDbQzyfXOgUbHE8rRgDnLruziNgXDCdbJunIBg/gpjAYifAB
         LWh1vo1E47IMh7Rraa83qahNCoICBijvHFmw1BLjhn/C9DgZJwvnWoZh59lZxiJ76Qzk
         BvWpooESvNhWsC51OCYUP2ziOLNZgVbIpqX9zlmWKBbE9ccp6YZg6xAzDow0YcpAB+5k
         0YCg==
X-Gm-Message-State: AOAM530N3GagthG3REUiRDKX86yBU6sbwPNzEBqo99VA/jxoqAlodrwJ
        u/W57trOVC8PLMCCCtr/VqU=
X-Google-Smtp-Source: ABdhPJznzxjGuKQN9f1ta7wVI2oJSfyNeOwl6k2V7x954oo7KbXh4+Ee4fj5P6vgOXjOp17oF/obFg==
X-Received: by 2002:a17:90b:1194:: with SMTP id gk20mr15910056pjb.181.1627084365765;
        Fri, 23 Jul 2021 16:52:45 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-37-fibre.sparkbb.co.nz. [222.152.189.37])
        by smtp.gmail.com with ESMTPSA id v10sm36531538pfg.160.2021.07.23.16.52.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jul 2021 16:52:45 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
To:     "Eric W. Biederman" <ebiederm@xmission.com>
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <87zgunzovm.fsf@disp2133> <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
 <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com> <8735scvklk.fsf@disp2133>
 <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
 <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com> <87h7gopvz2.fsf@disp2133>
 <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com> <877dhio13t.fsf@disp2133>
 <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com> <87tukkk6h3.fsf@disp2133>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <df6618bf-d1bc-4759-2d14-934c22d54a83@gmail.com>
Date:   Sat, 24 Jul 2021 11:52:38 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <87tukkk6h3.fsf@disp2133>
Content-Type: multipart/mixed;
 boundary="------------70644DAD01933758A424CEB9"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a multi-part message in MIME format.
--------------70644DAD01933758A424CEB9
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eric,

Am 24.07.2021 um 10:31 schrieb Eric W. Biederman:

>>>> Unless we change fpsp040_die() to call force_sig(SIGSEGV).
>>>
>>> Yes.  I think we would probably need to have it also call get_signal and
>>> all of that, because I don't think the very light call path for that
>>> exception includes testing if signals are pending.
>>
>> As far as I can see, there is a test for pending signals:
>>
>> ENTRY(ret_from_exception)
>> .Lret_from_exception:
>>         btst    #5,%sp@(PT_OFF_SR)      | check if returning to kernel
>>         bnes    1f                      | if so, skip resched, signals
>>         | only allow interrupts when we are really the last one on the
>>         | kernel stack, otherwise stack overflow can occur during
>>         | heavy interrupt load
>>         andw    #ALLOWINT,%sr
>>
>> resume_userspace:
>>         movel   %curptr@(TASK_STACK),%a1
>>         moveb   %a1@(TINFO_FLAGS+3),%d0	| bits 0-7 of TINFO_FLAGS
>>         jne     exit_work		| any bit set? -> exit_work
>> 1:      RESTORE_ALL
>>
>> exit_work:
>>         | save top of frame
>>         movel   %sp,%curptr@(TASK_THREAD+THREAD_ESP0)
>>         lslb    #1,%d0			| shift out TIF_NEED_RESCHED
>>         jne     do_signal_return	| any remaining bit
>> (signal/notify_resume)? -> do_signal_return
>>         pea     resume_userspace
>>         jra     schedule
>>
>> As long as TIF_NOTIFY_SIGNAL or TIF_SIGPENDING are set,
>> do_signal_return will be called.
>
> I was going to say I don't think so, as my tracing of
> the code lead in a couple of different directions.  Upon closer
> inspection all those paths either lead to fpsp_done or more
> directly to ret_from_exception.
>
> For anyone else who might want to trace the code, or for myself later on
> when I forget.  As best as I can figure the hardware exception vector
> table is setup in: arch/m68k/kernel/vector.c
>
> For the vectors in question it appears to be this chunk of code:
>
> 	if (CPU_IS_040 && !FPU_IS_EMU) {
> 		/* set up FPSP entry points */
> 		asmlinkage void dz_vec(void) asm ("dz");
> 		asmlinkage void inex_vec(void) asm ("inex");
> 		asmlinkage void ovfl_vec(void) asm ("ovfl");
> 		asmlinkage void unfl_vec(void) asm ("unfl");
> 		asmlinkage void snan_vec(void) asm ("snan");
> 		asmlinkage void operr_vec(void) asm ("operr");
> 		asmlinkage void bsun_vec(void) asm ("bsun");
> 		asmlinkage void fline_vec(void) asm ("fline");
> 		asmlinkage void unsupp_vec(void) asm ("unsupp");
>
> 		vectors[VEC_FPDIVZ] = dz_vec;
> 		vectors[VEC_FPIR] = inex_vec;
> 		vectors[VEC_FPOVER] = ovfl_vec;
> 		vectors[VEC_FPUNDER] = unfl_vec;
> 		vectors[VEC_FPNAN] = snan_vec;
> 		vectors[VEC_FPOE] = operr_vec;
> 		vectors[VEC_FPBRUC] = bsun_vec;
> 		vectors[VEC_LINE11] = fline_vec;
> 		vectors[VEC_FPUNSUP] = unsupp_vec;
> 	}
>

Correct.

> Which leads me to call traces that look like this:
>
> hw
>   fline
>     fpsp_fline
>        mem_read
>           user_read
>              copyin
>                in_ea
>                   <page-fault>
>                      fpsp040_die

According to my understanding, you can't get a F-line exception on 
68040. F-line is a coprocessor protocol violation, only raised when 
there is no coprocessor present on the bus.

What we expect to get is any of the arithmetic exceptions, and the 
'unsupported opcode' one (for those floating point instructions that the 
68040 FPU does not implement).

In reality, it's probably the 'unsupported' exception we expect to hit 
most often.

>
> If that mem_read returns it can be followed by
>        not_mvcr
>           real_fline
>             ret_from_exception
>
> Or it can be followed by
>        fix_con
>           uni_2
>              gen_except
>                  do_clean
>                     finish_up
>                        fpsp_done
>                           ret_from_exception
>
>
>
>>> The way the code is structured it is actively incorrect to return from
>>> fpsp040_die, as the code does not know what to do if it reads a byte
>>> from userspace and there is nothing there.
>>
>> Correct - my hope is that upon return from the FPU exception (that
>> continued after a dodgy read or write), we get the signal delivered
>> and will die then.
>
> Yes.  That does look like a good strategy.
>
> I am wondering if there are values we can return that will make the
> path out of the exit routine more deterministic.

I doubt it - maybe 'preloading' the register used for the read with 
something invalid as floating point instruction or data might force 
another exception more readily, but that's just speculation on my part.

> I have played with that a little bit today, but it doesn't look like I
> am going to have time to put together any kind of real patch today.

I've attached a corrected version of my patch to supply the required 
stack frame - this ought to make use of do_exit() safe. Still working on 
a way to exercise this code path. Let's think about ways to use signals 
once I've succeeded to do that.

Cheers,

	Michael


>
> Simply modifying fpsp040_die to call force_sigsegv(SIGSEGV) should be
> enough to trigger a signal (no call stack work needed if we remove
> do_exit).  The tricky bit is what value do we want to fake when we
> can not read anything from userspace.   For a write fault we should just
> be able to skip the write entirely.
>
> In both cases we probably should break out of the loop prematurely.  But
> I don't know if that is necessary.
>
>
> The lazy strategy would be to copy the ifpsp060 code and simply oops
> the kernel if the read or write of userspace gets a page fault.
>
>>> So instead of handling -EFAULT like most pieces of kernel code the code
>>> just immediately calls do_exit, and does not even attempt to handle
>>> the error.
>>>
>>> That is not my favorite strategy at all, but I suspect it isn't worth
>>> it, or safe to update the skeleton.S to handle errors.  Especially as we
>>> have not even figured out how to test that code yet.
>>
>> That's bothering me more than a little, but I need to find out whether
>> the emulator even handles FPU exceptions correctly ...
>
>
> As a fallback plan we can following the lead of ifpsp060/os.S and simply
> not catch the kernel triggered page fault, and let
> arch/m68k/mm/fault.c:send_fault_sig() return a kernel oops.  It is not
> ideal as it allows userspace to trigger a kernel oops, but it does at
> least keep the kernel in a consistent state.
>
> diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
> index a8f41615d94a..4c6c4b07ef38 100644
> --- a/arch/m68k/fpsp040/skeleton.S
> +++ b/arch/m68k/fpsp040/skeleton.S
> @@ -479,7 +479,6 @@ copyout:
>  |	movec	%d1,%DFC		| set dfc for user data space
>  moreout:
>  	moveb	(%a0)+,%d1	| fetch supervisor byte
> -out_ea:
>  	movesb	%d1,(%a1)+	| write user byte
>  	dbf	%d0,moreout
>  	rts
> @@ -493,21 +492,9 @@ copyin:
>  |	SFC is already set
>  |	movec	%d1,%SFC		| set sfc for user space
>  morein:
> -in_ea:
>  	movesb	(%a0)+,%d1	| fetch user byte
>  	moveb	%d1,(%a1)+	| write supervisor byte
>  	dbf	%d0,morein
>  	rts
>
> -	.section .fixup,#alloc,#execinstr
> -	.even
> -1:
> -	jbra	fpsp040_die
> -
> -	.section __ex_table,#alloc
> -	.align	4
> -
> -	.long	in_ea,1b
> -	.long	out_ea,1b
> -
>  	|end
> diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
> index e2a6f3556211..3ec6ae1bdaf9 100644
> --- a/arch/m68k/kernel/traps.c
> +++ b/arch/m68k/kernel/traps.c
> @@ -1144,15 +1144,6 @@ asmlinkage void set_esp0(unsigned long ssp)
>  	current->thread.esp0 = ssp;
>  }
>
> -/*
> - * This function is called if an error occur while accessing
> - * user-space from the fpsp040 code.
> - */
> -asmlinkage void fpsp040_die(void)
> -{
> -	do_exit(SIGSEGV);
> -}
> -
>  #ifdef CONFIG_M68KFPU_EMU
>  asmlinkage void fpemu_signal(int signal, int code, void *addr)
>  {
>
> Eric
>

--------------70644DAD01933758A424CEB9
Content-Type: text/x-diff;
 name="0001-m68k-fpsp040-save-full-stack-frame-before-calling-fp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-m68k-fpsp040-save-full-stack-frame-before-calling-fp.pa";
 filename*1="tch"

From 737b74a376f0b3da09ba7cb088e99c2c85b7405c Mon Sep 17 00:00:00 2001
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Sun, 18 Jul 2021 10:31:42 +1200
Subject: [PATCH] m68k/fpsp040 - save full stack frame before calling
 fpsp040_die

The FPSP040 floating point support code does not know how to
handle user space access faults gracefully, and just calls
do_exit(SIGSEGV) indirectly on these faults to abort.

do_exit() may stop if traced, and needs a full stack frame
available to avoid exposing kernel data.

Add the current stack frame before calling do_exit() from the
fpsp040 user access exception handler. Top of stack frame saved
to task->thread.esp0 as is done for system calls.

Unwind the stack frame and return to caller once done, in case
do_exit() is replaced by force_sig() later on. Note that this
will allow the current exception handler to continue with
incorrect state, but the results will never make it to the
calling user program which is terminated by SYSSIGV upon return
from exception.

CC: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/fpsp040/skeleton.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index a8f4161..1cbc52b 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -502,7 +502,14 @@ in_ea:
 	.section .fixup,#alloc,#execinstr
 	.even
 1:
+
+	SAVE_ALL_INT
+	| save top of frame
+	movel	%sp,%curptr@(TASK_THREAD+THREAD_ESP0)
+	SAVE_SWITCH_STACK
 	jbra	fpsp040_die
+	lea	44(%sp),%sp
+	rts
 
 	.section __ex_table,#alloc
 	.align	4
-- 
2.7.4


--------------70644DAD01933758A424CEB9--

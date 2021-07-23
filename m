Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE32C3D3384
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 06:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhGWDm4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 23:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhGWDmp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jul 2021 23:42:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE39C061757
        for <linux-arch@vger.kernel.org>; Thu, 22 Jul 2021 21:23:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mt6so527165pjb.1
        for <linux-arch@vger.kernel.org>; Thu, 22 Jul 2021 21:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=WsiAS3z4oAzigWGNyrDdXuhw9uHB2q0vdBc/ZxtadIc=;
        b=RCD9kPFJuFifpir8xRlxehiCOuy2mroN+w4M6ciZUGqBRUZMWDJwB7BGVOI7yPVdPR
         D/FuhNMGcAM8wYLwiYmX8csMQVHOvVOH3jgxwGLUNMg7O1gf/IZ8pk01AByD50zsqZTx
         dc/UsK/vhaWW8FVfy7GvrPnD06/jsePnB3lYaWthd45TpkFwhIQEbt867WHWsz21SsOh
         /T0vlx+njtLMOUQyEwhnU5PAJtWJi2Qn0Lo1WcW33wkOMzJVoKIn4u184Ub7SKBUUTVg
         AYHV1qFTwEOqlNZLT/gSuTGKYgWB+MP+KJmDIG0yJgl5ZLXxqUP+yYuTsJQEOiaC0WKn
         VjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=WsiAS3z4oAzigWGNyrDdXuhw9uHB2q0vdBc/ZxtadIc=;
        b=WJggQpJFDXGa3qFAqdf+IXwWJinqy+pEFLVh/fnI8t/lyXMHHF6ZHIv7q6tGlQYpsD
         eOfRRCQI8VVc+3Xy2llZKI0tBSMChPkibg8x1j44rxOXTrAoAnAEVViv33py47x+VAno
         GgwgLkMBoCuRj/+uB/4P7MibzIOP7vvEkuY/zn70MyH8gw87yFwMkufe0OP/yuLAXzZW
         4QCpO3R6VAERkJ49/lm9tFkM+iOEcPV7ifqwlTN/l5xWFfA1lWqXO8zsXArYQA3wVDVY
         6NIn6hyb8xp+vRQZw5wlePbqUVlBd+O6VLl7OfQkTHit7GRFDeBPk4ZemUKwqYhkNdNI
         VlIw==
X-Gm-Message-State: AOAM532MrpjdkE6naqXOlKC8qMjWxpYcS63e5n7Ra8OBGJzt+KN0mm/4
        TyLZqpOBxMHwr2m5S3ksneY=
X-Google-Smtp-Source: ABdhPJyBJTjfadBKKXYpbAsw9v0hBHT4b7S4vNjUNOeU+s7zqCB0CIl0hLbFDzGy3j18GQ2HCZE5EQ==
X-Received: by 2002:a17:90a:a087:: with SMTP id r7mr12253320pjp.84.1627014198181;
        Thu, 22 Jul 2021 21:23:18 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-37-fibre.sparkbb.co.nz. [222.152.189.37])
        by smtp.gmail.com with ESMTPSA id s36sm21208469pgl.8.2021.07.22.21.23.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 21:23:17 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
To:     "Eric W. Biederman" <ebiederm@xmission.com>
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <87zgunzovm.fsf@disp2133> <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
 <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com> <8735scvklk.fsf@disp2133>
 <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
 <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com> <87h7gopvz2.fsf@disp2133>
 <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com> <877dhio13t.fsf@disp2133>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com>
Date:   Fri, 23 Jul 2021 16:23:12 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <877dhio13t.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Eric,

Am 23.07.2021 um 02:49 schrieb Eric W. Biederman:
> Michael Schmitz <schmitzmic@gmail.com> writes:
>
>> Hi Eric,
>>
>> On 21/07/21 8:32 am, Eric W. Biederman wrote:
>>>
>>>> diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
>>>> index a8f4161..6c92d38 100644
>>>> --- a/arch/m68k/fpsp040/skeleton.S
>>>> +++ b/arch/m68k/fpsp040/skeleton.S
>>>> @@ -502,7 +502,17 @@ in_ea:
>>>>   	.section .fixup,#alloc,#execinstr
>>>>   	.even
>>>>   1:
>>>> +
>>>> +	SAVE_ALL_INT
>>>> +	SAVE_SWITCH_STACK
>>>          ^^^^^^^^^^
>>>
>>> I don't think this saves the registers in the well known fixed location
>>> on the stack because some registers are saved at the exception entry
>>> point.
>>
>> The FPU exception entry points are not using the exception entry code in
>> head.S. These entry points are stored in the exception vector table directly. No
>> saving of a syscall stack frame happens there. The FPU places its exception
>> frame on the stack, and that is what the FPU exception handlers use.
>>
>> (If these have to call out to the generic exception handlers again, they will
>> build a minimal stack frame, see code in skeleton.S.)
>>
>> Calling fpsp040_die() is no different from calling a syscall that may need to
>> have access to the full stack frame. The 'fixed location' is just 'on the stack
>> before calling  fpsp040_die()', again this is no different from calling
>> e.g. sys_fork() which does not take a pointer to the begin of the stack frame as
>> an argument.
>>
>> I must admit I never looked at how do_exit() figures out where the stack frame
>> containing the saved registers is stored, I just assumed it unwinds the stack up
>> to the point where the caller syscall was made, and works from there. The same
>> strategy ought to work here.
>
> For do_exit the part we need to be careful with is PTRACE_EVENT_EXIT,
> which means it is ptrace that we need to look at.
>
> For m68k the code in put_reg and get_reg finds the registers by looking
> at task->thread.esp0.

Thanks, that's what I was missing here.
>
> I was expecting m68k to use the same technique as alpha which expects a
> fixed offset from task_stack_page(task).
>
> So your code will work if you add code to update task->thread.esp0 which
> is also known as THREAD_ESP0 in entry.S

Shoving

movel   %sp,%curptr@(TASK_THREAD+THREAD_ESP0)

in between the SAVE_ALL_INT and SAVE_SWITCH_STACK ought to do the trick 
there.

>
>>> Without being saved at the well known fixed location if some process
>>> stops in PTRACE_EVENT_EXIT in do_exit we likely get some complete
>>> gibberish.
>>>
>>> That is probably safe.
>>>
>>>>   	jbra	fpsp040_die
>>>> +	addql   #8,%sp
>>>> +	addql   #8,%sp
>>>> +	addql   #8,%sp
>>>> +	addql   #8,%sp
>>>> +	addql   #8,%sp
>>>> +	addql   #4,%sp
>>>> +	rts
>>> Especially as everything after jumping to fpsp040_die does not execute.
>>
>> Unless we change fpsp040_die() to call force_sig(SIGSEGV).
>
> Yes.  I think we would probably need to have it also call get_signal and
> all of that, because I don't think the very light call path for that
> exception includes testing if signals are pending.

As far as I can see, there is a test for pending signals:

ENTRY(ret_from_exception)
.Lret_from_exception:
         btst    #5,%sp@(PT_OFF_SR)      | check if returning to kernel
         bnes    1f                      | if so, skip resched, signals
         | only allow interrupts when we are really the last one on the
         | kernel stack, otherwise stack overflow can occur during
         | heavy interrupt load
         andw    #ALLOWINT,%sr

resume_userspace:
         movel   %curptr@(TASK_STACK),%a1
         moveb   %a1@(TINFO_FLAGS+3),%d0	| bits 0-7 of TINFO_FLAGS
         jne     exit_work		| any bit set? -> exit_work
1:      RESTORE_ALL

exit_work:
         | save top of frame
         movel   %sp,%curptr@(TASK_THREAD+THREAD_ESP0)
         lslb    #1,%d0			| shift out TIF_NEED_RESCHED
         jne     do_signal_return	| any remaining bit 
(signal/notify_resume)? -> do_signal_return
         pea     resume_userspace
         jra     schedule

As long as TIF_NOTIFY_SIGNAL or TIF_SIGPENDING are set, do_signal_return 
will be called.


>
> The way the code is structured it is actively incorrect to return from
> fpsp040_die, as the code does not know what to do if it reads a byte
> from userspace and there is nothing there.

Correct - my hope is that upon return from the FPU exception (that 
continued after a dodgy read or write), we get the signal delivered and 
will die then.

>
> So instead of handling -EFAULT like most pieces of kernel code the code
> just immediately calls do_exit, and does not even attempt to handle
> the error.
>
> That is not my favorite strategy at all, but I suspect it isn't worth
> it, or safe to update the skeleton.S to handle errors.  Especially as we
> have not even figured out how to test that code yet.

That's bothering me more than a little, but I need to find out whether 
the emulator even handles FPU exceptions correctly ...

Cheers,

	Michael

>
> Eric
>

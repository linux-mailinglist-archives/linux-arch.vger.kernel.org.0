Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A893E3AE2CB
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 07:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhFUFeY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 01:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhFUFeY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 01:34:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B7AC061574;
        Sun, 20 Jun 2021 22:32:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bb20so5069232pjb.3;
        Sun, 20 Jun 2021 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=9Dkwdn9F1dEc6drYZVBte1PeX9pW02/5PpZNItAMxjk=;
        b=Y4L2y3K3dfO+HYNLCDmxWRT5BGc+Vi55FMc3yMUdMMQ2ihq3gxg11Fo+Koz8vtK6cG
         SCzCSD+1O1t+CyxHu1Li7k4yigOcEIp4+qatZ/lnJzE0EROxC97pKhCP/j+Rti0AV5ry
         hXkJMzFvG1cnDevCojrDkvv4eXrGCi1ym1WVvpSACsjgHqiVBVVWedhdZHtTvYxWn/tw
         tZCEihRNAmysmh8Y4gGq65t/duk7yMAqTD1YVDJEPepl5476vXhwfwclHEWjZJGcPUEO
         PIZcRwol19+Kinf/fttz0ZzXckDPOi0hUvaCXhyAknS0C8B5fUGb5fFJMKLiHkX9QDsT
         6Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=9Dkwdn9F1dEc6drYZVBte1PeX9pW02/5PpZNItAMxjk=;
        b=d+e7lzudtawkE0pc3otQtw02srQWKLZO1gzu9m5jpXg/VKNMRFuVuWXPGY4MT2f4/1
         lJubY8GS7+PW4jkzDNS092+ydsxyI2f8mkfspPXNDgQZgLanuuHFT6iCfYZoOUd6E8zB
         77jhJmUF1RdfkKACLU4vJGNiZCJ6VP9m74kbT5OjwxPsl4oG9BlYheUCyzFFfIjh7k7X
         RW1Ep/vz1l3BFCVK/V2dakXPd7EBv2PRAOdql53miHG9S4RV9nDdK2VBtWC6wWi6xxXZ
         avXJP8Y2bRdwHVRcGXP950NXW+rEriFnaF7NWNjPa18nXLXjEGGJU9SxcOnJxIbPlex0
         Vwgg==
X-Gm-Message-State: AOAM533e50h8jAaFnYkSX9fWJ0u1M8XukcDDwkHOb22UuY6O6f/X1CbO
        WW493Op5VKmF4AX3U2c9jNY=
X-Google-Smtp-Source: ABdhPJy6ShNBj/4lp9QqO0nZz6uf/JEyPKhJ050z5jPNoXLIznjBgPf40kkZYXgRSJtsG/8KPUxspA==
X-Received: by 2002:a17:90a:6392:: with SMTP id f18mr25399433pjj.136.1624253529536;
        Sun, 20 Jun 2021 22:32:09 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id x21sm2312621pfu.211.2021.06.20.22.32.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 22:32:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] alpha/ptrace: Record and handle the absence of
 switch_stack
To:     Al Viro <viro@zeniv.linux.org.uk>
References: <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <87zgvqor7d.fsf_-_@disp2133>
 <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
 <87mtrpg47k.fsf@disp2133> <87pmwlek8d.fsf_-_@disp2133>
 <87k0mtek4n.fsf_-_@disp2133> <393c37de-5edf-effc-3d06-d7e63f34a317@gmail.com>
 <CAHk-=wip8KgrNUcU68wsLZqbWV+3NWg9kqqQwygHGAA8-xOwMA@mail.gmail.com>
 <60c0fe00-b966-6385-d348-f6dd45277113@gmail.com>
 <YNALIY2vhvzKi+Sy@zeniv-ca.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <f0be8f95-e4ab-960f-19fa-ab60fd958552@gmail.com>
Date:   Mon, 21 Jun 2021 17:31:58 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <YNALIY2vhvzKi+Sy@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Al,

Am 21.06.2021 um 15:44 schrieb Al Viro:
> On Mon, Jun 21, 2021 at 03:18:35PM +1200, Michael Schmitz wrote:
>
>> This is what I get from WARN_ONCE:
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1177 at arch/m68k/kernel/ptrace.c:91 get_reg+0x90/0xb8
>> Modules linked in:
>> CPU: 0 PID: 1177 Comm: strace Not tainted 5.13.0-rc1-atari-fpuemu-exitfix+
>> #1146
>> Stack from 014b7f04:
>>         014b7f04 00336401 00336401 000278f0 0032c015 0000005b 00000005
>> 0002795a
>>         0032c015 0000005b 0000338c 00000009 00000000 00000000 ffffffe4
>> 00000005
>>         00000003 00000014 00000003 00000014 efc2b90c 0000338c 0032c015
>> 0000005b
>>         00000009 00000000 efc2b908 00912540 efc2b908 000034cc 00912540
>> 00000005
>>         00000000 efc2b908 00000003 00912540 8000110c c010b0a4 efc2b90c
>> 0002d1d8
>>         00912540 00000003 00000014 efc2b908 0000049a 00000014 efc2b908
>> 800acaa8
>> Call Trace: [<000278f0>] __warn+0x9e/0xb4
>>  [<0002795a>] warn_slowpath_fmt+0x54/0x62
>>  [<0000338c>] get_reg+0x90/0xb8
>>  [<0000338c>] get_reg+0x90/0xb8
>>  [<000034cc>] arch_ptrace+0x7e/0x250
>>  [<0002d1d8>] sys_ptrace+0x232/0x2f8
>>  [<00002ab6>] syscall+0x8/0xc
>>  [<0000c00b>] lower+0x7/0x20
>>
>> ---[ end trace ee4be53b94695793 ]---
>>
>> Syscall numbers are actually 90 and 192 - sys_old_mmap and sys_mmap2 on
>> m68k. Used the calculator on my Ubuntu desktop, that appears to be a little
>> confused about hex to decimal conversions.
>>
>> I hope that makes more sense?
>
> Not really; what is the condition you are checking?  The interesting trace

The check in get_reg() is:


            if (WARN_ON_ONCE((off < PT_REG(d1)) &&
               test_ti_thread_status(task_thread_info(task),TIS_TRACING)
                    && !test_ti_thread_status(task_thread_info(task),
                                         TIS_ALLREGS_SAVED))) {
                    unsigned long *addr_d0;
                    addr_d0 = (unsigned long *)(task->thread.esp0 + 
regoff[16]);
                    pr_err("get_reg with incomplete stack, regno %d offs 
%d orig_d0 %lx\n", regno, off, *addr_d0);
                    return 0;
            }


> is not that with get_reg() - it's that of the process being traced.  You
> are not accessing the stack of caller of ptrace(2) here, so you want to
> know that SAVE_SWITCH_STACK had been done by the tracee, not tracer.
>
> And if that had been strace ls, you have TIF_SYSCALL_TRACE set for ls, so
> 	* ls hits system_call
> 	* notices TIF_SYSCALL_TRACE and goes to do_trace_entry
> 	* does SAVE_SWITCH_STACK there

... and sets both the new TIS_TRACING and TIS_ALLREGS_SAVED flags in the 
thread_info->status field (now that I've corrected my patch).

> 	* calls syscall_trace(), which calls ptrace_notify()
> 	* ptrace_notify() calls ptrace_do_notify(), which calls ptrace_stop()
> 	* ptrace_stop() arranges for tracer to be woken up and gives CPU up,
> with TASK_TRACED as process state.

Thanks for explaining! So in order to get a trace for the process being 
traced, I would have to check the TIS_ALLREGS_SAVED in ptrace_stop()?

> That's the callchain in ls, and switch_stack accessed by get_reg() from
> strace is the one on ls(1) stack created by SAVE_SWITCH_STACK.

So testing for TIS_ALLREGS_SAVED in get_reg() (called by the tracer, but 
with the tracee's task struct passed to arch_ptrace()) does check that 
SAVE_SWITCH_STACK was done before the syscall in the tracee, right?

Anyway, I'd missed setting the flags for some crucial SAVE_SWITCH_STACK 
operations in my woefully incomplete patch. With that corrected, there's 
no more warning from mmap. I'll try with a more recent version of strace 
and gdb once I've updated my test image.

Cheers,

	Michael

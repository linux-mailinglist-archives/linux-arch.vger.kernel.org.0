Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B95A3AD547
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jun 2021 00:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhFRWg6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 18:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhFRWg6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2021 18:36:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0C8C061574
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 15:34:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f10so3312140plg.0
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 15:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=B/HElwUoLhpqBsueuzwwyQyKkKw5KxjI753KlYOCOqc=;
        b=KtkV5Q/qERWQFVptcDLaP8YKJv1iqBeFHMjL5XSaRUw0SL+V4jNhQ9qH6pRO0u0F99
         tNpnJ3C9yJVJ8vwSdV0MqjWEdqQAMJwZjDXr1vBm2OzfgGWtIhgS7zoo0qRkCCXG5Efq
         zSQZaQm4PWN1I9dUb0ytMdIPLXnnTZAan9fgrO2KIHYDkpCP0kdTNm1fhXhAw2TuSzci
         uLclbhGupevgjBYi1A1Xim/N/7+0a0sp4EDBud81zuhR0DMb7FHUSvbjx4+H+rKunTn5
         XY/QL61VEYW5KiVbvNyzFVifAh2LLSuLw6ZysNEcJCEL/1x4IVFPGrBaN+VXknGVNdkm
         T03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=B/HElwUoLhpqBsueuzwwyQyKkKw5KxjI753KlYOCOqc=;
        b=V10W7Ox3s7aVOqAS2QlYrYbAGnWbhhXTUKk2DYmMV81vUqs95q9l2oh/MguU0Th5+O
         Laa/GUzeEa+H9Pw0wjvduWTl/gAGyNbHzN9VYDLhswiJgXPx0XB+60LQzI9NzuAL9UaJ
         eQNwublBzR3h9+0TqX7vQpEFJsH9IY3xmQ0aEjd5E4xoSz/isUSES8P7ZT/Ztq9NEWx2
         QwgGmppvPwRq4Euq0KiWXqvbZYGJTEYdT2SUuPUyWa6Yvb88kD0UigkK5oyHaxQWQ5LA
         w4hUOA8cOs0yZJTbqa7hyWIJjF6kLmnqpXQxo/wv0/VTNMaBwkMlJoQtovqZt5RU2h64
         km+w==
X-Gm-Message-State: AOAM533IvH+H/aTmTFCLxZEeQfQWOMmN+KulM1gFov3a7VfM7DdtZviV
        J3n9FUzSuMvC6+ZttaVrjR4=
X-Google-Smtp-Source: ABdhPJxR9pPHuKmMTSygj6jNjLF69ifM+lKUNj7sgc171+wHOOz4yEmAwGsowRm6x4/GNNMOhGJRFA==
X-Received: by 2002:a17:903:31c9:b029:ed:6f56:9d1e with SMTP id v9-20020a17090331c9b02900ed6f569d1emr6616584ple.46.1624055687773;
        Fri, 18 Jun 2021 15:34:47 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id p20sm10011849pgi.94.2021.06.18.15.34.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jun 2021 15:34:47 -0700 (PDT)
Subject: Re: [PATCH v2] m68k: save extra registers on more syscall entry
 points
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <1623979642-14983-1-git-send-email-schmitzmic@gmail.com>
 <CAHk-=whTKf6UFr6YneXsPU4=8dTs+eEX_861ugESTE3CmZtFUg@mail.gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <91865b90-c597-6119-5e14-dfe521a33489@gmail.com>
Date:   Sat, 19 Jun 2021 10:34:41 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whTKf6UFr6YneXsPU4=8dTs+eEX_861ugESTE3CmZtFUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

Am 19.06.2021 um 05:17 schrieb Linus Torvalds:
> On Thu, Jun 17, 2021 at 6:27 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>
>> I'd need specific test cases to exercise io_uring_setup in
>> particular, to see whether stack offsets for pt_regs and the
>> switch stack have been messed up.
>
> I don't think doing this for io_uring_setup() will help any - the
> problem is not in that system call thread itself, it's purely in the
> kernel thread that it then starts.
>
> And the fact that io_uring_setup() has the full stack frame won't then
> help that kernel thread, for exactly the same reason that was true on
> alpha: copy_thread() will actually _create_ the full stack, but when
> we switch to it (through switch_to() -> resume()), the resume code in
> arch/m68k/kernel/entry.S will switch to that stack, and then do
> RESTORE_SWITCH_STACK which will consume it again.

Now I see ... I had glossed over the point in resume() where the stack 
pointer was switched to the new task.

> So I think m68k should do the same thing as Eric's patch for alpha: do
> the full stack for exit and exit_group, and for kernel thread creation
> - or at least PF_IO_WORKER), do an extra stack frame on the kernel
> stack, so that even after resume() we'll still have another copy of
> the frame.

Is your patch to copy_thread() to add the extra stack frame still needed?

(Eric added switch stack save/restore around the worker thread call in 
ret_from_exception, which pushes back the missing stack contents as far 
as I understand ... )

There seems to be no expectation for kernel worker threads to have valid 
saved user context, just space on the stack for the tracer to read. I'll 
drop saving full context for io_uring_setup in v3.

> The alternative would be to do what x86 does: see __switch_to_asm().
> Instead of doing that normal kernel entry/exit stack (with
> SAVE_SWITCH_STACK and RESTORE_SWITCH_STACK), x86 has it's own very
> special "only for task switching" stack frame thing, and leaves the
> pt_regs etc entirely alone.
>
> Of course, that "only for task switching" is _kind_of_ what the whole
> SAVE_SWITCH_STACK is for - it's part of the name after all - but the
> difference is that on alpha and m68k, it's also (and primarily) the
> "full state" stack frame, used not just for task switching, but for
> signal handling state and for ptrace too.
>
> So in theory, it would be good to split this up:
>
>  (a) have the signal handling and ptrace stack be one thing (maybe
> rename the "SWITCH" part of the operations to something else, like
> "EXTRA" or "SIGNAL" or whatever)

We can rename the macros, but we also expose struct switch_stack in 
uapi/asm/ptrace.h - hard to rename that one.

>  (b) make a separate "for task switching only" stack frame, which is
> used by that switch_to() -> resume() sequence, and that copy_thread()
> has a "struct inactive_task_frame" thing for..

That's more than a bit beyond my m68k assembly level, sorry. Maybe 
Andreas can help if we decide to go that way?

Cheers,

	Michael

>
> That way, the pt_regs/extra_regs stack frame that copy_thread()
> creates wouldn't then be eaten up by the task switch.
>
> But while that sounds like the right thing to do, it would be a rather
> bigger change. I'm not entirely sure it's worth it.
>
> Eric, comments?
>
>                 Linus
>

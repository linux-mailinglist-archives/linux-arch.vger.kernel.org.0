Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD56E3DA954
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhG2Qsw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 12:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG2Qsv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jul 2021 12:48:51 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EC4C061765
        for <linux-arch@vger.kernel.org>; Thu, 29 Jul 2021 09:48:47 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id z3so6549277ile.12
        for <linux-arch@vger.kernel.org>; Thu, 29 Jul 2021 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6BJZPuaSLnqmeDXMAsuvzDiXrxHDYBWei3808F0adGQ=;
        b=mcUsbDjcmq73UEhJ0VDofgm3OcKL4ZJ3bATGRsQJPjweKOkFY510g0MzO1pFLH7Eir
         ceyZFg/r7cPVKZS87e77d/aD631T+Ne4nmpuTsba3Bkrb7+WUxsFKv/9Ohx9MQ1yDHJF
         Gz3t7cIrhkEBl7lA2YofrdAyLNOh1asYULiU6gEmE7A/LDaNGl/P0b1oBuI/CpiFnVme
         6tVZ3UGBVv1IVL7VOvZnk7KSvkQFN1nW7GuxOi4ZlJDzqe4d27OrVFfCFLCv8KiMbqqR
         uKlWlxAFG0okrdv0B3oGccLN9Vu3YdYfQEkl6APXMr9Lu7jGo+E679+qWcnZODswyZnn
         kZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BJZPuaSLnqmeDXMAsuvzDiXrxHDYBWei3808F0adGQ=;
        b=NILcsobZMqM7Rrmay/9MQpzKu5BUaQfphxLCZ7Tq8/sEk9fm0MPjdkQSf/QpW0htjI
         Onj2XKbN1MPmtbsY+eIRP87moB2hSPJGY+E0r14xzh6+Vvt27yAeTb1bawfHEaBFsiPT
         u86Hde/e04IJMovnq1AHudZlkCJcdDQGHLHGdCFZgci+hkJEae23WTai/95l5hhYQ0Ij
         YiD0WhBzfOBa2lTW1C9OV98CeATwHRUQvuCDRMbglQ4Q7GT39iUx3evkA4qR/2kog0C+
         TREWq8KQw31Y5bWk6WUbMROrN9OP9vvS8errWHsgqjqbn6NzXpEu2+kEoBiuBR9rt0F9
         0nYw==
X-Gm-Message-State: AOAM5314EjwpYDpr/97KdIQ4EHpdVTz0XvU8p36SjxCFI9YINPOEbQCh
        v7EEh974J0VfLk+fziR58jd5TXqLB9HIgo7Ha2U=
X-Google-Smtp-Source: ABdhPJyRI2yPdW6aB/2e0QiUGI/jX4f1fwP2Hr4U0G4GKsbL2O/KMexrXWedTnTMBK/kEJkfV8UzhDbCPXUiQxdiewc=
X-Received: by 2002:a92:dc10:: with SMTP id t16mr4068917iln.95.1627577327366;
 Thu, 29 Jul 2021 09:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <CAK8P3a0o1bniPG+pocGtMGV-RVEGVJrQDLmz6SyZ-2NGcq2WnQ@mail.gmail.com>
 <CAAhV-H7Cq10OcQMAGCODoByy+3z7_TQv9vASH0AMt+v2dtrp9A@mail.gmail.com> <CAK8P3a2a8R+pMZykCP5zFCPUzRqdPiBpJuCkmQdMuzL+34DFuw@mail.gmail.com>
In-Reply-To: <CAK8P3a2a8R+pMZykCP5zFCPUzRqdPiBpJuCkmQdMuzL+34DFuw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 30 Jul 2021 00:48:33 +0800
Message-ID: <CAAhV-H7BYczyM4Eor5T2i9M5j-xRumQwKmb9T+UH+eHt9QY58A@mail.gmail.com>
Subject: Re: [PATCH 00/19] arch: Add basic LoongArch support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Chen Zhu <zhuchen@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Wed, Jul 7, 2021 at 3:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jul 7, 2021 at 5:04 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Tue, Jul 6, 2021 at 6:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > 3. 32-bit support: There are small bits of code for 32-bit support everywhere
> > >    throughout the code base, but there is also code that does not look like
> > >    it would work in that configuration. I would suggest you split out all 32-bit
> > >    code into a separate patch, the way you have done for SMP and NUMA
> > >    support. That way it can be reviewed separately, or deferred until when
> > >    you actually add support for a 32-bit platform. Please also clarify which
> > >    modes you plan to support: should every 64-bit kernel be able to run
> > >    LA32R and LA32S user space binaries, or do you require running the same
> > >    instruction set in both kernel and user space as RISC-V does?
> > >    Do you plan to have MIPS N32 style user space on 64-bit kernels?
> > No N32 style user space in our current plan, but the 64-bit kernel is
> > supposed to run 32-bit applications in the near future.
>
> Ok, sounds good. Adding compat support for a native 32-bit ABI has gotten
> a lot easier over time.
>
> On that note, what are the requirements to the kernel for supporting LBT
> with aarch64/mips/x86 tasks? Does this involve handling the system calls
> (ioctl in particular) for those architectures in the kernel as well, or do you
> expect this to be done entirely in user space?
>
> The same topic has come up in the past, as there are at least three projects
> that need support for emulating foreign-architecture system calls (qemu,
> fex and tango). If there is sufficient demand, we may end up generalizing the
> kernel's compat layer to support multiple such ABIs instead of just native
> and compat.
>
> > > 4. Toolchain sources: I see you only have binaries for an older gcc-8.3
> > >     release and no sources so far. I assume you are already busy porting
> > >     the internal patches to the latest gcc and will post that soon, but my
> > >     feeling is that the kernel port should not get merged until we have a
> > >     confirmation from the toolchain maintainers that they plan to merge
> > >     support for their following release. We should however make sure that
> > >     your kernel port is completely reviewed and can just get merged once
> > >     we get there.
> >
> > Toolchain is maintained by other developers, it will be open source of
> > course, I hope it won't be too late. :)
>
> Right, I meant 'you' as in someone @loongson.cn, not necessarily you
> personally.
Now toolchain of LoongArch is open, please take a look at it. I think
there are also something need to change. In order to reduce
compatiability problems in future, please focus on those things
interactive with Linux kernel. Thank you very much!

https://github.com/loongson/glibc/tree/loongarch_2_33
https://github.com/loongson/binutils-gdb/tree/loongarch-2_37
https://github.com/loongson/gcc/tree/loongarch-12

Huacai

>
> > > 5. Platform support: You have copied the underlying logic from arch/mips,
> > >     but that still uses a method where most platforms (not the new
> > >     "generic" version) are mutually exclusive. Since you only support
> > >     one platform right now, it would be best to just simplify it to the point
> > >     where no platform specific code is needed in arch/loongarch/ and
> > >     it just works. If you add 32-bit support later on, that obviously requires
> > >     making a choice between two or three incompatible options.
> >
> > I will improve it, and I will need some help for this.
>
> It should be mostly covered by the comments I made on the individual
> comments already, but let me know if you have more specific questions.
>
>        Arnd

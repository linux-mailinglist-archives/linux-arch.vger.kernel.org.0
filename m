Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28A53BE143
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jul 2021 05:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhGGDHp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 23:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGGDHo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 23:07:44 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCDBC06175F
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 20:05:04 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h6so1229780iok.6
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 20:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNh614jocMWheD92rk85riRpsMx3rhGNPpPR4yP/ZDs=;
        b=QfoRhS9jNcCwnzNT6WDXEGD4gMtlpEjXUaN4Os4kBwls/8rCUozx9K71C++V0p8HJq
         YEbgjX0Ph7fnprjooFPd65y3jpHL+J+71ycisL+EoYvUJTuqFDC921LQd85Jn8vrlSMu
         AUJoR0Xl5ut6oNJGH56mP/WFjWfFHS/sHWMguOsiPGlD4JBLK42KLdzQsBpPmKnV/Y+B
         hTThk0MFDs+kAk/jG3aA7+nVMjpRjWcEFlYIejVXecWSlj7uoi8rcl186/Y52ZC3B5HO
         ozXBPYs1F06Qd+D2Tx7whxLUb+1hP4sxuPqYS3olyB+RCJ/7MJUhqB1nPWYrauojvE6b
         uGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNh614jocMWheD92rk85riRpsMx3rhGNPpPR4yP/ZDs=;
        b=iazcGCRzwhHAPx9g+bOpGbftQIaQx5zfX+E/ZlwUTNl/QMZaNDDU9ynY2xgsNm3aWQ
         ZzF/Q56aEspzF0fkTCMmzLh9EMDLEmmWog+B/76hhQqyFmD6vigmmAoqhRGGO3fCupoD
         hXesw6zzqZcbyxlAD4OwW3ilurNrVLmuwYyw10pMSNtIoiYPqc1fWmaxMTt07ByaD1hJ
         urFBiSDnY7yuj5tisAWTrIpGRaLm64N8cTE1p4nDiyZmTbSnNpajI1iRpAzVpYjIHWkp
         s8+W6t0PXwHqcCgsuIQAEyzd0oo2okofxIKQyuAxoV7eohWfwfCgSIXSRNhLPJ6vC0Hi
         o2AQ==
X-Gm-Message-State: AOAM533Kg/hDIaUwbFPSNCKwaYnUyN+KEKewJ7SwhsOw6afARoN0qzCQ
        2EJhgEmgFyJTiP1lnOaUAWbNhDfzTHjhpII/lyU=
X-Google-Smtp-Source: ABdhPJx9mPW+K19X3hkT0qR6Ph1uOTJsceY0yUvKrefJab2QY4RF6iI3SS0quR/2mT7iYQasF0x4m+owGFRDHTnhxJU=
X-Received: by 2002:a5e:a80b:: with SMTP id c11mr18450451ioa.94.1625627103611;
 Tue, 06 Jul 2021 20:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <CAK8P3a0o1bniPG+pocGtMGV-RVEGVJrQDLmz6SyZ-2NGcq2WnQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0o1bniPG+pocGtMGV-RVEGVJrQDLmz6SyZ-2NGcq2WnQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 7 Jul 2021 11:04:51 +0800
Message-ID: <CAAhV-H7Cq10OcQMAGCODoByy+3z7_TQv9vASH0AMt+v2dtrp9A@mail.gmail.com>
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

On Tue, Jul 6, 2021 at 6:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> > LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> > version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> > boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> > are already added in the next revision of ACPI Specification (current
> > revision is 6.4).
> >
> > This patchset is adding basic LoongArch support in mainline kernel, we
> > can see a complete snapshot here:
> > https://github.com/loongson/linux/tree/loongarch-next
> >
> > Cross-compile tool chain to build kernel:
> > https://github.com/loongson/build-tools/releases
> >
> > Loongson and LoongArch documentations:
> > https://github.com/loongson/LoongArch-Documentation
> >
> > LoongArch-specific interrupt controllers:
> > https://mantis.uefi.org/mantis/view.php?id=2203
>
> Thanks a lot for your submission, I've been waiting for this, and have just
> completed an initial quick review, will send out the individual replies in a
> bit.
Thanks for your reply. I will reply to other mails with some delays
because I need some time to absorb so much information.

>
> I have a few high-level comments about things that need to be improved
> before merging:
>
> 1. Copyright statements: I can see that you copied a lot of code from arch/mips,
>  and then a bit from arch/arm64 and possibly arch/riscv/, but every file just
>  lists loongson as the copyright holder and one or more employees as authors.
>  This clearly has to be resolved by listing the original authors as well.
As you know, old Loongson processors are based on MIPS, so we are
familiar with MIPS, from hardware designer to software developer. This
is the root cause why we copy so much code from MIPS, and LoongArch
actually has many similarities as MIPS. But anyway, it is our fault to
remove the copyright holders, so this will be resolved, of course.

>
> 2. Reducing the amount of copied code: my impression is that the bits you
>    wrote yourself are generally of higher quality than the bits you copied from
>    mips, usually because those have grown over a long time to accommodate
>    cases you should not worry about. In cases where there was no generic
>    implementation, we should try to come up with a version that can be shared
>    instead of adding another copy.
We know MIPS is out of date, but our knowledge is not enough, so we
are not able to find the best way always, and the MIPS code "just
works". This will be improved in future versions.

>
> 3. 32-bit support: There are small bits of code for 32-bit support everywhere
>    throughout the code base, but there is also code that does not look like
>    it would work in that configuration. I would suggest you split out all 32-bit
>    code into a separate patch, the way you have done for SMP and NUMA
>    support. That way it can be reviewed separately, or deferred until when
>    you actually add support for a 32-bit platform. Please also clarify which
>    modes you plan to support: should every 64-bit kernel be able to run
>    LA32R and LA32S user space binaries, or do you require running the same
>    instruction set in both kernel and user space as RISC-V does?
>    Do you plan to have MIPS N32 style user space on 64-bit kernels?
No N32 style user space in our current plan, but the 64-bit kernel is
supposed to run 32-bit applications in the near future.

>
> 4. Toolchain sources: I see you only have binaries for an older gcc-8.3
>     release and no sources so far. I assume you are already busy porting
>     the internal patches to the latest gcc and will post that soon, but my
>     feeling is that the kernel port should not get merged until we have a
>     confirmation from the toolchain maintainers that they plan to merge
>     support for their following release. We should however make sure that
>     your kernel port is completely reviewed and can just get merged once
>     we get there.
Toolchain is maintained by other developers, it will be open source of
course, I hope it won't be too late. :)

>
> 5. Platform support: You have copied the underlying logic from arch/mips,
>     but that still uses a method where most platforms (not the new
>     "generic" version) are mutually exclusive. Since you only support
>     one platform right now, it would be best to just simplify it to the point
>     where no platform specific code is needed in arch/loongarch/ and
>     it just works. If you add 32-bit support later on, that obviously requires
>     making a choice between two or three incompatible options.
I will improve it, and I will need some help for this.

Huacai
>
>         Arnd

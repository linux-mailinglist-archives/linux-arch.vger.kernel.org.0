Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46153EA3C4
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 13:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhHLLca (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 07:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbhHLLc3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 07:32:29 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80963C061765
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:32:04 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id k3so6491451ilu.2
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LLWbypFYtmmhpbofF5TQROLKFJee5lG0VaWrUd5101c=;
        b=VI4VFK/PZglf40eNW4NpTC3MKUixGyPsgiiA0Bsg0N8uDU2dfXEDfw8sNiszR/rjdy
         N/zyCfTJPd+POiUDhFeIXeZ1mALnrG7QAwmMw3XX69Kdqg5h6IK8xCY6xrtATp+xi5LR
         QjqEDppdXq1OVFkp7WN674DmRO00/sGzBJXDPKWEU4vT1quVA3En5qsD5Jr82JQ/b+6w
         nY/ivXCK39Mf4yHqbjWAIXWpNvXJ93SLuJgvCvXdjb+I3SqBqwRAliXcu0Auzjc2TRUD
         9zOhmA+fAG/ejShY015c/i7sx012tj1ptUewJrabxIc8ILLUobd+Pw41PeX9sDw5sZ7U
         oOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LLWbypFYtmmhpbofF5TQROLKFJee5lG0VaWrUd5101c=;
        b=XRsjyjW3If4hA46oDFa8krg+YEwzCVY0eDsFplV/KIMnOn0P7QMSXaSJGDCqzSWzyi
         XaO7aKFIj8qXfw5E7v32e7ARS5vcm+8d8Et4EqcPZXz+P7r6nnm4szdYAcvrtUAiBtaO
         FHC/MtAH2rdLtU/qjBlRrH6sEFZqh7/FpyaLVWhQ6hn2s+VA/Xeg6z8nAwmj2lPTmOXj
         HZ5kpRkhAUR44LFVPi/TeLn/o9DLMjc9ZYwMxVYfup4ljejl35GzyAhkL7K1k27Enp6g
         qDcpVdY7FwAKozt+Q7oi+2v6/X66Ch1oDc4ug4lY7qB/tOMvXYT/XsC2ZZ5jpsppaKKh
         ZjEA==
X-Gm-Message-State: AOAM5306vF83iEnpfYmO33k5550Dph3lnW4PDW/zo0y3oouYRG1A4HIX
        9PJy/6eyK+KtYnyIUyc/SHINu11JOyegaOfj9mk=
X-Google-Smtp-Source: ABdhPJwHJwkQ8vvzaKoD2Kyf7FTuvuJH5jzz/AsZ2kzPIEtt1hzirEZD9p8hiX0IRX9as2RaGeURUnT5L+vgdGrdu7g=
X-Received: by 2002:a05:6e02:2199:: with SMTP id j25mr2554884ila.97.1628767923937;
 Thu, 12 Aug 2021 04:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-17-chenhuacai@loongson.cn> <CAK8P3a10NN4mZYtzEEiYv8jqPZbMH-LH406cZV6M4HXhr-Z9yQ@mail.gmail.com>
In-Reply-To: <CAK8P3a10NN4mZYtzEEiYv8jqPZbMH-LH406cZV6M4HXhr-Z9yQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 12 Aug 2021 19:31:52 +0800
Message-ID: <CAAhV-H4CngxKBnZPyheMFgWcZvWVrinvBQ4UJhD=vGr+TBBk2g@mail.gmail.com>
Subject: Re: [PATCH 16/19] LoongArch: Add VDSO and VSYSCALL support
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Tue, Jul 6, 2021 at 6:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > This patch adds VDSO and VSYSCALL support (gettimeofday and its friends)
> > for LoongArch.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/asm/vdso.h             |  50 +++
> >  arch/loongarch/include/asm/vdso/clocksource.h |   8 +
> >  .../loongarch/include/asm/vdso/gettimeofday.h | 101 ++++++
> >  arch/loongarch/include/asm/vdso/processor.h   |  14 +
> >  arch/loongarch/include/asm/vdso/vdso.h        |  42 +++
> >  arch/loongarch/include/asm/vdso/vsyscall.h    |  27 ++
> >  arch/loongarch/kernel/vdso.c                  | 132 ++++++++
> >  arch/loongarch/vdso/Makefile                  |  97 ++++++
> >  arch/loongarch/vdso/elf.S                     |  15 +
> >  arch/loongarch/vdso/genvdso.c                 | 311 ++++++++++++++++++
> >  arch/loongarch/vdso/genvdso.h                 | 122 +++++++
> >  arch/loongarch/vdso/sigreturn.S               |  24 ++
> >  arch/loongarch/vdso/vdso.lds.S                |  65 ++++
> >  arch/loongarch/vdso/vgettimeofday.c           |  26 ++
>
> I fear you may have copied the wrong one here, the MIPS implementation seems
> more complex than the rv64 or arm64 versions, and you should not need that
> complexity.
>
> Can you try removing the genvdso.c  file completely? To be honest I don't
> see why this is needed here, so I may be missing something, but the other
> ones don't have it either.
OK, VDSO needs to be refactored.

Huacai
>
>
>        Arnd

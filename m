Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6494F436FE6
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 04:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhJVCVT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 22:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJVCVQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 22:21:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42FAC061764;
        Thu, 21 Oct 2021 19:18:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y4so1738859plb.0;
        Thu, 21 Oct 2021 19:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQKje0AqFwDCTyJBC38SZqAvyBp0gWUAwYNALedOFkw=;
        b=ap0gm2cWG9NNBXcbcBd24LRTgN7sOth0eIAke7a/Xxrd1JdQrlsUm4xLoGRUO+EW6y
         Ll5Vtfg8Q+PRwKVF5hL2noeAxBe6ceUwg7j1q+wGzrPHa85KWsfdF4Mw9yloCmNoOoG3
         iDlnbuzDnTgB9aamZAOk24sxXdKADFQjn3wr3msV4agB/fK4lr/8OyILEppo0nqpq6hF
         rKR07j+NuVCCM/wJlshcSyb2cMA9/gpNV5j33vcZFfWd0n26eqlii6ttoBQvqa/DR2Ug
         Q3IlkAVVR4rOuvIETXbNqlUXPT1/jowHA0kNSaQBa/r+Rl8Hh+cnKZPynN6PaaYB3sQS
         R2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQKje0AqFwDCTyJBC38SZqAvyBp0gWUAwYNALedOFkw=;
        b=R9U+hzWtDXHskdPVkRltqS0/seYlbv+1CvCmERqLIPBsoLWbKEPlVqqHj94MYG4Krw
         LgSNWEQQ8xvKTMr+bkXXrS4ejbhBSSbqipwsv81yEOxWqTzirmMb8uBb0i9DFShQFcNA
         QC2Yew/x/5iUs7douwugXKKnNaXrzQ3qGHKsMWbU50zw+ob++9dOUt8abbXgn/ONg1zs
         /1upepM4Ue74OroCQv7tJu+JX6mO/DeesLe3rMxD2Zvogd63pluiUpbRHvIDGL/9x/Pw
         GIN1GsBhT0wj1EELeyJHlIY+pdDKcu4f4uiQ1o1rrSOI0JGief7HVVm1cFlFxUYcFQpF
         1WpA==
X-Gm-Message-State: AOAM531gnS/EUDsvij/AC3S4V01V1gRWGxkIJ5K60w0NPeMmOqsxxW7z
        +BYkx21T5oEWBcM5Ac5mHx2A+Jp57JDROnR9eziukGtgEV8=
X-Google-Smtp-Source: ABdhPJzH6gvYQwMelz8MkyZ6c5kphs8nR7/+XwTmfbc88coGLGQ33okMENsfTZ4yyC/cb8EOBn2vj4ZREbmbPoRP4nA=
X-Received: by 2002:a17:902:ea0a:b0:13e:8b24:b94 with SMTP id
 s10-20020a170902ea0a00b0013e8b240b94mr8661852plg.45.1634869139087; Thu, 21
 Oct 2021 19:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631583258.git.chenfeiyang@loongson.cn> <3907ec0f-42a0-ff4c-d4ea-63ad2a1516c2@flygoat.com>
 <CACWXhK=YW6Kn9FO1JrU1mP_xxMnEF_ajkD6hou=4rpgR2hOM5w@mail.gmail.com>
 <20210921155708.GA12237@alpha.franken.de> <ef429f0f-7cc9-2625-3700-47dc459ee681@wanyeetech.com>
 <8a6f5c78-62c0-5d58-1386-dabfcacc112a@wanyeetech.com> <alpine.DEB.2.21.2110182128090.31442@angie.orcam.me.uk>
 <CACWXhK=Au5qc96NBQObHnLAL+4wNMqo6apvK5-572Hohs8OrYQ@mail.gmail.com> <alpine.DEB.2.21.2110191004440.31442@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2110191004440.31442@angie.orcam.me.uk>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Fri, 22 Oct 2021 10:19:20 +0800
Message-ID: <CACWXhKnU2=eVxsAUYqaK9VN0ZG3=iZiZ_cf=w-7gBNt1pdZasA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] MIPS: convert to generic entry
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, arnd@arndb.de,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        chenhuacai@kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 19 Oct 2021 at 16:33, Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Tue, 19 Oct 2021, Feiyang Chen wrote:
>
> > > > Score Without Patches  Score With Patches  Performance Change SoC Model
> > > >        105.9                102.1              -3.6%  JZ4775
> > > >        132.4                124.1              -6.3%  JZ4780(SMP off)
> > > >        170.2                155.7             -8.5%  JZ4780(SMP on)
> > > >        101.3                 91.5              -9.7%  X1000E
> > > >        187.1                179.4              -4.1%  X1830
> > > >        324.9                314.3              -3.3%  X2000(SMT off)
> > > >        394.6                373.9              -5.2%  X2000(SMT off)
> > > >
> > > >
> > > > Compared with the V1 version, there are some improvements, but the performance
> > > > loss is still a bit obvious
> > >
> > >  The MIPS port of Linux has always had the pride of having a particularly
> > > low syscall overhead and I'd rather we didn't lose this quality.
> >
> > Hi, Maciej,
> >
> > 1. The current trend is to use generic code, so I think this work is
> > worth it, even if there is some performance loss.
>
>  Well, a trend is not a proper justification on its own for existing code,
> and mature one for that matter, that works.  Surely it might be for an
> entirely new port, but the MIPS port is not exactly one.
>
> > 2. We tested the performance on 5.15-rc1~rc5 and the performance
> > loss on JZ4780 (SMP off) is not so obvious (about -3%).
>
>  I've seen teams work hard to improve performance by less than 3%, so
> depending on how you look at it the loss is not necessarily small, even if
> not abysmal.  And I find the figure of almost 10% cited for another system
> even more worrisome.  Also you've written the figures are from UnixBench,
> which I suppose measures some kind of an average across various workloads.
> Can you elaborate on the methodology used by that benchmark?

Hi, Maciej,

UnixBench uses multiple tests to test various aspects of the system's
performance:

- Dhrystone test measures the speed and efficiency of non-floating-point
  operations.
- Whetstone test measures the speed and efficiency of floating-point
  operations.
- execl Throughput test measures the number of execl() calls that can be
  performed per second.
- File Copy test measures the rate at which data can be transferred from one
  file to another, using various buffer sizes.
- Pipe Throughput test measures the number of times (per second) a process
  can write 512 bytes to a pipe and read them back.
- Pipe-based Context Switching test measures the number of times two
  processes can exchange an increasing integer through a pipe.
- Process Creation test measures the number of times a process can fork and
  reap a child that immediately exits.
- Shell Scripts test measures the number of times per minute a process can
  start and reap a set of one, two, four and eight concurrent copies of a
  shell script where the shell script applies a series of transformations
  to a data file.
- System Call Overhead test measures the cost of entering and leaving the
  operating system kernel.

In these tests above, the most affected is the System Call Overhead test,
and I'll go into more detail about how it's measured.

The System Call Overhead test counts the sets of system calls that are
completed within the specified time (usually 10 seconds). By default, a set
of system calls contain close(), getpid(), getuid(), and umask(). We call
the test score "index". Specifically, the score for this test is calculated
as follows:

product = log(count) - log(time / timebase)
result = exp(product / iterations)
index = result / baseline * 10

"timebase" and "baseline" are fixed values that are different for each test.
Scores for other tests are calculated in a similar way. The final total
score is calculated as follows (The total number of tests is "N"):

index = exp((log(result1) + log(result2) + ... + log(resultN)) / N) * 10

>
>  Can you tell me what the performance loss is for a cheap syscall such as
> `getuid'?  That would indicate how much is actually lost in the invocation
> overhead.

We use perf to measure the sys time of the the following program on Loongson
3A4000:

int main(void)
{
    for (int i = 0; i < 10000000; i++)
        getuid();
    return 0;
}

The program will take about 1.2 seconds of sys time before the kernel is
patched, and about 1.3 seconds after the kernel is patched.

>
>  With that amount known, would you be able to indicate where exactly the
> performance is getting lost in generic code?  Can it be improved?

Sorry, we tried to use perf to analyze the extra time, but have no idea at
the moment, since most of the code is located in __noinstr_text_start.

Thanks,
Feiyang

>
>   Maciej

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBBF3C2184
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jul 2021 11:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhGIJ1j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jul 2021 05:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhGIJ1j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jul 2021 05:27:39 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD20C0613DD
        for <linux-arch@vger.kernel.org>; Fri,  9 Jul 2021 02:24:56 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id k11so11760903ioa.5
        for <linux-arch@vger.kernel.org>; Fri, 09 Jul 2021 02:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5Ob00/jKbmKkG1HdKeEb25b3wYm0hP9FPlKP1Yr52w=;
        b=n+tE8nEXg8f4jKNmIDeXsFoXfoFc7ZboXynMEpa+yctf30H5HCeNxp/IcaJQl3XVok
         yI7rik75p/W7E4QOEMlzToDoGMYiZ8gil8aUdb2QjhDRnCXzYNHEVX3CoODUegdh+JEb
         +M57mRZ9zSKfpXSXp6Ug9frfcqrzOKqG3Rfsonb4hg5PK1kHIprKgQ/CLvfju7wh1ciZ
         9MszWvXEts/k5qz393Py4dqfb5wt5cIRfmWcUXZxBXcdV09Sp0VpXuEvSjyRU9s50B4o
         gXeAB0F/a/rikzDimUlU2BlQS5wtB9YtQ3FKYVXaxBrcXNJeuJoDzUNn4LDNhArximvM
         WgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5Ob00/jKbmKkG1HdKeEb25b3wYm0hP9FPlKP1Yr52w=;
        b=Td7zi2TL3Q5daldDK7PP3aHVDPJHKfX4dwtyBd2It9/uh3tjYMppRDlmMdtHM7ip5k
         UA56QyYt9XiUshRABqCPEvjcqt7RVv9yaaKX06bD4w1q93axGF0ToV4GcoL0I+wA5aR+
         X8smjhZDIuhWRCZj5DoH88MNP0+c6fkguDnhoIchQTmozJ+VWAimn0PLyCEYKUSTucq4
         0z1mg5oojDanSMGTFV8wvFRLRH74WTuAGZdHAMp3vgtGJE5sFSZJYYXdzM4oLzS/6nIq
         eW4We4+jfieYXiU1bOMJG6SFmNYzmI2bmEYhJZTOaIaYDWRQ9KiOm2t5oxP5JVGv3dQc
         wiHQ==
X-Gm-Message-State: AOAM533jN0dPpKRfoP8eNtbMIs4UQLYjsZvZK1sBiYVoiRwCh7jHBM0H
        rmHn7tPDoO2/B6HY/EnQeBHu8LnA2657pyaMSfW1YYm2UJGq2Sjo
X-Google-Smtp-Source: ABdhPJwS6POnzcsBP0UHV8xem8Waml0Kj+ej5BD3m4EC/t8gLbNwpENcO4jYMoVgeFOLGeRl6zQzkmIqg3sJjpES/Jw=
X-Received: by 2002:a5e:8612:: with SMTP id z18mr11072835ioj.38.1625822695634;
 Fri, 09 Jul 2021 02:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-11-chenhuacai@loongson.cn> <CAK8P3a0zkiFrn9K14Hg8C-rfCk-GbyTGMnq_DFBd8o28q99tRg@mail.gmail.com>
 <CAAhV-H4WtGqgYF_zDhaS9+Ja7k=Zs8O2qWo5GqHDDf5cKw-zow@mail.gmail.com> <CAK8P3a1GQ=P-kNB5+wUkyqV0uD11uHCJZSQ7gbkwjev0GhuJTQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1GQ=P-kNB5+wUkyqV0uD11uHCJZSQ7gbkwjev0GhuJTQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 9 Jul 2021 17:24:44 +0800
Message-ID: <CAAhV-H4Yqo090vmy0Y7hGzguP9Q_C+EuZvsq7D43dA=J0f_1qA@mail.gmail.com>
Subject: Re: [PATCH 10/19] LoongArch: Add signal handling support
To:     Arnd Bergmann <arnd@arndb.de>, yili0568@gmail.com
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
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Thu, Jul 8, 2021 at 9:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 8, 2021 at 3:04 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Tue, Jul 6, 2021 at 6:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > +
> > > > +#ifndef _NSIG
> > > > +#define _NSIG          128
> > > > +#endif
> > >
> > > Everything else uses 64 here, except for MIPS.
> >
> > Once before we also wanted to use 64, but we also want to use LBT to
> > execute X86/MIPS/ARM binaries, so we chose the largest value (128).
> > Some applications, such as sighold02 in LTP, will fail if _NSIG is not
> > big enough.
>
> Have you tried separating the in-kernel _NSIG from the number used
> in the loongarch ABI? This may require a few changes to architecture
> independent signal handling code, but I think it would be a cleaner
> solution, and make it easier to port existing software without having
> to special-case loongarch along with mips.
Jun Yi (yili0568@gmail.com) is my colleague who develops LBT software,
he has some questions about how to "separate the in-kernel _NSIG from
the number used in the LoongArch ABI".

Huacai
>
>       Arnd

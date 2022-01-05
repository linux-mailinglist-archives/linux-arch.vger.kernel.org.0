Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC55485035
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 10:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiAEJkv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 04:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiAEJku (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 04:40:50 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EB0C061761;
        Wed,  5 Jan 2022 01:40:50 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id c36so42429485uae.13;
        Wed, 05 Jan 2022 01:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1JabUfioaXQzQJ9cyfx4bPbapY2g1hoPELFMnBeqJw=;
        b=G7N8XSF+kA5XWE1zgOstxJvehCpGUEZNO5dt96BFGSWnakr+tcAYbKh6C3hs4GOoyu
         Yhdo0/6j6EYnE6dWUYfN/foAc9o8Q/mFEQfELPEUn5M6/EN3NpmtBRob4BSPydMEuRft
         Zuc7xVhZy4hy7KQ71MDbvq/60q09Ls8n0//sM5h1yHR/pBVN6qClzOOBNMpjVEhFZket
         sD6tucMhDg3NDunnoqvq3/iIVSCs4pTVBnCmgDHEMAmnJwiDQrnAOwNE1jrUQCiwEsTm
         4KVfwV+NoZRomdBuTDEwlm1qHrQgLLWvi5GukJG7u/1phHUErZGVIonPrgrevkuZjk0x
         +ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1JabUfioaXQzQJ9cyfx4bPbapY2g1hoPELFMnBeqJw=;
        b=OReKEHzxdRHZ4my4+lUuaIRK/UgtTurJCM7GfvxnGs08UQwQpW3YL1K5PzLaD5ci/2
         bSiczkSWDpmxQnPY0IAjZn8YLIou/sEDVoBH8c0ar+6EIFArx55E5hb2ShfuQCoJMTv/
         CzMDgHCqAGR4gcbGg+lZqkvaa0bf5DVaMGdgFJju3X22XfQKTjWzlBz/0CU/KMzE+iwi
         KMfUAlan1l7RtWbQoa1nuQHJOL9XH0vOt4aVqAmodWoTYeOgbZrV/Cuc33v7rpfTMmXM
         8QWE13ufNvUfTWfQ5EBmj45SwgEeGAoIiSGzTkxTMJ7C637vPKOCaymTrdS4R5rMeqWA
         /3IA==
X-Gm-Message-State: AOAM533q4x352/CsVh48CSvan0zzdyLKe85qf7tb2oMNQ2QkduOYM6KX
        M8J44EFh1eCU7FyB0gaXixCyUxlAU3Eb8zH1rJH+u7F/S1E=
X-Google-Smtp-Source: ABdhPJwHDpzSWJ/HD9aDpmk46Nd2vRr9D/1sJ/QYCx0rcjjI2aiEOYE0Fh+nDGNm45mVSwWAf7u5ojdUjsBROja5WTw=
X-Received: by 2002:a05:6102:ec2:: with SMTP id m2mr17000808vst.6.1641375649657;
 Wed, 05 Jan 2022 01:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20211013063656.3084555-1-chenhuacai@loongson.cn>
 <722477bcc461238f96c3b038b2e3379ee49efdac.camel@mengyan1223.wang>
 <CAAhV-H40oWqkD+tQ3=XA8ijQGukkeG5O1M1JL3v5i402dFLK+Q@mail.gmail.com> <587ab54d77af2fb4cdbe0530cdd5e550c3e968db.camel@mengyan1223.wang>
In-Reply-To: <587ab54d77af2fb4cdbe0530cdd5e550c3e968db.camel@mengyan1223.wang>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 5 Jan 2022 17:40:49 +0800
Message-ID: <CAAhV-H6R=xWL18AH7HzeXHOVD_d-5m7RvdQCLkOR1NeDZ_0HMw@mail.gmail.com>
Subject: Re: [PATCH V5 00/22] arch: Add basic LoongArch support
To:     Xi Ruoyao <xry111@mengyan1223.wang>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ruoyao,

The problem still exists in 5.16-rc8, can you try to change
cpu_relax() definition to smp_mb()? It seems can fix the problem.

Huacai

On Tue, Dec 28, 2021 at 4:34 PM Xi Ruoyao <xry111@mengyan1223.wang> wrote:
>
> On Tue, 2021-12-21 at 15:53 +0800, Huacai Chen wrote:
>
> > On Mon, Dec 20, 2021 at 5:04 PM Xi Ruoyao <xry111@mengyan1223.wang>
> > wrote:
> > >
> > > The snapshot panics on my system under high pressure (building and
> > > testing GCC).  The panic message is pasted, but it's kind of broken up
> > > likely because multiple CPU cores were outputing to the serial console
> > > simutaniously.
> > >
> > > The config is attached.  I'm not sure the reason of the panic (bug in
> > > the patches or bug in mainline kernel?) Do you have some pointers to
> > > diagnostic and fix the issue?
> > >
> > > [ 5391.004745] CPU 1 Unable to handle kernel paging request at virtual address 000000000040007e, era == 90000000003aa07c, ra == 90000000003aa84c
>
> /* snip */
>
> > We also found that the latest github kernel has some stable issues,
> > and we are investigating.
>
> I rebased the patches onto 438645193e59e91761ccb3fa55f6ce70b615ff93 and
> the problem *seems* gone.  Not sure if it's something fixed in the
> mainline or some more strange thing.
> --
> Xi Ruoyao <xry111@mengyan1223.wang>
> School of Aerospace Science and Technology, Xidian University

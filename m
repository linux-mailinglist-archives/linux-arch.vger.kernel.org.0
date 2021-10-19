Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7770432BBE
	for <lists+linux-arch@lfdr.de>; Tue, 19 Oct 2021 04:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhJSCYk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 22:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhJSCYj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Oct 2021 22:24:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE1EC06161C;
        Mon, 18 Oct 2021 19:22:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id o133so16281262pfg.7;
        Mon, 18 Oct 2021 19:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIxys+02dACBgAAWK22WWSvyl2SrlSH2RsPmfZbyBhc=;
        b=BDlN1PvPPDgx5tNxnHcaLqo+2y5VIhIEQWlWm5BkJ6pu4vPG2PID7N0oFCEQFTg9p3
         quGjDry7DnBqZesoOuWQf90+89+hSUP63DTcTQnpv679lTCKDuhlWctq9UWs8rZtC2Kw
         B+raVrgoDMCdmx82fyyFrU6fmofdm2pXkhnommEFvvxJK/P/Kl0hemIPbA4u/LdKo4cV
         HHRZ+7Ki90TGTP9+MFVlUmKklx7WNcNK7w1S8Z7hQyAPgow80AOOCyZL3G1gosTQ73Kx
         am4k0AZpuyONLw7rEKcvBf95QKg20yWkpzMbfSZlK5cLe6v5MqSQG/VnGmKvVl8C+dss
         NiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIxys+02dACBgAAWK22WWSvyl2SrlSH2RsPmfZbyBhc=;
        b=sAXX/+gwE5vuufpH8UdtF+1qSum9w7IPsWNOobD/Gjw/qppUDqdR8RgZGgP1zWD9eZ
         /a/K2wcEZGcHNzsvgXvilC/q0MoqVD5OKddPaKQCMs/3M/ll9elSqqoAZMWzgItI52Mj
         yKVDX8Pt/pUGyOOKVW+fefNmCDhLa/m6ZhD/m9FJYrg6m7EQ3/17WknVYcw+PlWWV9X2
         67TtoamybCGfw5JqrESz3irLZhpjRzNjTSP2m335/smqITUzmxveDndmyYVBNYU321fu
         y0+kQnnsouKuT12qC/rUYDDP5rntTbsnh8DDuVgixEqmthaiuVAueCsYU9Grtj3jBG/7
         TlhA==
X-Gm-Message-State: AOAM530HVqJlogPgsF4QLBFcfmzR1avbCCYHduVHp6XtgZmkFg6kYzfV
        tH0QmszYbJ+sq/nCR4/qIkrZYk2i2MQSZIzL2j0=
X-Google-Smtp-Source: ABdhPJxv9BdPv8N0bdSg7pQ+PK5Htlp+4f4qoJSSIGrVakIESYgFuVZMDt5HoY0PLP14JKgY+q2RfgwiYlPO6RMAdYE=
X-Received: by 2002:a62:5209:0:b0:44c:68a7:3a61 with SMTP id
 g9-20020a625209000000b0044c68a73a61mr32415690pfb.83.1634610147003; Mon, 18
 Oct 2021 19:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631583258.git.chenfeiyang@loongson.cn> <3907ec0f-42a0-ff4c-d4ea-63ad2a1516c2@flygoat.com>
 <CACWXhK=YW6Kn9FO1JrU1mP_xxMnEF_ajkD6hou=4rpgR2hOM5w@mail.gmail.com>
 <20210921155708.GA12237@alpha.franken.de> <ef429f0f-7cc9-2625-3700-47dc459ee681@wanyeetech.com>
 <8a6f5c78-62c0-5d58-1386-dabfcacc112a@wanyeetech.com> <alpine.DEB.2.21.2110182128090.31442@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2110182128090.31442@angie.orcam.me.uk>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Tue, 19 Oct 2021 10:22:47 +0800
Message-ID: <CACWXhK=Au5qc96NBQObHnLAL+4wNMqo6apvK5-572Hohs8OrYQ@mail.gmail.com>
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

On Tue, 19 Oct 2021 at 03:32, Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Wed, 13 Oct 2021, Zhou Yanjie wrote:
>
> > > > can people, who provided performance numbers for v1 do the same for v2 ?
> > >
> > >
> > > Sure, I will test the v2 in the next few days.
> >
> >
> > Sorry for the delay, It took a lot of time to migrate the environment to my
> > new computer, here is the results:
> >
> >
> > Score Without Patches  Score With Patches  Performance Change SoC Model
> >        105.9                102.1              -3.6%  JZ4775
> >        132.4                124.1              -6.3%  JZ4780(SMP off)
> >        170.2                155.7             -8.5%  JZ4780(SMP on)
> >        101.3                 91.5              -9.7%  X1000E
> >        187.1                179.4              -4.1%  X1830
> >        324.9                314.3              -3.3%  X2000(SMT off)
> >        394.6                373.9              -5.2%  X2000(SMT off)
> >
> >
> > Compared with the V1 version, there are some improvements, but the performance
> > loss is still a bit obvious
>
>  The MIPS port of Linux has always had the pride of having a particularly
> low syscall overhead and I'd rather we didn't lose this quality.

Hi, Maciej,

1. The current trend is to use generic code, so I think this work is
worth it, even if there is some performance loss.
2. We tested the performance on 5.15-rc1~rc5 and the performance
loss on JZ4780 (SMP off) is not so obvious (about -3%).
3. Yanjie, is there any problem with the code base you tested?
Could you help to test patch v3 on the latest mainline kernel?

Thanks,
Feiyang

>
>  FWIW,
>
>   Maciej

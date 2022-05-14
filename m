Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96B25271B4
	for <lists+linux-arch@lfdr.de>; Sat, 14 May 2022 16:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiENONI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 May 2022 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiENONE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 May 2022 10:13:04 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053FA140F3;
        Sat, 14 May 2022 07:13:02 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id y74so11169852vsy.7;
        Sat, 14 May 2022 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1i1F8HA8SXw91VCcJkd0PDhnz+7pwWJ7etAarJLpsYc=;
        b=UhhF5+ErMt0QBRHo3cb0CIi7PPt6V1b0Kl8TkcsbidISlait2xK3HZnrykYh8MPAKN
         pJVobsLGBXBz3IoRT42AETIIwJUfoKic28GhUYSshM/yOaH1TexpPCfmy1Nrc919sbKn
         MRpHSDEImOLuIWvlSMs4MsNpcRglUvPhgh0KDKHbushmpMekGaPNLWMGNkVNmJx2G9q6
         +q6uDU/6WuyxS70uKQYRgs6XDV4EiMlA+JUdKX0hhgf6ecvIEx12JRDQSGDShnPVjTwK
         vn2hOZRte/SHLCarmLqDkUbf5A+35Ii+W0LTVIKrOQqc2Cize+zKsnQYeUwv55JoN31N
         dk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1i1F8HA8SXw91VCcJkd0PDhnz+7pwWJ7etAarJLpsYc=;
        b=ZCW+XHF8HpnHUdG+Yooo8axwYTs2A8F5EmmgmPJ/FkYcg25DsVSeDSIBjvYdmcbr3r
         bzdcbRKePTOnzYnSdtQQjfHTZIFJ/sr2v8vr8OwGGA8T+YAXk/glo++ZqwZprJugvIGC
         5jL2wK1C5EVIA3c/DAjBAm9clUTBRCLSoj4PI3RJ/aVdBD8X45dvJZmiYz7E483VWv5I
         lGYcBDJsryDzIFzrWDnBfwWKwbBF7wlfIG3yLzUTVf+Hfk1v6U1wEVi+uHXZxgreHLAR
         n72VgaL4c5Ojxafao3XF0Oyk1Ci5VCT9aaDyDQgYn/0Vc4FN6uJonIYWjWb4i3rjayk3
         zBBQ==
X-Gm-Message-State: AOAM532/mIHq7IHPMEzI7PiFGE4/RpoxV1seyhiYMMs9IXUs8Ln2c9+q
        +C7pvAujvehvvyqYOWDWEcfsPHjGiNOQD3Al4pU=
X-Google-Smtp-Source: ABdhPJzSPFrXHMMmil75BIQHjLaH8mzGwSbTHdDepfITOzoF5VTWu8Ub5Q10tr9MPBQuTHDS9MzTvz4IHJudSM80JTw=
X-Received: by 2002:a67:be0b:0:b0:32c:d82f:6723 with SMTP id
 x11-20020a67be0b000000b0032cd82f6723mr4212504vsq.67.1652537581096; Sat, 14
 May 2022 07:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-17-chenhuacai@loongson.cn> <Yn+nAFCA/+Wm+rC/@mail.local>
In-Reply-To: <Yn+nAFCA/+Wm+rC/@mail.local>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 14 May 2022 22:12:37 +0800
Message-ID: <CAAhV-H7_a4hUoDV+FLjf9PXuHjxRa8BokjCFAGFfirgAPfGuqw@mail.gmail.com>
Subject: Re: [PATCH V10 16/22] LoongArch: Add misc common routines
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
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
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Alexandre,

On Sat, May 14, 2022 at 8:56 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hi,
>
> On 14/05/2022 16:03:56+0800, Huacai Chen wrote:
> > diff --git a/arch/loongarch/kernel/rtc.c b/arch/loongarch/kernel/rtc.c
> > new file mode 100644
> > index 000000000000..d7568385219f
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/rtc.c
> > @@ -0,0 +1,36 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <asm/loongson.h>
> > +
> > +#define RTC_TOYREAD0    0x2C
> > +#define RTC_YEAR        0x30
> > +
> > +unsigned long loongson_get_rtc_time(void)
> > +{
> > +     unsigned int year, mon, day, hour, min, sec;
> > +     unsigned int value;
> > +
> > +     value = ls7a_readl(LS7A_RTC_REG_BASE + RTC_TOYREAD0);
> > +     sec = (value >> 4) & 0x3f;
> > +     min = (value >> 10) & 0x3f;
> > +     hour = (value >> 16) & 0x1f;
> > +     day = (value >> 21) & 0x1f;
> > +     mon = (value >> 26) & 0x3f;
> > +     year = ls7a_readl(LS7A_RTC_REG_BASE + RTC_YEAR);
> > +
> > +     year = 1900 + year;
> > +
> > +     return mktime64(year, mon, day, hour, min, sec);
> > +}
> > +
> > +void read_persistent_clock64(struct timespec64 *ts)
> > +{
>
> This should rather be implemented in a proper rtc driver and then have
> userspace set the system time or use hctosys.
I found that some archs don't implement read_persistent_clock64(), so
I can safely remove the whole file if there is available rtc drivers?

Huacai
>
> > +     ts->tv_sec = loongson_get_rtc_time();
> > +     ts->tv_nsec = 0;
> > +}
> > --
> > 2.27.0
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

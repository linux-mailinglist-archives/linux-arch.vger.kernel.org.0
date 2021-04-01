Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDA1351F1D
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 20:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbhDASxi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 14:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240508AbhDASvo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 14:51:44 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66509C061793;
        Thu,  1 Apr 2021 10:50:31 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h7so2733823ilj.8;
        Thu, 01 Apr 2021 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XaU3R90qixaVV7aW+rUvI7mZW0sgqPkaDVLLZSANpk=;
        b=PAOXjaNp3KR9wkaqwzGajUV+bY15zWzlA+x/vHCeUTnxF2zu1Fe2viAmSmIB7UJ3km
         c3MirZ6IcUQH/AU93wLX+XRldUcJznMOZksUvqClnSPh2zMf7QzNRNen5iAhTA2iAvQx
         +uCXc64hqKPVmXXWLUZx7NNiOkaaO6LuB1AHrvI1qB4c2wIZbXLt8BWASpzpQod59IWQ
         UPMMUaMA5OkGaeCztLQukKuWJL2sdH7uijreieUDBAu+O8aStfDW9wLyJFDLaefvLL96
         kEH1/vjzh2KmRxFH52PKsfxCeij4a6x/bbRWimLfVxFmdPlXDlGRdSxbrN9MJY1v4waV
         mPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XaU3R90qixaVV7aW+rUvI7mZW0sgqPkaDVLLZSANpk=;
        b=gPzNhUnFOvuG9NaoEb98icE06z27rBgw+jNI6Qq2o5aTbHM5+BD420OdNVQ2pdVRal
         asauFsGuz5nRZYSv4Op8wCydxezz4ttsHRZdCeNYZ4i7mOQNkNRhIPgPAytI7cEqG+Ug
         RgRY76TGoZLxC+VC5srVyfpJkHQA1FKChfmdK6uw2vxqPrFlK6TodFFGPayVdbgDcGnj
         zdBlEAiiJLsOu5kuBG4LEOqL3elqJvyOcVRV/XZcXWdTjNdna31DnG2MKvtm1FHA4fs5
         Cm33wygJhZJ6Q851knxCwpxsdyDqwpd9SEkKlQjQePbKpTd+HgQUK6szmsH45f7D2FLa
         U7sg==
X-Gm-Message-State: AOAM533a4knUpQdDGqtlPf9adG7nhxhrydx602gnaMENSZXOMrHuJZ3R
        WIn+45a6nPLZJ4iHNb1TXzJ4rIYUmexkiJHpOho=
X-Google-Smtp-Source: ABdhPJypdKxpeEkzgLCokUxyMCMz480lSKKdcgSUnSJMv1uQm0VHIbMAqvXRye1H8rAFcLAtk2dSHPm1P2RfBItEowg=
X-Received: by 2002:a05:6e02:8:: with SMTP id h8mr7415793ilr.164.1617299430937;
 Thu, 01 Apr 2021 10:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615038553.git.syednwaris@gmail.com> <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
 <CAHp75VfJ5bGaPkai_adsBoT6=7nS2K8ze0ka3gzZkQARkM5evA@mail.gmail.com>
 <CACG_h5pb0pA+cTNPGircAM3UrV5BGmqgk45LF_9phU_J4FaRyw@mail.gmail.com>
 <CAHp75VfDZbJjCOEGdHc=-D6W8_7m2=CinXj-itwn6hvoVqdWYQ@mail.gmail.com>
 <YF8evJTkiBYjnDON@shinobu> <CAHp75VektkxSH7S3qTkYd1De613HGrBDvXn36FFex_p1n9BDng@mail.gmail.com>
In-Reply-To: <CAHp75VektkxSH7S3qTkYd1De613HGrBDvXn36FFex_p1n9BDng@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Thu, 1 Apr 2021 23:20:19 +0530
Message-ID: <CACG_h5pox5CCmhy7+itc7cpjCSYtzSXGA85ow14nPrAThyNTDA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and _set_value
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 27, 2021 at 10:05 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Mar 27, 2021 at 2:02 PM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> > On Sat, Mar 27, 2021 at 09:29:26AM +0200, Andy Shevchenko wrote:
> > > On Saturday, March 27, 2021, Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > > On Fri, Mar 26, 2021 at 11:32 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Sat, Mar 6, 2021 at 4:08 PM Syed Nayyar Waris <syednwaris@gmail.com>
> > > > wrote:
> > > > >
> > > > > > +       bitmap_set_value(old, 64, state[0], 32, 0);
> > > > > > +       bitmap_set_value(old, 64, state[1], 32, 32);
> > > > >
> > > > > Isn't it effectively bitnap_from_arr32() ?
> > > > >
> > > > > > +       bitmap_set_value(new, 64, state[0], 32, 0);
> > > > > > +       bitmap_set_value(new, 64, state[1], 32, 32);
> > > > >
> > > > > Ditto.
>
> > > > With bitmap_set_value() we are also specifying the offset (or start)
> > > > position too. so that the remainder of the array remains unaffected. I
> > > > think it would not be feasible to use bitmap_from/to_arr32()  here.
> > >
> > >
> > > You have hard coded start and nbits parameters to 32. How is it not the
> > > same?
> >
> > Would these four lines become something like this:
> >
> >         bitmap_from_arr32(old, state, 64);
> >         ...
> >         bitmap_from_arr32(new, state, 64);
>
> This is my understanding, but I might miss something. I mean driver
> specifics that make my proposal incorrect.
>
> --
> With Best Regards,
> Andy Shevchenko

I initially (incorrectly) thought that all of the bitmap_set_value()
statements have to be replaced. But now I realised, only those
specific bitmap_set_value() calls containing 32 bits width have to
replaced.

I will incorporate the above review comments in my next v4 submission.

Regards
Syed Nayyar Waris

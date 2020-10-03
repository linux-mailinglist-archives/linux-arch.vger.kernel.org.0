Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400342824F5
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 17:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgJCPI2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Oct 2020 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgJCPI2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Oct 2020 11:08:28 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29BCC0613D0;
        Sat,  3 Oct 2020 08:08:27 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q5so3930273ilj.1;
        Sat, 03 Oct 2020 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOUbPAOj/ENg2re+6PqsOMWC7kbWB8MQWVQQDZeWHvI=;
        b=spvRBPSQW3AcFZz47CrtOVZa/uAQ6+ZnEEzhf4ewEMcTvv/P+EUNluBmEjDPD7eEWB
         kkN1ATsN6wAYh+R9vhMgWUvQ0pQRjTPgtuKOdAfpQPCXK1DCcb7dxMlhniekhEu0U5Mi
         zPEHUm5xLXx22Kwc0Pz5NnU4OfPd+gEUxswMKlTQbKjOPr+HsByB1BoIjpIsUXeNQWSD
         FZ0z0ALCytCvxg1mXqgVD7QoNXjXwVLdE8fa/G2MqWLzXOLiOBu0YvAGRRnqN38ti/El
         PiyvDiboDXDMgJNuzHz83p1eGlfRuoANig87hdTsGpvB9RgZ0U9KlucaGhkn/10CAskx
         QiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOUbPAOj/ENg2re+6PqsOMWC7kbWB8MQWVQQDZeWHvI=;
        b=inl0A6lIvESJmasF7fGWM8Lf4el8KgX2JvKDyZJ+g+SA5WUlWu+pA9ldf9ocksG0uV
         RhI6W6PUb3PBBdxcRgpbaCmmQcYKUTEYl3TZzbgCs6Mz92gFMrg9mSRJ1mUU22qfdduY
         0b7BaSkEjoyNeKJd3KrgSWa6jDQLbDgNIxHz9e5zlEczbuZLqyXE3gCgv5XuWcfaKl9A
         1tWTOsdT5axf7jMgggFvXf/ISlWixUUSYH0ER2Dg9zPlWjRbMaQ/5CJy0zPwmElVwz6S
         ekMrck3I2H34v+Zvy2HVSivvOQ72LISUE8vwbktpsbFpzbAloMGR2WyxODGfRmO4x+ui
         yjIw==
X-Gm-Message-State: AOAM531E7j/IRdcl9hjN2+VoTgjokAqhJDaPoN9DT0YTctvwzXNqiM3k
        7GC/85Ygrn/GDepZQ6ZqHHnO2OLzzAT+sdqd7VKm9oKv+aU=
X-Google-Smtp-Source: ABdhPJxp6kSkAHj4Xkkh6XjqPMQ0YbtG4VdS8Nn10ClYorweDaAQLPjHJxrQOAzFvJUzRoSb4cKOoPoQHCmdW4u4mhY=
X-Received: by 2002:a92:790b:: with SMTP id u11mr6147817ilc.13.1601737706985;
 Sat, 03 Oct 2020 08:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601679791.git.syednwaris@gmail.com> <dcd0580812ebae079e6f5035b990b195ccc6b709.1601679791.git.syednwaris@gmail.com>
 <CAHp75VcoGAjrPa7rcORsaDXZLb-n+U3hG0k6O+weMVYweSPVxg@mail.gmail.com>
 <CACG_h5pianK4DRL5YeuSuN0gv6Jvcndc=_wLCL4QgmZyR=bOMw@mail.gmail.com>
 <CAHp75VdC+eH0ScksdAVp==HnDMTMY3vVUZM5NZy6mfVSR0YoLA@mail.gmail.com>
 <20201003125626.GA3732@shinobu> <CAHp75VdfGCnoyOEn9-c0O4cx7t8GRTH+Ux_gYiRvZeOnDyQryg@mail.gmail.com>
In-Reply-To: <CAHp75VdfGCnoyOEn9-c0O4cx7t8GRTH+Ux_gYiRvZeOnDyQryg@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sat, 3 Oct 2020 20:38:14 +0530
Message-ID: <CACG_h5roN0dKGYMcZ3BXNzSMAWdU06mAx8NrpuomaubSRfdm-A@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] bitops: Introduce the for_each_set_clump macro
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 3, 2020 at 6:32 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Oct 3, 2020 at 3:56 PM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> > On Sat, Oct 03, 2020 at 03:45:04PM +0300, Andy Shevchenko wrote:
> > > On Sat, Oct 3, 2020 at 2:37 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > > On Sat, Oct 3, 2020 at 2:14 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Sat, Oct 3, 2020 at 2:51 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> ...
>
> > > > > > +               map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> > > > > > +               map[index] |= value << offset;
> > >
> > > Side note: I would prefer + 0 here and there, but it's up to you.

Andy what do you mean by the above statement, can you please clarify?
Can you please elaborate on the above statement.

Thanks

> > >
> > > > > > +               map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> > > > > > +               map[index + 1] |= (value >> space);
> > >
> > > By the way, what about this in the case of start=0, nbits > 64?
> > > space == 64 -> UB.
> > >
> > > (And btw parentheses are redundant here)
> >
> > I think this is the same situation as before: we should document that
> > nbits must be between 1 and BITS_PER_LONG.
>
> At least documented, yes.
>
> --
> With Best Regards,
> Andy Shevchenko

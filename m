Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2542334B828
	for <lists+linux-arch@lfdr.de>; Sat, 27 Mar 2021 17:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhC0QgR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Mar 2021 12:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhC0Qf4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Mar 2021 12:35:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E0EC0613B2;
        Sat, 27 Mar 2021 09:35:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x26so7034782pfn.0;
        Sat, 27 Mar 2021 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpU0cSThGl8ak0x5kospVQerR+Ul788zCbqnp0/6I+c=;
        b=aAIafX+3F07ro8pDEOUANecTxrCEhvl0vFrE5guVccFbk55Sqb4lRgzPBogBF2G0ND
         hbXPTCit+hfY9lqtm3+wFAnUlrZ6+CiQLEdyJSZgCkHBq26/xhDbztwUurO9AiUgpTb5
         13tgXWyWb5WOrr/bNlKhcO6dAC2Juch2vxvkJDAlzjgfS+6ryj2TOymBTfaPwboRSdK5
         RfJn+xZa/0wGDD5f2/KneytDKQe57xXP+LKVaNWhB58Hmfi6mDCInKcRBEiVXrJbNR8E
         VKAmG3ZvEW444Q3Rydo5QjfrXwL6BXYawnztdSpKC5mUpFbhuOqWhUTkquso8eAVoieM
         cf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpU0cSThGl8ak0x5kospVQerR+Ul788zCbqnp0/6I+c=;
        b=UBVf7KPN67x55gQt3l/axcUyli/3qad9EYZSYzEJP41lreCVq+9Ofrca2ELRjDzOLU
         N/hcK0rGHmUe/71qvAO09p9c+iuqtLP5Xj+fafbGnLSicYBa+QE0L8oDtA78+xsVmtuo
         uDa5NHN8osKte3smiZLC0wKySlccOMCyKKlfdG/NO7yu/lOCVIP4khD2ukWl/eKloTlm
         89y+VxnAI4ARBuaOkgbcwcMLcWfHL64xDXRrlMRiZ1sNFvio3s1oC0ajP68qTXRUMGr6
         7qGZQIQvI0ZcgyCQQXPlx86n+dxcAUcxYiazmRBaxGr2/pqlO9u/Ui0LZRJ5S/NwhSb+
         FsOQ==
X-Gm-Message-State: AOAM532UQmMbIiP2lMHZEduvBquQ1G2wFEQ0hZpbkC6In8BjY/thQxAu
        cMpBFnzaa8Q73FGYs+jTdTi2r/vCn+gTfpgkoWzX7ivL3bUJYQ==
X-Google-Smtp-Source: ABdhPJx7rl3fvAip5z1uvO/cH9QWPwxBzrJg3U25gLEgDHoXbQY552tI/heNJNPcZ+ar5ul3/JFkodmXe68G/b3fwaE=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr17643531pfb.7.1616862956224; Sat, 27
 Mar 2021 09:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615038553.git.syednwaris@gmail.com> <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
 <CAHp75VfJ5bGaPkai_adsBoT6=7nS2K8ze0ka3gzZkQARkM5evA@mail.gmail.com>
 <CACG_h5pb0pA+cTNPGircAM3UrV5BGmqgk45LF_9phU_J4FaRyw@mail.gmail.com>
 <CAHp75VfDZbJjCOEGdHc=-D6W8_7m2=CinXj-itwn6hvoVqdWYQ@mail.gmail.com> <YF8evJTkiBYjnDON@shinobu>
In-Reply-To: <YF8evJTkiBYjnDON@shinobu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 27 Mar 2021 18:35:40 +0200
Message-ID: <CAHp75VektkxSH7S3qTkYd1De613HGrBDvXn36FFex_p1n9BDng@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and _set_value
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
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

On Sat, Mar 27, 2021 at 2:02 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Sat, Mar 27, 2021 at 09:29:26AM +0200, Andy Shevchenko wrote:
> > On Saturday, March 27, 2021, Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > On Fri, Mar 26, 2021 at 11:32 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Sat, Mar 6, 2021 at 4:08 PM Syed Nayyar Waris <syednwaris@gmail.com>
> > > wrote:
> > > >
> > > > > +       bitmap_set_value(old, 64, state[0], 32, 0);
> > > > > +       bitmap_set_value(old, 64, state[1], 32, 32);
> > > >
> > > > Isn't it effectively bitnap_from_arr32() ?
> > > >
> > > > > +       bitmap_set_value(new, 64, state[0], 32, 0);
> > > > > +       bitmap_set_value(new, 64, state[1], 32, 32);
> > > >
> > > > Ditto.

> > > With bitmap_set_value() we are also specifying the offset (or start)
> > > position too. so that the remainder of the array remains unaffected. I
> > > think it would not be feasible to use bitmap_from/to_arr32()  here.
> >
> >
> > You have hard coded start and nbits parameters to 32. How is it not the
> > same?
>
> Would these four lines become something like this:
>
>         bitmap_from_arr32(old, state, 64);
>         ...
>         bitmap_from_arr32(new, state, 64);

This is my understanding, but I might miss something. I mean driver
specifics that make my proposal incorrect.

-- 
With Best Regards,
Andy Shevchenko

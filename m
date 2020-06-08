Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9FA1F1F2B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jun 2020 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgFHSm3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Jun 2020 14:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgFHSm2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2020 14:42:28 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95691C08C5C2;
        Mon,  8 Jun 2020 11:42:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a25so21821867ljp.3;
        Mon, 08 Jun 2020 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9KtGypd9O3mkYSni3haeyAzkPLbqdCH0D7DlGVhpZjw=;
        b=EQi7Q05sApuRKinL0weqgIZ+qtNLmOyyNoTVeNKrqARzk6pjV4hDiK0+YlgsiQYMpz
         rKCcHDJGdNg1byzLxnXS6IBvppM3bFYsiiDqd/UzaZyj1HoYS7bQbJKkDyZpWQ2GEF8p
         coCy/q/gwJlTB5Wnyuj5kBpcAGuskwFgdp1vEFrKWCa06+aBsVnnA3XO5QrTK3GCnSIC
         q/qdRKwtCJMr5wqf11Zt0JOhyV+YNGbNEQCxHzCJDlYpa0NwUzVLWotSe7zK9sY2VJFd
         pcyAIaK08Yvsv/v4MaVFnhnMuC+6SDkZpK5108yo66mA1Wpu493hsL/RWswyTLEjN6di
         lbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9KtGypd9O3mkYSni3haeyAzkPLbqdCH0D7DlGVhpZjw=;
        b=OTV9ElaStklNM1pzyl3SesOSvjQgK3pNd3NESfHIA0tt5Z8IcqSgRyIJYDiL4rRqB/
         d0u0iq4yBx8vfXEwOO9O34uTkiN0IcWulTEwslWGyhpZ64tRDaUu2omHBlw/NEACxtjA
         f8G0lYOEk1uKXYz8wO7J8cHTDfvvW4DGgZduJZn5uqn5nDMy1P2MHHmujFnAfOHwfcKT
         7XXNyZs4TpUzqJRgVEjfjlO2ntB5xTY+SSmfAp5jmdwCjf+q+AUEKoQ7GgmIfIPErRHY
         N0As1Vjjyn8xbl97cLqHAcpU8VyUp2zOmbs48QJHT0fXUsxqvhr5HFsB93u83FRYRYXg
         BCqw==
X-Gm-Message-State: AOAM530/R4bJj5dTYDWaoln9vdaks5vlcp9shz8JJ3cEf2qb65VQtB1O
        zn7cYenXm3JEgvwHwpcULEY=
X-Google-Smtp-Source: ABdhPJwic3xfHer3oWZ0zX8I7mh+bnifoX6KvHs0VAbxX+HeZIeWgS2ec3WZvMRw1viBDesSnAaraQ==
X-Received: by 2002:a05:651c:cc:: with SMTP id 12mr11940769ljr.397.1591641747059;
        Mon, 08 Jun 2020 11:42:27 -0700 (PDT)
Received: from rikard (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id r13sm3883494ljh.66.2020.06.08.11.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 11:42:26 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Mon, 8 Jun 2020 20:42:22 +0200
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, emil.l.velikov@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>, syednwaris@gmail.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 2/2] bits: Add tests of GENMASK
Message-ID: <20200608184222.GA899@rikard>
References: <20200604233003.GA102768@rikard>
 <20200607203411.70913-1-rikard.falkeborn@gmail.com>
 <20200607203411.70913-2-rikard.falkeborn@gmail.com>
 <CAMuHMdVm_ptUipb==jt1aL4RLcRU=OHawV1j4xfB1_z7S-FPxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVm_ptUipb==jt1aL4RLcRU=OHawV1j4xfB1_z7S-FPxQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 08, 2020 at 09:33:05AM +0200, Geert Uytterhoeven wrote:
> Hi Richard,
> 
> Thanks for your patch!
> 
> On Sun, Jun 7, 2020 at 10:35 PM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> > Add tests of GENMASK and GENMASK_ULL.
> >
> > A few test cases that should fail compilation are provided under ifdef.
> 
> It doesn't hurt to mention the name of the #ifdef here.
> 
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> 
> > --- /dev/null
> > +++ b/lib/test_bits.c
> > @@ -0,0 +1,73 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Test cases for functions and macrso in bits.h
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/bits.h>
> > +
> > +
> > +void genmask_test(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_EQ(test, 1ul, GENMASK(0, 0));
> > +       KUNIT_EXPECT_EQ(test, 3ul, GENMASK(1, 0));
> > +       KUNIT_EXPECT_EQ(test, 6ul, GENMASK(2, 1));
> > +       KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, GENMASK(31, 0));
> > +
> > +#ifdef TEST_BITS_COMPILE
> 
> "#ifdef TEST_GENMASK_FAILURES"?

Much better! I'll update that (and add the ifdef to the commit message)
for v3.

Thanks

Rikard
> 
> > +       /* these should fail compilation */
> > +       GENMASK(0, 1);
> > +       GENMASK(0, 10);
> > +       GENMASK(9, 10);
> > +#endif
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

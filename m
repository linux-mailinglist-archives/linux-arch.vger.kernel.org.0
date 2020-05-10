Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8020D1CCD28
	for <lists+linux-arch@lfdr.de>; Sun, 10 May 2020 21:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgEJTFv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 May 2020 15:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgEJTFu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 May 2020 15:05:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4567C061A0C;
        Sun, 10 May 2020 12:05:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d22so3495231pgk.3;
        Sun, 10 May 2020 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TrDysAnyzIqn5Cn1iMOx1jHu5Zp3yUHwKX37t/G/0oo=;
        b=Tusd/kAIJ93DCgBlGio6JGtGTJMloGM3X+oLDhyeqDPqSqCXLICnX9B8HMn/Jd0Tik
         +k7rp+0JfNDOaOh23t8jMPC6KRZz/xaa8oDPLQ+uXPvlcS1bGZ1DLNaxEcN5K35fNAUQ
         K4+XmSRSvOCSjx8VciY3xSCCEOJy8x4ot1c6rf6Kzelxqy31GZ+6vunnB01XxySlLljG
         nKgOxJLV8Qb0HRTMNhZNqOejR93rP3pryODWevJvGCthrkNvR2P1xPBlvkfvmDyxSxTH
         wJlGEMaTgD4KvDzqEGV1cq7HxVl6HOFnLM2W1f9zS4HlohudcR0q29xfWtlTGa7bPjpw
         Je0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrDysAnyzIqn5Cn1iMOx1jHu5Zp3yUHwKX37t/G/0oo=;
        b=nU3K3FfvENJIKEtD5yCrNbaiuNwQbD91+pmL60KA3Kz6h6+pohF9PfK3yrhVifU8LA
         W7AAgVwMgBp/2MMqZE2vq5nMuZ0+6OjwO2bGoAmqXtrMc0PolQwXdlwORb6nvU4bIiMz
         kGp10xYT+YDmZbMtJoxuXQ2aJSFErjHLpoEkesjnyK9ipabcFdM8LKLglOrq22MpVpup
         WA1128OOgT0MVCWgCCVOBzIvo1Ugr4lOAuZwzFfbghSbMO01wBo2rGS4KzvMDjG+C5LW
         mX+yvpOX+g6n1ZpvDNMdLi0497Qxhr+BHq4ABwuAzK9tylffTogQW+4DWsaREJwOd0m5
         hcSw==
X-Gm-Message-State: AGi0PuZncimxjfZ58V9lpjl7wxFboiksifoxXxSDedQErzw2tXLPuw7D
        pJYaZWDaMi18vK1P2cZGgRpakmF1V15WTn3Modw=
X-Google-Smtp-Source: APiQypLeReEsRK6CfvZljwNh3sLkBBj5r2qTM7yV0oIgFRo3EmuOUB97cNaBFdGIXnDDJM4DwzZIgvCMuvjhuSRGYZ8=
X-Received: by 2002:a65:6251:: with SMTP id q17mr11271737pgv.4.1589137550161;
 Sun, 10 May 2020 12:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588460322.git.syednwaris@gmail.com> <20200504114109.GE185537@smile.fi.intel.com>
 <20200504143638.GA4635@shinobu> <CAHp75Vf_vP1qM9x81dErPeaJ4-cK-GOMnmEkxkhPY2gCvtmVbA@mail.gmail.com>
 <20200505145250.GA5979@shinobu> <CACG_h5pcb3uOn+or-6L8bMk3bBNFXWJre9C9pRi3hNgFxGkd_g@mail.gmail.com>
In-Reply-To: <CACG_h5pcb3uOn+or-6L8bMk3bBNFXWJre9C9pRi3hNgFxGkd_g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 May 2020 22:05:38 +0300
Message-ID: <CAHp75VcRztO-DPnUin-2TU9e10k0VViD7=S3ypQ0vQ=ittxNkw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Introduce the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, rrichter@marvell.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 9, 2020 at 7:36 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> On Tue, May 5, 2020 at 8:24 PM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> > On Tue, May 05, 2020 at 04:51:56PM +0300, Andy Shevchenko wrote:
> > > On Mon, May 4, 2020 at 5:41 PM William Breathitt Gray
> > > <vilhelm.gray@gmail.com> wrote:
> > > > On Mon, May 04, 2020 at 02:41:09PM +0300, Andy Shevchenko wrote:
> > > > > On Sun, May 03, 2020 at 04:38:36AM +0530, Syed Nayyar Waris wrote:

...

> > > > > Looking into the last patches where we have examples I still do not see a
> > > > > benefit of variadic clump sizes. power of 2 sizes would make sense (and be
> > > > > optimized accordingly (64-bit, 32-bit).

> > > > There is of course benefit in defining for_each_set_clump with clump
> > > > sizes of powers of 2 (we can optimize for 32 and 64 bit sizes and avoid
> > > > boundary checks that we know will not occur), but at the very least the
> > > > variable size bitmap_set_value and bitmap_get_value provide significant
> > > > benefit for the readability of the gpio-xilinx code:
> > > >
> > > >         bitmap_set_value(old, state[0], 0, width[0]);
> > > >         bitmap_set_value(old, state[1], width[0], width[1]);
> > > >         ...
> > > >         state[0] = bitmap_get_value(new, 0, width[0]);
> > > >         state[1] = bitmap_get_value(new, width[0], width[1]);
> > > >
> > > > These lines are simple and clear to read: we know immediately what they
> > > > do. But if we did not have bitmap_set_value/bitmap_get_value, we'd have
> > > > to use several bitwise operations for each line; the obfuscation of the
> > > > code would be an obvious hinderance here.
> > >
> > > Do I understand correctly that width[0] and width[1] may not be power
> > > of two and it's actually the case?

> > I'm under the impression that width[0] and width[1] are arbitrarily
> > chosen by the user and could be any integer. I have never used this
> > hardware so I'm hoping one of the gpio-xilinx or GPIO subsystem
> > maintainers in this thread will respond with some guidance.
> >
> > If the values of width[0] and width[1] are restricted to powers of 2,
> > then I agree that there is no need for generic bitmap_set_value and
> > bitmap_get_value functions and we can instead use more optimized power
> > of 2 versions.

> Regarding the question that whether width[0] and width[1] can have any
> value or they are restricted to power-of-2.
>
> Referring to the document (This xilinx GPIO IP was mentioned in the
> gpio-xilinx.c file):
> https://www.xilinx.com/support/documentation/ip_documentation/axi_gpio/v2_0/pg144-axi-gpio.pdf
>
> On page 8, we can see that the GPIO widths for the 2 channels can have
> values different from power-of-2.For example: 5, 15 etc.
>
> So, I think we should keep the 'for_each_set_clump',
> 'bitmap_get_value' and 'bitmap_set_value' as completely generic.
>
> I am proceeding further for my next patchset submission keeping above
> findings in mind. If you guys think something else or would like to
> add something, let me know.

Thank you for investigation. So, if Xilinx is okay with the change, I
have no objections.

-- 
With Best Regards,
Andy Shevchenko

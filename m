Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA1E1CC2C8
	for <lists+linux-arch@lfdr.de>; Sat,  9 May 2020 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgEIQg1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 May 2020 12:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727787AbgEIQg1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 May 2020 12:36:27 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11405C061A0C;
        Sat,  9 May 2020 09:36:27 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s10so4976198iog.7;
        Sat, 09 May 2020 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4doamfEac81w7NdGvlnuzzcfip0SyF0byJNJJN5mb4=;
        b=WOlYAndiY3sFA4r+kyJYu3WC5c3IBZUCZH9umuw/d4kq6khVKANcmQAD6PcluHPism
         vwVOUzCo4XaDzJdfvhOyPk3VFuXoJy0pU7JJrzV3MN9fyQko7aq2QhVLzl1cIoLmpZ6+
         xOg4c/pWzYIAzZfeOfE40HTeT8xUBY8mGxh5MhySa8Rd+Q1hAxBxvNf7r00gZtkn2zpX
         kLe92ok+KQ0eL4oUuC1pTmhIqWPzf80E71vE39u974eRsVlLqPDqVvWD3LBnLCcY45uj
         gzlX5FX1+k/aAbOwFqnRMRAD99HW/JPoeiJowZCNBZqaM4z+MKZ/mGn2uNAE1fn6u8vg
         PAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4doamfEac81w7NdGvlnuzzcfip0SyF0byJNJJN5mb4=;
        b=rIOmDQxuAI56YZyI2kOF3OtwUOa42ibujWwOqnVbqPX3/bT8ssPEtRDRG3ebaTbu/G
         YUU12KC6ofYHnQYJN8WBMDuoZLGt0/gfDM7+EI9K+ckXHUuHTa0t8fXwBcXgI9+ileNo
         blP2mpN+qVu3An9g9S21X8I/KUR6fx99VrfNPye7gzT33o7I7Kj9iUqMxrD2M0WbCB/+
         FYfg05I77JxVFQHL9PxnjNyvOmk8MUyXKu5/vGhHv3EDfXofQ/wR0xN72V9yJN7MFWMX
         oDJjEWZ+aATTFcuUQocJG+B/INOYt/IF9BEtgs8pIm8VdEAX9nm3UoKzVsVVBBzVfiez
         yD/A==
X-Gm-Message-State: AGi0PubTa0uV2a2KylE6b8aNNHvvngT+HPoqZBV9q9jkruVzfemah9R2
        tyAHkApgRYAdY8AcbYiMvJRnqfKjKaa+8weW8J55mdoh
X-Google-Smtp-Source: APiQypIwH+UOY7qJJYslhe41JcWrNe0Unvr55D5zZKUUBr9RGQMW5ZaXnpschPwH9qL0gzKBZTPZt8JnUhQyQoXd2+c=
X-Received: by 2002:a02:ce89:: with SMTP id y9mr2156102jaq.64.1589042185786;
 Sat, 09 May 2020 09:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588460322.git.syednwaris@gmail.com> <20200504114109.GE185537@smile.fi.intel.com>
 <20200504143638.GA4635@shinobu> <CAHp75Vf_vP1qM9x81dErPeaJ4-cK-GOMnmEkxkhPY2gCvtmVbA@mail.gmail.com>
 <20200505145250.GA5979@shinobu>
In-Reply-To: <20200505145250.GA5979@shinobu>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sat, 9 May 2020 22:06:14 +0530
Message-ID: <CACG_h5pcb3uOn+or-6L8bMk3bBNFXWJre9C9pRi3hNgFxGkd_g@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Introduce the for_each_set_clump macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Tue, May 5, 2020 at 8:24 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Tue, May 05, 2020 at 04:51:56PM +0300, Andy Shevchenko wrote:
> > On Mon, May 4, 2020 at 5:41 PM William Breathitt Gray
> > <vilhelm.gray@gmail.com> wrote:
> > > On Mon, May 04, 2020 at 02:41:09PM +0300, Andy Shevchenko wrote:
> > > > On Sun, May 03, 2020 at 04:38:36AM +0530, Syed Nayyar Waris wrote:
> >
> > ...
> >
> > > > Looking into the last patches where we have examples I still do not see a
> > > > benefit of variadic clump sizes. power of 2 sizes would make sense (and be
> > > > optimized accordingly (64-bit, 32-bit).
> > > >
> > > > --
> > > > With Best Regards,
> > > > Andy Shevchenko
> > >
> > > There is of course benefit in defining for_each_set_clump with clump
> > > sizes of powers of 2 (we can optimize for 32 and 64 bit sizes and avoid
> > > boundary checks that we know will not occur), but at the very least the
> > > variable size bitmap_set_value and bitmap_get_value provide significant
> > > benefit for the readability of the gpio-xilinx code:
> > >
> > >         bitmap_set_value(old, state[0], 0, width[0]);
> > >         bitmap_set_value(old, state[1], width[0], width[1]);
> > >         ...
> > >         state[0] = bitmap_get_value(new, 0, width[0]);
> > >         state[1] = bitmap_get_value(new, width[0], width[1]);
> > >
> > > These lines are simple and clear to read: we know immediately what they
> > > do. But if we did not have bitmap_set_value/bitmap_get_value, we'd have
> > > to use several bitwise operations for each line; the obfuscation of the
> > > code would be an obvious hinderance here.
> >
> > Do I understand correctly that width[0] and width[1] may not be power
> > of two and it's actually the case?
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
>
> I'm under the impression that width[0] and width[1] are arbitrarily
> chosen by the user and could be any integer. I have never used this
> hardware so I'm hoping one of the gpio-xilinx or GPIO subsystem
> maintainers in this thread will respond with some guidance.
>
> If the values of width[0] and width[1] are restricted to powers of 2,
> then I agree that there is no need for generic bitmap_set_value and
> bitmap_get_value functions and we can instead use more optimized power
> of 2 versions.
>
> William Breathitt Gray


Regarding the question that whether width[0] and width[1] can have any
value or they are restricted to power-of-2.

Referring to the document (This xilinx GPIO IP was mentioned in the
gpio-xilinx.c file):
https://www.xilinx.com/support/documentation/ip_documentation/axi_gpio/v2_0/pg144-axi-gpio.pdf

On page 8, we can see that the GPIO widths for the 2 channels can have
values different from power-of-2.For example: 5, 15 etc.

So, I think we should keep the 'for_each_set_clump',
'bitmap_get_value' and 'bitmap_set_value' as completely generic.

I am proceeding further for my next patchset submission keeping above
findings in mind. If you guys think something else or would like to
add something, let me know.

Regards
Syed Nayyar Waris

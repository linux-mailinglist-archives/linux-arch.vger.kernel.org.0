Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCF91C576E
	for <lists+linux-arch@lfdr.de>; Tue,  5 May 2020 15:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgEENwE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 May 2020 09:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728993AbgEENwD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 May 2020 09:52:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64787C061A0F;
        Tue,  5 May 2020 06:52:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z6so838631plk.10;
        Tue, 05 May 2020 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSUqQDWC8kjEfI7Zwy/W0Ml7p1PvgRlntpeykuMm0bw=;
        b=hl68Rx6+hwqgjCDnRBIJ4ghqd/Mbjw3qnNO117CIrop6ybuvdvRuSN03pEe7LfHEPI
         DEpOBZgu6KgRtAIgWgd9EZ6+ZSZpdmdrcUwE4xCJSRrgUf6ZClZVqGvF71hyrA1fE0CG
         5XBjSIhRA4+6zJ8uXyhuPujWQz6cVK4l21vd5YazoEAGPJUkjCT72SOFXQTriCqkd2pk
         uSYVpm7onCs3V/dcpk87Lc0IyMldYKecnD5gtwshAbJHKmuG7rbftbJtgtq4Hf5Eu4Dp
         pPA8M/GBhnv2uvwEAgQAizkTBjG2gVDkDo7CwZbbHIjISSjFrMXB3MnYmb9f6aJ5H9kM
         v4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSUqQDWC8kjEfI7Zwy/W0Ml7p1PvgRlntpeykuMm0bw=;
        b=YrmUYUHWiqz1uko2DTOZU0kjuiCIF8oMjwoqtqJ1gOBycGoAyV6zAXWtpMX6PE+WRF
         rkX3PzGaZWR0S9q9ei5/R5nNkHgi7d1yGjotALkON57FyRJxH3wGEfoJZD+yE9qCHWya
         266jjWjU4u4h5I5wzjhzapg9ewJEePzj7Oo5X3/Npjbi8TCHl+FahcxZFE0g+sMvEtg3
         XGTtDrxlYkGnXGY4K26LqGMHAJLLt1LIi09gxBdvCOaGGzm3mzaSb3WqMR6K73jqnDvk
         VLwp5ekXCEVv2EYJ0htytVUy2MxwMHWC9DVEgbMSj4BnP8lbESq3WHF/3BWPi8y2vSiK
         ftPQ==
X-Gm-Message-State: AGi0Pua5/mAfQ2kNuhXgXSbKWC2YaqPOT+UXXiFhbjY38K4awGA6sn5q
        Qeys2cTkYPXb4rySw/YJozpeHDHJ/4SP4fwuz8/NzVNn
X-Google-Smtp-Source: APiQypJNEHsSL0GExSztmK2I6nxQUgw+68Y8I+I3LffAVV8E4crlumGaO3BAzZEfzHPrp79Ypgd2ypo3cV1x0ObIE9w=
X-Received: by 2002:a17:90a:fa81:: with SMTP id cu1mr3234534pjb.25.1588686722930;
 Tue, 05 May 2020 06:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588460322.git.syednwaris@gmail.com> <20200504114109.GE185537@smile.fi.intel.com>
 <20200504143638.GA4635@shinobu>
In-Reply-To: <20200504143638.GA4635@shinobu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 May 2020 16:51:56 +0300
Message-ID: <CAHp75Vf_vP1qM9x81dErPeaJ4-cK-GOMnmEkxkhPY2gCvtmVbA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Introduce the for_each_set_clump macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, rrichter@marvell.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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

On Mon, May 4, 2020 at 5:41 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Mon, May 04, 2020 at 02:41:09PM +0300, Andy Shevchenko wrote:
> > On Sun, May 03, 2020 at 04:38:36AM +0530, Syed Nayyar Waris wrote:

...

> > Looking into the last patches where we have examples I still do not see a
> > benefit of variadic clump sizes. power of 2 sizes would make sense (and be
> > optimized accordingly (64-bit, 32-bit).
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
>
> There is of course benefit in defining for_each_set_clump with clump
> sizes of powers of 2 (we can optimize for 32 and 64 bit sizes and avoid
> boundary checks that we know will not occur), but at the very least the
> variable size bitmap_set_value and bitmap_get_value provide significant
> benefit for the readability of the gpio-xilinx code:
>
>         bitmap_set_value(old, state[0], 0, width[0]);
>         bitmap_set_value(old, state[1], width[0], width[1]);
>         ...
>         state[0] = bitmap_get_value(new, 0, width[0]);
>         state[1] = bitmap_get_value(new, width[0], width[1]);
>
> These lines are simple and clear to read: we know immediately what they
> do. But if we did not have bitmap_set_value/bitmap_get_value, we'd have
> to use several bitwise operations for each line; the obfuscation of the
> code would be an obvious hinderance here.

Do I understand correctly that width[0] and width[1] may not be power
of two and it's actually the case?

-- 
With Best Regards,
Andy Shevchenko

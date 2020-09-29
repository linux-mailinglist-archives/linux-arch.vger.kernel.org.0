Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7A27CEC8
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 15:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgI2NOp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 09:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgI2NOo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 09:14:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D68C061755;
        Tue, 29 Sep 2020 06:14:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so4486773pff.6;
        Tue, 29 Sep 2020 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jh0GLZpzBbjRrSh/msJBZ2oenCHRsVM/j1YzWOGaB/w=;
        b=dqnymzjl2wf8hdUH1oGx5ndS5k/Q++Ks+kamR+OvZg4UkRbUvSD9nzBQOMHtG2705R
         1a4SXPzy6yAwm6V+YEUa9Xe+8ssoEGua7KTkDT+rnBI+QrCycDBORKWF1yh8sxFql38b
         Y0HslFnFOxaxeBaDNWSQur0qECYOOwCImjdcAXjvDDiHyDWmCXeP0zJgP44UH3IHJYoU
         clt8gz7N+FYD/U+iaeIXa8dgsd7rqOjrAzqpldqp+EcC5QX71rFoSf+r3F4zUVSojkRb
         1ZIqVa4FjtoYy6VUqfaShqOfmgZI72w9o3VpKH9zcBksbLS0OIrYSqLL31364ozD6JHO
         lY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jh0GLZpzBbjRrSh/msJBZ2oenCHRsVM/j1YzWOGaB/w=;
        b=SyAJCR+eaYrmv+k3Z6FEO0NsPW7R6dCwTnDc12jYx5hCh44FJNXHUXW0WUKhgb44gp
         x8/a2UW1ii85NYlvN7dbv6jCEZqsSVYeAXryy5bBhRYNsps8PUZdTgbkCcmzhofmsISv
         l5gYVVG5nlUfLyjpNDyVNhnc+cMpSjPA9sGTjhC5QJUXMdwoMfpKRK3fJ3cI3dW2aoUt
         AfyMlEx0ORQNgkowk11SGzlTlGqnyfyCgc/wPa0ooPfJbpc95rHFIUVBtEkHDJgF+FF4
         OB7PjZ4zoHdcoQfsxgUokCssVzBz3wTxT0tsdXeCauEdDLK8bnX817Huv1Xs5CpMhMsW
         OuCQ==
X-Gm-Message-State: AOAM533Wtho7oVWJlwObLAzQ/zZp0QTidDkG+yOSBGhtFo8qgDB+LMxt
        IWE4K/8GNk6UCS7mis5Qo35cZptlDozWyBgjwJE=
X-Google-Smtp-Source: ABdhPJyhLNcv1GQUuvKWQRlG0vNVotWRi8tnN9tvFGnxerJxPkMwudpNYSXHgX97533bO6SgRzKi1O77y/FKRaxdY5Y=
X-Received: by 2002:aa7:9201:0:b029:13e:d13d:a10c with SMTP id
 1-20020aa792010000b029013ed13da10cmr3929913pfo.40.1601385284101; Tue, 29 Sep
 2020 06:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593243079.git.syednwaris@gmail.com> <CACRpkdYyCNEUSOtCJMTm7t1z15oK7nH3KcTe5LreJAzZ0KtQuw@mail.gmail.com>
 <20200911225417.GA5286@shinobu> <CACRpkdah+k-EyhF8bNRkvw4bFDiai9dYo3ph9wsumo_v3U-U0g@mail.gmail.com>
 <20200929130743.GB4458@shinobu>
In-Reply-To: <20200929130743.GB4458@shinobu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Sep 2020 16:14:25 +0300
Message-ID: <CAHp75VdtUr1KHD5bng4sHZqsR888gN_TJ-bN8oLsX8GpsM8wYw@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce the for_each_set_clump macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 29, 2020 at 4:09 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Tue, Sep 29, 2020 at 02:45:18PM +0200, Linus Walleij wrote:
> > On Sat, Sep 12, 2020 at 12:54 AM William Breathitt Gray
> > <vilhelm.gray@gmail.com> wrote:
> > > On Thu, Jul 16, 2020 at 02:49:35PM +0200, Linus Walleij wrote:
> > > > On Sat, Jun 27, 2020 at 10:10 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

...

> > > What's the name of the branch with these patches on kernelorg; I'm
> > > having trouble finding it?
> > >
> > > Btw, I'm CCing Andrew as well here because I notice him missing from the
> > > CC list earlier for this patchset.
> >
> > IIRC there were complaints from the zeroday build robot so I
> > dropped the branch and I am still waiting for a fixed up patch
> > series.

> My apologies, I wasn't aware a build error was reported. I'll be happy
> to help address the issue with Syed, but I can't seem to find a copy of
> the message on <https://lkml.org/lkml/2020/6/27/107> or my email logs.
> Do you have a link available to the zeroday build log?


Time to open lore.kernel.org? [1][2]

Linus, are you referencing to [3]? It was fixed in GENMASK()
implementation some time ago.

[1]: https://lore.kernel.org/lkml/cover.1593243079.git.syednwaris@gmail.com/
[2]: https://lore.kernel.org/lkml/cover.1592224128.git.syednwaris@gmail.com/
[3]: https://lore.kernel.org/lkml/202006171559.JSbGJXNw%25lkp@intel.com/

-- 
With Best Regards,
Andy Shevchenko

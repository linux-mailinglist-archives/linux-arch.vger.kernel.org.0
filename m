Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5667427E525
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgI3J3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 05:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgI3J3v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Sep 2020 05:29:51 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEC3C0613D2
        for <linux-arch@vger.kernel.org>; Wed, 30 Sep 2020 02:29:50 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b12so1281137lfp.9
        for <linux-arch@vger.kernel.org>; Wed, 30 Sep 2020 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nt40XuawGIMRcY63tlPUjuXidTwwmmBOZZvJmZ1LX2Q=;
        b=bf4NU12b3N473SZmKQIxU3GCoKztiyNSsQTMp3TbU6A+9NE02UH1rF77dBv0GlTs+j
         jbHMPUiOejGLeb6g8VD+ocqbYBVZb8KTJPKrrw2Fl5Vdasd1ZJbyf/8+FdygYeyer4ax
         nb5B0mEW/r4vofeX+G34TPMcyPGidSeKnYJTc41tqN72X5oV728x1+OnDHcYlrkdk2lg
         elZNTxoVe9pYcELTSe4AKkwz9eFhsVIw4IwY48Tts1vKnTIsrcBjotFynilITBxrpBwx
         6AKzGibQKjiZu95XaKz4seSqN/MAbwADdRuLxWSyoZk7JRrlQdiG1JREz+0aFDEWtRdQ
         alFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nt40XuawGIMRcY63tlPUjuXidTwwmmBOZZvJmZ1LX2Q=;
        b=OIprXewSXrJG/OABbgAo1x2lmkXCA6Nu/p2FeWKWbepGrfiYmAf2HEUVXKKhxW90uZ
         K9fkecVj0nwp7ZD7xnEAp/YmY/2PNyVAeYcjaZaKda8Q8axh2JqS3K1qyI8Kg1R3lav9
         iJaFwUfsfgtA+vLnVlhzh7P3PqV5nLJA3OhLuF4O3AADasfR6wyf4r9+8kuHZScIHd43
         X+GDG1gecMbcrE8mxidGtLv+sbgdAzBdQstqZJpLJwU9KRnWpGGWi2n+O+XkB9PVS7WE
         CxJUdMdkVDm04b0bikanXzDDCPZQxoA5a7ZDy4JDKKjDYCKctP6BfR6WA1I5w23+xjW/
         9eNA==
X-Gm-Message-State: AOAM532ogfMZHjRIahj9ziVWGLSym5MZ1r/BSnUELL/JRiZlUeGhttwd
        7GpJRUYBQCSAauZikieEa3A8UfPiHdmRM7oPVhB7gg==
X-Google-Smtp-Source: ABdhPJydiZObahpdH7vb9u5yuvddV6XbKHWHV7bX5NbThwH/zdH7E/sNA6cVQIaf6JMJfyGvwxbSlE0D/R0ap9XDQhE=
X-Received: by 2002:a19:6419:: with SMTP id y25mr526157lfb.333.1601458189195;
 Wed, 30 Sep 2020 02:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593243079.git.syednwaris@gmail.com> <CACRpkdYyCNEUSOtCJMTm7t1z15oK7nH3KcTe5LreJAzZ0KtQuw@mail.gmail.com>
 <20200911225417.GA5286@shinobu> <CACRpkdah+k-EyhF8bNRkvw4bFDiai9dYo3ph9wsumo_v3U-U0g@mail.gmail.com>
 <20200929130743.GB4458@shinobu> <CAHp75VdtUr1KHD5bng4sHZqsR888gN_TJ-bN8oLsX8GpsM8wYw@mail.gmail.com>
In-Reply-To: <CAHp75VdtUr1KHD5bng4sHZqsR888gN_TJ-bN8oLsX8GpsM8wYw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Sep 2020 11:29:38 +0200
Message-ID: <CACRpkdY-SwOx9tGyvrZy_VZJgHyG4ipo27bPnTe==o8_b_CTfg@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce the for_each_set_clump macro
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
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

On Tue, Sep 29, 2020 at 3:14 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Linus, are you referencing to [3]? It was fixed in GENMASK()
> implementation some time ago.
> [3]: https://lore.kernel.org/lkml/202006171559.JSbGJXNw%25lkp@intel.com/

Yup.

I tried to apply the patches again now to test it but now patch 2
needs to be rebased.

Sorry for all the trouble!

Syed can you rebase the patch set on v5.9-rc1 and resend as v10?

Yours,
Linus Walleij

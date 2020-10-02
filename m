Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CB5281D3F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Oct 2020 22:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgJBU7H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Oct 2020 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBU7H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Oct 2020 16:59:07 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34240C0613D0;
        Fri,  2 Oct 2020 13:59:07 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id o18so2501809ilg.0;
        Fri, 02 Oct 2020 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkEYe1/fNy+Pf7SIAfod53fKG7vqHvWMD5Ql6n+ejRA=;
        b=Ij7PUtkJXXbHQuBf9b8ZOxPvaU1A4n3iWSWa3CFASIc7I4v8wyPm4Dupo2AuLqWE/w
         y7POCNEBvYyDVb9dqHo7ls4kSRElaq2Wyo+FXtnQR3JeOfOI7ZC2dDGllAnD0D7+03/Z
         jQv/4GTdmY9ehua0cjtW9uSpqctb/J7/XRt3Kg8GMt4uL+JeLuUTzYR14atNNX8Vdz+W
         0XIPgJ/lI7OObl5sItq82k81rc10JdjlY/taAZL9qlqYLYNeWhoFhWYVRxgYJ3u8eGJ4
         0CyEDwkz3fsXUDvujQTCe9e6yRSTHWkp66vpM+XILRSp/ZhBVUDOjIpNqJX4MYalH+gn
         qG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkEYe1/fNy+Pf7SIAfod53fKG7vqHvWMD5Ql6n+ejRA=;
        b=Yb3n1KV6Cq5kKpZptZ+G/umGtQ17CWT5D/GFpuQ3sjKltoO4PPl6zNZd82XdHSthba
         aErkV0LIt2MWbV2IHPG+mW3P2BsMO5j+pu3weKFjOfq6PsuDBqt930ldLU4NuCIfbS2T
         35A6FhzBXYM9CpTRqTsBH6pnvlaY9GjLw9AmiK3X82Mg18962hflecMzsnQXU+61L40D
         m3+pgV/HZbe6uB8qPP/j96s5tHuPq/0onvTG3+bDJzfZSZd7GrvMTYaCm42bsklItMIP
         LnRJ7D/YaES2G/en+on6fxqR3h7J1aXxQgo1EAqsobQfb3ezK0h/oGeXnRHALDdePvWY
         9q1A==
X-Gm-Message-State: AOAM531HsbEMPDUo6xHyhqFGtVEDd5TAuRC2YcCmd8rlyOWr7fGCl2st
        6RqWFJoMQLC8Hfe4+s1BRcFyvUj5nYcrdW8ibag=
X-Google-Smtp-Source: ABdhPJxwldEJ93I2YYlI4aV0mGMs3+uEX9u8wY+YfRcK16cMXr4MrtvoeooObH0TWVAJOdlNaj0/+P/5Ow69DdAaFFg=
X-Received: by 2002:a92:ba4d:: with SMTP id o74mr3331734ili.205.1601672346502;
 Fri, 02 Oct 2020 13:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593243079.git.syednwaris@gmail.com> <CACRpkdYyCNEUSOtCJMTm7t1z15oK7nH3KcTe5LreJAzZ0KtQuw@mail.gmail.com>
 <20200911225417.GA5286@shinobu> <CACRpkdah+k-EyhF8bNRkvw4bFDiai9dYo3ph9wsumo_v3U-U0g@mail.gmail.com>
 <20200929130743.GB4458@shinobu> <CAHp75VdtUr1KHD5bng4sHZqsR888gN_TJ-bN8oLsX8GpsM8wYw@mail.gmail.com>
 <CACRpkdY-SwOx9tGyvrZy_VZJgHyG4ipo27bPnTe==o8_b_CTfg@mail.gmail.com>
In-Reply-To: <CACRpkdY-SwOx9tGyvrZy_VZJgHyG4ipo27bPnTe==o8_b_CTfg@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sat, 3 Oct 2020 02:28:55 +0530
Message-ID: <CACG_h5or4anPqMRv5HOpe6CDOAWTY8rBot9G82p=9TABL1qCMQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce the for_each_set_clump macro
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
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

On Wed, Sep 30, 2020 at 2:59 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Sep 29, 2020 at 3:14 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>
> > Linus, are you referencing to [3]? It was fixed in GENMASK()
> > implementation some time ago.
> > [3]: https://lore.kernel.org/lkml/202006171559.JSbGJXNw%25lkp@intel.com/
>
> Yup.
>
> I tried to apply the patches again now to test it but now patch 2
> needs to be rebased.
>
> Sorry for all the trouble!
>
> Syed can you rebase the patch set on v5.9-rc1 and resend as v10?

Sure Linus. I will send it as soon as possible.

Thanks
Syed Nayyar Waris

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D4634AE32
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 19:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCZSC0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 14:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCZSCV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2021 14:02:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C257EC0613AA;
        Fri, 26 Mar 2021 11:02:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ha17so2938644pjb.2;
        Fri, 26 Mar 2021 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTtckNqfgPJECPo3DysCtidoRhR82TGqjwDr082dzvc=;
        b=HomMG5tmEE57XL9UIQbKSe3ws0sltJL4iaupR7VFjVqM1YI91NSi7ki8cYXfIdaACT
         EDp5XeM96/4RSzm/womxj3+9BulgMihM4RzbsjzXc81sUgks1Ktb8MnmcBRrwY1sNVwd
         NUq/GCJN6brC1caudBGuNt6+WiT2mP1IhHWm75tORLvvX3cy1QjU2AGsrXkLPd4Z/IcG
         Gv9E6j0kdhneKcVJuxw2tpsTaUenMyhyqmBUatew1rqQtlaVvB5KFTvm87k1qfg78Faj
         hVRftML1t3fFQ0hNza1R3Q7ytWTx+4aSK3LjYFyt5iQtOoex28P6YKf6ACu15JKfaqtg
         XeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTtckNqfgPJECPo3DysCtidoRhR82TGqjwDr082dzvc=;
        b=tQqklmT4/m8WqcYftI9ZUQ3SpFLKC3UIIjlX8JAsNX6PkiydsznuXO2xrfgd6jMJZP
         r99R0WYPwemSyfsmhFCQS+tGbOTrXx6gz1cCBWITZmiMQMi5JOzZrPafqLvd2e7xGFVx
         URDUEhon/ROOgmGIp4y0sbGajE1s+JUbjZijYLm/J6LSFBEv1HHD8XFPuPPxnTcX1tL2
         4+ClLnFBGjTcwwQnrVJjVdjduD76nOHMm0n7W8xFlBedGpTUm9nexoJ0msmxvW9DqvBM
         Qa1JohZdNLvTp4sWF/gt0LAF9FzBh5j4qBiwbLjXLl3FmqTmXO3yg6i1mh/qBEBMllVL
         PYnw==
X-Gm-Message-State: AOAM5303uuvyPP1Y5XiDgm/JheMXGQ5cYIAVIRybkTjp5gMP/hx1aX0Q
        1DDV6RLA3GBYfzakqHp9jJC8hzt0EDNGIQ1afWc=
X-Google-Smtp-Source: ABdhPJzlqlgSsQUclAQDsiUesqjn/B6oZXOCRD46IejEbRTKqwacQen8AxHw4iQQ6ma+vJLqJTvB288AfGYgWyqANk8=
X-Received: by 2002:a17:90a:b311:: with SMTP id d17mr15149555pjr.228.1616781740355;
 Fri, 26 Mar 2021 11:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615038553.git.syednwaris@gmail.com> <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
In-Reply-To: <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Mar 2021 20:02:04 +0200
Message-ID: <CAHp75VfJ5bGaPkai_adsBoT6=7nS2K8ze0ka3gzZkQARkM5evA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and _set_value
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
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

On Sat, Mar 6, 2021 at 4:08 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

> +       bitmap_set_value(old, 64, state[0], 32, 0);
> +       bitmap_set_value(old, 64, state[1], 32, 32);

Isn't it effectively bitnap_from_arr32() ?

> +       bitmap_set_value(new, 64, state[0], 32, 0);
> +       bitmap_set_value(new, 64, state[1], 32, 32);

Ditto.

-- 
With Best Regards,
Andy Shevchenko

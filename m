Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B2732FAE8
	for <lists+linux-arch@lfdr.de>; Sat,  6 Mar 2021 14:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhCFNjc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Mar 2021 08:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhCFNjN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Mar 2021 08:39:13 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2D6C06174A;
        Sat,  6 Mar 2021 05:39:13 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id z9so4684464iln.1;
        Sat, 06 Mar 2021 05:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUtXX8/HZ0V6MQRHKlsjyuvUd1b9QHwqr/3loxbIPr0=;
        b=LVnsIhWWvq/e9UQMz17fmPOgkualzCNApWudHFHQxA8iGpdpheK2LgtfHnrJqLhM8F
         haBfBjTg3EJLyf4pLX4v63BdLQMKu0qF+P+ZMVlD6gI8U1FNeJB4Qu/FWBbiOGaJqfKU
         Pdnhj9V9ruM0XuT9fdJq65KITijELkSNQo9a8BNRrN5+P8S0/X4tDAoUYxUqfNC3kErW
         kDY9HgUkG79aY2obKhYb4O8Idg9Y6vHbNRGy99Aek78tHaURS3wYya6fsZPEEPjfbf/J
         8vXvgdAS8SQ9HycGp9MB9kyQvoiHThXIfAFHmjQZRMZmPIPMt2iBmQ5qFin/1fIjgFRy
         bAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUtXX8/HZ0V6MQRHKlsjyuvUd1b9QHwqr/3loxbIPr0=;
        b=DZ7f5IjUmseXljTQnfUrtCk7ypjd7IxhKERDehGqvS3AebOly0GNUMrE5D0fd0azFJ
         7BXAmzUPuwCK7bcDMIxoek7TiwK+ZCpRv+fZsvqGx9L+7Vg2W2DZkLdpTNNKM1XsnPZm
         Wx4v2i5JqVbXVos31nTnXJmHOaFZh1XEsqI1eqfYLK1cPBfFxsE6V+GTDP2DdEoelpcS
         ff3OzCBNwXHH7oeuqthyg+7i1W4bnONGs/9GfFLhfISz4OlzJ8Egspfjuk3pVb7AxQys
         pz1c1211/sbrr4tk4yYPBWLvWAn12n/2vmVfYKFd4TV4TFSrhIHcCfEYgQyUN3OWsO0Z
         ZULg==
X-Gm-Message-State: AOAM532WJx2+UwGpY//1RxTRm5JjJd2lrwyfpvtQbTiBfHiklqBwdWpA
        etL2EUM2MyBSjLIJu5UzHqUlrcEO74SW2XP5mGU=
X-Google-Smtp-Source: ABdhPJxHu2RjGeqsCKdYOEuGeOlX1kBsXprC1jCl5fML6RgYaPkTtZPueNlHOnznhZQMgvdfftrJupojm09iAk6wNWE=
X-Received: by 2002:a05:6e02:20e8:: with SMTP id q8mr12395869ilv.205.1615037952694;
 Sat, 06 Mar 2021 05:39:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613134924.git.syednwaris@gmail.com> <CAMpxmJXWk8YJR6-DHMj3+Dk4-TdE-FuFtxK_MvbsoLVqZA9rLg@mail.gmail.com>
In-Reply-To: <CAMpxmJXWk8YJR6-DHMj3+Dk4-TdE-FuFtxK_MvbsoLVqZA9rLg@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sat, 6 Mar 2021 19:09:01 +0530
Message-ID: <CACG_h5rjCYxn8F1xipX2tDB193B7Sj-86aGk07pmAtq2ot31Wg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Introduce the for_each_set_clump macro
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 3, 2021 at 8:13 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> On Fri, Feb 12, 2021 at 2:19 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> >
> > Hello Bartosz,
> >
> > Since this patchset primarily affects GPIO drivers, would you like
> > to pick it up through your GPIO tree?
> >
>
> Sure, as soon as you figure out what's wrong with the xilinx patch.
> Could you also follow William's suggestion and rename the functions?
>
> Bart

I have incorporated William's suggestions and have also solved the
build error coming in the xilinx patch.

I am sharing the v3 patchset. Thanks !

Regards


Syed Nayyar Waris

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC955285AA0
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 10:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgJGIjC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 04:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgJGIjC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 04:39:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B4FC0613D2
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 01:39:01 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c21so1103227ljn.13
        for <linux-arch@vger.kernel.org>; Wed, 07 Oct 2020 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/CTq+Ii8YYGlsTBxUkE2J0PCQyVRe5tUNmSX2DD4CQ=;
        b=oabYzbNjgTaVHV+r00t+tDC3+0dTVNdSOlaClGlLs21doOxTmPumwNt3J/PkkGf08q
         AuTGo3ooXnG8RuZTGgQpKB9FdetN3mL1Hlip1qsF2GcSA+HVQcA59+6ijyu6vBbcyv75
         LLm1YOI2EQWx76WQnPl1FiJzLTj3vsOZviWUxDWncuaZNgc7QSLT3eJ54Aa1XYamj88V
         kRZ+L37Qg/FL6BKZVr0mlNd84XvttjbjA9uD0FYsK3qswfe5rLYw031s5NPeFLo5GeDO
         JuwiwUkRVnUCvtqxvY9msYtYN/q5jUr7/1Upj9uA0u1OAid16UB1ZvLy5NYZHkQfsFxG
         /H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/CTq+Ii8YYGlsTBxUkE2J0PCQyVRe5tUNmSX2DD4CQ=;
        b=Hd2HDMd0QBck9fRLmJVcm5P+XZlVZYWxpqvIWdsRZDYyp11WrwPwXg3jb/YmB0HcOO
         pTcbWrjPdhmu6WLT8+0cFzHIyiz8OFR1oQ1ED8p7s3YtwtaQ94SjCLVFjp23BYh16vsW
         Hj4rdBEzVIJ8stoLuvvxk1W/+lgQgKSkB8hTfq+xboK/KmwPsX7YRm45JuMoDuytG6wl
         UMXF8p8hsYoKkh8F/560SDtguLUzjen/CdKj/2W37BuvbFvb/BcqNRd0Dp8yzpteTYPc
         ZIGqYqfx2wGUcPMKzr5y2amRWATCj+AkWqKTYJb++ych7ab4ob8PNZkJ2kZ6sFcciRNF
         SGng==
X-Gm-Message-State: AOAM531iQRbRUjQOgnhZ5Bl+yj7HUEpEtxlVJNJcfUic6D8T3BQeJxnk
        5/BkLcGEMAxtfM6wEySztgmRYDrXQ8fFdOgbOUnfFw==
X-Google-Smtp-Source: ABdhPJwvN/74UnKNYnZMEj9q7ob1QqvcR1emufgQbxmGvJ46Tg35bsCOcA3ioK4zL1xqdnw0xgR10qrV/kaLqGO/M3E=
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr717572lji.338.1602059939987;
 Wed, 07 Oct 2020 01:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601974764.git.syednwaris@gmail.com>
In-Reply-To: <cover.1601974764.git.syednwaris@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Oct 2020 10:38:49 +0200
Message-ID: <CACRpkdZcfR8Vyavpi4xM1zJab6SgapGBYqK9GR2mp-xh=LuVsw@mail.gmail.com>
Subject: Re: [PATCH v11 0/4] Introduce the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "(Exiting) Amit Kucheria" <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 6, 2020 at 11:20 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

> Since this patchset primarily affects GPIO drivers, would you like
> to pick it up through your GPIO tree?

Definitely will, once we are finished!

I see Andy still has comments and we need more iterations.
That is fine, because we are not in any hurry. Just keep posting
it!

Let's merge this for v5.11 when we are finished with it.

Yours,
Linus Walleij

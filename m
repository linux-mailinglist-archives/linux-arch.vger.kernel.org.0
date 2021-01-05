Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCC32EAD48
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jan 2021 15:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbhAEOUG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jan 2021 09:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbhAEOUF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jan 2021 09:20:05 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346F7C061793
        for <linux-arch@vger.kernel.org>; Tue,  5 Jan 2021 06:19:25 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g24so31251817edw.9
        for <linux-arch@vger.kernel.org>; Tue, 05 Jan 2021 06:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/9ZfcA2tM6SOnOAgqAyi8khL28Ou4AoCcOsnTQ0YF4=;
        b=vhALD3rc06dWqruq6fITSXawb6N3JgrPn0LBfVwyZbbwJm5bBWyMOCOlUMvbv2VViR
         prUteizV9nRdwPsbqApNu4/pBGJE8vvwY8JQVMDlr/GWZMtJXHOZQ9HeKDAE0O2x8XTD
         /elYM+BXpm3o4x/99VIMUPGurHP7P3m90NGIVXDkw5smPnRf3+VjYkg0fPpMMrcX9BQ0
         POXaCioLFFiORsGmqDBShuO358XnDCqYFtnEcxqszHu/z2YhKVKnugoDjTbmh7aUXQEm
         EWdkyWosd6Wp6J6wwC/1wlVMSlHAg6ULQwxX4RRySD9oShYJ+JB4cuKBkyKIt76Q33x1
         9+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/9ZfcA2tM6SOnOAgqAyi8khL28Ou4AoCcOsnTQ0YF4=;
        b=sV5vC7q7M9hwnFVWFQQyV89Nilke3DeOdtt28Aj35PHzi42xJvhqsXsMVIa9twIcqB
         4xYSFWSBA+6lwaxE25zPMjUVE2+S6z0W5hOWOrjr5l3uvFmJunFw03U2BwGfYFg2+ZH3
         2pvzSH+20RrZbu0VsV9ox+NyiLTamQL9twypjeUtMC64GSFPnLr1M5IO1urrrRmmigMI
         ncnsIvwQTG1feBEp21OaJd2+1cbqoFhHM73mu7Zbbyo8+tMF0nepNAiv4B8q0FyQZmEQ
         EeU/F/+otkQ6DCtGSNzDCBYZwhT+4mKgNOkinUM3Q+FwKnj46WEGZ2Sb0DmMnbyB2gNP
         W+Ag==
X-Gm-Message-State: AOAM532mG/v6WLA7qUVPSBQ8FCtYX1kx6cS+GB4D/Q4bQXxBzUO8bM9H
        Nu1tAkNsBakVij4a6LLuWo0Lpjw+WBZcadzw1UuCKg==
X-Google-Smtp-Source: ABdhPJxIVgZDRUr17uvcAnR7t5T6eFIgYR7KHHCcIaA2rzCzP103uhOV4yPjCluFvme/MqfKZGXVVTWgEWl+bjNiUj8=
X-Received: by 2002:a05:6402:307c:: with SMTP id bs28mr76783235edb.186.1609856363835;
 Tue, 05 Jan 2021 06:19:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608963094.git.syednwaris@gmail.com> <CACRpkdYZwMy5faNhUyiNnvdnMOf4ac7XWqjnf3f4jCJeE=p2Lw@mail.gmail.com>
In-Reply-To: <CACRpkdYZwMy5faNhUyiNnvdnMOf4ac7XWqjnf3f4jCJeE=p2Lw@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 5 Jan 2021 15:19:13 +0100
Message-ID: <CAMpxmJW46Oh2h7RrBNo5vACfYnWy63rZOO=Va=ppUDeaj5GpBg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Introduce the for_each_set_clump macro
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Sun, Dec 27, 2020 at 10:27 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sat, Dec 26, 2020 at 7:41 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> > Since this patchset primarily affects GPIO drivers, would you like
> > to pick it up through your GPIO tree?
>
> Actually Bartosz is handling the GPIO patches for v5.12.
> I tried to merge the patch series before but failed for
> various reasons.
>
> Yours,
> Linus Walleij

My info on this is a bit outdated - didn't Linus Torvalds reject these
patches from Andrew Morton's PR? Or am I confusing this series with
something else?

Bart

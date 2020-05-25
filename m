Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACDD1E0AB9
	for <lists+linux-arch@lfdr.de>; Mon, 25 May 2020 11:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389581AbgEYJgr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 May 2020 05:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389421AbgEYJgr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 May 2020 05:36:47 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0567C08C5C1
        for <linux-arch@vger.kernel.org>; Mon, 25 May 2020 02:36:46 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y1so2698388qtv.12
        for <linux-arch@vger.kernel.org>; Mon, 25 May 2020 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RrCJYv2CMkjmXgxh4luY1jGTleOro3sZ8PAwMM7JZE8=;
        b=fuRxqLaU5g8a+KV52JfO8iIc6Dpzv7xH8zEcUSQ/EPvQBP7xuZujlB1Zqe487JQ3Kq
         07LoVBHsy1UXVK+h1466jj5fLf4k0US9SOPw/xkahZeYDz6NXGm5hSOhNSrUBtmqhLWK
         KpGTM4RgelTirb7PDz/hSax3IAD2wQczpkOEfKXlM0XO/X+ySXMhXr8sWjHil9VXwp4a
         gjc6rD/Jhv2tYnFrfXg8taOWar/FQPrbAQeQRe+RXkie2tW8wVIJTOK74bsrPbGDoPrG
         lezjk7vKK6+6lpnEOFAUY+wGVeHzj2KdWfnZ/xg9pSOhTX2lpNrlKoV/wVcAJES3+lOl
         9t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RrCJYv2CMkjmXgxh4luY1jGTleOro3sZ8PAwMM7JZE8=;
        b=NszGoH8dqs77vT7mab3tzmeKnqZAYhwWFsVh1M3gEOyZYPCyqLpBiXjpbsPkILs3r4
         FUXZXnHz3Q4BX1QQY+tg3umJ70JcMJBNPJpK4OtcDYH5IiBUU+I5RtIex4arSI71JCRi
         i2/R6VWr37JrW16D3NGGUfSbxUGrg6SSTGXw5LkexmDyGrUARF6u7WjSZbOOdH5+m3mh
         Al1jrXG8HJ3AX5rpE+thXpYXh/gUJ0H/jUb8mK2t41bEWKscWL1spoi+9VO4ke2KOdSA
         rZ9tw8Q4s8MB2s4yghPgwH1GfmJ5iAzlII+m+ixYndVjmXjzQWfk749nuntbB1FRJ82v
         gV8Q==
X-Gm-Message-State: AOAM531zUVDhToMuUv9j6oiY7e2XoJugTKoLb+7cQNVtmho7oI7rT9t+
        D0Qm3OmLCiJWSISjoBwjvBS2bmHwts/OaS/8pabFhg==
X-Google-Smtp-Source: ABdhPJxH6RRcuaHYqO3WxxeIfwE81GyLqMO/ChAPMvFcbjmN7sgsVd4B4nKXJegt6FTlMqeYNykQPLynPcScd/lVDDo=
X-Received: by 2002:aed:257c:: with SMTP id w57mr26966940qtc.208.1590399406112;
 Mon, 25 May 2020 02:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590017578.git.syednwaris@gmail.com>
In-Reply-To: <cover.1590017578.git.syednwaris@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 25 May 2020 11:36:35 +0200
Message-ID: <CAMpxmJUrC270rgWcADYruqA_qVeh9-N8mCVPWgJkL-8kU2bO1A@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Introduce the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, rrichter@marvell.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-arch@vger.kernel.org,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

niedz., 24 maj 2020 o 07:00 Syed Nayyar Waris <syednwaris@gmail.com> napisa=
=C5=82(a):
>
> Hello Linus,
>
> Since this patchset primarily affects GPIO drivers, would you like
> to pick it up through your GPIO tree?
>
> This patchset introduces a new generic version of for_each_set_clump.
> The previous version of for_each_set_clump8 used a fixed size 8-bit
> clump, but the new generic version can work with clump of any size but
> less than or equal to BITS_PER_LONG. The patchset utilizes the new macro
> in several GPIO drivers.
>
> The earlier 8-bit for_each_set_clump8 facilitated a
> for-loop syntax that iterates over a memory region entire groups of set
> bits at a time.
>

The GPIO part looks good to me. Linus: how do we go about merging it
given the bitops dependency?

Bart

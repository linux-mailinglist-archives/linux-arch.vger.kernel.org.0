Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AE72222D2
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgGPMtt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 08:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgGPMts (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 08:49:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178C9C08C5C0
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 05:49:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r19so6924684ljn.12
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 05:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMUqbM/2tAa8/paafO1/gccjmbEp76TZl0DYAO5Htac=;
        b=vuSLav+Cii51LYAbUmO1o2Rs7yss7EnlSKUR20VVaxbbxAYlCtWHJRMDU2Py8c8JTY
         WKhP3yKme72urB8ucBIKLAPShsPH9qJuaUcriEuBK9Wjv8FMrcnFMZbgbhNpHDLpfeb1
         2ZUxDC9TUvSLcWYF1QnnLlRGGq+l5vEZ5VQHiE2Ik+JiWFkWFqZ86Wsve2eOzvhGL+9K
         ihffOk/HZOePmw9cpO/AebqqXNtNfd7wNPftBpKcRDP4/lSsTY8DAa+BNuR8dIOnpM5y
         thFQEosZBhaeERRBEgpmtYGFLXBddwyP7XPHXPSRBypnXeSA/gggCvyS+NkEQJv0Cvb7
         IUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMUqbM/2tAa8/paafO1/gccjmbEp76TZl0DYAO5Htac=;
        b=JerEfFvOp3x2Cuf60FnhCWLoKIXNHwITFJHZBcixBWiZyZOG3CTY580LamNGcv1wlD
         TQ9sAtn6mr5wpGDgNZStGWm2xE802DfAsAGBN2BWCssd7099Jd1afeSLTD7niPghoQBt
         lfDVmRQUAF2AuNFy6YK4kM0Z9CUK1ms0S0w/8UjrCjcTV9s3UjSiYBP/CQjTs3PNFbgS
         wOcek9hmPtXn1+SVfivsoN0j+HCKKpQ3EjTRoaWO+qIdYmeQIJsbOzysOd8qEofhA+Ma
         7tpSO3jdjQkwYe6iE3h0K5EHBAwXLN/WMq8rHoNjyR92USahN8mCcNUNrRLU70pdDLIt
         lZHw==
X-Gm-Message-State: AOAM53346ocnz+btrMj/jxJlseUHpdvHrK9LN9pxD55RwtvlM1Q4wTLo
        relJCy12/+4nuzFIRw2rk6uelyhuguDwIzQoUQ65wA==
X-Google-Smtp-Source: ABdhPJzZjvVBo25Dqxum0154FLbEBUp91nFV11Hp0xSDYrsQ5aSM1HddHJViEwuAP/BPFZwNurh2InaBi7wl7mxu/zE=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr1887718ljc.104.1594903786614;
 Thu, 16 Jul 2020 05:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593243079.git.syednwaris@gmail.com>
In-Reply-To: <cover.1593243079.git.syednwaris@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 14:49:35 +0200
Message-ID: <CACRpkdYyCNEUSOtCJMTm7t1z15oK7nH3KcTe5LreJAzZ0KtQuw@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-arch@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Syed,

sorry for taking so long. I was on vacation and a bit snowed
under by work.

On Sat, Jun 27, 2020 at 10:10 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

> Since this patchset primarily affects GPIO drivers, would you like
> to pick it up through your GPIO tree?

I have applied the patches to an immutable branch and pushed
to kernelorg for testing (autobuilders will play with it I hope).

If all works fine I will merge this into my devel branch for v5.9.

It would be desirable if Andrew gave his explicit ACK on it too.

Yours,
Linus Walleij

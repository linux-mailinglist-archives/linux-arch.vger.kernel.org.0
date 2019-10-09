Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B41DD0B13
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfJIJ0O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 05:26:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36506 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbfJIJ0N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 05:26:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id x80so1107961lff.3
        for <linux-arch@vger.kernel.org>; Wed, 09 Oct 2019 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SD+HI02CKBBsUnBjBS8AONRJ3UqoWuFlv1/fGBB0L+4=;
        b=Yp/ezDTokXabk02kHZS4Q9Zcrip4udpQ7qThrEB8fA+oF5/YBaD2Q+THIO35uJ3kfM
         ijAdu971Sc0u1iXVcq8FmBzJx92WFKIL13rYfNLHAFEcAcABM/XNEWuxdcFUR630+oKt
         EhOBtNE8brRBt6vUfGQkuPeYH0wO5CD9zsgK8XTxtLlluYKde8xrN7DJnQGKvtMGqrQb
         301v9yPx51H2ueQoUMiDBqmPbWS6qbm39fIrpFjEigHHHzEF4FAtjiFlUyKtyHYy4pFZ
         eyTC9foJ37+QThE5FPa4048amnHh8m0WuErFx7J6r28IzNf5kcGpC7qLDNVSqenrhhXu
         UeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SD+HI02CKBBsUnBjBS8AONRJ3UqoWuFlv1/fGBB0L+4=;
        b=W5UwqASZG/Bnpj9Pj9HWK6UTo1GZkFRkJoh1X5h/zXtu59wvBGY852V6L/xr0IrKVA
         gVJk0qRYK+lFMOtVVKEUy4TJYKgSM+FAipWyJnhK3cbsIuwpfQKUxW9B+b4Um9Emt/BO
         gPyiyyWsKoVFWE1vpr910prqwNi9MPDXlwUusZGhggfOkbft42zG7CQ0myJOwsENnVJg
         sh0JWZeZVM7LwJP1/VEDcvKdGnW2Ulk+k3umbaE0Tr894niCLr3SdSIufXnKqFxWmdM8
         lFlT/Z4oE/2iw8lyZg2i4ziPyTYFKwp0Ut9f3IPqKk2CmRG5Ad0TSZcOt2xaZJGu7K1a
         2bAQ==
X-Gm-Message-State: APjAAAV0tThry/L61Z4qI4Y4+csWh27gDjw8RfputOz/FzW+DyxHtTi1
        CA0hCsDV6XAMkgpnfqCFnoXEVwA6M9ZgKHqlJ3PWKg==
X-Google-Smtp-Source: APXvYqzFG7lDdH9uA0MTciR+6xdQMm6jmgxkQ3KIBmF6lJi9ASjDpky3Ev/tMd6UZRmclpoRgOMzubjoi2Xc5yZYX5w=
X-Received: by 2002:a19:c505:: with SMTP id w5mr1439629lfe.115.1570613170790;
 Wed, 09 Oct 2019 02:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570299719.git.vilhelm.gray@gmail.com> <be63fa49f036b9168f223152648307a63056f4ee.1570299719.git.vilhelm.gray@gmail.com>
In-Reply-To: <be63fa49f036b9168f223152648307a63056f4ee.1570299719.git.vilhelm.gray@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Oct 2019 11:25:59 +0200
Message-ID: <CACRpkdbEszHr3zzVBTinVFQXU+sjOu9YbWC-554+7PYgupYJBA@mail.gmail.com>
Subject: Re: [PATCH v15 01/14] bitops: Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Phil Reid <preid@electromag.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        morten.tiljeset@prevas.dk,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 5, 2019 at 8:37 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

As usual I am happy to merge all this but I would need
Andrew Morton's ACK, as I don't feel like a maintainer for
the bitops.

Yours,
Linus Walleij

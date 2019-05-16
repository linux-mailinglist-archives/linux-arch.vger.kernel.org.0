Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCA420657
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 13:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfEPLul (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 07:50:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42099 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfEPLuk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 07:50:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id 188so2796600ljf.9
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfZWKHa7k32vSF2Rgion0TnHTAjuA1aCE2qsRonqXP0=;
        b=axwfrku8av26C74Qcnj8NMFl8LQW3ytVsyxJwHyHrABKFSul4eTIQRAgniBSpRNR2T
         SUCKllbRVUhjH9a5M8vQ2ZctPU2aRCPW2zzHfrExJfmGQGGJKj+UZ8gMQKIIKMCg8q+W
         d71EwYTR3Nq/rACyFL4CAxYsp4QgSeBRv2U7Q+fNBUsAFO7pdw4soy6W9pOYAyCeXSbD
         CqdAcuzevt6wp/8joMtEkxOTMm36jy27fYgJD0kUVC1x24NqeVW7JvAfFlnUf7AVqtb0
         wSTH5rhMPlygfwvgCPaK4TGfEgwd4+eSNjsCqRVenL0HNST+g99Optp097VsBxKhX9Dm
         4j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfZWKHa7k32vSF2Rgion0TnHTAjuA1aCE2qsRonqXP0=;
        b=gVoovvoz5HylZmfCxKeXrZqdtAzN/ua/QTTAOm2VkJlC4R99QHystAD7Iot9Onw5Sg
         Cayx7F1LMOS5TtekpmRhCCkgB0R7hjbAW8MTT7rRKb/frum7Cev1mfbgyfpwBva1Vv40
         g3ZlWIJaLpGde0yVX7717qNyiQbUV5GXBdOAeyBiHPlQZbMATfJkFmegoCik6JNLt8is
         7G0ikPcmZv+T2FxEgh6tupOOAWTMGrvGPEWCiPxRq2SX/GkywMvBdTPsu9JLs4QhsJ7h
         0Gsai4TsQeKJUR6Pz4nWbmMV7tqbqNOoep9pQ46gEXzXiFKF/fqh9qJODINMjIQ228TI
         ScSg==
X-Gm-Message-State: APjAAAUJYv4Q472C6vYcFkSFdbwWqNF239iWtMhBn6zkJyd1AKudEGHb
        FIYEFJxiaAgeMzRrwdJ9ADK8TwQEsMnDEkiZ5ogCqA==
X-Google-Smtp-Source: APXvYqwaxRjeq7pjR9npAXmwgyhZKdqhC73PwgIVTdnHjqNpDaNtDJResi7MGSU8C3U2sKn8oJY/87TKdcHLFfT0UHI=
X-Received: by 2002:a2e:60a:: with SMTP id 10mr3127929ljg.126.1558007438447;
 Thu, 16 May 2019 04:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553828158.git.vilhelm.gray@gmail.com> <1cc8b30bb3954ca2a0961ffb0a2eed8a005ed670.1553828158.git.vilhelm.gray@gmail.com>
In-Reply-To: <1cc8b30bb3954ca2a0961ffb0a2eed8a005ed670.1553828158.git.vilhelm.gray@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 May 2019 13:50:26 +0200
Message-ID: <CACRpkdbCt1PAJ1rBvKvZ2ydLgJmKXuLN4mRtSU8CaW=U7EcFbQ@mail.gmail.com>
Subject: Re: [PATCH v14 01/11] bitops: Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Phil Reid <preid@electromag.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 29, 2019 at 4:03 AM William Breathitt Gray
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
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
